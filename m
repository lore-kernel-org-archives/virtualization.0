Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C133BBD9
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770761603; cv=none; b=jkcfSf3xBzMOXzyzIRYT5DgOdO5x880q43pyw8F/9CgymjbTC3MEwBtySzvRNDXMI29pXeVQoTLLvLy6nqBlsHR75NUFFgJqUxdFOMxC6Y2Z+i40O267dcJjB8WYjPymrRblFj2AAFhBH3Dh9d1iRXNTKMxp1NkDDm4z0p9POoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770761603; c=relaxed/simple;
	bh=zwWrhU6LfesEpgYgA/BYgk/WJcEt3YxZza1OLt0VoVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2dDp+7qm/2Wv8CRb4XRgujY04O4XW1012qaKoj3FrjFwkJrr1H/qgS9RUI0WCBwP5lW4+8oBskLSDrtlkVyvSUQsXUKPGkENQ1rQxMKsi2VWouQBNMQ0XO0Tkfkho5rZ2qwgWxhvQtdyjJscWgXy8/hdFEPdG0RETVx/q5qrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdEnIsj/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GNgiRBuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdEnIsj/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GNgiRBuf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ALVXfX2169252
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 22:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5nTCr+xuryPJ1HpVPDG/DVIr
	pdNtB8DMTFv7L6Sd+kc=; b=HdEnIsj/u9lznKcM+cVpa5eAlJjqKYDIdfXWleDx
	ILcEWqi3xNQPG1uqcdNJVKuH6RDVfPeA27IGCPyNzunTkj3rB0UhqAcxY4CHCpD4
	osOg2arsTz+URJlKTNL9WtjlzrDlp3XOhEyN1gjO1N0V/LIakS4+C7WPkkZr0l2G
	APeufA8GrK0do4Em2NyYow+uauEPvQFQ1yxVRmkfEmo3djaLnTLDVD7WxOLQhlVx
	IgOn/GWSYha1OJBPHRg3pPAkGLKxLapiu+khCOPei/UcpQkl2AGJgXtxW56eUsqG
	awmcAC9T8OxeFQHXdAtBuoYiLUXQLjYrGYx2WUDp356dXw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c80drtw22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 22:13:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6ae763d03so149613185a.3
        for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 14:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770761600; x=1771366400; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTCr+xuryPJ1HpVPDG/DVIrpdNtB8DMTFv7L6Sd+kc=;
        b=GNgiRBufmV1wJlJj77v514UtYsYGAGg/AQ7UevKbsh9sPUrXs0/UDhOmh6ih6eOQN/
         znimCqmIT1cV7pNMzPqa9dqQZ8SQzHSGf5sCxqrNA+2OcBPs0w3gV5O7xxpevCcc/PbL
         IP77WYJ860G7Ik5575ofncAM6cG3WjMy6zG/OQNoTkohWqJOnHe17MPKqD4FjLebjjti
         1bkn43MdstqDv3EJfiBZaiMSkbjSp9DXvkjR5R2JKU483Hvqjm1PxVhB5tTCWXLILoCi
         IOf3rutqsNyG9g4lk/tWvuMa+KW/G2Edj3YFw1jiNWwnZNdApte3Sw1BYY4K+Yq+xd5+
         SPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770761600; x=1771366400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nTCr+xuryPJ1HpVPDG/DVIrpdNtB8DMTFv7L6Sd+kc=;
        b=Y1OJuMahaREVWkzUhxxK6id74jplhM44w0c5Yg34NTpP/fbtSQnG8Cq921+fovHWgD
         WOq+on1x5/uqlj8slxWponM0TzyP9hdJdQrl+rPGK2UfoGAjT15vv9iE01fpVXEBUoxF
         Jz3o2jWofnX50Mvnwlq0TluqhnBzSgsUv9tkXePUlrC2tzdDowgskVARo1BXVOQxVVEk
         82xEFAkbDuhIcOIJ7uFcPwYBw9PA0HbN+9O04FdRI0+al7WunjHNsDOqVFtqnzO6571R
         VN87jKqWCVVDkY57h9Zl00kDhzMKl/yTQKfmzqp6uu7fa4CoRY2dpMT+swUTjg3DDn3G
         hRSA==
X-Forwarded-Encrypted: i=1; AJvYcCXgQ+mgiX5f3ZdTFTTwaO/NZhKgWzP9URoar3GvowhsFqPuGegw78GWlPW95ptzDU0oHYbZEFNSAsuOdNHpTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiJvE5ReEE9xJKKU3Xgo+Th6hQIOtiUDzuKJ/3aruaqNqpeu0V
	CAkZYM1zkUJwXVHHTJkOROcLNE/WOEkTk9xxyNcsPCeVTppQ3zdtAxjGw3hUirfDA+H7XpqNyJ0
	PBtq/E8M2PLrQTii6WWhYcRNDyAA6MiXNznL+HuBrLm7efJ1/mWvZu7HXivLyVkxXvC7boA==
X-Gm-Gg: AZuq6aJ7PigTuDsKIEz1Xzt4Qlqb9ylHcKrT3tBxDIOFn0qhOF/0EGp/GBvRni2d0+V
	7p8EtCkvzv4rNh/9403Kxs4iL3p609zg4PCVTYnyq2eTXEeGTCIpSzZ5vtCCSZJ4t/CN0Oace2p
	jqgz0Q4VUxfDctnbKw//hOb26KvuMQALaWRimnAWaPwRnPGc3Ry9ZP7JQoQXZKoaC5XXYfUGoTv
	ONOYwP/Udtb6JQ7xE2W0Mwonyc7hlZSgCccxJM4DH+mcWU21Mj4wGfAkYpV6OdYYlwtm8mPrW5N
	uI3tAyN/DSiaPMQ6aSdwYr+YBhw0GEswhTAwlRUt77nf7fYEY/OG5/+yy3hQpqRqI5SDIDFQiZL
	zX7zKUD30k0mvuzsIzShLMFSIgXmJ3XUbQKbRUCrVusXl4kK+PFIeAAt3k2mzsZKLiRXWC7dUCE
	pj66Hn6ESfOihDxmbjNH/GhchyWvaFdj2mhRk=
X-Received: by 2002:a05:620a:410e:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8caf13083edmr2257941485a.70.1770761600408;
        Tue, 10 Feb 2026 14:13:20 -0800 (PST)
X-Received: by 2002:a05:620a:410e:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8caf13083edmr2257938385a.70.1770761599898;
        Tue, 10 Feb 2026 14:13:19 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f72sm3521414e87.2.2026.02.10.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:13:17 -0800 (PST)
Date: Wed, 11 Feb 2026 00:13:14 +0200
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
Subject: Re: [PATCH v2 4/5] drm/ci: move qualcomm baremetal jobs to lava
Message-ID: <55cjkwps5sfd766uxab5viu36tez77rnrlnabocqb3o7t5hhr6@nydrmwbimnzj>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
 <20260210071138.2256773-5-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210071138.2256773-5-vignesh.raman@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE4NCBTYWx0ZWRfX7hQtfeEaIY1l
 yKIM3j2o8I4zPMaDlpNn1wphG1FGG82KhAJXl5g+vg2ed9e8Fnr9osUpuQr/mP+edMOnvpy+N50
 58T+n8COUIijauqOZgxxBUjOxHgjTeb1gu/GERZt6+6fQWOmNFdL3Zj1r5EQdoAa1u0tVf21wuE
 Mzccr+yc78zkGeb1RnjpRXin+6P0UHZDwnmlgYOWCQtc3iLVq2B/4TojyFecmFwhDk8f6s7kBkq
 qxi65jozMnmVND75FbeWGSp/pP+TX8l0nB+EKOmbia1p9kaTCG7AAHY0HvASO2Pjsr8sNae7RAn
 EPJOwHpGT7Xg5c64A9qQg1kvRCHAlxuk4WSGfhhC0cwaINaOME2EwNKFWvL22Pi8tCUIbG04ag5
 yhQdOdr6x1NOQf92Qka/cpkncdd+Xta402ojJWTxLeWoFcvoUXfzhEMHjE1YjUFdh8LTLxXZxvj
 7d+/11qdkGAQ7b1QDqg==
X-Authority-Analysis: v=2.4 cv=fd+gCkQF c=1 sm=1 tr=0 ts=698bad81 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=9K-sheTcyn_FmZRYi04A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: LvSg5I9xE_O3L4GZ_KPDlPSeQ_YZeUx2
X-Proofpoint-GUID: LvSg5I9xE_O3L4GZ_KPDlPSeQ_YZeUx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100184

On Tue, Feb 10, 2026 at 12:41:33PM +0530, Vignesh Raman wrote:
> Qualcomm apq8016 and apq8096 DUTS are moved to Collabora lava
> farm. So enable these jobs to use lava and update expectation
> files.
> 
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> ---
> 
> v2:
>   - No changes.
> 
> ---
>  drivers/gpu/drm/ci/arm64.config               |  1 +
>  drivers/gpu/drm/ci/test.yml                   | 41 +++++++++++--------
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |  4 ++
>  .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |  2 +
>  4 files changed, 31 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
