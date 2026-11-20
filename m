Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170982;
	b=R8rDoDp4ZOKuP/aVKlipL8HQlvH8Q2kSWwxvk3niqCoYGikeGX17Pve3fHK3TL6WcUNW
	 kngpjhSYTVskcF2uDYdLE8UI8x41Kd5ls1gFLJZJ+wSrfnRqst7jL6EWADxcOMBNrwPjt
	 5uCWUDoBJMFBBgsQeMnndGI8bWpFrA+x9hzUdA56EmXvEzlOfNRSF82oJs9VAeni8LlHj
	 DcNqdKh90J/B8FpsEWt3wG2A4joSr7iY3jq7ZaufHHvvGWdbtuCb1/Sxmxf15YmS8jHB7
	 Iywm5Alhx4/b6qnOH+K3lpCsdDjqV1xnCxtcFQt5hmFOtRBlhFAa45P0DTOQZe8LuHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170982;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=;
	b=seUNRBJIV2JHzNtVqAvDiQz0nuAV5e/6Eib3Ijxevk577sT+v/pFFIv/2iMoRh6xxfbZ
	 a8Uz5rbaklOa/QEqH3rSgMROpzR8n3++xddAexHvXOTlPs3Cv6FXrTdmafpiOUPtqI0Nd
	 lxyteJY/Q+xbU1WxtFlXnBg4i55+qcS6I7Bh8R9DtocKqPSMaKiRu79W/xIFrypybwbLt
	 lBpRJvXYJ96wFfi2LZV0yeebxln2Y+nj2XNsGhceDKTPOwh2DUXY2LWoi4LwI3o27R0Iw
	 ECVzo2DO3fDHFQj1LUsa/C/BWbhbKlfez83h/zQN5Vkh+RPG/l97htjkROMMPNX/Wbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nZLj8MnR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBTdbz5N;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F7606A32C
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC3F7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nZLj8MnR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBTdbz5N
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7evj3605903
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=; b=nZLj8MnRYh9hs9Z1
	DVr+pW8mc1HN1+h7E6DSbGUCPtnqf+95k2vaosJBKr2xH4jr4SDOQWstZSELjR6X
	P4rwFyLFWy5kwqItqEIlPo4TTXkOvO6XUxiO3jL/VH4MDt+q5Tr/gnxupui2HpZx
	Mv8GBg4sJMEtLta0MYBaoVC5oohiqcsLBvmZYaH8RObu0B0N4juu95ENTLtBbdfE
	ezsy4ocxbNHj53s/TIY1tr1QiX9M5DEPqpG0lXSWEs31qJ/AJolmBjZwP8woOdNP
	k3wnL36p5yzY/9nO0cJit0VVgWf9P/Paq8tSeDaa22a6FZEWjdhF9Wa1VV+jLP+m
	lZDmmA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqs3v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:36:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3b45597c7so1741675c88.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 02:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170980; x=1795775780; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=;
        b=DBTdbz5NE8DOHsbUIgbQyZ0SZskK064ssGMPWYkyGw/YeEHJlPd56zUSlGM9x8XdZr
         dBv+AuEpZokc9HA5OI8Ayhj+F1FBw8Ww+pxC/+XwqrrKG7I/Gkzn7K+mSYjBvh+ad5YO
         BYWSqiixWTuBuEYp0Dss+7IRW8YDaKqp2DlTm9z1rcJppbHAm7M9GfgikhXSJQwPoBNy
         gSMK8KNElov+1N1mmyVedb1SDxgei6R62uD8u8W0JNhK3cW8nc77OXV3Db1B/rt8Vkhi
         wdIzXd9L9t7DZ09Ua0hTQ37qx6lmjIchpb845zPYPYrBqhXfYqyC24BjE9Ag7sxoGDzQ
         zE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170980; x=1795775780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuX5zcj4UPNO1ikmBe+QANwAm+PZ5dEA+zleB4MI4Kk=;
        b=hHplu7dOiYztnh+8RQkvh0pyy/krMr95Lyln7AboCYEikVLJNBsXLqB3VwxewrNjji
         rR7qVupc24/jQoETrEpcW21s3eirib93wYR+Ki5MqDGXn4rDf6Lt4exQsJLZvZAb8wZc
         fFSohcU04KpxACRf/tAgDywXa7kXGlWsjT7pYUJZ9TWkkxWsZl3BugYk7G6fmwzTPrzG
         /CQ4pht5nAozaKoyxOiuyRhCGA0AIWG9iQPsVxzBtdlpBSt8wdV1kQbG3wqZk7vmIoOE
         PHsqo8crGVPxS5Eura/WG38xq0jk7lPpCxit/+w/3ylTgXht+bAsjSx7tHBatyGi6+Zg
         LwlQ==
X-Forwarded-Encrypted: i=1; AL+hErEjid96fxvjtka9oal+KjKbjInBNRt+MSEZBIIMWtRhcL4ab9tLfZWv6ieX9mov+6sJkCmhIiI7SDlYBVmzkw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+alCBix757b0zMyQVkY0UKfQ7J/xtsDvn+zNSe8oo/4FpAx6oL
	P2docrAIsgCxbj9tXPuTA15CpXGYEoieBbzzamjMY4Ol9I/UDHRLdHtlOOm2KyL7Aa3cfETayme
	UaLiQXhkt2AmFC1XMc5TtsPJfOsOcu5ixZBhakzRIQldstXXCQ9E5CE+42fOaQgqcOr6nJg==
X-Gm-Gg: AYBFou1b90RMRT7h28TYbDvj7wXqnQQHhFKQ54ztny0PqhrwYxekBUXtP67n+hyvu2m
	IpPAeOAAg62vZdEfCMxgBfUBbxgmjB1PC+qWkZP2LLR7DjVfRKfkKnvxfHZMxjWv4wMtQcFCoek
	/9640dSYWw4Nw6OZ+vHrVAOF+O/P4nslqc+JRdxeODPm0FY1YJZyJts5/cBkZYIvjijvz6oEUmr
	TST+2MDMD1hZqKILfr2ISeW4Lhyfb2/kHKvkSfm9QXIdmxWjKX6FH1yo8ke3blweaKTveKc1+FQ
	0odbX+an6z7pLOtmR4vp3x7tY0b8T95xO2MJCqkMDOT2fYVi1vNNCRqwyjRkIuSPCYd+2I5fFxL
	aLcczulZ3ATBUCT/6NP0VeHD07sm6wuYReazKv/Isv+aMlRNGhEsrkz3bv6+gkgEtPwQJVohORg
	WF3cUw42YB
X-Received: by 2002:a05:7022:287:20b0:1a1:47b2:5512 with SMTP id a92af1059eb24-1b5568d3d0cmr2508084c88.26.1795170979997;
        Fri, 20 Nov 2026 02:36:19 -0800 (PST)
X-Received: by 2002:a05:7022:287:20b0:1a1:47b2:5512 with SMTP id a92af1059eb24-1b5568d3d0cmr2508034c88.26.1795170979510;
        Fri, 20 Nov 2026 02:36:19 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:36:19 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:16 +0530
Subject: [PATCH v8 4/4] iommu/of: Add support for "iommu-ranges" on a
 device node
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
Message-Id: <20261120-add_iommu_ranges-v8-4-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=4773;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=3u8NUa/qy0yHzef8Ilum7wr9/tHtysHRT9/CPW8PRJk=;
 b=kcvXno4oNL7+KUPZO562NIpdh0WbGdSrqywP901CqDHHI/2C/BmLn0pS6VLBAkN29PzwEU+kE
 JgZRCU/8+S7A0UhaayXO80ZzOuOFCL1RcBnVYilkO0oenfF0L6JGjq/
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX5dEmxJVQS2qH
 xKjq/+TkYqK88VdPjp9gglt3B3LcMbfKeRGsBTzNJXBUjyYABvbezSxh0X4bXKhpC6mdhvauARa
 AJliLuFKEHWhC+ha1Y5ohx5M3gdn8LT2D6oiFOP8Xgv94cFMPHUlwZr5rYy0SR2ZgxWT0kJ+VcZ
 2fNGA8DSuYreq7jJcmuAJY80o62yLMkEn8KYSg6vm4Ur7QniYgmN8JOMVcyv6lEnvnDxI+wd8s+
 ps6kITTw3xk2xkiwymj5/qkVInzJZfKjL1aVW/WbfQJHy933mhMRO+3AHP/eqLu9e1++yiogkkw
 Jh6eaqLWe6ktOrc+1kYP1eQeR84W9C4I1dKq1s4w8Sz7oQ1ABArztt7FYpE9/AAhPGQc/HOaRY/
 ai4UttPLGBEcDttuOU2AZzo6K+2RFA8sVzf4UnYffPaIAWWrYuEP2dNChLMxCrsX7VbrYxPftUX
 IDIFun9k+VqU5blELdA==
X-Proofpoint-GUID: b4M1NVEcQwGBJDcMmhW_TrIWM4oAIRn3
X-Proofpoint-ORIG-GUID: b4M1NVEcQwGBJDcMmhW_TrIWM4oAIRn3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX8ibN94AEtHRh
 ywmK1oi/bLah/66V3aF60dwIn7mAXJtkOWft7a6AEhP3KWv9lv+aKxUmck3vf2lIM/EvWmgEy8b
 /S52qd8VaxoYjD9YXkKm2moSnyS0fvw=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b0022a4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NeORdnCe0LA2B_GC58cA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200042

Reserving an IOVA address using "iommu-addresses" requires it to be
placed in the reserved-memory node. But when "iommu-addresses" is the
only property being described and there is no backing "reg" (i.e. no
actual reserved system memory), it does not really belong under
/reserved-memory. A device IOVA range is specific to its own address
space, and does not describe the system physical memory to make it
qualify under reserved-memory. Given this, place "iommu-addresses"
inside reserved-memory only when it is paired with a "reg", otherwise,
define it within the device own node. It was discussed here:
https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org

Existing "iommu-addresses" property expects a phandle, which does
not make sense when the property is defined within the device node.
"iommu-ranges" was introduced to specify the device specific IOVA ranges
when there is no backing "reg".

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..2ee5490ba3572cd9f2d2b7655cbe93055ac87d03 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -190,6 +190,111 @@ iommu_resv_region_get_type(struct device *dev,
 	return IOMMU_RESV_RESERVED;
 }
 
+/**
+ * of_iommu_derive_resv_regions - derive reserved regions which
+ *                                are outside of iommu-ranges
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list
+ *
+ * A device can describe its own usable IOVA ranges directly on its node
+ * via "iommu-ranges". Everything not under those ranges is derived
+ * as a reserved region so the IOMMU allocator won't use it. Entries may
+ * appear in any order in the property.
+ */
+static void of_iommu_derive_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct of_iommu_range {
+		struct list_head node;
+		phys_addr_t start;
+		phys_addr_t end;
+	} *pos, *new, *next_range;
+	int size, prot = IOMMU_READ | IOMMU_WRITE;
+	struct iommu_resv_region *region;
+	const __be32 *maps, *end;
+	struct list_head *prev;
+	phys_addr_t next = 0;
+	LIST_HEAD(ranges);
+
+	maps = of_get_property(dev->of_node, "iommu-ranges", &size);
+	if (!maps)
+		return;
+
+	end = maps + size / sizeof(__be32);
+
+	while (maps < end) {
+		phys_addr_t iova, iova_end;
+		resource_size_t length;
+
+		maps = of_translate_dma_region(dev->of_node, maps, &iova, &length);
+		if (!maps) {
+			dev_err(dev, "%pOF: failed to parse iommu-ranges\n",
+				dev->of_node);
+			goto exit;
+		}
+
+		if (!length)
+			continue;
+
+		iova_end = iova + length - 1;
+
+		if (iova_end < iova) {
+			dev_err(dev, "%pOF: iommu-ranges overflows address space\n",
+				dev->of_node);
+			goto exit;
+		}
+
+		prev = &ranges;
+		list_for_each_entry(pos, &ranges, node) {
+			if (pos->start > iova)
+				break;
+			prev = &pos->node;
+		}
+
+		new = kmalloc_obj(*new);
+		if (!new)
+			goto exit;
+
+		new->start = iova;
+		new->end = iova_end;
+		list_add(&new->node, prev);
+	}
+
+	if (list_empty(&ranges))
+		return;
+
+	if (of_dma_is_coherent(dev->of_node))
+		prot |= IOMMU_CACHE;
+
+	list_for_each_entry_safe(pos, next_range, &ranges, node) {
+		if (pos->start > next) {
+			region = iommu_alloc_resv_region(next, pos->start - next, prot,
+							 IOMMU_RESV_RESERVED, GFP_KERNEL);
+			if (region)
+				list_add_tail(&region->list, list);
+		}
+
+		if (pos->end >= PHYS_ADDR_MAX - 1)
+			goto exit;
+
+		if (pos->end >= next)
+			next = pos->end + 1;
+
+		list_del(&pos->node);
+		kfree(pos);
+	}
+
+	region = iommu_alloc_resv_region(next, PHYS_ADDR_MAX - next,
+					 prot, IOMMU_RESV_RESERVED, GFP_KERNEL);
+	if (region)
+		list_add_tail(&region->list, list);
+
+exit:
+	list_for_each_entry_safe(pos, next_range, &ranges, node) {
+		list_del(&pos->node);
+		kfree(pos);
+	}
+}
+
 /**
  * of_iommu_get_resv_regions - reserved region driver helper for device tree
  * @dev: device for which to get reserved regions
@@ -264,5 +369,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 			}
 		}
 	}
+
+	of_iommu_derive_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);

-- 
2.34.1

