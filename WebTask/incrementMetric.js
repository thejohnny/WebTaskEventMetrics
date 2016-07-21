var MongoClient = require('mongodb').MongoClient;
var waterfall   = require('async').waterfall;

module.exports = function(context, callback) {

  if (!context.data.MONGO_URL) return callback(new Error('MONGO_URL secret is missing'))
  if (!context.data.vendorId) return callback(new Error('vendorId is missing'))
  if (!context.data.metricName) return callback(new Error('metricName is missing'))

  var MONGO_URL = context.data.MONGO_URL;

  waterfall([
    function connectToDatabase(done) {
      MongoClient.connect(MONGO_URL, function(err, db) {
        if (err) return done(err);

        done(null, db);
      });
    },

    function incrementMetric(db, done) {
      var metricKeyName = 'metrics.' + context.data.metricName
      var metric = {}
      metric[metricKeyName] = 1

      db.collection('metrics').update(
        { vendorId: context.data.vendorId },
        { $inc: metric },
        { upsert: true },
        function (err, result) {
          if (err) return done(err);

          done(null, result);
        }
      );
    }
  ], callback);
}