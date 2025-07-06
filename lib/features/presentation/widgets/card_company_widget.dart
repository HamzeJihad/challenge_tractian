import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tractian/features/domain/entities/company_entity.dart';

class CardCompanyWidget extends StatelessWidget {
  const CardCompanyWidget({super.key, required this.companyEntity});

  final CompanyEntity companyEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff2188FF),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: .1), offset: const Offset(0, 4), blurRadius: 8),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Row(
            children: [
              Center(child: SvgPicture.asset('assets/images/company_icon.svg')),

              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  companyEntity.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
