Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995820;
	b=RuwgTwxo8xHKTn2QrHO/8kkhGw15US/FQ35OVyoRgv7+pkJuQNTEhs6QoOdbz6YT1l6O
	 kpER/SdzHS9tREZoSkCU7qfSa+S90vfuWvjhzwd6zPR7p7+U7sI2nIIYvYXt3gPM69p3K
	 tsBJkr/byw7IQsR1cwigtj7KS8ixevzk8IHM2SWrSmrkBqZHZ7DDF9KoF/4DAsDSu5mNu
	 IW6j2z9uquoJUdaR4RCb/qRcA/6TGVjcuzKke1hnXYzgoCybuFD3ETQBLhpErTVHNgfA4
	 3bo+R3OpBuE77+LOrEbA6ZRV8MocYCve9iMuv1Bn4E5iOzY535WRAVlXy2CAoHgVTvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995820;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gTJDLwTy2wT4V1gqm1r4n9p7Ykj4+MV0Uarsemoozrs=;
	b=JUa4L073p0XqRGgagSXyhLUvDErj0KaY5XQRwKtyqc7iXxTLWW1v/Srp/njH1627uwBy
	 ms0+jJy+hNm4Uzr+aMnNJmlHzx7Vpd/0v2VtbnX99svFgwyPDdfzHiyDHnMqEL2vqzbON
	 l30MKucxHwqVIBvY+GfM5Ki1BzuYnSeGOg6WNkYs/sXXQxk/W513Y73cfSe+ywFqTN4RZ
	 484j4NhYZQ9jWb916SeB4kKaAcXfCJWLX2L26POmNU3tgY6D1llYEmdHu9Xz3EILgghkZ
	 itWujd68VEXVGkKTJjsAHD0qj1BU0tXHhx5uiwPK7zdhqUYRhr+6DHCsC9pvJG5LD8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H9uFQbBw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eOlgRkJE;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E57606A321
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E57606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H9uFQbBw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eOlgRkJE
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b9c5718228
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTJDLwTy2wT4V1gqm1r4n9p7Ykj4+MV0Uarsemoozrs=; b=H9uFQbBwqfqOB0AL
	ADgRK97GnapxjfmpIVwxlM7i7Hs9VQ+02F4t0aG5dh/CKwcLMIXsFv6hglvM4Agg
	9+st8Xitcm5vQde/V/BZXwBX0UnOgjMcq0P7Qio5ak37iKTdzgw43XTKOYMMaz23
	NHk8g3O81IOEwUms1LA0SFYMFUR67jAN6s2cI4kKnV5oe3EEcUTVfRC+hsamvruM
	ytinWRrXFzQNPie/4s6DJ/GT/mnT/Kv+1utKfDbb95zXHtwcSZMYD+eaBiNgvsmY
	YPRttoqdsN/IdT6sSfLO3VOXbgFEF3qNx+B7+fPIzeAx+Au/MPS1YfRsIYSOFz6u
	aPx2zw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgss4kr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e942b1cc86so29812735ad.1
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995817; x=1793600617; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTJDLwTy2wT4V1gqm1r4n9p7Ykj4+MV0Uarsemoozrs=;
        b=eOlgRkJE3SkoXmS35AbHZaRLTy6Cy4J4532QdPqt3uoevonsDr1UHhg6HZChbb3Qlo
         7eMPYI6avuihfVBEdfRRRvn2NMsXAT/mSqNgQFNKLKbGynnPd9nhkblrxmYskqJQ8YcZ
         TSiahxBd5q7uz1A2tmL5RxAdBXxTizKHkSmVz8PdZLqYmif39rDP5cIY/5WQnwfB0gvb
         z1xSeIFcXPsRFASYxaQo346DrAvrT3QnMpdaSav053cHWizAup6wZlvu39VRonhwXeZL
         JdUF0Jq72SpbI93K3OYkxCD5Bmo2SBzw09j29xc8PTtH3i6mqCSEtRAb/LBp1d62BIFo
         TWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995817; x=1793600617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTJDLwTy2wT4V1gqm1r4n9p7Ykj4+MV0Uarsemoozrs=;
        b=IeGze0MnT/W8PU4E5nj04BHUt44ncm3kTZyEjGssxK2IgFwPEOFJK5bAzf990WSR78
         SX1ph4pdtsuKnY4Bzm3/4KhHqmeD4FhPIazOOlVRsjDCU2oPR9RoUQSbj8Ajz1EbLxst
         wy0rhP0i6C0CNtiVQ2uz1v7KTNjeju06FDFSE/5DU9WSNIPgaQzzwEJPEYsB6Faw3q5W
         uFJrZnH/bdUjYM43wVb+Nd+71JJDVOAT6K1rmXN2m5hacWQ2svZbM+PW5FrNMnMB2gkR
         eJyTQ79TpNKS6bKBJ/OeiNqSu/ljUuNVS7dCiVonw53bl25m6AVTifn6cXAWLOybIVBn
         mzXA==
X-Forwarded-Encrypted: i=1; AKwUvBycaXsBxKZpDU2aJwGxquOZTxEABLVh0B7i6/cLmU0r2tI3AABYM64Q2WDrDcZ8RKZrdHCx8wsgC8PScH+v4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYK/WVbCYFYG246XDce/NO0icHdqvYYcxERUyBSw6UbZGb1ZRZMS
	0FgMKBvlG5QWrexdsvCRjQeINcBumQ4V2E9mNVhZHioBDpOFLC4ambgEdBZaRunRYGo2IhLXrHD
	4ETc08QWdM5Oeb747KpXYcJ4515s+QTAvtCiV0oK/5tacmPJUeGxSjt5MjWGrBdGcAeoXBQ==
X-Gm-Gg: AYBFou0PptBDzsz7Ol/wYDhm53vlgIdFNCbzrdtOqwa23mFPGOzxuxS6K/qjXC0l3YF
	Fo8QZ0czGTnz0F1kaurCtHgXKhq9a/eFB/SgT7LcchY0ic0NJ3P7E1sMiC5/pb7OcsjAxr6sHIp
	bTajqK4uLwqB0Gb/c1c4JcrHW1ud4SCmj/ZEfxFudXII9fbKDlu8fehZ7qF4y8DPFBW1ItXezUq
	4FpLWxI8/n2n9FayVE47qTtSaiOR2eVhgyZpgQKGEd0Oz/3nT+US857HNtw6u7SHCCWtv/E+vsg
	tDVRl6mmGe9v25+wbjxw8NcBUSsL+pJTFVn6yYTpUDRYVbntvnh4xwcZhHjrGC/1w0szK0PEBAS
	uwJn4KK+XbOh3UvNbkicn0LcHNbkmXCG3kA==
X-Received: by 2002:a17:903:19cc:b0:2e9:9524:b004 with SMTP id d9443c01a7336-2ea9c832904mr51958325ad.59.1792995816978;
        Sun, 25 Oct 2026 23:23:36 -0700 (PDT)
X-Received: by 2002:a17:903:19cc:b0:2e9:9524:b004 with SMTP id d9443c01a7336-2ea9c832904mr51957895ad.59.1792995816339;
        Sun, 25 Oct 2026 23:23:36 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:23:35 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:21 +0530
Subject: [PATCH v2 11/23] drm/msm/dcp: Add DCP CRTCs and shared plane state
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-11-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=28990;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=T9KMwmznRRrDMiH7YlBKMSidRWgKkYrCytIt2w0eP14=;
 b=IUUm+WIFhka8zL3Ko1DqdTgZ44rjgNIvirEr4qxgjDbtgzOgisi8t+Sm8kkoaDLmjosXoXaok
 9/PWjpBF0IVB7BvBb1XOfU+BWGe9zX4+AkM/l70DINbWtZTqcoCKD49
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX+rNrnqOIjUdA
 CAsKI1tw+hMlgflO1r3Hh6s9y3QruXs9MSusW4rzeHGZvhJE4xrL4tSYJYEhazHrf8pdOcPgCZS
 VyWYvtuD++Biht2dpqH4j1N/AXKlWNI=
X-Proofpoint-GUID: eQxrGQSDvOkC4IpJZD5E7GWNN6UwgSPA
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adef1ea cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ibcdE0NEZMhhqndzFkkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: eQxrGQSDvOkC4IpJZD5E7GWNN6UwgSPA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX5EB8LWuxUctw
 moTC5+mfKBVL80ISd6k4KIUCehEEO6jW6CrJ61TSuMFXc3HzuS8nKheZgj0LdZhRXEp36EeE8lH
 tafIu/zsDzThk9DEaKVKYqUS9sghjRlmeLNWqjNh/pJM60c+2ZMI5qxE7HnkYr+YLXSR6sE0hw4
 kylCbz0z9qqTPSqsxrrOah+xeYTr2jaYhFQPUJCQMQVG9V6Ci4445BMLn9mS5WtBFq85KZXiCU1
 vmHaLZ5J7lD+UJbLvFHQ62J+0xobTd7gXre1/Z1kpqCTeElrkzSqQbJsZvjYBEWK6Ou+WN2DU2x
 pLSZ3/cOrID1quwj8GTc9f3dIJ9eYZ3bYC3niU2IWiUUXFkJcCm+TxlRzh72SJ0cOmXoi8/y2qv
 2btnU5uChjh3tbemeeTGlIp/nL0lf/Feo5kazVObEzbTZcBIC6YVF4r2AmIKhRpdX3O8KkSdxBt
 ZbkdreXWOTMb+nZ+WQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025

Create the DRM CRTC objects and shared state needed to expose the
firmware-owned DCP pipeline through MSM DRM. Without CRTC state,
DRM cannot track firmware sessions, aggregate bandwidth, or validate
the display configuration.

Implement CRTC objects, display lookup and session state, CRTC
bandwidth aggregation, and the shared plane state used by validation
and plane programming.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile              |   2 +
 drivers/gpu/drm/msm/dcp/dcp_crtc.c        | 725 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_crtc.h        | 104 +++++
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c     |  21 +
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h     |  54 +++
 drivers/gpu/drm/msm/dcp/dcp_plane_state.h |  37 ++
 6 files changed, 943 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 77c268aabca6..80341ce07d53 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -72,6 +72,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 	disp/mdp5/mdp5_smp.o \
 
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
+	dcp/dcp_crtc.o \
+	dcp/dcp_dpu_kms.o \
 	dcp/dcp_hfi_core.o \
 	dcp/dcp_hfi_crtc.o \
 	dcp/dcp_hfi_dsi.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
new file mode 100644
index 000000000000..ec4f74c2920f
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP CRTC implementation.
+ */
+
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_rect.h>
+#include <drm/drm_vblank.h>
+
+#include <drm/drm_managed.h>
+
+#include "msm_drv.h"
+
+#include "dcp_crtc.h"
+#include "dcp_drv.h"
+#include "dcp_hfi.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_plane_state.h"
+
+#include "hfi/hfi_defs_display.h"
+#include "hfi/hfi_properties_display.h"
+
+#define DCP_FRAME_DONE_TIMEOUT_MS	500
+
+static struct dcp_dpu_kms *dcp_crtc_get_kms(struct drm_crtc *crtc)
+{
+	struct msm_drm_private *priv = crtc->dev->dev_private;
+
+	return to_dcp_dpu_kms(priv->kms);
+}
+
+static struct drm_crtc_state *
+dcp_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
+{
+	struct dcp_crtc_state *cstate;
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	cstate = kzalloc_obj(*cstate, GFP_KERNEL);
+	if (!cstate)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &cstate->base);
+
+	cstate->topology_mixer_count =
+		to_dcp_crtc_state(crtc->state)->topology_mixer_count;
+	cstate->topology_bits_per_component =
+		to_dcp_crtc_state(crtc->state)->topology_bits_per_component;
+	memcpy(cstate->mixer_roi, to_dcp_crtc_state(crtc->state)->mixer_roi,
+	       sizeof(cstate->mixer_roi));
+	cstate->update_roi = to_dcp_crtc_state(crtc->state)->update_roi;
+	return &cstate->base;
+}
+
+static void dcp_crtc_atomic_destroy_state(struct drm_crtc *crtc,
+					  struct drm_crtc_state *state)
+{
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(state);
+
+	__drm_atomic_helper_crtc_destroy_state(state);
+	kfree(cstate);
+}
+
+static struct drm_crtc_state *
+dcp_crtc_atomic_create_state(struct drm_crtc *crtc)
+{
+	struct dcp_crtc_state *cstate;
+
+	cstate = kzalloc_obj(*cstate, GFP_KERNEL);
+	if (!cstate)
+		return ERR_PTR(-ENOMEM);
+
+	__drm_atomic_helper_crtc_state_init(&cstate->base, crtc);
+	cstate->topology_mixer_count = 1;
+	cstate->topology_bits_per_component = 8;
+	return &cstate->base;
+}
+
+static void dcp_crtc_aggregate_bw(struct drm_crtc_state *crtc_state,
+				  bool enable)
+{
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc_state);
+	struct drm_plane *plane;
+	const struct drm_plane_state *pstate;
+
+	cstate->dram_ib  = 0;
+	cstate->dram_ab  = 0;
+	cstate->llcc_ib  = 0;
+	cstate->llcc_ab  = 0;
+	cstate->core_clk = 0;
+
+	if (!enable)
+		return;
+
+	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
+		if (!pstate->visible || !pstate->fb)
+			continue;
+
+		const struct dcp_plane_state *dcp_pstate = to_dcp_plane_state(pstate);
+
+		cstate->dram_ib  = max(cstate->dram_ib, dcp_pstate->fetch_bw);
+		cstate->dram_ab += dcp_pstate->fetch_bw;
+		cstate->llcc_ib  = max(cstate->llcc_ib, dcp_pstate->fetch_bw);
+		cstate->llcc_ab += dcp_pstate->fetch_bw;
+		cstate->core_clk = max(cstate->core_clk, dcp_pstate->clk);
+	}
+}
+
+static enum drm_mode_status
+dcp_crtc_mode_valid(struct drm_crtc *crtc,
+		    const struct drm_display_mode *mode)
+{
+	struct dcp_dpu_kms *kms = dcp_crtc_get_kms(crtc);
+	u32 max_width, max_height;
+
+	dcp_mode_limits(mode, kms->caps->max_width, kms->caps->max_height,
+			&max_width, &max_height);
+
+	return drm_mode_validate_size(mode, max_width, max_height);
+}
+
+static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
+				  struct drm_atomic_commit *state)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	u32 mixer_count;
+	u32 session_id;
+	u32 i;
+	int ret;
+
+	if (!crtc->state->active)
+		return;
+	if (!dcp_kms->commit_pm_active) {
+		cstate->hfi_error = -EIO;
+		return;
+	}
+
+	if (!dcp_crtc_get_session(crtc, &session_id)) {
+		cstate->hfi_error = -ENODEV;
+		return;
+	}
+
+	if (cstate->core_clk > 0 || cstate->dram_ib > 0) {
+		ret = dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id,
+					  cstate->dram_ib,  cstate->dram_ab,
+					  cstate->llcc_ib,  cstate->llcc_ab,
+					  cstate->core_clk);
+		if (ret) {
+			cstate->hfi_error = ret;
+			return;
+		}
+	}
+
+	mixer_count = cstate->topology_mixer_count;
+	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
+		cstate->hfi_error = -EINVAL;
+		return;
+	}
+	for (i = 0; i < mixer_count; i++) {
+		struct dcp_mixer_roi *roi = &cstate->mixer_roi[i];
+
+		if (!roi->w || !roi->h) {
+			drm_err(crtc->dev, "CRTC%u: invalid zero-sized LM%u ROI\n",
+				dcp_crtc->display_id, i);
+			cstate->hfi_error = -EINVAL;
+			return;
+		}
+
+		ret = dcp_hfi_crtc_set_resource(dcp_kms->hfi, session_id,
+						i, roi->w, roi->h, roi->x, roi->y);
+		if (ret) {
+			cstate->hfi_error = ret;
+			return;
+		}
+	}
+
+	ret = dcp_hfi_crtc_set_dest_roi(dcp_kms->hfi, session_id,
+					cstate->update_roi.x, cstate->update_roi.y,
+					cstate->update_roi.w, cstate->update_roi.h);
+	if (ret) {
+		cstate->hfi_error = ret;
+		return;
+	}
+}
+
+static void dcp_crtc_atomic_flush(struct drm_crtc *crtc,
+				  struct drm_atomic_commit *state)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	unsigned long flags;
+	u32 session_id;
+	int ret;
+
+	if (!crtc->state->enable)
+		return;
+	drm_dbg_driver(crtc->dev, "DCP_FLUSH CRTC%u mask=0x%x err=%d\n",
+		       dcp_crtc->display_id, crtc->state->plane_mask,
+		       cstate->hfi_error);
+
+	if (!dcp_crtc_get_session(crtc, &session_id)) {
+		drm_dbg_driver(crtc->dev,
+			       "CRTC%u: atomic flush without HFI session\n",
+			       dcp_crtc->display_id);
+		goto flush_done;
+	}
+
+	if (cstate->hfi_error)
+		goto flush_done;
+
+	ret = dcp_hfi_crtc_set_scan_sequence_id(dcp_kms->hfi, session_id,
+						++dcp_crtc->commit_seq_id);
+	if (ret)
+		goto flush_error;
+
+	ret = dcp_hfi_crtc_set_autorefresh(dcp_kms->hfi,
+					   session_id, true, 1);
+	if (ret)
+		goto flush_error;
+
+	goto flush_done;
+
+flush_error:
+	cstate->hfi_error = ret;
+
+flush_done:
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	dcp_crtc->event = crtc->state->event;
+	crtc->state->event = NULL;
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+}
+
+void dcp_crtc_set_session(struct drm_crtc *crtc, u32 session_id)
+{
+	struct dcp_crtc *dcp_crtc;
+	unsigned long flags;
+
+	if (!crtc)
+		return;
+
+	dcp_crtc = to_dcp_crtc(crtc);
+	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
+	dcp_crtc->session_id = session_id;
+	dcp_crtc->session_valid = true;
+	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
+}
+
+void dcp_crtc_clear_session(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc;
+	unsigned long flags;
+
+	if (!crtc)
+		return;
+
+	dcp_crtc = to_dcp_crtc(crtc);
+	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
+	dcp_crtc->session_valid = false;
+	dcp_crtc->session_id = 0;
+	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
+}
+
+bool dcp_crtc_get_session(struct drm_crtc *crtc, u32 *session_id)
+{
+	struct dcp_crtc *dcp_crtc;
+	unsigned long flags;
+	bool valid;
+
+	if (!crtc)
+		return false;
+
+	dcp_crtc = to_dcp_crtc(crtc);
+	spin_lock_irqsave(&dcp_crtc->spin_lock, flags);
+	valid = dcp_crtc->session_valid;
+	if (valid && session_id)
+		*session_id = dcp_crtc->session_id;
+	spin_unlock_irqrestore(&dcp_crtc->spin_lock, flags);
+
+	return valid;
+}
+
+void dcp_crtc_set_topology_state(struct drm_crtc_state *state,
+				 u32 mixer_count,
+				 u32 bits_per_component)
+{
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(state);
+
+	cstate->topology_mixer_count = mixer_count;
+	cstate->topology_bits_per_component = bits_per_component;
+}
+
+void dcp_crtc_commit_kickoff(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	u32 session_id;
+	int ret;
+
+	if (cstate->hfi_error) {
+		drm_err(crtc->dev,
+			"DCP_TRIGGER CRTC%u suppressed after HFI error %d\n",
+			dcp_crtc->display_id, cstate->hfi_error);
+		return;
+	}
+
+	if (!dcp_crtc_get_session(crtc, &session_id)) {
+		drm_warn(crtc->dev,
+			 "CRTC%u: no active session, skipping FRAME_TRIGGER\n",
+			 dcp_crtc->display_id);
+		return;
+	}
+
+	/* MSM serializes commits, so only one frame completion may be pending. */
+	if (atomic_cmpxchg(&dcp_crtc->pending_kickoff_cnt, 0, 1)) {
+		drm_err(crtc->dev,
+			"CRTC%u: frame completion already pending\n",
+			dcp_crtc->display_id);
+		cstate->hfi_error = -EBUSY;
+		return;
+	}
+	dcp_crtc->pending_seq_id = dcp_crtc->commit_seq_id;
+
+	ret = dcp_hfi_display_commit(dcp_kms->hfi, session_id);
+	if (ret) {
+		drm_err(crtc->dev,
+			"HFI commit failed for CRTC%u (session=%u): %d\n",
+			dcp_crtc->display_id, session_id, ret);
+		atomic_dec(&dcp_crtc->pending_kickoff_cnt);
+		wake_up(&dcp_crtc->frame_done_wq);
+	}
+}
+
+void dcp_crtc_wait_for_commit_done(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	unsigned long timeout = msecs_to_jiffies(DCP_FRAME_DONE_TIMEOUT_MS);
+
+	if (!atomic_read(&dcp_crtc->pending_kickoff_cnt))
+		return;
+
+	if (!wait_event_timeout(dcp_crtc->frame_done_wq,
+				atomic_read(&dcp_crtc->pending_kickoff_cnt) == 0,
+				timeout)) {
+		drm_err(crtc->dev,
+			"frame done timeout for CRTC%u\n",
+			dcp_crtc->display_id);
+		atomic_set(&dcp_crtc->pending_kickoff_cnt, 0);
+	}
+}
+
+void dcp_crtc_complete_commit(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	unsigned long flags;
+
+	if (!crtc->state->active)
+		dcp_crtc_aggregate_bw(crtc->state, false);
+
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	if (dcp_crtc->event) {
+		drm_crtc_send_vblank_event(crtc, dcp_crtc->event);
+		dcp_crtc->event = NULL;
+	}
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+}
+
+int dcp_crtc_vblank(struct drm_crtc *crtc, bool enable)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	u32 session_id;
+	int ret;
+
+	if (!dcp_kms->hfi || !dcp_crtc_get_session(crtc, &session_id))
+		return -ENODEV;
+
+	if (enable)
+		ret = dcp_hfi_display_event_register_async(dcp_kms->hfi,
+							   session_id, HFI_EVENT_VSYNC);
+	else
+		ret = dcp_hfi_display_event_deregister_async(dcp_kms->hfi,
+							     session_id, HFI_EVENT_VSYNC);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(dcp_crtc->vblank_enabled, enable);
+	return 0;
+}
+
+void dcp_crtc_vblank_callback(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+
+	if (!READ_ONCE(dcp_crtc->vblank_enabled))
+		return;
+
+	if (ktime_compare(dcp_crtc->vblank_cb_time, ktime_set(0, 0)) == 0)
+		dcp_crtc->vblank_cb_time = ktime_get();
+	else
+		dcp_crtc->vblank_cb_count++;
+	drm_crtc_handle_vblank(crtc);
+}
+
+void dcp_crtc_frame_done_callback(struct drm_crtc *crtc)
+{
+	struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+
+	atomic_add_unless(&dcp_crtc->pending_kickoff_cnt, -1, 0);
+	wake_up(&dcp_crtc->frame_done_wq);
+}
+
+static struct drm_crtc *dcp_crtc_find_by_session_id(struct dcp_drv *drv,
+						    u32 session_id)
+{
+	struct dcp_dpu_kms *dcp_kms;
+	struct drm_crtc *crtc;
+	u32 active_session_id;
+
+	if (!drv || !drv->kms)
+		return NULL;
+
+	dcp_kms = drv->kms;
+
+	crtc = dcp_dpu_kms_get_crtc(dcp_kms, session_id);
+	if (!crtc || !dcp_crtc_get_session(crtc, &active_session_id) ||
+	    active_session_id != session_id)
+		return NULL;
+
+	return crtc;
+}
+
+void dcp_crtc_hfi_vblank_cb(struct dcp_drv *drv, u32 session_id)
+{
+	struct drm_device *dev = drv && drv->kms ? drv->kms->dev : NULL;
+	struct drm_crtc *crtc = dcp_crtc_find_by_session_id(drv, session_id);
+
+	if (crtc)
+		dcp_crtc_vblank_callback(crtc);
+	else if (dev)
+		drm_err_ratelimited(dev,
+				    "unknown CRTC for HFI VSYNC session %u\n",
+				    session_id);
+}
+
+void dcp_crtc_hfi_frame_done_cb(struct dcp_drv *drv, u32 session_id, u32 sequence_id)
+{
+	struct drm_device *dev = drv && drv->kms ? drv->kms->dev : NULL;
+	struct drm_crtc *crtc = dcp_crtc_find_by_session_id(drv, session_id);
+
+	if (crtc) {
+		struct dcp_crtc *dcp_crtc = to_dcp_crtc(crtc);
+
+		/* A single pending commit makes equality valid across sequence wrap. */
+		if (sequence_id != dcp_crtc->pending_seq_id) {
+			drm_warn(crtc->dev,
+				 "CRTC%u: ignoring stale FRAME_SCAN_COMPLETE seq=%u expected=%u\n",
+				 dcp_crtc->display_id, sequence_id,
+				 dcp_crtc->pending_seq_id);
+			return;
+		}
+		dcp_crtc_frame_done_callback(crtc);
+	} else if (dev)
+		drm_err_ratelimited(dev,
+				    "unknown CRTC for HFI frame-done session %u seq=%u\n",
+				    session_id, sequence_id);
+}
+
+static int dcp_crtc_setup_mixer_rois(struct drm_crtc *crtc,
+				     struct drm_crtc_state *crtc_state,
+				     struct dcp_crtc_state *cstate)
+{
+	const struct drm_plane_state *pstate;
+	struct drm_plane *plane;
+	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
+	u32 mixer_count = cstate->topology_mixer_count;
+	u32 mixer_width = mode->hdisplay / mixer_count;
+	u32 i;
+
+	if (!mixer_width)
+		return -EINVAL;
+
+	cstate->update_roi.x = 0;
+	cstate->update_roi.y = 0;
+	cstate->update_roi.w = mode->hdisplay;
+	cstate->update_roi.h = mode->vdisplay;
+	for (i = 0; i < mixer_count; i++) {
+		cstate->mixer_roi[i].x = (mode->hdisplay * i) / mixer_count;
+		cstate->mixer_roi[i].y = 0;
+		cstate->mixer_roi[i].w = (mode->hdisplay * (i + 1)) / mixer_count -
+			cstate->mixer_roi[i].x;
+		cstate->mixer_roi[i].h = mode->vdisplay;
+		drm_dbg_driver(crtc->dev,
+			       "DCP_CHECK CRTC%u LM%u roi=(%u,%u %ux%u)\n",
+				to_dcp_crtc(crtc)->display_id, i,
+				cstate->mixer_roi[i].x, cstate->mixer_roi[i].y,
+				cstate->mixer_roi[i].w, cstate->mixer_roi[i].h);
+	}
+
+	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
+		bool fullscreen;
+		bool assigned = false;
+		u32 mixer_idx;
+
+		if (!pstate || !pstate->visible || !pstate->fb)
+			continue;
+
+		for (mixer_idx = 0; mixer_idx < mixer_count; mixer_idx++) {
+			struct dcp_mixer_roi *mixer = &cstate->mixer_roi[mixer_idx];
+
+			if (pstate->crtc_x >= mixer->x &&
+			    pstate->crtc_x + pstate->crtc_w <= mixer->x + mixer->w) {
+				assigned = true;
+				break;
+			}
+		}
+
+		/* Any plane may cover the complete split display. Plane type is
+		 * not a resource-selection mechanism in the universal-plane API.
+		 */
+		fullscreen = pstate->crtc_x == 0 && pstate->crtc_y == 0 &&
+			pstate->crtc_w == mode->hdisplay &&
+			pstate->crtc_h == mode->vdisplay;
+
+		if (!assigned && !fullscreen && mixer_count > 1) {
+			/*
+			 * Split-pipe/source-split and multirect allocation are
+			 * deferred until the atomic pipe resource manager is added.
+			 * Reject planes needing multiple mixer rectangles for now.
+			 */
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int dcp_crtc_atomic_check(struct drm_crtc *crtc,
+				 struct drm_atomic_commit *state)
+{
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct drm_crtc_state *crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc_state);
+	struct drm_plane *plane;
+	const struct drm_plane_state *pstate;
+	u32 max_width, max_height;
+	u32 mixer_count;
+	int num_planes = 0;
+	int ret;
+
+	drm_dbg_atomic(crtc->dev, "CRTC%u: atomic_check enable=%d active=%d mode=%s\n",
+		       crtc->base.id, crtc_state->enable, crtc_state->active,
+		       crtc_state->mode.name[0] ? crtc_state->mode.name : "none");
+
+	if (!crtc_state->enable || !crtc_state->active)
+		return 0;
+
+	mixer_count = cstate->topology_mixer_count;
+	if (mixer_count < 1 || mixer_count > DCP_MAX_MIXERS) {
+		drm_err(crtc->dev,
+			"CRTC%u: invalid mixer count %u (limit 1..%u)\n",
+				crtc->base.id, mixer_count, DCP_MAX_MIXERS);
+		return -EINVAL;
+	}
+
+	ret = dcp_crtc_setup_mixer_rois(crtc, crtc_state, cstate);
+	if (ret)
+		return ret;
+
+	dcp_mode_limits(&crtc_state->adjusted_mode,
+			dcp_kms->caps->max_width, dcp_kms->caps->max_height,
+			&max_width, &max_height);
+
+	if (crtc_state->adjusted_mode.hdisplay > max_width ||
+	    crtc_state->adjusted_mode.vdisplay > max_height) {
+		drm_err(crtc->dev, "CRTC%u: mode %dx%d exceeds DCP caps %dx%d\n",
+			crtc->base.id,
+			crtc_state->adjusted_mode.hdisplay,
+			crtc_state->adjusted_mode.vdisplay,
+			dcp_kms->caps->max_width,
+			dcp_kms->caps->max_height);
+		return -E2BIG;
+	}
+
+	/* Limit visible planes to the firmware blend-stage count. */
+	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
+		if (!pstate || !pstate->visible)
+			continue;
+		num_planes++;
+	}
+
+	if (num_planes > DCP_MAX_BLEND_STAGES) {
+		drm_err(crtc->dev, "CRTC%u: %d planes exceeds max blend stages %d\n",
+			crtc->base.id, num_planes,
+			DCP_MAX_BLEND_STAGES);
+		return -EINVAL;
+	}
+
+	dcp_crtc_aggregate_bw(crtc_state, true);
+
+	return 0;
+}
+
+static u32 dcp_crtc_get_vblank_counter(struct drm_crtc *crtc)
+{
+	return drm_crtc_vblank_count(crtc);
+}
+
+static void dcp_crtc_atomic_enable(struct drm_crtc *crtc,
+				   struct drm_atomic_commit *state)
+{
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	u32 session_id;
+	int ret;
+
+	if (!dcp_crtc_get_session(crtc, &session_id))
+		return;
+
+	ret = dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
+					  HFI_MODE_DPMS_ON);
+	if (ret) {
+		drm_err(crtc->dev, "CRTC%u: DPMS ON failed: %d\n",
+			to_dcp_crtc(crtc)->display_id, ret);
+		cstate->hfi_error = ret;
+	}
+
+	drm_crtc_vblank_on(crtc);
+}
+
+static void dcp_crtc_atomic_disable(struct drm_crtc *crtc,
+				    struct drm_atomic_commit *state)
+{
+	struct dcp_dpu_kms *dcp_kms = dcp_crtc_get_kms(crtc);
+	struct dcp_crtc_state *cstate = to_dcp_crtc_state(crtc->state);
+	u32 session_id;
+	int ret;
+
+	if (dcp_crtc_get_session(crtc, &session_id)) {
+		ret = dcp_hfi_crtc_set_bw(dcp_kms->hfi, session_id, 0, 0, 0, 0, 0);
+		if (ret) {
+			drm_err(crtc->dev,
+				"CRTC%u: clearing bandwidth vote failed: %d\n",
+				to_dcp_crtc(crtc)->display_id, ret);
+			cstate->hfi_error = ret;
+		}
+
+		ret = dcp_hfi_crtc_set_power_mode(dcp_kms->hfi, session_id,
+						  HFI_MODE_DPMS_OFF);
+		if (ret) {
+			drm_err(crtc->dev, "CRTC%u: DPMS OFF failed: %d\n",
+				to_dcp_crtc(crtc)->display_id, ret);
+			cstate->hfi_error = ret;
+		}
+	}
+
+	drm_crtc_vblank_off(crtc);
+}
+
+static const struct drm_crtc_funcs dcp_crtc_funcs = {
+	.set_config             = drm_atomic_helper_set_config,
+	.page_flip              = drm_atomic_helper_page_flip,
+	.atomic_create_state    = dcp_crtc_atomic_create_state,
+	.atomic_duplicate_state = dcp_crtc_atomic_duplicate_state,
+	.atomic_destroy_state   = dcp_crtc_atomic_destroy_state,
+	.enable_vblank          = msm_crtc_enable_vblank,
+	.disable_vblank         = msm_crtc_disable_vblank,
+	.get_vblank_counter     = dcp_crtc_get_vblank_counter,
+};
+
+static const struct drm_crtc_helper_funcs dcp_crtc_helper_funcs = {
+	.atomic_check         = dcp_crtc_atomic_check,
+	.atomic_enable        = dcp_crtc_atomic_enable,
+	.atomic_disable       = dcp_crtc_atomic_disable,
+	.atomic_begin         = dcp_crtc_atomic_begin,
+	.atomic_flush         = dcp_crtc_atomic_flush,
+	.mode_valid           = dcp_crtc_mode_valid,
+};
+
+struct drm_crtc *dcp_crtc_init(struct dcp_dpu_kms *kms,
+			       struct drm_plane *primary_plane,
+			       u32 display_id)
+{
+	struct drm_device *dev = kms->dev;
+	struct dcp_crtc *dcp_crtc;
+	int ret;
+
+	dcp_crtc = drmm_kzalloc(dev, sizeof(*dcp_crtc), GFP_KERNEL);
+	if (!dcp_crtc)
+		return ERR_PTR(-ENOMEM);
+
+	dcp_crtc->display_id = display_id;
+
+	spin_lock_init(&dcp_crtc->spin_lock);
+	init_waitqueue_head(&dcp_crtc->frame_done_wq);
+	atomic_set(&dcp_crtc->pending_kickoff_cnt, 0);
+
+	ret = drmm_crtc_init_with_planes(dev, &dcp_crtc->base,
+					 primary_plane, NULL,
+					 &dcp_crtc_funcs,
+					 NULL);
+	if (ret) {
+		drm_err(dev, "CRTC%u init failed: %d\n", display_id, ret);
+		return ERR_PTR(ret);
+	}
+
+	drm_crtc_helper_add(&dcp_crtc->base, &dcp_crtc_helper_funcs);
+
+	drm_dbg_driver(dev, "CRTC%u initialized\n", display_id);
+	return &dcp_crtc->base;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.h b/drivers/gpu/drm/msm/dcp/dcp_crtc.h
new file mode 100644
index 000000000000..ae7046e8d97a
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP CRTC implementation.
+ */
+
+#ifndef __DCP_CRTC_H__
+#define __DCP_CRTC_H__
+
+#include <linux/completion.h>
+#include <linux/spinlock.h>
+
+#include <drm/drm_crtc.h>
+
+struct dcp_dpu_kms;
+struct drm_plane;
+
+#define DCP_MAX_MIXERS 6
+#define DCP_MAX_BLEND_STAGES 12
+
+static inline void dcp_mode_limits(const struct drm_display_mode *mode,
+				   u32 cap_width, u32 cap_height,
+				   u32 *max_width, u32 *max_height)
+{
+	*max_width = cap_width;
+	*max_height = cap_height;
+
+	if (mode->hdisplay < mode->vdisplay && cap_width > cap_height) {
+		*max_width = cap_height;
+		*max_height = cap_width;
+	}
+}
+
+struct dcp_mixer_roi {
+	u32 x;
+	u32 y;
+	u32 w;
+	u32 h;
+};
+
+struct dcp_crtc {
+	struct drm_crtc base;
+	u32 display_id;
+	u32 session_id;
+	bool session_valid;
+
+	struct drm_pending_vblank_event *event;
+	wait_queue_head_t frame_done_wq;
+	atomic_t          pending_kickoff_cnt;
+	/* Protects CRTC-local vblank and commit state. */
+	spinlock_t        spin_lock;
+	u32     vblank_cb_count;
+	bool    vblank_enabled;
+	ktime_t vblank_cb_time;
+	bool    enabled;
+	u32 commit_seq_id;
+	u32 pending_seq_id;
+};
+
+struct dcp_crtc_state {
+	struct drm_crtc_state base;
+
+	u32 topology_mixer_count;
+	u32 topology_bits_per_component;
+	struct dcp_mixer_roi mixer_roi[DCP_MAX_MIXERS];
+
+	struct dcp_mixer_roi update_roi;
+	int hfi_error;
+	u64 bw_ctl;
+
+	u64 dram_ib;
+	u64 dram_ab;
+	u64 llcc_ib;
+	u64 llcc_ab;
+	u64 core_clk;
+};
+
+#define to_dcp_crtc(x)       container_of(x, struct dcp_crtc, base)
+#define to_dcp_crtc_state(x) container_of(x, struct dcp_crtc_state, base)
+
+struct drm_crtc *dcp_crtc_init(struct dcp_dpu_kms *kms,
+			       struct drm_plane *primary_plane,
+			       u32 display_id);
+
+void dcp_crtc_commit_kickoff(struct drm_crtc *crtc);
+void dcp_crtc_wait_for_commit_done(struct drm_crtc *crtc);
+void dcp_crtc_complete_commit(struct drm_crtc *crtc);
+int dcp_crtc_vblank(struct drm_crtc *crtc, bool enable);
+void dcp_crtc_vblank_callback(struct drm_crtc *crtc);
+void dcp_crtc_frame_done_callback(struct drm_crtc *crtc);
+
+struct dcp_drv;
+void dcp_crtc_hfi_vblank_cb(struct dcp_drv *drv, u32 session_id);
+void dcp_crtc_hfi_frame_done_cb(struct dcp_drv *drv, u32 session_id, u32 sequence_id);
+
+void dcp_crtc_set_session(struct drm_crtc *crtc, u32 session_id);
+void dcp_crtc_clear_session(struct drm_crtc *crtc);
+bool dcp_crtc_get_session(struct drm_crtc *crtc, u32 *session_id);
+void dcp_crtc_set_topology_state(struct drm_crtc_state *state,
+				 u32 mixer_count,
+				 u32 bits_per_component);
+
+#endif /* __DCP_CRTC_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
new file mode 100644
index 000000000000..44b1c2200aee
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP KMS driver.
+ */
+
+#include <drm/drm_crtc.h>
+
+#include "dcp_dpu_kms.h"
+
+struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
+				      u32 display_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < dcp_kms->num_crtcs; i++)
+		if (dcp_kms->crtcs[i].display_id == display_id)
+			return dcp_kms->crtcs[i].crtc;
+
+	return NULL;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
new file mode 100644
index 000000000000..f8010fc5d32f
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * DCP KMS state.
+ */
+
+#ifndef __DCP_DPU_KMS_H__
+#define __DCP_DPU_KMS_H__
+
+#include <linux/spinlock.h>
+
+#include "msm_drv.h"
+#include "msm_kms.h"
+
+struct dcp_hfi;
+struct dcp_caps;
+struct dcp_dsi_bridge;
+struct dcp_drv;
+struct drm_crtc;
+
+#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
+#define DCP_DPU_MAX_CRTCS	4
+#define DCP_DPU_MAX_PLANES	12
+
+struct dcp_dpu_kms {
+	struct msm_kms		 base;
+	struct drm_device	*dev;
+	struct device		*pm_dev;
+	struct dcp_drv		*drv;
+	struct dcp_hfi		*hfi;
+	struct dcp_caps		*caps;
+	struct device_node	*dpus_np;
+	struct device		*iommu_dev;
+	bool			 rpm_enabled;
+	bool			 commit_pm_active;
+	struct dcp_dsi_bridge	*dsi_bridge[2];
+	struct {
+		struct drm_crtc *crtc;
+		u32 display_id;
+	} crtcs[DCP_DPU_MAX_CRTCS];
+	unsigned int num_crtcs;
+};
+
+#define to_dcp_dpu_kms(x) container_of(x, struct dcp_dpu_kms, base)
+struct drm_crtc *dcp_dpu_kms_get_crtc(struct dcp_dpu_kms *dcp_kms,
+				      u32 display_id);
+int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dcp_kms,
+				     struct drm_crtc *crtc);
+
+int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms);
+extern const struct msm_kms_funcs dcp_dpu_kms_funcs;
+int dcp_kms_init(struct drm_device *ddev);
+
+#endif /* __DCP_DPU_KMS_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane_state.h b/drivers/gpu/drm/msm/dcp/dcp_plane_state.h
new file mode 100644
index 000000000000..aafa93cb69b9
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_plane_state.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP plane state definitions.
+ */
+
+#ifndef __DCP_PLANE_STATE_H__
+#define __DCP_PLANE_STATE_H__
+
+#include <drm/drm_plane.h>
+
+#define DCP_PLANE_PROP_PKT_MAX_SIZE	512
+
+struct dcp_plane_state {
+	struct drm_plane_state base;
+
+	u64 fetch_bw;
+	u64 clk;
+
+	u8     prop_pkt[DCP_PLANE_PROP_PKT_MAX_SIZE];
+	size_t prop_pkt_size;
+	u32 prop_pkt_id;
+
+	bool needs_dirtyfb;
+
+	u32 src_img_w;
+	u32 src_img_h;
+
+	u32 hfi_pipe_id;
+	u32 hfi_format;
+};
+
+#define to_dcp_plane_state(x) \
+	container_of(x, struct dcp_plane_state, base)
+
+#endif /* __DCP_PLANE_STATE_H__ */

-- 
2.43.0

