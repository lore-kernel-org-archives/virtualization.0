Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48A156222
	for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254007; cv=none; b=Drsw/eUiOeS1XRbV/1c9IRU1OO3qmJq/44ZonMz67ZiFV2/kt+lgjQCTDjHQDZjSAwzwRl9w0Dhcmg6z3V7n4+puBEkkyn4uiiXsPIR57ub+pji5C0S9WALVQA/YRftxGq93KIh32NChPkHNDeMVJYqiF2GxFlqqwpPhvSI24FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254007; c=relaxed/simple;
	bh=C2wUdJpLQToS9OTaCbJ+nIjnndPqiV6hDGe7qVUlkmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q71z01BMDJgHHvEdMCnHMZy6bz7iX4MW8EU5I3awfslH6FDwBd1tUkd51kH2MCbhVWusgQ09r5OMvpkm1LtPUY6W8Tdubag5E+0E4/NadLBWOqCeD4tNsmVEjXD8KHUOxe2u73G2cAs7YCEugB0VCufgDCjCUhj2DR3UAcvkCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jJcLTAoM; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJcLTAoM"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so65103421fa.3
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727254003; x=1727858803; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yRGp5lskF2mbtcxmoFpyzKd/BqPva/CreLYlU+Osqs=;
        b=jJcLTAoMe6gDYMkW8bWVeRGXWyMfmPY6WdwzaxV/uvT5yBu9XRntDOm2odm82UuurP
         ExloI/hyPiElcIjT+uHi2b75WNT/VhhqiVPdoqpUA86txPlBYUeU/0IFI7xrHy41d8Kt
         /981dGhfIPs4cA+eq54tCdEsseIZB75M++geVgaZvyLGeXeIghMzQW9rzUgIwtcN7V1B
         Lijw4HiLK3uCLVJd1oX54wrecnSzOQjN/bLVpkfKxytLWXhP98Nq4vzreQVqU8Z8pjKT
         nkZZg97WFr2OUKDSH3t05a7kAq7/SUOAsJ0/RUog4Gx4r5u2PqQUfVFVCCl2olHRo8sS
         Eupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727254003; x=1727858803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRGp5lskF2mbtcxmoFpyzKd/BqPva/CreLYlU+Osqs=;
        b=ZdQqIOlhv/smrnBIYNSP/sXpTsAhNUb4/xQRw7HlQnvJ7JeU/1aYYk6M1t2lkKROu7
         J13/aydnrOJ2EaDydnCHLjomtcDPNVilBlO8OIg2cJmPDswT2oy+sJT2zxZenqVbOoaC
         AESP0mxwdnKNbClkY9tTbegFG8BKaPVmDoJhvlxBGKVk71ci/3mtAUfIffBWgR1pHiF0
         3Usk3BuapRXWn76tmhcJCqd0yRtU7lvPpPDLP2EzLSDeF79jJmDDTncCyO5OA/J0TbQS
         kG39rierwV1JlUvAS5pac1LcvOOh+15Sc+AjwkgPdV94U8dFyxH4bbALEWOVNIN6/jl0
         o08A==
X-Forwarded-Encrypted: i=1; AJvYcCX29hfqfB4fwpjBp1DJr2mUz1gFed9aa6RhlhRpEA9rAQDfCAPeCo1FLlkcVD46EzWEevOcQOkuPkrUfTAvhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxLAH6VzcLDgqphWF+obcVTCYDw8La2LQfoFXcOOIf2duNrBFh
	zKC4C35poJyvqDLh2p0UCNHHcWj3qeqXGsHbEcR2k5ian9qSPei9L+mlrMT2glA=
X-Google-Smtp-Source: AGHT+IHGGuuc5DgIEE8huO5Nf+QqWz4aKGNfwoBxKPNxJBNkF8LnAA0IjcwCRgwvkpbCrrQ5J09w3A==
X-Received: by 2002:a05:651c:2128:b0:2f8:d537:2846 with SMTP id 38308e7fff4ca-2f915fdf844mr12642871fa.13.1727254003253;
        Wed, 25 Sep 2024 01:46:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d282fd34sm4517451fa.28.2024.09.25.01.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:46:41 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:46:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: kraxel@redhat.com, daniel@ffwll.ch, airlied@gmail.com, 
	mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 02/10] drm/bochs: Use helpers for struct drm_edid
Message-ID: <hvf7ws4x3uemp6o5ucwfvmrv6wbtgl2xfb7vvut4qrop4j7b6y@ncqluxhfsd7f>
References: <20240902105546.792625-1-tzimmermann@suse.de>
 <20240902105546.792625-3-tzimmermann@suse.de>
 <2fuwrqk4aeuflsxjr73zj6nyvvmpmiupam4oemw7oxfia22ila@5hehupmjzkhh>
 <c5c1b947-bf7a-46c6-be8e-ddd52d90b707@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c1b947-bf7a-46c6-be8e-ddd52d90b707@suse.de>

On Wed, Sep 25, 2024 at 10:15:49AM GMT, Thomas Zimmermann wrote:
> Hi
> 
> Am 23.09.24 um 06:35 schrieb Dmitry Baryshkov:
> > On Mon, Sep 02, 2024 at 12:53:40PM GMT, Thomas Zimmermann wrote:
> > > Implement a read function for struct drm_edid and read the EDID data
> > > with drm_edit_read_custom(). Update the connector data accordingly.
> > > 
> > > The EDID data comes from the emulator itself and the connector stores
> > > a copy in its EDID property. The drm_edid field in struct bochs_device
> > > is therefore not required. Remove it.
> > > 
> > > If qemu provides no EDID data, install default display modes as before.
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >   drivers/gpu/drm/tiny/bochs.c | 48 +++++++++++++++++-------------------
> > >   1 file changed, 22 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> > > index 47a45a14306c..197fc00b373f 100644
> > > --- a/drivers/gpu/drm/tiny/bochs.c
> > > +++ b/drivers/gpu/drm/tiny/bochs.c
> > > @@ -85,7 +85,6 @@ struct bochs_device {
> > >   	u16 yres_virtual;
> > >   	u32 stride;
> > >   	u32 bpp;
> > > -	const struct drm_edid *drm_edid;
> > >   	/* drm */
> > >   	struct drm_device *dev;
> > > @@ -172,12 +171,14 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
> > >   #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
> > >   #endif
> > > -static int bochs_get_edid_block(void *data, u8 *buf,
> > > -				unsigned int block, size_t len)
> > > +static int bochs_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
> > >   {
> > >   	struct bochs_device *bochs = data;
> > >   	size_t i, start = block * EDID_LENGTH;
> > > +	if (!bochs->mmio)
> > > +		return -1;
> > > +
> > >   	if (start + len > 0x400 /* vga register offset */)
> > >   		return -1;
> > > @@ -187,25 +188,20 @@ static int bochs_get_edid_block(void *data, u8 *buf,
> > >   	return 0;
> > >   }
> > > -static int bochs_hw_load_edid(struct bochs_device *bochs)
> > > +static const struct drm_edid *bochs_hw_read_edid(struct drm_connector *connector)
> > >   {
> > > +	struct drm_device *dev = connector->dev;
> > > +	struct bochs_device *bochs = dev->dev_private;
> > >   	u8 header[8];
> > > -	if (!bochs->mmio)
> > > -		return -1;
> > > -
> > >   	/* check header to detect whenever edid support is enabled in qemu */
> > >   	bochs_get_edid_block(bochs, header, 0, ARRAY_SIZE(header));
> > >   	if (drm_edid_header_is_valid(header) != 8)
> > I understand that you probably don't want to change the behaviour of the
> > driver, but maybe it's better to check drm_edid_read_custom return
> > value? Bochs, amdgpu and radeon are the only drivers that call
> > drm_edid_header_is_valid().
> 
> The nearby comment indicates that EDID support might not be present in qemu.
> But drm_edid_read_custom() warns in this case, even though it's a legal
> state. Hence the test.

Ack, thanks for the explanation.

> 
> Best regards
> Thomas
> 
> > 
> > > -		return -1;
> > > +		return NULL;
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

-- 
With best wishes
Dmitry
