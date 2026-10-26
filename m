Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995746;
	b=nDsmx8LZN+F4t86v1bHHHi2hRI02I7OruD6EjT2DTdk3pImqvDn7DdFOMfqSJtJZc3Hn
	 q/BEXhGS33p+wG5xv/YHKX1so8WJuKnGQCZs/BNac7I60JFpvfxyLTorcVaqDeMhJY0Cu
	 AfssUOKGxoSv881Diu7ZuGF9wp//vx9wmNpp3ehWKryfS1uj4KQiT7yPF5vwXNczhi9FN
	 LaGFmb90SB5II/2XlqzEkPWCfiApFni1m6Rux9TpArdO3EusCxP8F26QzAd4hT20k/FBJ
	 XUMdcFtOrkmzehIAFoo8K1TWQPgv9SGavhfbAx9Sfqy+W3p2iUEQW2Fm53e3apJL+8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6oZSUaLiaSqFOb+1x976n9MXSh90eln4BSwfR3q3W2A=;
	b=MFhW9UmvFOjIzeN6PPD9eY6bKTaCN+JGzpAtqcS8GB4793vxmSbnK83AMvtWIGDVwDRp
	 EbwRKLP4Y2DNdsTrqL++/7+2dEiC1g8MUoaxW1ZOr3N0DOBh43n1taaAm5q5TWyGfCNQ4
	 CJ1gRN7orLgKnm79IPqLpVyANKiXBpzniOdS5pGjAp3zs7yfgQqOBOt3tLj6zGspb7b/o
	 F/ORFkI7zio83ybsPDaVLg0CHDuSwhaspl+AtmTfmZHMzHeVvkIkqHNWvdrK04pOd4KuB
	 GM40SCj2gWSIEqS1SeE7yxy7UrzfZxg4bd8qPb9dYVIjxdIlRqBuPG7WbVtmWXHseRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GvN3rfD3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d23AeMMl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB03A606A31B
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB03A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GvN3rfD3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d23AeMMl
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aVEJ2222637
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6oZSUaLiaSqFOb+1x976n9MXSh90eln4BSwfR3q3W2A=; b=GvN3rfD33LfdJBpO
	+7zvv63kLWYgqlKIkg5bcOBPZD6q5jxwFZY2qkgkmvF34J9s+ojXKJKdubIYPXCI
	SDGwu7ck2prdpfejD6AkGpxsAPv7UfMQpdM/Enz6hHYIw43MdYr5gsQAbujOUwNb
	Jfj3jPYKDipgaihM1j4Oe0+W3VkeWPRtY53b7IQOIJlLSWHgEsGpnaILELlGzjPj
	9l8Y2+rYj5Gs1db0FHPVw4VJhgcUEH5BRP0M6SUwCFAuv585nXgL9TFrWFYJPa+z
	XGzfzcXPk8IrCDz/dZSn07eVF2kBLc2/qqLQpjGvsEYIxT12dvJualCavLax1ovu
	HRj1SQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd8thd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:22:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso28665225ad.3
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995743; x=1793600543; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6oZSUaLiaSqFOb+1x976n9MXSh90eln4BSwfR3q3W2A=;
        b=d23AeMMlUH2P73MgRC306l96+dE8iT58WVkHsl9GTi9EsTfwz1xsml0YIMHR0/BHuN
         pCZcxLrYMAEiD0OM5GpCypnz7G5xkI70RiN7Ylc0NxKiUuOAwMOk/FZxHAiAedVDE968
         pD4fCCFfQcyylM3+6WeGRm5RfFZpyFtz4XBrw+6LjrXRZrUbsUWk43Uqr1QhAKDw4X/u
         oj3SCk25G6F9mleZtAG4rIt5W4LnrSpgKcfyjHOZUEdanTEwDuAjYIwlWeSh6pqSuFLE
         2Qyh9ef4ziBpsoVOGU4WhFWgSJSdVN6RdoOFamWVKh4/vlYWH/TUwgg2/lnD69rebIjj
         26DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995743; x=1793600543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oZSUaLiaSqFOb+1x976n9MXSh90eln4BSwfR3q3W2A=;
        b=2eEkzSUYQd8UrLHNZPZ4R6V6ZEaMrr0ElK8b4v9R+4a70JjyKcoDl602zHCbQnKnAM
         ebrQyzl4HesmB7breB60N1jksbMQHQaWPvcV6oZxMgDTDBFWkAYmW8iMZVvEe+mVhZGZ
         gWAJsor/u3OYCvYn/tGvWaVWffEctolbz5I+lwpxAyTALhvZHfGU82ZLjBWH88/l0nqY
         zn406cbWOWQbT7TipAUX9jOoIEzqZ0JoHQIC6aeVObnDw91uMMWSmLW56XgyeJpg0bxU
         3IDOD24phPy8IoKamdMI5c78Ou1TG30VckxS7y6dmREQfMWFhi88oTQ8UbccjO9RRSTZ
         yjoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzFOVPCrVzRlM6FsGBmRmH8cXnG9K1sM7CsCP95LXdN0EopA3mMnPTDftbvrAbiGfDoEuga0JBmT1HpVRlDw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJILAZCaDMWRPcxNk3K6742WxooNMMIUS/7w9ojseCQ2xOxwDfg
	QYUzjOthFulHl76IQbl1eiz7yPxZ5jPYdQfsaQvEEiiOlnV6NoIsHYhXhWekzJhP2gUQDv9F2oL
	KXPNMoATkF/w/DhQ0ywaB7amWeswNulXzhLt4iqxup5aQIrhkslyZ3TDlMv+zPqvxnbIDZw==
X-Gm-Gg: AYBFou2RnWPI8MNlwv5qQcYCiRPetAVCrHIJp1s9OX3XaZo7pyu0+wgzTDj0rrN/x2B
	441q7895ckfLLNMXT0Jwi07lmVVeoNXXX6+IIZ85ShShuFuBX1gyAus3n51iMggCu6KLXy+xBXX
	jR5cmjtvuVZDo/vbyuGqDz5mJoTwBb+IN4AlUE9qiNwzJcSi6iUKEbFvjUxsELs4vxhnBFzuN6z
	MsHB5R9/o6+PCh8b0tb3F/rmGY4XDwlWGFAT2VZzY9kr1OSg63pmmkw7TCnLJHidkaL74az5xNc
	bHzGfMZB7ffBTP/I7typ0Wx2HUmtEPANzDabhVoWmQMEuXxftVGKNpH1pgiZrkgUwPJdGInBK1A
	VvmZjN2nRvkvuTeQeR+YZEvtu2vptjm5b2Q==
X-Received: by 2002:a17:902:fc45:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2ea9c7bf298mr50931185ad.47.1792995742276;
        Sun, 25 Oct 2026 23:22:22 -0700 (PDT)
X-Received: by 2002:a17:902:fc45:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2ea9c7bf298mr50930685ad.47.1792995741515;
        Sun, 25 Oct 2026 23:22:21 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:22:21 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:14 +0530
Subject: [PATCH v2 04/23] drm/msm/dcp: Add HFI display definitions
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-4-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=47013;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=anTSHEbTjelsWxQdvO0XHgYVaaakwKL2MBegacpem60=;
 b=cWSC/vILcIfT0icREuzZ0XNfWomQfuzmbCRwjHj4ocSF7sCcBQEwKLRqCOejgx5Ii7/bLxEBL
 ewkqG0IRfIkACRSLwlvf5y+ceAjH+VFukRE653XAq114Uhug/VJu9sQ
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: 5rhfkCJIYgIIx08iLHfN29umyOqszeUY
X-Proofpoint-GUID: 5rhfkCJIYgIIx08iLHfN29umyOqszeUY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX+I3cRjhrrCQ7
 9qOcx2/CyfXRqw6hm72s/JXCLAGbp/vmoXrAno5mehG5V0Ps5xslAlMaTm0B5vzl3TX0ap240g0
 HNnZ5PUezC+5d6SRHb3MFhzlLjt4pikIiWkHDTqxT5oHR6BH1qDOg98iZsfqQRCRivZGBs2FiSd
 a6yO4Xj3R1kDi6J01+imjbfCkXSUUMQ6iDoTeDRajpWSoB7m0cHl5ZXqwAJVokNKLwTrPtX26dH
 pFli8mNahVW3huBXBrYS+o8j5O/iRou3A1dVAgNnY5BC9/0Yasxm3p/Yf6X+LIhUZVOx3ZdAlaJ
 UvGymQBqpPPo3zb3CrNHdIczuWkU+O0jmKR7omCJWrWdYgQkXPm9572iKNxvS2mPzzHVUMef7uc
 G6beoFxyAXqR4BEERlV+knSmQUpnZdcwYSO48/3NXX+oX6n4y2v5JY4XO3IZgfIJl9hmcJAGmSE
 a5bDHZ/2eyc170tMtSA==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adef19f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=OHF3rh-K3CxaddEARscA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXwbfPKGdL4xXT
 9qVk1QPaIK7qbAVr1ltKirZFqwe2O4ZtX5H3VGjDMwvg8pMNQx2BR7imMT17YgbHrnLz28cB0L0
 0jL7gWyy79CrVGJPUKLDZviewzauCLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Define the HFI display protocol used to configure the firmware-owned
display pipeline. DCP does not expose host-visible display registers,
so DRM state must be represented by display commands and properties.

Describe display commands, events, data structures, color-management
data, and property identifiers consumed by the DCP KMS and command
layers.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h | 105 +++++
 .../drm/msm/dcp/hfi/hfi_commands_display_events.h  |  90 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h     | 464 ++++++++++++++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h   | 247 +++++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_properties_display.h   | 480 +++++++++++++++++++++
 5 files changed, 1386 insertions(+)

diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h
new file mode 100644
index 000000000000..5f24b45e67b1
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_COMMANDS_DISPLAY_H__
+#define __H_HFI_COMMANDS_DISPLAY_H__
+
+/* Display-command range. */
+#define HFI_COMMAND_DISPLAY_BEGIN                                     0x02000000
+
+/* Set display properties. */
+#define HFI_COMMAND_DISPLAY_SET_PROPERTY                              0x02000001
+
+/* Read display or layer properties. */
+#define HFI_COMMAND_DISPLAY_GET_PROPERTY                              0x02000002
+
+/* Commit previously submitted display state. */
+#define HFI_COMMAND_DISPLAY_FRAME_TRIGGER                             0x02000003
+
+/* Register a display event. */
+#define HFI_COMMAND_DISPLAY_EVENT_REGISTER                            0x02000004
+
+/* Unregister a display event. */
+#define HFI_COMMAND_DISPLAY_EVENT_DEREGISTER                          0x02000005
+
+/* Enable the display session. */
+#define HFI_COMMAND_DISPLAY_ENABLE                                    0x02000006
+
+/* Send post-enable panel commands. */
+#define HFI_COMMAND_DISPLAY_POST_ENABLE                               0x02000007
+
+/* Disable the display stream. */
+#define HFI_COMMAND_DISPLAY_DISABLE                                   0x02000008
+
+/* Release post-disable display resources. */
+#define HFI_COMMAND_DISPLAY_POST_DISABLE                              0x02000009
+
+/* Set a previously validated display mode. */
+#define HFI_COMMAND_DISPLAY_SET_MODE                                  0x0200000a
+
+/* Validate a display mode in firmware. */
+#define HFI_COMMAND_DISPLAY_MODE_VALIDATE                             0x0200000b
+
+/* Request host-side display power control. */
+#define HFI_COMMAND_DISPLAY_POWER_CONTROL                             0x0200000c
+
+/* Register display power-control handling. */
+#define HFI_COMMAND_DISPLAY_POWER_REGISTER                            0x0200000d
+
+/* Transfer one DCS command. */
+#define HFI_COMMAND_DISPLAY_TRANSFER_DCS_CMD                          0x0200000e
+
+/* Transfer a DCS command set. */
+#define HFI_COMMAND_DISPLAY_TRANSFER_DCS_CMD_SET                      0x0200001d
+
+/* Configure the display idle timer. */
+#define HFI_COMMAND_DISPLAY_IDLE_TIMER_CONTROL                        0x0200000f
+
+/* Configure DisplayPort transfer units. */
+#define HFI_COMMAND_DISPLAY_SET_DP_TU                                 0x02000010
+
+/* Configure HDR display properties. */
+#define HFI_COMMAND_DISPLAY_CONFIG_HDR                                0x02000011
+
+/* Configure display audio. */
+#define HFI_COMMAND_DISPLAY_AUDIO_CONFIG                              0x02000012
+
+/* Control display audio. */
+#define HFI_COMMAND_DISPLAY_AUDIO_CONTROL                             0x02000013
+
+/* Set the display color space. */
+#define HFI_COMMAND_DISPLAY_SET_COLORSPACE                            0x02000014
+
+/* Provide the HDCP 1.x AKSV. */
+#define HFI_COMMAND_DISPLAY_HDCP1X_AKSV                               0x02000015
+
+/* Provide an HDCP 2.x response. */
+#define HFI_COMMAND_DISPLAY_HDCP2X_RESPONSE                           0x02000016
+
+/* Report sink HDCP capabilities. */
+#define HFI_COMMAND_DISPLAY_HDCP_FEATURE_SUPPORTED                    0x02000017
+
+/* Configure DSI DCS command remapping. */
+#define HFI_COMMAND_DISPLAY_DSI_CUSTOM_DCS_CMDS_SET_REMAP             0x02000018
+
+/* Configure DSI DCS command replacement. */
+#define HFI_COMMAND_DISPLAY_DSI_CUSTOM_DCS_CMDS_SET_REPLACE           0x02000019
+
+/* Configure display batch mode. */
+#define HFI_COMMAND_DISPLAY_BATCH_MODE                                0x0200001a
+
+/* Configure the display HFI subsystem. */
+#define HFI_COMMAND_DISPLAY_HFI_SUBSYSTEM_CONFIG                      0x0200001b
+
+/* Execute a DCS low-power command type. */
+#define HFI_COMMAND_DISPLAY_EXEC_DCS_CMD_TYPE                         0x0200001c
+
+/* End of display-command range. */
+#define HFI_COMMAND_DISPLAY_END                                       0x02ffffff
+
+/* Alias for the display-command range end. */
+#define HFI_COMMAND_DISPLAY_CLOSE                                     HFI_COMMAND_DISPLAY_END
+
+#endif /* __H_HFI_COMMANDS_DISPLAY_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display_events.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display_events.h
new file mode 100644
index 000000000000..48d9c936b672
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display_events.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_COMMANDS_DISPLAY_EVENTS_H
+#define __H_HFI_COMMANDS_DISPLAY_EVENTS_H
+
+/* Display-event command range. */
+#define HFI_COMMAND_DISPLAY_EVENT_BEGIN                                         0x04000000
+
+/* Report vertical sync and its index. */
+#define HFI_COMMAND_DISPLAY_EVENT_VSYNC                                         0x04000001
+
+/* Report frame-scan start and sequence ID. */
+#define HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START                              0x04000002
+
+/* Report frame-scan completion. */
+#define HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE                           0x04000003
+
+/* Report display idle state. */
+#define HFI_COMMAND_DISPLAY_EVENT_IDLE                                          0x04000004
+
+/* Report display power-state changes. */
+#define HFI_COMMAND_DISPLAY_EVENT_POWER                                         0x04000005
+
+/* Report display hardware recovery. */
+#define HFI_COMMAND_DISPLAY_EVENT_HW_RECOVERY                                   0x04000006
+
+/* Report frame-capture completion. */
+#define HFI_COMMAND_DISPLAY_EVENT_FRAME_CAPTURE_COMPLETE                        0x04000007
+
+/* Report an unrecoverable panel failure. */
+#define HFI_COMMAND_DISPLAY_EVENT_PANEL_DEAD                                    0x04000008
+
+/* Report LTM statistics events. */
+#define HFI_COMMAND_DISPLAY_EVENT_LTM                                           0x04000009
+
+/* Report RGB histogram events. */
+#define HFI_COMMAND_DISPLAY_EVENT_RGB_HIST                                      0x0400000a
+
+/* Report PA histogram events. */
+#define HFI_COMMAND_DISPLAY_EVENT_PA_HIST                                       0x0400000b
+
+/* Report hotplug status. */
+#define HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS                                    0x0400000c
+
+/* Report EDID and supported modes. */
+#define HFI_COMMAND_DISPLAY_EVENT_EDID_INFO                                     0x0400000d
+
+/* Report SPR/OPR values at frame scan. */
+#define HFI_COMMAND_DISPLAY_EVENT_SPR_OPR                                       0x0400000e
+
+/* Report interface MISR values at frame scan. */
+#define HFI_COMMAND_DISPLAY_EVENT_INTERFACE_MISR                                0x0400000f
+
+/* Request HDCP 1.x authentication start. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_START                                  0x04000010
+
+/* Request HDCP 1.x authentication stop. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_STOP                                   0x04000011
+
+/* Update HDCP 1.x encryption state. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_ENC                                    0x04000012
+
+/* Update HDCP 1.x repeater topology. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_TOPOLOGY_UPDATE                        0x04000013
+
+/* Start the HDCP 2.x sequence. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP2X_START                                  0x04000014
+
+/* Process an HDCP 2.x message. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP2X_PROCESS_MSG                            0x04000015
+
+/* Report an HDCP 2.x message timeout. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP2X_TIMEOUT                                0x04000016
+
+/* Report sink HDCP capabilities. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP_FEATURE_SUPPORTED                        0x04000017
+
+/* Report COPR status data. */
+#define HFI_COMMAND_DISPLAY_EVENT_AIQE_COPR_READ                                0x04000018
+
+/* Report programmable-line events. */
+#define HFI_COMMAND_DISPLAY_EVENT_PROG_LINE                                     0x04000019
+
+/* End of display-event command range. */
+#define HFI_COMMAND_DISPLAY_EVENT_END                                           0x04ffffff
+
+#endif /* __H_HFI_COMMANDS_DISPLAY_EVENTS_H */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h
new file mode 100644
index 000000000000..c01a001409ce
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h
@@ -0,0 +1,464 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_DISPLAY_H__
+#define __H_HFI_DEFS_DISPLAY_H__
+
+#include "hfi_defs_common.h"
+
+/* Display blending and power controls. */
+enum hfi_display_blend_ops {
+	HFI_BLEND_OP_NOT_DEFINED        = 0x0,
+	HFI_BLEND_OP_OPAQUE             = 0x1,
+	HFI_BLEND_OP_PREMULTIPLIED      = 0x2,
+	HFI_BLEND_OP_COVERAGE           = 0x3,
+	HFI_BLEND_OP_SKIP               = 0x4,
+	HFI_BLEND_OP_MAX                = 0x5,
+};
+
+enum hfi_display_power_mode {
+	HFI_MODE_DPMS_INVALID   = 0,
+	HFI_MODE_DPMS_OFF       = 0x1,
+	HFI_MODE_DPMS_ON        = 0x2,
+	HFI_MODE_DPMS_LP1       = 0x3,
+	HFI_MODE_DPMS_LP2       = 0x4,
+	HFI_MODE_DPMS_NOLP      = 0x5,
+};
+
+enum hfi_display_power_control {
+	HFI_PANEL_POWER      = 0x1,
+	HFI_CTRL_POWER       = 0x2,
+	HFI_PHY_POWER        = 0x4,
+};
+
+enum hfi_display_commit_flag {
+	HFI_VALIDATE           = 0x1,
+	HFI_COMMIT             = 0x2,
+};
+
+enum hfi_display_res_type {
+	HFI_RESOURCE_LM = 0x1,
+};
+
+/* Firmware resource configuration. */
+struct hfi_resource_cfg {
+	u32 res_type;
+	u32 resource_idx;
+	u32 width;
+	u32 height;
+	u32 reserved;
+};
+
+/* Display region of interest. */
+struct hfi_display_roi {
+	u32 x_pos;
+	u32 y_pos;
+	u32 width;
+	u32 height;
+};
+
+enum hfi_display_roi_type {
+	PANEL_ROI = 0x0,
+};
+
+/* VSync event payload. */
+struct hfi_display_vsync_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 vsync_index;
+};
+
+/* Frame-scan event payload. */
+struct hfi_display_frame_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 bufferflip_index;
+};
+
+struct hfi_display_color {
+	u16 color_0;
+	u16 color_1;
+	u16 color_2;
+	u16 color_3;
+};
+
+enum hfi_display_dim_layer_flag {
+	HFI_DIM_LAYER_INCLUSIVE = 0x1,
+	HFI_DIM_LAYER_EXCLUSIVE = 0x2,
+};
+
+/* Dim-layer configuration. */
+struct hfi_display_dim_layer {
+	enum hfi_display_dim_layer_flag flags;
+	u32 stage;
+	struct hfi_display_color color_fill;
+	struct hfi_display_roi rect;
+};
+
+enum hfi_layer_cache_state {
+	HFI_CACHE_STATE_DISABLE = 0x0,
+	HFI_CACHE_STATE_READ = 0x1,
+	HFI_CACHE_STATE_WRITE = 0x2,
+};
+
+enum hfi_layer_cache_op_type {
+	HFI_CACHE_OP_TYPE_NONE = 0x0,
+	HFI_CACHE_NORMAL_CACHEABLE_READ = 0x1,
+	HFI_CACHE_READ_INVALIDATE = 0x2,
+	HFI_CACHE_READ_EVICT = 0x3,
+	HFI_CACHE_PREFETCH_READ = 0x4,
+};
+
+/* Autorefresh configuration. */
+struct hfi_display_autorefresh_cfg {
+	u32 enable;
+	u32 frame_count;
+};
+
+struct hfi_display_idle_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 idle_index;
+};
+
+struct hfi_display_power_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	enum hfi_display_power_mode power_state;
+};
+
+struct hfi_display_prog_line_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 prog_line_index;
+};
+
+enum hfi_display_idle_timer_control {
+	HFI_DEFAULT          = 0x0,
+	HFI_WAKEUP           = 0x1,
+	HFI_BLOCK_TIMER      = 0x2,
+	HFI_UNBLOCK_TIMER    = 0x3,
+};
+
+/* Display event identifiers. */
+enum hfi_display_event_id {
+	HFI_EVENT_VSYNC               = 0x1,
+	HFI_EVENT_FRAME_SCAN_START    = 0x2,
+	HFI_EVENT_FRAME_SCAN_COMPLETE = 0x3,
+	HFI_EVENT_FRAME_IDLE          = 0x4,
+	HFI_EVENT_DISPLAY_POWER       = 0x5,
+	HFI_EVENT_HW_RECOVERY         = 0x6,
+	HFI_EVENT_FRAME_CAPTURE_COMPLETE = 0x7,
+	HFI_EVENT_PANEL_DEAD          = 0x8,
+	HFI_EVENT_LTM                 = 0x9,
+	HFI_EVENT_RGB_HIST            = 0xa,
+	HFI_EVENT_PA_HIST             = 0xb,
+	HFI_EVENT_HPD_STATUS          = 0xc,
+	HFI_EVENT_DISPLAY_EDID_INFO   = 0xd,
+	HFI_EVENT_SPR_OPR             = 0xe,
+	HFI_EVENT_INTF_MISR           = 0xf,
+	HFI_EVENT_HDCP1X_START        = 0x10,
+	HFI_EVENT_HDCP1X_STOP         = 0x11,
+	HFI_EVENT_HDCP1X_ENC          = 0x12,
+	HFI_EVENT_HDCP1X_TOPOLOGY_UPDATE = 0x13,
+	HFI_EVENT_HDCP2X_START        = 0x14,
+	HFI_EVENT_HDCP2X_PROCESS_MSG  = 0x15,
+	HFI_EVENT_HDCP2X_TIMEOUT      = 0x16,
+	HFI_EVENT_HDCP_FEATURE_SUPPORTED = 0x17,
+	HFI_EVENT_AIQE_COPR           = 0x18,
+	HFI_EVENT_PROG_LINE_INTR      = 0x19,
+};
+
+enum hfi_display_dp_event {
+	HFI_DP_EVENT_NONE         = 0x0,
+	HFI_DP_EVENT_HPD_PLUGGED  = 0x1,
+	HFI_DP_EVENT_IRQ_HPD      = 0x2,
+	HFI_DP_EVENT_SET_MODE     = 0x3,
+	HFI_DP_EVENT_HPD_UNPLUGGED = 0x4,
+};
+
+enum hfi_display_dp_state {
+	HFI_DP_STATE_DISCONNECTED = 0x0,
+	HFI_DP_STATE_HPD_IN       = 0x1,
+	HFI_DP_STATE_CONNECTED    = 0x2,
+	HFI_DP_STATE_HPD_OUT      = 0x3,
+};
+
+struct hfi_display_hpd_status {
+	enum hfi_display_dp_event dp_evt;
+	enum hfi_display_dp_state dp_state;
+};
+
+/* Display mode sent to firmware. */
+struct hfi_display_mode_info {
+	u32 size;
+	u32 h_active;
+	u32 h_back_porch;
+	u32 h_sync_width;
+	u32 h_front_porch;
+	u32 h_skew;
+	u32 h_sync_polarity;
+	u32 v_active;
+	u32 v_back_porch;
+	u32 v_sync_width;
+	u32 v_front_porch;
+	u32 v_sync_polarity;
+	u32 refresh_rate;
+	u32 clk_rate_hz_lo;
+	u32 clk_rate_hz_hi;
+	u32 flags_lo;
+	u32 flags_hi;
+	u32 reserved1;
+	u32 reserved2;
+};
+
+/* DSI command descriptor. */
+struct hfi_dsi_cmd_desc {
+	u32 size;
+
+	u8 channel;
+	u8 type;
+	u16 flags;
+
+		u32 tx_len;
+	u32 tx_buff_addr_lsb;
+	u32 tx_buff_addr_msb;
+
+		u32 rx_len;
+	u32 rx_buff_addr_lsb;
+	u32 rx_buff_addr_msb;
+
+		u32 ctrl_idx;
+	u32 ctrl_flags;
+	u32 last_command;
+	u32 post_wait_ms;
+
+	u32 seq_no;
+
+		u32 reserved2;
+};
+
+/* DSI command descriptor. */
+struct hfi_dsi_cmd_desc_set {
+	u32 size;
+	u32 type;
+	u32 count;
+	u32 state;
+	u32 seq_no;
+	u32 reserved2;
+	struct hfi_dsi_cmd_desc cmds[];
+};
+
+enum hfi_display_blend_stage {
+	HFI_BLEND_STAGE_BASE,
+	HFI_BLEND_STAGE_0,
+	HFI_BLEND_STAGE_1,
+	HFI_BLEND_STAGE_2,
+	HFI_BLEND_STAGE_3,
+	HFI_BLEND_STAGE_4,
+	HFI_BLEND_STAGE_5,
+	HFI_BLEND_STAGE_6,
+	HFI_BLEND_STAGE_7,
+	HFI_BLEND_STAGE_8,
+	HFI_BLEND_STAGE_9,
+	HFI_BLEND_STAGE_10,
+};
+
+enum hfi_layer_fetch_mode {
+	HFI_PARALLEL_FETCH        = 0x0,
+	HFI_TIME_MULTIPLEX_FETCH  = 0x1,
+};
+
+enum hfi_layer_security_policy {
+	HFI_LAYER_SECURITY_POLICY_NON_SECURE                  = 0x0,
+	HFI_LAYER_SECURITY_POLICY_SECURE                      = 0x1,
+	HFI_LAYER_SECURITY_POLICY_SECURE_DIR_TRANSLATION      = 0x2,
+	HFI_LAYER_SECURITY_POLICY_MAX
+};
+
+#define HFI_DISPLAY_ROTATION_0   BIT(0)
+
+#define HFI_DISPLAY_ROTATION_90   BIT(1)
+
+#define HFI_DISPLAY_ROTATION_180     BIT(2)
+
+#define HFI_DISPLAY_ROTATION_270   BIT(3)
+
+#define HFI_DISPLAY_REFLECT_X   BIT(4)
+
+#define HFI_DISPLAY_REFLECT_Y   BIT(5)
+
+enum hfi_cwb_tap_points {
+	HFI_TAP_POINT_NONE,
+	HFI_TAP_POINT_LM,
+	HFI_TAP_POINT_DSPP,
+	HFI_TAP_POINT_DEMURA,
+	HFI_TAP_POINT_MAX,
+};
+
+enum hfi_fence_type {
+	HFI_FENCE_SCAN_START,
+	HFI_FENCE_SCAN_COMPLETE,
+};
+
+enum hfi_dp_sink_capability_flags {
+	HFI_DP_SINK_CAP_MST,
+	HFI_DP_SINK_CAP_DSC,
+	HFI_DP_SINK_CAP_FEC,
+};
+
+/* EDID and mode information. */
+struct hfi_display_event_edid_info {
+	u32 controller_id;
+	u32 stream_id;
+	u32 link_rate;
+	u32 lane_count;
+	u32 bits_per_pixel;
+	u32 flags;
+	struct hfi_buff edid_modes_buf;
+};
+
+struct hfi_display_dp_tu {
+	u32 dp_tu;
+	u32 valid_boundary;
+	u32 valid_boundary2;
+};
+
+/* Display audio configuration. */
+struct hfi_audio_config {
+	u32 sample_rate;
+	u32 num_of_channels;
+	u32 channel_allocation;
+	u32 level_shift;
+	u32 down_mix;
+	u32 sample_present;
+	u32 stream_id;
+};
+
+struct hfi_hdr_metadata {
+		u32 hdr_state;
+	u32 eotf;
+	u32 hdr_supported;
+	u32 display_primaries_x[HFI_MAX_COLOR_COMPONENTS];
+	u32 display_primaries_y[HFI_MAX_COLOR_COMPONENTS];
+	u32 white_point_x;
+	u32 white_point_y;
+	u32 max_luminance;
+	u32 min_luminance;
+	u32 max_content_light_level;
+	u32 max_average_light_level;
+};
+
+/* HDR display configuration. */
+struct hfi_display_hdr_cfg {
+	struct hfi_hdr_metadata hdr_meta;
+	u32 dynamic_hdr_payload_size;
+	u8 dynamic_hdr_payload[HFI_DHDR_PAYLOAD_MAX_SIZE];
+};
+
+enum hfi_colorimetry {
+	HFI_COLORIMETRY_DEFAULT            = 0,
+	HFI_COLORIMETRY_SMPTE_170M_YCC     = 1,
+	HFI_COLORIMETRY_BT709_YCC          = 2,
+	HFI_COLORIMETRY_XVYCC_601          = 3,
+	HFI_COLORIMETRY_XVYCC_709          = 4,
+	HFI_COLORIMETRY_SYCC_601           = 5,
+	HFI_COLORIMETRY_OPYCC_601          = 6,
+	HFI_COLORIMETRY_OPRGB              = 7,
+	HFI_COLORIMETRY_BT2020_CYCC        = 8,
+	HFI_COLORIMETRY_BT2020_RGB         = 9,
+	HFI_COLORIMETRY_BT2020_YCC         = 10,
+	HFI_COLORIMETRY_DCI_P3_RGB_D65     = 11,
+	HFI_COLORIMETRY_DCI_P3_RGB_THEATER = 12,
+};
+
+enum hfi_misr_block {
+	HFI_MISR_DSI   = 0x0,
+	HFI_MISR_MIXER = 0x1,
+	HFI_MISR_INTF  = 0x2,
+};
+
+enum hfi_batch_mode {
+	HFI_BATCH_MODE_NONE   = 0x0,
+	HFI_BATCH_MODE_START  = 0x1,
+	HFI_BATCH_MODE_END    = 0x2,
+	HFI_BATCH_MODE_CANCEL = 0x3,
+};
+
+enum hfi_batch_usecase_id {
+	HFI_BATCH_USECASE_NONE = 0,
+	HFI_BATCH_USECASE_GMU_REPROJ,
+};
+
+struct hfi_misr_config {
+	u32 enable;
+	u32 frame_count;
+	enum hfi_misr_block block;
+};
+
+/* HDCP 1.x topology. */
+struct hfi_hdcp1x_topology_data {
+	u32 depth;
+	u32 device_count;
+	u32 max_devices_exceeded;
+	u32 max_cascade_exceeded;
+};
+
+/* HDCP 2.x message payload. */
+struct hfi_hdcp2_message {
+	u32 timeout_ms;
+	u32 repeater_flag;
+	struct hfi_buff request;
+	struct hfi_buff response;
+};
+
+struct hfi_display_mode_extended_info {
+	u32 size;
+	struct hfi_display_mode_info base;
+	u32 mixer_count;
+	u32 cmpr_count;
+	u32 cmpr_enabled;
+	u32 cmpr_bpp;
+	u32 cmpr_slice_count;
+	u8  test_pattern;
+	u8  reserved[7];
+};
+
+struct hfi_cmd_set_remap {
+	u32 cmd_type;
+	u32 custom_cmd_type;
+	u32 flag;
+	u32 reserved;
+};
+
+struct hfi_dsi_dcs_cmd_set_replace_entry {
+	u32 dpu_buff_type_offset;
+	u32 cmd_type;
+	u32 count_cmds;
+	u32 hfi_buff_struct_offset;
+	u32 reserved;
+};
+
+struct hfi_custom_wd_te_params {
+	u32 wd_te_enabled;
+	u32 custom_fps;
+};
+
+/* Display batch-mode configuration. */
+struct hfi_batch_mode_info {
+	enum hfi_batch_mode mode;
+	enum hfi_batch_usecase_id usecase_id;
+	u32 reserved[2];
+};
+
+#define HFI_WB_DNSC_CFG_DISABLE	BIT(0)
+
+struct hfi_dnsc_cfg {
+	u32 flags;
+	u32 dst_width;
+	u32 dst_height;
+};
+
+#endif /* __H_HFI_DEFS_DISPLAY_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h
new file mode 100644
index 000000000000..7a474e0c55b7
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_DISPLAY_COLOR_H__
+#define __H_HFI_DEFS_DISPLAY_COLOR_H__
+
+#include <linux/types.h>
+
+#include "hfi_defs_common.h"
+
+#define HFI_DISPLAY_COLOR_FLAGS_FEATURE_ENABLE         BIT(0)
+
+#define HFI_DISPLAY_COLOR_FLAGS_FEATURE_BROADCAST      BIT(1)
+
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_0_FLAG    BIT(2)
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_1_FLAG    BIT(3)
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_2_FLAG    BIT(4)
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_3_FLAG    BIT(5)
+
+#define HFI_DITHER_MATRIX_SZ                16
+#define HFI_DITHER_LUMA_MODE                BIT(0)
+#define HFI_DITHER_OFFSET_ENABLE            BIT(1)
+
+#define HFI_DITHER_MATRIX_SZ_EXTENDED       256
+#define HFI_DITHER_MATRIX_SELECT_4_4        0
+#define HFI_DITHER_MATRIX_SELECT_6_6        1
+#define HFI_DITHER_MATRIX_SELECT_8_8        2
+#define HFI_DITHER_MATRIX_SELECT_16_16      3
+
+/* Dither configuration. */
+struct hfi_display_dither {
+	u32 flags;
+	u32 feature_flags;
+	u32 temporal_en;
+	u32 c0_bitdepth;
+	u32 c1_bitdepth;
+	u32 c2_bitdepth;
+	u32 c3_bitdepth;
+	u32 dither_matrix_select;
+	s32 matrix[HFI_DITHER_MATRIX_SZ_EXTENDED];
+};
+
+/* PA dither configuration. */
+struct hfi_display_pa_dither {
+	u32 flags;
+	u32 strength;
+	u32 offset_en;
+	u32 matrix[HFI_DITHER_MATRIX_SZ];
+};
+
+#define HFI_QRTC_LUT_SIZE 81        /* Each LUT is 9x9 */
+#define HFI_QRTC_NUM_LUTS 3         /* Number of LPF/HPF tables */
+
+/* QRTC subsampling modes. */
+#define HFI_QRTC_SUBSAMPLE_1x1 0x0  /* Horizontal: 1, Vertical: 1 */
+#define HFI_QRTC_SUBSAMPLE_2x1 0x1  /* Horizontal: 2, Vertical: 1 */
+#define HFI_QRTC_SUBSAMPLE_2x2 0x2  /* Horizontal: 2, Vertical: 2 */
+#define HFI_QRTC_SUBSAMPLE_3x3 0x3  /* Horizontal: 3, Vertical: 3 */
+
+/* QRTC DMA selections. */
+#define HFI_QRTC_DMA_1 0x1
+#define HFI_QRTC_DMA_3 0x3
+
+/* QRTC rectangle selections. */
+#define HFI_QRTC_RECT0 0x0  /* Select Rectangle 0 */
+#define HFI_QRTC_RECT1 0x1  /* Select Rectangle 1 */
+#define HFI_WRITE_BACK_0 0x0
+#define HFI_WRITE_BACK_1 0x1
+#define HFI_WRITE_BACK_2 0x2
+#define HFI_CWB_BLOCK_0 0x0
+#define HFI_CWB_BLOCK_1 0x1
+#define HFI_CWB_BLOCK_2 0x2
+#define HFI_CWB_BLOCK_3 0x3
+#define HFI_CWB_BLOCK_4 0x4
+#define HFI_CWB_BLOCK_5 0x5
+#define HFI_CWB_BLOCK_6 0x6
+#define HFI_CWB_BLOCK_7 0x7
+
+/* Bit 16 marks a secure QRTC buffer. */
+#define HFI_QRTC_SECURE_BUFF BIT(16)
+
+/* QRTC configuration and capture-buffer selection. */
+struct hfi_qrtc_config {
+	u32 flags;
+	u32 lut_dma_flags;
+	u32 iova_l;
+	u32 iova_h;
+	u32 len;
+	u32 coring_en;
+	u32 coring_pos;
+	u32 coring_neg;
+	u32 lpf_en;
+	u32 subsample_mode;
+	u32 dma_sel;
+	u32 rect_sel;
+	u32 wb_sel;
+	u32 cwb_sel;
+	u32 cwb_tap_point;
+	u32 cwb_iova_l;
+	u32 cwb_iova_h;
+	u32 cwb_len;
+	u32 cwb_height;
+	u32 cwb_width;
+	u32 format;
+	u32 aligned_cwb_height;
+	u32 aligned_cwb_width;
+};
+
+#define HFI_LTM_DATA_SIZE_0        32
+#define HFI_LTM_DATA_SIZE_1        128
+#define HFI_LTM_DATA_SIZE_2        256
+#define HFI_LTM_BLOCK_MAX          4
+
+#define HFI_LTM_STATS_SAT          BIT(1)
+#define HFI_LTM_STATS_MERGE_SAT    BIT(2)
+
+#define HFI_LTM_HIST_DONE                   BIT(0)
+#define HFI_LTM_WB_PB                       BIT(1)
+#define HFI_LTM_HIST_OFF                    BIT(2)
+
+struct hfi_display_ltm_init_param {
+	u32 flags;
+	u32 init_param_01;
+	u32 init_param_02;
+	u32 init_param_03;
+	u32 init_param_04;
+};
+
+struct hfi_display_ltm_cfg_param {
+	u32 flags;
+	u32 cfg_param_01;
+	u32 cfg_param_02;
+	u32 cfg_param_03;
+	u32 cfg_param_04;
+	u32 cfg_param_05;
+	u32 cfg_param_06;
+};
+
+/* Shared LTM statistics buffer descriptor. */
+struct hfi_display_ltm_buffer {
+	u32 flags;
+	u32 dpu_iova_l;
+	u32 dpu_iova_h;
+	u32 dcp_addr_l;
+	u32 dcp_addr_h;
+	u32 size;
+};
+
+struct hfi_display_ltm_stats_data {
+	u32 stats_01[HFI_LTM_DATA_SIZE_0][HFI_LTM_DATA_SIZE_1];
+	u32 stats_02[HFI_LTM_DATA_SIZE_2];
+	u32 stats_03[HFI_LTM_DATA_SIZE_0];
+	u32 stats_04[HFI_LTM_DATA_SIZE_0];
+	u32 stats_05[HFI_LTM_DATA_SIZE_0];
+	u32 status_flag;
+	u32 display_h;
+	u32 display_v;
+	u32 init_h[HFI_LTM_BLOCK_MAX];
+	u32 init_v;
+	u32 inc_h;
+	u32 inc_v;
+	u32 portrait_en;
+	u32 merge_en;
+	u32 cfg_param_01;
+	u32 cfg_param_02;
+	u32 cfg_param_03;
+	u32 cfg_param_04;
+	u32 feature_flag;
+	u32 checksum;
+};
+
+struct hfi_display_ltm_event_resp {
+	u32 event_type;
+	u32 dcp_addr_h;
+	u32 dcp_addr_l;
+};
+
+#define HFI_RGB_HISTOGRAM_BIN_COUNT 1024
+#define HFI_RGB_COMPONENT_SIZE 3
+
+#define HFI_RGB_HIST_ROI_ENABLE BIT(1)
+
+#define HFI_RGB_HIST_DONE BIT(0)
+#define HFI_RGB_HIST_WB_ERR BIT(1)
+#define HFI_RGB_HIST_OFF BIT(2)
+
+struct hfi_display_rgb_hist_ctrl {
+	u32 flags;
+	u32 roi_mode;
+	u32 roi_x;
+	u32 roi_y;
+	u32 roi_width;
+	u32 roi_height;
+	u32 tap_point;
+	u32 colorspace_mode;
+};
+
+struct hfi_display_rgb_hist_stats_data {
+	u32 hist[HFI_RGB_HISTOGRAM_BIN_COUNT];
+	u32 hist_min;
+	u32 hist_max;
+	u32 hist_sum_lsb;
+	u32 hist_sum_msb;
+	u32 hcount;
+	u32 crc;
+	u32 status_flags;
+	u32 roi_mode;
+	u32 roi_x;
+	u32 roi_y;
+	u32 roi_width;
+	u32 roi_height;
+	u32 tap_point;
+	u32 colorspace_mode;
+};
+
+/* Shared RGB histogram buffer descriptor. */
+struct hfi_display_rgb_hist_buffer {
+	u32 flags;
+	u32 dpu_iova_lo[HFI_RGB_COMPONENT_SIZE];
+	u32 dpu_iova_hi[HFI_RGB_COMPONENT_SIZE];
+	u32 dcp_addr_lo[HFI_RGB_COMPONENT_SIZE];
+	u32 dcp_addr_hi[HFI_RGB_COMPONENT_SIZE];
+	u32 size;
+};
+
+struct hfi_display_rgb_hist_event_resp {
+	u32 event_type;
+	u32 dcp_addr_lo[HFI_RGB_COMPONENT_SIZE];
+	u32 dcp_addr_hi[HFI_RGB_COMPONENT_SIZE];
+};
+
+/* Shared PA histogram buffer descriptor. */
+struct hfi_display_pa_hist_buffer {
+	u32 flags;
+	u32 dcp_addr_lo;
+	u32 dcp_addr_hi;
+	u32 size;
+};
+
+struct hfi_display_pa_hist_event_resp {
+	u32 dcp_addr_lo;
+	u32 dcp_addr_hi;
+};
+
+#endif /* __H_HFI_DEFS_DISPLAY_COLOR_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_display.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_display.h
new file mode 100644
index 000000000000..34a4220393f4
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_display.h
@@ -0,0 +1,480 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PROPERTIES_DISPLAY_H__
+#define __H_HFI_PROPERTIES_DISPLAY_H__
+
+/* Display-property range. */
+#define HFI_PROPERTY_DISPLAY_BEGIN                                   0x00020000
+
+/* Whether DIM layer is supported. */
+#define HFI_PROPERTY_DISPLAY_HAS_DIM_LAYER                           0x00020001
+
+/* Whether Idle PC is supported. */
+#define HFI_PROPERTY_DISPLAY_HAS_IDLE_PC                             0x00020002
+
+/* Whether LM Noise is supported. */
+#define HFI_PROPERTY_DISPLAY_LM_NOISE                                0x00020003
+
+/* Noise layer version. */
+#define HFI_PROPERTY_DISPLAY_NOISE_VERSION                           0x00020004
+
+/* Whether dedicated CWB is supported. */
+#define HFI_PROPERTY_DISPLAY_FEATURE_DEDICATED_CWB                   0x00020005
+
+/* Whether CWB feature is supported. */
+#define HFI_PROPERTY_DISPLAY_FEATURE_CWB                             0x00020006
+
+/* Whether system cache is used for static display traffic. */
+#define HFI_PROPERTY_DISPLAY_SYS_CACHE_DISP                          0x00020007
+
+/* Whether trusted-display mode is supported. */
+#define HFI_PROPERTY_DISPLAY_FEATURE_TRUSTED_DISPLAY_MODE            0x00020008
+
+/* Whether UBWC Statistics is supported. */
+#define HFI_PROPERTY_DISPLAY_UBWC_STATS                              0x00020009
+
+/* Whether dynamic clock control is supported. */
+#define HFI_PROPERTY_DISPLAY_DYN_CLK_SUPPORT                         0x0002000a
+
+/* Whether qsync mode is supported. */
+#define HFI_PROPERTY_DISPLAY_QSYNC                                   0x0002000b
+
+/* Whether AVR Step is supported. */
+#define HFI_PROPERTY_DISPLAY_AVR_STEP                                0x0002000c
+
+/* Whether CWB Dither is supported. */
+#define HFI_PROPERTY_DISPLAY_WB_CWB_DITHER                           0x0002000d
+
+/* Whether system cache is used for writeback. */
+#define HFI_PROPERTY_DISPLAY_WB_SYS_CACHE_DISP                       0x0002000e
+
+/* Whether writeback supports linear rotation. */
+#define HFI_PROPERTY_DISPLAY_WB_LINEAR_ROTATION                      0x0002000f
+
+/* The extended power modes supported by the Display. */
+#define HFI_PROPERTY_DISPLAY_POWER_MODE                              0x00020010
+
+/* The DPU DRAM IB vote for DRAM(LLCC(SDE)->DDR) in Kbps. */
+#define HFI_PROPERTY_DISPLAY_DRAM_IB                                 0x00020011
+
+/* The DPU DRAM AB vote for DRAM(LLCC(SDE)->DDR) in Kbps. */
+#define HFI_PROPERTY_DISPLAY_DRAM_AB                                 0x00020012
+
+/* The DPU LLCC IB vote for LLCC(SDE_master_on_MNOC->LLCC). */
+#define HFI_PROPERTY_DISPLAY_LLCC_IB                                 0x00020013
+
+/* The DPU LLCC IB vote for LLCC(SDE_master_on_MNOC->LLCC). */
+#define HFI_PROPERTY_DISPLAY_LLCC_AB                                 0x00020014
+
+/* The DPU IB vote for MNOC(virt_master-> virt_slave(NOC)). */
+#define HFI_PROPERTY_DISPLAY_CORE_IB                                 0x00020015
+
+/* The DPU AB vote for MNOC(virt_master-> virt_slave(NOC)). */
+#define HFI_PROPERTY_DISPLAY_CORE_AB                                 0x00020016
+
+/* The Mdp core clock in hertz. */
+#define HFI_PROPERTY_DISPLAY_CORE_CLK                                0x00020017
+
+/* Associates a layer before its properties are programmed. */
+#define HFI_PROPERTY_DISPLAY_ATTACH_LAYER                            0x00020018
+
+/* Removes a layer from the display. */
+#define HFI_PROPERTY_DISPLAY_DETACH_LAYER                            0x00020019
+
+/* Commit sequence returned with frame-scan events. */
+#define HFI_PROPERTY_DISPLAY_SCAN_SEQUENCE_ID                        0x0002001a
+
+/* Enables or disables interface auto-refresh. */
+#define HFI_PROPERTY_DISPLAY_AUTOREFRESH_CFG                         0x0002001b
+
+/* Configure the HFI queue. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_HFI_CONFIG                       0x0002001c
+
+/* Reports scratch-memory size required by LSR writeback. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_NEEDS_SCRATCH_MEM            0x0002001d
+
+/* Configure the scratch memory. */
+#define HFI_PROPERTY_DISPLAY_SET_SCRATCH_MEM                         0x0002001e
+
+/* Configure the sync display. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_REPROJ_SYNC_TO                   0x0002001f
+
+/* Configure the LSR. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_REPROJ_CONFIG_MATRIX                0x00020020
+
+/* Configure. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_REPROJ_CONFIG_EXT                0x00020021
+
+/* Configure. */
+#define HFI_PROPERTY_DISPLAY_INPUT_FENCE                             0x00020022
+
+/* Provide a reusable fence. */
+#define HFI_PROPERTY_DISPLAY_REUSABLE_FENCE                          0x00020023
+
+/* Configure the HFI queue. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_CVP_BUFF                       0x00020025
+
+/* Configure the output buffers. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_OUT_BUFFERS                       0x00020026
+
+/* Configure the LSR. */
+#define HFI_PROPERTY_DISPLAY_LSR_MAPPED_HFI_BASE_ADDR                  0x00020027
+
+/* Configure the shared memory. */
+#define HFI_PROPERTY_DISPLAY_HRP_HFI_CONFIG                            0x00020028
+
+/* Attach output layer before. */
+#define HFI_PROPERTY_DISPLAY_ATTACH_OUTPUT_LAYER                     0x00020029
+
+/* Removes an output layer from the display. */
+#define HFI_PROPERTY_DISPLAY_DETACH_OUTPUT_LAYER                     0x0002002a
+
+/* Set destination ROI for display. */
+#define HFI_PROPERTY_DISPLAY_DEST_ROI                                0x0002002b
+
+/* Configures output fence. */
+#define HFI_PROPERTY_DISPLAY_OUTPUT_FENCE                            0x0002002c
+
+/* The dim layer parameters for display output. */
+#define HFI_PROPERTY_DISPLAY_DIM_LAYER                               0x0002002d
+
+/* The dim layer parameters for display output. */
+#define HFI_PROPERTY_DISPLAY_MISR_CONFIG                             0x0002002e
+
+/* QSYNC mode for video/command mode panels. */
+#define HFI_PROPERTY_DISPLAY_QSYNC_MODE                              0x0002002f
+
+/* Configure resource output. */
+#define HFI_PROPERTY_DISPLAY_SET_RESOURCE_DATA                       0x00020030
+
+/* Set VRR (Variable Refresh Rate). */
+#define HFI_PROPERTY_DISPLAY_VRR_FRAME_PARAMS                        0x00020031
+
+/* The Expected Preset Time which is used. */
+#define HFI_PROPERTY_DISPLAY_EPT                                     0x00020032
+
+/* This property sets line pointer offset time in nanoseconds. */
+#define HFI_PROPERTY_DISPLAY_VSYNC_OFFSET                            0x00020033
+
+/* Update the panel brightness level. */
+#define HFI_PROPERTY_DISPLAY_BRIGHTNESS                              0x00020034
+
+/* Set vsync source to watchdog. */
+#define HFI_PROPERTY_DISPLAY_CUSTOM_WD_TE                                   0x00020035
+
+/* Display color-property range. */
+#define HFI_PROPERTY_DISPLAY_COLOR_BEGIN                             0x00020100
+
+/* Setup 3D LUT. */
+#define HFI_PROPERTY_DISPLAY_COLOR_3D_LUT                            0x00020101
+
+/* Setup IGC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_IGC                               0x00020102
+
+/* Setup GC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_GC                                0x00020103
+
+/* Setup PCC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PCC                               0x00020104
+
+/* Setup PA HSIC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_HSIC                              0x00020105
+
+/* Setup PA MEMCOLOR SKIN. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_SKIN                     0x00020106
+
+/* Setup PA MEMCOLOR SKY. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_SKY                      0x00020107
+
+/* Setup PA MEMCOLOR FOLIAGE. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_FOLIAGE                  0x00020108
+
+/* Setup PA MEMCOLOR PROTECTION. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_PROT                     0x00020109
+
+/* Setup PA SIXZONE. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SIXZONE                           0x0002010a
+
+/* Setup PA VLUT. */
+#define HFI_PROPERTY_DISPLAY_COLOR_VLUT                              0x0002010b
+
+/* Setup PPB DITHER. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DITHER                            0x0002010c
+
+/* Setup RC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RC                                0x0002010d
+
+/* Setup SPR_INIT config. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_INIT                          0x0002010e
+
+/* Setup SPR_UDC config. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_UDC                           0x0002010f
+
+/* Setup DSPP SPR DITHER. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_DITHER                        0x00020110
+
+/* Setup DSPP PA DITHER. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_DITHER                         0x00020111
+
+/* Setup Demura. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DEMURA_CFG                        0x00020112
+
+/* Setup Demura tables. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DEMURA_TABLE                      0x00020113
+
+/* Setup Demura backlight. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DEMURA_BACKLIGHT                  0x00020114
+
+/* Setup destination scaler. */
+#define HFI_PROPERTY_DISPLAY_DEST_SCALER                             0x00020115
+
+/* Setup QRTC config. */
+#define HFI_PROPERTY_DISPLAY_COLOR_QRTC_CONFIG                       0x00020116
+
+/* Setup LTM initialization params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_INIT                          0x00020117
+
+/* Setup LTM configuration params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_CFG                           0x00020118
+
+/* Setup LTM noise threshold. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_NOISE_THRESH                  0x00020119
+
+/* Setup LTM histogram control. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_HIST_CTRL                     0x0002011a
+
+/* Setup LTM VLUT table. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_VLUT                          0x0002011b
+
+/* Setup LTM initial params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_QUEUE_BUF                     0x0002011c
+
+/* Setup LTM initial params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_CLEAR_BUFS                    0x0002011d
+
+/* Property to configure RGB hist control. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RGB_HIST_CTRL                   0x0002011e
+
+/* Property to queue RGB histogram. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RGB_HIST_QUEUE_BUFFER           0x0002011f
+
+/* Property to clear all queued RGB. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RGB_HIST_CLEAR_BUFFERS          0x00020120
+
+/* Setup AI Scaler. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_AI_SCALER                    0x00020121
+
+/* Setup SSRC configuration. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_SSRC_CONFIG                  0x00020122
+
+/* Setup SSRC data. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_SSRC_DATA                    0x00020123
+
+/* Setup MDNIE. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_MDNIE                        0x00020124
+
+/* Setup IPC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_MDNIE_IPC                    0x00020125
+
+/* Setup ART. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_MDNIE_ART                    0x00020126
+
+/* Setup ABC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_ABC                          0x00020127
+
+/* Setup RC for PU. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RC_PU                             0x00020128
+
+/* Property to configure PA hist control. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_HIST_CTRL                      0x00020129
+
+/* Property to queue PA histogram. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_HIST_QUEUE_BUFFER              0x0002012a
+
+/* Property to clear all queued PA. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_HIST_CLEAR_BUFFERS             0x0002012b
+
+/* Property to setup SPR partial update. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_PU                            0x0002012c
+
+/* Property to setup SPR partial update. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_COPR                          0x0002012d
+
+/* End of display color properties. */
+#define HFI_PROPERTY_DISPLAY_COLOR_END                               0x000201ff
+
+/* End of display-property range. */
+#define HFI_PROPERTY_DISPLAY_END                                     0x0002ffff
+
+/* Layer-property range. */
+#define HFI_PROPERTY_LAYER_BEGIN                                     0x00030000
+
+/* Whether layer decimation is supported. */
+#define HFI_PROPERTY_LAYER_FEATURE_DECIMATION                        0x00030001
+
+/* Blend operations set by Host. */
+#define HFI_PROPERTY_LAYER_BLEND_TYPE                                0x00030002
+
+/* Blending alpha of the plane. */
+#define HFI_PROPERTY_LAYER_ALPHA                                     0x00030003
+
+/* Z-order of the plane. */
+#define HFI_PROPERTY_LAYER_ZPOS                                      0x00030004
+
+/* Source ROI per layer. */
+#define HFI_PROPERTY_LAYER_SRC_ROI                                   0x00030005
+
+/* Destination ROI per layer. */
+#define HFI_PROPERTY_LAYER_DEST_ROI                                  0x00030006
+
+/* Configures blend roi. */
+#define HFI_PROPERTY_LAYER_BLEND_ROI                                 0x00030007
+
+/* Total Image Height. */
+#define HFI_PROPERTY_LAYER_SRC_IMG_SIZE_H                            0x00030008
+
+/* Total Image Width. */
+#define HFI_PROPERTY_LAYER_SRC_IMG_SIZE_W                            0x00030009
+
+/* SMMU mapped source Image start address. */
+#define HFI_PROPERTY_LAYER_SRC_ADDR                                  0x0003000a
+
+/* Source Format Configuration for each layer. */
+#define HFI_PROPERTY_LAYER_SRC_FORMAT                                0x0003000b
+
+/* Stride for each layer. */
+#define HFI_PROPERTY_LAYER_STRIDE                                    0x0003000c
+
+/* Multi rectangle fetch modes. */
+#define HFI_PROPERTY_LAYER_MULTIRECT_MODE                            0x0003000d
+
+/* Blending background alpha of the plane. */
+#define HFI_PROPERTY_LAYER_BG_ALPHA                                  0x0003000e
+
+/* Source Region of Interest (ROI). */
+#define HFI_PROPERTY_OUTPUT_LAYER_SRC_ROI                            0x0003000f
+
+/* Destination Region of Interest(ROI). */
+#define HFI_PROPERTY_OUTPUT_LAYER_DST_ROI                            0x00030010
+
+/* Total image height of output buffer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_SRC_IMG_SIZE_H                      0x00030011
+
+/* Total image width of output buffer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_SRC_IMG_SIZE_W                      0x00030012
+
+/* SMMU mapped start address. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DST_ADDR                            0x00030013
+
+/* Destination Format Configuration of output buffer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DST_FORMAT                         0x00030014
+
+/* Stride for each layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_STRIDE                             0x00030015
+
+/* Rotation for each layer. */
+#define HFI_PROPERTY_LAYER_ROTATION                                  0x00030016
+
+/* Security policy settings applied. */
+#define HFI_PROPERTY_LAYER_SECURITY_POLICY                           0x00030017
+
+/* The LSR alpha buffer properties of the input layer. */
+#define HFI_PROPERTY_LAYER_LSR_IN_A_BUFFER                           0x00030018
+
+/* The LSR Reprojection layer's plane equation. */
+#define HFI_PROPERTY_LAYER_LSR_REPROJ_PLANE_EQ                       0x0003001a
+
+/* The layer's gamma type. */
+#define HFI_PROPERTY_LAYER_GAMMA                                     0x0003001b
+
+/* The LSR layer's local/remote/other type. */
+#define HFI_PROPERTY_LAYER_LSR_LAYER_TYPE                            0x0003001c
+
+/* The LSR layer's lock type. */
+#define HFI_PROPERTY_LAYER_LSR_LOCK_TYPE                             0x0003001d
+
+/* Sets the LSR reprojection render pose. */
+#define HFI_PROPERTY_LAYER_LSR_RENDER_POSE                           0x0003001e
+
+/* The LSR render frustum properties of the layer. */
+#define HFI_PROPERTY_LAYER_LSR_RENDER_FRUSTUM                        0x0003001f
+
+/* Custom buffers for this layer. */
+#define HFI_PROPERTY_LAYER_LSR_X_BUFFER                              0x00030020
+
+/* The LSR Reprojection pose properties of the layer. */
+#define HFI_PROPERTY_LAYER_LSR_REPROJ_POSE                           0x00030021
+
+/* Source image size of each layer in bytes. */
+#define HFI_PROPERTY_LAYER_SRC_IMAGE_SIZE                           0x00030022
+
+/* Rotation for output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_ROTATION                           0x00030023
+
+/* Sys cache related attributes for each layer. */
+#define HFI_PROPERTY_LAYER_CACHE_ATTR                                0x00030024
+
+/* LLCC scid of the system cache to be used. */
+#define HFI_PROPERTY_LAYER_LLCC_SCID                                 0x00030025
+
+/* Sets system-cache attributes for the output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_CACHE_ATTR                         0x00030026
+
+/* LLCC scid of the system cache to be used. */
+#define HFI_PROPERTY_OUTPUT_LAYER_LLCC_SCID                          0x00030027
+
+/* The CWB tap point for output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_CWB_TAP_POINT                      0x00030028
+
+/* Configure downscale blur. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DNSC_BLUR_CFG                      0x00030029
+
+/* Source exclusion rectangle region. */
+#define HFI_PROPERTY_LAYER_EXCLUSION_RECTANGLE_ROI                   0x0003002a
+
+/* Configure downscale. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DNSC_CFG                           0x0003002b
+
+/* The security policy for output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_SECURITY_POLICY                    0x00030031
+
+/* Sets the disparity-layer injection interval. */
+#define HFI_PROPERTY_LAYER_LSR_DISPARITY_PHASE                     0x00030032
+
+/* Layer color-property range. */
+#define HFI_PROPERTY_LAYER_COLOR_BEGIN                               0x00030100
+
+/* Setup VIG GAMUT. */
+#define HFI_PROPERTY_LAYER_COLOR_3D_LUT                              0x00030101
+
+/* Setup UCSC IGC. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_IGC                            0x00030102
+
+/* Setup UCSC UNMULT. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_UNMULT                         0x00030103
+
+/* Setup UCSC GC. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_GC                             0x00030104
+
+/* Setup UCSC ALPHA DITHER. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_ALPHA_DITHER                   0x00030105
+
+/* Setup UCSC CSC. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_CSC                            0x00030106
+
+/* Setup CSC. */
+#define HFI_PROPERTY_LAYER_COLOR_CSC                                 0x00030107
+
+/* Setup VIG scaler. */
+#define HFI_PROPERTY_LAYER_COLOR_SCALER                              0x00030108
+
+/* End of layer color properties. */
+#define HFI_PROPERTY_LAYER_COLOR_END                                 0x000301ff
+
+/* End of layer-property range. */
+#define HFI_PROPERTY_LAYER_END                                       0x0003ffff
+
+#endif /* __H_HFI_PROPERTIES_DISPLAY_H__ */

-- 
2.43.0

