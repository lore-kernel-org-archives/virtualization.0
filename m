Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995787;
	b=mCXTLOdlbnAlhTzIpihltIiFmrR4pnDbNB2oxRo6YcXbUqerrlX38rZXrMGBOwgRE19p
	 2s96pvFZ28tXIugz6M9Ou49fGoqxThA3U9/ZUO4tcK4MkPUOV6xSlpq3EwSqxDQ+Kzhqt
	 pZ9CD/Zvo3kPbrWDkBB/b8nNTfPEQzYCCKiIkljDwl/WJJ/s3rdHR1MzewrGXa3GST/W0
	 X0I5XJ77xNOFzwFyyGdrT5wKSV8LMFlyxgaaQGSVfTUMjjKSCOgE+dsZ7PfX8JRRDypQj
	 OzobUhCo6eDm+XGHu9TBin6a25Ha89FEC4XrYeVCiQNzx+qcyTYNTJWVl/9PKIqWlNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995787;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FOTpEFlT+y/a1rTH+O9UH/+T4QWFtNapc0ipHXawgfI=;
	b=fdhRSNmDvfkcVwdCGoGbkEkJro9jITVCCJWUZ3p9DOntaT21ChNV1T3g4zBw3mjsqWNU
	 ry0YZg34PjnqiXTpwqXcGQHGm6PgD09u9P/DwbfNHlEgvzskCunF0G44qB4Dkk7Jx4fh+
	 /yAgnkKhAhyrAW8ZQPdTjM1zO014QkIXLdIiy/qh1+u7PR4yB6m9SLcFK5Mq7MvWFrnpB
	 WxvhteJWhOVvfkyR0KjwWdQsxmWVu9xDqyyP/JU1h4RpidIqXxgEruIFko/O5RTxKzIGx
	 2GQQOrOvfl5PAVRNkmLsdr/2oyNfTjEFPg8kuANvVVep+T6u5EJ5epMbQfJHcrvLYJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eqq6Xly6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BYhl1RKr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69CD606A322
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69CD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eqq6Xly6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BYhl1RKr
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4adLi2222783
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FOTpEFlT+y/a1rTH+O9UH/+T4QWFtNapc0ipHXawgfI=; b=eqq6Xly6j99rVXxm
	mTMq6xSCi4SVvYsj6gI/WPSO/xQ3S3GU6gaMtmo6Vk6MCg+dNeUJoFzftv+auoIt
	Dy08ozdSZLaxETXhRU5WikzK5iroDhSedoGKCVyFGEaDLMcPZfUOfXFm3CuaguJa
	T0B5KvsRAyxdMnFR4gcC5+VDi1jlyQOaHiTce5Dwcect4a+2VAzt1NxHcQOlvrNl
	pSINbm5NOU8CAVE0VtjzUmo9SbLqMZNTNULAaPeQ3JESGMi2D9DYFG2JZ2O9T8+B
	YNy0LsCNrJhJSNVBB1huy5+oOSL3GO/3OBnzwxqe2RHYdN/k4murgsQ36qeGYanK
	5wkOLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd8tp5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dfb24dfedfso28734245ad.2
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995785; x=1793600585; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOTpEFlT+y/a1rTH+O9UH/+T4QWFtNapc0ipHXawgfI=;
        b=BYhl1RKrPsOlFPvoEjo95pMNLQOj8aKx3y7I2q+rpSPdr7GIhVOpi0ihqlIGDYV+Qs
         9pH2uD93uAXIiLtxqUhmdnoHoX0WzCwd+HQbeC4ZqSj0amPo4fatXt/fkTzGW3edvkm1
         wePguqmMB0A90n8YtSbBp3ei4GnXk26r6ka7PvBpyqvXI+KkkGjVJbSInR+UyqbkM7aN
         gmkIVCfftdNIrUgt41OY2hNYt73cyDyx4/a4sopXLATwg2dc3nN87HASjTbdFtt1CsB+
         TsNzIoYWUlRZ56lrkyqHhKQeoMSaHRmQvZTiqWSVk3fMSvjB8psYPhoPt5XgMRE5mOY3
         ja8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995785; x=1793600585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOTpEFlT+y/a1rTH+O9UH/+T4QWFtNapc0ipHXawgfI=;
        b=AQE4vsewuOhiO8Jw2TdTonXwka0Ss9DQoyRNUfc3e/aV6WfsJWIiXuOEZma5qJpwaL
         JCFwT0QSpIWVSc6JI7y/m1l7xO1z5LnzGiWmbOlpa6ctQUnbC4vaJAWBbVK4VcZhqzfn
         hoUPL18EO39wO20HcSyke4GOHP6n/Fgr0HWKErS5fe9f6+Zrnvte9p4DthPOATmmhnDk
         oCEWT9/dVSrPXte5rSDtS1GrtAXV6rQ8ay8iZJgCnLUSsHHyJHb6z+A54uF50CQIi/pI
         zXF0VpBf4Eg3clyMjJVQZ/TnlojxY5vew/BM83Ilqu/rypZ0bWOgmdeSJTlQstgs5LGX
         UedA==
X-Forwarded-Encrypted: i=1; AKwUvBwCsLd6xVB/XiTwe1jLl6XgAqNb3y2hnzR4dBUM825677latQ5/u/XJ2obDx3x5oMyuj8WDs7XHMhvGMoyqBQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ8lI6Aw6lotLONReQ/cIMV5szBNqpIuHNPuBRQyhVeBwgrUGTb
	B33CNhskiglnzERYMWE81Da3a8Nv7jBS/jZxfggbeCrqoA3n83aYslwNAao3DpSwfuN7R4qA4sk
	HYItYRW2SNEDsGByheuGh92dKd3BeIAusF2apgdNsPT8qOSkr1Y4q3V7xoRNK6x8ckA+kVA==
X-Gm-Gg: AYBFou2LpG0MJQHUh8S58Z1eggOLMbiBKkNiJIYSqSqoJi7SSICMFslfCLVvLMN4HVV
	1tcujZxvwXNMhrJZNhph1DZp/lq+xxux6Nm/Gk5UzQNAifdhl0k0ad9Me/ZVQdLi62KsVFADJJK
	b2c7Cn3xo/QaCPQJwNUJZBWQRTlqaUxbYKcO+Nel1nUFaKakjieXPZQlQ6hYaPej2eIedXjXgP3
	BwZwkItfYMWLWlax00p8m6qfSyG9LuaGPVE9tpebNvA5/P0zR9g+cB7B5RgiRLo5Qlnr6c6Ey+P
	BjMx1lfHmV+ka/1jxaN5hAPDGyWDLIam0X+bOJ4vCz1zywxrQ6qoSKbw7l690xDPvorODqFx5hB
	zX9vf0Kyj0lL6+Fqqzj/ToyYVUVs+gu5qHQ==
X-Received: by 2002:a17:903:3850:b0:2ea:7180:3ab9 with SMTP id d9443c01a7336-2ea9c8afeb4mr48270035ad.43.1792995784638;
        Sun, 25 Oct 2026 23:23:04 -0700 (PDT)
X-Received: by 2002:a17:903:3850:b0:2ea:7180:3ab9 with SMTP id d9443c01a7336-2ea9c8afeb4mr48269755ad.43.1792995784146;
        Sun, 25 Oct 2026 23:23:04 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:23:03 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:18 +0530
Subject: [PATCH v2 08/23] drm/msm/dcp: Add IPCC power notifications
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-8-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=7880;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=ZliBQcpFZc/16J0ivg4K92KJ50R0FEFC7a9oWSS2AUk=;
 b=oeF2+yhu6C0tTEPvS4ijcCGa3EHT1863DUfZIbjiUMBcQ15kbRI0oR2KII+grdry/V7RCxSJT
 3oyw8G3PXx7B2Xb39BRODfFABQmVENPqGVOsWGj/n1PxFxmt+AyeeZ+
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: pXi_ax-409jYsviDEG9i3aU-PMXU1_Lk
X-Proofpoint-GUID: pXi_ax-409jYsviDEG9i3aU-PMXU1_Lk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXwZEnCxN5MF9j
 P/VnxBEOqbncaxcP2UxaqY64tD6OS0UJlEpe5MvCmnKzF4+YxD4/iOdpZwFGGbe/YlXhEvM6Y7j
 bbKQgW+KmA5Rzd0u72tABFfx9v+XMO0639fDgeupCH6IivxsqBbCKcPZJhXcl/D/oPw9uSZJ25v
 8N4PzfIrKUNz1cLjA6bGu7CGcrc1Y4XYgdDk/SS5E6hL3hmZsY8C3fR8lpDM3XiUdVjg6QU9LLW
 hLszZoyRn1x9smsUtk/IA8WaOpG4fmY91GrlnZmYgESvKNhMWJP3QkfHh84ELZlbAiaBx+OCmpU
 cHUv7AdxmmvFu7wdcgpRoySB5pCp61iR4FA5DkBtBQT/l2TX65g9Cjo86tMirafykSQznVfpM51
 Utb/Le1iim4VpvO9CkuGQKLREoYme33dlO4LlwalC6wzAO3Y6O7Kz7EDyRnrObawkoyjTK+WkLq
 iaFJQYrD4Z0rlpL0lFw==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adef1c9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Rkk83rcldGj31tuyXloA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX4ib2sYIfgqjs
 yH52k5w3xP8SC4FojMmVTvCnuxXpzEl7F+uuUtSDlPGt0y2s3rlp8QFmwCRugrcO5IpgTyinAsw
 EjqhSLTOf+ZMQrU+V1y5SmzGrEIbXH0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Wake and acknowledge DCP firmware through the platform IPCC
channel. DCP may power-collapse while VirtIO-MMIO remains accessible,
so a VirtIO queue kick alone cannot reliably wake firmware during
system power transitions.

Implement serialized IPCC notifications, bounded acknowledgment waits,
IRQ wake handling, and teardown-safe callback lifetime management
while leaving HFI data transport on VirtIO.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile       |   1 +
 drivers/gpu/drm/msm/dcp/dcp_drv.h  |   1 +
 drivers/gpu/drm/msm/dcp/dcp_ipcc.c | 173 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_ipcc.h |  42 +++++++++
 4 files changed, 217 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 56c48fe2e2c5..9c698c4f4949 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -73,6 +73,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_core.o \
+	dcp/dcp_ipcc.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
 	dcp/hfi/hfi_utils.o
diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
index 44d9b2cd5171..16f87035cb9a 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 
 #include "dcp_hfi.h"
+#include "dcp_ipcc.h"
 
 struct dcp_dpu_kms;
 
diff --git a/drivers/gpu/drm/msm/dcp/dcp_ipcc.c b/drivers/gpu/drm/msm/dcp/dcp_ipcc.c
new file mode 100644
index 000000000000..e161939dddc1
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_ipcc.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP IPCC power-notify mailbox client.
+ *
+ * The APSS-to-DCP channel must be signaled before a VirtIO queue kick.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/of_irq.h>
+#include <linux/string.h>
+#include <linux/virtio.h>
+
+#include "dcp_ipcc.h"
+
+#define DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS	10000
+
+static void dcp_ipcc_handle_rx(struct dcp_ipcc *ipcc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipcc->state_lock, flags);
+	if (ipcc->shutting_down) {
+		spin_unlock_irqrestore(&ipcc->state_lock, flags);
+		return;
+	}
+
+	complete(&ipcc->power_notify_done);
+	if (ipcc->resp_vq && virtqueue_kick_prepare(ipcc->resp_vq))
+		virtqueue_notify(ipcc->resp_vq);
+
+	spin_unlock_irqrestore(&ipcc->state_lock, flags);
+}
+
+static irqreturn_t dcp_ipcc_power_notify_irq(int irq, void *data)
+{
+	struct dcp_ipcc *ipcc = data;
+
+	dcp_ipcc_handle_rx(ipcc);
+
+	return IRQ_HANDLED;
+}
+
+static void dcp_ipcc_rx_callback(struct mbox_client *cl, void *data)
+{
+	struct dcp_ipcc *ipcc = container_of(cl, struct dcp_ipcc, client);
+
+	dcp_ipcc_handle_rx(ipcc);
+}
+
+static void dcp_ipcc_free_channel(void *data)
+{
+	mbox_free_channel(data);
+}
+
+int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev, unsigned int irq_index)
+{
+	int irq, ret;
+
+	memset(ipcc, 0, sizeof(*ipcc));
+	init_completion(&ipcc->power_notify_done);
+	mutex_init(&ipcc->power_notify_lock);
+	spin_lock_init(&ipcc->state_lock);
+
+	ipcc->client.dev          = dev;
+	ipcc->client.tx_block     = false;
+	ipcc->client.tx_tout      = 0;
+	ipcc->client.knows_txdone = true;
+	ipcc->client.rx_callback  = dcp_ipcc_rx_callback;
+
+	ipcc->power_chan = mbox_request_channel(&ipcc->client, 0);
+	if (IS_ERR(ipcc->power_chan)) {
+		ret = PTR_ERR(ipcc->power_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "IPCC: failed to get DCP power channel: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, dcp_ipcc_free_channel,
+				       ipcc->power_chan);
+	if (ret)
+		return ret;
+
+	irq = of_irq_get(dev->of_node, irq_index);
+	if (irq <= 0)
+		return dev_err_probe(dev, irq ? irq : -EINVAL,
+				    "failed to get required power notify IRQ\n");
+
+	ret = devm_request_irq(dev, irq, dcp_ipcc_power_notify_irq, 0,
+			       "dcp-power-notify", ipcc);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				    "failed to request power notify IRQ %d\n", irq);
+
+	ipcc->power_notify_irq = irq;
+
+	return 0;
+}
+
+void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ipcc->state_lock, flags);
+	if (!ipcc->shutting_down)
+		ipcc->resp_vq = resp_vq;
+	spin_unlock_irqrestore(&ipcc->state_lock, flags);
+}
+
+void dcp_ipcc_deinit(struct dcp_ipcc *ipcc)
+{
+	struct device *dev = ipcc->client.dev;
+	unsigned long flags;
+
+	mutex_lock(&ipcc->power_notify_lock);
+
+	spin_lock_irqsave(&ipcc->state_lock, flags);
+	ipcc->shutting_down = true;
+	ipcc->resp_vq = NULL;
+	spin_unlock_irqrestore(&ipcc->state_lock, flags);
+
+	devm_free_irq(dev, ipcc->power_notify_irq, ipcc);
+	devm_release_action(dev, dcp_ipcc_free_channel, ipcc->power_chan);
+	mutex_unlock(&ipcc->power_notify_lock);
+}
+
+int dcp_ipcc_enable_irq_wake(struct dcp_ipcc *ipcc)
+{
+	return enable_irq_wake(ipcc->power_notify_irq);
+}
+
+void dcp_ipcc_disable_irq_wake(struct dcp_ipcc *ipcc)
+{
+	disable_irq_wake(ipcc->power_notify_irq);
+}
+
+int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc)
+{
+	unsigned long timeout;
+	int ret;
+
+	mutex_lock(&ipcc->power_notify_lock);
+
+	reinit_completion(&ipcc->power_notify_done);
+
+	ret = mbox_send_message(ipcc->power_chan, NULL);
+	mbox_client_txdone(ipcc->power_chan, ret);
+	if (ret < 0) {
+		dev_err(ipcc->client.dev,
+			"IPCC TX: power notify failed: %d\n", ret);
+		goto out_unlock;
+	}
+
+	timeout = wait_for_completion_timeout(&ipcc->power_notify_done,
+					      msecs_to_jiffies(DCP_IPCC_POWER_NOTIFY_TIMEOUT_MS));
+	if (!timeout) {
+		dev_err(ipcc->client.dev,
+			"IPCC power notify acknowledgment timed out\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
+	}
+
+out_unlock:
+	mutex_unlock(&ipcc->power_notify_lock);
+	return ret;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_ipcc.h b/drivers/gpu/drm/msm/dcp/dcp_ipcc.h
new file mode 100644
index 000000000000..2d1ddd5adebb
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_ipcc.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * IPCC power-notify mailbox interface for DCP firmware.
+ *
+ * Channel 5 carries APSS-to-DCP wake notifications; responses arrive through
+ * the mailbox client's RX callback.
+ */
+
+#ifndef __DCP_IPCC_H__
+#define __DCP_IPCC_H__
+
+#include <linux/completion.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+
+struct device;
+struct virtqueue;
+
+struct dcp_ipcc {
+	struct mbox_client client;
+	struct mbox_chan *power_chan;
+	struct virtqueue *resp_vq;
+	struct completion power_notify_done;
+	/* Serializes concurrent power-notify transactions. */
+	struct mutex power_notify_lock;
+	/* Protects callback state and response queue access. */
+	spinlock_t state_lock;
+	bool shutting_down;
+	int power_notify_irq;
+};
+
+int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev, unsigned int irq_index);
+void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq);
+void dcp_ipcc_deinit(struct dcp_ipcc *ipcc);
+int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc);
+int dcp_ipcc_enable_irq_wake(struct dcp_ipcc *ipcc);
+void dcp_ipcc_disable_irq_wake(struct dcp_ipcc *ipcc);
+
+#endif /* __DCP_IPCC_H__ */

-- 
2.43.0

