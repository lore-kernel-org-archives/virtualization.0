Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101029;
	b=wOYKYU3N6egIcwRIjaDfhOcK+/yJvdYkza2dQfkypqj+KG5bsdpTd52JWJXhr58lQfCV
	 /9tzvodVdUnqC/lH5CAA7VyLH8TTdxXRTnCZgbw+42DMqnibgzNwi2h/RUq/RoQ4ENyiq
	 fC7XHvXtJKIyx3yAyon+3W2ayXtBGh69J7cfSEdNancWljhvZ+kmdMZLWbexMacP+dN+p
	 aZXjeYsndGP+vq1vx/oyA8kq5/AUSGuhf5KdClDrx29Xd+OyMVmrQaT9f3HCF6zw2kpV1
	 JwysRBXVhKQmDMtkKm9AWPku4FAqrETLXQa8jg22IaYJhsIF1gS2aAbZfJgr4T6D6vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101029;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
	b=3pRez5Vr9ZZ83Q34VPKnQXItXfUg7hxTIhDd7Ei56Bif2PKECY9fmroBx9hbOf6He4fB
	 Q2zMWP68kZRhHTY4mBMjEhXjOll291nUwptvVG/Gwdov8mpArx+GBq6jL5LkXxDMWHZP6
	 AZzk7l7EgcWJVi9R6jgbnd815hCgGNpybxMp/O1+QjdQKF33z+8AeOHo9+6l9+KQ9SbYJ
	 59d1FkpxAOIjV61so1+Ysv0n1Otg4X3snWckqw9lW1BJ+WScQa/O/w7E7wkW3qYSxK2Hr
	 kHivxKgIoL4j5i5kButxEbC6ua8FdkVvaOcvvznaNMtyHTEGO/lWPwsk3qTbgIwUdbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="BYkqWIL/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwYAIa58;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1F606A31F
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E1F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BYkqWIL/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwYAIa58
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdskK1973260
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d9Gksr16Ym7a6rQh3BsSgLKt
	bW1PN6uAQD1PHStu3Cg=; b=BYkqWIL/vT76gUwo2BPV8+qHrr6gTQHtEF/qsZzV
	t9k7/HNQeqhwS+OHKqnDsMIWulbLG2pqkKIwvCy+qUpRSxC99/XxZBrYFP4cxZ7l
	/Q5YOmpG3L271QH2G5vKyPoPM1U+Mq8rSMuRfxu5hdQR1Oyw80YcKP/fbSWdHayk
	T1s4ECD6OiTjnRcPlz4xyWeEWk5/6k+IM1aG5CEfYWk//wv8JxvDfs9IpI340eXV
	4UYya+dCPcGYNtZp5Y0LWnfYkoc75+7VeOWSCho+8Jf88hndccM3tEwzSWSew6Ic
	bV2hVKl418/lToGDeg8NuPuK+BK//WEAdS2VFXbsnHzZsw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1gbfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 11:37:08 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c02e1df088so890763137.3
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793101027; x=1793705827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
        b=YwYAIa58bf9rj8YOE5fSBzcJ9G8STim2199vHLTWNRkM+jp9LyX5P9BLnOs1gbt9sc
         ZC8ZaZ0DIi9aCPjrC2I/7O+APnfrmx+G4oHC7R3qo/8nTCtidaynhX9wHazzOl5emwsz
         i31LyBx9tWyA9+2PQ1cDBh2Jr2JBmhqpQoTDH7uu7W/3EUWu2cSJ7Swym6lqLH4GCDwq
         ZFsK3iZFUrmD+ZVfDubjwgxg1dD9/PIlJVtSp4+LnWBrtzS+F9C1VFMlRvM6gCBBMrLU
         MoRqtZCysThq2jQghpvvK8iqGXjRG4P25j7OQwYcq/kQLiX4KxGssBBpn3nOv4XprCzO
         ZWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101027; x=1793705827;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
        b=xtS1yOIdJ8ydOpATDwgbVNwA/LIz5d85qDmdJMM8f+z5JflkAhrt8QQly965vgrIxo
         mhQMzbiVEmuKmGrhPdG8V8tJfSQXVATdY7yTbq+NnJEmNNfaQtjy2/hk2Pjn8tRosXFN
         1klmRQE/5fp3bwZOIPvPFsMRCro9ys9/rBQcXxqfuYJGOrJyFZpxYvm2GCvkngWLhCVH
         bMjGD2T5tFkP96zdbPvrTJofV5M/II5r+SH2FMnphQ2F6ywaoJk7NeDc1p3bicvyHDjd
         MdBgcIFJfKDzfBK+Fi/W0z2ebnvQRXf98QuiFyMptYB2p0637KeCCyJEKgejG/UmN3P8
         MOqg==
X-Forwarded-Encrypted: i=1; AKwUvBwMRICpFkHKVwJuD51bJkTEJv3t/Y+nzo7tAiiCubAZ+BibZk9vTTkPGleZkWoQiU0NXf5KbrbSx2MTooBrlw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI3bup9TKeqRsdwg/lub/4WNoRXJyBP6IiJyk6d4dB6fF5bLziX
	F592hmkEtM+/D9cc/Klfz0m6vxx9tA6sSsGbPiFdAtln7LBZMkrXCLezWAGsAfUkFVfIh8+SHlQ
	s3WMCmgJnnM+MAAQ1ZWkUS/0/7675aeIkT1pyohAvrCIzAI7xBmTO5Hz6WpdeLOhzIsHYhQ==
X-Gm-Gg: AYBFou1ivjkcvqv2dfDQN32Rkm/dE54447ikyFjnaYyLLKlXTYUlF0pQ6rZNk5vN1RJ
	hKoV3aDpRNFgbs6yHfJPN5M8L7/dunrBZbqa/y18GaUBEWqORdmKHzY1c+gbMireDuLs/jZnbSt
	+CeHkP5c5lYlFDpzIYcz/dj9DFtUFzGxgRKAbvAaef1z2NEua0VtXHltYXHvGthvP0ZEjdo6LO5
	ZWN/SjUnzYGerlXJer1DBrQ2kcdT/IYdA4fkB+UqOBie3HsK/MmrilNfdWvghflQ7ZUB03kUQQJ
	uKWjGlR56efE9iJiBj9XKcDYemEcRxV4Cc16Eep0UBxbj6rhJ6wyrcPFWJJa1enIjUUJk33U5c/
	5MJqnHmY8luqnUGoUQhZW1Lus4wmvxK8XUavrF/irnwKBxWNabExmzek5GdqKcnGn+6vs8y3EUH
	wLNnHGZSbQ6Vij
X-Received: by 2002:a05:6102:644a:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7ce5ccaae68mr2852897137.7.1793101026907;
        Tue, 27 Oct 2026 04:37:06 -0700 (PDT)
X-Received: by 2002:a05:6102:644a:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7ce5ccaae68mr2852880137.7.1793101026222;
        Tue, 27 Oct 2026 04:37:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a8930dsm2093206e87.46.2026.10.27.04.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:37:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:37:03 +0200
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
Subject: Re: [PATCH v2 21/23] drm/msm: Support KMS backends without a display
 IRQ
Message-ID: <jmsh74ugfivd6ffwiqvofwnkkxnu5z67hqdei7jarhrftvkgac@hq2e5s2aj7fr>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
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
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae08ce4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=auR94sGctrba0TjZuGkA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: --sSsJAvJu3qztuE9kKEsA7f4kNjx8gb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXxPPC/Ux93Q9T
 psk8rnOf30uMdHV0iCImnV3soKJYwBFxXTJgETuv2kBQVo/IzJmODJDqPCiqY6ZkQd7gXFAyBD+
 YIxBod7BIEVT23BPx6/WY5/CfS39ve8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX+3zeWSB/IuvB
 2Y/EPKV4ZQiXqMT6ssLqAyTjJr1W4HSYgrWMPo20tnA86jSTV/IQJfZyH00ZL6CWUMSox0PamL5
 lE4l2o1gnslvGc7SMOjLBsPwfZyMMRR/zbE4NopSRoOqWArh+1nvlLp41V8BQeiV9FzVaCJuBvc
 QagC6Ounf7SPA4v9kEj/4h41fw7BMk9eAhM/KUzzUnsB6GDH0yVRpQwRKbFQv8SnM8B2Wd/CKs5
 n2MAe7JM6pxP3F6k5GM/9VsWWfZte383hCluThRx4TyvTNHWjtwzjG+6UoPZW1VXhhb+Vt8qZ7t
 AtjCTbVBkB/Ru24tBjowYgIO8rg/cmvNe7WMyZwD9+Jp7THjvE0XyRtZY9u1oG1xix6jrSsCIvf
 vVEwB28vm+cPkli3T4VeVTKjKc4o1ZOCUXDRmL4eYHFwHPZFbJhwNsZeTdUz0VkVPjJfOkoQ56W
 bdZzkYEj3UFMuvB0N8g==
X-Proofpoint-GUID: --sSsJAvJu3qztuE9kKEsA7f4kNjx8gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270046

On Mon, Oct 26, 2026 at 11:51:31AM +0530, Jayant Shekhar wrote:
> Some MSM KMS backends receive display events through firmware or

Which ones?

> another transport and therefore have no host-visible display interrupt.
> Rejecting such a backend during common KMS initialization prevents
> it from using the MSM DRM framework.
> 
> Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
> frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
> interrupt is reserved for power-notify acknowledgments. Existing
> IRQ-backed KMS implementations retain their current request and
> teardown flow.

With the commit message fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
