Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995947;
	b=SF1jntWMXEjzeRA1+WPQfeG+ijMN56jjGdDuafmloqA2vGmzjvNS5CxJbmpRvAbGkHwE
	 9ZtexT0MkBT0+JL5LlimCWtEj5rwsKMC46wbnYo0RM6NDHFcfwWz91SsQwqhXec4s2/Qa
	 2a+G+ZIYdf4PrCGHkT6f1FryfdgStd8KUxhR5yAA/ZIorWA6+FbnEYxaVLBqYjyKz4w4o
	 ssgRhpnNZgoKhzXJSjklmZLCx8JlAbDYFdTxZmQSznYIHX1YqY9x2KpgzcJjaZ6ABd49Y
	 CU6uHbhB4vDlsbAbeW0ptVhbhU//QOC2PELB9HB9uoz4zCFB26JKgcIEfIkm7nROgYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=;
	b=oLoEfzlvqPfeb3cpMSwyjTQMcKt110uzAYdmJ+RfE8DhuQ8H4xk4DYP1muFzl8P4H7XB
	 N10r9nsZ0UD8dmo7wmBtRJ+l/9yEY31Ryps1U/HxBLe+rYN4iVr0h/khrxblCfjMOldxk
	 clug6emLGQ6dl+6JazdXtmHMJ3T1YEXz0etF+xL7PiJsnc5NIVh1adBkcQXRC7RLFci+H
	 a70GoVesxjPCnSZKni+qkso+U1d5b9CnQoWxWC1Q/i2/LbEQuIRtqO6jE0yCNxzY68gSC
	 WJVdPFhKdjDgCdDuL684j4q5NtCFuah5Mzek2HD1tSHvAubQJmEQdcOpQ/fjLL6rA+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AF2QO09t;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XA3SuI56;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272AB606A325
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 272AB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AF2QO09t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XA3SuI56
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aTKO1708665
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=; b=AF2QO09tuvUM3jqZ
	pSCUqmKrO4lnRGeBAuqNE4HoMghuuf9ANxMv2q8JOwcryBTLC9Rdf8xBqaJnQuD2
	GxzGJdBANbr4UO/monIXFFvfVL5AHC24jI1aFWk3VW46rDw58JNfR0rcj+EPlXRN
	eX+D/VAva651BTctxF+S3TAoiKqqevZaHryYBOLUUf2PMNqNVG2/MT9wGVifnsu5
	bAsE/AWM9z4BFjOP+UMzwbjTUK1qAIsVCcAkxym3FK2GwsDnT9h5QPpfgYR9vkK4
	YTl0r4uPspz5zb/WFIrbwBjxUNx2BBnbNRoQv9anEe7IewLpX16fg4kor6aj+mVp
	VEMIMg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsjd94gt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:25:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eabb908860so8327735ad.0
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792995946; x=1793600746; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=;
        b=XA3SuI56iUJsSgMizzk/5QaEakmEjFuncgNekPg/An3scDjeTmj73J7r5gWTl4M475
         F3ipomFmaTIkE2jKg0DkpNF7RFFodWTRhWNnp0Jo3uvvgnNJnSFHaP37x469GQN/5/P6
         CZ2KPsLp6n3s8ZSrq39JhYkr3jK2/cHq6HhGFsyVdVAAvgl47+NbO2gfR9Ffd93OLBLX
         dtz6WB/VB0XlnLlllWykZiK4EnzLAB/QCdl5uLCZv81XVe/ErtEXfxu98g+/Y56TT+8b
         e6VFgVKZrTzeoHGKiYSEfYhUHGEihX6L4ix1d/APhrQKdQ/Ww10RYGrb0cAcCgelfnMM
         7IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995946; x=1793600746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCnvFyOtoxqBwa/Gstd7a10Uc74nGWW4NE9dwrU5Y1I=;
        b=NQnUx5NIXF4BczgN4JyYQ2FF+hwkRXOzd9n1SglX5aTl0v5GXDIXS7gVGdhe2IwDL0
         YqEpGYpN2meKTcN15stakpEBHpSwj118VdXhNDuTm3iC8UgwB+E7yGQGKNOg+nXo4QN2
         1MRpxMw/wwMYxq+oJdaQqA4liPgThWpu2z6ObckxbHXX6cKew2KIr8CrepgyMpzt4H2T
         QRzKDTBywK8zhF8iBayQ4XruZSzus9cthHiAz/lJzT9GS1VF4aNtK5/l0J8KOLR5wdcq
         YF19y3kDh0r5ky+WhFfN9U2UE4RFX8zxQUeqOKIMn7J/RWP336H9pFrhnJsUhcisaQJk
         q6Fw==
X-Forwarded-Encrypted: i=1; AKwUvBwPY67WjH1GQD/AfAm89fhhAusYvqKMF1bt2PbZkj5hbJDaNvcpbFyp3CDFvamd0DAkkKyV3d/6ShHPNHFjwg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJozvlVsZLxMrChMjgG+WmPiTpz/UsVA8S8v96d5YQUPDK7PlUF
	K+DmcxAA5Ez7MpEqqGc4BzpmPjFqogQhQLkcZMyoEQ9iz/9vH9vvEqKko0acTCJh1aLRmjwWOs5
	OHcUXfS5HewnmqnWIyvrjNRk154SZ3HYK4lJ590AnkIAdJVjm2LsVJpTihu5LQJyy4efdEQ==
X-Gm-Gg: AYBFou2IeW+d9APjIMkVRik38r4qRZVk3JILVo0fZEZ+W4bDC3y55UcN4SxIlHKS0lj
	2jG8naNoYkY+8SjaDypFOfdJBf8lOt7kK0OiUZxQpExwYFts2TqTBv096GgTdwlX6HbXyhRsOIk
	8yMlK7nWh93Qn+d8tfqIbnLevO7vU9Ou4Dfj2LcndxG9DSqZxmziDkT//ydeI1Mm9ZnJz1w+Myw
	ZYaTzPuQ9kRpl2WIz4IykmDAdHALKfeYrFpJPr6KQ5I8hU29Uu5tx03lzxwjk84z/t3yZJ1f3On
	908QrgT7nRcDGpv0wWoWbY99tG0UNBazvRKspVEl44tguPvfu91vQsZHqkqOsJjF1vGUmULcriI
	Zg0cR+Og2bEGnEm6ktQmEWnlHBEyh6C3FVQ==
X-Received: by 2002:a17:902:cf12:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2ea9c63efcamr48839215ad.17.1792995945670;
        Sun, 25 Oct 2026 23:25:45 -0700 (PDT)
X-Received: by 2002:a17:902:cf12:b0:2e9:73db:3c78 with SMTP id d9443c01a7336-2ea9c63efcamr48838845ad.17.1792995945230;
        Sun, 25 Oct 2026 23:25:45 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:25:44 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:33 +0530
Subject: [PATCH v2 23/23] arm64: dts: qcom: hawi: Add DCP support
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
Message-Id: <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=5616;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=JWax6SHxXqnSdz0sR52ZG2fr/5xHogt+xoHHZShHbR4=;
 b=3phvyPAWLpPk42PFcsZstSJQNZG3MKuNnHg2gCbX6SuTSkcshSlrsuGkDS29WnsFK2MrUgree
 GAjJ2fJdmXzC8b2UQG8TZFR1oKZzbT3VTflheMwfWxfPdFCg0+kVtOU
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: k_iLDan131It3_dSu8TL7F_TwPaEvIT0
X-Proofpoint-GUID: k_iLDan131It3_dSu8TL7F_TwPaEvIT0
X-Authority-Analysis: v=2.4 cv=a4elZkSF c=1 sm=1 tr=0 ts=6adef26a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cp69EZODLtjo7xmYzNYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXwwkFsHV7lMyd
 0uykE5My79ghVWYmJqpxzdi/8WjVx2qGpa8QbRjPMBw137d9xadt7ceB4C17E1Z4jfV5ydj2W5F
 xCCcfMXs0ynsTHTn6O3MFkMwxWCYV0A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfXykOgNTptJ1FH
 u63AQiVSuhh+ImfvQLX1XjI7cQrc4oGzMqHiCW3YNQEJ2Na1OGfGMA+jLlzlqVmd9ZiZs2zGmmp
 Jbahb8hpORuc9Pz01A/l8z/KlASzjBBg45Myl+GJ5bb9Dz0NHbGa6aoiOcdn4QShJUNAQ3ouUb0
 THZfud7NK8+fkQJp8GPcSDmHiopvjQ/UNvBME3+L7e3oYgy7mkAv6IbbfxyyeJlByLWl00KibRe
 rifny63q0qUfG/f7fq/qRBV1Hsjk1zb46Rl+iL2mjfipGeQY3571czKGQFWN5UdN2iAeqFqId8q
 fsIWzvYFp6jXhcDcQH1w2tGrgeDRGPlyv/apTwnDLGI6Ut9KorQJGPA3DRm4V94a+81dwhlBzcd
 IrdkYAR9QowPjTW9olziBUHVXErg0Ejx0Hf3ZfOG3l8ahZno76Zg53jl6shTCQgT0Hpnu+ik7fG
 S/9raPPVMVogzznRQ0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260025

Hawi display hardware is owned by DCP firmware, so the platform device tree
must describe the Qualcomm transport wrapper, firmware display subsystem,
power-notify channel, IOMMU contexts, and display graph used by the MSM DRM
driver.

Describe the Qualcomm DCP transport and its VirtIO-MMIO child,
the IPCC power-notify channel, IOMMU assignments, firmware-visible IOVA
range, and DSI display endpoints on Hawi. Enable the DCP display device on
the Hawi MTP platform.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi-mtp.dts | 129 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/hawi.dtsi    |  40 +++++++++++
 2 files changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
index c38e5fab7a2c..a27003f69d02 100644
--- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
@@ -34,6 +34,18 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	display_panel_vdd: regulator-display-panel-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "display-panel-vdd";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		gpio = <&pmd8028_e1_gpios 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+		pinctrl-0 = <&sde_disp0_vdd_active>;
+		pinctrl-names = "default";
+	};
+
 	clocks {
 		bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
 			compatible = "fixed-factor-clock";
@@ -142,6 +154,7 @@ sdcard_vdd_3p0: sdcard-vdd-3p0 {
 
 		vin-supply = <&vreg_bob1>;
 	};
+
 };
 
 &apps_rsc {
@@ -995,3 +1008,119 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
+
+&dcp_dsi0 {
+	panel@0 {
+		compatible = "novatek,nt37801";
+		reg = <0>;
+
+		pinctrl-0 = <&sde_dsi_active &sde_te_active &sde_esync0_suspend
+			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
+			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
+		pinctrl-1 = <&sde_dsi_suspend &sde_te_suspend &sde_esync0_suspend
+			     &sde_mdp_vsync_p_1p2_active &sde_mdp_vsync_p_1p8_active
+			     &sde_disp0_rst_1p2_active &sde_disp0_rst_1p8_active>;
+		pinctrl-names = "default", "sleep";
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&display_panel_vdd>;
+
+		reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_dcp_in: endpoint {
+				remote-endpoint = <&dcp_intf0_out>;
+			};
+		};
+	};
+};
+
+&dcp_intf0_out {
+	remote-endpoint = <&panel_dcp_in>;
+};
+
+&pmd8028_e1_gpios {
+	sde_disp0_vdd_active: sde_disp0_vdd_active {
+		pins = "gpio2";
+		function = "normal";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <2>;
+		qcom,drive-strength = <2>;
+	};
+};
+
+&pmh0110_d_e0_gpios {
+	sde_mdp_vsync_p_1p2_active: sde-mdp-vsync-p-1p2-active-state {
+		pins = "gpio9";
+		function = "paired";
+		input-disable;
+		output-enable;
+		power-source = <2>; /* 1.2v */
+	};
+
+	sde_mdp_vsync_p_1p8_active: sde-mdp-vsync-p-1p8-active-state {
+		pins = "gpio10";
+		function = "paired";
+		input-enable;
+		output-disable;
+		power-source = <1>; /* 1.8v */
+	};
+};
+
+&pmh0110_f_e0_gpios {
+	sde_disp0_rst_1p2_active: sde-disp0-rst-1p2-active-state {
+		pins = "gpio9";
+		function = "paired";
+		input-enable;
+		output-disable;
+		power-source = <2>; /* 1.2v */
+	};
+
+	sde_disp0_rst_1p8_active: sde-disp0-rst-1p8-active-state {
+		pins = "gpio10";
+		function = "paired";
+		input-disable;
+		output-enable;
+		power-source = <1>; /* 1.8v */
+	};
+};
+
+&tlmm {
+	sde_te_active: sde-te-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_suspend: sde-te-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_esync0_suspend: sde-esync0-suspend-state {
+		pins = "gpio88";
+		function = "mdp_esync0";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio211";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend-state {
+		pins = "gpio211";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
index 6b0a0ff0faa4..836970cdef71 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -6841,4 +6841,44 @@ timer {
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	dcp: virtio@9be8000 {
+		compatible = "qcom,dcp-virtio";
+		reg = <0x0 0x09be8000 0x0 0x1000>;
+		interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
+		iommus = <&apps_smmu 0x15a3 0x0>;
+		iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
+		dma-coherent;
+		mboxes = <&ipcc 13 5>;
+		mbox-names = "dcp-power-tx";
+
+		dcp-subsystem {
+			compatible = "virtio,device34";
+
+			iommus = <&apps_smmu 0x400 0x2>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dcp_intf0_out: endpoint {
+
+					};
+				};
+
+			};
+
+			dcp_dsi0: dsi@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
 };

-- 
2.43.0

