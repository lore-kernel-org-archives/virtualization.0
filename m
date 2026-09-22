Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C653B337
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089812; cv=none; b=A9j0rXN4nmovEGysnPK9DE1/ZCrRgcQvXaOgtKcJka3fAgdXX4ql9S4NnyYwJaUgAufyG232ZJzXXEADmMcGWgkBfHxPdCIOh5XEI8fdEP3P80btzNpsoY+hzjuV/FsO37sY1pT6vZG10eHKnFsidkJrlOV5HcRIOZX2D0TngXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089812; c=relaxed/simple;
	bh=eZvJzrFV596OF1br1NU0yVbzXelFlV68AjwAwCh1swg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heyjGHD4gl4kNwbZMNDdwwEM5O1CcnO1c4WYsKhc9yo5fKNyOho37yDKBMHBxpoiH9ODppFODmEjBh98Kg+Er9woB9FkE8jRoIxVszQQkTeB0tbPv7HaYJMjdEsCEjQxBqyIsUbrpHvj8B9V+ZJwczNaUMwOSGSr6LiRXm7bpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KU0SFQVg; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KU0SFQVg"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d9004a1ac0so28729355ad.3
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790089809; x=1790694609; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nEUSfYy3fMUXK5aMDHvOLpQjElNKnWNceOG4CaIeRdw=;
        b=KU0SFQVgATLuM4RnGiqUMwRzSNebzeFZP12AonvKYPJW1xt7JkujYKCD1JH4REdd+z
         soYUndyLvkFcGabgSgloLo5UYoKfGUm2jX9uraleaw26N0FTaPW0aofNg1zfE+7W4n7C
         zFq5MWD0XId3DIkSwBBor2Nq4KTjoPdToa+EmX/vk6ufg6K4n3Tea6EpeY+AgAAC7F4q
         MkH/nXD93z3OU5wCXfKmNDdDVVuT/LQ8nlpivszqpNfOnwMin/vTwBrSpS3I4Me03mma
         AjuMfHXzxH6nQGWsZwPvFxSYvdMRdkT49syeVp6LbozcJUSAZaCC8X6dwi0gFdgJqRyD
         buQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089809; x=1790694609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEUSfYy3fMUXK5aMDHvOLpQjElNKnWNceOG4CaIeRdw=;
        b=Ylk+PmmvkFJ8BCvEvRIe5HotJ7DQ4ga2bcehsmOc35ZeTWEFw1WVnOGzOptqCk99Cr
         mNx6/uuSLr85Iv9qF6S+DwCGO4SEMyTr3ao6SDBZTsIaAmy4VDmpnx1YNCtBw1CWfXZP
         nbg0FpokrbtQ4Kd7hgph9J2wicdfWLxm4dp54squEzNqjqN8daoTzoso3/IO9flYCVix
         j60xQoWUXRDPZneo8jlJW6cYmHNZY/f3hGLSAfF8APRvC+HluCZTpdtOOsgtr0EOI6Vc
         3xSddHv0ywEiQrlBibcEG0B/KGgixx8NmwgSsXYRG7vGVojXQXV1pA706gseRTAmw2C2
         c8aQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8zHm2Q9ro7LZsNjb+RyJofKCcrRyXami4n/SfoQhjkwc9Bl/I2HHUctPdoUbUyIHRQSc5KE4e8pn3tetJJA==@lists.linux.dev
X-Gm-Message-State: AFuF++lU5lnaWTSi1Z41U8r+PGhO9WzzKrmFh3NxQx1s65rvT58fhVmA
	aMGdKzMceNdKFr506TqobyBIX2MJ/Q1CteNH+2hUKV8/YSxIC58pPfTIoB76sPEGUZw=
X-Gm-Gg: AYBFou1PnkEpt9e+pncPa6XlMX6JeoagJLH3IJZm+Jblr1WbO/c0TSAC6PhEoM4XVWj
	3CczsdmI3iFKTMiptu6+DFBbSKI0MAJGfVfMJgg4isS0H65Bxl9nvkszJtO0HFmd6PAmWt+UDmm
	5xU4ymqs036z+KOBNp8DGaxWsywk+5cnOzyTUIn9zgQFMTqLPvITZrpei0JkjMXkVpSaDoks5pN
	1WtyzrD2TpaKrtiY+zoez3t+Nw6RieM9jQkb9p8pyrRHRDbmcyl08hdDvh6pjT1i+27IAmM8cm9
	Du6InrYs6IzcLfUnh5wrfOdK9LcfVXlTgIifF7glIP/U1wYLt1F2WKuZgj7d2pF6gbgwjCJFLEv
	v7FbO1ql4pXuyTUgfRoxpyXSbBGcu45rI+BAD4EWUAJThriqnhxso7DNkEGfI0yghqFfZbVjduv
	PG1zI580C31F7RhxIy3nCgBwB4403Mz/wEMvxzNA41B8zgjyLWeFe1+/rJGyYjm0ZKLPxcTkj/
X-Received: by 2002:a17:902:db0f:b0:2dd:76b1:3509 with SMTP id d9443c01a7336-2df609d1b62mr16580265ad.14.1790089809191;
        Tue, 22 Sep 2026 08:10:09 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1046:ab8:737c:d2e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0563eesm11964455ad.69.2026.09.22.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:10:08 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:10:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 05/12] remoteproc: always report VIRTIO_F_VERSION_1
 feature
Message-ID: <arKaTaFuNW936nwg@p14s>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-5-dac8c5eb4aa9@valla.it>
 <arFRqopkkJf7Nlq4@p14s>
 <arIgI4E5rGXq9H0P@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIgI4E5rGXq9H0P@bywater>

On Tue, Sep 22, 2026 at 08:32:15AM +0200, Francesco Valla wrote:
> On Mon, Sep 21, 2026 at 09:47:54AM -0600, Mathieu Poirier wrote:
> > On Wed, Sep 16, 2026 at 11:10:50PM +0200, Francesco Valla wrote:
> > > There is currently no way to report the VIRTIO_F_VERSION_1 using the
> > > resource table alone, as the per-vdev feature array is limited to 32
> > > bits.
> > > 
> > > Considering that the VirtIO 1.0 specification is now ~10 years old,
> > > always report the VIRTIO_F_VERSION_1 feature, as some drivers depend on
> > > it.
> > > 
> > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > ---
> > >  drivers/remoteproc/remoteproc_virtio.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > > index 74e0da970f1d..cfd66d9d1c9e 100644
> > > --- a/drivers/remoteproc/remoteproc_virtio.c
> > > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > > @@ -249,7 +249,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
> > >  
> > >  	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
> > >  
> > > -	return rsc->dfeatures;
> > > +	return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);
> > 
> > I understand this.
> > 
> > >  }
> > >  
> > >  static void rproc_transport_features(struct virtio_device *vdev)
> > > @@ -275,14 +275,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
> > >  	/* Give virtio_rproc a chance to accept features. */
> > >  	rproc_transport_features(vdev);
> > >  
> > > -	/* Make sure we don't have any features > 32 bits! */
> > > -	BUG_ON((u32)vdev->features != vdev->features);
> > > +	/* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
> > > +	if (WARN_ON_ONCE((u32)vdev->features !=
> > > +			 (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> > > +		return -1;
> > 
> > And this.
> > 
> > >  
> > >  	/*
> > >  	 * Remember the finalized features of our vdev, and provide it
> > >  	 * to the remote processor once it is powered on.
> > >  	 */
> > > -	rsc->gfeatures = vdev->features;
> > > +	rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
> > >  
> > 
> > But I'm having trouble with this one.  
> > 
> > First bit 32 of vdev->features gets cleared and then bit 0 to 31 are assigned to
> > rsc->gfeatures.  Why bother with clearing bit 32?
> >
> 
> Bits > 31 gets silently dropped because rsc->gfeatures is a u32; this
> was inserted to explicitly drop the flag that has been inserted before
> and avoid the "silently". It has no real funtional impact and can be
> safely dropped.
>

We have come to the same conclusion.
 
> > >  	return 0;
> > >  }
> > > 
> > > -- 
> > > 2.55.0
> > > 
