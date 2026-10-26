Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995831;
	b=EA4VrF0a4bFP/B/f/Rs+o6MaKpZiX7g2XTGcLcTn3V+SarUVXUXIf+90VbhAys8se7Cu
	 lJTxIETDrUC05DfiTUjgr0hKqFYNNBx3WIp3n8ienVVXN2A7USAxsEgbckSOGRp+BBoFX
	 tVpsvVRyTAEsghbzBTOBOfS4cnPeG4pbzMDepjt0CKEGscpQeRj4CiTYeize6JjOYNnW5
	 FvGKvoTVV2+J7/5zKIw9J5cku+qdVHogNUPSPhCFsZJkAqCryGBMCZkQoti1a8FpAu65d
	 HlJ2aIuQERkQLEblH8O08O2zib7cDuK0DFjKX/Pp1uudHbPts96I4iEbQ2PJ99XjTVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995831;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IAgLWqyLXYByXrXz4yx6gL+7DcWLmaGaZMClloREPOU=;
	b=ytwPyLlncduW58Qgj/g88GOMViu6pM5+GUbSAdpqRQROUR9WT2RmIRvLZvJrgoY8e8+G
	 +n6lqtmxMCjzimh0CLJH2jwFi6DjdaU4UzuBcATS7I8sq50f87Szi75Z52rEMdAdSGUSe
	 DB6rs4tjf88s9zEeQcDDSimcBgs6X6a9NI4BEp/6/gaoUR+meoXXs71thtScwxpLjQE3g
	 7dxB0mpJAC3QdLmg0n15z6NiZBO/IsZP/L0YfTVyNz51nZGxVqIzIYYbz3xWdj2Hp2/ON
	 IhjFQjKHCNDIU/efohGBOaYrs/jxLS8lKUdinhKajB/iQDt8/fPdXo3ZUeEE79slvkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=obyD57AM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XKPx2XSi;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADA606A31F
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14ADA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=obyD57AM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XKPx2XSi
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b43H1340479
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IAgLWqyLXYByXrXz4yx6gL+7DcWLmaGaZMClloREPOU=; b=obyD57AMGvaPXPwD
	P8PTwI7xnZ4VT86l4okPX8HybI/7Z+6yzLj605LlEiad969cjf/UbqjMm2lG3B++
	7nJGbYxOHcWKhhf3nK3k2kWn4QyYYwDNUNGaICtBVzquL6euFCOUyrCV29LJ0YYv
	HVmZeQSYUyRcSOpSeWWxDSQvvKQdU3dTRVO1Gc3mAcxr/8dC2E1Vtr1dHEk8/Sl1
	0x8EvI+hWWVs+fBTzCjc8uJBgoJ2AJcS0Rio137nB/O2QpRrBN6v+lbtN4WLgbON
	TGCnmryO4bXD3Evr6YdTSX2+yApWbhKg69GMMOYjYFy5NOl91qc/Egabh76h9fsH
	WrPNnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9vwc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9501034c4so50069065ad.0
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995828; x=1793600628; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IAgLWqyLXYByXrXz4yx6gL+7DcWLmaGaZMClloREPOU=;
        b=XKPx2XSiUxhHdsilFd+XQgpguNBNQBHGQ5byYIFU3L5Wx73ZxzzX9xzjX17ZryHfzh
         TOt3zLz9iLK2M0EX6P3QIoRJHCaVjdygdy76dmwN/h57ioAwXdd72kEUu+xUb4CP46N8
         WVaotpmdKUg/Nju/l+BD5ULqDUMPsVD8O1cMYQwfUDCDfGt3FOpLw8QtE5fEF5mn6UU0
         rx9d0vGa0Ou9UAz1I0MJc/6mMz3v6VEd4bNOO4RRk6JC2gtF04VgXmJwWRwAtzKnBhzH
         1uE9n2d3b9w5w+xW2fhFzyDf5er9FXsUx5Hf1u6mC6Utmirx5adOSFfIXOQhjvdWbVYg
         Qj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995828; x=1793600628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IAgLWqyLXYByXrXz4yx6gL+7DcWLmaGaZMClloREPOU=;
        b=WRj5xNB/V/LHF+JE6fH/sTjIoLaSpJ3LL1PgRFBRtn6BAKVNyjWHJSe1elpaZeqn5r
         f72+zvC3avblhCssUY7zbBblPg+vaoWYVizFDhQTBhDnsRk6z0WgR0BRbGkK3LyTRRo7
         6aGEHgU3SUPYWC8bhyK7aOUy5AeWRry0BfPQEDBJKcSe478ihulUazXBp6Eef5v5Yxrs
         aAgpIIl6RbbohKUP2dyWpHIDlmiRD+azAQJO9lfY4a7a+MyJc5rtXpjC4EXtPxI/i4lg
         c9qrUsf5sPjubizJi6myobhMZnAbV6L8FlxHHYEbS81cmgtYV8AgClo3z56j9dOvkSUX
         oaMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxteRc9J62dV33L3DROKGp/Udgu18hCwLAlAaxxv2eiDSkv1ziYTP/GVX+cH1eN2lZVVpfDbTruTKJz0pU8/w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJtUygVJ83ynJC8leh+295Rc+9dzo1huGCfSZgdv+UaSKSuR5Ap
	ujTvwf5YjAXt3j8pHO2KYZttvLR7cSUvTBPpV1gjzE3oeCqtQySA1jnaSzpdM8rzIZJCKb08Yge
	b/GSB7f8yqgil/1V7qGgsgB9SkWxiYzllAjMIDfg0A3zVBZan4qzE6oLH/ALqk3s2bne0cg==
X-Gm-Gg: AYBFou0418ySD5lUTg4s5MfqIDDqsYQ6KHfHiL5sV3Ov+duxfm8kj4bOmN8eB4RkyR8
	ustInwRc+BLElaUPoWetSf7KDVQCEvmV18NkW1QeFCSeZGCkd21Gqf7Gt2MyZ3DNSxlS4qkQ3Bu
	9Zapjb7wMNgzUWvEO546Ss3L2GmNV5CsT75zIcqga8EaHNgmdNjOct5zHm49BiCXUiOCSOHAmgq
	j0FyG13pZCOWfTGYhjCViZBtHEmu6t1VNTZXscveOGkuGqGndkXVjUmKv3eflGB/qojw9vo2yWT
	YZBg7VW6xYnRHD2c/MieyOueo05/sBVqOFYAjIXMhSfwCqXu+003eF7o6AZk0iHwAsGXE7jijNo
	z7QjEIlRLwhDWrpMVFmUCFjwF+g8TsFTOCQ==
X-Received: by 2002:a17:903:2389:b0:2e9:6788:9379 with SMTP id d9443c01a7336-2ea9c821072mr46552815ad.32.1792995828183;
        Sun, 25 Oct 2026 23:23:48 -0700 (PDT)
X-Received: by 2002:a17:903:2389:b0:2e9:6788:9379 with SMTP id d9443c01a7336-2ea9c821072mr46552725ad.32.1792995827544;
        Sun, 25 Oct 2026 23:23:47 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:23:47 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:22 +0530
Subject: [PATCH v2 12/23] drm/msm/dcp: Add DCP planes
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-12-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=36458;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=uUt8RDPi9RIiliGe+JdCUOIu/0UDVUEDmEwoNwNGLYE=;
 b=nCjJfIBp8cFfarIoLhGQrb1ioim8cqPxLU7zAOZ/TbnNnPOBzkj4Gwx6tw2MXPV6C1vQpUZDs
 glTJuaX7+a4AqSgUDGiiRF3KUCEe96iwMziIc4FpRhlSfyZSmGTNgK9
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: AumQFGA5KUlfASliRlpEbW1XJd-6ca7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX/IDKHnEwMjeV
 ec0XANEvO09QVxe8tPtIc48MNsXhmoACWLLGkUlogMIdNv6cLAf9sI1ZEa1fjb0RudCl/fL7MnX
 wXfhYjdCblOAXe/rFzkbCWTGoaVuQZf8U5oKhuuUpJDccn4zkB+qTzO3mmqCD573mY1aypoprMc
 c+SRrk6DcK/L8tLdVUEYzTMxrsUa9nJHbXcTCSQbBaLa8d3MgmwtZ1FlG/VYmqN1kNUyi+EAt3F
 OxHRDcFiax229DDv5phay7W8FyWeIs2ukoctfsl8ty3QAW0SNw8fENg2VJe9ReWCnLE0/yXhxdJ
 +0DyvTky4aQsFLUHMtH5W4Izpz+T0IS+wkmXSe8z7ou4VtRO/ZzRYRVoYysORt4JTaJH0fgwHut
 PqYKdzeY963coBFTWIn46syqkyKfTNku1Rf0bzf0FEwulAJcaGNb03RH4CHxiNm6Fhl8+bJfC5W
 wc1Js7qh3pMp3wSlswA==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adef1f5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=zMfg28cwe5JNWI1n_8oA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: AumQFGA5KUlfASliRlpEbW1XJd-6ca7b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX/EBARVkIFPV6
 5X9en6lNGZl/KAOX4N6PIP8aLwfrZE+R3x0cmXlpWmZvTqIJAEhv5M7WltDZpf0UJoQW5horDFL
 5oodfkA98uS1gCi5NzWOGqsUjiir+iw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Expose DCP overlay planes through the DRM plane API. Userspace needs
normal atomic plane state while the firmware-owned pipeline requires
validated formats, assigned pipes, mapped buffers, bandwidth votes,
and HFI property packets.

Implement plane validation, format and scaling checks, firmware pipe
assignment, framebuffer mapping, bandwidth calculation, atomic state
handling, and HFI updates and disables.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile        |    1 +
 drivers/gpu/drm/msm/dcp/dcp_plane.c | 1056 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_plane.h |   36 ++
 3 files changed, 1093 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 80341ce07d53..b425fefda890 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -74,6 +74,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_crtc.o \
 	dcp/dcp_dpu_kms.o \
+	dcp/dcp_plane.o \
 	dcp/dcp_hfi_core.o \
 	dcp/dcp_hfi_crtc.o \
 	dcp/dcp_hfi_dsi.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.c b/drivers/gpu/drm/msm/dcp/dcp_plane.c
new file mode 100644
index 000000000000..af8aa2162b03
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_plane.c
@@ -0,0 +1,1056 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP plane state validation and HFI property packet construction.
+ */
+
+#include <linux/math64.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_rect.h>
+
+#include "msm_drv.h"
+
+#include "dcp_crtc.h"
+#include "dcp_hfi.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_plane.h"
+
+#define DCP_ZPOS_MAX			255
+#define DCP_MAX_IMG_WIDTH		0x3FFF
+#define DCP_MAX_IMG_HEIGHT		0x3FFF
+#define DCP_SSPP_MAX_PITCH_SIZE	0xFF00
+#define DCP_MAX_UPSCALE_RATIO	20
+#define DCP_MAX_DOWNSCALE_RATIO	4
+
+static const u32 dcp_plane_formats[] = {
+	DRM_FORMAT_ARGB8888, DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBX8888, DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB888,   DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,   DRM_FORMAT_BGR565,
+	DRM_FORMAT_ARGB1555, DRM_FORMAT_ABGR1555,
+	DRM_FORMAT_RGBA5551, DRM_FORMAT_BGRA5551,
+	DRM_FORMAT_XRGB1555, DRM_FORMAT_XBGR1555,
+	DRM_FORMAT_RGBX5551, DRM_FORMAT_BGRX5551,
+	DRM_FORMAT_ARGB4444, DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_RGBA4444, DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_XRGB4444, DRM_FORMAT_XBGR4444,
+	DRM_FORMAT_RGBX4444, DRM_FORMAT_BGRX4444,
+	DRM_FORMAT_ARGB2101010, DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_ABGR2101010, DRM_FORMAT_XBGR2101010,
+	DRM_FORMAT_NV12, DRM_FORMAT_NV21,
+	DRM_FORMAT_P010, DRM_FORMAT_YUV420, DRM_FORMAT_YVU420,
+};
+
+static const u64 dcp_format_modifiers[] = {
+	DRM_FORMAT_MOD_QCOM_COMPRESSED,
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID,
+};
+
+static struct dcp_dpu_kms *_dcp_plane_get_kms(struct drm_plane *plane)
+{
+	struct msm_drm_private *priv = plane->dev->dev_private;
+
+	return to_dcp_dpu_kms(priv->kms);
+}
+
+static bool dcp_plane_hfi_pipe_valid(struct dcp_dpu_kms *dcp_kms, u32 pipe_id)
+{
+	const struct dcp_caps *caps;
+	u32 i;
+
+	if (!dcp_kms->caps)
+		return false;
+
+	caps = dcp_kms->caps;
+	for (i = 0; i < caps->num_vig_pipes; i++)
+		if (caps->vig_pipe_ids[i] == pipe_id)
+			return true;
+
+	for (i = 0; i < caps->num_dma_pipes; i++)
+		if (caps->dma_pipe_ids[i] == pipe_id)
+			return true;
+
+	return false;
+}
+
+static bool dcp_plane_pipe_is_vig(const struct dcp_caps *caps, u32 pipe_id)
+{
+	u32 i;
+
+	for (i = 0; i < caps->num_vig_pipes; i++)
+		if (caps->vig_pipe_ids[i] == pipe_id)
+			return true;
+
+	return false;
+}
+
+static bool dcp_plane_pipe_busy(struct drm_atomic_commit *state,
+				struct drm_plane *self, u32 pipe_id)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *plane_state;
+	struct drm_plane *iter_plane;
+	struct drm_plane_state *new_plane_state;
+	int i;
+
+	drm_for_each_plane(plane, state->dev) {
+		if (plane == self)
+			continue;
+
+		plane_state = plane->state;
+		for_each_new_plane_in_state(state, iter_plane, new_plane_state, i) {
+			if (iter_plane == plane) {
+				plane_state = new_plane_state;
+				break;
+			}
+		}
+
+		if (plane_state && plane_state->crtc && plane_state->visible &&
+		    to_dcp_plane_state(plane_state)->hfi_pipe_id == pipe_id)
+			return true;
+	}
+
+	return false;
+}
+
+static u32 dcp_plane_assign_pipe(struct dcp_dpu_kms *dcp_kms,
+				 struct drm_atomic_commit *state,
+				 struct drm_plane *plane,
+				 struct dcp_plane_state *pstate,
+				 bool yuv, bool scaling)
+{
+	const struct dcp_caps *caps = dcp_kms->caps;
+	u32 i, pipe_id;
+
+	/* YUV scanout requires a VIG pipe with the CSC path. */
+	if (dcp_plane_hfi_pipe_valid(dcp_kms, pstate->hfi_pipe_id) &&
+	    (!yuv || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
+	    (!scaling || dcp_plane_pipe_is_vig(caps, pstate->hfi_pipe_id)) &&
+	    !dcp_plane_pipe_busy(state, plane, pstate->hfi_pipe_id))
+		return pstate->hfi_pipe_id;
+
+	/*
+	 * R1/virtual pipes are intentionally not allocated as independent
+	 * planes yet. They require transactional physical-pipe/R1 ownership
+	 * and multirect programming, which will be added with the resource
+	 * manager.
+	 */
+	for (i = 0; i < caps->num_vig_pipes; i++) {
+		pipe_id = caps->vig_pipe_ids[i];
+		if (!dcp_plane_pipe_busy(state, plane, pipe_id))
+			return pipe_id;
+	}
+
+	if (yuv || scaling)
+		return U32_MAX;
+
+	for (i = 0; i < caps->num_dma_pipes; i++) {
+		pipe_id = caps->dma_pipe_ids[i];
+		if (!dcp_plane_pipe_busy(state, plane, pipe_id))
+			return pipe_id;
+	}
+
+	return U32_MAX;
+}
+
+static const struct {
+	u32 fourcc;
+	u64 modifier;
+	u32 hfi_fmt;
+} dcp_fmt_table[] = {
+	{ DRM_FORMAT_ABGR8888,    DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGBA8888 },
+	{ DRM_FORMAT_XBGR8888,    DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGBX8888 },
+	{ DRM_FORMAT_ABGR2101010, DRM_FORMAT_MOD_QCOM_COMPRESSED,
+		HFI_COLOR_FORMAT_UBWC_RGBA10_10_10_2 },
+	{ DRM_FORMAT_XBGR2101010, DRM_FORMAT_MOD_QCOM_COMPRESSED,
+		HFI_COLOR_FORMAT_UBWC_RGBX10_10_10_2 },
+	{ DRM_FORMAT_BGR565,      DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_RGB565 },
+	{ DRM_FORMAT_NV12,        DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_NV12 },
+	{ DRM_FORMAT_P010,        DRM_FORMAT_MOD_QCOM_COMPRESSED, HFI_COLOR_FORMAT_UBWC_P010 },
+
+	{ DRM_FORMAT_RGB565,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGR565 },
+	{ DRM_FORMAT_BGR565,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGB565 },
+	{ DRM_FORMAT_RGB888,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGR888 },
+	{ DRM_FORMAT_BGR888,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGB888 },
+	{ DRM_FORMAT_ARGB8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA8888 },
+	{ DRM_FORMAT_ABGR8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA8888 },
+	{ DRM_FORMAT_RGBA8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR8888 },
+	{ DRM_FORMAT_BGRA8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB8888 },
+	{ DRM_FORMAT_XRGB8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX8888 },
+	{ DRM_FORMAT_XBGR8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX8888 },
+	{ DRM_FORMAT_RGBX8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR8888 },
+	{ DRM_FORMAT_BGRX8888,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB8888 },
+	{ DRM_FORMAT_ARGB2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA10_10_10_2 },
+	{ DRM_FORMAT_ABGR2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA10_10_10_2 },
+	{ DRM_FORMAT_RGBA1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR2_10_10_10 },
+	{ DRM_FORMAT_BGRA1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB2_10_10_10 },
+	{ DRM_FORMAT_XRGB2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX10_10_10_2 },
+	{ DRM_FORMAT_XBGR2101010,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX10_10_10_2 },
+	{ DRM_FORMAT_RGBX1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR2_10_10_10 },
+	{ DRM_FORMAT_BGRX1010102,  DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB2_10_10_10 },
+	{ DRM_FORMAT_ARGB1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA5551 },
+	{ DRM_FORMAT_ABGR1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA5551 },
+	{ DRM_FORMAT_RGBA5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR1555 },
+	{ DRM_FORMAT_BGRA5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB1555 },
+	{ DRM_FORMAT_XRGB1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX5551 },
+	{ DRM_FORMAT_XBGR1555,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX5551 },
+	{ DRM_FORMAT_RGBX5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR1555 },
+	{ DRM_FORMAT_BGRX5551,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB1555 },
+	{ DRM_FORMAT_ARGB4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRA4444 },
+	{ DRM_FORMAT_ABGR4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBA4444 },
+	{ DRM_FORMAT_RGBA4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ABGR4444 },
+	{ DRM_FORMAT_BGRA4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_ARGB4444 },
+	{ DRM_FORMAT_XRGB4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_BGRX4444 },
+	{ DRM_FORMAT_XBGR4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_RGBX4444 },
+	{ DRM_FORMAT_RGBX4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XBGR4444 },
+	{ DRM_FORMAT_BGRX4444,     DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_XRGB4444 },
+	{ DRM_FORMAT_YUV420,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_YU12 },
+	{ DRM_FORMAT_YVU420,       DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_YV12 },
+	{ DRM_FORMAT_NV12,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_NV12 },
+	{ DRM_FORMAT_NV21,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_NV21 },
+	{ DRM_FORMAT_P010,         DRM_FORMAT_MOD_LINEAR, HFI_COLOR_FORMAT_P010 },
+};
+
+static u32 dcp_drm_to_hfi_format(u32 fourcc, u64 modifier)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dcp_fmt_table); i++) {
+		if (dcp_fmt_table[i].fourcc == fourcc &&
+		    dcp_fmt_table[i].modifier == modifier)
+			return dcp_fmt_table[i].hfi_fmt;
+	}
+
+	return U32_MAX;
+}
+
+static u32 dcp_drm_to_hfi_rotation(u32 drm_rotation)
+{
+	u32 hfi_rot = 0;
+
+	if (drm_rotation & DRM_MODE_ROTATE_0)
+		hfi_rot |= HFI_DISPLAY_ROTATION_0;
+	if (drm_rotation & DRM_MODE_ROTATE_90)
+		hfi_rot |= HFI_DISPLAY_ROTATION_90;
+	if (drm_rotation & DRM_MODE_ROTATE_180)
+		hfi_rot |= HFI_DISPLAY_ROTATION_180;
+	if (drm_rotation & DRM_MODE_ROTATE_270)
+		hfi_rot |= HFI_DISPLAY_ROTATION_270;
+	if (drm_rotation & DRM_MODE_REFLECT_X)
+		hfi_rot |= HFI_DISPLAY_REFLECT_X;
+	if (drm_rotation & DRM_MODE_REFLECT_Y)
+		hfi_rot |= HFI_DISPLAY_REFLECT_Y;
+
+	if (!hfi_rot)
+		hfi_rot = HFI_DISPLAY_ROTATION_0;
+
+	return hfi_rot;
+}
+
+static u32 dcp_drm_to_hfi_blend_op(u32 drm_blend_mode)
+{
+	switch (drm_blend_mode) {
+	case DRM_MODE_BLEND_PIXEL_NONE:	return HFI_BLEND_OP_OPAQUE;
+	case DRM_MODE_BLEND_PREMULTI:	return HFI_BLEND_OP_PREMULTIPLIED;
+	case DRM_MODE_BLEND_COVERAGE:	return HFI_BLEND_OP_COVERAGE;
+	default:			return HFI_BLEND_OP_NOT_DEFINED;
+	}
+}
+
+static u16 dcp_compute_bg_alpha(u32 pixel_blend_mode, u16 fg_alpha)
+{
+	switch (pixel_blend_mode) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		return DRM_BLEND_ALPHA_OPAQUE - fg_alpha;
+	case DRM_MODE_BLEND_PREMULTI:
+	case DRM_MODE_BLEND_COVERAGE:
+		return (fg_alpha != DRM_BLEND_ALPHA_OPAQUE) ? fg_alpha : 0;
+	default:
+		return DRM_BLEND_ALPHA_OPAQUE;
+	}
+}
+
+static u32 dcp_hfi_scale_alpha(const struct drm_plane_state *state, u32 alpha)
+{
+	if (to_dcp_crtc_state(state->crtc->state)->topology_bits_per_component >= 10)
+		return alpha;
+
+	return alpha << 8;
+}
+
+static u64 dcp_plane_calc_bw(u32 bpp,
+			     const struct drm_display_mode *mode,
+			     const struct drm_rect *src,
+			     const struct drm_rect *dst)
+{
+	int src_w = drm_rect_width(src) >> 16;
+	int src_h = drm_rect_height(src) >> 16;
+	int dst_h = drm_rect_height(dst);
+	int fps   = drm_mode_vrefresh(mode);
+	int vbp   = mode->vtotal - mode->vsync_end;
+	int vpw   = mode->vsync_end - mode->vsync_start;
+	int vfp   = mode->vsync_start - mode->vdisplay;
+	u32 hw_latency = 25;
+	u64 scale_factor = (src_h > dst_h) ? mult_frac(src_h, 1, dst_h) : 1;
+	u64 plane_bw, prefill_bw;
+
+	plane_bw = (u64)src_w * mode->vtotal * fps * bpp * scale_factor;
+	prefill_bw = plane_bw * hw_latency;
+
+	if ((vbp + vpw) > hw_latency)
+		do_div(prefill_bw, (vbp + vpw));
+	else if ((vbp + vpw + vfp) < hw_latency)
+		do_div(prefill_bw, (vbp + vpw + vfp));
+	else
+		do_div(prefill_bw, hw_latency);
+
+	/* HFI DRAM/LLCC votes are expressed in Kbps. */
+	return div_u64(max(plane_bw, prefill_bw), 1000);
+}
+
+static u64 dcp_plane_calc_clk(const struct drm_display_mode *mode,
+			      const struct drm_rect *src,
+			      const struct drm_rect *dst)
+{
+	int src_h = drm_rect_height(src) >> 16;
+	int dst_w = drm_rect_width(dst);
+	int dst_h = drm_rect_height(dst);
+	int fps   = drm_mode_vrefresh(mode);
+	u64 clk   = (u64)dst_w * mode->vtotal * fps;
+
+	if (src_h > dst_h) {
+		clk *= src_h;
+		do_div(clk, dst_h);
+	}
+	return clk;
+}
+
+void dcp_plane_calc_perf(const struct drm_plane_state *state,
+			 const struct drm_display_mode *mode,
+			 struct dcp_plane_perf *perf)
+{
+	struct drm_rect src, dst;
+	u32 bpp;
+
+	memset(perf, 0, sizeof(*perf));
+
+	if (!state || !state->visible || !state->fb || !mode || !mode->clock ||
+	    !drm_mode_vrefresh(mode))
+		return;
+
+	src = drm_plane_state_src(state);
+	dst = drm_plane_state_dest(state);
+	bpp = drm_format_info_bpp(state->fb->format, 0);
+
+	perf->fetch_bw = dcp_plane_calc_bw(bpp, mode, &src, &dst);
+	perf->clk = dcp_plane_calc_clk(mode, &src, &dst);
+}
+
+static inline u32 *prop_u32(u32 *p, u32 prop_id, u32 lid, u32 val)
+{
+	*p++ = HFI_PACK_KEY(prop_id, 0, 2);
+	*p++ = lid;
+	*p++ = val;
+	return p;
+}
+
+static inline u32 *prop_roi(u32 *p, u32 prop_id, u32 lid,
+			    u32 x, u32 y, u32 w, u32 h)
+{
+	*p++ = HFI_PACK_KEY(prop_id, 0, 5);
+	*p++ = lid;
+	*p++ = x; *p++ = y; *p++ = w; *p++ = h;
+	return p;
+}
+
+static inline u32 *prop_attach(u32 *p, u32 lid)
+{
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_DISPLAY_ATTACH_LAYER, 0, 1);
+	*p++ = lid;
+	return p;
+}
+
+static inline u32 *prop_src_addr(u32 *p, u32 lid,
+				 const dma_addr_t *iova, u32 hfi_fmt)
+{
+	/* The firmware format is struct hfi_plane_buff: all low words,
+	 * followed by all high words, then the common descriptor fields.
+	 */
+	p += HFI_PACK(p, HFI_PROPERTY_LAYER_SRC_ADDR, lid,
+		      lower_32_bits(iova[0]), lower_32_bits(iova[1]),
+		      lower_32_bits(iova[2]), lower_32_bits(iova[3]),
+		      upper_32_bits(iova[0]), upper_32_bits(iova[1]),
+		      upper_32_bits(iova[2]), upper_32_bits(iova[3]),
+		      0, 0, 0, hfi_fmt);
+	return p;
+}
+
+static inline u32 *prop_stride(u32 *p, u32 lid, const u32 *pitches)
+{
+	int i;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_LAYER_STRIDE, 0, 5);
+	*p++ = lid;
+	for (i = 0; i < 4; i++)
+		*p++ = pitches[i];
+	return p;
+}
+
+static inline u32 *prop_cache_attr(u32 *p, u32 lid, u32 state, u32 op)
+{
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_LAYER_CACHE_ATTR, 0, 3);
+	*p++ = lid;
+	*p++ = state;
+	*p++ = op;
+	return p;
+}
+
+static int dcp_plane_build_one_hfi_props_packet(struct dcp_plane_state *pstate,
+						const struct drm_plane_state *state,
+						u32 session_id, u32 packet_id,
+						u8 *packet)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct hfi_cmd_buff_hdl hdl;
+	struct hfi_header_info hdr_info;
+	struct hfi_packet_info pkt_info;
+	u32 payload[DCP_PLANE_PROP_PKT_MAX_SIZE / sizeof(u32)];
+	u32 *p = payload;
+	u32 *num_props_ptr;
+	u32 num_props = 0;
+	u32 hfi_format;
+	u32 hfi_rotation;
+	u32 hfi_blend_op;
+	u32 pitches[4] = { 0 };
+	dma_addr_t fb_iova[HFI_MAX_PLANES] = { 0 };
+	u32 src_x, src_y, src_w, src_h;
+	u32 dst_x, dst_y, dst_w, dst_h;
+	u32 hfi_alpha, hfi_bg_alpha;
+	u32 lid = pstate->hfi_pipe_id;
+	int i, ret;
+	u32 payload_words;
+
+	hfi_format = pstate->hfi_format;
+
+	hfi_rotation = dcp_drm_to_hfi_rotation(state->rotation);
+	hfi_blend_op = dcp_drm_to_hfi_blend_op(state->pixel_blend_mode);
+
+	src_x = state->src_x >> 16;
+	src_y = state->src_y >> 16;
+	src_w = state->src_w >> 16;
+	src_h = state->src_h >> 16;
+	dst_x = state->crtc_x;
+	dst_y = state->crtc_y;
+	dst_w = state->crtc_w;
+	dst_h = state->crtc_h;
+
+	hfi_alpha = dcp_hfi_scale_alpha(state, state->alpha);
+	hfi_bg_alpha = dcp_hfi_scale_alpha(state,
+					   dcp_compute_bg_alpha(state->pixel_blend_mode,
+								state->alpha));
+
+	for (i = 0; i < 4 && i < fb->format->num_planes; i++)
+		pitches[i] = fb->pitches[i];
+
+	for (i = 0; i < HFI_MAX_PLANES && i < fb->format->num_planes; i++)
+		fb_iova[i] = msm_framebuffer_iova(fb, i);
+
+	num_props_ptr = p++;
+
+	p = prop_roi(p, HFI_PROPERTY_LAYER_SRC_ROI, lid,
+		     src_x, src_y, src_w, src_h);
+	num_props++;
+
+	p = prop_roi(p, HFI_PROPERTY_LAYER_DEST_ROI, lid,
+		     dst_x, dst_y, dst_w, dst_h);
+	num_props++;
+
+	p = prop_attach(p, lid);
+	num_props++;
+
+	p = prop_src_addr(p, lid, fb_iova, hfi_format);
+	num_props++;
+
+	p = prop_stride(p, lid, pitches);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_FORMAT, lid, hfi_format);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_ROTATION, lid, hfi_rotation);
+	num_props++;
+
+	p = prop_cache_attr(p, lid,
+			    HFI_CACHE_STATE_DISABLE,
+			    HFI_CACHE_OP_TYPE_NONE);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_ZPOS, lid,
+		     state->normalized_zpos);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_ALPHA, lid, hfi_alpha);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_BG_ALPHA, lid, hfi_bg_alpha);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_BLEND_TYPE, lid, hfi_blend_op);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_IMG_SIZE_W, lid,
+		     pstate->src_img_w);
+	num_props++;
+
+	p = prop_u32(p, HFI_PROPERTY_LAYER_SRC_IMG_SIZE_H, lid,
+		     pstate->src_img_h);
+	num_props++;
+
+	*num_props_ptr = num_props;
+
+	payload_words = p - payload;
+
+	hdl.cmd_buffer = packet;
+	hdl.size       = DCP_PLANE_PROP_PKT_MAX_SIZE;
+
+	hdr_info.num_packets   = 0;
+	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info.object_id     = session_id;
+	hdr_info.header_id     = packet_id;
+
+	ret = hfi_create_header(&hdl, &hdr_info);
+	if (ret)
+		return ret;
+
+	pkt_info.cmd          = HFI_COMMAND_DISPLAY_SET_PROPERTY;
+	pkt_info.id           = session_id & 0xFFFF;
+	pkt_info.flags        = HFI_TX_FLAGS_NON_DISCARDABLE;
+	pkt_info.packet_id    = packet_id;
+	pkt_info.payload_type = HFI_PAYLOAD_U32_ARRAY;
+	pkt_info.payload_size = payload_words * sizeof(u32);
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl, &pkt_info);
+	if (ret) {
+		pstate->prop_pkt_size = 0;
+		return ret;
+	}
+
+	pstate->prop_pkt_size = hfi_get_header_size(&hdl);
+
+	drm_dbg_driver(state->plane->dev,
+		       "DCP_COMMIT p=%u pipe=%u src=%ux%u+%ux%u dst=%ux%u+%ux%u fmt=0x%x mod=0x%llx alpha=%u bg_alpha=%u props=%u words=%u size=%zu\n",
+		       state->plane->base.id, lid, src_x, src_y, src_w, src_h,
+		       dst_x, dst_y, dst_w, dst_h, hfi_format, fb->modifier,
+		       hfi_alpha, hfi_bg_alpha, num_props, payload_words,
+		       pstate->prop_pkt_size);
+	return 0;
+}
+
+static int dcp_plane_build_hfi_props_packet(struct dcp_plane_state *pstate,
+					    const struct drm_plane_state *state,
+					    u32 session_id, u32 packet_id)
+{
+	int ret;
+
+	pstate->prop_pkt_size = 0;
+
+	ret = dcp_plane_build_one_hfi_props_packet(pstate, state, session_id,
+						   packet_id, pstate->prop_pkt);
+	return ret;
+}
+
+static int dcp_plane_prepare_fb(struct drm_plane *plane,
+				struct drm_plane_state *new_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	int ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: prepare_fb fb=%u\n",
+		       plane->base.id,
+		       new_state->fb ? new_state->fb->base.id : 0);
+
+	if (!new_state->fb)
+		return 0;
+
+	ret = drm_gem_plane_helper_prepare_fb(plane, new_state);
+	if (ret)
+		return ret;
+
+	ret = msm_framebuffer_prepare(new_state->fb, pstate->needs_dirtyfb);
+	if (ret) {
+		drm_err(plane->dev, "plane%u: framebuffer prepare failed: %d\n",
+			plane->base.id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void dcp_plane_cleanup_fb(struct drm_plane *plane,
+				 struct drm_plane_state *old_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: cleanup_fb fb=%u\n",
+		       plane->base.id,
+		       old_state->fb ? old_state->fb->base.id : 0);
+
+	if (!old_state->fb)
+		return;
+
+	msm_framebuffer_cleanup(old_state->fb, pstate->needs_dirtyfb);
+}
+
+static int dcp_plane_atomic_check(struct drm_plane *plane,
+				  struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
+	struct drm_crtc_state *crtc_state;
+	struct drm_rect src;
+	struct drm_rect fb_rect = { 0 };
+	u32 max_width, max_height;
+	int min_scale = DRM_PLANE_NO_SCALING;
+	int max_scale = DRM_PLANE_NO_SCALING;
+	bool scaling;
+	int ret, i;
+	struct dcp_plane_perf perf;
+
+	drm_dbg_driver(plane->dev,
+		       "DCP_CHECK plane%u pipe=%u src=(%u,%u %ux%u) dst=(%d,%d %ux%u)\n",
+			plane->base.id, pstate->hfi_pipe_id,
+			new_state->src_x >> 16, new_state->src_y >> 16,
+			new_state->src_w >> 16, new_state->src_h >> 16,
+			new_state->crtc_x, new_state->crtc_y,
+			new_state->crtc_w, new_state->crtc_h);
+
+	pstate->prop_pkt_size = 0;
+	pstate->fetch_bw = 0;
+	pstate->clk = 0;
+
+	if (!new_state->crtc)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
+	if (IS_ERR(crtc_state)) {
+		ret = PTR_ERR(crtc_state);
+		drm_err(plane->dev, "plane%u: failed to get CRTC state: %d\n",
+			plane->base.id, ret);
+		return ret;
+	}
+
+	if (!new_state->fb)
+		return 0;
+
+	scaling = new_state->src_w != ((u32)new_state->crtc_w << 16) ||
+			  new_state->src_h != ((u32)new_state->crtc_h << 16);
+
+	pstate->hfi_pipe_id = dcp_plane_assign_pipe(dcp_kms, state, plane,
+						    pstate, new_state->fb->format->is_yuv,
+						    scaling);
+	if (pstate->hfi_pipe_id == U32_MAX) {
+		drm_err(plane->dev, "plane%u: no compatible HFI pipe available\n",
+			plane->base.id);
+		return -ENOSPC;
+	}
+
+	if (dcp_plane_pipe_is_vig(dcp_kms->caps, pstate->hfi_pipe_id)) {
+		min_scale = FRAC_16_16(1, DCP_MAX_UPSCALE_RATIO);
+		max_scale = DCP_MAX_DOWNSCALE_RATIO << 16;
+	}
+
+	ret = drm_atomic_helper_check_plane_state(new_state, crtc_state,
+						  min_scale, max_scale,
+						  true, true);
+	if (ret) {
+		drm_err(plane->dev, "plane%u: plane state check failed: %d\n",
+			plane->base.id, ret);
+		return ret;
+	}
+
+	if (!new_state->visible)
+		return 0;
+	if (new_state->crtc_x < 0 || new_state->crtc_y < 0 ||
+	    new_state->crtc_w <= 0 || new_state->crtc_h <= 0 ||
+	    (u64)new_state->crtc_x + new_state->crtc_w >
+			crtc_state->adjusted_mode.hdisplay ||
+	    (u64)new_state->crtc_y + new_state->crtc_h >
+			crtc_state->adjusted_mode.vdisplay) {
+		drm_err(plane->dev,
+			"plane%u: destination out of bounds: (%d,%d %ux%u), mode %ux%u\n",
+			plane->base.id, new_state->crtc_x, new_state->crtc_y,
+			new_state->crtc_w, new_state->crtc_h,
+			crtc_state->adjusted_mode.hdisplay,
+			crtc_state->adjusted_mode.vdisplay);
+		return -EINVAL;
+	}
+
+	if (new_state->normalized_zpos >= DCP_MAX_BLEND_STAGES) {
+		drm_err(plane->dev,
+			"plane%u: zpos %u exceeds blend stages %u\n",
+			plane->base.id, new_state->normalized_zpos,
+			DCP_MAX_BLEND_STAGES);
+		return -EINVAL;
+	}
+
+	dcp_plane_calc_perf(new_state, &crtc_state->adjusted_mode, &perf);
+	pstate->fetch_bw = perf.fetch_bw;
+	pstate->clk = perf.clk;
+
+	pstate->hfi_format = dcp_drm_to_hfi_format(new_state->fb->format->format,
+						   new_state->fb->modifier);
+	if (pstate->hfi_format == U32_MAX) {
+		drm_dbg_atomic(plane->dev, "plane%u: unsupported format 0x%x mod 0x%llx\n",
+			       plane->base.id,
+				 new_state->fb->format->format,
+				 new_state->fb->modifier);
+		drm_err(plane->dev,
+			"plane%u: unsupported format 0x%x modifier 0x%llx\n",
+			plane->base.id, new_state->fb->format->format,
+			new_state->fb->modifier);
+		return -EINVAL;
+	}
+
+	fb_rect.x2 = new_state->fb->width;
+	fb_rect.y2 = new_state->fb->height;
+
+	if (drm_rect_width(&fb_rect) > DCP_MAX_IMG_WIDTH ||
+	    drm_rect_height(&fb_rect) > DCP_MAX_IMG_HEIGHT) {
+		drm_err(plane->dev,
+			"plane%u: framebuffer too large: %ux%u (limit %ux%u)\n",
+			plane->base.id, new_state->fb->width, new_state->fb->height,
+			DCP_MAX_IMG_WIDTH, DCP_MAX_IMG_HEIGHT);
+		return -E2BIG;
+	}
+
+	dcp_mode_limits(&crtc_state->adjusted_mode,
+			dcp_kms->caps->max_width, dcp_kms->caps->max_height,
+			&max_width, &max_height);
+
+	if (new_state->fb->width > max_width ||
+	    new_state->fb->height > max_height) {
+		drm_err(plane->dev,
+			"plane%u: framebuffer %ux%u exceeds caps %ux%u\n",
+			plane->base.id, new_state->fb->width, new_state->fb->height,
+			dcp_kms->caps->max_width, dcp_kms->caps->max_height);
+		return -E2BIG;
+	}
+
+	for (i = 0; i < new_state->fb->format->num_planes; i++) {
+		if (new_state->fb->pitches[i] > DCP_SSPP_MAX_PITCH_SIZE) {
+			drm_err(plane->dev,
+				"plane%u: pitch[%d]=%u exceeds limit %u\n",
+				plane->base.id, i, new_state->fb->pitches[i],
+				DCP_SSPP_MAX_PITCH_SIZE);
+			return -E2BIG;
+		}
+	}
+
+	src = drm_plane_state_src(new_state);
+
+	pstate->src_img_w = new_state->fb->width;
+	pstate->src_img_h = new_state->fb->height;
+
+	if (new_state->fb->format->is_yuv) {
+		u32 src_x = src.x1 >> 16;
+		u32 src_y = src.y1 >> 16;
+		u32 src_w = drm_rect_width(&src) >> 16;
+		u32 src_h = drm_rect_height(&src) >> 16;
+
+		if (src_w < 2 || src_h < 2) {
+			drm_err(plane->dev,
+				"plane%u: YUV source too small: %ux%u\n",
+				plane->base.id, src_w, src_h);
+			return -EINVAL;
+		}
+
+		if (src_x & 0x1 || src_y & 0x1 || src_w & 0x1 || src_h & 0x1) {
+			drm_err(plane->dev,
+				"plane%u: unaligned YUV source: (%u,%u %ux%u)\n",
+				plane->base.id, src_x, src_y, src_w, src_h);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void dcp_plane_set_hfi_error(const struct drm_plane_state *state, int ret)
+{
+	struct dcp_crtc_state *cstate;
+
+	cstate = to_dcp_crtc_state(state->crtc->state);
+	if (!cstate->hfi_error)
+		cstate->hfi_error = ret;
+}
+
+static int dcp_plane_submit_update(struct drm_plane *plane,
+				   struct drm_plane_state *new_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
+	u32 session_id;
+	int ret;
+
+	if (!dcp_crtc_get_session(new_state->crtc, &session_id)) {
+		drm_dbg_driver(plane->dev,
+			       "plane%u: update before HFI session open, deferring\n",
+			       plane->base.id);
+		return 0;
+	}
+
+	pstate->prop_pkt_id =
+		(u32)atomic_inc_return(&dcp_kms->hfi->packet_id);
+
+	ret = dcp_plane_build_hfi_props_packet(pstate, new_state, session_id,
+					       pstate->prop_pkt_id);
+	if (ret)
+		return ret;
+
+	ret = dcp_hfi_submit_prop_pkt(dcp_kms->hfi, pstate->prop_pkt,
+				      pstate->prop_pkt_size);
+	if (ret)
+		return ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: submitted HFI update pipe=%u bytes=%zu\n",
+		       plane->base.id, pstate->hfi_pipe_id, pstate->prop_pkt_size);
+
+	return 0;
+}
+
+static int dcp_plane_submit_disable(struct drm_plane *plane,
+				    struct drm_plane_state *old_state)
+{
+	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
+	struct dcp_dpu_kms *dcp_kms = _dcp_plane_get_kms(plane);
+	u32 session_id;
+
+	if (!old_state->crtc)
+		return 0;
+
+	if (!dcp_crtc_get_session(old_state->crtc, &session_id)) {
+		drm_dbg_driver(plane->dev,
+			       "plane%u: disable after HFI session close, skipping detach\n",
+			       plane->base.id);
+		return 0;
+	}
+
+	return dcp_hfi_plane_disable(dcp_kms->hfi, session_id,
+				     pstate->hfi_pipe_id);
+}
+
+static void dcp_plane_atomic_update(struct drm_plane *plane,
+				    struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct dcp_plane_state *pstate = to_dcp_plane_state(new_state);
+	int ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: atomic_update visible=%d fb=%u pipe_id=%u\n",
+		       plane->base.id, new_state->visible,
+		       new_state->fb ? new_state->fb->base.id : 0,
+		       pstate->hfi_pipe_id);
+
+	pstate->prop_pkt_size = 0;
+
+	if (!new_state->visible || !new_state->fb)
+		return;
+
+	ret = dcp_plane_submit_update(plane, new_state);
+	if (ret) {
+		drm_err(plane->dev,
+			"plane%u: HFI update failed: %d\n", plane->base.id, ret);
+		dcp_plane_set_hfi_error(new_state, ret);
+		return;
+	}
+}
+
+static void dcp_plane_atomic_disable(struct drm_plane *plane,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *old_state =
+		drm_atomic_get_old_plane_state(state, plane);
+	struct dcp_plane_state *pstate = to_dcp_plane_state(old_state);
+	int ret;
+
+	drm_dbg_driver(plane->dev,
+		       "plane%u: atomic_disable pipe_id=%u\n",
+		       plane->base.id, pstate->hfi_pipe_id);
+
+	ret = dcp_plane_submit_disable(plane, old_state);
+	if (ret) {
+		drm_err(plane->dev,
+			"plane%u: HFI detach failed: %d\n", plane->base.id, ret);
+		dcp_plane_set_hfi_error(old_state, ret);
+	}
+
+	pstate->prop_pkt_size = 0;
+	pstate->prop_pkt_id = 0;
+}
+
+static struct drm_plane_state *
+dcp_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct dcp_plane_state *pstate, *old_pstate;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	old_pstate = to_dcp_plane_state(plane->state);
+	pstate = kzalloc_obj(*pstate, GFP_KERNEL);
+	if (!pstate)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &pstate->base);
+	pstate->hfi_pipe_id     = old_pstate->hfi_pipe_id;
+	pstate->src_img_w       = old_pstate->src_img_w;
+	pstate->src_img_h       = old_pstate->src_img_h;
+	pstate->fetch_bw       = old_pstate->fetch_bw;
+	pstate->clk            = old_pstate->clk;
+	pstate->needs_dirtyfb  = old_pstate->needs_dirtyfb;
+	pstate->prop_pkt_size   = 0;
+	pstate->prop_pkt_id     = old_pstate->prop_pkt_id;
+
+	return &pstate->base;
+}
+
+static void dcp_plane_atomic_destroy_state(struct drm_plane *plane,
+					   struct drm_plane_state *state)
+{
+	__drm_atomic_helper_plane_destroy_state(state);
+	kfree(to_dcp_plane_state(state));
+}
+
+static struct drm_plane_state *
+dcp_plane_atomic_create_state(struct drm_plane *plane)
+{
+	struct dcp_plane_state *pstate;
+	u32 hfi_pipe_id = to_dcp_plane(plane)->hfi_pipe_id;
+
+	pstate = kzalloc_obj(*pstate, GFP_KERNEL);
+	if (!pstate)
+		return NULL;
+
+	__drm_atomic_helper_plane_state_init(&pstate->base, plane);
+	pstate->hfi_pipe_id = hfi_pipe_id;
+
+	return &pstate->base;
+}
+
+static void dcp_plane_atomic_print_state(struct drm_printer *p,
+					 const struct drm_plane_state *state)
+{
+	const struct dcp_plane_state *pstate = to_dcp_plane_state(state);
+
+	drm_printf(p, "\tprop_pkt_size=%zu\n", pstate->prop_pkt_size);
+	drm_printf(p, "\thfi_pipe_id=%u\n", pstate->hfi_pipe_id);
+
+	if (pstate->prop_pkt_size) {
+		u32 hfi_rot = dcp_drm_to_hfi_rotation(state->rotation);
+
+		drm_printf(p, "\thfi_format=0x%x\n", pstate->hfi_format);
+		drm_printf(p, "\thfi_rotation=0x%x\n", hfi_rot);
+	}
+}
+
+static bool dcp_plane_format_mod_supported(struct drm_plane *plane,
+					   u32 format, uint64_t modifier)
+{
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return true;
+
+	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED)
+		return dcp_drm_to_hfi_format(format, modifier) != U32_MAX;
+
+	return false;
+}
+
+static const struct drm_plane_helper_funcs dcp_plane_helper_funcs = {
+	.prepare_fb     = dcp_plane_prepare_fb,
+	.cleanup_fb     = dcp_plane_cleanup_fb,
+	.atomic_check   = dcp_plane_atomic_check,
+	.atomic_update  = dcp_plane_atomic_update,
+	.atomic_disable = dcp_plane_atomic_disable,
+};
+
+static const struct drm_plane_funcs dcp_plane_funcs = {
+	.update_plane           = drm_atomic_helper_update_plane,
+	.disable_plane          = drm_atomic_helper_disable_plane,
+	.atomic_create_state    = dcp_plane_atomic_create_state,
+	.atomic_duplicate_state = dcp_plane_atomic_duplicate_state,
+	.atomic_destroy_state   = dcp_plane_atomic_destroy_state,
+	.format_mod_supported   = dcp_plane_format_mod_supported,
+	.atomic_print_state     = dcp_plane_atomic_print_state,
+};
+
+struct drm_plane *dcp_plane_init(struct drm_device *dev,
+				 u32 hfi_pipe_id,
+				 enum drm_plane_type type,
+				 unsigned long possible_crtcs)
+{
+	struct dcp_plane *dcp_plane;
+	struct drm_plane *plane;
+	int ret;
+
+	dcp_plane = drmm_universal_plane_alloc(dev, struct dcp_plane, base,
+					       possible_crtcs,
+							       &dcp_plane_funcs,
+							       dcp_plane_formats,
+							       ARRAY_SIZE(dcp_plane_formats),
+							       dcp_format_modifiers,
+					   type, NULL);
+	if (IS_ERR(dcp_plane))
+		return ERR_CAST(dcp_plane);
+
+	plane = &dcp_plane->base;
+	drm_plane_helper_add(plane, &dcp_plane_helper_funcs);
+
+	ret = drm_plane_create_zpos_property(plane, 0, 0, DCP_ZPOS_MAX);
+	if (ret)
+		drm_dbg_driver(plane->dev, "plane%u: zpos property failed\n", hfi_pipe_id);
+
+	drm_plane_create_alpha_property(plane);
+
+	drm_plane_create_blend_mode_property(plane,
+					     BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+		BIT(DRM_MODE_BLEND_PREMULTI) |
+		BIT(DRM_MODE_BLEND_COVERAGE));
+
+	drm_plane_create_rotation_property(plane,
+					   DRM_MODE_ROTATE_0,
+		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
+		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270 |
+		DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y);
+
+	drm_plane_enable_fb_damage_clips(plane);
+
+	dcp_plane->hfi_pipe_id = hfi_pipe_id;
+	if (plane->state)
+		to_dcp_plane_state(plane->state)->hfi_pipe_id = hfi_pipe_id;
+
+	drm_dbg_driver(dev, "plane initialized (type=%d, hfi_pipe_id=%u)\n",
+		       type, hfi_pipe_id);
+	return plane;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_plane.h b/drivers/gpu/drm/msm/dcp/dcp_plane.h
new file mode 100644
index 000000000000..377a156c046a
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_plane.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP plane implementation and API.
+ */
+
+#ifndef __DCP_PLANE_H__
+#define __DCP_PLANE_H__
+
+#include "dcp_plane_state.h"
+
+struct dcp_dpu_kms;
+struct drm_display_mode;
+
+struct dcp_plane_perf {
+	u64 fetch_bw;
+	u64 clk;
+};
+
+struct dcp_plane {
+	struct drm_plane base;
+	u32 hfi_pipe_id;
+};
+
+#define to_dcp_plane(x) container_of(x, struct dcp_plane, base)
+
+void dcp_plane_calc_perf(const struct drm_plane_state *state,
+			 const struct drm_display_mode *mode,
+			 struct dcp_plane_perf *perf);
+struct drm_plane *dcp_plane_init(struct drm_device *dev,
+				 u32 hfi_pipe_id,
+				 enum drm_plane_type type,
+				 unsigned long possible_crtcs);
+
+#endif /* __DCP_PLANE_H__ */

-- 
2.43.0

