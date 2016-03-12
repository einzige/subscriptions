# Subscriptions

Implement an app where users can subscribe to each other.

## Business process
User creates an account in the system. From this moment user can subscribe and/or become a profile owner to let other users subscribe on his profile:

### Profile owner flow
- Any user can create a single public profile.
- Any profile must have a cost set.
- Profile owner can change cost at any time.
- Cost for existing subscribers does not change.
- Any profile can be deleted.
- Profile can't be deleted if gross sales for the profile owner reached $100.
- Deleted profiles can't have subscribers (system cancels subscriptions automatically).
- Profile can be restored.
- Profile owner can go on vacation.
- Profile owner can go back from vacation.
- Once profile owner disabled "vacation mode", all billing dates for its subscribers must be moved accordingly by the number of days spent on vacation.
- Profile owner gets payout on the last date of each month if monthly gross sales reached $100. Propose and implement your own `payout_amount` formula.

Petri net for this flow would roughly look like:
![image](https://files.slack.com/files-pri/T04P6CFKA-F0SBXEMRT/pasted_image_at_2016_03_12_06_38_pm.png?pub_secret=bbd44f9be8)

### Subscriber flow
- Any user can subscribe on multiple profiles.
- User can subscribe only if their billing details are set.
- User can subscribe only if their billing details are valid (credit card is not declined).
- Subscriber gets charged right after subscription created.
- Charge amount includes profile cost and additionally fees set in the system configuration.
- Charges recur until subscription is canceled.
- Regular billing period length - 30 days.
- Recurring payment must always happen in a next month.
- If user cancels subscription he still has an access to a profile until next billing period.
- User can restore subscription. Will user be charged or not depends on date of the most recent payment made for the subscription.
- If recurring payment fails (credit card declined, zero balance etc) subscriber looses access to the profile until charge succeeds.
- When user updates their billing info system automatically performs attempt to pay for subscriptions with failed billing.
- If user updates credit card details 5 times in a day, system automatically locks their account.
- If user subscribes on 10 profiles in a day, system locks their account.
- If user updates their credit card number and this credit card number is already in the system, it locks their account.

Petri net for this flow would roughly look like:
![image](https://files.slack.com/files-pri/T04P6CFKA-F0SBNCWMA/pasted_image_at_2016_03_12_06_43_pm.png?pub_secret=f58c114e1e)

### Account locks

Any business action can't be performed by a user if their account marked as "banned" by the system.

## Additional tasks

- Calculate monthly churn and retention rates for subscribers.
- Find profile recommendations to subscribe on for a subscriber.
- Fetch a list of profile owners for payout (with payout amounts).
- Fix issues in the task description.

## How to

- Run `bundle install`
- Edit `config/databases.yml`

```
vagrant:~/app$ rake db:create FRAMEWORK_ENV=test
Loading test
The database subscriptions_test has been successfully created
vagrant:~/app$ rake test
Started with run options --seed 52239

  1/1: [===============================================================================================================================================================] 100% Time: 00:00:00, Time: 00:00:00

Finished in 0.02387s
1 tests, 1 assertions, 0 failures, 0 errors, 0 skips
```

- Migrations?
- `framework g migraiton create_users`
- Migrate?
- `rake db:migrate FRAMEWORK_ENV=test`
