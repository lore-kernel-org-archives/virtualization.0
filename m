Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE951A138
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784480; cv=pass; b=DGmXsSXYy4fkpRfCxdueQPrHN9Z7lAlbJvfjFu3aDfBikxDia8LprXP8e5m5Lteq3bXx8USeoTEWmGKYIgT4VrCIY3V+7aky5UrYaXZATlkBJLbUHuisZBfjAfRBkRE7Py11Hsf6ub7XYe/YTu29yKfXsaVgYV7/4O+U7iDqkXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784480; c=relaxed/simple;
	bh=uSh6Ndk8HHsadtIVQXx7nQmrmgTpDlhjRHbrdndeFDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLOx8huF+53uCG7xnR523jKpYWNj4ROEwCdnzwttULTeeNTZsZUo6odaSVMUgghHibNGeVPI86GBuxOM9Ri00YqbWSL0ixE4kvhCdjYr06DwQuMWjkQBYZP59Bd2nkr9+S8aKYhaOD1n47sOsF3GaEIpPL8jUHN8FTYtBPgfzSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=sKYGFrCN; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=KL9852F5; arc=pass smtp.client-ip=185.56.87.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="sKYGFrCN";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="KL9852F5"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-8s9d.prod.antispam.mailspamprotection.com; s=arckey; t=1790784472;
	 b=D+so2I5AxHsltUAdUom+6HJ+MeapWbHLBvXcBmUmKnORaaV+y1dPJsE4U0EhK0mdTQJ8lybWUN
	  N675AQ5EnHM8oBWArbaXxYE+9PfI+YGdtZA7ioK792pwBtSaFIn0DExg3PxAbPiBmzxnbR3gVy
	  3z4tTIRoY/IMx2jGC0AjEOpRVNNRfer6rGkrGyoW8kqKCMcVl4jPMFcJweN9IHERlakE32/gTz
	  Gs03wcKJmr3mKxOvEyZwBL8/faPbq6PXBBosPolhjV1Pd1+0SB1UmGOo91Ty5pn2Y9OF7LZUqT
	  JoFbnWphosivRYLkAg89aWEZ6ApN0PZHdRHY6eNpi/XkhQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-8s9d.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-8s9d.prod.antispam.mailspamprotection.com; s=arckey; t=1790784472;
	bh=uSh6Ndk8HHsadtIVQXx7nQmrmgTpDlhjRHbrdndeFDg=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=pHI4UA7fyMNVoDap3QM4d3EeYIQxHY9MykT5qTlwfxb37sHKM8v+wVb0z/d9peFmgyACYJfty8
	  ElfuuYEMTa2QOEeA7+Ex5OMRsaiwTO6Qw1I0NZhmRHeJsYrppgQWFbpg++5bNW4fG78FPa3Dvo
	  jzmCZiePVEGD1cIzgcrID417eN97Kookohb1drtMD9NcAKgJSqKKZmeTGrkF6kKDNEDCTRjbQT
	  II1UDTzPuT2d9+HDTMMSjeyFYIaGkaVVyK5i4v7yhfPszYSFhz+GBjQZYPj6BSVh++sdfSHUtB
	  4oq+NlchmUFyoDOVrQsb0YjZSc/eKzI79h5DaO5BrTs3hA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=dP3jA4xLY1vRZxU2Q34betBGbV5S3gISyd5gwp53GhY=; b=sKYGFrCNkUlc/jbw9jHiZcwnHv
	ua7E+wlC2kVXe3O9eLyk5AJ9P1R4WTvNJi2S001nvUXQaqTrV2QW4PcMSA3lDij61li5IU0ISGYmm
	ujYeJxRjBPqbBk4tQMW1i4Ooi6V+B2G6hLnVMZQHVJxjH9fH53XDkDUQEOme7gbEBv1g=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-8s9d.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBwkW-0000000E0Ql-2yGi
	for virtualization@lists.linux.dev;
	Wed, 30 Sep 2026 16:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=dP3jA4xLY1vRZxU2Q34betBGbV5S3gISyd5gwp53GhY=; b=KL9852F57TwOirk5hpKe/6AAas
	Ch7amGbhS2pdRcxtmR8nhoAnhQQveQpq29lAnx1yzEUt937S2L0yqYqrNoWrBiW1o6NWcGwwa5bs5
	qLhD2LlArvXL8SV44ZifN31KEXb6txZ5lJ2z8o652qGHEPo97y3+XqWH+b8JTTfd9ELQ=;
Received: from [87.14.44.235] (port=62882 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBwkE-000000004sz-36Mg;
	Wed, 30 Sep 2026 16:01:22 +0000
Date: Wed, 30 Sep 2026 18:01:20 +0200
From: Francesco Valla <francesco@valla.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH 0/2] Add devicetree bindings for spi-virtio
Message-ID: <ar0wnqVFn10MISod@bywater>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
 <20260930-neon-automatic-rooster-e2eec5@quoll>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-neon-automatic-rooster-e2eec5@quoll>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: aac7ff679ca8086ce7c3a41a47d352e7
X-AntiAbuse: ID - aac7ff679ca8086ce7c3a41a47d352e7
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBwkW-0000000E0Ql-2yGi-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-8s9d.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Krzysztof,

On Wed, Sep 30, 2026 at 01:58:38PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 29, 2026 at 06:41:54PM +0200, Francesco Valla wrote:
> > Add bindings for spi-virtio, like the ones that already exists for
> > gpio-virtio and i2c-virtio. A node using these would not be used to
> > probe the device, which is registered by the virtio transport
> > (e.g.: virtio-mmio) but to declare properties and/or child nodes.
> 
> Keep proper versioning of your work and DO NOT IGNORE previous
> discussions. This was discussed before, no?
> 
> https://lore.kernel.org/all/20260916-remoteproc_virtio_map-v1-7-dac8c5eb4aa9@valla.it/
>

This is correct, the first patch was an accesssory part of a RFC series I
sent some days ago. I decided to drop it from that series as it was
outside its particular scope, as Mathieu noted [1], after picking up a
copy-paste error signalled by sashiko.

I should definitely have mentioned that in the cover letter.

However, I believe this to be independent of that particular series.

> b4 solves the first problem for you.
>
> Best regards,
> Krzysztof
> 

Thank you!


Regards,
Francesco



[1] https://lore.kernel.org/all/CANLsYkzC5DU8j_QJLkuUcV2tYb=G86L_G4yiBZTePKSqiRdd6w@mail.gmail.com/

