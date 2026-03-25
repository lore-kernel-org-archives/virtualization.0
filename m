Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456773624A3
	for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422397; cv=none; b=JJnihc2bd8p73AXzf7KcvxRdjz89kqzgtyJgWOo5Y3j4hKt6tDKdxO4r/3va9i96tue8T6cPUATauCD0yB56rfxOcquywmf7xoak+YlAH0rR52MYKi9QtnzklXBplpJ8NqT63gwUkHJbawWZhHLzIKVMATL0A1idO0f+ELwt1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422397; c=relaxed/simple;
	bh=jDZXpI0NalqoL+zn0UWvL4nVQ7ubhdhC5Wlv3Vb4wJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOZZQg9vOqvc1cFn3dydY2j9KljOL/gK/eVOlc5iJOfKVcOlf16Mn+WFnpcMQPKnu6GSlmvt3kqaL5Mt9owJoacjpsYUNtGB0Z/K621GlkXHYNMicVGZbeAlOHgHxt6J4ZYa1kzvCx5Ypdd6no1oiV4TZaQQBuNE+yyN0Rwl+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0m3F5br; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=epqBMri1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0m3F5br";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="epqBMri1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3xqXh658605
	for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 07:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rQsKwSTJPFyNadQFvKFExVIv
	rmCLGMcz0vINVo0Po1s=; b=L0m3F5brvM58NyDoxlUV5OVWo1Jmej53m0CksRk2
	d7xYJYzAzCTsf6dALVssxvAmBjHQ58BM0efr51a4SfNSYzgt934DCxQN6bfSehkS
	zINpH9s22Q12DVReWnso1p0P4pm9QZ1mgPuHg+cTIRsQ2TqHEYMVU2expcqGhNR6
	YkQlfy6Wqy3rd7+uTLNpsW9CNqAKnq069HlEYoZSD8TTVvFpnwQfiToUSxk59VaM
	oHufhv/vnZjJJcoqFhcPqzdMHeAv7cS12NIa+4MUdEL9j2yCCpm97X4wQ7QdRHqn
	gwFqff4iulnucegoIQrymBFi4cTG8n4irD1sPINtVw/6KQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489wggx7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 07:06:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b31cff27fso25593981cf.3
        for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774422394; x=1775027194; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQsKwSTJPFyNadQFvKFExVIvrmCLGMcz0vINVo0Po1s=;
        b=epqBMri1i0qDw3V/PuGQTFVMBz/fFozmxuH5Qa7hzVVmnNQ2n12l2hWi+uaSJT/y9F
         ylf+9ck0w/LdM305IDijJ+ge6OH8ty5NDKvkIogl+WOsGAVljQw0CeRDdBw1xvSwLP0+
         RflIQ3H/KpcuTTt5ShQtfjAaMCSYtrZy7l+FF7lCSeV/Yqsmkr0BC5d9iVgjqKB3SwNA
         PpZgxZ3rxk7fPNNTlc/JCm5x+vTsIpKf0zk5jq/Lg6zywWJT91/qDSyqrLTiWUfPkF55
         cJOYRqrclop4YBtCR9HqOtZD2n7apTvLwW1oAH0yp9JP6yafQ5UQv1aDxXVEGmY9OHbM
         +CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774422394; x=1775027194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQsKwSTJPFyNadQFvKFExVIvrmCLGMcz0vINVo0Po1s=;
        b=YdcTUDp6pOXEEB2sj1gLL1LoktG83ALzAU5OH3LiBq++NZ2iHftWzF3tIF/bvj5raw
         por2EgmwUhBL22icA908moMZp1rwLZ3B4fvQXUXQ/WtJf321cZ8522f2+zMB4MuAvzf6
         sRfHzPCAXTKog3OQjE48GkP8oxuv6BLOE5ZpN4ofqFKKIFV4Me1P1ejuwHGFqN8orGRC
         CwjeQl/lsdXmhNChBjYP8LcdpGnc0WjLPDpnf99cAItbaXAoToCl7N8Pmp8BS/zixJ0Z
         z5BiXfRtHYvgv+P4MDtu8O2aM7FYKcFDqcyUVFIdn3y9WSXyj9hCMTbQ2zquju2j4pW6
         oekw==
X-Forwarded-Encrypted: i=1; AJvYcCWQMuhfcx8IKjuCuLIjv4Yj2nHJqntvadkJl8Sy/ooFhBFskUG0U8Fh8wFMnNpAaag3ff3bbBa2m+p44n7IcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVNXj4T9mQF73kApGkZJFJT737zb+3TOGm/e3eVceuAZ61l8lH
	a4gt9s7ipPgbkqpG/ZPhIcPhbXXJCsmohIPmYYC60oa2wP/SCs4LZjvgjBBHD0K6jmPgT1CNQNY
	smYOCHwbT5xhsqY4LCo8Qk4dLIKxvacY4l6dI7HMZ+0FwdNjaoR7wTDd2Lzocbgw3K13Evg==
X-Gm-Gg: ATEYQzztZtG7dsRDOM6OLsoAXoEbHmXMbxOh/0PtrWiNKld8wgfmmiZxDqwWSgZfdCR
	OWJIvnlIvnn4mtAt7794fSxZtkemTBBsQOaOQ6fwCogKu2IzUyqbJnw+ndBSkvRAkML7veXLKbf
	K4jRSe2/kc9Qo/P1vuh2ajbar2bhMjYcVssQ0usshvTH5lflxSvs7SrFoHq9Aupml+1VVAUAKp7
	A6UGjvMDw1ot0krFTJZHkUFfyKloJ9tL/K+G1wsuVbkJd1GpHvOb57QEIneVqjlcUdh7/lsk1IQ
	KdnnsgCL1YY6kqlCcsFa7OUnRhOWUn7NDefcmqjhO9rLBqGXrRT2gfMzE722yFrcOz5X3W342j6
	LtIb5aCAqxdu6fU/j2XNqCm4/sT/vq2RsxuGSadGx8HG5+Wf7MIffOcIrLXE+CuKKUwBSnCZlvE
	qoR3cDKVH/JPku6m/DmcNJ4gTgKMBuIz1KQuo=
X-Received: by 2002:ac8:5cd0:0:b0:50b:3be7:b04 with SMTP id d75a77b69052e-50b80f01b6emr35059681cf.67.1774422394508;
        Wed, 25 Mar 2026 00:06:34 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:50b:3be7:b04 with SMTP id d75a77b69052e-50b80f01b6emr35059231cf.67.1774422393873;
        Wed, 25 Mar 2026 00:06:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2852071edsm3641505e87.49.2026.03.25.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:06:32 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:06:30 +0200
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
Subject: Re: [PATCH v2 0/5] drm/ci: add new jobs, uprev IGT and mesa
Message-ID: <pqa5xua2shwqpkmwbu2jitz2ogpbmgcd4wizb4nt6qtxstubse@4ltbfdvfpqxj>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210071138.2256773-1-vignesh.raman@collabora.com>
X-Proofpoint-GUID: JB-xUCAd4DayfISDDq2PSmVgJdtZB2Xf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA0OSBTYWx0ZWRfX3smqj01oj195
 P7t+d1OhghVnG9kVRpP0Oj2Cx2KCvlyIXmT2hUQqj+bJguFxbTsrwurFk6r+2SR5Te/o3zCfMf6
 CiO97sFELLoCUmfzXHwbAWHyPza1wY6SDVid7Z52RnSzRXe8ydSyNaqmF2+RvicYM/2W/qOnL81
 wiTGOuUVYuPepXK7d3OSZHwc6lwVBYy39f2IKhBPFdJ4FfH70IebdIDMgc6Hzd0tw3KnFiGqhjQ
 +4pkeHuesbjf4OUJ8pbJcMwU9pHs9hGyyUvcPj3zzKoCbruowcG8cNAWnqxNkwOGxe4QEbA4nZk
 8nwE7flp8xVvqn36UrJ6D7oiPODW7UBpC8lT8cJF5TLl9O9GuqvqzxEf3wqEzHvSEapswMffjZZ
 rU8k+m2fr7R5rFf70KVoUM7e9RSHjkfcyv9sJbqnZfBFgl3/IQW++XXwwyue03d9iZ8+1R9pEjz
 AkgntEwpMkTtewmL0hg==
X-Authority-Analysis: v=2.4 cv=e/gLiKp/ c=1 sm=1 tr=0 ts=69c3897b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=LmRgrdqyE-cJMQzL5zkA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: JB-xUCAd4DayfISDDq2PSmVgJdtZB2Xf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250049

On Tue, Feb 10, 2026 at 12:41:29PM +0530, Vignesh Raman wrote:
> This series introduces new job to drm-ci for testing the following
> devices:
> - rk3588-rock-5b
> 
> Other updates include:
> - Adapting to recent changes in Mesa CI, such as:
>    - LAVA overlay-based firmware handling
>    - Container/job rule separation
>    - Removal of the python-artifacts job
>    - Use lava-job-submitter container to submit jobs
>    - Use of the Alpine container for LAVA jobs
>    - Remove bare-metal jobs and disable apq8016 and apq8096 jobs,
>      as these have been migrated to the Collabora LAVA farm
>    - Fix issues with rebase with external fixes branch
>    - Update expectation files  
>    - Various other CI improvements
> - Move bare-metal jobs for apq8016 and apq8096 to LAVA, as these devices
>   are migrated to Collabora LAVA farm.
> - Updating the runner tag for i915: cml (switching from hatch to puff)
>   to improve device availability.
> - Adjusting parallelism in jobs (sm8350-hdk, amly) to better utilize
>   test resources.
> 
> Pipeline: https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1601024
> MR: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/213
> 
> mediatek:mt8183 fails and it is reported upstream - https://lore.kernel.org/linux-mediatek/CAAq5pW9o3itC0G16LnJO7KMAQ_XoqXUpB=cuJ_7e3-H11zKd5Q@mail.gmail.com/#r
> Few intel jobs fails, this will be investigated and a seperate patch to update xfails will be sent.
> 
> Link to v1: https://lore.kernel.org/dri-devel/20260127104406.200505-1-vignesh.raman@collabora.com/T/#t

Picked it into msm-next, thank you!

-- 
With best wishes
Dmitry
