'use strict';

if (
  typeof window.Static === 'object' &&
  typeof window.Static.SQUARESPACE_CONTEXT === 'object'
) {
  console.info(
    'Squarespace detected, useEscapeKeyToLogin =',
    window.Static.SQUARESPACE_CONTEXT.websiteSettings.useEscapeKeyToLogin
  );

  window.Static.SQUARESPACE_CONTEXT.websiteSettings.useEscapeKeyToLogin = false;
  console.log('useEscapeKeyToLogin set to', false);
}
