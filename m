Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DD42B750
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904238; cv=none; b=FcOgugfakBQzYXujZCvlecJhSspiltIp8+4YYo01uSl6dGyR6F2+wJkzrERDWL2369Pk+uqd21s3LNT+6CRmpzvWG/RgzGQMHyZ0LGdFpdKIqF09Us2pw8EsmEJubFxrqGISvMpYR2SxTWD/sQAjhY2JoBv7xKdoos2IZ/I/YPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904238; c=relaxed/simple;
	bh=7S3y8xagN6M8BKCyyfGlaZamJdaKETfZUvOcAw2ZrRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQY8e8wfm06E+mipyMLG4S6pvfbDZJ1RV9D1WJPKtNT3nTWp49roPk48hyyuVCKXIdFqy4mjJvQrdWen6XKvY4yyBwiinxM1mDKoB92Q32KJi2AochZvCYzAEBqspnpUEZS3wHYUsbxodUDv2bCgglYjke/v93TkT2KZt/v1lJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=QW+57uW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eSiSydMD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="QW+57uW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eSiSydMD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7ED137A00C5;
	Wed,  1 Jul 2026 07:10:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 07:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782904234; x=1782990634; bh=aV1udWJKCU
	U1GwPfHpaZ60j3LSXApxKguDyoKA/vmos=; b=QW+57uW9HkfmdAevZYO6hNk7MU
	UJ5sUmzE8fkopzZhgRGj+luurUcYgCvd3qZFha/IXpF0cLdE/oIKeb6sZ5i46YCj
	5emNlfzej2MAwN3QY7s/8NkdSGhMOo4AAizT5BYwo2NguJXSk8c1qkV211JgYXh2
	jSq3zVEkai0h2sVv1BwzKc3DOcoZyQSLtkSwFz6BFoglb0QIhCjZpzxs/ltwpaIE
	fjChZA1uhE1kAezoEOXdPcweATd4paWCMi+CwfNAanD6V24Kslq6TPIxhLJAWV+G
	MuNrDnVeixwfMpfNkoZ21A+UCl9oAUz0P+9VmuSXuxktNiiUEkZOuRDC1ygQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782904234; x=1782990634; bh=aV1udWJKCUU1GwPfHpaZ60j3LSXApxKguDy
	oKA/vmos=; b=eSiSydMDQX+CowDdO1PT2dJ4kfskM1dFh0Doj9OX0OCYOAihpXF
	ZeibHsZFyz87p9Em1hrHeX0DroYFK0wHCFX3JopmBEn+KeGbJOrMo+PEsXQVPFVl
	fGVlee6qQuvAD/f0e2Q4MYK4Ae9yl+Gp96gSwmZQp0FTSjOI34zGDJ1uvtArd+6G
	J7k+wPfwq+pJ0aqDNAQh1ptzhDj4lXoEkwGDgrGTyADks6RZ1q/5grIMiiqMtcUE
	nufXuPtczzs7piIA15Hwo2wTIr12uFH93G6vbUuoLxib+JKeETLhFpyvu/yDozE0
	y+Nz1S5YSVJcGtBuIBCzb5xEhsdPZF1PZcw==
X-ME-Sender: <xms:qfVEatKm1aXXEHE303YNA2PUrc25rodnYQor9-iRvo29jooz1FNI3A>
    <xme:qfVEaqpPUjgJIq3_47vyuMnQ00TESnC8o_JTItLbgikeGQ3wEMPyW6OKOKPhGd1is
    ZA4Q_vAafTa4oQF1RLhh172o07K50-iokaJJBr4swezozSDM5wCAFo>
X-ME-Received: <xmr:qfVEajWA_O2-QqAFaqCpU9FwyaS0-MLmm10c1G7vfC9NzwwHgjZsjw3o43MnJHlcjNaqMy-21VCXrGKI796p_s1VZKPy>
X-ME-Proxy-Cause: dmFkZTERqKoBfc/660oCSojHU9/SahCQW6mKBxxdeYT0+nBWOqFVsHBZmsJVHvgH4XIkH0
    WVE49E+VTNq9R+eiYDJYve2ZKe6OZIhKglB1jc3zmSAueayuV8HqfK6ZyQ9nt2QhlXWvja
    LHP3ghuQ3l9SohPnRuM/K8LPcGydiCqCY4Vw4L+NZIeiHsNPp8VGvk5HzCpLsdiuHRtIOj
    ZYDq5fWPjOZ8cv+ZCPV2BZLsGD2H5KZVMBTCcPT//PmmhmenrhZQygy5ZD0374FLiZhAvT
    Rk0QWiG1Ajx/VqzISEaV4Fwb/mdDeP37Qg0xv7GKXNJpvHvcolnHvTam+Flc4B5H9btkab
    oZTeeANG0QjuSES8h0etk+NW8ahCKDrnKAMEzABd+abkZCgAJnGC4ZZ36JQhULfyz4t/R/
    Mid+zwmSywn8KeGSdwZi1IT62S+KmP+15qYQ8Rq/4WA7lLdQwmRDy06DLKxk4P1WrbW/c4
    I11UbytksuyooyzSnwPWJdxKhtip9iWCdjr8oY3+NkyDYOOeNWp1DHIm6X0wOh2Srq4iWf
    C7TA2ugoLtXz7XwJ0qSGgyuv7sN5jdzNqg0ltNLS+z1brLS25CN1K1NZa46X4OOLqlixvH
    1XbGVoPDVwDjq01s+R9TtrKnqDUUPVZkUqv9JyKNIGioq7GaG4BXqirMsf0w
X-ME-Proxy: <xmx:qfVEal3nTWN5TeHEG8lJcMKhZmFjdIUnjVJqjVz9ZesWMrNGP_tRIA>
    <xmx:qfVEak2s7dLo9JoXzMqVXr3HeEzUb6YuUPva27Jl_Ew_9Qqg5Rbbww>
    <xmx:qfVEakmqmj9felDYsy4LsvwqHjenJ7HmQCbCU1kQkoPXZ7zAY1c2sQ>
    <xmx:qfVEalOuPrV8Fj1nrihgDT9rnUcMOcAag_Abwml9jtxPROrHnwfdDA>
    <xmx:qvVEavcuy1T6xkNV9ogLod16gd1KlQstRTavPeXIyOhz6dCbRLho-zz->
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:10:33 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id C540B842E150; Wed, 01 Jul 2026 13:10:30 +0200 (CEST)
Date: Wed, 1 Jul 2026 13:10:30 +0200
From: Alyssa Ross <hi@alyssa.is>
To: Sergio Lopez <slp@redhat.com>
Cc: Chia-I Wu <olvaffe@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
Message-ID: <akT1XEW766c7Imst@mbp.qyliss.net>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wobtd2eeewguko6j"
Content-Disposition: inline
In-Reply-To: <20260428194450.518296-3-slp@redhat.com>


--wobtd2eeewguko6j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
MIME-Version: 1.0

On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
> If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
> aligned to blob_alignment. Validate this in verify_blob() so that
> invalid requests are rejected early.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>

FYI: this change breaks crosvm, which is squatting the 5 and 6 values
of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
crosvm bug, so hopefully it can be taken care of there.

https://issuetracker.google.com/issues/529852979

> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c33c057365f8..d0c4edf1eaf4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>  	params->size = rc_blob->size;
>  	params->blob = true;
>  	params->blob_flags = rc_blob->blob_flags;
> +
> +	if (vgdev->has_blob_alignment &&
> +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>
> --
> 2.53.0
>

--wobtd2eeewguko6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCakT1pAAKCRBbRZGEIw/w
opdTAP9Jg7Ks4gxxyhXN2k9emUgJfzKrC6SUa2yUEFCWEcE1LwD/UUuIJbEO4Vd3
IH8EBm8oektUqbiYA9e0FT8+x9oKCA4=
=g71s
-----END PGP SIGNATURE-----

--wobtd2eeewguko6j--
