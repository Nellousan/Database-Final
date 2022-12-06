use actix_web::{web::Bytes, App, HttpRequest, HttpResponse, HttpServer};
use sqlx::{
    postgres::{PgPoolOptions, PgRow},
    Column, Pool, Postgres, Row, ValueRef,
};

async fn run_query(query: &str) -> String {
    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect("postgres://postgres:postgres@db:5432")
        .await;

    let a: Pool<Postgres>;
    match pool {
        Ok(p) => {
            a = p;
        }
        Err(err) => {
            panic!("{}", err);
        }
    }

    let res = sqlx::query(query).fetch_all(&a).await.unwrap();

    let mut body = "".to_owned();

    for r in res {
        body.push_str(&row_to_string(r));
        body.push_str("\n");
    }

    body
}

fn row_to_string(row: PgRow) -> String {
    let mut res = "".to_owned();
    for col in row.columns() {
        res.push_str(col.name());
        res.push_str(": ");
        let value = row.try_get_raw(col.ordinal()).unwrap();
        let value = match value.is_null() {
            false => match value.as_bytes() {
                Ok(bytes) => match bytes.len() == 4 {
                    true => u32::from_be_bytes(bytes[0..4].try_into().unwrap()).to_string(),
                    false => match value.as_str() {
                        Ok(val) => val.to_owned(),
                        Err(_) => "Error".to_owned(),
                    },
                },
                Err(_) => "Error".to_owned(),
            },
            true => "NULL".to_owned(),
        };
        res.push_str(&value);
        res.push_str("\t");
    }
    res
}

#[actix_web::post("/")]
async fn greet(bytes: Bytes, _req: HttpRequest) -> HttpResponse {
    HttpResponse::Ok().body(run_query(&String::from_utf8(bytes.to_vec()).unwrap()).await)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(greet))
        .bind(("0.0.0.0", 8080))?
        .run()
        .await
}
