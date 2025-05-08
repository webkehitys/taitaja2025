<?php
// TODO: Fix this function
function getTLD($email) {
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        return "Invalid email";
    }

    $parts = explode('@', $email);
    $domain = $parts[1];

    $tldParts = explode('.', $domain);
    $tld = $tldParts[0]; 

    return $tld;
}

// Test cases
$emails = [
    "user@example.com",
    "test@school.co.uk",
    "invalid-email"
];

foreach ($emails as $email) {
    echo "$email → " . getTLD($email) . "<br>"; } ?>
