Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3827225A5B
	for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307130; cv=none; b=GU53Wh2K5TOZm6CbynZOBEf9qd6bbb66ooevqGgiRFBfIN/Syn9hSDZINCMVd5/fpeJl3unoREAAl6XQ8EG5BQqX/YohnowCykmGOoE+uDtmnJd/c7M6QyhHJks+GmAUaB4CoZlgKOiLpE92LEwDxqjIpeS8EhNdhBMYZY1sYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307130; c=relaxed/simple;
	bh=opueA1Tj3onhtKt90wHgpDBqZHyCmOUWHK/OOSI7zNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnkdiIfmcWtPksuAvnDICVBWj8l6terNSUa1aSCekfKqMv1KIhEcl4MCIHRPG6LBZ0tGLKPR4P/eNbItExlpwFhmca20LdzAUYXabKe7SujDjRr0qxx9vezftWYp8xsDr+ryX5KYpzSG8Ge2Pz1NgKZn41vHWcEyCcdaLkgApIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=STV1aCeq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cq2gdSDb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="STV1aCeq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cq2gdSDb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AG1Rcg74115429
	for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 15:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=brXB1Y/LPVXbRpByEO14Lypc
	5NwpFVTcCsuQsNLy+W4=; b=STV1aCeqitSSB1V44tB0l1zmgK/7jDhruQaVos81
	EssOg08VRmId+HKWwnbjmu1A0oxPC5Ot0Oyvyo87OOJHticVG/YB653NVBPtYm9d
	UMItP9V/wSh+4E91LFlEQhJNuVhFvVTS+/bfsvX8obshzPQA/diigqQyXgEmYa+2
	zxXYJ2F40o0rqOYznjpqhDid9v6g18id9gJ19enQV+cFgUdkWcy+0mxpFb239eHs
	p3aVsMkvNCq6kwdAPk3OKLUDSbymiPKKYAioD2H3p7O3WWKAQeMEmM52tSJ1CZTR
	ylI817cj5MU9L4CVRhwrC+CcUAq4YwWU/UgKqZenuQxUbw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejkma9u3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 15:32:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b1d8f56e24so981621985a.2
        for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763307127; x=1763911927; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=brXB1Y/LPVXbRpByEO14Lypc5NwpFVTcCsuQsNLy+W4=;
        b=Cq2gdSDbf5UX9fozbTParWD0NLMy+9xuuFeMPdwrFVMOMboZjyle2N5PaTpFmGu1PV
         XULRx3ISJmkII8R/M4L04/pMk86td00jyOwIwZc8zu5kF+f0o9sRQGbXUVMlI+vo/qg3
         +irkX8XXoYhrcaIQIRHNju4rJLvqvau/rAx76DZNkCKnJk3HULqI/9Z9T04P+mcztGiB
         0LhMbic5TOieupJL46BnD/4DBI+VGUJ1+3pnxIjYBpDbQPRZoz6wlVetqzCCvmnxKY8s
         wosd+a+MgT153gE2dNC4H9xPr5XClXv0tPMDHcMQGxrvZxjQf2kM/x6rQVIUQaJpy1xR
         zBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763307127; x=1763911927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brXB1Y/LPVXbRpByEO14Lypc5NwpFVTcCsuQsNLy+W4=;
        b=UmjQ5oz7CmsbSFFo6m/9PscBf/kxP8e4cxpJ71s7NZiEd/tcxiDn7kzPBqwKy6jPxf
         wkMkIjqk8Et7eNiH41sRnTNwkZL4WDSpT8h8N3C65GR072GaSIx85V02skkI0IISd4u3
         CULl9EYL5Rrj76NUBfOodRPy/rBGldg3dlepfWIodmPb27B38kYHwGzn9bZ0yJc9hLQj
         ywoW9p+bcP+szkc9AlZoXNGM6uwhiZGrkl4SjIIC8d6CGyvm/mL4AvZ4Kg/dwLDj2k47
         dvWMJcsaWzI6b9Jq56/ihm9b6maefPBMztrM+agQ1LYYAKd6BvbZk/voVCZLl3vifGZz
         Fb2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfqMw4S7q9FhX1ak7sBxexV1KiwHr7W9OF6g2++CuoJkCtHyHw3pHgbgpp+7W5GI0dOeWE5ZJciwABmhpuQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE3I2uZ1PGRCoyQ1utO0AYRX5UWuHmUxgC7UXSfeAF5llqbArO
	H8SVRw5infwbJ7G3v0U+E4XoX7oVrIpxsCOj/H3kvEXxvh71TyuwyOror8Bt1QD7dgg59F4RQbq
	UguK7fEF7+fyERU5UH9AwxdDoVcG/S8nCs3TwtQWI5OmkFulRItDNiHvQK+nyUfEwTeUClw==
X-Gm-Gg: ASbGncsHFdmiC6NPXz1bXCKbqPrJYC41kj5GIIw7NE7Bqe51fQksvYME72AMZ2OgtlK
	rczQ3jdGAcrKi3FZggwUh8drhHIoHGmp7PqLCahenUjeWuZs/X+kiuAmBfWTKL4svw7rZEgCXtv
	XZZWRrJxRpjQmQxV6Ig6ptrGgHkj1WzN462sdD1ynfCHmkWzIRLXBwJGgH2o87syVkHu4Wy04jp
	0XHYEDqmI1L58212iAP93+8nJ2MkgM3u5jec2gasm6mCrd229LZZM7GnAfWh7aEy+j8PzdeRiqM
	oI5n8fqQ7senGMM9Ipbv4YgTIW8g81c4sICgdDPuV2SsVGQMCwHg8bcAc2tzqRj7KiPOwQu3u9T
	ttML2ML7jySNRKfTatoh9wanvEqxdCqpJ1YzfRhz+hZa7qw+nUcOJIpyIgj7tGgA/f0RRKT+eFu
	43+pGB9HiZXFpy
X-Received: by 2002:ac8:7dd6:0:b0:4eb:a3fe:53d with SMTP id d75a77b69052e-4edf2177a96mr137561081cf.79.1763307126916;
        Sun, 16 Nov 2025 07:32:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLhJkaOMAE2symS5kOW15WypsaRmGyogTqDdNGkh+5TTdpKm+0QEXmKB8gHRw7DCEiCrhb5w==
X-Received: by 2002:ac8:7dd6:0:b0:4eb:a3fe:53d with SMTP id d75a77b69052e-4edf2177a96mr137560551cf.79.1763307126391;
        Sun, 16 Nov 2025 07:32:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804003a4sm2483875e87.59.2025.11.16.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:32:05 -0800 (PST)
Date: Sun, 16 Nov 2025 17:32:03 +0200
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
Subject: Re: [PATCH v1 1/2] drm/ci: uprev mesa
Message-ID: <2obhppq6a4ercfnhvm42tbbgh3xut4lz66fc4j7mpev5oxxno7@dydu2wysmgvi>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-2-vignesh.raman@collabora.com>
 <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
 <42v64xdsaqug5yy76yel4tukh6wkt2tp237vlnpteabyl5qjo5@iigtgujvecwc>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42v64xdsaqug5yy76yel4tukh6wkt2tp237vlnpteabyl5qjo5@iigtgujvecwc>
X-Proofpoint-ORIG-GUID: -7UUVIrJo2MkFJGihq9f19Em_8aReck6
X-Authority-Analysis: v=2.4 cv=N6ok1m9B c=1 sm=1 tr=0 ts=6919ee77 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=zodt2Hv4yxvvtHnNIosA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE2MDEyOSBTYWx0ZWRfX5uNq+pNU9aXY
 hsxBGJ5IiBwLjXtm/U3BMxabR6kZZHn+We+fXYKgpj1ZsF4xpyKrnB754vFwRJG2NfA1fP7vp4P
 hMJaC8RDXVkaI9OnE86Pjncv3fkfXpfsXCQullzZD/pzJR4KsKwpKMhOhnnAxppsuSYoGQ1jGbY
 BfWeC3Z3QZdoo4ENrU1/ub4YGQWd93TpXGf4S7vz7uxXGtx2lytghJc1K92v1ySQZdezE+TisJo
 wW+2gj0eqQkynDOV2U6kQ/Ibr+yD+JIP+rSu2AWjH4pDilkls2y5elZjqvjVXfSLfi/6KToylVd
 7qZQTiM8CczTAmT5J43TFhKMq0Aed8CeTWY90K/mI0jW1wsJamPZ/p9MDdGKJhn+I/GoDwrK0lD
 hZHr32m9vqfBtnh/r4EgaS+yrHMXHg==
X-Proofpoint-GUID: -7UUVIrJo2MkFJGihq9f19Em_8aReck6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511160129

On Sat, Nov 15, 2025 at 05:55:17AM +0200, Dmitry Baryshkov wrote:
> On Sat, Nov 15, 2025 at 02:44:56AM +0200, Dmitry Baryshkov wrote:
> > On Fri, Nov 14, 2025 at 08:30:50AM +0530, Vignesh Raman wrote:
> > > Uprev mesa to adapt to the latest changes in Mesa CI, including support
> > > for firmware via LAVA overlays, removal of the python-artifacts job,
> > > split container and build rules, use lava-job-submitter container,
> > > and various misc fixes.
> > > 
> > > Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > ---
> > >  drivers/gpu/drm/ci/build.yml         |  22 +++---
> > >  drivers/gpu/drm/ci/container.yml     |  28 ++++++--
> > >  drivers/gpu/drm/ci/gitlab-ci.yml     |  95 ++++++++++++++++++++-----
> > >  drivers/gpu/drm/ci/igt_runner.sh     |   4 +-
> > >  drivers/gpu/drm/ci/image-tags.yml    |  22 +++---
> > >  drivers/gpu/drm/ci/lava-submit.sh    | 101 +++++++++++++--------------
> > >  drivers/gpu/drm/ci/static-checks.yml |   1 +
> > >  drivers/gpu/drm/ci/test.yml          |  18 +++--
> > >  8 files changed, 186 insertions(+), 105 deletions(-)
> > > 
> > 
> > Thanks a lot for taking care of it!
> > 
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Hmm, this causes a lot of failures, see [1] (note, the run is not
> finished yet):
> - On some platforms (msm, rk3399, mt8173) the
>   core_setmaster@master-drop-set-root test fails. On other it seems to
>   work correctly
> - sm8350 seems to have some issues with this uprev, it cant' finish the
>   jobs at all
> - mt8173 and rockchip:rk3399 seem to have other test failures too

I have fixed most of the fallouts, see [2]. But ideally this should be
split into two parts: fix before mesa uprev (I think some of them are
already there), uprev mesa, applying necessary fixes and then enable apq
jobs.

At this point I have no idea what's wrong with MT8183. Most likely it
needs either a DT fix or a driver fix. The driver fails to probe because
it can't build a sensible component chain.

On i915 several tests kill the hardware, making it timeout all remaining
tests in a bad way.

BTW: I see that for some of the drivers we skip the absolute majority of
the tests. What are we actually testing on those?

> 
> Could you please update fails / flakes tor all the affected platforms?
> Also I'm really interested in the master-drop-set tests. Why do they
> fail on some of the platforms, but not on all? This seems to be some
> infrastructure-related issue, since exactly the same kernel with the
> same IGT passes those tests (at least on msm hardware).
> 
> [1] https://gitlab.freedesktop.org/drm/msm/-/pipelines/1547684

[2] https://gitlab.freedesktop.org/lumag/msm/-/commits/msm-next-lumag-db820c


-- 
With best wishes
Dmitry
