import fastify from 'fastify'

const server = fastify({
  logger: true
})

// Declare a route
server.get("/", function handler(request, reply) {
  reply.send({ hello: "shouldnt have to wait !" });
});

// Run the server!
server.listen({ port: 3000, host: '0.0.0.0' }, (err) => {
  if (err) {
    server.log.error(err);
    process.exit(1);
  }
});
