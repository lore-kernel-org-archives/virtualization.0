Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101126;
	b=Wt28mojb+hSREH5yIO3NtDX9kVqeZPUwz9i3oSlHvNYu2RbJ+SHJQow0cxwKnLm2g6tL
	 TXtGiXOh+iTfEO7jGGyzbkDcuBOo6GxBM1Ri9PUDnm78d65LaSVU0W1Nf+rFlIMcD34Es
	 UOZzA4TFgEqTsT1aTe/Ef3antJudP6CGoEtR35YV1N6FazDbeGy6Of3ow9OszPJ8X9o8b
	 UY/j8mTRX17LmBQsUNnJ+NNdXspAGHqLmVYv+I6foeeLc6wns12U7p/ngsJ4CbqRZcAhT
	 x7K9818YrN594mLPt0FQP+PH1VWdZmmDsRdQjF6Badosk8pO5vxYU5DEZPUCsOGobyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t8KeJqXYQPr8zutUgjnJ6yEQLnjHNNZkSiiSYzj+XfU=;
	b=HUnl38yvoFS41irmOwzW42SmNRv9WZtD0Hc9ik0nkNngRCIIDTsKjbparJHclnCQ7/5V
	 9yqo8GsNdyRegDyVLLZnfmmtc5UE7gfmj2HJ8pRQrXA4GQoGti07q7RIobogckVJ74OiZ
	 pOevDn2vogQwJw0HozL0c5eq9qY2sM5Iy/rQua5hvmCMw49quNwpoJqIvKGXJLt3Q64XR
	 mlRuFCQcqYm/B1n4dFQqUSA2WZgXgQTMv2wm5V7Bl9QfvCk7bzc+zr+foRiAhU0rbD6eL
	 7CSBeUMKu2Suuc2TW+qmDynGJqxx2XgxhUeSVaBZ4Z403Vm6RaUdyfvaGe2JSbAH70Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="d8A1SGU/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DV92vPbo;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C98606B5F2
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C98606B5F2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d8A1SGU/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DV92vPbo
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeGix3026463
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t8KeJqXYQPr8zutUgjnJ6yEQ
	LnjHNNZkSiiSYzj+XfU=; b=d8A1SGU/3lNieXhNKzh78QX8sIvtyhoggCDvkjo2
	ZooNqFjFtRxIPsA+xBHGhEwUfOys1kTG07Iff1x+bBTZFVWToPjzxT9N8EnOkrNx
	IEGxQb2KI8RaKfi6IZ19cdymyNOTdoCHQeQYQLCMNTK9oZwDvYY148nlQMyElYrH
	nDvOEUPoI5cM1gKNxhj7N7mZKOPMRLIrN6j0HBwaYQi86++6BI0mVQNoQLmdXzQ9
	wKMW0uM4oJNn608zdT4wH+3YUkoQIer3xZf8YVZLZru2N3Hx6hdqAnijFoHnd9sT
	w6PcNVLoGn9P/kyfRan8jZasQplHO5ZXeiRXOVeR9WFG9Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91a8n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:38:45 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c0f07b4e81so720798137.2
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 04:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793101125; x=1793705925; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t8KeJqXYQPr8zutUgjnJ6yEQLnjHNNZkSiiSYzj+XfU=;
        b=DV92vPboMoJpSIRoabYbsrZObDNjQzATjcjf3axXnl9nYRXEgxB+VbEX5U6kE4rSqx
         kqTTSNXISoUSc22IM4HHc7G+AImlGOdtzg233/PfkC+EnPKqiYHzu0+8j0kecdOsR50A
         D4qz86GKLFEyadzZyQ4KnADEO6dgnw18QyECVGFm40PsVXQN8ZGGsQRsYQU4wZvYG0vw
         xWBbrZj4MX1BtCwDKODw8ANLWucdWY4Xn/0qOiAEPijmdWwyHwTV3PIdGg5v+ZZoDFDE
         cfY1vYIPYQz5hsOP+JU6eXnx7Ul1ZUL58VzGKKa4FpCjhD9THL3Oaz0nYip/dSwFuXz0
         S1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101125; x=1793705925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8KeJqXYQPr8zutUgjnJ6yEQLnjHNNZkSiiSYzj+XfU=;
        b=ltSs3Erz8LqQ0qEh9O7qlo3CGFnCF2bZMTOseJWm+6FbcE/L4LE35tkDWkVNYkwoih
         0U4TRNzKTkfkk0Aq5Ur9Qx10SVoqLRdtOdbnfHXW9jbChsGiI+4n8bU+gM68Cs7QhlO/
         DvleIbjxoPo+z6fajiUWPEuhUq3r9EkkGvDzDXHCuzlDn4KWQ55pslobuWs1MfylFjJ5
         EtJGwfdvS8U6iFBdxbR+Izt2Tjd2bwCgYyClGCoep14CSutECP5hP6vY71Dn5oGth6b3
         Rz8GLbDwnOhwSoC72joX/dBhcOBeAx7fTJrYvrqzJE3+eZIkr7P7kg1dXPudun85XfG5
         iCPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNHjlHLQoAhG4STWXHgV/PGfLSoTFGM5GT9dA4pi9tIcHRPXMJeY0dmom0+zfqolRerG9f6iTGTk0KpFWXzg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLCeJZgfSVdslPJwFRrw+LgWmz9X50geJeh9jypdCLtMnqM+jw0
	9QPOfbnW1VggPDfrKyEmPhhG+0EEbHIuu3jIPbjQobLkESUFM8IFXjfdyWPZoIvoe5HzpwXBqfn
	e0hrroCtNs0CPRdkegW/TjvhasIx+0r1CfdC52ZWtCN8c80ni4J8h/KQlc7j+m2fDlgQoaQ==
X-Gm-Gg: AYBFou1LbFHhE2A4w+V9/kvn7bQxm3hUVZhL88naoLFBSOCiKJ+LtnoFpyicoLfCWKI
	G7Hw7fAwfFoZS7N4lJbBe6zomQ0FWyFr53MHQg6jsZcqtUVKETQnNvrDnoa3sroAcf4eIy05FAL
	ArCmApBnfogE4VXYMMzxdKrcP34dtAAKDC9zeno7zd1BxNgi27DgHezU6AR+uYmnreMp+Mlswjm
	8jWrvm1tm/39kon5YbX4DsTKSNjNZpZ5UpM68d7o9dZu1BGmgao1/GxhhPou4uVSveTaGMRdoyC
	grrMlvvsyHiWPueTUAnnVZMEq9Gnc4ceBdiL1RZx+ZQVGCB4aHYYEbcXUlBRM+BhvbYT23sBrem
	WIuBTWAFdg4l0fmjP1OI8w/bhWFET8VYjBLlIoYzQAHDEfkEBygJlHOdHIpilT91LPldvQtWdky
	buafiWP2lxB/t7
X-Received: by 2002:a05:6102:ca:b0:7ce:6474:7216 with SMTP id ada2fe7eead31-7ce647480demr2158217137.36.1793101124458;
        Tue, 27 Oct 2026 04:38:44 -0700 (PDT)
X-Received: by 2002:a05:6102:ca:b0:7ce:6474:7216 with SMTP id ada2fe7eead31-7ce647480demr2158168137.36.1793101123899;
        Tue, 27 Oct 2026 04:38:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70a27a03sm24389741fa.29.2026.10.27.04.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:38:41 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:38:40 +0200
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
Subject: Re: [PATCH v2 22/23] drm/msm: Register the DCP backend
Message-ID: <m7zuu3txmzw4xemqrdtemccmvc4g6l3fsqk6xyxz5zzdbltptd@oqubuxwbukeg>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
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
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: TDVsJHTtJbmfLB0XgxzWL0pM-oweM9li
X-Proofpoint-GUID: TDVsJHTtJbmfLB0XgxzWL0pM-oweM9li
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae08d45 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=5ffiRAJw0Nfj9fulafYA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXwnzr1r68a5zh
 9pjxQ1UFxcEBCQK4mTbJd5p2KV5SKnjqfI/R+j44fRUK2xEcDwBWe4/mi2OKzmCUMZCHuMOR+BM
 aVKcMu+j6moMFcwVb7x3aShO0enLS4gd/qBVgqzLbA0f13mOXdrNS7FrAUZfOC05xVyP1uWMjrS
 gTfq/kmloOpBlczI5o/nzy9waYKTOXrmoIIeCQj/30gANCJqD5iPkZcQzBDwt5D/9fvsZf+ek0s
 iDq+gP7RXqm7S47B7vlTCPp479zvF/GYHBNCoPVttV9J8HZyODFHFUJV3jLyWNNaRQmN8fQr323
 LMAZxyG7ntcudomyZfvmLQXuMJCAr/yT8q4nrCuZlIrubH9zmQNODoygZBG91cfKJwa0LMHn4iq
 XPBIvTYD8nfATFJJLMAqU1o6KSnrkfmd4lalcJWFNzwBaSXfSu6aVQHoZ+T1lh2Mg2swOSIOY5o
 08h1xEXpGf51lMrmbyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX/5XbDnnd4KCd
 gFXeerS1fGgfTUjhVz+Cjwa5xyLchI+TEuKfnJFVqXU7HDJ4RWLdlpydUclefE9sRShY7LuONI3
 pvZobgxnq7zmulN6YZxbQHHOQQRKyhM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270046

On Mon, Oct 26, 2026 at 11:51:32AM +0530, Jayant Shekhar wrote:
> The DCP platform driver provides an MSM KMS backend. Register it from the
> MSM DRM driver init and exit paths so the VirtIO driver can use the backend
> when the DCP function is discovered.
> 
> Add DCP registration hooks with no-op stubs when CONFIG_DRM_MSM_DCP is
> disabled. This keeps backend registration consistent with the other MSM
> display backends while allowing DCP support to remain optional.

There is no need to describe patch contents. Please update the prompts
you pass to your AI.

> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 2 ++
>  drivers/gpu/drm/msm/msm_drv.h | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 5816c64d7ce7..d413c361c442 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1208,6 +1208,7 @@ static int __init msm_drm_register(void)
>  	DBG("init");
>  	msm_mdp_register();
>  	msm_dpu_register();
> +	msm_dcp_register();
>  	msm_dsi_register();
>  	msm_hdmi_register();
>  	msm_dp_register();
> @@ -1229,6 +1230,7 @@ static void __exit msm_drm_unregister(void)
>  	msm_dsi_unregister();
>  	msm_mdp_unregister();
>  	msm_dpu_unregister();
> +	msm_dcp_unregister();
>  }
>  
>  module_init(msm_drm_register);
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index aa5dfd82ac6f..befaa9f2cb5c 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -417,6 +417,14 @@ static inline void msm_dpu_register(void) {}
>  static inline void msm_dpu_unregister(void) {}
>  #endif
>  
> +#ifdef CONFIG_DRM_MSM_DCP
> +void msm_dcp_register(void);
> +void msm_dcp_unregister(void);

This means that the earlier patches generate "function without
prototype" warnings. Please fix that. The prototypes must come together
with the function definition.

> +#else
> +static inline void msm_dcp_register(void) {}
> +static inline void msm_dcp_unregister(void) {}
> +#endif
> +
>  #ifdef CONFIG_DRM_MSM_MDSS
>  void msm_mdss_register(void);
>  void msm_mdss_unregister(void);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
