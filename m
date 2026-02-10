Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3ED3358A3
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757659; cv=none; b=PWcf/sHcbvH/E9TUVX2sDLlyBxlZFiOhEUx7B1MI0pBYnAfVZvCatn8l4HV5f91PilrokqLYltXHsCbSI1gtVgEiEwSUwuTfsS0YMCXKNORx7tPauYTSDC6xFaib9cU8kZ3YGT9xTzwROBo6xKdBfgpSEPz8N9bcZyZJU1f+Qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757659; c=relaxed/simple;
	bh=O8Y60BSUfW0JulofWcWOcnLNPib8cfjgTkAXX1r0icg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy3PmNcMkzAbKaTORxSAl2icx03BQtfBroozObhmSjYkx89RypT1tByzziZQDAicxdcEFHsmLyewo8i8yeAn70sgrM+kvHDjN1s1Uotlt7CCuSbauogzrH2kNpcfIgj97ibPRyCRKGHrTir6oMkZ5Kadg7at4Tx7fifWE1uMKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BOj42PKj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XlAkGzM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOj42PKj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XlAkGzM7"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AKC9Oa2640778
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 21:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WYekD6MnY0SEVsICbNMS91My
	xF2Htl8S3olx63sNyJE=; b=BOj42PKjqHWpHuUFFKX7fABB68llL9h3EjDxQ+m7
	RERiH64TbniHjMINOGhJxsL/cpuR5YC41SHlQk9ilvrSLQ5TzUeIPi+i09rdl2j2
	aAh48Z/KrFLSA4Q3VhLof+0nEPrq4Tsw2aVi8cvG+H57j7nheg60qt29lIzC/59H
	KDB9Ljm9wjXiNBP+W+TJPGxeKGosACMgNDLFAoBHrO80pUA9Msw1HWXhVgR11zsL
	spxo0TF6+3N4sa5NTOoD+34Pvymqqu+KcKOgL1bI7x/xGJ7Tzj2W8gvtiqfvYMPG
	lcNfvwfEZsxPldedJmGFaaJaxM1kQPqAUYd4+vQYw/u59A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8bgng6ws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 21:07:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52f07fbd0so1932628085a.2
        for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770757655; x=1771362455; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYekD6MnY0SEVsICbNMS91MyxF2Htl8S3olx63sNyJE=;
        b=XlAkGzM7zlfBUFktn2R6Zxk6HehgoMNPVd0nZAarvnPpkIUzjihVKZ6Jh9HmgOt8I6
         rvO+JKJVgBi7CixSKDpZKJpYNzHL2c8Y3JRJ4ItukrZ6UxUoY4uybHz7mvHxXba0zt4U
         1Fikkm048FFi/J7PYblMnd9ZIvhE7MoU0j3vAhCiwFlvcH5R4QMUxCQpmP3sN0gIGj3k
         OQqHFa74qenduKyUaIF47ML4kfzaDg61weZK9cBlUUL1uCEYMdJ21Bp85jdREhK2SuQW
         WJcfxSkQJodkKAUr4uAoTJZ+96JUsIzUK+ACxL4NCUagR+eyUvULlst4xKGfVJ5xsm0a
         1awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770757655; x=1771362455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYekD6MnY0SEVsICbNMS91MyxF2Htl8S3olx63sNyJE=;
        b=UHuq//XU78f1AMEq0IHAuGbk72S97vZmYW5/gHUECIsTB1A9UVjgAfD2mv3u2nXN4j
         u6c5iL/OnH5YAtY4u72nueRNgWCMmuxbiNvQuygcJksB0955d4+5ERbSaQn2RrQUzisP
         R6QqtgVnpzLXup0pkoeq08PlCU38K6qDXOYNv/1a20WYDKffkP8k8EBj+WNKBFke24LV
         dbSQD8F3CeDCteCXnni3am/CU2ECvwyl2rFcrCTifxso63O9q1rR+6g1q8RwMhUrNJxV
         L2W8u1G+jUtJCfP4BtN8joBgNWgKTIxaJpl2NK1/onqjJZ4OtgnF88fIHPS3TL6wxILu
         SNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUTa8efC+5RyJGJfqNQr2OmbU/hViW70nSHYXsAJ88PcCj91tfz3G8vZ2r6gigjS4QqTbrC+b3iU6SGiBfjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS1rhOz9ptEubricqKTqo/mN+9UDeaYnP1r54BAHFhIek5WpzJ
	pJFXfxeeWRz/tQPsscWIaWiBUOvmcFifql1vefHf/aI/XxmTj4D0/ptA/kSk1bYqfNSgvLmo3MP
	ajYYwT0SBkuo2EI7XVRl+BtanAt/GL0lA15sRp3ptI1HWyukdoBL2AafStLcpCkUlJWZgQg==
X-Gm-Gg: AZuq6aJG9SXHmGeDsmxZFShhmW5b03raX+Drnd1U0Gw7e7jyebENUv6geL7UzuCDVUW
	qt9ZGM+KHwo5iGpioYiLA2DtUtT1LL6jHmaIhPe7+EsV1JGAwtVOlXv0Oe1Qbuj0im8fEPaCLsG
	JU9In8xMKr4+mMGxYHBm962SBAt6h5WY1m3Vo9lNl3F4cxgSwKqzerPSjI16zEScK8lqGOOrMdu
	lzMSHSv4SJOQ2DrIaztifrraKwf5ua44KyNoeauyW2oWW2ATzwuGVKG3uj3t/jSFGLQntfOB6zd
	e1C9tA0FBmWNseqh16Q0BqgVf8EP6SL1yRtiO7iSWJETJ/63efw7kTyLWWuGaGiTjGHfx5w1sgV
	PMHeVHz2+xcp4ji91mwwtfQ20RbcBqLGnfurU17CN7wf86IuyWL4kgEAb04wgKP79fbTDg7pY5S
	O/pVSfVxaqjI8qkKftE4qpzQhBs1R4j6Msyyc=
X-Received: by 2002:a05:620a:4492:b0:8ca:1240:4990 with SMTP id af79cd13be357-8cb280bc385mr75880185a.86.1770757655201;
        Tue, 10 Feb 2026 13:07:35 -0800 (PST)
X-Received: by 2002:a05:620a:4492:b0:8ca:1240:4990 with SMTP id af79cd13be357-8cb280bc385mr75876785a.86.1770757654672;
        Tue, 10 Feb 2026 13:07:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6ee4sm3514472e87.4.2026.02.10.13.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 13:07:34 -0800 (PST)
Date: Tue, 10 Feb 2026 23:07:32 +0200
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
Subject: Re: [PATCH v2 3/5] drm/ci: uprev mesa
Message-ID: <sl7sjcaylfmemxnqfs72wcb4mv4smcn2knhcj4he7skmgawqey@mzgj7wwzjvgb>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
 <20260210071138.2256773-4-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210071138.2256773-4-vignesh.raman@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3NSBTYWx0ZWRfX3m0xdshn2xfx
 ddIL22pjaGnPR9I0KEGuIGbadUF9DJAFr7LIi+jmfdPYAcpoY3rNBzPpueBfO4bmB8I1w7dSeFn
 gn4L8HPMA79EA5Dfxguci8hikr8G7gUVGrqUy1DWBVOAnl68XnzxO8oI9tjz+2w8eyuPDEpuprG
 NyDXaXAt83dQOhKTfd7BQnfQ3fv6XrgYt2NiO5Zf16YacFCv/jiIGa6f6tsiZCYfUEjnKy2r9jb
 QijNLp+LjJKplssK0AkywTgHWgvyXDvYcznKv9Bl1Fo8LQeQUcJ0Lqq1apJG30R04pxgjwPySVh
 cN5nc/77W46r3FssO41CFOehFWV/c0G0SfcjrdiDYI/gOq+s75YuZqlBO6JIuzVwOi7tx8hU5ok
 NOBmcuY6n5S6JFK6cKPIwd3qX3t6ll5OgYcURgOFa3edw8JRCOFTFY2GvmtHFOCv5S4Uaigewqe
 05e/Mz+BG/555USHYVQ==
X-Authority-Analysis: v=2.4 cv=TKVIilla c=1 sm=1 tr=0 ts=698b9e18 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=eEoeB42FsikaTLMEZsIA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: wbg_d3WdsSO3hlgZ1VuFPYj35T8xHdjn
X-Proofpoint-GUID: wbg_d3WdsSO3hlgZ1VuFPYj35T8xHdjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100175

On Tue, Feb 10, 2026 at 12:41:32PM +0530, Vignesh Raman wrote:
> Uprev mesa to adapt to the latest changes in Mesa CI, such as:
>  - LAVA overlay-based firmware handling
>  - Container/job rule separation
>  - Removal of the python-artifacts job
>  - Use lava-job-submitter container to submit jobs
>  - Use of the Alpine container for LAVA jobs
>  - Various other CI improvements
>  - Remove bare-metal jobs and disable apq8016 and apq8096 jobs,
>    as these have been migrated to the Collabora LAVA farm
>  - Fix issues with rebase with external fixes branch
>  - Update expectation files
> 
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> ---
> 
> v2:
>   - Merge patch to fix issues with rebase with external fixes branch
>   - Remove bare-metal jobs and disable apq8016 and apq8096 jobs
>   - Update expectation files
> 

Thanks
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
