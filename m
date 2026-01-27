Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43330BB82
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512854; cv=none; b=HZWCI4TI+enO/TFqCy4pFZ4xc0ascjZe9BWk8SKNZxbkBhQxKUwcN/WcWYrJo1TKHiGljIEEFNhL/O6QzLa5QGlav/eiN9UmYE2gtHIKFIwjVtug1jkFtSGS+La2tF1ZU21uGDHaDRL7O5tek0BA1Ab9DUlAIdo2DokzCcItNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512854; c=relaxed/simple;
	bh=oeBWwUuV0jeiE3ipYjKd79LqD3RSO0Ms3tWW/Keqnfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSU0EKFUNGt+kXd1eB9CvMSpWfte3aGlDwJLNR72lREyy1a3BO7Sya/DWgUnhZJui7gd8nCPOxaLhJqOxueUdXpimq2o0JRU/kxKrFdD+h1ASWszQE68rRiFWkix/rVYcQVDQt1NFx4h7QCE8TF5ho8Zf4kZ9ikBObZj21XTfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZOmoAHbz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=edhzasEY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZOmoAHbz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="edhzasEY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R7RuhI112562
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 11:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QHcqP74r9VhaV5/cZgET4JduR2x2H6zcTZIlVplq3nc=; b=ZOmoAHbzG7TQYghP
	Q/+fbofrkL7z1l7f55oU9lCHS5tFUbwHxZdoNe8x2Autw64GNBVGPZfGheI2QSXv
	FLteKO5fStxqgUtuFGTqtUmc3bhwpXiwUTAZq+eiWL9XCEl7E9oBmFcwcII/R3A1
	XIXCwti6ZrVikX3lgE3m+BnoMabUKfRhd6rX6vphMzGx4wHMLshJAZJClrQDYRtc
	V9wdwul5Zz53ucOdClomE9fcqt3xWzzcwLuJR/aoXdZY0kjqRw8azEK/efE5heiY
	9HP7tGuOK4teYFXiS9Y1Hx43Up5X4TKZSsUszoo+KyiOSAcSekrY+FTAMewIDm0c
	ocgIsg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxs0e0umf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 11:20:52 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5f52b01cdc7so6046727137.0
        for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769512852; x=1770117652; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHcqP74r9VhaV5/cZgET4JduR2x2H6zcTZIlVplq3nc=;
        b=edhzasEYDjVLvwmH4NCSyMLBDqSu00HSL2YYYRDnMuH6WgNpIKefTojML9w+goKhzg
         O2Myg3F6XnyNvgjTziQ3Uq89WOH9jX/tR/6/WN3/gdNZR7SvHeOTdx74++zENLPwegyk
         /Frk6HDeHOW9JEnqInsW2qfbm77Le9aoU/ogVmbPM4u6ObObL4rwqt4FJyW9YsZR8qNf
         wtuYAH0b7H1Nb1HOj12YUc8qVFrX4wQKVvuta9GpUdOQCQ5/f0iDh2gmgYfp61trR5AV
         reYDWYGiwikh9gxxWy04mRlTX2dQRZyzAK6d/NOyEsZuRdyME2eNFOkWrJgG4aq2ErMT
         LPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769512852; x=1770117652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHcqP74r9VhaV5/cZgET4JduR2x2H6zcTZIlVplq3nc=;
        b=AlXe9jpRD3Y8WiayHhYzy1GT6Y1ZcYQyl1yMgZv4K5ghf+Yy8NaSk3YXsD3MO81yaJ
         kCerepum7fCzF2qpeCnYEKeWY7CjLowF58hvSoyD/Gn2LXi7BE014T8whx1wMBIraRpM
         n5gWKrOY2tsPwK5rkApZ4hpJD96DN5d2ExRde0a1jBV31EacFae28beucmS3rQ3XmKDG
         0O3DidJ0uT1EjibtPbC2Qmefh13F7BYhU0mL3udEJifdDbj1EKNRzZOuGY67KVKTGP87
         Qn6ortaYEit79H81aWpzUDIrzoqUHFLs2qSk2EYFMJ+yvsirJ+asNTmhhM7/34z29bPV
         NZwg==
X-Forwarded-Encrypted: i=1; AJvYcCU7P3KlAxkluWrEgqdqj/kzRyIUb+WLItAfTMf6Q/CZwGkNrk131JlFB2HaNDVZRvuSNPoBtddYm0VDRdNEHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0dJa0WzRg7F83ke2PdAWpttOYnJ3G7ZHADSaKPjNJaRnzTTrR
	bx96Oa/8MfkbT+6XTk6UDa6Cs59zMyiHbi9S8v0awtxujphkJQlmfVSkbcFfrk9w0T4XiVfbFWj
	mGtNpKrkS6x7fnieE89lDQH+FSH9NlL5AG+v+aMn+OjYcTW9SkFG9LRUcyWIsFbxX6Ilisw==
X-Gm-Gg: AZuq6aLxP1vc1W+5sOyeuZljoH3KuVw37vM6Cp6kUtC1lkDOzAoevrctg7jgPoTTmAF
	2cE/764AJxSN+hrrz5VBn3dZgwx34AKw7xeeBvGBE0xrmZdO0G22EgcQUJjjXH46nFx5VqgL088
	jkkMyYldzPeCcCuBcDNtL1JOig61Ekvx9Yk61PJNbw8hrVXCiXkprYJOgVSTIGJoz5VEUr7rVui
	Jn0ArbjJm/v8menZ31GlgvJvN1zbgKpb6Wt60NAbxXhIe70xhTgAOYwuxC8qNo1eDk17axd8Ta2
	aC5N3+LL5vxno61twGsi0lR+x0w8n61lc9CZrWnLOGVIW6OapMe9KkvYsLwNdq11YlGnaBmgh63
	HRHfX0WMR1oJe79ZxmXNptTRaVjD1ZHnPWPWyMsZAXO8DH83XNx0hOAI2Aj+Hx/Nfh0bVTHNdMa
	3FjLCeEHBLXXxE9OnirJxbZZ4=
X-Received: by 2002:a05:6102:291f:b0:5f5:35bd:6fb3 with SMTP id ada2fe7eead31-5f7235d4e59mr521469137.5.1769512851687;
        Tue, 27 Jan 2026 03:20:51 -0800 (PST)
X-Received: by 2002:a05:6102:291f:b0:5f5:35bd:6fb3 with SMTP id ada2fe7eead31-5f7235d4e59mr521455137.5.1769512851297;
        Tue, 27 Jan 2026 03:20:51 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48f0259sm3368696e87.45.2026.01.27.03.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 03:20:50 -0800 (PST)
Date: Tue, 27 Jan 2026 13:20:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
        helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
        lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        valentine.burley@collabora.com, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] drm/ci: reduce sm8350-hdk parallel jobs from 4 to
 2
Message-ID: <ftkgk4xevcfe4dyx2pqi3gk3bqm7jcv65qvn3ypgrwls5dyx3m@srsgbmsteifw>
References: <20260127104406.200505-1-vignesh.raman@collabora.com>
 <20260127104406.200505-4-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127104406.200505-4-vignesh.raman@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5MiBTYWx0ZWRfX/ocFzPwMTggn
 AXkH+ROG7A6Jo9CkfeTSevhiZOzWuDxLh+UO1E9R9rdrL8YoxbDOApR8hOTe8X0+cjXo9I+SD79
 4oMHYy1AgxH6DH3Q0FkcTe51VG9PCR5ZFZ4vlTtzGtCxldKMMXp0UofQmhv3uqrta2vhNMZcl4A
 PNYGUSVgYtryME8B3C/qlWYg/HSbbnOc+rsnN4l5F0xS4FRBf2RGH89MT65ei5YTK5/uW7nLqF6
 0AH3+dF4tmlqxxuXl58D6ToOWpjgEUUhjgvqSD+DaQwUvx2NsdxDhxua/V8hiN54zOq+BtNuXvt
 fNziLE5C7p0sU37PYuLMP6LYoyZbj9xC4BXt71xYsJcUK29yActO0r9Zh4ZZkUn3euOB0KhblEg
 QRgdupb4tBix7ImaO4Swdz0iLEdUfXqXEpZbNy4K9ko0bbE244oCToOPjt5nH68z2vpxCCWogYn
 Gcg30PgLr8gGeLTdcbg==
X-Proofpoint-ORIG-GUID: J_negfDUXdCd4_QSIvgKeyX7FiIXWhMP
X-Authority-Analysis: v=2.4 cv=Hvh72kTS c=1 sm=1 tr=0 ts=69789f94 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=_49z0RMimKR0Jg0_r6oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: J_negfDUXdCd4_QSIvgKeyX7FiIXWhMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270092

On Tue, Jan 27, 2026 at 04:13:58PM +0530, Vignesh Raman wrote:
> The sm8350-hdk jobs are short and each test takes around 2–3 minutes and
> the full job completes in about 10 minutes. Running 4 parallel jobs uses
> 4 devices at once, which is not needed. Set parallel to 2 to reduce
> device usage.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/test.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
