Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170974;
	b=nB+ptEoJ+kydQsdutBteLxIDLyP5OVHbdafViQ1VX6ItMaL6HvICpZaqPOivB60jYl4W
	 L/cHLHLzfgJ7jYy6HK0AvVLWURdwtg/vrGjfQpd1Y/gkMqBFtJbL30Bq84wCTR2/MTFth
	 W0FY+U+rLMsiYuV9gToWvAo8NFFsBNV2HvuCq0FAN0rUawlkjmrEfxO4WEBwx5/6wixpQ
	 ZJxlu2FFK96it97bXH3WK+104hFKMuELdToEAv4GoHVSWOhKnWfO/AIbHk9zFLP7IWVrg
	 0rxPexKlPVJrtY+/gh0lT1WvjC29m/tVk3j0eaHBrGOShfpl8yWyPY/UHiQrkyGbtdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=;
	b=Ezu6qBkH8chQh4CJ2uYmxH0QJ8LIqSwztmfDHtOxcCRcODDYFjRRBoeLM6zJC47BBun7
	 sXBf9b46i+9nPtsExuW3xYCGVdTHekk2vOzsRMjyZLIly5I7hg7m3nf7fmTzsFvimRyE8
	 t0CisXF/QSX1WYhqukN5SAt0dqIQEj6fM9UjhCGOEBiWN0szrzVziZl76dUbOt4fBOqtN
	 em8nO1eviXfoHXdirR3c8gZLwPIeDCq0kr/WHfOhqir6mfEp7Vn1ImSe96eCQbzQA0qqY
	 PwYhvwPtNd+xRe+bkwVjrV0FrL1AuNA07gCX3O+D9N5GFqhEcIpFWNPsoZ13SpWjLmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcugcrQR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kgTNc1Z/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D726606A33E
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D726606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcugcrQR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kgTNc1Z/
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7f1fW1112277
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=; b=RcugcrQRpXJG+2cX
	u/yN0UKmUym66Avol2QZZENLLL1C1qiJKsNGUVVpxouxFhIQmcFvVY++uOB1LECj
	K4w5dJCAIb22JuWT3egj5keqXqGvDPqWI+jRISryqqF/WjlkBoCa3jlwmdy7DWHC
	c/RX4OAuwm+gAE7ip2IGZTCHMnMiUteLC9/q31gVzEoDjZsWzQp6bg7jIooQad4d
	4GT7vMoEdeaxiR/9wm+COH53gvxIYiAkTLj5NVZkWZfiMNhLOZhaIhfu8WVt/qoG
	S/SI1ZXKNM7NnLytpNT7PsNq3lSMhXRLyK5cWjcAfnfySlPMiWcHkzdHP00AaMS3
	q76F0Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtscg2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:36:12 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso1745307c88.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170971; x=1795775771; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=;
        b=kgTNc1Z/Y6koXACrISlFqacgTnd0x1rXzoacT8lFF6I8ckRFR5Rz+871cwqfqaY3AL
         AI6bUGcH7RBkdWFCAn/N/xNeclqYFueBFfnsDtq5+rMnRxSklmLx3Cfa/DsC1ClQRjs1
         N0f2+CYhMNLvcQHI97mafL7kXhImvI6yrW2UahyxLuWK6qK4VtwG8dtGYfL6r8Rm39nS
         eiJTA8O2AJf2wgNerAS0op6d0jQlilAqxCnYcrWXdJm9o2RBv1h8UvQCCm0Li7y4I/29
         tS6uJvIj/+h0pYw2LC1yRtohSbY3XYjuzE9ZnrHx1jOsx6cL3gcH9y2OUckEeKK4K+cf
         HXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170971; x=1795775771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=;
        b=EQf7q97A+UIKX+OjVeOJ5aUMJUSgM2VMwlwLLWg8A3H7VAo7BQqX3/iFI5/G7xv1I5
         B24emNLOJtPfjflT8XGQ1ktESwJJlcnPxHf8E7/hbVyx02r5nqzm45lvQJABw+d/u9Xf
         DVTAetMrVAeaWBaWKZuY0SrgraTVnhoqzJtZsbxif152MPgz60XwggaIkaUnAENSBH6A
         Uu6T3Sl5gKNwXKO856cVZ+Fln0QxpyJgNc3gtJwgUpufYJGdHJ4AZZylS2frPNZNJ4VI
         9wp1BjPmVBXVbhLeJwQEhvyFUeq+m5qy6EZ7gvBUNNR9zRbo8iDVNub9z7/ajsRDx5D0
         pEdw==
X-Forwarded-Encrypted: i=1; AL+hErGvPfXskR/SL3cKFrJYkvadDP+vFGdKtivqr4fvS964b06GfPSs17/XUYZxPXS7D+4TV7PsWzLz+C7OsxlnuA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/7GhksTl/xBs+o8D8Hn1GvqDl6d/d+s1FmEla4Q8umuDYbSPYa
	T3erJH//CZjW9VxCiSki7bcgt4AryADTbUWGEsuaXGrZ76Fyo3nUg7VaEMOgDPVIQm2W0u01rHm
	Dg56Fo+vbL65II5KAOMI7iuszlMLg6oP3AWsHkBtn4RlH/zBNrynheLHfavwXfrNFOjQ/eA==
X-Gm-Gg: AYBFou14tU51xd5/EhdN4vwDSUdFSBNmhTxKQsgtaAJ5DYj7ozoDlEN90cXDGbj5iqw
	X5wPPRPx0r1nh6VAGL88bVuIX/fSN1q1AiVQk3sJdh04xUOTv+JKT7FM/b0rymPcicda4/kU3rL
	CXkBfTb1C+qZJVzl59MXKNJPz7MwohffI0tKSWMbHhSgtR8mjPhbKet3t1jL7HM8aSTgZjoLKdJ
	EpfV9qt1eMw9CVD9yy8DkZ27yNXz/elOogoG0wSl2OxGdyvFr3OYVpH53BW6PXfrYx7Dt9Llh+U
	cGDNN3JxDy9pzb0+GYQQMgCmfa6a6DUDdSg3t75hfM2Ah/G35lHEqJLneiTNZqD4TJ4nf3KPJCz
	RwkPt5kJEDkPeJHbgp1vWxIYiiYts0459spFQvF0MibPsj+outC3cz9U70i6LsHQbtax8tTr1Ac
	jH3JYfikA/
X-Received: by 2002:a05:701b:4308:b0:1b5:1a6e:1bec with SMTP id a92af1059eb24-1b5568779e3mr2412522c88.10.1795170971286;
        Fri, 20 Nov 2026 02:36:11 -0800 (PST)
X-Received: by 2002:a05:701b:4308:b0:1b5:1a6e:1bec with SMTP id a92af1059eb24-1b5568779e3mr2412504c88.10.1795170970833;
        Fri, 20 Nov 2026 02:36:10 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:36:10 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:15 +0530
Subject: [PATCH v8 3/4] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
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
Message-Id: <20261120-add_iommu_ranges-v8-3-d90486973b73@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=2526;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=8VtOi8S+vuKc7RA+CVg3aczf+OtltBZNKbr3XIYNYKo=;
 b=xsG659uTuS5o1iuLQ6eSuJqdRUJEN1+bgvkjt7FkqqfPKK37yn8B+cgqpCnZxWeW0JXiteD/n
 7R4lNKjGmyHA0Je7SgBkedvZqTo7tgI93FdK/lauEWxlaoswYRhPRP+
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: 4H_QR2M3SCpOTbRpM5hipVXZKzu61cMe
X-Proofpoint-GUID: 4H_QR2M3SCpOTbRpM5hipVXZKzu61cMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfXxnQQbkV79PeP
 EpuuCSWxuMYpucGfD8RTe8zExFaLFNNUiRwoVIyygM2oiy62EyxpmqH5LwdT7aP22pwSSn1LzLn
 kCWYpeP4kHRzk0r+QaHmE4dtRZDiwSB4IdRQdClqAtDZjlZI2wABZToINFhdHlKJSW8b6wBOnTy
 nfHhezFUdXDDpWTZbzrFmvNSezAEGXTBA/ZcqrYK2nEnLeZsyI4KdjA0Nh82m9tGK5Xdk9oDzMy
 Y7azbHw73sD7Fx6ZEK5hl3iavt2bFcMx1wLbDtdosfX/oQe7x8+TYh0yc9JbkEuGvgs4nhIcTrf
 WnKMp5V/4hjWo6F/me7o7LIJc0lUXfuQlBOMvm+H17ZiRrghkDg2P8mhcaa9n5G+CKVaM7KA/PW
 xS+AGKcg0PykShS+5lH78/4WT2MO7s18qM+qaXxVePUGG8yYpOR8CA4kmYg7gWikFrpfSj9/lpS
 4lnzxlUf2EGgSrrVDow==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6b00229c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ntQ06SF4OG-o5Uha_HkA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX7Li3jym/qzxX
 F097VguRY/fqVnS4Xnb5T/Y/xyBfRFKvih7TO1vvFPxT287TAsTO3A2+e8MvEXskW7SQbulSJZH
 5Uyx1N2nVAOeMvdMU5jNJ2/jgEm6Oks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200042

Currently, the OF_IOMMU code is built when OF and IOMMU_API are enabled.
However, the code also uses OF address parsing helpers, which are only
available when OF_ADDRESS is enabled. Since this dependency is not
expressed in Kconfig, when OF_ADDRESS is disabled the code relies on
CONFIG_OF_ADDRESS guards and a __maybe_unused annotation to avoid
compilation issues.

The only architecture supporting OF without OF_ADDRESS is SPARC, which
does not use OF_IOMMU. Therefore, make the OF_IOMMU code depend on
OF_ADDRESS so that it is built only when the required address parsing
support is available, avoiding the CONFIG_OF_ADDRESS guards and
__maybe_unused annotation in the code. No functional change is intended.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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

