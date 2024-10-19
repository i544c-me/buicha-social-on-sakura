'use strict';

const func = require('..').handle;
const test = require('tape');

const fixture = { log: { info: console.log } };

test('Unit: handles an HTTP GET', async t => {
  t.plan(1);
  // Invoke the function, which should complete without error.
  const result = await func({ ...fixture, method: 'GET' });
  t.doesNotEqual(result, '');
  t.end();
});
