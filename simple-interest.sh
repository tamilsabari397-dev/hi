#!/usr/bin/env bash
set -euo pipefail

is_non_negative_number() {
    [[ $1 =~ ^([0-9]+([.][0-9]*)?|[.][0-9]+)$ ]]
}

read -r -p "Principal amount: " principal
read -r -p "Annual rate of interest (%): " rate
read -r -p "Time period (years): " time

if ! is_non_negative_number "$principal"; then
    printf 'Error: principal must be a nonnegative number.\n' >&2
    exit 1
fi

if ! is_non_negative_number "$rate"; then
    printf 'Error: rate must be a nonnegative number.\n' >&2
    exit 1
fi

if ! is_non_negative_number "$time"; then
    printf 'Error: time period must be a nonnegative number.\n' >&2
    exit 1
fi

LC_NUMERIC=C awk -v principal="$principal" -v rate="$rate" -v time="$time" 'BEGIN {
    interest = principal * rate * time / 100
    printf "Simple interest: %.2f\n", interest
    printf "Total amount: %.2f\n", principal + interest
}'
