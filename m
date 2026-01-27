Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90334B195
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523964; cv=none; b=ltEfPQgSKRqhSg+OKHZsvygUmUAnkKv7Z/RkJFPd/Lp7Wjt5z3Pw1kBgSFRBh9gIWmBZHZjyFVHrOZsCb/vp9/1yMtNc9tZKGPrP0ZGIDIEc8G4sRRe83aMapDzc55smZJ+r835nIz4UgpTaa8wg9MzVjmCB95Jch0bVnwOz8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523964; c=relaxed/simple;
	bh=Rj6r3LFeX7UEeteYTUs51v5jgZPlRg02IraZry9nF6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFF311rmhxvUia6GEvdVvk4f9o+DPPfAFIOeYF9jSgy9enhuoxaY3xe5PlVE5SQY/cPUUp9qK9xWzsk6l89tumFnslQJFggT1vpZYty7kuxeIijB+3xIUgiJKCKqieXQskCMLA7+BJerrRBVqq5isXjnNGDaYpD+MEM4UTPJx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7eUaL8F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jzhNfQz4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7eUaL8F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jzhNfQz4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAXunO1268864
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 14:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LeBGXuVPBeSkZrySiP9d01PK
	e2NSJk5/OBYu735H4lg=; b=D7eUaL8F/NQC5dIugNwP0PYoJJ8XMLVA/hWsVtxI
	TzAG0cBfSO/OEVWj3LXovywqEr0h5KcKGsN1gbRNggn55uj5TJDlj0P5rz3fxiR5
	uQTSTvRKsWKqq+4Cy0kPTyOMgUonpOpduLhMhALGfpBU071fhmEWYSFjNYvI+wJF
	Qw+GJ64tAdNnxMco95gcqFEP8Cr1Tr4YCjwDaX9mFimeBof8Mz2WvS/HCLCk+o5V
	NNWFIh0XXSbz7xwg/dg13RYXOfzzxDzHQr+sGFOaI8oTYjsA8wPvpEwmb+ChduZp
	Y0HvDtg61ADlLO1qUzsxlcZnVGspsBhvv/VrlZEvFhPK1w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyasyt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 14:26:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9483af29f38so5337642241.2
        for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769523961; x=1770128761; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeBGXuVPBeSkZrySiP9d01PKe2NSJk5/OBYu735H4lg=;
        b=jzhNfQz4cDh4yZYv+K7stV32gobM2LU6w5BhXn6j5QcD/ddCtwamiifB/3jDf88y6p
         U/dNboK90A1v9M23iXYzCQfShpXl+4KicwltxirEX+V85eJ4QUWzv+KRS7BPCfZPFRkr
         VKrz6YVCqdudGT4qRjuv0JPc0mFlhib50mW9VUGzPdtRwl4S7PUFtAWZ7wXV6n5Amy6z
         391/3GXke6AK0Uu245hvyHIpz4eseVfgLmbbUSbDRBpxYLpWQTif98ppMKPfLl3NB6wI
         nliZkzXXDp49tOwOsG8Xni5Agr8Bdq1Wg1bW8zZ4kLifafDcvhEhqteSKRZwcUHtCzwf
         CeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523961; x=1770128761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeBGXuVPBeSkZrySiP9d01PKe2NSJk5/OBYu735H4lg=;
        b=t5kSh38Nm+aIUhx3l6urLsK8xqqWqI6340zOLxzRhy+HCLGEasOqb4jKNh123hdxNI
         zyYFRm4HkGTb+mzp+Ju1R6ZNpQO3/GgE/SqURanKQI7HRivusL7VYmbLrU93+MXDg9NN
         kCP34/acTnD/WTNChcoPCVswKWEZQTuAj/wmkaOf8GLB7Vz5SSc1nxmckkhFHfTMgpP5
         e1cgHIXSpoHZCxOey5f3/6RvWJoi5xrvaDigJsfFW9AUqADM5osTOjEHERGHz7CCtMTn
         Q4pRuSmhvfCEiwyyqfpgXIvS7D28MRJImmOVFFdtEH6mF2xlbJwP0I1jNrKda5gmadpx
         C8HA==
X-Forwarded-Encrypted: i=1; AJvYcCXoyMcfFb3nn8/ueN4KTHQDt0I+xkoHcsP/aFaY94W9fMkBTAFFM2SFPPisiaXRqzawPWutaIq3G4DXVaoRHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLBqRgMd5nXuMZ/6HvNPrpvzNqwp1z2pPn8VQL0E6nsiErwS8C
	WWVfRznOxNdxhf2GWjYuSoNBhPsVktTgHVlV3tifEf+bCC9sMV3QOjnS4KqZQKG+6r0XXG754Ku
	jx3DQMcoqF7O1F82v5nc2W5jXAXFvJ0/k6kb2lHdflQtAOoFR+wHNKmBi+lMpqaXwAMjJmg==
X-Gm-Gg: AZuq6aLNxw+c/1htwm+X6mzcOpBpplZLATOgITBP7Vlw9Uha9F/9bT9XeNjAJ+ps4GS
	sHkSrzQtvk6qDKpu9aa2rGTLfGQfrOOg0+uQhA+ANvywU+Pkr6TkrHWVidNCI8mn9GhjwDJjU52
	FccJzzLh4AfzcUpJq+3ozkwjPvAGw/6CSQWNqcaqquCA52gDBsLJc7KEAq/7bTuj3SNDnmXL2og
	CVPjg1EGUMUfS7/sk21LPl6VldbRqucVg81lyUPN7pItFPDWiVO57bTUs0bB8B7WDRKvhOGy/2D
	Hd9+aDthsjdBm1pxMTpihDtIo4w9Lzg6+PuGG7S4BGKYkFNZyEpkMhZYGlJJh1FO5ixHxfchqSa
	eFb8+mg9CFtSjvTtnLeRYKrK74nLkDSbyonRNs4Y6EeGN0CN6XZhsIjLbqC+TWcEOwyOisUrtQh
	R/F5K/pjDsEwjNu2593GR39wk=
X-Received: by 2002:a05:6102:4610:b0:5f7:24db:fdb8 with SMTP id ada2fe7eead31-5f724dc08c8mr478864137.25.1769523961046;
        Tue, 27 Jan 2026 06:26:01 -0800 (PST)
X-Received: by 2002:a05:6102:4610:b0:5f7:24db:fdb8 with SMTP id ada2fe7eead31-5f724dc08c8mr478854137.25.1769523960506;
        Tue, 27 Jan 2026 06:26:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de4918965sm3637789e87.55.2026.01.27.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 06:25:59 -0800 (PST)
Date: Tue, 27 Jan 2026 16:25:56 +0200
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
Subject: Re: [PATCH v1 6/7] drm/ci: uprev IGT
Message-ID: <5vxrhiilcsaull2airasmc3pjqazvswrtojozz264i5vk3m6zl@pgkdwq46p4ho>
References: <20260127104406.200505-1-vignesh.raman@collabora.com>
 <20260127104406.200505-7-vignesh.raman@collabora.com>
 <zi7frtnecrzyei4fl4nmwmth3icnsyycxxobbrcwovbqfsfq4z@eh25dyfrjkqz>
 <9949e82b-6ec2-4975-939b-d6a709ecf43f@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9949e82b-6ec2-4975-939b-d6a709ecf43f@collabora.com>
X-Proofpoint-GUID: B6pBUswqNhOBG4ndHb5wuvKR1_dWrxDU
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=6978caf9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=ocmXNzLk5YWpj9Dh6n0A:9
 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: B6pBUswqNhOBG4ndHb5wuvKR1_dWrxDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExOCBTYWx0ZWRfX+AsvSj2dObiz
 vR86VOyRi7LJaM5Cbdgypa+/riMfiMQ3CBi4y6ombEcMvgSybzDXz2R/33ZVUlofQy71NCJWo/i
 kWUad2bwrmU+7/vlher5iMuo2KwxVwmyxCNKhPdEhpYEBWEd014RQ+qsFGFMo0nzZ+S6c1MvIKU
 UjbCZjajCZX5ZOHTvWIqRC1aJVFDLsx9uCab+n5lDTZD5l2Tr4IR3viSKL2vKiEoky8fQO8D5D5
 2J0jXau4GRL9La1ArPvM5kdGC5ceGGLOsK3xYcmchdsAtGXuIp8/2ZbSlIz/fSzWOaPbFqAMfBZ
 FxIDrtFGAKoesAocu599xeFTpv6cpNTY1nsTDLCqgJBqqpg585hJTfBm1zRSvUfhXKVwJPL8215
 uraEYdbwS0LxkLc15JmJEgEw3rp6xiU/FEXLj32qMBHzOv7/OdHFnwYolocG4IBjCJzEQK9monG
 zsLFa7iS1DUUPb3K9Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270118

On Tue, Jan 27, 2026 at 06:26:11PM +0530, Vignesh Raman wrote:
> Hi Dmitry,
> 
> On 27/01/26 18:01, Dmitry Baryshkov wrote:
> > On Tue, Jan 27, 2026 at 04:14:01PM +0530, Vignesh Raman wrote:
> > > Recent IGT [1] seems to be broken on MSM hardware, with many tests
> > > failing due to the old_primary->index != 0 assertion. Uprev IGT to
> > > the last known good revision where the tests pass, and update the
> > > expectation files accordingly.
> > > 
> > > [1] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/commit/a909ab05
> > > 
> > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > It is not clear, which parts here are due to Mesa uprev (yes, there are
> > some of those) and which are due to the IGT uprev. Please split into two
> > commits and make sure that Mesa-uprev passes more or less clearly.
> 
> The mesa uprev and the IGT uprev are already split into two separate
> commits. The IGT uprev only updates the IGT version in gitlab-ci.yml and
> xfails.

I think I was not clear enough: Mesa uprev also causes some of the
xfails. Those needs to be a part of the Mesa uprev commit.


-- 
With best wishes
Dmitry
