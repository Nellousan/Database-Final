FROM rust:1.65

WORKDIR /app

COPY . .

#RUN cargo vendor --no-delete
RUN cargo build -j 6

CMD cargo run