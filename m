Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101494;
	b=ngsbdsG0m2fQAO0Ncye3wqfjWbZZTUJdSgH4A3oK5PvzIw9Wx/I3lPsb6ZW5q2wDmTPR
	 9EHUh7Ld+ED6iEEtLxvZmjEM2EA5o/dxixaCiu8v0wQq8x82e3sAO2M8aacvMZbksH+9u
	 lk2h7t7ud3hWVYdfraoeosU2gBND1RGZRQmCqCe6O4xSxqt4aYzKHkzHeSw8a/1z+cyJs
	 z3O4BYuVcuJRGA9P53iVH3HujJa5pD3/bzaCXWtg6Pavpym/8SC+SmI3/M1GWGy7iWEMt
	 SWEnpFWRUt2OVeCjCsflPxqhjlLIMOo2EeW436wqxNK6eqAgOP2EhrtFIimsRy9nS8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101494;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lE7AshOR9IvZTWb4KZq+JxDOO/khlLsKuqrhcF9jNKs=;
	b=tZQPqh0rzUb0we2tjfgu51dffaj/E6Te4/PzgyCaTAudi1w7pzqH1tJYYOeFSOvfdFiV
	 lMLwkKhLX6rAJ9+LO8AZX3eKCXa/pwu7av6lKKkQDXPNQZ59fihRls1+1o+hHOUNvFw9N
	 NC4F/bHJCqGNoLg9f67RDOUfhb3GvZERv30VUancdqBfBJApWEEZlP7k4RHCWVn+ayU5e
	 RpWh1sddDZwXVf+fzEbtSa+DxIxG2UctqHQSX5Zq+jikIQvFvVbGSwoZE+LpoMjdh4YKH
	 4v5xW8B2xJ0pexvc2uFmp6XuneH1eanfgevx9V1mEIppq2q7hp5RvS4ND8gfXczqDLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JECJ1hD7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jBz9KL70;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556F606A7CA
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3556F606A7CA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JECJ1hD7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jBz9KL70
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeTPN1428073
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lE7AshOR9IvZTWb4KZq+JxDO
	O/khlLsKuqrhcF9jNKs=; b=JECJ1hD7v8moO1XN6ecJsdDt6TuQlsG5Fw8AGyBv
	SRdm5mWhtl6JZijzfe7UdoOdJP+7kP9QjjLQMphlmGNiwqUQ29O/SHADAdC0drng
	nvZOlcFkb8PSwKF1bZtbJFygVxaXT1LYi+wh1uM6ONeX3IBCLss+MJJjE0FOQicb
	vbHBdeARg9khPu4JnTTJNa4VMO0Sk98DNk1+OjAxQvnoNtkEDqGmB+/23Jsl6KCM
	+BQaqRa0d3ZBR5UC3Xf30cV7FWGyOuQUeH1HPeJNxoL6aRlfKXiWLPblY+VWw3Me
	U29bdBvrEZhKiW8OK/Wn32P0WXPaJdCkrGbH3N2nLrPE+w==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbd2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:44:51 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c15deb3794so847998137.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793101491; x=1793706291; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lE7AshOR9IvZTWb4KZq+JxDOO/khlLsKuqrhcF9jNKs=;
        b=jBz9KL7097VUdVYGuHPvhndrHa98m/mx5fb4srcDdlrQFheMIY/CClY31y/HvHRHMJ
         ZVks0rRqXNPwr8P6y/yMWAz5xDnZijcAwV/dJ2aHp9/tq4dbQXoXFp0JwbwwBCFSmHlu
         SGLRD4KZqorBvyyfJLBxX86wCRPW3UDpn6ct8/RXBwNlqhsIO/w6nT7MewacbIoSX+SA
         sKGrdxk/Y50u315v+3h0YRANGNxcovzNjsnIi3ukBfFMFLXZnHBnw7KYgopsOPScqrUw
         yR01b03B1IxKjoGpC4URPGz/m6lSAwqOryVCL3DAW1oEVRMMc22pgR24HJ7SKKRHToQD
         1F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101491; x=1793706291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lE7AshOR9IvZTWb4KZq+JxDOO/khlLsKuqrhcF9jNKs=;
        b=r8ixXetSaeYz8CXTxpl/spMkPIVJfCWIdMI3gnk4ClGUnZC/paojtNiiumnqmi1gi0
         I9mGKd9RaGKsPWSXvIRDlnfFoILYrmyl1uzZRczRLhVrnkOMlNthoeEl9V6NvLKhebU0
         ayUMduL3Xsy+IViyoMp0XCXRxM+eOlUzVsO/eb1ukOvsmwtNjmhbEpeTA1/TlodejjVS
         bo40B5Rd7/1flFeomV9pN/nGUwIWJ6zX0A18doNGKud7W7Zcldk5Fcqg9Eawy2fV6cFp
         /RX9YiC9lCkr7QucUR0K1HFTtRWZfFBBGEX/cKWwM+bRmOUcHX1Y8Bm68HyQjAYH5jNE
         adPw==
X-Forwarded-Encrypted: i=1; AKwUvByTsa5gp39eN/OqY8l1B6VIAzG70LfvBAI42IsL7qoVArqkPWMIfpiCHR3jt+DyrFbTOlK3rmaMmrKMdEP8VA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJGsCMxFpRhFU1cwcrc/2L23rhxvTYY4BqpWrj8Df8sVrlYy+JN
	vMAm+1pnb/demSH9ZpoiLbK8CKfeB9KSuzLMXEHFUq/lWz0crlzlxcytkMOU9mu0kwWctBFSye8
	tGRzKPsgVp00lUMVE3GrW3qwlE63VwZ3ZI49Fgm/2T4gYyB3QYz5Elpcu176r0vvgkm3JDw==
X-Gm-Gg: AYBFou2A4vLUeMix8UV/3OZQ6+DOEtW7mhJUOs13plVZo9ibmcKkSmolcL7kdepYks2
	41FVwFNO1dpVaCpUyBp2msC2rOnkUJy4+jdmfRppUZnSpn78yJrefNEl+WzFW0/i9f+Eg5Kh5dl
	MKVR0jYfJdUFdhmEsg14VqZwNlclPRnYhVhEUlxbuhQ/2UXcIViIRNk/NXbumPjqdRsKUVqubPf
	H0nZOt3kDGTg3XGcanGzuBYisBRuN+vtP2fWL9UnTnrcKcjG/tJeVzukN+YYw28LVB4rwHQNlw0
	nSnOj/F2hH+Vx83BkSXvJuZNoTVrU6iEG7UjZ4Jm8sLOk7fIsoXp2cPpbPZaiw73eIleR3LW0RD
	h3yOfwFw4jYWybC4QcjHr0FUGCN8flwOhxYBXlnCuNU2BoYrlwqC2FpstJvavJajAcKtNoRs+nI
	c81MtafHSNrqU+
X-Received: by 2002:a05:6102:5048:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7ce5ce4227dmr2779175137.34.1793101490729;
        Tue, 27 Oct 2026 04:44:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5048:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7ce5ce4227dmr2779134137.34.1793101490117;
        Tue, 27 Oct 2026 04:44:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a8945esm2027201e87.53.2026.10.27.04.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:44:48 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:44:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 23/23] arm64: dts: qcom: hawi: Add DCP support
Message-ID: <zg235e6lnlml52ya5fj4f4ulmamnqrlvtfs4yj7i4z4ezrr5uv@zaybpfrp5hjn>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-23-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXw9Ej0cXCiCMn
 qZorYwWLlsbSl9GAaOm3cKDZsN4HOfVLQUorcjReJjQQBPDqPa4HG1BUfsnQHXg1rI7QbKaEaDv
 LmGwWhbf3hmA5UuxxSM62p0M5zL2J5g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX7fF82K+61JFX
 qGFDfojaSm9qusC2wgQEFkAlXaJZA8IpOK80xMaDiksq7XVG9X3TcrgA+1FfZvgeaQn/D8XaGnR
 n9MKQ9zijf6u2gJYViFyrBhYhygoTp2oOoSGAAgH7wqnYvGe1pRU+IvdYNuYyKimjMDSKsyXzg2
 Zmu6QVv57X7W9RO8sYuvvnjtUPQ+Y81ua66eiJh6ZsyCmiKnq9CEWi5ua8dsK6+8t//70r8eejZ
 rxuKId+KfGCeWzXP2og+Y/gnNOI38fW3nDMzAPo5NrVwhNj0K/1sYXxZ4fDApp1CdF4PS2GaYCy
 FeqOmOW3l4DQqFiUBoMdBXvM+bNrJK8uyp5JfYFIRM39cYc1TWNmrB/h34OUoAds4uhKiZdcZso
 QYfcc5d0kmMty6ys6wSDx4FLNNy1QX47PAuC1sx0xfL4F1o6st29YMNlCn2rZ/IX0DdL9X1KxIy
 CyDiTJm8PZXvkP110iw==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae08eb3 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Imd885ZT4_v8IS7qKhkA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: nOlhnEFB72WpXAG5f-cg6CdIVQfK0neH
X-Proofpoint-GUID: nOlhnEFB72WpXAG5f-cg6CdIVQfK0neH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270046

On Mon, Oct 26, 2026 at 11:51:33AM +0530, Jayant Shekhar wrote:
> Hawi display hardware is owned by DCP firmware, so the platform device tree
> must describe the Qualcomm transport wrapper, firmware display subsystem,
> power-notify channel, IOMMU contexts, and display graph used by the MSM DRM
> driver.
> 
> Describe the Qualcomm DCP transport and its VirtIO-MMIO child,
> the IPCC power-notify channel, IOMMU assignments, firmware-visible IOVA
> range, and DSI display endpoints on Hawi. Enable the DCP display device on
> the Hawi MTP platform.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hawi-mtp.dts | 129 ++++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/hawi.dtsi    |  40 +++++++++++
>  2 files changed, 169 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
> index c38e5fab7a2c..a27003f69d02 100644
> --- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
> @@ -34,6 +34,18 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	display_panel_vdd: regulator-display-panel-vdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "display-panel-vdd";

Is it the actual name in the schematics?

> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		gpio = <&pmd8028_e1_gpios 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		pinctrl-0 = <&sde_disp0_vdd_active>;
> +		pinctrl-names = "default";
> +	};
> +
>  	clocks {
>  		bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
>  			compatible = "fixed-factor-clock";
> @@ -142,6 +154,7 @@ sdcard_vdd_3p0: sdcard-vdd-3p0 {
>  
>  		vin-supply = <&vreg_bob1>;
>  	};
> +

Unrelated

>  };
>  
>  &apps_rsc {

[..]

> +&tlmm {
> +	sde_te_active: sde-te-active-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_te_suspend: sde-te-suspend-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};

What's the difference from the previous entry?

> +
> +	sde_esync0_suspend: sde-esync0-suspend-state {
> +		pins = "gpio88";
> +		function = "mdp_esync0";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_dsi_active: sde-dsi-active-state {
> +		pins = "gpio211";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	sde_dsi_suspend: sde-dsi-suspend-state {
> +		pins = "gpio211";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};

What is it used for? I don't see GPIO 211 to be used. GPIO 210 is used
for panel reset.

> +};
> diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
> index 6b0a0ff0faa4..836970cdef71 100644
> --- a/arch/arm64/boot/dts/qcom/hawi.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
> @@ -6841,4 +6841,44 @@ timer {
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>  	};
> +
> +	dcp: virtio@9be8000 {
> +		compatible = "qcom,dcp-virtio";
> +		reg = <0x0 0x09be8000 0x0 0x1000>;
> +		interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;

Align properly

> +		iommus = <&apps_smmu 0x15a3 0x0>;
> +		iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
> +		dma-coherent;
> +		mboxes = <&ipcc 13 5>;
> +		mbox-names = "dcp-power-tx";
> +
> +		dcp-subsystem {
> +			compatible = "virtio,device34";
> +
> +			iommus = <&apps_smmu 0x400 0x2>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					dcp_intf0_out: endpoint {
> +

No need for an empty line.

> +					};
> +				};
> +
> +			};
> +
> +			dcp_dsi0: dsi@0 {
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
>  };
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
