Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719797;
	b=bCJb+DLTndDMJnq/jMWYB09pD+DkDVQ+oHRkoOfk5qwIltUHPImi1aoAAOlSIUsYHaaK
	 T5RXdc87SFwYqfPFaCDAPKS+0E6UNHgVCPh+SBJfSHmLNtxRNv0MT07J0ZfuypWMBPCE9
	 4EZajUTNgmjrMa20WSFnXbYeQ+kxVWjWDkFagUT/ZZNIMLc9GxcbaSkINSIBN+8FTNIIG
	 CUIaKjYR41AUrOCLzX4MWvBU4aPMU0X68QG1Pw0Gv7aYIxXUX5Fu8n1wHSnIqtvV4KUNz
	 Nfy+zY73uUh7f5xfGU4+vEqdBAF7GWUI8qu653Pc6bfT/Ttjzo3sL2OxvoRRd/VlBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
	b=Wl27uC3Pw4uQpxfpAbarVyP7kaVdC/TATl9+UR1Wi/b6OE07ndL2fTlzXouMbP9j4O9v
	 p77fStUXF+2yyi8hjxvBXdOLIPZ53nyDgIXKizLNfUOFwW4pFH9HaRspoIVGxkum5YAjh
	 ESVeRcMhX3z1PiHZSczRKS2hL8R6mX6c4Rw0nudvjNddbimeYiMNZk9s9wes/KIknZy9P
	 adCPBtlf8T3JAs+YKtMErxpPlVSk6CjxkrCK66EissFz857Kiy3DFwvitGL0LdbgeauLw
	 f8jl7Vy6N3BOoodqbgjChg2kns99s33ElSmBhxdqM8q9itp0CmEKWXZMf5rAB4ikNZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiaEb7tp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XTzE6pgJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4098606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 15:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4098606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiaEb7tp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XTzE6pgJ
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9pJq4103888
	for <virtualization@lists.linux.dev>; Tue, 3 Nov 2026 15:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RzAwmn1KqONWs6eIlRenG+
	fOoEFpFouVi0Vep/WmIJw=; b=OiaEb7tpyJlOXnQBKO5HXYHqU2QXQBLRj5DN2s
	J9m43VarO96/fhzBkqOF99pH/jp7CWtEd/7gB5g1obL/Bic81XJYCHaohzZ9l0xA
	L+lHtvzwMr0+EZwyBMpRGgDIamcU52pS6xKLVo3lnjqY/CW7vfFF70dfPu663YXp
	nY084CVXXX7M9tr1eG+Gk3Tld4uOjtgbHBopSwWz5AZc5phqE6SM5BQbwlZG3sXK
	wSM+nWcVUYuiimzvXkGUneVvCBHfi8DB1N11earN6dSoaSAKuDC8svxOHbUS+GIA
	Ic/5z2TXwadvdM0rxALUyXhXU2bc3F9NRqopaWEGqbBOcIRQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76daudc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 15:29:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3552883bd19so2224192eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793719795; x=1794324595; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
        b=XTzE6pgJvpxIq6u8hFdt8qHtCP8SCQz19KJclYQUrHfNSI/mWl5nKHAkU8u7c4fZqS
         +30kgDRNrenyujQaGYVx2FN2l17rNhw/TnqPF9uP3cHjpziOQvJ0/mDKIYsoJ8Zax+Xa
         zHfBFMdvaKRsNVtc8uCu27ZzEETMIYAFYhj/r8NB3avt1AWGqnZSm1SSIm04FYFfSyTt
         kdrOtwLjUfLIJH+E/d8parO4hZshIskmZ5tEodBCJWTqnfz5OVuK+eqzoQTthvOfWZiy
         8LCU4DayQJpIIicOSv5NbZnmE3T6UJGfjhdw/7WvSh0fKUYOYePx+u0+BCaCEUL5M3yz
         VHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719795; x=1794324595;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RzAwmn1KqONWs6eIlRenG+fOoEFpFouVi0Vep/WmIJw=;
        b=S/NLnMvjybNaXM8OD1ZWmiRAx5A3jr3LJLSmH3ZAt/MiddcqjFkIFMNpJz8wrsLt6l
         lfGuCXwidhqLglsRPZeHW/HhhfICkYeOMSIRvbsMzKQhzbMNdpoxdQQCcIonwaz8IrMI
         6cnFr+yKOJv4/FY58MkdSzTz/tS1JsYLg1jFE7nzX4YHt1ZiG1oqe2fYfa3Z2E7z4LSF
         prn9AjA4iY6wjq0DJEStJI1qt1+SEKBlHVirdohqcUKLL/umGV0dOsGi/gubQCLPd1GL
         ecNRA8mNqf+q9JdkvW1RVPByk8tUse4sO6g/4KTnF6uSqJ1ml0OtxhPYnmVf14O6TSdS
         d0vA==
X-Forwarded-Encrypted: i=1; AKwUvBz/tIbnhB5kEaV+bgNlIZxefKb5USbFkvb03W3WQAKCIW7ivhMrgqOMpHraC/GTE36NcRFnNmOuNZMZ6Ywwyw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+b7jzg959MpNR9KkLMIktcfnrb4fm7SR/434LlVbw1xdUtzNtP
	Mjetom5FxuZTJHuWN0KF8o2V8zPR5W9Jp3WUKj9mx8AxyliMsbsDKCcVe1HbUoDhsrDtuB83XHa
	wNlMCa/4BSZLqk5v5noAqZFBipNxttG7bBejO69SUxYvbhk3GUP4wHVzvCR/JOq/gAyZ8Qg==
X-Gm-Gg: AYBFou1myZ9ZZGHukOLT4PfNr+OYEhRsCvTIX7lz+p5/AqVvMPcmhTVmYiJsOQLYGNU
	WVH7Cdu0kLxFfeMMEmlGhsjkLQcGBCxwcAcFA5Fdj9Ojl630+6tszgo4ZQGc1IdIFXDN/UwonSh
	+0azCpmArmQbSgFiP0F4s6EDG7FN0uHQpiFcKgUojpvcoe1UKcCIi+moJ+A9dptAGHBshiR2qQx
	NfEOOCqVrzDcTMBWtxvQOxY809fPSAJvgTWXUYulKqhGtMyu96pcuHMd5apmtczhUMGaZEfXxBQ
	mM9TYXHQE41ynmnZ5YxONUBDvh37h9yUz7nxGZRCiLG/WpyQ011ecRflUcef/+7VjDfEqVyBKcP
	FbOk3iPCDNh1mslBwbHY4PR+UFemG2XeVT20ni4nEHq3TtSsUXNZHeVS1S8H7nSvAgHZDNwvn1y
	x0V5ibV1uW
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id 5a478bee46e88-36a423a3232mr23680644eec.19.1793719795258;
        Tue, 03 Nov 2026 07:29:55 -0800 (PST)
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id 5a478bee46e88-36a423a3232mr23680576eec.19.1793719794488;
        Tue, 03 Nov 2026 07:29:54 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm59888302eec.1.2026.11.03.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:29:54 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v6 0/2] of_iommu: add support for "iommu-ranges"
Date: Tue, 03 Nov 2026 20:59:31 +0530
Message-Id: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANv96WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNj3cSUlPjM/Nzc0vgikHSxrqmJZXKacVqSgYWZuRJQW0FRalpmBdj
 I6NjaWgCSac2bYgAAAA==
X-Change-ID: 20261103-add_iommu_ranges-549cf3fb0867
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793719787; l=1715;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=52kUfvJEjuAQ68NM7IfYjdmCWi0NnQFqIUoegHkYmd0=;
 b=DsGcdPC6bbyZcgbXI+x+d2nTQHP/P17/5VsA0eTxp/IopXFAyFXAhN7bSJu6be09Ke2TJ33KG
 Y8u+E7u3GIUD4nBNAz680SfcfPFwpr+6GDGk0YC9/7/b9OlbVEMWgCm
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9fdf4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7TpIluchohn6vR-9VeIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX8p9naa3iBF3s
 zdObN1v9RNJBv82GdO8Yyu8Mhax9n38JiIOejwQliSAlhY66hTJf0TydKX1KmZwogsHsbWL5iir
 xnMrzrSF6uDjmnuRd20LyGvDdTjYl6U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX6GgFqrNV+LLf
 cSo6hxG5nJV2kGTCJKVTd9UewTvgfUPjRQ/7aSkPP5DO3TPC+VxBJp3hcQMUfaCnshZkMDog8xf
 y4XRnqVF4z5s+/M+QvnVnLT6HHAJA2eHfvmeWdY4tymouKdo20yU7nR2zwHQedkNkwMoGxCyLA/
 t8uz17quCSEZGz73WhTfAasrf1ynlF+UrcxpK9tnHlWqul4ZOSF41aui6PEkCbjm73/29z4J5wD
 E8P+U0UpE9xQ4zTLlnkCNVFisTZ3AQ+WukJEdvYcXxduz/nm4wYMO1spl39qAXA3sb+PYx4HFzv
 5DVDAJ67owFKDSGEX+8bbb2OX7/d6EzQOSbK4LZig+UC4NS5DZ+iFPHzljRvzmCVUhKTzWC9LL/
 TDQJDqLEtIHPF3oCrejNcdbLtueVDy7y37I1ejJJ7eWXf5+cddOSebDUGZbWY5xfEF7gx/Qm0mI
 LDCn/ng6HHjpqG2zbEg==
X-Proofpoint-GUID: haDpUTN4RDK6qhFlm1aoqfnAFGHgiK7v
X-Proofpoint-ORIG-GUID: haDpUTN4RDK6qhFlm1aoqfnAFGHgiK7v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030061

The series adds support for recently introduced property 
"iommu-ranges". It adds the required checks to error out for cases 
which are not following the schema definition.

Iommu-ranges was defined in schema with this PR
https://github.com/devicetree-org/dt-schema/pull/207

The patch series is being posted as revision v6, since the patches 
were initially part of the media series [1]. The patches are moved out 
to get review comments from iommu reviewers, which was otherwise looking 
as a media seris. Happy to move this back to media series if anyone have 
any concerns. 
[1] 
https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v6:
- Addressed sashiko comments.
- Addressed comment from Bryan.
- Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

---
Vikash Garodia (2):
      iommu: use resource_size_t for reserved region length
      of: Add support for "iommu-ranges" on a device node

 drivers/iommu/amd/iommu.c    |   2 +-
 drivers/iommu/intel/iommu.c  |   2 +-
 drivers/iommu/iommu.c        |   2 +-
 drivers/iommu/of_iommu.c     | 138 +++++++++++++++++++++++++++++++++++++++----
 drivers/iommu/virtio-iommu.c |   2 +-
 drivers/of/address.c         |   2 +-
 include/linux/iommu.h        |   4 +-
 include/linux/of_address.h   |   2 +-
 8 files changed, 135 insertions(+), 19 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-add_iommu_ranges-549cf3fb0867

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

