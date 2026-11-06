Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985306;
	b=g19CH5KGMqAknC/s45MAAmmNVUziJ/UK7dQYeumRMaKZLQACsBrS0pPgI+JUO+ygV05e
	 DUWsEi+RU5SVNEcJJJX5PUbvQvepb3eW0yKg78/XA2OL43FISISJlyqCZer2L2/lr+4Ad
	 BLQOkO0Ns5PZ+7fGAiW6cID42G7DyrkD5rTuyDTfdEQzpDz+wvwr59acs7kfAm+BKYhV8
	 Fdz9bykIsPU8N6rfCCDiu7Sum3O60avLQkFqt13MPnsA6gMGUhKkoIBZQME7aVCo8QzsL
	 NvisaA1XoIsKn1Ngm+IbTGkv/4nBEq13ufwD+hDtTKl4TB2amvPR5PKuyyTNBETksKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985306;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mzPETPHnkYVK0UfJpNaFhQVJoXImwU21czXLXkKClNk=;
	b=siYASN8HQTk2xTcIhbEuf98BPcY8SL5ZgsRfKsrqwmjLIlsJxaH1fhV7qXjQZk+ye2+Q
	 6yV4M5pVb/Xyc/v3OXOtPFABrFcU6GgZmiQCnZhtz/K5MbNWub65tP7JrPl+0bovZjzs8
	 6nH/Kg7Eg0IsGz7aVbvrfBW1snLqcABzEVQ7xuR9dGnWi/R0Uy1VIx869Ozh1RTARJs03
	 Gw+aUqBiWnsUhsieHU51s3SJUzc22t5WSeTJVkKVA/LGDtuZclsfHZQU3Yw+2qNrCajFW
	 mTtlFqc20tjGAJxRjGuW2E1FWkcyoOwpTvns+qKZxXQ7v/zHgcQK6v/1cSut//IuQUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WU1WEKau;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SYZBJm1T;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B21606A331
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B21606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WU1WEKau;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SYZBJm1T
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F01uU1121606
	for <virtualization@lists.linux.dev>; Fri, 6 Nov 2026 17:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mzPETPHnkYVK0UfJpNaFhQ
	VJoXImwU21czXLXkKClNk=; b=WU1WEKau5zQSj+GfaHdAlAwBxl+uKl+Xc/Ixwj
	hJ1gFD3A60RZoELqBS7gKmcYPwyRmm1VbfXfxX/b4nW3DQx+f+P19s5XDGoFG+RX
	sSDNky0Fw1gn3yJnMZzn2Y9tCe055TXZTU6lfSETCxL9EiLfK4JpRaOOET+llHq7
	HHJ3W4NQ4snARMyhFqDLzZ6L1Snplds1Zhwd23BeruhorgqCjIzeFAW0DU5Wp3IC
	8/o9P2V0ry1EyAvj+ZuAj5kPvE3zzYGQ3r7FlLBZCtJc76Qhwb69Z088/X72yYDt
	GV6K9jfDji8WKw3bMkCAXcGb6ki/WHvclFsl7yj17H+GsN0A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9uurj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 17:15:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36ecd5db581so2699197eec.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 09:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985304; x=1794590104; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mzPETPHnkYVK0UfJpNaFhQVJoXImwU21czXLXkKClNk=;
        b=SYZBJm1ThtpgH2CITBIfi8j8dsDqeXOEAGY7o6WRLIcayIUHKusHFmR0INV9SB7bqB
         FLJLBvIo1Y8MpoqKTIiFwkWfVccye8hih5CKL/vReTDS0m05Cd/5to3fG11DmB1zw7/B
         DPbqof+dnA1OASM44wa/NqD+9lARj4G2Sp+Aa1vteucDNt5HJrh33gKCSe9vcaBtJu5i
         rckCczJd0c83v7r+zYb7owAlHR/zH6Mfo96WLEr+ZRq24fE+x8ZnidyqWwwIlSbT5nO+
         jr7TSz2xABIDg4RIGU1x19VsOLPhz9iOJGQ30J7RSEnWRYhr2KHjqQ3C7sLyHqJb84mA
         RbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985304; x=1794590104;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mzPETPHnkYVK0UfJpNaFhQVJoXImwU21czXLXkKClNk=;
        b=gRSNXgVtrE6dn5UoQhqw8l/uQ8ECJJjinwZkr7abnaCAD+qV2YPp/je+rVqOlzpcUW
         QWnkGgzLmiFhcM6Jv2oQQWvTeXuWJu/VAC+m+NFbzRjOjs+yvV3ta189DuTs+QS2eWot
         DE0GlyrzjEv6m4TBHUxdj+mdzhFoM4qqLVhqRr9SsdU4auu4AtPi934L2b60sDjY8aAq
         VzlapsrgCobgoZ7tCEe/N/4O9LnQRkwlqGT1Pqpt60CvtGa3BX074gMps4h099osfX8J
         63ArHxztT5qvohf0MCL1yC/LDSQQ5a+xj+okAQdW9zioKrL1xEhE3zY46uJaQZphmxQ7
         rKMg==
X-Forwarded-Encrypted: i=1; AL+hErFOEGsW7GhaC2B43Ov6foQdvEEdUqVkz4RVp0a6/HxdbffPAk0F0BbwdQGuvUeOvvN5cmOurLFHF9Ib+aKMag==@lists.linux.dev
X-Gm-Message-State: APuU4Z/9SUmmXdBh1SojT+tSjIv86YAKWmifiyIVgaTwEnk1H0MmZI48
	WUg1lBfpERL5lhgwpY5+Iwh4a5zVQctAZMcTq/pPtTWwn8qPCzoTDvwGpcF4glGSdhOwuFjvv+w
	1NC10wvpXeEI2p+dRY8+B+lvv1zT6YX7Iu7xkiUGnmi/XqbqMwzn7aV84bniEGqgVysL36Q==
X-Gm-Gg: AYBFou0X/MDMbL4JQpRiVzYvznIHWxRmFTqDF4Tc3nPZDal1SJEDsDjdNRGbL4f6Zgv
	sBpTGjg+eDL5i5rHe3+9iJNTUPYqr+KIHNp7n8ScJYmNSjpuPCi2AdURzT2kkQPzsd0F6RoR73v
	JmDV3TPnayv3qkBmArQ51/qVIWYzKIGwF++QEav3QEdLnz/zI0pa2rmMcm6n+dSe3Ii6n39oy27
	kbWKIkKr1JKRmP2Mcll9HSFCnE1YO/tb1HVaeIlK4p3AilYC2eIyP0ssn1FAjCSgCq37UupLsNa
	4vBAjrRtKX7iR+bEC04cjUctSgU381qYT5pHhSaObQJyAN95FgQfagJzS0G2qzlJa+MgAldy7Z2
	gq6XwHIdKC6WZg9wlXSmh1IUzMJu19c+Puq/M+X8a0HexYDLkKslgmfX25/hQgNS0oQ9zMLWKCU
	slIS+MKFzD
X-Received: by 2002:a05:7300:dd05:b0:36a:f99:ae79 with SMTP id 5a478bee46e88-36f75a2aeadmr4180216eec.7.1793985303564;
        Fri, 06 Nov 2026 09:15:03 -0800 (PST)
X-Received: by 2002:a05:7300:dd05:b0:36a:f99:ae79 with SMTP id 5a478bee46e88-36f75a2aeadmr4180176eec.7.1793985303019;
        Fri, 06 Nov 2026 09:15:03 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:02 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Date: Fri, 06 Nov 2026 22:44:23 +0530
Message-Id: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAO8K7moC/32NWw6CMBBFt0Lm25I+tAhf7sMQUmkrkwjVjjQaw
 t4tLMCfSc7cO2cWIBfRETTFAtElJAxThupQQD+Y6e4Y2swgudRCcMWMtR2GcZy7uMXETse698r
 f+FlXkM+e0Xn87Mprm3lAeof43T8kvW3/yJJmnCktvKqlMEKpSyAqX7N59LlW5gHtuq4/RAXNn
 rcAAAA=
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=2711;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=Z5Ua5oBOiMcZbFYp3oCu5cR6YJYcm7KwL8DCEcA6yZU=;
 b=dLAbyFhw5znL5UwjVUjewzKHN9IhmK8lt4IzRQsAfxEF+wfeGjBKMi7gA6LhDWlqg/7I8BhFy
 kyP382eR98EAPvFVqWUFsb0MnYZTmNPIE/Wqrf6JXkgZiv/PbKP1CNB
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX0EyMrYAn15hD
 ZybDm5fnofSLtRF2HdqQzesctctHqvyoVRiHEGhhrQbvmYCp8z23yz/bToXO7CVTRvXAAylGwWE
 2XW8G3IBKoCxFkQwq8IxG/Bg8D/J8ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXzOr4botSldDH
 I6+b/C597rid2fsywFic6zzLevJeAxG8C2AyTmEkfKNsS7BpW9qMc06LD8ADeSRc/bpwbfIXz5e
 1E/EAFvfZjqkIaxzLE8skjJGUxNTYcQUoRviM10lo4myw/9ED6vwVpRLC8RzHGSD4j7leFcql95
 3fVjz/MtlPVZVNNnJ2ZrSgjcgst3zw+wPOOyif7tFdl2snSfDqSZ7Q4p8gx/M/NHaOyLInVoRfV
 UcTZoGLR/5kVB5TydT28ZyZ+ke9+8uDrTFBHRuqLD5sHGuPhnFj90BJaytyqNHD+c6JX1Nfyx7F
 woNJBt4RU5/oLsB7OvQirVyCYmfeV6n/sVLWU9oMgGKQOWd/4213Ny1z27zchWOWd1KtYxqy96A
 LmneeCt/cUuI2ABlDgODcsCvPbsGXR4iN6lI+9v8BOYm1UuDAu9KxM857bYEMcq6d7SV8D0x8ds
 fw5P1YDOzo1z8EMy1uA==
X-Proofpoint-ORIG-GUID: UQWk66S8eZCODRoDo2gXWicWI9DAqXIt
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aee0b18 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=izMSoC9YYMgMvuwp5ZsA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: UQWk66S8eZCODRoDo2gXWicWI9DAqXIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The series adds support for recently introduced property 
"iommu-ranges". It adds the required checks to error out for cases 
which are not following the schema definition.

Iommu-ranges was defined in schema with this PR
https://github.com/devicetree-org/dt-schema/pull/207

The patch series is being posted as revision v6, since the patches 
were initially part of the media series [1]. The patches are moved out 
to get review comments from iommu reviewers, which was otherwise looking 
as a media series. Happy to move this back to media series if anyone have 
any concerns. 
[1] 
https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v7:
- Move the "iommu-addresses" behaviour change ("reg" required, non-direct
  mappings rejected) into its own patch before the iommu-ranges patch (Bryan)
- Make OF_IOMMU depend on OF_ADDRESS and drop the #if guards (Rob)
- Use resource_size_t for the size in vfio_find_dma() (Sashiko)
- End the derived trailing reserved region at PHYS_ADDR_MAX - 1 to avoid
  overflow (Sashiko)
- Add a dma-iommu fix to protect the IOVA rbtree anchor on 32-bit with
  64-bit dma_addr_t (Sashiko)
- Use the "iommu/of:" prefix and fix the subject case
- Link to v6: https://lore.kernel.org/r/20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com

Changes in v6:
- Addressed sashiko comments.
- Addressed comment from Bryan.
- Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/

---
Vikash Garodia (5):
      iommu/dma: Keep reserved regions below the IOVA rbtree anchor
      iommu: Use resource_size_t for reserved region length
      iommu/of: Make OF_IOMMU depend on OF_ADDRESS
      iommu/of: Require reg for iommu-addresses
      iommu/of: Add support for "iommu-ranges" on a device node

 drivers/iommu/Kconfig           |   2 +-
 drivers/iommu/amd/iommu.c       |   2 +-
 drivers/iommu/dma-iommu.c       |  32 +++++----
 drivers/iommu/intel/iommu.c     |   2 +-
 drivers/iommu/iommu.c           |   2 +-
 drivers/iommu/of_iommu.c        | 147 ++++++++++++++++++++++++++++++++++------
 drivers/iommu/virtio-iommu.c    |   2 +-
 drivers/of/address.c            |   2 +-
 drivers/vfio/vfio_iommu_type1.c |   2 +-
 include/linux/iommu.h           |   4 +-
 include/linux/of_address.h      |   2 +-
 11 files changed, 155 insertions(+), 44 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-add_iommu_ranges-549cf3fb0867

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

