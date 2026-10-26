Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995937;
	b=dGUjCZUwtcavFf2N/vNcdQ0ZbOlMZh7douMZQtjwbHfHIGhBB+Tn29UlBS9BPqiC06+K
	 FJLVuREDkm0Er9//BcB6mk/XvzlQYYm5pVJxk5jPyOLuruWs9hqpdkRn+lGsCcVcx1yN6
	 N47Bi7EllZ5Fjj3MmEEdWl6T0KDnxspFmNz+rcNeIESKR4tp3sw8GEs1+/pydCNO9ReCZ
	 QDAwz89zoojAoqFjGSTRfiBV7LmYj5ZLUYIi0Dws7bKrg+FJds0aHSPxJNbcdLDDLNXuH
	 9v/aRW4Dtg8711xQ6gF3WcQ1EeUpxOJp6vfDgi02S0vZGjSg5VWcXIYPx5iwkTDPNoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995937;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
	b=ndd4Ckmt9o238VsyjVEq1Wp4ybstxXRR59LN9wINKXelX6jFPoLESeS9HTRrWvBMbD3q
	 9UNvmXsIWcyLLiqaPPymddx0ad6+ZemacbXkY/6wrR3AaMhG3kFphxxJ4Vb2sVC+grmuW
	 5X3T1CLo6Az7W0SAlkxfiveKvxua6/tr0rHzxEjjnnJfi1424afYYsePSOZoj2Eki+M03
	 0+SkY44v78hsDTKODmu4g2xAWvk2cS+CxEiP91gvfJsKuN5WQBpOrOUzAaf1c6Fx83uS1
	 +rWusEPjarObsA931cnvfCa4g6oBmf8z14QNGEqtIonzKTxdCkXQ/jEC20BoilT6tiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d6jUNACE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AbHcBUmP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E3606A32C
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 379E3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d6jUNACE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AbHcBUmP
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b7Gb1907968
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=; b=d6jUNACEdMZOAneb
	efc/lmRa0ouqmtZPn6+Lmoacckw5QKLPorWHW4OB6TWz/6dvAfcL4m1WDtfznd0/
	ICcLtZNS6b6JuiLKehMPapqK0XJsrbbmgRHvTAIwtvwZtP2wE1s4xTZ9ajwUCjkN
	YFWqESrQ7CIZ3WoQURT/1XMXMTOx8cm2OdPGdBFYnrROzceKLxgy4PjYxvaR+PAq
	ap0JCgeSelkq9r9Kx/mX8M1U4XV0z8HOiA0SSt+mnjbiexaAT0DpabYJ+4KEPVda
	cBrcqlp4m1v3mtoL7YbfppntANJNpzQFWBN4xBUjoIJslJriDxA+zLbfod2FcQZ2
	gBpCBA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gn4qd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e601800e58so48552595ad.2
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995935; x=1793600735; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
        b=AbHcBUmPfels+ng9/uRYApaNvbcYi8l+tnqGVhIuSJDAXuPENguaWpCVV2nRuDaCpf
         5B4LRBUpo7qyuDRgIs/AOJCHQE+ofTeBWYv8X+Dy08wZ8tPK2Z2AX3Utw7TAGDGKIKA2
         +aRASsDjs2o7LL09YcyWVGgLp4g6x0nUgejbc8e7o1SJGHNXbClqQSLaNBc48QuSq9Yt
         kSCMJSdAgFi4UvhDWGvo/y4PbzvFjXC9wEvw431/G5yEVMEykhF1fMOfXWpim8IkonDq
         dAvT47D4nF2XVggjxr1xFGYfcfoOLxabnSgO5Pva8GEDgUeWuWvTc7QL4YuvSy3i/Fkd
         fnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995935; x=1793600735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+yqLfO39gj/H74c+0JuxaYjS95aZYaE8hMGc6dAOLI=;
        b=oFgwCX2l/vLyE0s/z7XtxfAJ51fcjZZVbzXgNFi3ZND5BS8PZtPm5W2K5fp7IxahFp
         5avepeuN+coprANx/8uMMXJwqP1B8buejQWJzb6S95+XL4zmlp1CIrSIxjGy110I0lnB
         yNODIeTTnm4gs33Hv8yszVcIK0m7JuX1M7rVvJEgX+RIbYgMT5+o/lPX7PrqHDCG/KiF
         3jlVpNFofgGViS4ABNyyRNUq4tS5DMAoyUGTrqJ2WDVSlaINE/sKs8lKiOC8X7oX9OKr
         +SPXS2mexF2du79RO+r2rbCs7RFuXmK/lWcof/uymfHC9SZ4KipXc/cE8BCFqIpbA2xr
         BtUA==
X-Forwarded-Encrypted: i=1; AKwUvBzdMH/veXnByYM4AfECBFolyVrkRpmEPfFtn6xXAbfxDP1XHoxfwsrLuAniQy3vV/qs6Igu8UpwSdHDJAfmzg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI/+w+2H3xDDEmymZ7aVbH7YtuDvRpLLUtVTKq1s6Xm3jPVJWgx
	/Jc6ulmZpWN698SmGAPKKy8DkYr2tCZuZtQe1t/cjB3PJXkHX8vzDNdL1pe0H6es5dnhbwgCCYH
	7KgIhVMSN8o5NlTkoKfACehqGF0719LHHykyc8P8E4WEzoyJdb9z3DqsQNe9E5nf/jIDm6A==
X-Gm-Gg: AYBFou0eWD3FXb078og2YkXFX9gGruSs0CvkPosIt5dlTEZmXv1D9H4clpC5qjjAnwI
	ocHYBRnTudpQzSg2v7QNLQW6XDxg/x0cVC8AwtR8XMdxJKd1lSeGTPJVHQfG+HiCRv81zy+q4T2
	pFe/InlI5Qb8GJOgihec8KAaC0c2YSgGmdbEGXPJ+ZHPTqP/2mI4kLorWqvbtxpsfdQHhTGrx6Z
	xbfemJVi/uQHSUuSwm0Cca3cQzn/TM8kBWQcBpusnSQJUf3u7nhmao8n7Uubg8S4CQcT7Clfrs0
	LkI05bbp3c3wTu31Hs+Np7ZTvtMLVh3qbtettlF4XOGZ/KPaAQP2IuSrq8+lJ/xL7QBJxPHujLY
	PKCu6wFnLNSg04Hqk/LHi98WN1+rjYqlzWg==
X-Received: by 2002:a17:903:1246:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2ea9c03e626mr53707845ad.1.1792995935107;
        Sun, 25 Oct 2026 23:25:35 -0700 (PDT)
X-Received: by 2002:a17:903:1246:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2ea9c03e626mr53707485ad.1.1792995934668;
        Sun, 25 Oct 2026 23:25:34 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:25:34 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:32 +0530
Subject: [PATCH v2 22/23] drm/msm: Register the DCP backend
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=1867;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=DnOVMMMul1WJd1CWK5XVZuD8++FkNWwJHoR8dINot9c=;
 b=QG83X9aBE4jBa1DAS4wPcmTipRI+XMBqCLy0NmwgeS2ERiIBadYlckpX6pOlVddmoKAl5KzcE
 g7G+3CHykn2CWWGLoyNuBrJN0+MFb1zULSaZ+b7RPKVSseb+q1g9A9G
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: HRan1jGx47AW4f1gBto-0FOpSn0JBKZG
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adef260 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lVH-uUz8Z5eEn0x1YxIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: HRan1jGx47AW4f1gBto-0FOpSn0JBKZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX7dvGOlR8DGtf
 gSO/WicQQoBYe847fa86MLt0WJnYU2v75UF+BOlKA5+yptX2KI4vkbm9MIMQ8k0xjRHBTJtutpg
 u4pPyPb+jPFu/QwFu9JDJiOJ6F68OPhaCYLPFRWgQKjAcoy+SwMfB0ZIcUBh5i8p7WHuUQNvB/M
 lIZuh0vJD/olbvLdotQIbbBx0dCcKLEbpncHgN1eMIgmXBrEh51/RFkqMhrGV6dbUlaLYrJ5Zso
 0Othu+HW/9amejq5iHfiOwt71XZb36EhAGZxdBlAHl3atus10Z9fXNxsBwm9VVtPw6Tmws9D7CD
 HoiBglDdB5iJls2d6RZNwHL/Se4mp6oNZ55iCYerp4nSzi8u50j/bYgiwC04acM7x7XI4huK6s0
 s9YL2BPB0sx6K6Ny98xb8Mb5tWtZrzXg/K70fT0cMEErJdquWLqhfEVcSjv3ndUInhlVmeHKjKZ
 Y4UKol/qIwlCVxCF7zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXwalKLmMG7Gwn
 cs2YrLR6jZZtE8rgoCr/E8PNM83cPuF3Oxugq/HiJ1oDdz0j9vAsRBckZB7nzRJI2MKOJymNMfu
 gRZjEr6WX37bm3jY+C/GDMOYgoAiTHU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

The DCP platform driver provides an MSM KMS backend. Register it from the
MSM DRM driver init and exit paths so the VirtIO driver can use the backend
when the DCP function is discovered.

Add DCP registration hooks with no-op stubs when CONFIG_DRM_MSM_DCP is
disabled. This keeps backend registration consistent with the other MSM
display backends while allowing DCP support to remain optional.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 ++
 drivers/gpu/drm/msm/msm_drv.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5816c64d7ce7..d413c361c442 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1208,6 +1208,7 @@ static int __init msm_drm_register(void)
 	DBG("init");
 	msm_mdp_register();
 	msm_dpu_register();
+	msm_dcp_register();
 	msm_dsi_register();
 	msm_hdmi_register();
 	msm_dp_register();
@@ -1229,6 +1230,7 @@ static void __exit msm_drm_unregister(void)
 	msm_dsi_unregister();
 	msm_mdp_unregister();
 	msm_dpu_unregister();
+	msm_dcp_unregister();
 }
 
 module_init(msm_drm_register);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index aa5dfd82ac6f..befaa9f2cb5c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -417,6 +417,14 @@ static inline void msm_dpu_register(void) {}
 static inline void msm_dpu_unregister(void) {}
 #endif
 
+#ifdef CONFIG_DRM_MSM_DCP
+void msm_dcp_register(void);
+void msm_dcp_unregister(void);
+#else
+static inline void msm_dcp_register(void) {}
+static inline void msm_dcp_unregister(void) {}
+#endif
+
 #ifdef CONFIG_DRM_MSM_MDSS
 void msm_mdss_register(void);
 void msm_mdss_unregister(void);

-- 
2.43.0

