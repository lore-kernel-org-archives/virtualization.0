Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995809;
	b=30yx5EjbpLTjsr5F7nIsRNSsAO586HUMT9U8lQKbpUpZ3mvHzSzXCvwOcpuOXGdrwxVC
	 D8NfFT+PBeoioZsfo2zoeTYNEgIAvAPHQDoTwwhNaE44sbIglfIX8Atvzt11mLfDaU7Kj
	 DPWrTgPAOKmKLXRv2l1uBhFasSr8y1Lu/ZfvyY3tyKI5BcKY+wSfk4QgDpr43yiQLdjfC
	 46l1T29gZmw+TTkDgUU7gZZOdmPWKVVM6NR1ur09ieg9n+b43HUmNNZjdj20KcS3KG2yO
	 2wt6QX1lGOPXo9qmCvHRxg/NXlpLjRDa89hIr68XtFOj5twLGJNwuQ756upZyutfwGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995809;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3t509laxb5fTYyLNtTJoqluEKHfKFwdYzBejJeayyEU=;
	b=jXC7VCQCP8jzKSdwtq+FoXaS85AU9tHss3RbhH7zQvtruiM7ux6CPIVQ9GLwO2BfSFC0
	 vnq7/XyG6gmlPMIadcbPFpJeBkur/nnxv8/XUW9QgV2CJBfll7NtT/7OnDrr+MIsdwp2P
	 bEZ5iAZAUPVlTANYxPVBGvTyUaElRgYU6yIlc2EpzspyZGmLGpGYbprM6cPJ0f9uAQD3E
	 toewjA7eLyq9pEvSB1SVEsHBpztHX51iRcHe0tzr7jGnThL/PFwtWwk9gqQpFwHdgLPx+
	 JuN36LGU8ak6JfhI08NUsg6bVCTRfK+8YVIdFZ1B5uD4tPQoTfPbZXAoSRRXF0jYZ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VqtIpNM+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y235LzM6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA3606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71FA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VqtIpNM+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y235LzM6
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aPD02222520
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3t509laxb5fTYyLNtTJoqluEKHfKFwdYzBejJeayyEU=; b=VqtIpNM+FGWswR44
	A+nfb1EdHV7c32nRoIIDd1ZSBO2NTyDEnMAv7G1unSxQg+KOsn4eoQWrEq7d4utC
	5poL2mlpskFcJsfHbbSDgfj9kz/L/DEZQjAkg/CK/vR8rETCIkHWySibEmnobH8s
	R9WWo+g5XR87UEAQbhkLGtlEDUYIYVCWecSqMP6u37rBFH7lpoETyQE3BtxuoO9B
	haPzuZPplpsqhzpMamDs6P7EgzE70sKvH73e9GWT1dKgDAn6vdtxglPpbDVkywB+
	w84m1YJOUQ1P4aSgX7Rb19sShu7XLkwUe700t5iOA3mGcXLbiuLSXNsHcjGlrB/R
	CX3V3A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd8trg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:23:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e8e16d22d8so47052345ad.1
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995806; x=1793600606; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3t509laxb5fTYyLNtTJoqluEKHfKFwdYzBejJeayyEU=;
        b=Y235LzM6r9J0QrCNhp8/gZURhkl+rGaQjKrXQPLtmzhvy2U+Yc3tu+sNvKM3Sz8dBG
         du3IIYEIhj/PiWndQHTYoMUgLJaZ7iwMy4fBc+W4+XhhCvmnIp2Co6B5p627b+LH7avM
         tdsFiKQNXU6Q7fDicm1AcPF21yGS/d0lHp/Du5Owr+w67p0FYNYtN4ljsBfDribYz3Ty
         HsdoN5n3Nwu+incsh9b37onxkxJetrBmg9CTeUsy0S4sW8z2m9KDlTYcUwVEqckcl7Ll
         /Ozbj+aymcMzmeRcu7yMI01z6d3dt2wyrmzYk1noxCfmnUZLXUQcM4evtn+cvofBvvb1
         O2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995806; x=1793600606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3t509laxb5fTYyLNtTJoqluEKHfKFwdYzBejJeayyEU=;
        b=kxCkHTotm7lmOAgHpJECiaNRczbZ1fhm4VRBogHCKPxxV8dIQVLKOM6sR3ibmCtM3m
         A7yWdBt9mYDzoCiIWYLc1Ic41Yjxrbg38eqeh3G2RKS/03TQXi2r4R6ShNTszq/H+6xQ
         UzHewmfTzZJEGXc6JMnDroDxqjgUcVudUoDg1lEwABTafVLxTpvHQL5b9XW08N9wxcy+
         yGNgvHTuQIaLxMywWrxc3J0ofqf0ZPdz1//smhGSOi4OmJuyJuPm7sWgqreNQA6jSsWj
         54yXBzY7HeeUuF7/JPtBAvFo7+64XsztJKHTSFm5ZGdC2JWmIwCuPOzJBGwIOzf1Fjew
         e8rg==
X-Forwarded-Encrypted: i=1; AKwUvBxkXETiw1I3aQpy7Z9tWQqdtZNnHeYtt2po10jwYelCivy0/qNIELivQ+RMu10CxLYoPECvAyRjwTN/CrTKOw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIP9abY8WMejLYobLpXHS6i4UiL3H01cjrvWtTo+mozCPr+nZpc
	ijP2os1gpuH/TWIony2syf6oDNcTeg4+1vTk19LoyOyqd8NIEZ+nophgFzhdBNv0e+deuGLa2J0
	KXbsF5TKLw492Qh0Q0nXnhssIMAEi541jgUpJgy6Cz+uM+WWJWtEAm3jy5T/NJr9xHjKqQw==
X-Gm-Gg: AYBFou20Gc0QuiWu0bL7SH4A1KMaRhSx8rizJtZsFGJleeTOvoihzkVWX3E961HwCGg
	JzKteaVCnozfagrxsFv//gym6TmaluiEO1/iX6zTThp9UA4s/xr6bRAX5/J3FU5G/3U76j+2a3w
	aHeoeLe3NBuU7GteSLfTRmwxlQGxxYTUS8lnZSUm10zCQLblk2oIAu3IbpduMyTcQgT5phrlgZh
	Q932ED2WmSmsyduqjUqtfTL7jYT7BDRNBZYxWrwK6kJIH5nDaHQ5xEXMgsKa3JdA0sduc/G6QkZ
	1kOsAsUo1+C9tSvTN/gPBU4BnCGkg6YoMcQbz+YAT3qJx6FtmUaOh+Ezf38E+xhZJdfOZwtzAsb
	5Iju3qbXkVEWdCO0ZMfkiPkA4UFF8Jsc8nw==
X-Received: by 2002:a17:903:37ce:b0:2e9:a23b:643d with SMTP id d9443c01a7336-2ea9c83437bmr47083565ad.35.1792995806209;
        Sun, 25 Oct 2026 23:23:26 -0700 (PDT)
X-Received: by 2002:a17:903:37ce:b0:2e9:a23b:643d with SMTP id d9443c01a7336-2ea9c83437bmr47083155ad.35.1792995805591;
        Sun, 25 Oct 2026 23:23:25 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:23:25 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:20 +0530
Subject: [PATCH v2 10/23] drm/msm/dcp: Add HFI DSI and panel commands
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=33556;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=ocZ7yutgG0nkYF6lCmZ+JQK23idMD+7hCX4W3kv7S+A=;
 b=v6lRZKzvrIMi6gtQjFDr5/o1stw75lM0oGJR1TR/IxO3Ud8DfV32VnTBmzB0D1H2JPByDBV7l
 w0U3NyoQ470AMHorCwWblUQ1CGiHOsRI4aQRSOnOVocv+xAt2KP6HIp
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: DAH1ST4Xmlab-3vN791HS0_qYZ0CGzT8
X-Proofpoint-GUID: DAH1ST4Xmlab-3vN791HS0_qYZ0CGzT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXwsdsHdhG32WH
 PcrWdriBul+Y77fUNI2frpTUklo72WehDvQt5cTNRrAkNYsW6TaOVyJkpRnKEOXevps9hsX1Lpy
 myXPTnClthZH4FchUJfTzsYhrxCMsO0Uyv8K7E15zTJAo+9Fs8OjbKi6AuKHxWunZZp+b+RC+n5
 djpmj0X71ShiJBmsiazkAflfZGZyfdq445MFkErIt8dH/nZ7KDpAK6QS2PivOnETK83ogu/5CZY
 F7X2OHv0IrqTOzwFTSGp8BhajCv90drIl8kgnfJpce9VFZImPA+nFNPnksHA9M39yphQ/W49S3P
 We59MRTnjeOydqlBKLtAH0PugFB1U9NBTAZoGwZCr5wzn+Tl9UACVqjK5gtRJkIJ9UcIm6Rpxlm
 SWw22UCHVGSH4ddUcS6s2xo7m9GmuZdslfa74WaEsznLbO/+m8zdu2aPl6N3unMvljpD+apbUL5
 edKFJXCji6mIA9ZhCXQ==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adef1df cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=xWjPvU2zngwjg2TwZJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXz9ZgEhibADk0
 60rhAtXT9vmCHMwQGOK+p2vWd+uNDOzxYAnLeGCsrf+ZfTzDB3rlZdgzE63XokFMmRcbS+yCf+z
 ZP9p9wFCqwXfANSRHzW6D+Btwu87W/k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Translate DSI host and panel operations into HFI commands. Firmware
owns the DSI hardware, so mode validation, display power, panel setup,
and DCS transfers must cross the HFI interface instead of accessing
controller registers from Linux.

Implement DSI mode validation, display session and power management,
panel initialization, and DCS transfer helpers while keeping them
separate from generic display commands.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile                |   2 +
 drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h     |  81 ++++
 drivers/gpu/drm/msm/dcp/dcp_hfi.h           |  25 ++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c       | 252 ++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c | 592 ++++++++++++++++++++++++++++
 5 files changed, 952 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index bdc5e3b8efa7..77c268aabca6 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -74,6 +74,8 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
 	dcp/dcp_hfi_core.o \
 	dcp/dcp_hfi_crtc.o \
+	dcp/dcp_hfi_dsi.o \
+	dcp/dcp_hfi_dsi_panel.o \
 	dcp/dcp_hfi_encoder.o \
 	dcp/dcp_hfi_kms.o \
 	dcp/dcp_hfi_plane.o \
diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
new file mode 100644
index 000000000000..a8898e469b44
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_panel.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP DSI panel configuration shared by the HFI panel implementation and
+ * the DRM DSI bridge.
+ */
+
+#ifndef __DCP_DSI_PANEL_H__
+#define __DCP_DSI_PANEL_H__
+
+#include <linux/dma-mapping.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#define DCP_DSI_MAX_PHY_TIMINGS	32
+
+/**
+ * struct dcp_dsi_hfi_panel_config - Complete HFI PANEL_INIT configuration.
+ *
+ * This contains the bridge-owned panel configuration plus the
+ * mode-dependent values assembled before the HFI PANEL_INIT command.
+ */
+struct dcp_dsi_hfi_panel_config {
+	u32 display_type;
+	u32 num_ctrls;
+	u32 ctrl_indices[4];
+	u32 num_phys;
+	u32 phy_indices[4];
+	u32 vsync_source;
+	u32 te_dcs_command;
+	u32 dma_trigger;
+	u32 stream_trigger;
+	u32 wr_mem_start;
+	u32 wr_mem_continue;
+	u32 dma_sched_line;
+	u32 dma_sched_window;
+	u32 phy_type;
+	bool cphy_mode;
+	bool lp11_init;
+	bool ulps_supported;
+	bool bllp_eof_power_mode;
+	bool bllp_power_mode;
+	u32 lane_map;
+	u32 color_order;
+	u32 esd_mode;
+	u32 jitter_numer;
+	u32 jitter_denom;
+	dma_addr_t dcs_tx_dva;
+	dma_addr_t dcs_tx_iova;
+	u32 dcs_tx_buf_size;
+	u32 phy_timings[DCP_DSI_MAX_PHY_TIMINGS];
+	u32 num_phy_timings;
+	bool dsc_enabled;
+	u32 dsc_version_major;
+	u32 dsc_version_minor;
+	u32 dsc_scr_version;
+	u32 dsc_slice_height;
+	u32 dsc_slice_width;
+	u32 dsc_slices_per_pkt;
+	u32 dsc_bits_per_component;
+	u32 dsc_pps_delay_ms;
+	u32 dsc_bits_per_pixel;
+	u32 dsc_chroma_format;
+	u32 dsc_color_space;
+	u32 dsc_block_prediction_enable;
+	/* Optional DSC rate-control override panel configuration. */
+	bool dsc_rc_override;
+	u8 dsc_rc_min_qp[15];
+	u8 dsc_rc_max_qp[15];
+	u8 dsc_rc_bpg_offsets[15];
+	u32 topology_mixer_count;
+	u32 topology_enc_count;
+	u32 topology_intf_count;
+};
+
+/* DCS buffers use IOVAs directly in the firmware command descriptor. */
+#define DCP_DSI_DCS_TX_BUF_SIZE	SZ_4K
+#define DCP_DSI_DCS_RX_BUF_SIZE	SZ_4K
+
+#endif /* __DCP_DSI_PANEL_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
index 6d3eadb5e811..88d73de69383 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_hfi.h
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
@@ -242,6 +242,31 @@ int dcp_hfi_send_resource_register(struct dcp_hfi *hfi);
 int dcp_hfi_set_display_property(struct dcp_hfi *hfi, u32 session_id,
 				 u32 prop_id, u32 value);
 
+struct dcp_dsi_hfi_panel_config;
+int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
+		       const struct drm_display_mode *mode,
+		       const struct mipi_dsi_device *dsi,
+		       const struct dcp_dsi_hfi_panel_config *cfg);
+int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx,
+			   u32 display_id, u32 *session_id);
+int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
+				  const struct drm_display_mode *mode,
+				  u64 clk_rate_hz);
+int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
+			     const struct drm_display_mode *mode,
+			     u64 clk_rate_hz);
+int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
+				      u32 packet_id);
+int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id);
+int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id);
+ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
+			     const struct mipi_dsi_msg *msg,
+			     void *tx_buf, dma_addr_t tx_iova,
+			     void *rx_buf, dma_addr_t rx_iova,
+			     u32 post_wait_ms, u32 ctrl_idx);
 #endif /* __DCP_HFI_H__ */
 void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
 				  void (*cb)(void *priv, u32 display_id,
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
new file mode 100644
index 000000000000..fbeec03cf90d
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for the DSI display-session lifecycle.
+ * Panel initialization and DCS transfers are implemented in dcp_hfi_dsi_panel.c.
+ */
+
+#include <linux/device.h>
+#include <drm/drm_modes.h>
+
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_display.h"
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_properties_display.h"
+
+static void dcp_hfi_fill_mode_info(struct hfi_display_mode_info *info,
+				   const struct drm_display_mode *mode)
+{
+	memset(info, 0, sizeof(*info));
+	info->size            = sizeof(*info);
+	info->h_active        = mode->hdisplay;
+	info->h_back_porch    = mode->htotal - mode->hsync_end;
+	info->h_sync_width    = mode->hsync_end - mode->hsync_start;
+	info->h_front_porch   = mode->hsync_start - mode->hdisplay;
+	info->h_skew          = mode->hskew;
+	info->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PHSYNC);
+	info->v_active        = mode->vdisplay;
+	info->v_back_porch    = mode->vtotal - mode->vsync_end;
+	info->v_sync_width    = mode->vsync_end - mode->vsync_start;
+	info->v_front_porch   = mode->vsync_start - mode->vdisplay;
+	info->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_PVSYNC);
+	info->refresh_rate    = drm_mode_vrefresh(mode);
+	info->clk_rate_hz_lo = lower_32_bits((u64)mode->clock * 1000);
+	info->clk_rate_hz_hi = upper_32_bits((u64)mode->clock * 1000);
+}
+
+static void dcp_hfi_dump_mode_info(struct dcp_hfi *hfi, const char *cmd,
+				   u32 session_id,
+				   const struct hfi_display_mode_info *info)
+{
+	dev_dbg(hfi->dev,
+		"HFI %s s=%u h=%u/%u/%u/%u v=%u/%u/%u/%u p=%u/%u r=%u clk=%llu sz=%u\n",
+		cmd, session_id,
+		info->h_active, info->h_back_porch, info->h_sync_width,
+		info->h_front_porch,
+		info->v_active, info->v_back_porch, info->v_sync_width,
+		info->v_front_porch,
+		info->h_sync_polarity, info->v_sync_polarity,
+		info->refresh_rate,
+		(u64)info->clk_rate_hz_lo | ((u64)info->clk_rate_hz_hi << 32),
+		info->size);
+}
+
+int dcp_hfi_display_mode_validate(struct dcp_hfi *hfi, u32 session_id,
+				  const struct drm_display_mode *mode, u64 clk_rate_hz)
+{
+	struct hfi_display_mode_info info;
+	int ret;
+
+	dcp_hfi_fill_mode_info(&info, mode);
+	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
+	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
+	dcp_hfi_dump_mode_info(hfi, "HFI MODE_VALIDATE", session_id, &info);
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_MODE_VALIDATE,
+				HFI_CMD_BUFF_DISPLAY, session_id,
+				HFI_PAYLOAD_U32_ARRAY,
+				&info, sizeof(info),
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_MODE_MS);
+
+	return ret;
+}
+
+int dcp_hfi_display_set_mode(struct dcp_hfi *hfi, u32 session_id,
+			     const struct drm_display_mode *mode, u64 clk_rate_hz)
+{
+	struct hfi_display_mode_info info;
+	int ret;
+
+	dcp_hfi_fill_mode_info(&info, mode);
+	info.clk_rate_hz_lo = lower_32_bits(clk_rate_hz);
+	info.clk_rate_hz_hi = upper_32_bits(clk_rate_hz);
+	dcp_hfi_dump_mode_info(hfi, "HFI SET_MODE", session_id, &info);
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_SET_MODE,
+				HFI_CMD_BUFF_DISPLAY, session_id,
+				HFI_PAYLOAD_U32_ARRAY,
+				&info, sizeof(info),
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_MODE_MS);
+
+	return ret;
+}
+
+int dcp_hfi_display_power_register(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_POWER_REGISTER,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_power_control_ack(struct dcp_hfi *hfi, u32 session_id,
+				      u32 packet_id)
+{
+	struct dcp_hfi_buf *buf;
+	struct hfi_cmd_buff_hdl hdl;
+	struct hfi_header_info hdr_info;
+	struct hfi_packet_info pkt_info;
+	int ret;
+
+	buf = dcp_hfi_buf_alloc(hfi);
+	if (!buf)
+		return -ENOMEM;
+
+	hdl.cmd_buffer = buf->data;
+	hdl.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info.num_packets   = 0;
+	hdr_info.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info.object_id     = session_id;
+	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl, &hdr_info);
+	if (ret)
+		goto err_free_buf;
+
+	pkt_info.cmd          = HFI_COMMAND_DISPLAY_POWER_CONTROL;
+	pkt_info.id           = session_id & 0xFFFF;
+	pkt_info.flags        = HFI_RX_FLAGS_SUCCESS;
+	pkt_info.packet_id    = packet_id;
+	pkt_info.payload_type = HFI_PAYLOAD_NONE;
+	pkt_info.payload_size = 0;
+	pkt_info.payload_ptr  = NULL;
+
+	ret = hfi_create_packet_header(&hdl, &pkt_info);
+	if (ret)
+		goto err_free_buf;
+
+	return dcp_hfi_send_cmd_async(hfi, buf, hfi_get_header_size(&hdl), NULL);
+
+err_free_buf:
+	dcp_hfi_buf_free(hfi, buf);
+	return ret;
+}
+
+int dcp_hfi_display_enable(struct dcp_hfi *hfi, u32 intf_idx, u32 display_id,
+			   u32 *session_id)
+{
+	int ret;
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_ENABLE,
+				HFI_CMD_BUFF_DISPLAY, display_id,
+				HFI_PAYLOAD_NONE, NULL, 0,
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_DISPLAY_MS);
+	if (ret) {
+		dev_err(hfi->dev,
+			"HFI DISPLAY_ENABLE intf=%u display_id=%u failed: %d\n",
+			intf_idx, display_id, ret);
+		return ret;
+	}
+
+	*session_id = display_id;
+
+	return 0;
+}
+
+int dcp_hfi_display_post_enable(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_POST_ENABLE,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_disable(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_DISABLE,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_post_disable(struct dcp_hfi *hfi, u32 session_id)
+{
+	return dcp_hfi_send_sync(hfi,
+				 HFI_COMMAND_DISPLAY_POST_DISABLE,
+				 HFI_CMD_BUFF_DISPLAY, session_id,
+				 HFI_PAYLOAD_NONE, NULL, 0,
+				 HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE,
+				 NULL, 0,
+				 DCP_HFI_TIMEOUT_DISPLAY_MS);
+}
+
+int dcp_hfi_display_close(struct dcp_hfi *hfi, u32 session_id)
+{
+	int ret;
+
+	ret = dcp_hfi_display_disable(hfi, session_id);
+	if (ret) {
+		dev_warn(hfi->dev, "HFI DISPLAY_DISABLE failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = dcp_hfi_display_post_disable(hfi, session_id);
+	if (ret) {
+		dev_warn(hfi->dev, "HFI DISPLAY_POST_DISABLE failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_CLOSE,
+				HFI_CMD_BUFF_DISPLAY, session_id,
+				HFI_PAYLOAD_NONE, NULL, 0,
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_DISPLAY_MS);
+	if (ret)
+		dev_warn(hfi->dev, "HFI DISPLAY_CLOSE failed: %d\n", ret);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
new file mode 100644
index 000000000000..b27fa8fa3160
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * HFI commands for panel initialization and DCS transfers.
+ * Firmware owns the DSI controller and PHY.
+ */
+
+#include <linux/device.h>
+#include <linux/math64.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_mipi_dsi.h>
+
+#include "dcp_dsi_panel.h"
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_commands_panel.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_panel.h"
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_properties_panel.h"
+
+#define DCP_DSI_CTRL_CMD_READ              BIT(0)
+#define DCP_DSI_CTRL_CMD_FETCH_MEMORY      BIT(5)
+#define DCP_DSI_CTRL_CMD_LAST_COMMAND      BIT(6)
+
+static u32 dcp_bpp_to_hfi(u32 bpp)
+{
+	switch (bpp) {
+	case 16: return HFI_PANEL_BPP_16;
+	case 18: return HFI_PANEL_BPP_18;
+	case 30: return HFI_PANEL_BPP_30;
+	case 24:
+	default: return HFI_PANEL_BPP_24;
+	}
+}
+
+static u32 dcp_dsi_traffic_mode(const struct mipi_dsi_device *dsi)
+{
+	if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO))
+		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		return HFI_PANEL_TRAFFIC_BURST_MODE;
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_PULSE_MODE;
+	return HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE;
+}
+
+static u32 dcp_lanes_to_hfi(u32 num_lanes)
+{
+	u32 mask = 0;
+
+	if (num_lanes >= 1)
+		mask |= HFI_PANEL_LANE_0;
+	if (num_lanes >= 2)
+		mask |= HFI_PANEL_LANE_1;
+	if (num_lanes >= 3)
+		mask |= HFI_PANEL_LANE_2;
+	if (num_lanes >= 4)
+		mask |= HFI_PANEL_LANE_3;
+
+	return mask ?: HFI_PANEL_LANE_0;
+}
+
+static bool dcp_hfi_panel_wait(struct dcp_hfi *hfi,
+			       struct dcp_hfi_completion *comp)
+{
+	unsigned long flags;
+
+	if (wait_for_completion_timeout(&comp->done,
+					msecs_to_jiffies(DCP_HFI_TIMEOUT_DISPLAY_MS)))
+		return false;
+
+	/* Serialize removal with response dispatch before the stack object dies. */
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	dcp_hfi_pending_find(hfi, comp->packet_id);
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+	return true;
+}
+
+int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
+		       const struct drm_display_mode *mode,
+		       const struct mipi_dsi_device *dsi,
+		       const struct dcp_dsi_hfi_panel_config *cfg)
+{
+	u32 num_lanes;
+	u32 bpp;
+	bool is_cmd_mode;
+	u32 display_type;
+	u32 vsync_source;
+	u32 traffic_mode;
+	u32 phy_type;
+
+	struct dcp_hfi_buf *buf1, *buf2;
+	struct hfi_cmd_buff_hdl hdl1, hdl2;
+	struct hfi_header_info hdr_info1, hdr_info2;
+	struct hfi_packet_info pkt_info;
+	struct dcp_hfi_completion comp1, comp2, comp3;
+	u32 payload[128];
+	u32 *p;
+	u32 packet_id, packet_id2, packet_id3;
+	u64 clk_hz;
+	int ret;
+	bool timeout1, timeout2, timeout3;
+	u32 link_bpp_x16;
+
+	if (!hfi || !mode || !dsi || !dsi->lanes || !cfg)
+		return -EINVAL;
+	if (cfg->num_ctrls > ARRAY_SIZE(cfg->ctrl_indices) ||
+	    cfg->num_phys > ARRAY_SIZE(cfg->phy_indices))
+		return -EINVAL;
+
+	display_type = cfg->display_type;
+	vsync_source = cfg->vsync_source;
+	phy_type = cfg->phy_type;
+	num_lanes = dsi->lanes;
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	if (bpp < 0)
+		return -EINVAL;
+	is_cmd_mode = !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
+	traffic_mode = dcp_dsi_traffic_mode(dsi);
+	link_bpp_x16 = bpp << 4;
+
+	buf1 = dcp_hfi_buf_alloc(hfi);
+	if (!buf1) {
+		dev_err(hfi->dev, "HFI PANEL_INIT: TX buffer exhausted\n");
+		return -ENOMEM;
+	}
+
+	hdl1.cmd_buffer = buf1->data;
+	hdl1.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info1.num_packets   = 0;
+	hdr_info1.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info1.object_id     = intf_idx;
+	hdr_info1.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl1, &hdr_info1);
+	if (ret) {
+		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (A) failed: %d\n",
+			ret);
+		goto err_free_buf1;
+	}
+
+	{
+		u32 num_props = 0;
+
+		p = payload + 1;
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TIMING_MODE_COUNT, 1);
+
+		/* DCS TX buffer is described by both DVA and IOVA properties. */
+		if (cfg->dcs_tx_iova && cfg->dcs_tx_dva &&
+		    !(cfg->dcs_tx_iova & 0x3ff) && !(cfg->dcs_tx_dva & 0x3ff)) {
+			num_props++;
+			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA,
+				       lower_32_bits(cfg->dcs_tx_dva),
+				       upper_32_bits(cfg->dcs_tx_dva),
+				       cfg->dcs_tx_buf_size, 0, 0);
+			num_props++;
+			p += HFI_PACK(p, HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA,
+				       lower_32_bits(cfg->dcs_tx_iova),
+				       upper_32_bits(cfg->dcs_tx_iova),
+				       cfg->dcs_tx_buf_size, 0, 0);
+		}
+		payload[0] = num_props;
+	}
+
+	packet_id = dcp_hfi_next_packet_id(hfi);
+	pkt_info.cmd          = HFI_COMMAND_PANEL_INIT_PANEL_CAPS;
+	pkt_info.id           = intf_idx & 0xFFFF;
+	pkt_info.flags        = HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				 HFI_TX_FLAGS_NON_DISCARDABLE;
+	pkt_info.packet_id    = packet_id;
+	pkt_info.payload_type = HFI_PAYLOAD_U32_ARRAY;
+	pkt_info.payload_size = (u32)((p - payload) * sizeof(u32));
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl1, &pkt_info);
+	if (ret)
+		goto err_free_buf1;
+
+	dev_dbg(hfi->dev,
+		"intf%u: DCP mode %dx%d@%dHz clk=%ukHz ht=%u hs=%u/%u vt=%u vs=%u/%u f=0x%x\n",
+		intf_idx, mode->hdisplay, mode->vdisplay,
+		drm_mode_vrefresh(mode), mode->clock,
+		mode->htotal, mode->hsync_start, mode->hsync_end,
+		mode->vtotal, mode->vsync_start, mode->vsync_end,
+		mode->flags);
+
+	{
+		u32 te_dcs     = cfg->te_dcs_command;
+		u32 dma_trig   = cfg->dma_trigger;
+		u32 str_trig   = cfg->stream_trigger;
+		u32 wr_start   = cfg->wr_mem_start;
+		u32 wr_cont    = cfg->wr_mem_continue;
+		u32 lane_map   = cfg->lane_map;
+		u32 color_ord  = cfg->color_order;
+		u32 vc_id      = dsi->channel;
+		u32 esd_mode   = cfg->esd_mode;
+		u32 dma_win    = cfg->dma_sched_window;
+		bool lp11      = cfg->lp11_init;
+		bool cphy      = cfg->cphy_mode;
+		bool ulps      = cfg->ulps_supported;
+		bool tx_eot    = !(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET);
+		bool bllp_eof  = cfg->bllp_eof_power_mode;
+		bool bllp_pwr  = cfg->bllp_power_mode;
+		u32 num_ctrls  = cfg->num_ctrls;
+		u32 num_phys   = cfg->num_phys;
+		u32 num_props = 0;
+
+		p = payload + 1;
+
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_PHYSICAL_TYPE, phy_type);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_BPP, dcp_bpp_to_hfi(bpp));
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_LANES_STATE,
+			       dcp_lanes_to_hfi(num_lanes));
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_OPERATING_MODE,
+			       is_cmd_mode ? HFI_PANEL_CMD_MODE_8_BIT :
+			       HFI_PANEL_VIDEO_MODE_8_BIT);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DISPLAY_TYPE, display_type);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_VSYNC_SOURCE, vsync_source);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TRAFFIC_MODE, traffic_mode);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TE_DCS_COMMAND, te_dcs);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DMA_TRIGGER, dma_trig);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_STREAM_TRIGGER, str_trig);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_WR_MEM_START, wr_start);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_WR_MEM_CONTINUE, wr_cont);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_LP11_INIT, lp11 ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_CPHY_MODE, cphy ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_ULPS_SUPPORTED,
+			       ulps ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_TX_EOT_APPEND,
+			       tx_eot ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_BLLP_EOF_POWER_MODE,
+			       bllp_eof ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_BLLP_POWER_MODE,
+			       bllp_pwr ? HFI_TRUE : HFI_FALSE);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_COLOR_ORDER, color_ord);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_VIRTUAL_CHANNEL_ID, vc_id);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_LANE_MAP, lane_map);
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_ESD_CONFIG,
+			       10 * sizeof(u32), esd_mode,
+			       0, 0, 0, 0, 0, 0, 0, 0);
+
+		num_props++;
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_CTRL_NUM, 0, 1 + num_ctrls);
+		*p++ = num_ctrls;
+		memcpy(p, cfg->ctrl_indices, num_ctrls * sizeof(*p));
+		p += num_ctrls;
+
+		num_props++;
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_PHY_NUM, 0, 1 + num_phys);
+		*p++ = num_phys;
+		memcpy(p, cfg->phy_indices, num_phys * sizeof(*p));
+		p += num_phys;
+
+		num_props++;
+		p += HFI_PACK(p, HFI_PROPERTY_PANEL_DMA_SCHEDULE_WINDOW, dma_win);
+		payload[0] = num_props;
+	}
+
+	packet_id3 = dcp_hfi_next_packet_id(hfi);
+	pkt_info.cmd          = HFI_COMMAND_PANEL_INIT_GENERIC_CAPS;
+	pkt_info.flags        = HFI_TX_FLAGS_NON_DISCARDABLE | HFI_TX_FLAGS_RESPONSE_REQUIRED;
+	pkt_info.packet_id    = packet_id3;
+	pkt_info.payload_size = (u32)((p - payload) * sizeof(u32));
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl1, &pkt_info);
+	if (ret)
+		goto err_free_buf1;
+
+	buf2 = dcp_hfi_buf_alloc(hfi);
+	if (!buf2) {
+		dev_err(hfi->dev, "HFI PANEL_INIT: TX buffer exhausted (B)\n");
+		ret = -ENOMEM;
+		goto err_free_buf1;
+	}
+
+	hdl2.cmd_buffer = buf2->data;
+	hdl2.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info2.num_packets   = 0;
+	hdr_info2.cmd_buff_type = HFI_CMD_BUFF_DISPLAY;
+	hdr_info2.object_id     = intf_idx;
+	hdr_info2.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl2, &hdr_info2);
+	if (ret) {
+		dev_err(hfi->dev, "PANEL_INIT: hfi_create_header (B) failed: %d\n",
+			ret);
+		goto err_free_both;
+	}
+
+	{
+		u32 num_props = 7; /* timing properties; DPHY and DSC are optional */
+
+		if (cfg->dsc_enabled)
+			num_props++;
+		if (cfg->dsc_enabled && cfg->dsc_rc_override)
+			num_props++;
+		if (cfg->num_phy_timings)
+			num_props++;
+		p = payload;
+		*p++ = num_props;
+	}
+	p = payload + 1;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_INDEX, 0, 1);
+	*p++ = 0;
+
+	/* PANEL_CLOCKRATE is the panel-selected DSI bit clock per lane. */
+	if (cfg->dsc_enabled && cfg->dsc_bits_per_pixel)
+		link_bpp_x16 = cfg->dsc_bits_per_pixel;
+	clk_hz = dsi->hs_rate ? dsi->hs_rate :
+		div_u64((u64)mode->clock * 1000 * link_bpp_x16,
+			num_lanes * 16);
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_CLOCKRATE, 0, 2);
+	*p++ = lower_32_bits(clk_hz);
+	*p++ = upper_32_bits(clk_hz);
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_FRAMERATE, 0, 1);
+	*p++ = drm_mode_vrefresh(mode);
+
+	/* Firmware expects numerator/denominator timing jitter per mode. */
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_JITTER, 0, 2);
+	*p++ = cfg->jitter_numer;
+	*p++ = cfg->jitter_denom;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_RESOLUTION_DATA, 0, 14);
+	*p++ = mode->hdisplay;                       /* active_width */
+	*p++ = mode->vdisplay;                       /* active_height */
+	*p++ = mode->hsync_start - mode->hdisplay;   /* h_front_porch */
+	*p++ = mode->htotal - mode->hsync_end;       /* h_back_porch */
+	*p++ = 0;                                    /* h_left_border */
+	*p++ = 0;                                    /* h_right_border */
+	*p++ = mode->hsync_end - mode->hsync_start;  /* h_pulse_width */
+	*p++ = mode->hskew;                          /* h_sync_skew */
+	*p++ = 0;                                    /* h_sync_pulse (TODO: confirm) */
+	*p++ = mode->vsync_start - mode->vdisplay;   /* v_front_porch */
+	*p++ = mode->vtotal - mode->vsync_end;       /* v_back_porch */
+	*p++ = 0;                                    /* v_top_border */
+	*p++ = 0;                                    /* v_bottom_border */
+	*p++ = mode->vsync_end - mode->vsync_start;  /* v_pulse_width */
+
+	/* Topology fields follow the firmware panel format. */
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_DISPLAY_TOPOLOGY, 0, 4);
+	*p++ = 1;
+	*p++ = cfg->topology_mixer_count;
+	*p++ = cfg->topology_enc_count;
+	*p++ = cfg->topology_intf_count;
+
+	*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_DEFAULT_TOPOLOGY_INDEX, 0, 1);
+	*p++ = 0;
+
+	if (cfg->dsc_enabled) {
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_COMPRESSION_DATA, 0, 12);
+		*p++ = HFI_PANEL_COMPRESSION_DSC;
+		*p++ = (cfg->dsc_version_major << 4) | cfg->dsc_version_minor;
+		*p++ = cfg->dsc_scr_version;
+		*p++ = cfg->dsc_slice_height;
+		*p++ = cfg->dsc_slice_width;
+		*p++ = cfg->dsc_slices_per_pkt;
+		*p++ = cfg->dsc_bits_per_component;
+		*p++ = cfg->dsc_pps_delay_ms;
+		*p++ = cfg->dsc_bits_per_pixel;
+		*p++ = cfg->dsc_chroma_format;
+		*p++ = cfg->dsc_color_space;
+		*p++ = cfg->dsc_block_prediction_enable;
+	}
+
+	if (cfg->dsc_enabled && cfg->dsc_rc_override) {
+		struct hfi_panel_compression_rc_override rc_override = {};
+
+		memcpy(rc_override.min_qp, cfg->dsc_rc_min_qp,
+		       sizeof(rc_override.min_qp));
+		memcpy(rc_override.max_qp, cfg->dsc_rc_max_qp,
+		       sizeof(rc_override.max_qp));
+		memcpy(rc_override.offsets, cfg->dsc_rc_bpg_offsets,
+		       sizeof(rc_override.offsets));
+
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_COMPRESSION_RC_OVERRIDE, 0,
+				sizeof(rc_override) / sizeof(u32));
+		memcpy(p, &rc_override, sizeof(rc_override));
+		p += sizeof(rc_override) / sizeof(u32);
+	}
+
+	/* DCP computes PHY timings unless an explicit override is supplied. */
+	if (cfg->num_phy_timings) {
+		u32 n = min_t(u32, cfg->num_phy_timings, DCP_DSI_MAX_PHY_TIMINGS);
+
+		*p++ = HFI_PACK_KEY(HFI_PROPERTY_PANEL_DPHY_TIMINGS, 0, n + 1);
+		*p++ = n;
+		memcpy(p, cfg->phy_timings, n * sizeof(*p));
+		p += n;
+	}
+
+	packet_id2 = dcp_hfi_next_packet_id(hfi);
+	pkt_info.cmd          = HFI_COMMAND_PANEL_INIT_TIMING_MODE_CAPS;
+	pkt_info.flags        = HFI_TX_FLAGS_NON_DISCARDABLE | HFI_TX_FLAGS_RESPONSE_REQUIRED;
+	pkt_info.packet_id    = packet_id2;
+	pkt_info.payload_size = (u32)((p - payload) * sizeof(u32));
+	pkt_info.payload_ptr  = payload;
+
+	ret = hfi_create_full_packet(&hdl2, &pkt_info);
+	if (ret)
+		goto err_free_both;
+
+	/*
+	 * Header A carries 2 packets (PANEL_CAPS, GENERIC_CAPS); firmware
+	 * ACKs each individually by its own packet_id. comp1 is registered
+	 * internally by dcp_hfi_send_cmd_async() below; comp3 must be
+	 * pre-registered here or its response is dropped as "no pending
+	 * completion". Header B carries only TIMING_MODE_CAPS (the topology
+	 * property that drives DCP's MDP resource reservation) — comp2 is
+	 * registered internally by its own dcp_hfi_send_cmd_async() call.
+	 */
+	init_completion(&comp1.done);
+	comp1.resp_data = NULL;
+	comp1.resp_len  = 0;
+	comp1.status    = 0;
+	comp1.packet_id = packet_id;
+
+	init_completion(&comp2.done);
+	comp2.resp_data = NULL;
+	comp2.resp_len  = 0;
+	comp2.status    = 0;
+	comp2.packet_id = packet_id2;
+
+	init_completion(&comp3.done);
+	comp3.resp_data = NULL;
+	comp3.resp_len  = 0;
+	comp3.status    = 0;
+	comp3.packet_id = packet_id3;
+
+	ret = dcp_hfi_pending_add(hfi, &comp3);
+	if (ret) {
+		dev_err(hfi->dev,
+			"intf%u: PANEL_INIT: failed to register GENERIC_CAPS completion: %d\n",
+			intf_idx, ret);
+		goto err_free_both;
+	}
+
+	ret = dcp_hfi_send_cmd_async(hfi, buf1,
+				     hfi_get_header_size(&hdl1), &comp1);
+	if (ret) {
+		dev_err(hfi->dev,
+			"intf%u: PANEL_INIT caps/generic (header A) failed\n",
+			intf_idx);
+		dcp_hfi_pending_find(hfi, packet_id3);
+		dcp_hfi_buf_free(hfi, buf2);
+		return ret;
+	}
+
+	/* Stack completions must be retired before returning after submission. */
+	ret = dcp_hfi_send_cmd_async(hfi, buf2,
+				     hfi_get_header_size(&hdl2), &comp2);
+	if (ret) {
+		dev_err(hfi->dev,
+			"intf%u: HFI_COMMAND_PANEL_INIT_TIMING_MODE_CAPS (header B) failed\n",
+			intf_idx);
+		comp2.packet_id = 0; /* never registered/in-flight, nothing to wait on */
+	}
+
+	timeout1 = dcp_hfi_panel_wait(hfi, &comp1);
+	timeout3 = dcp_hfi_panel_wait(hfi, &comp3);
+	if (comp2.packet_id)
+		timeout2 = dcp_hfi_panel_wait(hfi, &comp2);
+	else
+		timeout2 = false;
+
+	if (timeout1 || timeout2 || timeout3) {
+		dev_err(hfi->dev,
+			"intf%u: HFI PANEL_INIT timed out (caps=%d timing_mode=%d generic=%d)\n",
+			intf_idx, !timeout1, !timeout2, !timeout3);
+		return -ETIMEDOUT;
+	}
+
+	if (ret)
+		return ret; /* header B send_cmd_async failure, comp1/comp3 now retired */
+
+	if (comp1.status || comp2.status || comp3.status)
+		dev_err(hfi->dev,
+			"intf%u: PANEL_INIT failed: caps=%d topology=%d generic=%d\n",
+			intf_idx, comp1.status, comp2.status, comp3.status);
+
+	return comp1.status ? comp1.status :
+	       comp2.status ? comp2.status : comp3.status;
+
+err_free_both:
+	dcp_hfi_buf_free(hfi, buf2);
+err_free_buf1:
+	dcp_hfi_buf_free(hfi, buf1);
+	return ret;
+}
+
+ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
+			     const struct mipi_dsi_msg *msg,
+			     void *tx_buf, dma_addr_t tx_iova,
+			     void *rx_buf, dma_addr_t rx_iova,
+			     u32 post_wait_ms, u32 ctrl_idx)
+{
+	struct hfi_dsi_cmd_desc cmd_desc = {};
+	static atomic_t seq_no = ATOMIC_INIT(0);
+	int ret;
+
+	if (!msg || !msg->tx_buf || !msg->tx_len)
+		return -EINVAL;
+
+	if (msg->rx_len && (!msg->rx_buf || !rx_buf))
+		return -EINVAL;
+
+	if (msg->tx_len > DCP_DSI_DCS_TX_BUF_SIZE) {
+		dev_err(hfi->dev, "DCS TX too large: %zu > %u\n",
+			msg->tx_len, DCP_DSI_DCS_TX_BUF_SIZE);
+		return -EINVAL;
+	}
+
+	memcpy(tx_buf, msg->tx_buf, msg->tx_len);
+
+	cmd_desc.size             = sizeof(cmd_desc);
+	cmd_desc.channel          = msg->channel;
+	cmd_desc.type             = msg->type;
+	cmd_desc.flags            = msg->flags;
+	cmd_desc.tx_len           = msg->tx_len;
+	cmd_desc.tx_buff_addr_lsb = lower_32_bits(tx_iova);
+	cmd_desc.tx_buff_addr_msb = upper_32_bits(tx_iova);
+	cmd_desc.ctrl_idx         = ctrl_idx;
+	cmd_desc.ctrl_flags       = DCP_DSI_CTRL_CMD_FETCH_MEMORY |
+					DCP_DSI_CTRL_CMD_LAST_COMMAND;
+	if (msg->rx_len)
+		cmd_desc.ctrl_flags |= DCP_DSI_CTRL_CMD_READ;
+	cmd_desc.last_command     = 1;
+	cmd_desc.post_wait_ms     = post_wait_ms;
+	cmd_desc.seq_no           = atomic_inc_return(&seq_no);
+
+	if (msg->rx_len > 0) {
+		if (msg->rx_len > DCP_DSI_DCS_RX_BUF_SIZE)
+			return -EINVAL;
+		memset(rx_buf, 0, msg->rx_len);
+		cmd_desc.rx_len           = msg->rx_len;
+		cmd_desc.rx_buff_addr_lsb = lower_32_bits(rx_iova);
+		cmd_desc.rx_buff_addr_msb = upper_32_bits(rx_iova);
+	}
+
+	ret = dcp_hfi_send_sync(hfi,
+				HFI_COMMAND_DISPLAY_TRANSFER_DCS_CMD,
+				HFI_CMD_BUFF_DISPLAY,
+				session_id,
+				HFI_PAYLOAD_U32_ARRAY,
+				&cmd_desc, sizeof(cmd_desc),
+				HFI_TX_FLAGS_RESPONSE_REQUIRED |
+				HFI_TX_FLAGS_NON_DISCARDABLE,
+				NULL, 0,
+				DCP_HFI_TIMEOUT_DISPLAY_DCS_MS);
+	if (ret) {
+		dev_err(hfi->dev,
+			"HFI DCS_TRANSFER type=0x%x len=%zu failed: %d\n",
+			msg->type, msg->tx_len, ret);
+		return ret;
+	}
+
+	if (msg->rx_len > 0)
+		memcpy(msg->rx_buf, rx_buf, msg->rx_len);
+
+	return msg->tx_len;
+}

-- 
2.43.0

