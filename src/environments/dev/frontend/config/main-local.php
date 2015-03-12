<?php

$config = [
    'components' => [
        'request' => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => '',
        ],
    ],
];

if (!YII_ENV_TEST) {
    $config['modules']['debug'] = ['class' => 'yii\debug\Module',
        'allowedIPs' => [
            '192.168.56.1',
            '127.0.1.1',
            '127.0.0.1',
            '192.168.88.104']];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = 'yii\gii\Module';
}

return $config;
