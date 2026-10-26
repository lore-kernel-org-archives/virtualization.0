Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995884;
	b=qsNKX3lQsr37YsID6VpyGnz+9NZqJbgu3B1inghucvsaA60vOM21V782NZT9zgOItD+z
	 ieVD0pq57DmJf1Tmlxkdo6cm61NlnUrKc5Ebsf862YZsfAt0ZmEbyhCPig03Lp7kCTqgV
	 63EGbmCHWAnwFbkAy457/twaACKY3C5RudYk4PnU2CLprTXcSA5yhIdzbKBrvlUb3TwFv
	 eTX4J8ruh3ZelwbsblsW09SvVelYLobJ6uFeK3TOEiKMureR6gtlF3cMinOGCDTNk3f+S
	 9GBhzjVRpsFIAptoFzisI1GiJP5EE+/OEN9EQ7fICQkjlUP9csw4QPuBBt/0jpF3dSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995884;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ghfaBWLkZdsfExNTUGqygog0Ct4Ic42/RH9IFidFsO0=;
	b=fMCKYVB1z2YbrITIjF+9VxFNPITZnOpzaqO8aThSMof4sEtv5nrnYA6NN8hYd44gVSsn
	 dC0ZCB91tXap1wJPukfTbYZxWZ0B/slOG7ynHWsMC+nAHxKv/+t9xJt0ZVthcHAWFqg2D
	 ntjDzDiXmJzfVox6yV2p0iFGo5ywrTB2PkLUr9FwXpDcK0wL97/4RqX4V0KHUoM04sIDr
	 CRj1A0kRZNPgiQxOMBwPrCpHIebU24xbfv8wuFtkhIUAtsZHfsUA1FgqC7HqBkSVq9D8h
	 NetAw8+KAK2SJ1TPxFPdcL38ZS8uIDwC6mncOH+RMDsNw19Dnf0oIKOf3Yo6obozn9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nKtifuI5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G5UqmFEv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A8606A321
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nKtifuI5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G5UqmFEv
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4abjp2222724
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ghfaBWLkZdsfExNTUGqygog0Ct4Ic42/RH9IFidFsO0=; b=nKtifuI5MlWCdo5J
	ZEmurlx6vTWDEVdpf+Rtc/q4ilPM4NgUVEg29Bh1pziLSENRoWHii7vHPcqIzFeP
	jMP/ofHH9K1EtK9lAwA4CBEdNqgeVfTXAscgyi+zreiBaKrAJzogyivFH3e69YRQ
	sUyvzAwL3l7sfs6Fb4/1D0E4h+C7zQrKcaXYopYBJNt/FeH85F+RWeiLTcklJKnE
	EEVsE5l5SK2pDA36fuXburBLYJMKsxtfZdafENBA3BBHu6bnLSNCIhPpMHvDt3pl
	5HNO1PWY6F8jI5CcwIIDt/7EKLev6Hmb7gYCCKgF2devRNp8agtkEbXgRzeEpAUv
	Envumg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd8tyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:24:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9d52f684fso26908025ad.2
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995882; x=1793600682; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghfaBWLkZdsfExNTUGqygog0Ct4Ic42/RH9IFidFsO0=;
        b=G5UqmFEv0s1o6Paj3TCcMHX4Qw6PguK+oBsN/G9YtAOdTjD7irUufFZlVDXpxgtors
         S6rh1HhM3PQ1FZac1mI4Bsfhvdf+sh+hltNmY+ijsI7sTjm/k/NCVPueS4HHAqbRW8kX
         +tC3Ozx/mKSxrkrTLPVC1bqzZmMqjTn61aMFAQ5aoW2s3ykwkPYg/+pN12RlUTitVo1l
         MShzRA5zS5oNhthe2PKLpE6neUNM/vOiUaET6wSFT6tuy+0tGyuKVUGpKLr4Jbz0buCi
         lO7PlOax8rFS3XAoCU20FXQVAYJuGnOCvoa8GlvWEy+2hlb7I1XFia1wimvnzt1/scMJ
         v6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995882; x=1793600682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghfaBWLkZdsfExNTUGqygog0Ct4Ic42/RH9IFidFsO0=;
        b=opd1qA3/uxkQl0HZjg/HSGTdx0tilTeFYUVAMAjREHgY91ZhwErcEHZ7jUZMa7htct
         UOFHzSZgMvnUIOT1Ttr2rCgvi6HImU3AZKJfSpXXgb7t1iW5BVOdRpbT7gNw9DDad1E5
         jvJS3yYCnBjfsw8jKE0ZBL1kEi/KEDReO8Id5bHPtRHBG4tQ5Bn6AcCbM0KIhemboBrD
         9IRrpIzorc9Z+h0OC0/pY9zsJldtyW77Kd2YCPnyYksj4A5odLVubhMiAy4LsvwsH7nu
         v0Foppb9waYGuUdcXgqgRU/2tfZGv7J9dXCdZl6WXds3h8moPMIE5081z4+U0LQMSdfT
         qMnw==
X-Forwarded-Encrypted: i=1; AKwUvBwwOSHMHaGi6QPkjRmaFXsc6hlV0dlHrZhAUVqwh9pgiL9OwnhT7+EST0wzmamw2ZTDHHTreH2FGaadYtRcAw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKfEdofeQRI5ZsreGD/ovzDCUTYR9BRnY8X5ico5j2RQrgler+9
	612qPLwlzYZ5UwqVAr+XE7AxpHu/gAPWr1JMf6pUDdmzNTc/OPSereuNA3NSQcyIABeFFWm6MIa
	lNulq9xKrgy12MA6cZL6E43mAMAOsXO0vCiulSi0utwHejYdnVKsKDuRAWal1kV3pAX6ReA==
X-Gm-Gg: AYBFou2EK4NK3hT1ffhh6IrVl/L/QsMQexMzxYFk46JB42F1EjOtTcv2gx2pk7G52Sq
	GuXKBI/KdiCe/lgBBsq9pO8eUM2iEBjNJJaZ0CmRMRIrEl6i1uKpeN7i2MAEcttrEzxk1boyvIB
	H7nmacfCRHJNYImYLCmSA0rtS52YcZJXrJABPYO77dj3TbGzhDlDLTqyS0GWDEe2nIZ3tGqjgLK
	yrqZgG6Jn249gbf53dbp1B3PYWvHxQhaQMP/fYJ1dfEMRUC2BHmMtFn8oWMkM0qfcicSfeJUx7a
	D79G3e/U12/X92dnvTpt0HDgfZNRXBBv+1NN9ey8TUFeIW7nEfvVgqpRKZ5JBU2JVeIGI08Qnah
	cNNPDkFbp2goVpW7S6l8oVuvpCOXDMJB0sQ==
X-Received: by 2002:a17:902:d486:b0:2e3:1776:278f with SMTP id d9443c01a7336-2ea9c876327mr49835735ad.42.1792995881735;
        Sun, 25 Oct 2026 23:24:41 -0700 (PDT)
X-Received: by 2002:a17:902:d486:b0:2e3:1776:278f with SMTP id d9443c01a7336-2ea9c876327mr49835295ad.42.1792995881136;
        Sun, 25 Oct 2026 23:24:41 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:24:40 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:27 +0530
Subject: [PATCH v2 17/23] drm/msm/dcp: Register DCP display pipeline
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-17-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=18889;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=hr6hkKPz6nEVUHntKzLpsUaKYOwRP+Hnnn0BXIJCB7o=;
 b=1mo06t1AFDucGADqQuA7kGSNVbpcgWQSOxyJKgH3n9FrVlhkYkbLEbbHdP9IUQLrs5+Lg7cpr
 SCkGTqMbSDLCRoa3P4m5UQDoYVMh733gI6gYAaYHvCd5rSsFrTVvpRd
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: aiPEdQOeowITvfNyKWaoGnxXPUQ4L3tA
X-Proofpoint-GUID: aiPEdQOeowITvfNyKWaoGnxXPUQ4L3tA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX0zE5gLivvEcc
 G6BriFAAqLtlskr1W7lLEP0CGh6gn+WTa3N42cAQF1Gn2bHMRunritkk4zzMJksOcnw+9AS84iI
 30Z0dJTqv7/CuxTI3FJrz3ZDNWdVkYCZDRNxpNOTDLSJ+TGWeU0gcEc/adO8w2PnM4Yq1dZOwAs
 9vf3pfOE8/KDVSEjnO2Bz11hMJHl0OaVqQCe9Tbm6/73x78PCzIqj7hm3aFq3xqoO8ZHlrsl9yx
 dkFBiR9ps9kpdgXtgJFTdde2YNWMPVk/dmmoPCjZ8kfINJdjhvRaoDFgA4Hbm6rggk8OMYDJehS
 L4khgetlQWk8HlXGTMxd6gjlJv91sLP2c7xd8635+dX7na6CmX8Dd1O4AGyPc4H7woO0bJpKuym
 wye32YxIa1JCh1lZSfuxSmlygqRrbwX7gfsSLOhCWHwIe4Azgfgla/DRfZLXKkpIJNJ/6piOQWx
 JX8bEls5GbiJZWPYSLw==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adef22b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bYrMkLCSNY_9vvF2WuwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX88r9Uc64xD+G
 4gPJFyVHhQ+g//XLHUkrmoT09UXb2xTKQo1SGH7L9phNTOuBUDV8adte47Kbh5HChjv5N9u/Ext
 N0tJlFe3tfLyrQnCVK0GkvQo0bBStn8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Register the DCP display pipeline from firmware capabilities and
the device-tree display graph. DCP exposes display resources through
firmware rather than host-visible display registers, so KMS objects
cannot be registered from a static hardware catalog alone.

Integrate power and IOMMU setup, parse capabilities and display
graph data, and create the DRM planes, CRTCs, encoders, bridges,
and connectors used by the DCP backend.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c | 625 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h |   3 +
 2 files changed, 628 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
index 61a4d8565359..8a73a99b2c76 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
@@ -4,10 +4,29 @@
  * DCP KMS driver.
  */
 
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_of.h>
+#include <drm/drm_plane.h>
+
+#include "msm_drv.h"
+#include "msm_gem.h"
+#include "msm_kms.h"
 
 #include "dcp_dpu_kms.h"
 #include "dcp_dsi_bridge.h"
+#include "dcp_crtc.h"
+#include "dcp_drv.h"
+#include "dcp_encoder.h"
+#include "dcp_hfi.h"
+#include "dcp_plane.h"
 
 int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
 				     struct drm_crtc *crtc)
@@ -59,3 +78,609 @@ bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dcp_kms,
 
 	return false;
 }
+
+void dcp_dpu_kms_cleanup_bridges(struct dcp_dpu_kms *dcp_kms)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		if (!dcp_kms->dsi_bridge[i])
+			continue;
+
+		dcp_dsi_bridge_cleanup(dcp_kms->dsi_bridge[i]);
+		dcp_kms->dsi_bridge[i] = NULL;
+	}
+}
+
+static void dcp_dpu_kms_dump_caps(struct dcp_dpu_kms *dcp_kms)
+{
+	const struct dcp_caps *caps = dcp_kms->caps;
+	u32 i;
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: hw=%u.%u fw=%u displays=%u\n",
+		       caps->dcp_hw_rev, caps->hw_rev, caps->fw_rev,
+		       caps->num_displays);
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: max_planes=%u max=%ux%u\n",
+		       caps->max_planes, caps->max_width, caps->max_height);
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: VIG pipes=%u virt=%u\n",
+		       caps->num_vig_pipes, caps->virt_vig_count);
+	for (i = 0; i < min_t(u32, caps->num_vig_pipes,
+			      DCP_MAX_SSPP_COUNT); i++)
+		drm_dbg_driver(dcp_kms->dev, "DCP caps: VIG[%u] pipe=%u r1=%u\n", i,
+			       caps->vig_pipe_ids[i], caps->vig_r1_indices[i]);
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: DMA pipes=%u virt=%u\n",
+		       caps->num_dma_pipes, caps->virt_dma_count);
+	for (i = 0; i < min_t(u32, caps->num_dma_pipes,
+			      DCP_MAX_SSPP_COUNT); i++)
+		drm_dbg_driver(dcp_kms->dev, "DCP caps: DMA[%u] pipe=%u r1=%u\n", i,
+			       caps->dma_pipe_ids[i], caps->dma_r1_indices[i]);
+
+	drm_dbg_driver(dcp_kms->dev, "DCP caps: DSI count=%u\n", caps->dsi_count);
+}
+
+static int dcp_dpu_kms_hw_init(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_device *dev = dcp_kms->dev;
+	struct drm_gpuvm *vm;
+	unsigned int i;
+	int ret;
+
+	kms->irq = IRQ_NOTCONNECTED;
+	dev->mode_config.cursor_width  = 512;
+	dev->mode_config.cursor_height = 512;
+
+	ret = pm_runtime_resume_and_get(dcp_kms->pm_dev);
+	if (ret < 0) {
+		drm_err(dev, "failed to enable power: %d\n", ret);
+		return ret;
+	}
+
+	vm = msm_kms_init_vm(dev, NULL);
+	if (IS_ERR(vm)) {
+		drm_err(dev, "SMMU/IOMMU init failed: %pe\n", vm);
+		ret = PTR_ERR(vm);
+		goto err_cleanup;
+	}
+	kms->vm = vm;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		if (!dcp_kms->dsi_bridge[i])
+			continue;
+
+		ret = dcp_dsi_bridge_map_buffers(dcp_kms->dsi_bridge[i]);
+		if (ret) {
+			drm_err(dev, "failed to map DSI%u DCS buffers: %d\n", i, ret);
+			goto err_cleanup;
+		}
+	}
+
+	if (!dcp_kms->hfi) {
+		drm_err(dev, "HFI unavailable, cannot initialize DCP KMS\n");
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
+	if (!dcp_kms->caps) {
+		drm_err(dev, "DCP caps unavailable, cannot initialize DCP KMS\n");
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
+
+	dcp_dpu_kms_dump_caps(dcp_kms);
+
+	dev->mode_config.min_width  = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_width  = max(dcp_kms->caps->max_width,
+					  dcp_kms->caps->max_height);
+	dev->mode_config.max_height = dev->mode_config.max_width;
+	dev->max_vblank_count = 0xffffffff;
+	dev->vblank_disable_immediate = true;
+
+	ret = dcp_dpu_drm_obj_init(dcp_kms);
+	if (ret) {
+		dev_err_probe(dev->dev, ret, "DRM object init failed\n");
+		goto err_cleanup;
+	}
+
+	pm_runtime_put_autosuspend(dcp_kms->pm_dev);
+	drm_dbg_driver(dev, "DCP hw_init complete\n");
+	return 0;
+
+err_cleanup:
+	for (i = 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
+		if (dcp_kms->dsi_bridge[i])
+			dcp_dsi_bridge_unmap_buffers(dcp_kms->dsi_bridge[i]);
+	}
+
+	if (kms->vm) {
+		struct msm_gem_vm *msm_vm = to_msm_vm(kms->vm);
+
+		if (msm_vm->mmu && msm_vm->mmu->funcs->detach)
+			msm_vm->mmu->funcs->detach(msm_vm->mmu);
+		drm_gpuvm_put(kms->vm);
+		kms->vm = NULL;
+	}
+	pm_runtime_put_autosuspend(dcp_kms->pm_dev);
+	return ret;
+}
+
+static void dcp_dpu_kms_enable_commit(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dcp_kms->pm_dev);
+	if (ret < 0) {
+		dcp_kms->commit_pm_active = false;
+		drm_err_ratelimited(dcp_kms->dev,
+				    "pm_runtime_resume_and_get failed: %d\n",
+				    ret);
+		return;
+	}
+
+	dcp_kms->commit_pm_active = true;
+}
+
+static void dcp_dpu_kms_disable_commit(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+
+	if (dcp_kms->commit_pm_active) {
+		pm_runtime_put_autosuspend(dcp_kms->pm_dev);
+		dcp_kms->commit_pm_active = false;
+	}
+}
+
+static int dcp_dpu_kms_check_mode_changed(struct msm_kms *kms,
+					  struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_crtc_state, *old_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+		if (!new_crtc_state->active)
+			continue;
+		new_crtc_state->planes_changed = true;
+	}
+
+	return 0;
+}
+
+static void dcp_dpu_kms_flush_commit(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dcp_kms->dev, crtc, crtc_mask) {
+		if (!crtc->state || !crtc->state->active)
+			continue;
+		dcp_crtc_commit_kickoff(crtc);
+	}
+}
+
+static void dcp_dpu_kms_wait_flush(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dcp_kms->dev, crtc, crtc_mask)
+		dcp_crtc_wait_for_commit_done(crtc);
+}
+
+static void dcp_dpu_kms_complete_commit(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dcp_kms->dev, crtc, crtc_mask)
+		dcp_crtc_complete_commit(crtc);
+}
+
+static int dcp_dpu_kms_enable_vblank(struct msm_kms *kms, struct drm_crtc *crtc)
+{
+	return dcp_crtc_vblank(crtc, true);
+}
+
+static void dcp_dpu_kms_disable_vblank(struct msm_kms *kms,
+				       struct drm_crtc *crtc)
+{
+	dcp_crtc_vblank(crtc, false);
+}
+
+static void dcp_dpu_kms_destroy(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+
+	dcp_dpu_kms_cleanup_bridges(dcp_kms);
+
+	if (kms->vm) {
+		struct msm_gem_vm *msm_vm = to_msm_vm(kms->vm);
+
+		if (msm_vm->mmu && msm_vm->mmu->funcs->detach) {
+			drm_dbg_driver(dcp_kms->dev,
+				       "detaching IOMMU domain from dcp-dpus\n");
+			msm_vm->mmu->funcs->detach(msm_vm->mmu);
+		}
+
+		drm_gpuvm_put(kms->vm);
+		kms->vm = NULL;
+	}
+
+	if (dcp_kms->rpm_enabled) {
+		pm_runtime_disable(dcp_kms->pm_dev);
+		dcp_kms->rpm_enabled = false;
+	}
+
+	msm_kms_destroy(&dcp_kms->base);
+}
+
+static void dcp_dpu_kms_irq_preinstall(struct msm_kms *kms) {}
+static void dcp_dpu_kms_irq_uninstall(struct msm_kms *kms) {}
+
+static irqreturn_t dcp_dpu_kms_irq(struct msm_kms *kms)
+{
+	return IRQ_NONE;
+}
+
+static void dcp_dpu_kms_snapshot(struct msm_disp_state *disp_state,
+				 struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(kms);
+
+	drm_dbg_driver(dcp_kms->dev,
+		       "DCP snapshot: max %ux%u\n",
+		       dcp_kms->caps->max_width,
+		       dcp_kms->caps->max_height);
+}
+
+const struct msm_kms_funcs dcp_dpu_kms_funcs = {
+	.hw_init            = dcp_dpu_kms_hw_init,
+	.irq_preinstall     = dcp_dpu_kms_irq_preinstall,
+	.irq_uninstall      = dcp_dpu_kms_irq_uninstall,
+	.irq                = dcp_dpu_kms_irq,
+	.enable_commit      = dcp_dpu_kms_enable_commit,
+	.disable_commit     = dcp_dpu_kms_disable_commit,
+	.check_mode_changed = dcp_dpu_kms_check_mode_changed,
+	.flush_commit       = dcp_dpu_kms_flush_commit,
+	.wait_flush         = dcp_dpu_kms_wait_flush,
+	.complete_commit    = dcp_dpu_kms_complete_commit,
+	.enable_vblank      = dcp_dpu_kms_enable_vblank,
+	.disable_vblank     = dcp_dpu_kms_disable_vblank,
+	.destroy            = dcp_dpu_kms_destroy,
+	.snapshot           = dcp_dpu_kms_snapshot,
+};
+
+static u32 dcp_dpu_kms_resolve_fw_display_id(struct dcp_dpu_kms *dcp_kms,
+					     u32 intf_idx)
+{
+	const struct dcp_caps *caps = dcp_kms->caps;
+	u32 count;
+	const u32 *ids;
+	u32 id;
+
+	count = caps->dsi_count;
+	ids = caps->dsi_indices;
+
+	if (intf_idx >= count) {
+		drm_err(dcp_kms->dev,
+			"DSI%u: no catalog entry (%u)\n", intf_idx, count);
+		return U32_MAX;
+	}
+
+	id = ids[intf_idx];
+
+	if (id > 0xFF) {
+		drm_err(dcp_kms->dev,
+			"DSI%u: catalog id 0x%x exceeds 8-bit range\n",
+			intf_idx, id);
+		return U32_MAX;
+	}
+
+	return id;
+}
+
+int dcp_dpu_kms_init_dsi_bridges(struct dcp_dpu_kms *dcp_kms,
+				 struct component_match **matchptr)
+{
+	struct device_node *dpu_np = dcp_kms->dpus_np;
+	struct device_node *ep_np, *dsi_np, *child_np;
+	struct of_endpoint ep;
+	int ret;
+
+	for_each_of_graph_port(dpu_np, port_np) {
+		u32 dsi_idx, fw_display_id;
+		struct drm_bridge *bridge;
+
+		ep_np = of_get_next_child(port_np, NULL);
+		if (!ep_np)
+			continue;
+
+		ret = of_graph_parse_endpoint(ep_np, &ep);
+		of_node_put(ep_np);
+		if (ret)
+			continue;
+
+		dsi_idx = ep.port;
+		if (dsi_idx >= ARRAY_SIZE(dcp_kms->dsi_bridge))
+			return -E2BIG;
+
+		if (dcp_kms->dsi_bridge[dsi_idx])
+			continue;
+
+		dsi_np = NULL;
+		for_each_available_child_of_node(dpu_np, child_np) {
+			u32 reg;
+
+			if (!of_node_name_prefix(child_np, "dsi") ||
+			    of_property_read_u32(child_np, "reg", &reg) ||
+			    reg != dsi_idx)
+				continue;
+
+			dsi_np = of_node_get(child_np);
+			break;
+		}
+		of_node_put(child_np);
+		if (!dsi_np)
+			return -ENODEV;
+
+		fw_display_id =
+			dcp_dpu_kms_resolve_fw_display_id(dcp_kms, dsi_idx);
+		if (fw_display_id == U32_MAX) {
+			of_node_put(dsi_np);
+			return -EINVAL;
+		}
+
+		bridge = dcp_dsi_bridge_init(dcp_kms, dsi_np, dpu_np,
+					     ep.port, dsi_idx, fw_display_id);
+		if (IS_ERR(bridge)) {
+			ret = PTR_ERR(bridge);
+			of_node_put(dsi_np);
+			return ret;
+		}
+
+		dcp_kms->dsi_bridge[dsi_idx] = to_dcp_dsi_bridge(bridge);
+		drm_of_component_match_add(dcp_kms->pm_dev, matchptr,
+					   component_compare_of, dsi_np);
+		of_node_put(dsi_np);
+	}
+
+	return 0;
+}
+
+static int dcp_dpu_kms_setup_bridges(struct dcp_dpu_kms *dcp_kms,
+				     struct device_node *dpu_np)
+{
+	struct drm_device *dev = dcp_kms->dev;
+	struct device_node *ep_np, *remote_np;
+	struct of_endpoint ep;
+	struct drm_encoder *encoder;
+	struct drm_bridge *bridge;
+	struct drm_connector *connector;
+	int ret = 0;
+	int dsi_idx = 0;
+
+	for_each_of_graph_port(dpu_np, port_np) {
+		ep_np = of_get_next_child(port_np, NULL);
+		if (!ep_np)
+			continue;
+
+		ret = of_graph_parse_endpoint(ep_np, &ep);
+		if (ret) {
+			of_node_put(ep_np);
+			continue;
+		}
+
+		remote_np = of_graph_get_remote_port_parent(ep_np);
+		of_node_put(ep_np);
+		if (!remote_np)
+			continue;
+
+		if (!of_device_is_available(remote_np)) {
+			of_node_put(remote_np);
+			continue;
+		}
+
+		dsi_idx = ep.port;
+		if (dsi_idx >= ARRAY_SIZE(dcp_kms->dsi_bridge)) {
+			of_node_put(remote_np);
+			drm_err(dev, "too many DSI outputs\n");
+			ret = -E2BIG;
+			goto out;
+		}
+
+		drm_dbg_driver(dev, "port@%u: DSI bridge intf_idx=%u\n",
+			       ep.port, dsi_idx);
+		if (!dcp_kms->dsi_bridge[dsi_idx]) {
+			of_node_put(remote_np);
+			drm_err(dev, "port@%u: no DSI host for index %u\n",
+				ep.port, dsi_idx);
+			ret = -ENODEV;
+			goto out;
+		}
+		bridge = &dcp_kms->dsi_bridge[dsi_idx]->bridge;
+
+		of_node_put(remote_np);
+
+		encoder = dcp_encoder_init(dev, DRM_MODE_ENCODER_DSI);
+		if (IS_ERR(encoder)) {
+			ret = PTR_ERR(encoder);
+			drm_err(dev, "encoder init failed: %d\n", ret);
+			goto out;
+		}
+
+		ret = drm_bridge_attach(encoder, bridge, NULL,
+					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (ret) {
+			if (ret == -EPROBE_DEFER) {
+				drm_dbg_driver(dev,
+					       "port@%u bridge deferred; panel not ready\n",
+					       ep.port);
+				goto out;
+			}
+			drm_err(dev, "bridge attach failed: %d\n", ret);
+			goto out;
+		}
+
+		connector = drm_bridge_connector_init(dev, encoder);
+		if (IS_ERR(connector)) {
+			ret = PTR_ERR(connector);
+			drm_err(dev, "bridge connector init failed: %d\n", ret);
+			goto out;
+		}
+	}
+
+out:
+	if (ret)
+		dcp_dpu_kms_cleanup_bridges(dcp_kms);
+	return ret;
+}
+
+static int dcp_dpu_setup_pipeline(struct dcp_dpu_kms *dcp_kms,
+				  struct device_node *dpu_np)
+{
+	struct drm_device *dev = dcp_kms->dev;
+	struct drm_plane *primary_planes[DCP_DPU_MAX_CRTCS];
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	int primary_idx = 0;
+	int max_crtc_count;
+	int total_planes;
+	int i, ret;
+
+	ret = dcp_dpu_kms_setup_bridges(dcp_kms, dpu_np);
+	if (ret)
+		return dev_err_probe(dev->dev, ret, "bridge setup failed\n");
+
+	max_crtc_count = 0;
+	drm_for_each_encoder(encoder, dev)
+		max_crtc_count++;
+
+	max_crtc_count = min(max_crtc_count, DCP_DPU_MAX_CRTCS);
+	max_crtc_count = min_t(int, max_crtc_count,
+			       dcp_kms->caps->num_displays);
+	max_crtc_count = min_t(int, max_crtc_count,
+			       ARRAY_SIZE(dcp_kms->dsi_bridge));
+
+	total_planes = min_t(int, dcp_kms->caps->max_planes,
+			     DCP_DPU_MAX_CRTCS * DCP_DPU_MAX_PLANES);
+
+	for (i = 0; i < total_planes; i++) {
+		enum drm_plane_type type;
+		unsigned long possible_crtcs;
+
+		possible_crtcs = ((1UL << max_crtc_count) - 1)
+				 << dev->mode_config.num_crtc;
+
+		if (primary_idx < max_crtc_count)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
+
+		plane = dcp_plane_init(dev, U32_MAX, type, possible_crtcs);
+		if (IS_ERR(plane)) {
+			ret = PTR_ERR(plane);
+			drm_err(dev, "plane init failed: %d\n", ret);
+			goto err_cleanup_bridges;
+		}
+
+		if (type == DRM_PLANE_TYPE_PRIMARY)
+			primary_planes[primary_idx++] = plane;
+	}
+
+	max_crtc_count = min(max_crtc_count, primary_idx);
+
+	dcp_kms->num_crtcs = 0;
+	for (i = 0; i < max_crtc_count; i++) {
+		u32 display_id;
+
+		if (!dcp_kms->dsi_bridge[i]) {
+			drm_err(dev, "missing DSI bridge for CRTC%u\n", i);
+			ret = -ENODEV;
+			goto err_cleanup_bridges;
+		}
+
+		display_id = dcp_kms->dsi_bridge[i]->fw_display_id;
+		if (dcp_dpu_kms_get_crtc(dcp_kms, display_id)) {
+			drm_err(dev, "duplicate firmware display ID %u\n",
+				display_id);
+			ret = -EINVAL;
+			goto err_cleanup_bridges;
+		}
+
+		crtc = dcp_crtc_init(dcp_kms, primary_planes[i],
+				     display_id);
+		if (IS_ERR(crtc)) {
+			ret = PTR_ERR(crtc);
+			drm_err(dev, "CRTC init failed: %d\n", ret);
+			goto err_cleanup_bridges;
+		}
+		dcp_kms->crtcs[dcp_kms->num_crtcs].crtc = crtc;
+		dcp_kms->crtcs[dcp_kms->num_crtcs++].display_id = display_id;
+	}
+
+	return 0;
+
+err_cleanup_bridges:
+	dcp_dpu_kms_cleanup_bridges(dcp_kms);
+	return ret;
+}
+
+int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms)
+{
+	struct drm_device *dev = dcp_kms->dev;
+	struct device_node *dpus_np = dcp_kms->dpus_np;
+	struct drm_encoder *encoder;
+	int enc_idx = 0;
+	int ret;
+
+	if (!dpus_np) {
+		drm_err(dev, "no DCP subsystem node — cannot create DRM objects\n");
+		return -ENODEV;
+	}
+
+	ret = dcp_dpu_setup_pipeline(dcp_kms, dpus_np);
+	if (ret)
+		return dev_err_probe(dev->dev, ret, "pipeline setup failed\n");
+
+	/* v1 - Encoders map one-to-one to CRTCs; cloning is unsupported. */
+	drm_for_each_encoder(encoder, dev) {
+		encoder->possible_crtcs = BIT(enc_idx);
+		encoder->possible_clones = 0;
+		enc_idx++;
+	}
+
+	drm_dbg_driver(dev,
+		       "DCP KMS: DPU ready — %d CRTCs, %d planes, %d encoders\n",
+		       dev->mode_config.num_crtc,
+		       dev->mode_config.num_total_plane,
+		       dev->mode_config.num_encoder);
+
+	return 0;
+}
+
+int dcp_kms_init(struct drm_device *ddev)
+{
+	struct msm_drm_private *priv = ddev->dev_private;
+	struct dcp_dpu_kms *dcp_kms = to_dcp_dpu_kms(priv->kms);
+	struct dcp_drv *drv = dcp_kms->drv;
+
+	dcp_kms->dev = ddev;
+	if (drv) {
+		drv->kms = dcp_kms;
+		dcp_kms->pm_dev = &drv->dcp_subsystem_dev->dev;
+	}
+
+	if (!dcp_kms->hfi)
+		return -ENODEV;
+	if (!dcp_kms->caps)
+		return -ENODEV;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
index 333567a78ad7..857ff211e0aa 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
@@ -50,6 +50,9 @@ int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
 				     struct drm_crtc *crtc);
 
 int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms);
+void dcp_dpu_kms_cleanup_bridges(struct dcp_dpu_kms *dcp_kms);
+int dcp_dpu_kms_init_dsi_bridges(struct dcp_dpu_kms *dcp_kms,
+				 struct component_match **matchptr);
 extern const struct msm_kms_funcs dcp_dpu_kms_funcs;
 int dcp_kms_init(struct drm_device *ddev);
 

-- 
2.43.0

