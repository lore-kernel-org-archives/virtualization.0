Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985341;
	b=5e0GwcvIGCUlI9XyN6qa7t3Vc/q28cAoXKkw7SvyPGDp2NZFL0jepd9a6z0hQyrtnbsm
	 UlJUn6iaZikduHHUNsqgwD52ERsIM7WWDWsdb8pID+8bXpQdOrk6XQdlgZzVdumEFMbKU
	 P2aBU+udnRSpsmu1DOEeDo2ACiKPdDEC6IP2A6H12qd2xkByMV1uPhWx5THUD1FF9r68Z
	 IAsqepTtSRDFDTnj0DXGqYDWQdonxeMpqG51T8N9z7DaHkrsOTKfQ7x/HhYhhfV8dmlmO
	 qI13KztCfZngquMH/+BWrDh2nIM0g/c7M0JGzYZwzWK3aWKujodrAKYjM4iqig7P1Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985341;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=;
	b=p341Gbz4AcO6hDpZkGnvv2Zgg9L0YnB4ECYeQWq2k1DgTKQ7nR+TAiXaMkGcI3yEf0b9
	 YKQ4RdppWil46bjPOKLVeNH7eBx0nRxhAbGRxRSzXaL5g9pbMF5+v94pKDF2SbmZ5dHvH
	 ao319Crn/eyc2Lo0gf4D4EakaXxWJ6l0lWeQadILEw6oLYPKs6MrhtTOAXVZyOpUXJWVP
	 YTFpFLh2e2KC4zs1mWdt1tpSdrL+YYy0PiIUKqFoU1IfO4rl5ZljdwpFYFvIbcEusqhCB
	 yTCPAx+qvhohQxPnVTjP6g4timBT1ljdKTeeUsC7PVFUUXrCDf2e3Q9XoeFya+q/W2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PxynK2so;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jycC9308;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9515606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9515606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PxynK2so;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jycC9308
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ExvOB102052
	for <virtualization@lists.linux.dev>; Fri, 6 Nov 2026 17:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=; b=PxynK2soVuo53JjN
	5aj46e3rVH7kXRVGRgHizLTk7r1efV79/U0yrirlZ7/QvmE9lWyP1ixbn046WYHW
	mRNkgaEaaU5spk5b068thk09RJAnom8M5OiVBPi47dlSmBWBNLB8ncWTx78AAh7p
	jhzXb/yblbck7Ox/MlVS8y+fvGb/gylJcl6EgNx+NlJ/9KmmI9gZjdwjFDv3oZYX
	ZDE+4oTOJNA6cPFKwCcls9o+Dp7zL00pMeN6/9V06JMNLlCrP4ae9Xy4jH1E9HOI
	bLaYdwKm+bI35HThXY48Od99Ofdf7AebqtXjmLlDrhKozB/bTqxzNqKmWqfkJLuy
	dkCcwQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3v0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 17:15:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f1e7d9d4dso1730531eec.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985339; x=1794590139; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=;
        b=jycC930835TqI4rqDc/eXQudgrAHtFomGrO1Exji1zkrieevndsyD/pudiqU2FmpOF
         uTFkMz+wWj3vG1n4jMzQuxQqFO9QZssNWGeMliESxNi7WLWg9q+CQ5SYSmEmbT575pAl
         bVqpmQ+ks6WuGO+nnXnwJx9bR2K5UQSB7zKmO0hbgwEFajOwFm/SOvK2yCREBXPzrOx9
         ISMUBNicJcQzdCUbCSkGbGtQsWvE98VNajleDG3MEQd2tMc5w3w+qO2sWTwpFO50pDJW
         8WRAn9lE3rX5Qra8vDQS50Otmg8jLcSQ02R1EGm/0PTN0gGdncRwfKwPIZyYGnDPo2UD
         xOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985339; x=1794590139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ktnp8h8HYMjSZRjDLlt4pPs82/7KOH2Yv0rLDfthZeI=;
        b=Lj5BK4qHoJCv8QbxFsjGdYSrQthbRC56V4ooMTnhl2wjRYhCvUw/qYu0sllRcW2Lra
         xVfx22hjt8EqCx5dWXSrLqUfBYAc1L9QJomvcQjjkwQnCiS5VlywAj+5MM3lBOO3FMYK
         kTfhrFOqqUumaKQ9Aa1VON4fFR+blARYQTjH5kiOJ0d6UIVuj1LQ43Y8sI/ZLACy0xsv
         rqpOH3zdW4pfsrHsVsJypjyDvO3w7fqGetGODRLJ1NP9oVN30WsrYPrEQaCqLmZPyCBt
         BmxeTXPPd2MZw2Ww8lP8PXRUXusKyNuSI93G3oGOZ1VO+VbExkjxCAf9jCagqPEolzIk
         slKw==
X-Forwarded-Encrypted: i=1; AL+hErHBjBCmo9k6D03UP1u3ldAwfus4PuqbLgZAwKEaRvpp30LvYhi49mMpwJONj3e6gBx2CURZu0dS+8Je2uthvA==@lists.linux.dev
X-Gm-Message-State: APuU4Z++OM5fXBYQO6RxTqRHeZCK94CVOmt1PZWuozu1JPvjRqx5DmBJ
	m0hyPhgNJYPZradRc0J2kM9kPr8LeX7TMtMBSCAfiFT67i0cebSpCWtOgixtkfTOTgQ5T7xk3M6
	Uld15lIyFYyB5ivSH44IqhQR+UC3GTqZaSqLX/BDbQLH4E5n97qBDQT8rcmB+/KmHgVb9LQ==
X-Gm-Gg: AYBFou2GoFDfD356Z0PvRmNLYkktTTXXxeEbHpQZ0WwV6tRfD2Q/WsODzBgTYewc8PC
	sdAO9l/QV91SaPDZ/OrtDuK1cFSdi7SfVF9qk+bkpKNeY8jz5Jx1d9iaL/v7/oghloEnPfLoYeS
	4T+MM3UXBTIHQJzBAwrarGlIga057WvkNbhbQT57vz2pU5C/Gw8dQ1nWUvt5ds9U3eDIy3JCdD9
	qPiZYUMLRr3SZAShKRtMq63suQ2nUa/mgHrszX5U0wls1LdjsShM1FWx36WrDGp82foqm2t0oTl
	jKfpHr6lAf4uKeqEwFPaUiXP1dsoNFBTDFGrdNQe+HxJejRUceqnVAlW3V20d8eyx3i1H1/RS/8
	AB32nMtKq4KJuYJ3aTQn+Wv2r0fF+9mBrIwV4gU+30xMrmpJWyJipXxc9tIAeyAYEglw+ZbvnWS
	Yu3flPHxXf
X-Received: by 2002:a05:693c:839a:20b0:36e:371:8255 with SMTP id 5a478bee46e88-36f6fb7f6b0mr4460525eec.0.1793985338751;
        Fri, 06 Nov 2026 09:15:38 -0800 (PST)
X-Received: by 2002:a05:693c:839a:20b0:36e:371:8255 with SMTP id 5a478bee46e88-36f6fb7f6b0mr4460485eec.0.1793985338092;
        Fri, 06 Nov 2026 09:15:38 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:37 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:27 +0530
Subject: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
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
Message-Id: <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=3341;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=eqYY4N+b5bBNKlPSwJkXdHdjtL4HfBKjpUYn+IsXKkA=;
 b=GBQVa8RApuiz6ercB/DdrPne5hpMvwbz+39mcf5Gak8TM+/DOIR+JsQkatd14qD1YxOVp3Bni
 be5cEvNi0vbASIajgNIko9PHVXfje8oKBQGQwGiGrYCVoXQBWE0ZAFZ
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX+0ubAYeoviw7
 U6nlT591zL+sQr5/PmBfKhWnKCsFw3iLpT4o4C8geB6fBut2ABjpBLJ34KvsAt98iw+amWpJ9qW
 9/XcVUQztEJleJTElSzf8RF5GRnBsZYxmsoIEyb+l/n0UVBu1bDgHTO61fjwgGchyNZ1juvKZ7h
 TmUadKNufPFYwMMfMqg1E/sd6RS3Rkmt6rboIaVuFaVo7GSmE8fuJpDqd7j/Wnq3/8d7SDi5+zn
 9mPSmZ3aBdgveBaGDjECRDhTBeDvB3+hcgLb/mOg1U0p+PW1pi4ITRv0JJ8gmNuhQ2JP15Fe+qY
 adKQJ2UKivuWUBf2zfFyW16CgbS6OhDCwMoUtkM+MhxFFi5HmneXIkC/1IYu8W31ip/v8GgT4Jr
 HCTWCYk32VQX1xW2WLpQl7bya6Km2EssrrMOJepp6o//DyGdwJ591FVqR6R+U2nAcrKAVJ+Pkfy
 cTEvCE5dVxzX36gQs5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX0Xjw+lpXR8IX
 FToH/gBgDtkdepsFV9KIqWanbf4vOW7VJRq3isg3iL8P8mK+WvuoxaWEWkii1LB1lfc8YDWbd7x
 NkZCa9iLn/lVwoTS7w7X0dwfkN7INL4=
X-Proofpoint-ORIG-GUID: uboDMs2CpsTTSeYagF_qfKjlcOemud2a
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aee0b3b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=S4w_zJ8MM8sBhC3S0vwA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: uboDMs2CpsTTSeYagF_qfKjlcOemud2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The "iommu-addresses" property describes an identity 1:1 mapping between
an IOVA range and the physical memory specified by "reg" in the same
reserved-memory node. Without "reg", there is no physical memory to map.

The DT schema now requires "reg" whenever "iommu-addresses" is present.
Align the kernel implementation with this requirement.
https://github.com/devicetree-org/dt-schema/pull/207

An identity mapping requires matching IOVA and "reg" ranges. Reject
mismatched ranges and report an error.

Suggested-by: Rob Herring <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
 {
 	phys_addr_t end = start + length - 1;
 
-	/*
-	 * IOMMU regions without an associated physical region cannot be
-	 * mapped and are simply reservations.
-	 */
-	if (phys->start >= phys->end)
-		return IOMMU_RESV_RESERVED;
-
 	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
 	if (start == phys->start && end == phys->end)
 		return IOMMU_RESV_DIRECT;
 
-	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
-		 &start, &end);
+	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
+		&start, &end);
 	return IOMMU_RESV_RESERVED;
 }
 
@@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 		struct resource phys;
 		int size;
 
-		memset(&phys, 0, sizeof(phys));
+		maps = of_get_property(it.node, "iommu-addresses", &size);
+		if (!maps)
+			continue;
 
 		/*
-		 * The "reg" property is optional and can be omitted by reserved-memory regions
-		 * that represent reservations in the IOVA space, which are regions that should
-		 * not be mapped.
+		 * "iommu-addresses" must be used in combination with a "reg" that provides
+		 * the physical address and size of this memory region, for an identity 1:1
+		 * IOVA mapping to that physical memory.
 		 */
 		if (of_property_present(it.node, "reg")) {
 			err = of_address_to_resource(it.node, 0, &phys);
@@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 					it.node, err);
 				continue;
 			}
-		}
-
-		maps = of_get_property(it.node, "iommu-addresses", &size);
-		if (!maps)
+		} else {
+			dev_err(dev, "%pOF: iommu-addresses requires a reg property\n",
+				it.node);
 			continue;
+		}
 
 		end = maps + size / sizeof(__be32);
 
@@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
 
+				if (type != IOMMU_RESV_DIRECT)
+					continue;
+
 				region = iommu_alloc_resv_region(iova, length, prot, type,
 								 GFP_KERNEL);
 				if (region)

-- 
2.34.1

