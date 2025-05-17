# Husband-ry

Husband(ry) for Men: Groom Yourself to be in your Gal's Good Books.  

Fun Project (with Satire) inspired by trends from early 2020s.

## Motivation

Understanding and **learning** cross-platform programming, and multi-platform application development with focus on interface.

## Advertisement

> *Are you a confused boyfriend or husband?*
> *Are you afraid of silent **treatment/lay off** by your lady?*  
> *Are you worried that your girlfriend or wife might ditch you?*  
> *Are you worried about the guy she told you not to worry about?*  

Worry NO MORE. Influenced by Influencers and Assisted by AI and Blockchain - Husband(ry) helps you tune yourself to the Job Description **she** has in mind for you.

> Avoid getting [AXE](https://youtu.be/ZC6faGD0Ow4)D. Try Husband(ry).

## Design

DAG Questionnaire with output leaves.  

### Question Node

Most interactive nodes are question nodes. Question node contains a question and associated options for user to select from. Each option points to one or more other nodes which may also be an advice node.

Traversal to next node is decided based on the option that is selected and the current state.

*S_{t + 1} = f(S_t, x)*  
where S_t is state at time t and x represents the option that is selected.

> An example question could be: *Which of the following options most closely indicates the response you get when you ask your special someone on their choice of snacks?* The corresponding options could be:
>
> - Indifference
> - Specific name of cuisine or snack
> - Unknown (response)
> - None (of the above)
>
> Remember: the questions and responses do not matter for they could be any gibberish - they could even be generated with random vectors/weights.

### Advice Node

These are leaf nodes of the DAG. They provide information to the user.

### Frameworks

- ~~Xamarin (.NET)~~
- Flutter (Dart)
- ~~Cordova, Ionic, React Native (JS)~~

### References

- 

## Acknowledgements

Media and Memes.
