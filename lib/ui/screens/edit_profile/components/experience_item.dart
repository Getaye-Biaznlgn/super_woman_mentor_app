import 'package:flutter/material.dart';
import '../../../../models/experience.dart';
import '../../../../utils/constants.dart';

class ExperienceItem extends StatelessWidget {
  Experience experience;
  VoidCallback onDelete;
  VoidCallback onUpdate;
  ExperienceItem(
      {required this.experience,
      required this.onDelete,
      required this.onUpdate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * .5),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    experience.position,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    experience.org,
                    maxLines: 2,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${experience.from.year}-${experience.to.year}'),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              const Spacer(),
              // IconButton(
              //     onPressed: onUpdate,
              //      icon: const Icon(Icons.edit_rounded)
              //   ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.backspace_outlined),
              )
            ],
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
