Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1847F787;
	Tue, 22 Sep 2026 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058879; cv=pass; b=n0hxts7CpOFk7imRhRD6wL1G2VPpQtY4iD/Mde7e3bOQeJfwezbXn31yUrrGg/CtnVaWTGSLNOTgDm6wSJC13sgxof1cuYeGhjDZy+iXjGv4ADxIXjoCIVigGwqZlJTsXZk/rC6l43rt5J7t0UIzQwilp0BGNfc2ZtOwNGuycOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058879; c=relaxed/simple;
	bh=KRF7mzrEcefx2cCAz6FPvzYQT9GQwppHdJJE1JW4tjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL55lfNY+1DoUX9F6gCNuTZY1CD0RiXXkKxF4GhwlN7VYJiuPLT/B/cteeJKg29Iz+tdr5j8+hPuKLJuUeJ8JOMI+vm1N5IsSn09l89fj9ILn9aXaBmVsJJycI3IY0kogm7LVmp6QbaqZL+HX6URtCyPLzYbTP3QP705ElMVe9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=R60idwLc; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=HEhwwlRP; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="R60idwLc";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="HEhwwlRP"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-f940.prod.antispam.mailspamprotection.com; s=arckey; t=1790058873;
	 b=WxBd/3r98sT6Xqx7pQwhMxTho0u6rOtTyWVPi/a9VZVVxbYXufzdYkU3eD5fNN1h1urvu7YAyk
	  QljkGL6sZOvBTJx8HSyO37BPYcfKhtlk9apbkCB5yE+ETKWdHRT2239IkeQJhRoI2ARY+ASxga
	  k1/irCLI9DQbgFWTjaW5NxUyQ3BKBRJEdX4abuB/c3362PixJyaM4AG4KP6ppq6XNYpmX7xuS2
	  IXZYHiASRzqsthfmWrOXtZItZJkYnqWPVA3p5aMcMjyb7zw/KWIAb8U8lRHF6qomplVNebj3r8
	  rbgtp4yTx4uURE2o6hDGXKsF4Ug62McWPQWpo+SYL65spQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-f940.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-f940.prod.antispam.mailspamprotection.com; s=arckey; t=1790058873;
	bh=KRF7mzrEcefx2cCAz6FPvzYQT9GQwppHdJJE1JW4tjU=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=PLtJgV3SJFPsVksCpNUOpV+PAauLCH3+l4nJF2uVc7nYbaNi5qH7Ys5WUIqumYxpJi+/o08bUV
	  fcrGKtRCPnc0Jgn+nzPqFL+g/XlpjpfD4ICouO6uZmM4tMF5AHrS3FjnpDAczJB66y1OyzhYvx
	  qkqVhY+uuDBfr+S3TYpPl3rgXQkT8+A0BPvgXnALxgju6q250JfG2Q/NVZbbPSgvAcYHkV/Kg9
	  a6YUvJqp58xDTlYLGT3ACu/K/5Z679EA1FeVhT4xyRbOzT+9tu0yFhIfcVObLGvmXUUJO8oPej
	  Az1SKmJjJAnmhYWTREirhidRDmKc+vUcx5S/XxKji+a28A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=1N06q9Iqt+n0HPR6BLN3adBn216qx/G71jg+AxnkRRA=; b=R60idwLcDPcTMGBZZb0l5BzBTm
	ZqoDtj1kxNkC5hHT9DM88X2FrBJmKpPC2PckUiAiIA1GQ06NzvptROeP5g5k/TyLZHm+XeLmYf8UQ
	BfXcue/4Cu9glAff93XUzmPpiE6dXjYzTZUdIQu5gI3FZkDDDaChYh8wyVDOkwqVpbss=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-f940.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x8u56-0000000GGBJ-085E;
	Tue, 22 Sep 2026 06:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=1N06q9Iqt+n0HPR6BLN3adBn216qx/G71jg+AxnkRRA=; b=HEhwwlRP3qLm1x3BiOx6/yErcr
	96L28DUv90dLTh0ICYZlv0l89z1LKoBL2EJReSJMV5nKubxJKxfixgaZ7M87PYUyWr0yZowCyQJpI
	IW7lUfbEyr5lOpT1TxOKPf4g6mfNdBq1FffppbX4hO7MlJiY+VMQr+iNf6j8+PILWI0Y=;
Received: from [79.43.46.244] (port=60174 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x8u37-00000000JK3-0fLD;
	Tue, 22 Sep 2026 06:32:17 +0000
Date: Tue, 22 Sep 2026 08:32:15 +0200
From: Francesco Valla <francesco@valla.it>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	virtualization@lists.linux.dev, imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 05/12] remoteproc: always report VIRTIO_F_VERSION_1
 feature
Message-ID: <arIgI4E5rGXq9H0P@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-5-dac8c5eb4aa9@valla.it>
 <arFRqopkkJf7Nlq4@p14s>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arFRqopkkJf7Nlq4@p14s>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 56d811be6fa5a82ea89630e0c183c422
X-AntiAbuse: ID - 56d811be6fa5a82ea89630e0c183c422
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x8u56-0000000GGBJ-085E-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-f940.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Mon, Sep 21, 2026 at 09:47:54AM -0600, Mathieu Poirier wrote:
> On Wed, Sep 16, 2026 at 11:10:50PM +0200, Francesco Valla wrote:
> > There is currently no way to report the VIRTIO_F_VERSION_1 using the
> > resource table alone, as the per-vdev feature array is limited to 32
> > bits.
> > 
> > Considering that the VirtIO 1.0 specification is now ~10 years old,
> > always report the VIRTIO_F_VERSION_1 feature, as some drivers depend on
> > it.
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >  drivers/remoteproc/remoteproc_virtio.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > index 74e0da970f1d..cfd66d9d1c9e 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -249,7 +249,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
> >  
> >  	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
> >  
> > -	return rsc->dfeatures;
> > +	return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);
> 
> I understand this.
> 
> >  }
> >  
> >  static void rproc_transport_features(struct virtio_device *vdev)
> > @@ -275,14 +275,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
> >  	/* Give virtio_rproc a chance to accept features. */
> >  	rproc_transport_features(vdev);
> >  
> > -	/* Make sure we don't have any features > 32 bits! */
> > -	BUG_ON((u32)vdev->features != vdev->features);
> > +	/* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
> > +	if (WARN_ON_ONCE((u32)vdev->features !=
> > +			 (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> > +		return -1;
> 
> And this.
> 
> >  
> >  	/*
> >  	 * Remember the finalized features of our vdev, and provide it
> >  	 * to the remote processor once it is powered on.
> >  	 */
> > -	rsc->gfeatures = vdev->features;
> > +	rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
> >  
> 
> But I'm having trouble with this one.  
> 
> First bit 32 of vdev->features gets cleared and then bit 0 to 31 are assigned to
> rsc->gfeatures.  Why bother with clearing bit 32?
>

Bits > 31 gets silently dropped because rsc->gfeatures is a u32; this
was inserted to explicitly drop the flag that has been inserted before
and avoid the "silently". It has no real funtional impact and can be
safely dropped.

> >  	return 0;
> >  }
> > 
> > -- 
> > 2.55.0
> > 
