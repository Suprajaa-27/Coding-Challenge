# General feedback

Thank you for completing the ZeroNorth Code Challenge.

Note that we have also provided you with comments in commits wherever we felt it
was appropriate.

## Correctness

We were unfortunately not able to provision the resources in one go, please see
the previous commits made by us to find details. Once fixed, the solution
worked. Writing sums to a dedicated log group separate from the application logs
would be preferable.

## Terraform Best Practices

Code was not formatted, contained errors and the usage of the module increased
operational overhead of the solution beyond necessity. Additionally, an AWS
provider was created in a child module, which is
[not recommended](https://developer.hashicorp.com/terraform/language/modules/develop/providers).
It would be a plus to separate IAC code from other files in the codebase (e.g.
under `/terraform` dir.)

## Security

The solution did not show the application of the
[principle of least privilege](https://docs.aws.amazon.com/wellarchitected/latest/analytics-lens/best-practice-5.2---implement-least-privilege-policies-for-source-and-downstream-systems..html).
See comments we provided for further details.

## Documentation

Lack of the [Markdown syntax](https://www.markdownguide.org/basic-syntax/) in
the `README.md` made it very hard to head. In depth explanations of each
package/command obfuscated clear instructions and requirements for building,
deploying and testing the project. Bash scripts automating these steps would be
preferable.

## Code Quality

Lack of uniform formatting in the Terraform code made it hard to read. More
descriptive error messages in the Lambda would be considered a plus.

> Thanks again for submitting your solution! You will hear from us soon
> regarding the next steps.
