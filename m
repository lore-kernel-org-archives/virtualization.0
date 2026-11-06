Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985333;
	b=CPNlgr82+RwW0f9tYPvi8cH19SogkkdffazhyHL1xipvb41khLjDprQwOPW9yEfPfuq0
	 t7PbYEIQ5louljw6C9gk9lDeihwvnubEtF/5k1MlAroGFjVO+oyUtbk9QaM3LEOqzjm3G
	 SMfO3OKiVYqa9BbN10xqKG/qFcx7lILRocYaLWhzqNwrHVdfYz4/2s+aVzU7Lzg9SlMYW
	 p9wf6EqHNET9izVRbDQT9IC315YUypMAMbQJBVY5p9SfLdkXbDKdT1ip2EQsdJLrfZVYZ
	 EMQuBfb1O8IM9OfTtgh5aVWUI5o/MqU/heK3o00PImc6UiX7GW7VcqtAFuTcyetNi9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
	b=JlVCl8UwYOm0RPsj9YdRJK5s1AHtogXc2xtnbcfhtSJN3IXpKYb0Hb80N75mNc7aDGmQ
	 I4ZQ9vecxT2Hxv7FAEuUQLQtClfa4/1YV4iA0x/2brTypJd1FzFtFplqFTLN62hWl9uR0
	 lVdWgLPGt0XRr8dtAEdn3r6yf1ruNbYrWL4/jZAVES7DOSxV0wNqzygDFOwsT7ljQpBKr
	 5OQEadwberamI5Wr+mw5xdrmCtT/msO4mRWk/AkmMj57OvGWDz/pPgFmLneW8TL3ylttg
	 LvagbGNZj7U97FxjWfvCFSXtOKHK7JYTFet0HKRdna1l7O0ORYFMIaW1zB2ml9xTmEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3vtkPAE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NBo+Gnz8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469EF606D803
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 469EF606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3vtkPAE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NBo+Gnz8
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F0LKH687878
	for <virtualization@lists.linux.dev>; Fri, 6 Nov 2026 17:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=; b=P3vtkPAEC2OU1b00
	o9yuEbq8a96oHz1CCQpEWhumD+JCXfrJVBaEIxKLCybmx//oe5RQ+4TB3R4RicYA
	x8TZSJGyfPSH1nDyG03f5E9JggRSUiS7uCxRXY7ILjVYOpxMvG4rRGUMLRaa5bP5
	UuDfaHXj9CtyeReUgmTt/+k92RDns0w8pGXjAknEiMN2jU1c9TcBu72fo9zzYHa0
	GzK/JZh+EJuGhzj/k7it8UPWJ1+AiDsiyf0DcvT3Rl8QRCcBVcoqnvnBA2awSEyR
	mzl5nimqZk+9pnEZH+xGfOExCks0/mVlm+SA7Bcirbuk6TlcOj5YWpvNTsTgUNHC
	60f7hA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb3tma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 17:15:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f1e7d9d4dso1730293eec.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 09:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985331; x=1794590131; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
        b=NBo+Gnz8wQNJ1SDPkGVY+qDy8qD4fr+h7DDSne6UY3uDAYKbv0bUc+X4PdPywcDKL6
         Im0k8gqUgIg2fDepo8vp9mYvQn2oQ8htuESuGOBsfcqskyLOzmlijWaXc2eSyaojxsyl
         bcRfFCY/hosfNJRREokLvQFaah804xxqgCEWUy7eqKu/tGm7yWFUoGfbJhlIPdltjqb8
         BPB9Wl1j62xsEGzzzvSj970qhJiHT3KGhG9NP7qnwuY4eggcq09j4Ur2hKgOupmmlJ1j
         ymbs4JNMEnlzplWCrq52H1Rf0WOT25IyXXIQN8AGKb9/igc9pcQQkG/c7WfQuxuHkQYe
         bPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985331; x=1794590131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
        b=jGn7IskTwEB6sdjEZFhHc62LKc19HtUzBQ3mtuRBAo/VPA7Yxu3noe376zMLAGmwN+
         Tuvt7+XMSy6GhHiirIZlnGeO1WwzPH0oV3bjRvr2v72o3g6glAn0stE4b0yWR742l4xj
         WjtWwnZa5PBPUMdnAmjeB0pSrErQTk6lSIc9ar9wKACGkBRuTxrVvENCrPHm53wI+J0w
         LTqpz+05HdWJF92n3qZlXJcrP1YZiRHj6kYFwUohpTY8YK9z/4ibsUanCIZZbgd6BWCc
         TXXi441trN7pwBDsrnI49EL4obZ3Wab8A1MvzZBd9gsEWMGBZO80Zl3kS66wlOW7K3Sw
         1qNg==
X-Forwarded-Encrypted: i=1; AL+hErGDctDRIE6nGxKGevRWRft7027HAxEJSf9YWkSXbLZh4qGeHtgJ951W1tqFUEtlHoYQM+cxUR1ST9wcwlBjWw==@lists.linux.dev
X-Gm-Message-State: APuU4Z84qMAwBSCF0WtCLhN+elWaU/Joz7CdRaX54nN5Lnvz432rIjSQ
	x3NKDGwCiEeq6edaaYfXJg/zBWepAJbzi8ZP0ZkHebNm3ztASbqmd2VNDuJEgnicuCHrW0oaI18
	PQB6keScCL6HbJruFmjPjWNsPL7lWg+pBLfhM0HH/UWEVq1w4FDriQlRtSgdfYOeaD40jaQ==
X-Gm-Gg: AYBFou3X8wP8puIMfkY5VzpGkGasaqt3pvJwimNQkeW6qi6qdZ21YCuXVvVYDWcO31H
	L0b0nmfN48/WN6KyCcai6c6D4cVzyvemXeIJUe5648nvOBQkjY5fCmDonG/VwDSXvA1bIenj8v2
	NzG8QyYzobpOx8Vya57TLzvcTIEK2kPylgK1QoSdRFYpRHPOLou1ZjLxFx9DQD/jaH9MOlT0YvO
	CNZz8rSBnsn0e851JOg1q/aU4DtpYuGTZpyfQjqpAxsyys1Zjb72MMZau5S039+THCgJkep1i9r
	3r7vS3ZwrvUUoUkK+GgDRmL62dtGqeMC6XzA92YnHb2/pUuB4BtDXKY+coEsriRbbakJvjD9UVS
	3IfJQhfIUEBEZ7oO6gAU88iZU6R60xLdm7oD0PDcjc+qMjbMWuBva9uojj2P+YrC37NFyCZgQ84
	SBwVPkpd+m
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36f76d0f26emr4000267eec.31.1793985330022;
        Fri, 06 Nov 2026 09:15:30 -0800 (PST)
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36f76d0f26emr4000223eec.31.1793985329467;
        Fri, 06 Nov 2026 09:15:29 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:29 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:26 +0530
Subject: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
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
Message-Id: <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=2273;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=NupkmvlL/dCPtTaOqaRQsl8ArnjGwSn52BAlgLqDvzE=;
 b=zmYLfThWfIv3sYXwDsJ6RflfKmCfmALOpmNPBUN8TCisKPeZCWDqMJUW2XSqMOPFsQD3BtSCT
 o8PihuvJzOpAYMe5W/ppgKgNz7pZ2PFLD8vYjYsYkLQ8uPypf6/trFV
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: DYMT8vGx_C7MGByH5FPVhAzVf42d6shA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX8N2r3Z+IbwMb
 R2XMgEH6dvNG4P+mDQvN0uKY/XUbwU02cTR8Mdunsr1dPyArd1MXDVzagZlxWItH3dW745Yds+L
 A6JtYN7e1FqsTA8Qm6G/wkoa/7RN/c0=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aee0b34 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fdurNWXONF6VWYIYtoQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: DYMT8vGx_C7MGByH5FPVhAzVf42d6shA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXz6RyZ+p/PUDN
 tHIv7Z3akPjE5SA3mbgnwA4jCtLH1A3e3NgfpgxtDzvad6Jf0niUAkqckhHUVAhJSdIq2sTLUpt
 P5jtne9bAclHKMU8yR5BjFLwSlckNoivVA0tSsymkuDdvy9JgYPP6ELDxDL9sgW7qTsTLe4l6R3
 piNCC8hbdvj+Y5XKwOCUWpmW21pas0K2UznOrdI7JWkY0SO4G/vNrPcgaOX/Z034XNOOT2lKfjF
 PcS3TzrCc4ILEJgzxd2EiiPUYRIpw4o9rIe+qlMtFpgsu41BKs5T1+BfsrlcN+zz7Cz2oqFyCgr
 Ov0EeX1WV8qh4w8046jBQ4sRtzyqH/YW7hiAONAM81QbG161TdQX8VabhJE+KswcDEyEjBDQhgK
 +kzUw8gfPema5yVu0R2vgpNDPBDDv8gMk+Z9JBVe5EblfQOqUFoNDEqP7yr9cB1xIVYhqx3PyO5
 4XNq6Zdx2gC6k/hKsDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060068

The OF_IOMMU code relies on OF address parsing helpers, but the
dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
annotation to handle configurations where OF_ADDRESS is disabled.

Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
preprocessor guards and __maybe_unused annotation.

The only architecture supporting OF without OF_ADDRESS is SPARC, which
does not use OF_IOMMU, so no functional change is intended.

Suggested-by: Rob Herring <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/Kconfig    | 2 +-
 drivers/iommu/of_iommu.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 85a8d7fdfa30b64e21b8db0db1d5bc268c04f24b..c1e97bd885f933cae45fb7806183477f2d64cd5d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -147,7 +147,7 @@ endchoice
 
 config OF_IOMMU
 	def_bool y
-	depends on OF && IOMMU_API
+	depends on OF_ADDRESS && IOMMU_API
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c266511db78910d6fd221af5437cecff4931c22..6675fc900e6c2d55b34c61dc9effaeb48e24f18f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -167,7 +167,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 	return err;
 }
 
-static enum iommu_resv_type __maybe_unused
+static enum iommu_resv_type
 iommu_resv_region_get_type(struct device *dev,
 			   struct resource *phys,
 			   phys_addr_t start, resource_size_t length)
@@ -203,7 +203,6 @@ iommu_resv_region_get_type(struct device *dev,
  */
 void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
-#if IS_ENABLED(CONFIG_OF_ADDRESS)
 	struct of_phandle_iterator it;
 	int err;
 
@@ -265,6 +264,5 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 			}
 		}
 	}
-#endif
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);

-- 
2.34.1

