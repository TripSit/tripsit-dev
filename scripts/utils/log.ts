import {
  createLogger,
  format,
  transports,
  addColors,
  Logger,
} from 'winston';
import { parse } from 'path';

const {
  combine,
  splat,
  timestamp,
  printf,
} = format;

addColors({
  error: 'red',
  warn: 'yellow',
  info: 'green',
  http: 'magenta',
  debug: 'blue',
});

const myFormat = printf(({
  level, message, timestamp, stack, ...metadata // eslint-disable-line
}) => {
  let msg = '';
  if (process.env.NODE_ENV === 'production') {
    msg += '(Prd) ';
  } else {
    msg += `(Dev) ${timestamp} `;
  }

  // This makes it so that the logs look nice and even
  // Idk why the length is 15, maybe cuz of colors
  if (level.length < 15) {
    msg += `${level}  `;
  } else {
    msg += `${level} `;
  }

  msg += `${message} `;

  if (JSON.stringify(metadata) !== '{}') {
    console.debug(`metadata: ${JSON.stringify(metadata, null, 2)}`); // eslint-disable-line no-console
    msg += JSON.stringify(metadata);
  }
  if (stack) {
    console.debug(`stack: ${stack}`); // eslint-disable-line no-console
    msg += `\n${stack}`;
  }
  return msg;
});

// We only want logtail logs in production
const transportOptions = [
  new transports.Console(),
];

export const logger = createLogger({
  level: 'debug',
  format: combine(
    format.colorize({ all: true }),
    splat(),
    timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    myFormat,
  ),
  transports: transportOptions,
});

declare global {
  type Logging = Logger;
  // eslint-disable-next-line no-var, vars-on-top
  var logger: Logging; // NOSONAR
  // eslint-disable-next-line no-var, vars-on-top
  var log: { // NOSONAR
    info: (prefix:string, message:string) => Logging,
    error: (prefix:string, message:string) => Logging,
    warn: (prefix:string, message:string) => Logging,
    debug: (prefix:string, message:string) => Logging,
    http: (prefix:string, message:string) => Logging,
  };
  // eslint-disable-next-line no-var, vars-on-top
  var f:(filename:string) => string; // NOSONAR
}

export const log = {
  info: (F: string, message: string) => logger.info(`[${F}] ${message}`),
  error: (F: string, message: string) => logger.error(`[${F}] ${message}`),
  warn: (F: string, message: string) => logger.warn(`[${F}] ${message}`),
  debug: (F: string, message: string) => logger.debug(`[${F}] ${message}`),
  http: (F: string, message: string) => logger.http(`[${F}] ${message}`),
};

global.log = log;
global.logger = logger;

global.f = function f(filename: string) {
  return `${parse(filename).name}`;
};

export default log;
