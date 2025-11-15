Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217F2C859
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763167812; cv=none; b=n0gVt4H2AMfQ9G7VADzzFTtQXXoerQ6KIoAo1S6975oanFyi3OZpyn4UxveEvC062e3qIZbQBNIzPa65g16UdzkfZzqFR1QJF3uv+yeJ5LdjDu6H6QX4+Sixvebj5Fxnt5bnAby+k+S23FTziqCvMB2bMGmClLvagcK3RY/tZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763167812; c=relaxed/simple;
	bh=+dCIM7GyD9F3DqbhMwxLnbXvN7e8ybxmxJOUHFdGcLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwUgOQmbZFA/9PFk/temOIKr0TTf+auORun3pDfyy5+kQUzlKZFBDoiQDXkbFJ7+hTPKUXUzW+xdYwgwgBSt7b2xVVu3HvRFtPgVy0WLfzNtwOUdZAchwTtH8Xr/TecQaWz9f30j5IF8f2nBkexjyn/+UE35TpEC23mWIVMNP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxUYZC8H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJarEKeh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxUYZC8H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJarEKeh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEKrwZR295866
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 00:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Qs9XNl6C5ygh9qZUkoG6dSnI
	2cAtbM33aIVEqpZU3HM=; b=LxUYZC8H3vZCJgDMaslziF+/Q+DGDpgidTjmxz91
	36M9bXPQASL0FtjnxYfrUVa1RxfX/6Gx0QRblsZWir9/aZGk9+AO/Bx7/lK6htOu
	Kld39VgMAHM2tQvShW6rixT4ooi/0ZDEkCQl+CHmcUqd7XlYKDhy9nIkb/l1G30P
	8MUMR014eDXOtxX+gjWzx34mcc9JA6nEV5BeVunCkD+NB3z6IefYWUeHupCjzzTd
	AzfeiCztR72AYwahKrSIIHEMhcWT5EQsRTFBaSGjKloFPxSK9SPAbPxvOhpNAzVX
	fLJMN8YRUPS0S07zPbKtVfvjn6QEYSfcvTnlirAT3vmhkA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aebuyrgqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 00:50:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88050bdc2abso85452006d6.2
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 16:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763167810; x=1763772610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs9XNl6C5ygh9qZUkoG6dSnI2cAtbM33aIVEqpZU3HM=;
        b=VJarEKehh0NJ5AT+AGddxqXnNADDYZJu+L4/jdsFdwaCvPCz6SGaJuuxaW8eOcRIqd
         MUpoYU0lBZC3AKb6Vm1lTwb2aBLTJdQvOXwe21vgsZf0bmaP36fsbmiOYBY+b9j7yF0p
         juo3x0g6cueK+i7uLHZOqEIu0Bk7shvWkF4E9Yw2sOHRVQlMk5XekKfQRR9GfxpI0f2C
         0BwB+WILOiWfCRyYmPh0lV4Hn12/XoVzu9Juba1Am8ZypcJuaru4CAAmPYd2uNTqxkAp
         o6sDe0cneusKN0f/hOFQGG1dKZskWE6Yp4iis5tEHuDU/Lh8VVP33jfrdynqBY/JKg9z
         15KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763167810; x=1763772610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs9XNl6C5ygh9qZUkoG6dSnI2cAtbM33aIVEqpZU3HM=;
        b=AkMbGNvz/Gld8jfYtfK1nlqSVLkPozZj5FlBVHtfDQ5cLDGas1kGSFUNxHC2TkNgXj
         nvAgWwy2X1v/goJ1+1dULNW/DF6glg1MN/QgvwDeRYS9l2Uai7SCu9yDr/hKJfiKTZBC
         WvkyENCE6XPIY0U7pJsClFTD5J390KezV1D0BeBmlxGajAnHEI9rK/ml+0AcI+fZ99Na
         q6h+B7/Ciek2LvdfS/Yco+Maz5Sh3ucOVsktsBw+/Lk0G3cq+uxbYDc9tM7N1RAgGZMl
         sUTohkfJDN13aaRUUtLr5rVybiOVAqziiiMqNI7CcVMbhf25lT1OyQdIzo8ozNnPdSN9
         RXeA==
X-Forwarded-Encrypted: i=1; AJvYcCXMMn6SGoGsAHdJ3F0b1luCNZxYvdRxE3Q/EPNd4KLf2eS4M0xPWRKco89ni9zJTllg/gw/4m3Ya+eAgiv4rA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoR/lYNIPKewkV8bQU8krGw3f/jBi7QA/YGYKFk8bjul40FZmX
	nqAcNhuRk/mWE1pMjgRiQQdoDg1WYqsmd+PEmFE0barTt8qIIrstupDMn21htM9bLXUvSssRNrJ
	BlUwvQ+Z4YK6XFzQ3hhKfy+rdM0M/TQdil9/vUZ8FpzWwOFtyzrdOW+aMHYSo4c4capM+aw==
X-Gm-Gg: ASbGncsYUIhk3ehPVMZ2/f/Nnwf604vy0BCQ/19F68UMWzKvfDbOVwR/ggdltmG3QnM
	yVlSvv1wxBaU5sO8IJZLcHaw1sokZHGVaWLlnSZcL5kZkaTWfkB4n8enbYdvCKFK9JT9QvMfVsh
	17xRn6obe4SZMbv7UsXpEyAGJ+UxZFyEiRfQQ2ehd7M3MEpSyMw2ZTc01LXIeJk3GfLLL4vR05W
	08ZfYnRzC/+yNvoWGtyboZCebXrDyLMQZDiudg8mnRJ2pj2Bn+N7b5If+HHCrYLXB7Ndixr83Iv
	GZTbYVVpDUUTrIYud4vXxpLWcfza1svjyC5ydAgdifxxj3DqSQaLyFwPneiDH4/UHxFIgI5YR5D
	7Ucz0XN1QN9CxyWrZQCVNCdO55Cj1ldUCLvlvWonlKJkfjCd5S3eJffYYlZvQ9GXnLtrDrAQfme
	gLmO3nUPo7GQ/L
X-Received: by 2002:ad4:5dce:0:b0:87c:1d89:a245 with SMTP id 6a1803df08f44-88292699d47mr77113276d6.49.1763167809678;
        Fri, 14 Nov 2025 16:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjIFGATfZLfaUZaE3KWR5c8p1sYfBsOVpYyQEawnaMA0DTE16Ifr+U3lmX3Y+76mKypsKpog==
X-Received: by 2002:ad4:5dce:0:b0:87c:1d89:a245 with SMTP id 6a1803df08f44-88292699d47mr77113096d6.49.1763167809268;
        Fri, 14 Nov 2025 16:50:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce0822csm12716841fa.10.2025.11.14.16.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 16:50:07 -0800 (PST)
Date: Sat, 15 Nov 2025 02:50:04 +0200
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
Subject: Re: [PATCH v1 2/2] drm/ci: Move qualcomm baremetal jobs to lava
Message-ID: <ursdbkco5n734zhfqceztib4b6vxb2juq5jfllzcjeuctd6lvn@dbdbkbr4csws>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-3-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114030056.1139570-3-vignesh.raman@collabora.com>
X-Authority-Analysis: v=2.4 cv=MKltWcZl c=1 sm=1 tr=0 ts=6917ce42 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=Oc5gQ_T1tCqBBtY5fQkA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAwNCBTYWx0ZWRfX6QPcnAiLbsLj
 8Xzt/OuKsGiggDBBiGiO3oergzLoKxzPPJicIOfO7jt3WMzkSeuU3ICJY4AsJkaaDMJcit72lqR
 0FWQQPR6SBH0nxfoFKRwLmG4mVa36RPK2W0KxqY9RQnYCJAaKMEMuL3gXp6Sa0Ofo5YwzhARbLG
 urMk9CpOTpsW5qNYvN8RBlrewjy/y5S6lZ2sce3qTOPYovKrw2oV9csZwgd1miaKBz7JSYjUPPm
 4W2WMntrlhs+rVHcwkyM+JfjHz4KogpK4paRtHoJjEeArx87rII/ENpTEr19Dzdgaf+kJMSQw9p
 ZuIn2Gbs0dDugBn6wR5oZAba4ZKhdP5XIVNhWSSfCEFhEaBjn3LeHS4l/bxAq+0XMVUEvJORogk
 h+gRN00mlLdwuDmXG1FiKylm4K3aXg==
X-Proofpoint-ORIG-GUID: Z-F-ME1IutJLhcJQOzy515B3VKRUJYTr
X-Proofpoint-GUID: Z-F-ME1IutJLhcJQOzy515B3VKRUJYTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511150004

On Fri, Nov 14, 2025 at 08:30:51AM +0530, Vignesh Raman wrote:
> Qualcomm apq8016 and apq8096 DUTS are moved to Collabora lava
> farm. So enable these jobs to use lava and update expectation
> files.
> 
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/arm64.config               |  1 +
>  drivers/gpu/drm/ci/test.yml                   | 62 ++++++-------------
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |  4 ++
>  .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |  2 +
>  4 files changed, 27 insertions(+), 42 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I'll try picking up these patches through the drm/msm tree, if noone
objects.

-- 
With best wishes
Dmitry
