import random


def handler(event, context):
    random_number = random.choice(range(1, 10))
    if random_number <= 5:
        raise Exception(
            "This exception represents that the function can "
            "fail for some known or unknown reason."
        )
    return True
