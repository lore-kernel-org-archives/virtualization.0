Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913C13D899
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458392; cv=none; b=iCKt4HP3OvoYLtVn3+1RcnObmicE7MX9DEIqaOSioEug+PsicSfbMCEOjmB0d++sdJenKTRPKMzM0Ur5BjF4O8gnW3r3lUugUdqnEnrvLtiWj+slqi0qcrPpJcK+Njwqulpp8FDFEKORxupkRAicIOBiSSdzwkCLh5zS1WagmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458392; c=relaxed/simple;
	bh=+59I1LMHz5513L5Tt9Gn+0+i8+g532fE4EtvdMuItaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug7zsOxEvpZoCRhioySxCq2GmCgEvduBIEncZ+ZljF05vXHeeXpCPAJHDNjOq68A6UX8lsTaYJr4Rx68HE3x1aAK73A0tiKdbZjw9fQnIY70ilHeUINhgMWnsRf3klbsbbJcRoszwa9piWeRfZUNjMehryQK+SLTbLm26YrLozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NvKZkGmU; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvKZkGmU"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80FAE60762
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 09:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dw_Ki_QRVu4k for <virtualization@lists.linux-foundation.org>;
 Thu, 23 May 2024 09:59:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2e; helo=mail-yb1-xb2e.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0C95D60678
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C95D60678
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NvKZkGmU
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C95D60678
	for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 09:59:48 +0000 (UTC)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-df457d734abso1955506276.0
        for <virtualization@lists.linux-foundation.org>; Thu, 23 May 2024 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716458387; x=1717063187; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4eLg5W63v6nyWYGdaPlQGL+64DpELLePyMxWT5qrNUU=;
        b=NvKZkGmUo0OcU/FLaZlclFE6H5ONCaLxR4dCGmH/FfXBfPPe93pm8OxP5DQtzIB2dk
         wBhtbqgKtxk2Qy9EruxzDY1Q9z5egKlNsRvEPJFYIGaI4ZJueRwHza1qRUps6lxcIbfb
         1Z2pjwSoadoXSEfvp91w751emxuMWpkKGReOjB8q6TWml+Ts+FfasLo0XXWnQzsiVbHk
         nogg87Ew2POKVYs40L65vkCqgDmovIA4bLd0IDygojNwS4I+KnKsP56j16mEsPh8oFur
         eHxR3rCllRP23CJeVOlt0Xe1k8EHUC0KSwrIG4lRmgCgCmWw4PxR0sicOxNWvPDxeYn3
         el5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458387; x=1717063187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eLg5W63v6nyWYGdaPlQGL+64DpELLePyMxWT5qrNUU=;
        b=BE9ONay16gsS+nQNCDB5Ah1qasZ+A5DXr3UFSLaUcVMG4XO9LWweF+GSKlDnlvQl/P
         1axhiD3gA2Pwjm1oO3UMQfSKlQs3BTV7iCKUx6iu5bbvFmUBm3rVsCfoIjiB//R4TJ/u
         PiamUzVRRNFD1lXKQzxtL5vczBSWGSwg9Z0SqOzZg9g1japwiPTrfkQz5cMCrrYPCqwt
         PJfyRpL1WJ0ZfdlleuV3d/dEaxVQViuCZlbYT+ITaOkYvzJrlfsZYFO0FIyJYPU7mNht
         0s1se8miXTYKqIH0hoL03Fm0DQ6EADKj6DaESD+gsIdrirx8bB36Upf9eJSj5+9GwN6q
         iCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpRpKW4wmOpyfOwIgf/8GYw7BNNCWUNNh8JhXZCJseM7YJuW1xzN6RzdiGCb1TTsR+ppHa3pOOnbIHtl6siITeDLekCQQmW8MV3tAFN0njgEpCYYoQO6WEAQ==
X-Gm-Message-State: AOJu0YzVdCu2A2SqG3M94n/Ihp3nQU56rBgXbSGHMSQlMNWANiF4UjK/
	j7HqWONWsUD1VeKE8xOGdo6/6gGbgkGJwForADWj6McrLgREdHI9jpMiefth/6l3aKxHXb33nH+
	DxVJOdba9DyD/aRztOwcrczCi2VPqUwRelOuWoQ==
X-Google-Smtp-Source: AGHT+IEH2bet0vxbyQkGUI55R017CbgvtHVbrVup5m0zjkPeCkh3N7ZUjMndzd5BhJJAs4TMZp+oQ52G6r3Sss4urHM=
X-Received: by 2002:a25:b181:0:b0:dee:607c:3528 with SMTP id
 3f1490d57ef6-df4e0a9cfa9mr4821493276.3.1716458387642; Thu, 23 May 2024
 02:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-2-vignesh.raman@collabora.com> <2qzmfv3oc6feihwxu3tl37rg6w3qsj2vddu5olvqk6vhqr26cc@bxu5y6ijvtfa>
 <9cd0667a-12ee-4d45-80e8-dc34259bf01d@collabora.com>
In-Reply-To: <9cd0667a-12ee-4d45-80e8-dc34259bf01d@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 23 May 2024 12:59:36 +0300
Message-ID: <CAA8EJprVVkQO7aPkehwL2zhYkGRkm4Foc13ErfuY6ikBA_4nLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/ci: uprev mesa version
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, david.heidelberg@collabora.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 May 2024 at 09:07, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>
> Hi Dmitry,
>
> On 20/05/24 16:13, Dmitry Baryshkov wrote:
> > On Fri, May 17, 2024 at 02:54:57PM +0530, Vignesh Raman wrote:
> >> zlib.net is not allowing tarball download anymore and results
> >> in below error in kernel+rootfs_arm32 container build,
> >> urllib.error.HTTPError: HTTP Error 403: Forbidden
> >> urllib.error.HTTPError: HTTP Error 415: Unsupported Media Type
> >>
> >> Uprev mesa to latest version which includes a fix for this issue.
> >> https://gitlab.freedesktop.org/mesa/mesa/-/commit/908f444e
> >>
> >> Use id_tokens for JWT authentication. Since s3 bucket is migrated to
> >> mesa-rootfs, update the variables accordingly. Also copy helper scripts
> >> to install, so that the ci jobs can use these scripts for logging.
> >>
> >> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> >> ---
> >>
> >> v2:
> >>    - Uprev to recent version and use id_tokens for JWT authentication
> >>
> >> ---
> >>   drivers/gpu/drm/ci/build-igt.sh   |  2 +-
> >>   drivers/gpu/drm/ci/build.sh       |  6 +++--
> >>   drivers/gpu/drm/ci/container.yml  | 12 +++------
> >>   drivers/gpu/drm/ci/gitlab-ci.yml  | 44 +++++++++++++++++++++----------
> >>   drivers/gpu/drm/ci/image-tags.yml |  2 +-
> >>   drivers/gpu/drm/ci/lava-submit.sh |  4 +--
> >>   drivers/gpu/drm/ci/test.yml       |  2 ++
> >>   7 files changed, 44 insertions(+), 28 deletions(-)
> >>
> >
> > [skipped]
> >
> >> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> >> index 8bc63912fddb..612c9ede3507 100644
> >> --- a/drivers/gpu/drm/ci/test.yml
> >> +++ b/drivers/gpu/drm/ci/test.yml
> >> @@ -150,6 +150,8 @@ msm:sdm845:
> >>       BM_KERNEL: https://${PIPELINE_ARTIFACTS_BASE}/arm64/cheza-kernel
> >>       GPU_VERSION: sdm845
> >>       RUNNER_TAG: google-freedreno-cheza
> >> +    DEVICE_TYPE: sdm845-cheza-r3
> >> +    FARM: google
> >
> > I see that this is the only user of the FARM: tag. Is it correct?
>
> No, we need to add FARM variable for other jobs as well.

Why? Even if we have to, we don't have them now and the change doesn't
seem to be related to the uprev'ing of mesa. So this probably should
go to a separate commit.

>
> > Also we miss DEVICE_TYPE for several other boards. Should we be adding
> > them?
>
> Yes, device type needs to be added for msm:apq8016, msm:apq8096, virtio_gpu.
>
> I will add this. Thanks.

I'd guess, separate commit too.

>
> Regards,
> Vignesh
>
> >
> >>     script:
> >>       - ./install/bare-metal/cros-servo.sh
> >>
> >> --
> >> 2.40.1
> >>
> >



-- 
With best wishes
Dmitry
