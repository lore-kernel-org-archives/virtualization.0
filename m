Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995916;
	b=g7M6ji8NHfsPw0GD/ow8VWqJIrRZu5gS+Zq/v8AplYFFuyhv382q9eozMs/6zBTntNI7
	 3HLKSc5xQO4pqloGaHSqjJ7rhEjxXmGF/sgG/tgJGIsaMixb6DUzzH4+J0rPYkBA8G3qQ
	 n4mG20XeSCNd1jgm8Z3F0eFwn/lnzVBnsiHc1CE5OO5IMJpVumgUdsb2yK0YZDTUYBbLW
	 URJ+vQESYxxq7u3mDatM3NI9nQu6HbvELGznpS3HZzvmxwu7ax5b6oiqVxbuFsh0rD9k4
	 Sbdmoi+r+GaAqs3abM5sR0pm59URgaayLU6GfK+XTcK7uCmKQTVBh3Q4jpSPDymDbUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JdhZ6AbmCpurtd/q62y0hrXzBcIs1W0RDoaIyJ9UaoM=;
	b=di3umJ9NUr+tqIMT5RpL1Qplb3/Pu41QKjZafw9a9Q7nNqBg0jszqyTFB014Cxgx2W9X
	 xdGPLL4yOORL3AkKPeglfy3wQ2rsQjUIJpp2Fl+4mlj0bGcCIs3ZRqE1nkQvsEBLb+fy0
	 BxavyLb4OMpd4or0+hbNCfSL1ouGGLA+5OzEkDa0DgDnAZ8UNdcUA9T+eOcQt9fruGv8d
	 FwQFo4lK212N68c+1Cr+Aqs30ILjYIWTwQe+4FakFlGyNDLpfgOGRY6VgyeVr3deQ8TIU
	 Nl3zCWvC5NrsvzXR6N4FmPgk+2E7/nf2EzXowHk9MhZr/oCNH1N1lcUyosTkzYpl95Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PYFX8vdh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DHyCnjpI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D193606A335
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D193606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PYFX8vdh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DHyCnjpI
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b43j1340479
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JdhZ6AbmCpurtd/q62y0hrXzBcIs1W0RDoaIyJ9UaoM=; b=PYFX8vdhMOVD9vGT
	FNveqv/40DjhhQWvHVTlp+yB52ym2Rk10jKH30Ee+hvJKdcqOJPFWmciZYcd9DMd
	bZyMhM9CZx6R1ZZddFJi+YtHg/BsN6rKI5Ad5ezguKSFamM9DnwK7aP4zVN4sAjy
	9Vm4kdws+A/tu03YkgHA58zYjjdG1RQreZzvWlJwGgJb/X5zDjnn4WjSeIRKffU7
	lRaL61XQx/bT5i6/Iaz/hm2ZlspFALKBHrkLjETlgmwxjRDDm2Q8AFHF1lLP8nB5
	ut/FRGoSXvktLkSOx5IG1A46HbtawF9J26nWHTsoewossEQLCiTLboVTI602ZsRZ
	C6aj3g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9vwjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so2639053a91.1
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995914; x=1793600714; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdhZ6AbmCpurtd/q62y0hrXzBcIs1W0RDoaIyJ9UaoM=;
        b=DHyCnjpI4rHHwWiaETWbSPt/w+P+iyQIpphwzu6rnC15/XMQ4HZwS90o9rC58K50d1
         EmMcQfJJ02d+IAZy4eBqMXQsZiezMljJmO+Dl52r+7SsoWMcst19zI1GAI/B2wy6TXbA
         9pkgi/UvM47FTDbRZqrh3ARLPuKEGbPwqgDaT6EHfe+Fvs0hD+m9+fqJ2DxpxS1QvPwu
         Au4T0n16UtAF9xlmS4ApzbHrgg4hEZl/xtOUELe3brWLydKkVD1RtCTgCd061ZlUZLpc
         FZXAhBX9nepfBA2Okb87ooNMpclMp2JZVqBzqy4BVZmUciUNq7JVFPhBleOHTOjZ7oXV
         bH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995914; x=1793600714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JdhZ6AbmCpurtd/q62y0hrXzBcIs1W0RDoaIyJ9UaoM=;
        b=W/iWOPCXdcBj1NLI9f0YYvWEcB8dnd9J5XGiPoyoC1UeUfycXyip8IGx17hC6cRaVq
         Qo5E5TdS8g+aveXGDqA0TMP0wDiT4zrGltD4a8k+dbZS4jI03cvIjqDbpg8NgNv0eqg7
         8YjrY5asCFnlDGbEQuOdkdhf3BqFEeaHQPZunx5v2oZaOUxe9hB8BTKp6kaYcRjG1MjF
         VR8M3ReugdPffCJu/zYiEeCv+bpNYCdiWgzxobHaZ5MsjF/8AJEolJFQqM81JifS5grG
         spcYFktpAFni94Km2/7Rsi05KDEU7WXz2Ug0MYxU2K+9z86C+4lQ6QhOueOPp6NIAcsR
         k7fg==
X-Forwarded-Encrypted: i=1; AKwUvBw4YK/5YTkgdUYzf+9VBnJ/732lHIM0idtDuXe8smoWDPN8YTpm0Y5in40vnFEC2/ERpPV0mC6XdcX5BHW10Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKVDzjvA6n2XPoGbHNI6hey0Qj/c8PiZF1V+ip9I+xCR03hziOs
	ACu4lhku3K3RKGOEJtdohyxzauY5j/rX9fLjAQ/+0jtr0Hlxaroz4UxzDWjO7qR3O+djMJeJeLF
	qHQYxk26acHHoICzoTR/azdWBXFlaSSYhkJ1w+vjqE6bs3bcz0wIkOv5wLziSkQxkPF02bA==
X-Gm-Gg: AYBFou34pQSvv1hSEc4fW3IyV65Jjhp3kgttKuPvFbVynAnymRGEy+8JGX0pybt4tJs
	+HuLqfpEKCgB01vOutw8NT0xqC+UesCREDxQZ0klSGKkrJDleI9OdSq84+N6MFPDshGPLVzOIYd
	gD5yS/fsZJOA8EaVxoVejE3P5rRQigMlVyqATOXouTd85RumlPG+aI7uHwtI4zg8gE+HJM85JZ1
	kZOcERPSRoHqscjSU72xpFGxiHfM2eO3tGBHGylureiV4z+QV35RmPTdjLdSErM/YNhWVO8HCw9
	4zRk4lf2GrUQQOySfIGlzH+KRsTVIedTKntoo9RE15n/+1a5snBLBqxRovo3cp1Ly+NCZF5FU4b
	1bkfpDSzfms9NBL/DAl77IcjmIE3vNXLfjg==
X-Received: by 2002:a17:902:f711:b0:2e2:cb65:a719 with SMTP id d9443c01a7336-2ea9c6c8335mr43542885ad.15.1792995913956;
        Sun, 25 Oct 2026 23:25:13 -0700 (PDT)
X-Received: by 2002:a17:902:f711:b0:2e2:cb65:a719 with SMTP id d9443c01a7336-2ea9c6c8335mr43542615ad.15.1792995913409;
        Sun, 25 Oct 2026 23:25:13 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:25:12 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:30 +0530
Subject: [PATCH v2 20/23] drm/msm/dcp: Add DCP VirtIO driver
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-20-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=16984;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=XR16TYMDvDGPNgOqIgvoE1/eZZWL44v+0drX45w1Npo=;
 b=Yi99R7LtFOJxfNdKFCbfvUFD+BJfphsMFncIaYHhkO+aCjWP8T0kN0ahfe8xRm679XM52MsgA
 qJ9ImZ7IpObCoejKIrLvZ13LZovt3R2KRg3hYu6cuhPsTIQPEQH3zTG
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: O9tcNV5-HIb711dlcm59-Bi92xg4m7RN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX9A8VjyPG4mf/
 IVuRNXol9gdYFnZOAAIsHjagQffzHqXMQMYnu62sl78HLjEsWl3zDnMwTXYaqYFa9fUhNC3bI8p
 0xTv0HecEHtdN/6PQeJrmOClo6VBRWHD8Gi0Yvvq7MS9cwvQ9Fk7HJaz/FzbjVwVr41XJt6RaDc
 qk54YixQjijxuRWT9/XzhKlHLgPNWnHekJLfBRhkkFC/0wayNYx2Fs/nar9BOoRJBpZ7TmWREsO
 JJ8IjvsOus4bVEjFlHwjVZrpglWgmr+7NtKjPC7YzLKeya3d5u6se4WRcDkYGOyrfXYGXyqHrTs
 DDI3DDijt6WfM8DZAW7X0u56QPWH1rsb1ZB7Kbf01zn8MRsgEcDARbfnvwyaJdHm2UJhFyFwfww
 AHNZRzc8qx2DVkTbxhr9MOD4B1ma8Hx0KpeXCui85wK4P0VCLpAyCcTbtDIVU4KXmEcH0InoRPl
 LvWunkmQRgvosOtbGLg==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adef24b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2FSeUxzs4D6olrMjOcoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: O9tcNV5-HIb711dlcm59-Bi92xg4m7RN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX5c4CxI2LYOsu
 5SB9PiIAk1ggoN4NZsqw2PvAH2vxrK+mjy06CxrMLasUS8mA4vDtsEMCoZxp+9tyL8V2wYwmmlf
 Ar1fePZGsgFARcTHhlPa/Q6V3ts5+ec=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Add the DCP function driver that binds the VirtIO device to MSM
DRM. Without a function driver, Linux cannot establish HFI queues,
discover firmware capabilities, or register the firmware-owned
display backend.

Set up the DCP DMA and IOMMU identity, initialize VirtIO and HFI
transport, register the MSM DRM component, and synchronize suspend,
resume, remove, and shutdown with in-flight HFI activity.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile         |   2 +
 drivers/gpu/drm/msm/dcp/dcp_drv.c    | 191 ++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_drv.h    |  17 +++
 drivers/gpu/drm/msm/dcp/dcp_virtio.c | 258 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_virtio.h |   2 +
 drivers/gpu/drm/msm/msm_drv.c        |   6 +-
 drivers/gpu/drm/msm/msm_drv.h        |   2 +
 7 files changed, 475 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index e1a995a8c980..ffdb159dd9ad 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -85,6 +85,8 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_plane.o \
 	dcp/dcp_ipcc.o \
 	dcp/dcp_encoder.o \
+	dcp/dcp_drv.o \
+	dcp/dcp_virtio.o \
 	dcp/dcp_virtio_transport.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.c b/drivers/gpu/drm/msm/dcp/dcp_drv.c
new file mode 100644
index 000000000000..8c38de883bf6
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_drv.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP VirtIO driver.
+ */
+
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/panic_notifier.h>
+#include <linux/pm_runtime.h>
+
+#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
+
+#include "dcp_drv.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_hfi.h"
+#include "dcp_ipcc.h"
+#include "dcp_virtio.h"
+#include "msm_drv.h"
+#include "msm_kms.h"
+
+int dcp_subsystem_dev_init(struct dcp_drv *drv)
+{
+	struct virtio_device *vdev = drv->vdev;
+	struct device_node *dcp_subsystem_node;
+	struct platform_device *pdev;
+	struct device *dev;
+	char busid[32];
+	bool iommu_mapped;
+	int ret;
+
+	dcp_subsystem_node = of_node_get(vdev->dev.of_node);
+	if (!dcp_subsystem_node) {
+		dev_err(&vdev->dev, "no DCP subsystem DT node\n");
+		return -ENODEV;
+	}
+
+	snprintf(busid, sizeof(busid), "dcp-subsystem.%s", dev_name(vdev->dev.parent));
+
+	/*
+	 * DCP is discovered through VirtIO, but display/HFI buffers must be
+	 * mapped through the dcp-subsystem node's DMA/IOMMU identity. Create a
+	 * platform device for that DT node so DMA API and msm_kms_init_vm() use
+	 * the display function's IOMMU domain.
+	 */
+	pdev = of_platform_device_create(dcp_subsystem_node, busid, vdev->dev.parent);
+	if (!pdev) {
+		dev_err(&vdev->dev, "dcp_subsystem_dev creation failed\n");
+		of_node_put(dcp_subsystem_node);
+		return -ENODEV;
+	}
+	dev = &pdev->dev;
+
+	dev->dma_parms = &drv->dcp_subsystem_dma_parms;
+	dma_set_max_seg_size(dev, UINT_MAX);
+
+	ret = of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
+	if (ret) {
+		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
+		goto err_destroy;
+	}
+
+	iommu_mapped = device_iommu_mapped(dev);
+	if (!iommu_mapped) {
+		dev_err(dev, "no IOMMU group attached\n");
+		ret = -ENODEV;
+		goto err_destroy;
+	}
+
+	dev_dbg(dev, "dcp-subsystem: iommu_mapped=%d iommu_group=%d\n",
+		iommu_mapped,
+		dev->iommu_group ? iommu_group_id(dev->iommu_group) : -1);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, DCP_DPU_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	drv->dcp_subsystem_dev = pdev;
+	drv->dcp_subsystem_node = dcp_subsystem_node;
+
+	return 0;
+
+err_destroy:
+	of_platform_device_destroy(dev, NULL);
+	of_node_put(dcp_subsystem_node);
+	return ret;
+}
+
+void dcp_subsystem_dev_deinit(struct dcp_drv *drv)
+{
+	if (!drv->dcp_subsystem_dev)
+		return;
+
+	pm_runtime_disable(&drv->dcp_subsystem_dev->dev);
+	of_platform_device_destroy(&drv->dcp_subsystem_dev->dev, NULL);
+	of_node_put(drv->dcp_subsystem_node);
+	drv->dcp_subsystem_dev = NULL;
+}
+
+int dcp_pm_prepare(struct device *vdev_dev)
+{
+	struct dcp_drv *drv = vdev_dev ?
+		dev_to_virtio(vdev_dev)->priv : NULL;
+
+	if (!drv || !drv->dcp_subsystem_dev)
+		return 0;
+
+	return msm_kms_pm_prepare(&drv->dcp_subsystem_dev->dev);
+}
+
+void dcp_pm_complete(struct device *vdev_dev)
+{
+	struct dcp_drv *drv = vdev_dev ?
+		dev_to_virtio(vdev_dev)->priv : NULL;
+
+	if (!drv || !drv->dcp_subsystem_dev)
+		return;
+
+	msm_kms_pm_complete(&drv->dcp_subsystem_dev->dev);
+}
+
+int dcp_component_register(struct dcp_drv *drv)
+{
+	struct device *dev = &drv->dcp_subsystem_dev->dev;
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = dcp_dpu_kms_init_dsi_bridges(drv->kms, &match);
+	if (ret) {
+		dev_err(dev, "DSI host initialization failed: %d\n", ret);
+		dcp_dpu_kms_cleanup_bridges(drv->kms);
+		return ret;
+	}
+
+	/* A GPU is optional for the DCP display-only DRM device. */
+	msm_add_gpu_components(dev, &match);
+
+	ret = component_master_add_with_match(dev, &msm_drm_ops, match);
+	if (ret) {
+		dev_err(dev, "component_master_add_with_match failed: %d\n",
+			ret);
+		dcp_dpu_kms_cleanup_bridges(drv->kms);
+		return ret;
+	}
+
+	return 0;
+}
+
+void dcp_component_unregister(struct dcp_drv *drv)
+{
+	struct device *dev = &drv->dcp_subsystem_dev->dev;
+
+	component_master_del(dev, &msm_drm_ops);
+	dcp_dpu_kms_cleanup_bridges(drv->kms);
+}
+
+static int dcp_panic_notifier_cb(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct dcp_drv *drv = container_of(nb, struct dcp_drv, panic_notifier);
+
+	if (drv->hfi)
+		atomic_set(&drv->hfi->shutdown_in_progress, 1);
+
+	return NOTIFY_OK;
+}
+
+void dcp_panic_notifier_register(struct dcp_drv *drv)
+{
+	drv->panic_notifier.notifier_call = dcp_panic_notifier_cb;
+	atomic_notifier_chain_register(&panic_notifier_list, &drv->panic_notifier);
+}
+
+void dcp_panic_notifier_unregister(struct dcp_drv *drv)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list, &drv->panic_notifier);
+}
+
+void __init msm_dcp_register(void)
+{
+	dcp_virtio_register();
+}
+
+void __exit msm_dcp_unregister(void)
+{
+	dcp_virtio_unregister();
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
index 16f87035cb9a..3adc5855a9a2 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
@@ -14,6 +14,7 @@
 #include "dcp_ipcc.h"
 
 struct dcp_dpu_kms;
+struct component_match;
 
 struct dcp_drv {
 	struct virtio_device	*vdev;
@@ -24,6 +25,22 @@ struct dcp_drv {
 	struct dcp_dpu_kms	*kms;
 	struct dcp_caps		 caps;
 	struct notifier_block	 panic_notifier;
+	struct dcp_ipcc		*ipcc;
 };
 
+int dcp_subsystem_dev_init(struct dcp_drv *drv);
+void dcp_subsystem_dev_deinit(struct dcp_drv *drv);
+
+int dcp_component_register(struct dcp_drv *drv);
+void dcp_component_unregister(struct dcp_drv *drv);
+
+int dcp_pm_prepare(struct device *vdev_dev);
+void dcp_pm_complete(struct device *vdev_dev);
+
+void dcp_panic_notifier_register(struct dcp_drv *drv);
+void dcp_panic_notifier_unregister(struct dcp_drv *drv);
+
+void __init msm_dcp_register(void);
+void __exit msm_dcp_unregister(void);
+
 #endif /* __DCP_DRV_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.c b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
new file mode 100644
index 000000000000..15d5caf02ff5
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP VirtIO device driver.
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/pm_runtime.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/slab.h>
+
+#include "dcp_drv.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_hfi.h"
+#include "dcp_ipcc.h"
+#include "dcp_virtio.h"
+#include "msm_drv.h"
+#include "msm_kms.h"
+
+static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv);
+
+static const unsigned int dcp_virtio_features[] = {
+	VIRTIO_F_VERSION_1,
+	VIRTIO_F_NOTIFICATION_DATA,
+	VIRTIO_F_RING_RESET,
+	VIRTIO_F_ACCESS_PLATFORM,
+};
+
+/*
+ * The VirtIO core owns transport discovery. This driver owns HFI setup and
+ * creates the DRM component only after firmware capabilities are available.
+ */
+static int dcp_virtio_probe(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv;
+	struct virtqueue *vqs[DCP_NUM_VQS];
+	struct virtqueue_info vqs_info[DCP_NUM_VQS] = {
+		[DCP_VQ_CMD]  = { .name = "cmd",  .callback = dcp_hfi_cmd_callback },
+		[DCP_VQ_RESP] = { .name = "resp", .callback = dcp_hfi_resp_callback },
+	};
+	struct dcp_dpu_kms *dcp_kms;
+	struct msm_drm_private *priv;
+	int ret;
+
+	dev_dbg(&vdev->dev, "DCP VirtIO probe started\n");
+
+	drv = devm_kzalloc(&vdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->vdev = vdev;
+	vdev->priv = drv;
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev, "VIRTIO_F_VERSION_1 not negotiated\n");
+		return -ENODEV;
+	}
+
+	drv->ipcc = dcp_virtio_get_ipcc(vdev);
+	/* Access-platform is required for the firmware-visible IOVA mappings. */
+	if (!virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM)) {
+		dev_err(&vdev->dev, "VIRTIO_F_ACCESS_PLATFORM not negotiated\n");
+		return -ENODEV;
+	}
+
+	ret = dcp_subsystem_dev_init(drv);
+	if (ret)
+		return ret;
+
+	ret = virtio_find_vqs(vdev, DCP_NUM_VQS, vqs, vqs_info, NULL);
+	if (ret) {
+		dev_err(&vdev->dev, "virtqueue allocation failed: %d\n", ret);
+		goto err_fn_dev;
+	}
+
+	ret = dcp_hfi_init(drv, vdev, vqs[DCP_VQ_CMD], vqs[DCP_VQ_RESP],
+			   vdev->dev.parent);
+	if (ret) {
+		dev_err(&vdev->dev, "HFI init failed: %d\n", ret);
+		goto err_del_vqs;
+	}
+
+	dcp_ipcc_set_resp_vq(drv->ipcc, vqs[DCP_VQ_RESP]);
+
+	/*
+	 * Keep the device unready until HFI state and virtqueues are initialized.
+	 * KMS registration below depends on synchronous firmware initialization.
+	 */
+	virtio_device_ready(vdev);
+	virtqueue_kick(drv->hfi->resp_vq);
+
+	ret = dcp_hfi_send_device_init(drv->hfi);
+	if (ret) {
+		dev_err(&vdev->dev, "HFI DEVICE_INIT failed: %d\n", ret);
+		goto err_hfi_deinit;
+	}
+
+	ret = dcp_hfi_get_capabilities(drv->hfi, &drv->caps);
+	if (ret) {
+		dev_err(&vdev->dev, "HFI GET_CAPS failed: %d\n", ret);
+		goto err_hfi_deinit;
+	}
+
+	/* Register the display resources before exposing the DRM component. */
+	ret = dcp_hfi_send_resource_register(drv->hfi);
+	if (ret) {
+		dev_err(&vdev->dev, "HFI RESOURCE_REGISTER failed: %d\n", ret);
+		goto err_hfi_deinit;
+	}
+
+	dev_dbg(&vdev->dev,
+		"DCP caps: %u displays, max %ux%u, %u planes\n",
+		drv->caps.num_displays, drv->caps.max_width, drv->caps.max_height,
+		drv->caps.max_planes);
+
+	dcp_kms = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*dcp_kms), GFP_KERNEL);
+	if (!dcp_kms) {
+		ret = -ENOMEM;
+		goto err_hfi_deinit;
+	}
+
+	dcp_kms->drv       = drv;
+	dcp_kms->pm_dev    = &drv->dcp_subsystem_dev->dev;
+	dcp_kms->hfi       = drv->hfi;
+	dcp_kms->caps      = &drv->caps;
+	dcp_kms->dpus_np   = drv->dcp_subsystem_node;
+	dcp_kms->iommu_dev = &drv->dcp_subsystem_dev->dev;
+	drv->kms        = dcp_kms;
+
+	ret = msm_kms_init(&dcp_kms->base, &dcp_dpu_kms_funcs);
+	if (ret) {
+		dev_err(&vdev->dev, "msm_kms_init failed: %d\n", ret);
+		goto err_hfi_deinit;
+	}
+
+	priv = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_hfi_deinit;
+	}
+
+	priv->kms      = &dcp_kms->base;
+	priv->kms_init = dcp_kms_init;
+	dev_set_drvdata(&drv->dcp_subsystem_dev->dev, priv);
+	dcp_kms->rpm_enabled = true;
+
+	/* Component binding now sees initialized HFI, capabilities, and IOMMU state. */
+	ret = dcp_component_register(drv);
+	if (ret) {
+		dev_err_probe(&vdev->dev, ret, "component register failed\n");
+		goto err_hfi_deinit;
+	}
+
+	dcp_panic_notifier_register(drv);
+
+	dev_dbg(&vdev->dev, "DCP VirtIO probe complete\n");
+	return 0;
+
+err_hfi_deinit:
+	dcp_virtio_hfi_cleanup(drv);
+	goto err_fn_dev;
+err_del_vqs:
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+err_fn_dev:
+	dcp_subsystem_dev_deinit(drv);
+	return ret;
+}
+
+static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv)
+{
+	struct virtio_device *vdev = drv->vdev;
+
+	if (!drv->hfi)
+		return;
+
+	dcp_ipcc_set_resp_vq(drv->ipcc, NULL);
+
+	dcp_hfi_stop(drv->hfi);
+	virtio_reset_device(vdev);
+	virtio_synchronize_cbs(vdev);
+	dcp_hfi_quiesce_queues(drv->hfi);
+	vdev->config->del_vqs(vdev);
+	dcp_hfi_deinit(drv->hfi);
+}
+
+/* Remove DRM users before tearing down HFI, IPCC, or the VirtIO queues. */
+static void dcp_virtio_remove(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv = vdev->priv;
+
+	dev_dbg(&vdev->dev, "DCP VirtIO remove\n");
+
+	dcp_component_unregister(drv);
+	dcp_panic_notifier_unregister(drv);
+
+	dcp_virtio_hfi_cleanup(drv);
+
+	dcp_subsystem_dev_deinit(drv);
+}
+
+/* KMS shutdown must complete while the firmware transport is available. */
+static void dcp_virtio_shutdown(struct virtio_device *vdev)
+{
+	struct dcp_drv *drv = vdev->priv;
+
+	pm_runtime_get_sync(&drv->dcp_subsystem_dev->dev);
+	msm_kms_shutdown(drv->dcp_subsystem_dev);
+	pm_runtime_put_noidle(&drv->dcp_subsystem_dev->dev);
+}
+
+static const struct virtio_device_id dcp_virtio_id_table[] = {
+	{ VIRTIO_ID_QPSFI, VIRTIO_VENDOR_ID_DCP_HFI },
+	{ 0 },
+};
+MODULE_DEVICE_TABLE(virtio, dcp_virtio_id_table);
+
+static const struct dev_pm_ops dcp_virtio_pm_ops = {
+	.prepare = dcp_pm_prepare,
+	.complete = dcp_pm_complete,
+};
+
+static struct virtio_driver dcp_virtio_driver = {
+	.driver = {
+		.name  = "qcom-dcp-hfi",
+		.owner = THIS_MODULE,
+		.pm    = &dcp_virtio_pm_ops,
+	},
+	.id_table           = dcp_virtio_id_table,
+	.feature_table      = dcp_virtio_features,
+	.feature_table_size = ARRAY_SIZE(dcp_virtio_features),
+	.probe              = dcp_virtio_probe,
+	.remove             = dcp_virtio_remove,
+	.shutdown           = dcp_virtio_shutdown,
+};
+
+int dcp_virtio_register(void)
+{
+	int ret;
+
+	ret = dcp_virtio_transport_register();
+	if (ret)
+		return ret;
+
+	ret = register_virtio_driver(&dcp_virtio_driver);
+	if (ret)
+		dcp_virtio_transport_unregister();
+
+	return ret;
+}
+
+void dcp_virtio_unregister(void)
+{
+	unregister_virtio_driver(&dcp_virtio_driver);
+	dcp_virtio_transport_unregister();
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.h b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
index a9c3b9aff61d..3ded8293ab18 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_virtio.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
@@ -8,9 +8,11 @@
 
 #include <linux/device.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 
 struct dcp_drv;
 struct dcp_ipcc;
+#define VIRTIO_VENDOR_ID_DCP_HFI		1
 
 struct dcp_ipcc *dcp_virtio_get_ipcc(struct virtio_device *vdev);
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5e8f3ce26b32..5816c64d7ce7 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1093,8 +1093,8 @@ static const struct of_device_id msm_gpu_match[] = {
 	{ },
 };
 
-static int add_gpu_components(struct device *dev,
-			      struct component_match **matchptr)
+int msm_add_gpu_components(struct device *dev,
+			   struct component_match **matchptr)
 {
 	struct device_node *np;
 
@@ -1153,7 +1153,7 @@ int msm_drv_probe(struct device *master_dev,
 	}
 
 	if (!msm_separate_gpu_kms_components()) {
-		ret = add_gpu_components(master_dev, &match);
+		ret = msm_add_gpu_components(master_dev, &match);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2840e8a5052d..aa5dfd82ac6f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -523,6 +523,8 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
 /* Driver helpers */
 
 extern const struct component_master_ops msm_drm_ops;
+int msm_add_gpu_components(struct device *dev,
+			   struct component_match **matchptr);
 
 int msm_kms_pm_prepare(struct device *dev);
 void msm_kms_pm_complete(struct device *dev);

-- 
2.43.0

