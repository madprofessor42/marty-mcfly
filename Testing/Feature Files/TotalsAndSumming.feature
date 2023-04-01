Scenario Outline: Total concentrations are calculated for analyte groups
Given I have a set of processed components in sample "Sample 1"
| Compound name | Is Internal Standard | Linked Internal Standard | Calculated Concentration | Detected |
| Acebutalol    | No                   | Labetolol                | 0.01                     | Yes      |
| Metoprolol    | No                   | Labetolol                | 0.005                    | Yes      |
| Propranolol   | No                   | Labetolol                |                          | No       |
| Atenolol      | No                   | Carvedilol               |                          | No       |
| Bisoprolol    | No                   |                          | 0.02                     | Yes      |
| Labetolol     | Yes                  |                          |                          | Yes      |
| Carvedilol    | Yes                  |                          |                          | No       |
And I have assigned "<compounds in group>" to the "Beta Blockers" group 
And I have a total "Medication" that is using the "Beta Blockers" group
When I review the data summary for the total
Then the calculated concentration of the total in "Sample 1" is "<expected calculated concentration>"
And the calculated concentration warning of the total in "Sample 1" is "<total calculated concentration warning>"

Examples:
| Scenario                                                                     | compounds in group                | expected calculated concentration | total calculated concentration warning                                      |
| An included group has one detected analyte                                   | Acebutalol                        | 0.01                              |                                                                             |
| An included group has two detected analytes                                  | Acebutalol, Metoprolol            | 0.015                             |                                                                             |
| An included group has a detected IS                                          | Labetolol                         | Not Calculated                    | Check all Analytes and linked Internal Standards                            |
| An included group has a detected IS and not detected IS                      | Acebutalol, Carvedilol            | Not Calculated                    | Check all Analytes and linked Internal Standards                            |
| An included group has an analyte which is not detected                       | Acebutalol, Propranolol           | 0.01                              |                                                                             |
| An analyte in an included group has a corresponding IS which is not detected | Acebutalol, Atenolol              | Not Calculated                    | Check all Analytes and linked Internal Standards                            |
| An included group has analytes which have Linked IS's and some which do not  | Acebutalol, Bisoprolol            | 0.03                              |                                                                             |
| An included group has a mixture of ISs and Analytes                          | Acebutalol, Metoprolol, Labetolol | Not Calculated                    | Totals cannot have a mixture of Analytes and Internal Standards             |
| No group in the total has no analytes/internal standards associated with it  |                                   | Not Calculated                    | No group in the total has no Analytes/Internal Standards associated with it |
