Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F62222AA
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763178926; cv=none; b=BtUX9XLakWPA6r/ygCy69diMdkA8IzdrbX7ax9c1qndUy8ERZMqyELPOW2erPLQ2sgXtKXHemTQd0ip3dpfQK6h+BigNc8fwEAGt9RWkVZa8a6+sn99D/57SVtn6TogdUmN3tCChFKlcgx5FCXt3Ur1xlgBiwyphWY7ExNbIN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763178926; c=relaxed/simple;
	bh=bSnaxQSmmizFstlMQXtunx/ahtOr9ZdNBIJJWbzQY+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c91aQZ6+xAnQhv9CScaUT+/Qkd5ywzZilTXyyx9NKqWgEnOy/H3UTRp66dQzvjCUizECwYrxd8fgBGqqs8QHmmf1YRxe6S9930BilbIxTPmMFkd/Hndadn4XvpaWpfV9vdOImIGINUSYIH0gceOFGsufCZJAhLNFcWw/MBD3YiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9xyueey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HL0zuKd/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9xyueey";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HL0zuKd/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEIQ54X043087
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 03:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kpUJE4SYKU9ynxkJ/T5JJhpa
	CqT/i8ZykNmysQrjF+s=; b=V9xyueey6blpzm/jfavsSbhlfoxZqh6ziY9GLiVo
	pRLERZ2MEX31+yuGsAhlfVnpx49LUnkivh7VOeVkX+iEZCpUszfAr6RWAvx/GoxG
	ZijhYK8E3mzyIqhG1hK2L5/w9DdedzrozrD9Lv3PvXEGCefrjA2nK2F6EPnJkN5Q
	59YLYTARTJ+Imk6JfdjaS45qa6wSMYck595UYohLzKOGwUnrjp4w0vmLrwRUpeB6
	SYq4g3sGHee1nq0e3QSLce0NkDu8LM1+cCMEAkTcfdWp6FkDpecyTGsY74vra0rZ
	jqFpR49ENgMSjHk8p1Xtfaa+aw5Hd9R3LM0WfZoyiVfmLQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ae3t9tajh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 03:55:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-880444afa2cso39186336d6.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 19:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763178923; x=1763783723; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpUJE4SYKU9ynxkJ/T5JJhpaCqT/i8ZykNmysQrjF+s=;
        b=HL0zuKd/Pv5SAdzCFejFE5bi2kiWb5bRHogy+O1grCGqeKREdmbJ6UG92WrKnxkEFZ
         t9xhBG9iovSOWRhT6/wTSuslaK9Rqhk4KXpfaH622aSG8qo5ab3uFzrYYbBIJmI+M6OC
         JAAK1zfjo2chrPnnn8hpJ9JqVgHpjiNEyDJjYb+jvVZXXyJVgRpQI2d0EPjAEnBke9oZ
         HbYttUYAeGMhMDM4in66CaNfsrNwcg45KvCkJMuFYzU4Ygu7GilHgtXC0EwNGWt4Psox
         qw/5xLu0dDMY86irn/bqfo+NCyNWHNx3QJutqZ5FsXZ/LKXQrl18ahqCSmiIa3NoDxei
         qaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763178923; x=1763783723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpUJE4SYKU9ynxkJ/T5JJhpaCqT/i8ZykNmysQrjF+s=;
        b=WEdqfT8eJR2N/6F1lD/BaY7nJDSlpobuuKztJDy3mC74pxMfhzzVeAl/vKx3vM8cmA
         vPff1Pxa94RqrzsaV89FJ8c1eeAa8ZRJjq6ASdLcyTLbxipBoIIdjSUIjbF3GDIN8BbU
         TShP102nWMewNnekpjuEEpgolnQddQOOMaXLcBW1YF9/SQD72OfBWroxRCC5qsXls0jq
         7n0sR+hRiam1YFS8C24JO6RrI9Q/0ts/D1TnzznvPN2rMk2y6MPDQ1TNgT433LYAyEQB
         ejswUDsOOMiD6FGPd+bGExUFhVZAH6oqcn1CitoHXda/EQxpO2JdiYZ9bLZJP+CpKcC3
         BGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwT00WV+kCU7avNIEu/PtxvWMxn24lwY3xxo2jeBqjIIXkUvbP62IUtLOJblZ36TmVGOUeeMX3SDlyEOR9lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUgfBtblJvthfSN5WJUEHFU09WOwzCEKWlqQxzWsBzX4+o+iuZ
	2DHQgxPmqfX5V+rat/REbHrkkbLNE+2fhHO19s/Wokbvee22Vdth7OiU7n11HLEiwz6IbD9uxKD
	UYVAlKzVnZic8AKgKHyiUKbhnwOD34LbgYnE+URadN1d+YJHpkaF97rfUJ+K6aj+1Yrkkww==
X-Gm-Gg: ASbGncu7V9WPJLIFT8cmTRebKTVKaJrjuk4M0er5awJotZeRTQT+nhbGyCcqQL9p5r6
	jBgX9GkwF2W9wBN/JRJC5McTgUY41g2ZFK6TozmIhuOqWTX4EpfHv6e1EA7kRaAqVGgFk0L+3Ov
	iX+ghvBsLJrY1nKo7/2/vN43F2FiutbjsyK3ikGZqM4gB02afACSZmEW7yVhKNZ2z1fTIVvURa9
	BvGDv8qCcdI+1AoxuOum1CJeaXoMwFuMvRt1OXzKKvE07zMLnTGDPkHMCeA/lvHvH5RP7Pvallq
	XaLUbWE4qM/NATjxeC/PUOu4cltoJWM0GOVgEkQofk5p3UjfNEDjIPx+NgVK5n7HGf2TkkQ9C4w
	OEDcgBKsIQntB+ITzwyMdYoMw7wXUQuxIAJGNJ6bDNZSQcvDsCix5UWAkpXKPRtgYuQ+wIk7ujN
	g/TvOGY0U89ZJX
X-Received: by 2002:a05:6214:c65:b0:882:4dec:42b9 with SMTP id 6a1803df08f44-882925f280amr79893416d6.26.1763178923095;
        Fri, 14 Nov 2025 19:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH21xNZD/1SaQbAJXQ9lzSs2ET/wK99qDySnRnPvmoMPz0h942r+lDos6cmgLn70aSgdH9ifQ==
X-Received: by 2002:a05:6214:c65:b0:882:4dec:42b9 with SMTP id 6a1803df08f44-882925f280amr79893116d6.26.1763178922595;
        Fri, 14 Nov 2025 19:55:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5958040c7ccsm1449901e87.100.2025.11.14.19.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 19:55:20 -0800 (PST)
Date: Sat, 15 Nov 2025 05:55:17 +0200
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
Message-ID: <42v64xdsaqug5yy76yel4tukh6wkt2tp237vlnpteabyl5qjo5@iigtgujvecwc>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-2-vignesh.raman@collabora.com>
 <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
X-Authority-Analysis: v=2.4 cv=IOAPywvG c=1 sm=1 tr=0 ts=6917f9ac cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=E-Vn-V3zxCEcjh91BPMA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAyOCBTYWx0ZWRfX2QCY8BNdsaos
 WpltrEDT6tVzNAnawSGIstanM71U2CO0MpE0pGq0McpBPruurou35fgZ5rRuqSe/snfGMdLQqur
 ipdyC4uKUq/E1TcH6/Hcfqkgj4z303OX8YAinOD1YSmD3kwyQOjxZwdmGUy79MvXZS3MNJgSBPL
 Ct2sdxvYz/L+0dq5wc3pESVrwpiu/eFnEkaBJOfk9y9gekBXhd7mIsIz8cV5XqDuhkAjjOw1DMG
 Ma9IlXokCdt6IWfm1WJas8+YVob0v26uWtpME7kA844sycq9qEYOMfqA6rVrtDI5yN+vdxNLlBX
 D3GaTrXiJctVuuFRRWAnE7Ndsg9eYuY3uUS4bQdXsFGmX8ZtdFm8gjclzGpHRuMXyD/skERy6k6
 bA1JbTtaUbiS9UV0Hh726w7j5dROhA==
X-Proofpoint-GUID: RS4UoljLVs_TRtn7XXMF9LOeNZZ5yihX
X-Proofpoint-ORIG-GUID: RS4UoljLVs_TRtn7XXMF9LOeNZZ5yihX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511150028

On Sat, Nov 15, 2025 at 02:44:56AM +0200, Dmitry Baryshkov wrote:
> On Fri, Nov 14, 2025 at 08:30:50AM +0530, Vignesh Raman wrote:
> > Uprev mesa to adapt to the latest changes in Mesa CI, including support
> > for firmware via LAVA overlays, removal of the python-artifacts job,
> > split container and build rules, use lava-job-submitter container,
> > and various misc fixes.
> > 
> > Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> >  drivers/gpu/drm/ci/build.yml         |  22 +++---
> >  drivers/gpu/drm/ci/container.yml     |  28 ++++++--
> >  drivers/gpu/drm/ci/gitlab-ci.yml     |  95 ++++++++++++++++++++-----
> >  drivers/gpu/drm/ci/igt_runner.sh     |   4 +-
> >  drivers/gpu/drm/ci/image-tags.yml    |  22 +++---
> >  drivers/gpu/drm/ci/lava-submit.sh    | 101 +++++++++++++--------------
> >  drivers/gpu/drm/ci/static-checks.yml |   1 +
> >  drivers/gpu/drm/ci/test.yml          |  18 +++--
> >  8 files changed, 186 insertions(+), 105 deletions(-)
> > 
> 
> Thanks a lot for taking care of it!
> 
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Hmm, this causes a lot of failures, see [1] (note, the run is not
finished yet):
- On some platforms (msm, rk3399, mt8173) the
  core_setmaster@master-drop-set-root test fails. On other it seems to
  work correctly
- sm8350 seems to have some issues with this uprev, it cant' finish the
  jobs at all
- mt8173 and rockchip:rk3399 seem to have other test failures too

Could you please update fails / flakes tor all the affected platforms?
Also I'm really interested in the master-drop-set tests. Why do they
fail on some of the platforms, but not on all? This seems to be some
infrastructure-related issue, since exactly the same kernel with the
same IGT passes those tests (at least on msm hardware).

[1] https://gitlab.freedesktop.org/drm/msm/-/pipelines/1547684

-- 
With best wishes
Dmitry
