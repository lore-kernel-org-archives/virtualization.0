Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170946;
	b=sIBisl2dKv9S6z81dWSFVak7zob3TuPi1DAVu7jzg5XAdNvYwke4zlBJzx1FMS7egJg8
	 j7rWieBOQF8lWAEvg3Ok95ZWxM+gWGDGLUlhTaoORtBseRhrzx3QQeKZC7xJmWBc3cWCV
	 RUFpPldgHB93BegcMxZDDKXTrC3jGfQVQgIh95Wl4Q93Wx0UVebtB4Yakwz3ZBV+kG4v9
	 EbQJIPZ4vLxFLeA+G1bb9r1OeTn6LQgYIJW1eCep2faHDR2z90CrErY6Ya/Fd1C1Urmbt
	 9xOruS2rDDAQUxHsZKj00tlkT0/K8MQyij2fXgkwpZy0Z3SUWaMVMVGPpvBAHl1A5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fGQE7qT4NXgldceTPPFhsj1qcpB7We7i0rIqTaL6aHQ=;
	b=HKo6rymbGE0MDzuOaZ5R9C/gnq9TIdJMPpczgkBriY8/lHf+e0rwurLJTx8aN4ptqA7o
	 IZpUBRmRW2g9PXP9Ga49jvRzgZUScVl4hGKqRK1mZ5hM25oXitbICl9v1IMXtWgjT552i
	 PBq4Wq0YDLB117ttqbQj9qzKF9rZR2KUCRGPgGVZH/xnMs+jUFN3tdi9mGWsx8OmKif4/
	 3Nwrr0qjTFOP+8EDWGfD74pZZ7yzKoS8bZuNYzkpm7J98SK8hyHQEEtANH7fRKLMwFMvi
	 1e7qfaZJFOOjPjtjJ3K311Z1/Z+YKRzlxZa5YeiBvCOt3APwrqQpyUH4v4DrQN3XqNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BCK4V0A1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OKths3JM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832A606A32C
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0832A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BCK4V0A1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OKths3JM
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7esM72019478
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fGQE7qT4NXgldceTPPFhsj
	1qcpB7We7i0rIqTaL6aHQ=; b=BCK4V0A1dKIG8oniMCufQ1infKALXo/PQJemoT
	MJvZQwPR7cvXGPSepenf7gdgxqjzvAZcuyX5nYzZ+Be/mlbPbXZl+kvRSc0TheOn
	BxnBN/65T/OxkfKYb9xPIj7pTrwFoNQpNHNP9VWUmk2tL8MBdL1V9icx+vDouEWp
	adb+dZGXs8qvJC+W2jeMjLsvkWMBrdWcNXM2R7vdh21HqfS1GfUVZJgBqdQCguvU
	QRYDfhJnmWNMxicPHn2ty8gpA2CDoUuIvB4c9Tm3nDH7CUIPH0w3TDvFjcRcsph0
	MDyJgWkz36cAb/u26inxtbJHYnEo7+Hjt24Qw/dsvTmubBfw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjj9b7t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:35:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-383ec96a7deso816087eec.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 02:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170945; x=1795775745; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fGQE7qT4NXgldceTPPFhsj1qcpB7We7i0rIqTaL6aHQ=;
        b=OKths3JMUdF32mO5R1ewupxjQb0QVa3TGZCOsM8Oh3IUYAlGrkzsnMjDg+GP9IIqAu
         wDrUxPsofNnQEpWD2qskPx6FcAh0VYn7c5D27fCqjKQAfIoL6KaMRBtBWZB1Oi571PAd
         q4v/xbhSX/1YHBdxz1CtAP3XSudwQtMcMv5ys1xrvxXIb3K2L0EXx7KLWfX+eatzRbq9
         OAV+u/EcL46R2H8SP3rax7yDBmbJCtbNt2zt8QaY/O3dDOKY00YugQlCa66Mw2v7RISO
         129HMA8oYZuTC2ZHLI9tdOB6lZzcceh8wWGvuvkwOd6WckjDCEkRXF/svOQ6q/nxC6B2
         8McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170945; x=1795775745;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fGQE7qT4NXgldceTPPFhsj1qcpB7We7i0rIqTaL6aHQ=;
        b=HfupAOUgqANb337dDbgJ+cwbfQ8jR6nRsZrOGSdFKVpN8qcJddRlerdVhqTo60ezX9
         4nb/H7Isl4cK16z5DpmrhDtD+bh8vSEYr/Py5wvddnv0mhhX/TikW3Vbp65WHNICYmAF
         Rro7MU6Zp0hkNLzC9xRyjH3R8vg23UH56hbOrd0oSYqld/VdDiQT6kC/OUwr5lHE+I4C
         GFdjzZ9l6+qOt6iUDESpzHI81OkPyseZjw5t354z1zRyKs51irUySST8eQ4ZmO7yFmhz
         s3o9NPbgvZ8GCLuZzgysruppGiX3fm20K/8bS/asfLHB3h11wuacOff5qsJFY8gsowQo
         E3EQ==
X-Forwarded-Encrypted: i=1; AL+hErEROZhmM0xVPsQbU97bCTHIbjcWh3t0T91CVL08Wdn4y4pl3I+n4eCiq3NgzrfNMHWurwA+p9hqzATcfEIZag==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VdcTt0kaMnPYMDDezYubR7ZwcwymawFcKTUbBNDouMeJG4iLh
	Uu0hMJrlAjJb8apyf+GYxPrlxbtNZl9cZha8Du5X6eQgjs3iBz+vqzefjd2mayEwwWgwbcGR4Sb
	6F+ha56qHZhMZYAEhtKRJKQbGyvDZfZNu3oxGg8HstRDp8XRZNsEMMUyDD4wVxtGd9VAyJA==
X-Gm-Gg: AYBFou3jQKm7YONWqv3fuR527rZguSteiIE9WfheTs982SINuzCeS0QIOXnAgFDSGlK
	2fuGoTe+d0sX3htWzro5yuU+stH0kWAtP9HXaVmQMTaxULGmVFUDgBygwQ/e6jv505cyWPZFlBX
	xjWv8q25P9BdECcA5D4o5rgphYkkLZomVkcOIgWPlk1z/sIqhk9v6wTYWZJWeT8jr4SZlZH5Vqu
	lYJXm7WceB886IX4ukmQNoszeEMp8Vmr4SK5y2wcx83QK2hgHq7qE+pApXAa8IWWbITLDfxaQtW
	8Ev2nEHSJLiUf4J+QXMBAcIpwTeJFXGdkFIQVBghrCUq/zud/swqB91XYYIhKiceialPeDkPPWw
	3f0HOLYDMmWgDrbkYzIf3QGIwU0JDPMpOEH5fiipFopEft+KYoksT0DUMEtuacHDaBMi2wUAje9
	KDZ3xannbi
X-Received: by 2002:a05:7022:6988:b0:156:6676:d0e2 with SMTP id a92af1059eb24-1b55689f5dbmr3186133c88.10.1795170944397;
        Fri, 20 Nov 2026 02:35:44 -0800 (PST)
X-Received: by 2002:a05:7022:6988:b0:156:6676:d0e2 with SMTP id a92af1059eb24-1b55689f5dbmr3186082c88.10.1795170943867;
        Fri, 20 Nov 2026 02:35:43 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:35:43 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v8 0/4] of_iommu: add support for "iommu-ranges"
Date: Fri, 20 Nov 2026 16:05:12 +0530
Message-Id: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAGAiAGsC/33NSw6CMBAG4KuYWVvSh7TgynsYQ2ppZRKh2kqjI
 dzdwsoFcTPJP49vJog2oI1w3E0QbMKIfsih2u/AdHq4WYJtzsApl4xRQXTbNuj7fmzCMo6kPNT
 GCXellVSQzx7BOnyv5PmSc4fx5cNn/ZDk0v2DJUkoEZI5UXOmmRAnH2PxHPXd5LUiF1jMpH4du
 eGo7JSGOsVpJWzJN5x5nr9LrzL8/wAAAA==
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=3521;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=GzIgwPcWsEdtE1R5dZ2OEfKuPBvzYazXDg9uDLXcGpk=;
 b=sAZIyYEFMPxc/mKwyM+anhz4daQoxanD7OvyvyY9sxfkh769HMHL94xBo7DLUmcOBPF1ICV4I
 Dc/pfA2MwZNACkbu6kNRYiyo8oaXW1RwkH5NV5lp7Ze0wyP781gadTQ
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b002281 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=18qFwLbqBIf2JpEd1ngA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX/GS6YDEYS5xn
 Q9Ja/kzqK3T/DVz8xq+1x3hwfUv5oM7kMAs50Eude+2sCPF9MeLeliOCTQ0Gs+7wpDDrdCIkjVj
 v09Za2idPzPMGX/Z2Qd1vtHYjKJWD2E=
X-Proofpoint-ORIG-GUID: hn-_DK2DisrrO_954icmuO9v7zXBz8SE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX5KeqC5iVpolA
 3me0pzDywPRmpCqJkwk/u/jUgPcm7bIaTgEzLzwE6hNUD3Y6ClkJMVmu8giPVqkJdj3LNc70WYg
 uw2DZGTmRZZVjXs2PiUzMDkc8ZTCQoAmCAATUOxJOdazwhEhEpAfMD+NObFmC5ONM9Pk/QpNe4y
 TbQAmqeDMbNwUPsb3Lgb/DbzHtltlu037ot3Huzo+LxDY+CD+tQ/oRmLuGegwhNjBYBQsJn0DSO
 DGEp9LDW6ii07tocl7MAjONALASor45Cw5Dvi3ZWbeVxAeKWsUPxz21T8IzHzsjMI5OvLb8MEN7
 ptCPxLeMNl/CiLjl3xgEXCv8MTopeXCoHK/4DaoJUluk/Z1za4XaXjBN5JPrr8gJNY3UN1Q85E6
 eN9dBFziMABy6E1PdtpzaJ1GpiGoHVB+nYUNS7gsAhJeTCfqZiyHUbUM32kZKea8h04T+K5ylDM
 C8A8vvnMARjCCDRPxDA==
X-Proofpoint-GUID: hn-_DK2DisrrO_954icmuO9v7zXBz8SE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200042

The series adds support for recently introduced property 
"iommu-ranges". It adds the required checks to error out for cases 
which are not following the schema definition.

Iommu-ranges was defined in schema with this PR
https://github.com/devicetree-org/dt-schema/pull/207

These changes are required for following clients
DCP display controller
https://lore.kernel.org/all/20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com

fastrpc
https://lore.kernel.org/all/20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com

Iris video
https://lore.kernel.org/all/20261103-vpu_iommu_iova_handling-v6-0-e4b6ad864f8f@oss.qualcomm.com

This patch series is being posted as revision v6 onwards, since the 
patches were initially part of the media series [1]. The patches were
moved out to get review comments from iommu reviewers, which was 
otherwise looking as a media series. Happy to move this back to media 
series if anyone have any concerns. 
[1] 
https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com

Dear IOMMU maintainers,

If there are no review comments, could you kindly apply the patches to a 
tree and share an immutable tag. Other media patches can proceed with 
that tag. Otherwise, if you prefer to have any other approach, kindly 
suggest.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v8:
- Drop patch#4 to avoid ABI break (Krzysztof)
- Update commit description for #3 (Dmitry)
- Link to v7: https://lore.kernel.org/r/20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com

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
Vikash Garodia (4):
      iommu/dma: Keep reserved regions below the IOVA rbtree anchor
      iommu: Use resource_size_t for reserved region length
      iommu/of: Make OF_IOMMU depend on OF_ADDRESS
      iommu/of: Add support for "iommu-ranges" on a device node

 drivers/iommu/Kconfig           |   2 +-
 drivers/iommu/amd/iommu.c       |   2 +-
 drivers/iommu/dma-iommu.c       |  32 ++++++-----
 drivers/iommu/intel/iommu.c     |   2 +-
 drivers/iommu/iommu.c           |   2 +-
 drivers/iommu/of_iommu.c        | 115 ++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/virtio-iommu.c    |   2 +-
 drivers/of/address.c            |   2 +-
 drivers/vfio/vfio_iommu_type1.c |   2 +-
 include/linux/iommu.h           |   4 +-
 include/linux/of_address.h      |   2 +-
 11 files changed, 140 insertions(+), 27 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261103-add_iommu_ranges-549cf3fb0867

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

