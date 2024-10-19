'use strict';

const { start } = require('faas-js-runtime');
const request = require('supertest');

const func = require('..').handle;
const test = require('tape');

const errHandler = t => err => {
  t.error(err);
  t.end();
};

test('Integration: handles an HTTP GET', t => {
  start(func).then(server => {
    t.plan(1);
    request(server)
      .get('/')
      .expect(200)
      .expect('Content-Type', /text/)
      .end((err, res) => {
        t.error(err, 'No error');
        t.end();
        server.close();
      });
  }, errHandler(t));
});
