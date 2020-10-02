Return-Path: <SRS0=l9dZ=DJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C256C4363D
	for <virtualization@archiver.kernel.org>; Fri,  2 Oct 2020 18:46:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C2520758
	for <virtualization@archiver.kernel.org>; Fri,  2 Oct 2020 18:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LhoHpieZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C2520758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 11F14203AC;
	Fri,  2 Oct 2020 18:46:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqJwGLmYyfUM; Fri,  2 Oct 2020 18:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 780D1203DF;
	Fri,  2 Oct 2020 18:46:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57BFAC016F;
	Fri,  2 Oct 2020 18:46:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99BA1C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7EF7A86C7E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ntxg77HoCp5e
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:46:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E30686C76
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:46:01 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e16so2869625wrm.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Oct 2020 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=cqLPfUuqb60ZIVoOQ31hnraU/Ifr39O5/ULDkN9IWmw=;
 b=LhoHpieZ6b1yu3Bgv5UVyYwE5gEJCucfXpQtCsua7dxm7nPU5GPxUoM22UNQQ6v2CK
 k0Y2QqxCtl6jlPSAgvR23+rIu6KvQsYlEl3KTS7hhk4KmBbGsS7srplNima8l2683HV3
 M+RegCjSI+WIRGmRnHJIv+DYHNTbkSdc4/ZqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cqLPfUuqb60ZIVoOQ31hnraU/Ifr39O5/ULDkN9IWmw=;
 b=U7P5JVDom7PucxRBRv6XLPqDSg7e2JGGYVux6DOOXGfNPNJoVRLPsecrA20hgAgDW8
 qW4lBnjnyuwk8VlLn+MT/VJVNMD/5vI2GPPSsau2aT1PFj2Pc7Zmg9oTx0NO+9uVrjA8
 GeaNA3aYnfQdCBKIDxjxFWm4R5GhWsTe0mgXMe4xUpTPZEFauvtmhi2oFifEge7tXYrC
 mCaKLiQusjy7xTaNHIK6ozYuPB6n4BEE382wIKuD/fymVHiMfnkQUL/PwO3EmE2h0sGf
 K4HwQYiHqaqGVR1Iqrlg3kRZdSLJ4E+HspcMnRS7C6VxWkCTsteR0xeT1wwxVjnRO/kI
 1Qqw==
X-Gm-Message-State: AOAM533UYHHQV6fRofy2dnkJhxYtSyrtA0mm4I8Asa11QSRk3fIbYXcj
 lBgtu0QmXDxsIfD3qpJzZ6bFUw==
X-Google-Smtp-Source: ABdhPJzgHPhBsD8FZtMDQrfMIjGL4qmZj/8xNAuAHXm+0qz5n2h6pVB3S7OCKNZbK4qjctoXq1cGGA==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr4528517wrq.297.1601664359823; 
 Fri, 02 Oct 2020 11:45:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id n2sm2937452wma.29.2020.10.02.11.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 11:45:57 -0700 (PDT)
Date: Fri, 2 Oct 2020 20:45:54 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/7] drm/todo: Update entries around struct dma_buf_map
Message-ID: <20201002184554.GN438822@phenom.ffwll.local>
References: <20200929151437.19717-1-tzimmermann@suse.de>
 <20200929151437.19717-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929151437.19717-8-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: luben.tuikov@amd.com, heiko@sntech.de, airlied@linux.ie,
 nouveau@lists.freedesktop.org, linus.walleij@linaro.org,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 melissa.srw@gmail.com, eric@anholt.net, ray.huang@amd.com, sam@ravnborg.org,
 sumit.semwal@linaro.org, emil.velikov@collabora.com, robh@kernel.org,
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 lima@lists.freedesktop.org, oleksandr_andrushchenko@epam.com, krzk@kernel.org,
 steven.price@arm.com, linux-rockchip@lists.infradead.org, kgene@kernel.org,
 bskeggs@redhat.com, linux+etnaviv@armlinux.org.uk,
 spice-devel@lists.freedesktop.org, alyssa.rosenzweig@collabora.com,
 maarten.lankhorst@linux.intel.com, etnaviv@lists.freedesktop.org,
 mripard@kernel.org, inki.dae@samsung.com, hdegoede@redhat.com,
 christian.gmeiner@gmail.com, xen-devel@lists.xenproject.org,
 virtualization@lists.linux-foundation.org, sean@poorly.run, apaneers@amd.com,
 linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, tomeu.vizoso@collabora.com,
 sw0312.kim@samsung.com, hjc@rock-chips.com, kyungmin.park@samsung.com,
 miaoqinglang@huawei.com, yuq825@gmail.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, linux-media@vger.kernel.org,
 christian.koenig@amd.com, l.stach@pengutronix.de
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Sep 29, 2020 at 05:14:37PM +0200, Thomas Zimmermann wrote:
> Instances of struct dma_buf_map should be useful throughout DRM's
> memory management code. Furthermore, several drivers can now use
> generic fbdev emulation.
> =

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  Documentation/gpu/todo.rst | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> =

> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 3751ac976c3e..023626c1837b 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -197,8 +197,10 @@ Convert drivers to use drm_fbdev_generic_setup()
>  ------------------------------------------------
>  =

>  Most drivers can use drm_fbdev_generic_setup(). Driver have to implement
> -atomic modesetting and GEM vmap support. Current generic fbdev emulation
> -expects the framebuffer in system memory (or system-like memory).
> +atomic modesetting and GEM vmap support. Historically, generic fbdev emu=
lation
> +expected the framebuffer in system memory or system-like memory. By empl=
oying
> +struct dma_buf_map, drivers with frambuffers in I/O memory can be suppor=
ted
> +as well.
>  =

>  Contact: Maintainer of the driver you plan to convert
>  =

> @@ -446,6 +448,24 @@ Contact: Ville Syrj=E4l=E4, Daniel Vetter
>  =

>  Level: Intermediate
>  =

> +Use struct dma_buf_map throughout codebase
> +------------------------------------------
> +
> +Pointers to shared device memory are stored in struct dma_buf_map. Each
> +instance knows whether it refers to system or I/O memory. Most of the DR=
M-wide
> +interface have been converted to use struct dma_buf_map, but implementat=
ions
> +often still use raw pointers.
> +
> +The task is to use struct dma_buf_map where it makes sense.
> +
> +* Memory managers should use struct dma_buf_map for dma-buf-imported buf=
fers.
> +* TTM might benefit from using struct dma_buf_map internally.
> +* Framebuffer copying and blitting helpers should operate on struct dma_=
buf_map.
> +
> +Contact: Thomas Zimmermann <tzimmermann@suse.de>, Christian K=F6nig, Dan=
iel Vetter
> +
> +Level: Intermediate
> +
>  =

>  Core refactorings
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -- =

> 2.28.0
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
