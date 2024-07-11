// config/middlewares.js
module.exports = ({ env }) => ({
  settings: {
    cors: {
      enabled: true,
      origin: ['http://localhost:3000', 'http://16.171.236.194:1337'], // Add your React app's URL and the Strapi server URL here
    },
  },
});
