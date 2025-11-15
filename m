Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3E165F16
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763167504; cv=none; b=hIvRcAz8lG0c4uDoRkcp+ohIWWhVt4uoD33BXX3AYs03OWPTSqRMvBn1NMCwNZw994/aC26UiwJR33qN0yMTx0lokaaTBIBvhwDtkCHBJeuy3S86MWX6dDCLD3MGo8sKPA2xMl1p3vi1XZ35DSmQB4W+FyYGQh52s39TTpP4PdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763167504; c=relaxed/simple;
	bh=RfI7Pl8POOHPpn3wIDYOadl1rbDNl3ZzGMDG1gTfGxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+iNR3elBjQxWpyiiNyvi76OfehZtbaZ8x40D+HkL9OP0biL85DZhOgMwKlbYo0sX/faE0M0Fd0kk/EXUoyMJDnNUbUeyO7PD5xB+wnjrWGg1mCwvEuddkOBic7nUKxJtgvAwkwUEQ3Uoafahb51hUhLx28Yua4mFSkqqYuxsT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODckJlfs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HWR8KVYI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODckJlfs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HWR8KVYI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEJLdHe4150237
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 00:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kHSr3Uxb5gfTp8PMcc+9CNwl
	Vz3omOLQcZ4QTy5X+lE=; b=ODckJlfsAxbyXTtcs5Zm543nzNcWtRpWXJwR+uMn
	0BqB/hWSyd4H8OuVqMp+yys58KTOTAThFhwxlyoThmB8gRaCIJKPfVhkcmZd5Kxw
	lfcbla9wgB++EGDkSmbCH3068Oov13I5BCMuM6f94boSl5AY/bvN+c9GpsOuxyr7
	MycHmceYdsDFwWcDa2NG0gHfD8rcfCSOQmWn8NIYI/9uFIivvkXUR12lN1VBKjT5
	Y3HSvqZFPm2DH+IcfCemhPBe1GISzlubXCJjqLHl0l7FtUB6DIxhlggAx+QrR280
	zmVmdjj2viq6ssQ/HDura3pZoLrKjHWEt8PvJRHceOdXOA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aeagyrp0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 00:45:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6855557aso96294851cf.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763167500; x=1763772300; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHSr3Uxb5gfTp8PMcc+9CNwlVz3omOLQcZ4QTy5X+lE=;
        b=HWR8KVYIzAQQGWeAxzyfvOAoOZMzDHinvxR8uLXvHn7VWCs18DTP//gpuTkn+sdt6q
         2Ghq/ZMdtIoW8wipEHGdWxfSkUclCxzK0wVvdv4NF1488cg9RsaxmyTgmbA3jRaAS7LP
         Um5YebNMUTINy2lDcKdDj4+574hMqOem8HzFvGSzjqPtblzy4aqypgSEE2hjjDB1jkr1
         bTZdqrvRc+LOaDsa9FsiIE5YD8jFWjMz76xolrC+28VhwG8GH1XpRVwLn5KVKGIpWf8b
         QfZV8MYFfpnTvlagzUkOjeXIFEkQWOc5f9JhnmnK9rP8XqM6PT3zjyvQCEFzT/nBB+TR
         GIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763167500; x=1763772300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHSr3Uxb5gfTp8PMcc+9CNwlVz3omOLQcZ4QTy5X+lE=;
        b=ADid5qK9IZyJ2RKobKYy6xtY9sRr5jbRWPLViVrFgA9e/9XiSbg0aNLfq226gxwGxd
         iXJaqrh3mEPZfRFjR6kbJ3rB1XU7t+n8ysvMzEMA/OAwMXy5vrf1yGRnkDHTylTuX4hs
         L7loDXQ/yMupn6wogt1X0klb4QXEd2BRVLHISvvdInMxaUb0roDMGHoFBFhS1KG/YLrM
         lAG7mKZqCQCWAG8unEUlVhWjg5odx2uYWmG68I9KJdoN0Wuzu5wCn822HETZOvEe0FQW
         otNlui/BHKOda5NroQZmhWbiX6YWWsC5tdoSEEglfKoryO0Un8y3KkTwGr2i0QUPCyxz
         56pA==
X-Forwarded-Encrypted: i=1; AJvYcCVNocWeUpQL0KXiP+fF56T+Gi6LorUxxo0FfNzWwAlwnLDYsjiKlwAxwuqB+ffahk7y+ptMtj+yZkl0CcZ+Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAXsPgMHSvX3kErZUnSh5xwYQAJIsVgN+Kk1g7of8vP5xO6DK5
	HMZk3L4QcUjxdzdtv2zKoEEdwoIGGJ98w8pwAuemYNm69z3TSOZxvfrILRGBzwXFsQiogfc6q0t
	2u41k8Cxt2b38dVhbAV9N1fMvF7Z+A4LzbiCP2ofwZ65w+h9Te/msWKAqW/mrAkhH5zv7Mw==
X-Gm-Gg: ASbGncukJycxfFmnAVLT4pZCRZmob5O7JDrrFdrVGfGSKm3kIR1xfsfOEyjVr8WJNm3
	/z8upCkwgcl9ix6h5ftskwQ2Za+yJV3/3ZFFUV3hDDkuHF4tMDo12wSQv+D7L4tIPGCrfWBVKUU
	LFFpQp3Ic6L2ezOnVx7Rok+GNONxP9D7+P0nBkrrJRKf9Q175JcxGtPcp16XN51ZRmzbqyJ2eGy
	YV6LHfbIXT9bCKrUlWfHbnVIq8427Jrl7yU8sMXUJnljKkIQz07kJHXpQKIN6wyslENHINp8ILg
	OxGe2oOdxbbvqokyGpcPqcoiWcRe3EO3GGfqCVXAdkSOTmA4fuqvPY4ohyHsWEnKC3iAqR1e+yG
	RZfmHwAH+GhEcvVMVLpXdmQgdMlICgF1+E9i99lq2RxY5a7BpfFjQQPBr76FHSxgUnOKFTGjK41
	0nAnbflLXpOjG1
X-Received: by 2002:ac8:5dd0:0:b0:4ec:ee54:b141 with SMTP id d75a77b69052e-4ede70699a3mr106378061cf.26.1763167500264;
        Fri, 14 Nov 2025 16:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTsDRVIqLn1VpOlz5z6xTpaoGY3LMTcHDBpzhVsFe6h8FITQwTVx2wdmRWmkQbySXE0rNnig==
X-Received: by 2002:ac8:5dd0:0:b0:4ec:ee54:b141 with SMTP id d75a77b69052e-4ede70699a3mr106377841cf.26.1763167499760;
        Fri, 14 Nov 2025 16:44:59 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce1577fsm12961501fa.17.2025.11.14.16.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 16:44:59 -0800 (PST)
Date: Sat, 15 Nov 2025 02:44:56 +0200
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
Message-ID: <prjwrsepfc3b6ozhue5cp66khlcvdrpvpy6jkk23edncmi4l3y@oiddmamgg3mx>
References: <20251114030056.1139570-1-vignesh.raman@collabora.com>
 <20251114030056.1139570-2-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114030056.1139570-2-vignesh.raman@collabora.com>
X-Proofpoint-ORIG-GUID: pPw_yptL1LiKCHKvYqtfOrjra62jb65u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAwNCBTYWx0ZWRfXy7qphT1RABu4
 D2iKN83hUK2bx/qHVvnuMR3295v88D0lovTGa9K/ZIY9iVEK/XzxS4LKFndoqqce/kJZWbwava9
 2HjJhLLyH/n4Qk9Qok2+hTRiEQZrB1oi6CaLh2vjgEtr9fa6eGjUnUZ0guFxW7189Xa+boVLOf1
 epYkhGvS3TjvE/HTR1dvDlni3Gee/zo6IMNS0HZLEf/AwIqpjIZ6UARsB6+umZdne0Kape3NTOX
 mi6n1GcpXgOpcIcpnuXJuaZqtZe09eDMGFgu/J5LsTs5mGrpFO0rOnMME+U1vwDRtvjRYtllYFb
 nxXhIdGS69Qzj4YsaVDCSKTyiT2Sj+83lzagloV7VRv8bOpYzPmks0HVlzPZU74oGk2DFf1nBtZ
 1DXBfKrL5b1ys6aR7t8AHAgLyQto+A==
X-Proofpoint-GUID: pPw_yptL1LiKCHKvYqtfOrjra62jb65u
X-Authority-Analysis: v=2.4 cv=Go1PO01C c=1 sm=1 tr=0 ts=6917cd0d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=H-B6EOQw763qFByNOf0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511150004

On Fri, Nov 14, 2025 at 08:30:50AM +0530, Vignesh Raman wrote:
> Uprev mesa to adapt to the latest changes in Mesa CI, including support
> for firmware via LAVA overlays, removal of the python-artifacts job,
> split container and build rules, use lava-job-submitter container,
> and various misc fixes.
> 
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/build.yml         |  22 +++---
>  drivers/gpu/drm/ci/container.yml     |  28 ++++++--
>  drivers/gpu/drm/ci/gitlab-ci.yml     |  95 ++++++++++++++++++++-----
>  drivers/gpu/drm/ci/igt_runner.sh     |   4 +-
>  drivers/gpu/drm/ci/image-tags.yml    |  22 +++---
>  drivers/gpu/drm/ci/lava-submit.sh    | 101 +++++++++++++--------------
>  drivers/gpu/drm/ci/static-checks.yml |   1 +
>  drivers/gpu/drm/ci/test.yml          |  18 +++--
>  8 files changed, 186 insertions(+), 105 deletions(-)
> 

Thanks a lot for taking care of it!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
