Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0E43F4B5;
	Fri, 25 Sep 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364412; cv=pass; b=lh9zMRyXyLGEcGKkHGZLOLIxY0nAjFgb/Dr6Qjcrfax324f8w5+LopUjCh1wOGgIG2wz+evvwdzwj44KKM0jkPXbtGonZvGiXZzQ4UheuzbvVZBAmS2GmxOR4DXIfikSMZ5PLl3fC7yybc1vuE/AZZTbp49I0n74KleMxfMbhkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364412; c=relaxed/simple;
	bh=xgwXF789iMFU1tHJBCYfohzF1FMXCUeFcBdG42GdAwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKS3ZtcWUjM4qHzO9PbIlztoQOJFTVHWdIXmGK+DKUpuccI/M9ch/TnXrkKiGPY5H1p5Jh/TdFC7x2tlgPfKwv0RaVA2yOVtTKWl+1h8zi+croRIxgGmEVxdnCKy28zvwP0ibbwo1vL2fTao/pGJNosXVoH7VFuyCPXzk5gKMrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=KegsoI3t; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=TYJhyBN1; arc=pass smtp.client-ip=185.56.87.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="KegsoI3t";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="TYJhyBN1"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-kb8j.prod.antispam.mailspamprotection.com; s=arckey; t=1790364409;
	 b=hF12uQzGzrdyTx/DtT7jNCxzsodn3eU84YOhICpuCsQ26X0+IqVncUz8pwcAksj0+s2BhBywMO
	  EFdgg5I97DzXxmV0DJb12de3vpWMK+G29/8v4NbhI7simNhrvN2zYGIvbPKbMWSXBpXa4QE9kx
	  kd0CD63v2iR6K5btpAqhi+JN8zmcZtubA3JVLj6A9nDvj3uz0nvFbk2x6UrC8QMUL/1558o9if
	  8jiwTM+Y5tlue2DBpH8+KmwPu7YhtFPzJ7TfLl3RTDVMvogmJ8c/hHL+DINVIGYciZjb0p9N4a
	  iZzz/E5TP79qIGEr2F6af1up2B0m7DXNIoMgzMDXUcEq8Q==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-kb8j.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-kb8j.prod.antispam.mailspamprotection.com; s=arckey; t=1790364409;
	bh=xgwXF789iMFU1tHJBCYfohzF1FMXCUeFcBdG42GdAwI=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=wVSXAYa4rP5qkS/lIG1+x0Ooo6336EiBap3UftF8EJN2f/nRtHom9dM8Q3uSWXx+AnTKyp/8ER
	  dJhZx28TWdaxXakX0mQL25tFN42jGn71ZUcbmaxhlQCS/aM+ACxnwviWOTwgVAbDsd5xrTwsov
	  YctJPTFE+V2dRmVozKLOGYzYsqdCR/xzE9Y/cG5FZRZ9a+rPLDU9sX2JKRj9lOJRN6NXvUumof
	  Y3Jr5jWj0+cVOGQSmku4y4N6seUajyalfxkDNbyyoneN9OxH7zCEa1BD2BE0qUZkDZC/mHe7Re
	  15y+3jbPMH+EpXqUxafya+zXHeKpSeH+kb+NgkD5rEPWkQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=pe3VO7IOUXW8W+2mymQNpuRLjGNQ7piBXOGa6ZWGAGA=; b=KegsoI3tru7sOtFtg2WzSjegfO
	tnt7xbG2RDVzgn24j2ovqSEVhEaGHq7noPQ7bBM4Y25Kvh9DoXOsb+FgiLhMu5ivK9W6+lE/dH+Im
	tK8D415rfmJHfIA1OHTwubKEGiMye/svjP5mJ/KvKnS/LwvXZe37OhscVxCe3zDSud5c=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-kb8j.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABZF-00000004dgj-3qt1;
	Fri, 25 Sep 2026 19:26:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=pe3VO7IOUXW8W+2mymQNpuRLjGNQ7piBXOGa6ZWGAGA=; b=TYJhyBN1lLzM3j+8pakSQMWVuQ
	t9mPBySmzyc3WNNnz8yxKZciuJ4xoz92WA8IDQ9Cf+qyAtkbvu2kdW9CFkJo1rvQUlA6QAnv+Os09
	A/+p5mE4ALa7sex5tsF+sHPQqVKAeFRcuB359Jqm8Xwur31oJ9WFh59QQVbTtu6FCDtM=;
Received: from [79.45.60.29] (port=62628 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xABYu-000000007dA-1S38;
	Fri, 25 Sep 2026 19:26:24 +0000
Date: Fri, 25 Sep 2026 21:26:22 +0200
From: Francesco Valla <francesco@valla.it>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, virtualization@lists.linux.dev, imx@lists.linux.dev, 
	iommu@lists.linux.dev
Subject: Re: [PATCH RFC 12/12] PoC: arm64: dts: imx93-11x11-frdm: add
 multiple vdevs
Message-ID: <arbILwxDF9lZZtd7@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-12-dac8c5eb4aa9@valla.it>
 <3065678.e9J7NaK4W3@steina-w>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3065678.e9J7NaK4W3@steina-w>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 2a661e867832621784e20a98398d6dda
X-AntiAbuse: ID - 2a661e867832621784e20a98398d6dda
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xABZF-00000004dgj-3qt1-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-kb8j.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Alexander,

On Fri, Sep 25, 2026 at 10:39:46AM +0200, Alexander Stein wrote:
> Am Mittwoch, 16. September 2026, 23:10:57 CEST schrieb Francesco Valla:
> > Add rings for multiple vdevs, as well as the required virtio nodes for
> > I2C, SPI and GPIO functionalities. On top of that, add example
> > peripherals using all of them.
> > 
> > NOTE: this is a Proof-Of-Concept, not meant to be integrated!
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> 
> Just a general question, unrelated to virtio, but related to AMP: How do you
> manage the clocks, so that Linux doesn't disable clocks needed by the
> Cortex-M?
> 
> Best regards
> Alexander
>

Clock management for remote processors on i.MX93 (and other i.MX parts)
is... not really a management, AFAICT. If you want to use a remote
processor, the mcore_booted argument shall be specified in the kernel
cmdline; this forces the clock management driver to leave root clock
gates enabled for *everything*, leaving the possibility for the remote
processor to use anything it needs.

While out of scope for the current patchset, some work in this field
certainly is on my (long) TODO list.

Current implementation can be seen in [1] and [2].


Regards,
Francesco


[1] https://elixir.bootlin.com/linux/v7.2.7/source/drivers/clk/imx/clk-imx93.c
[2] https://elixir.bootlin.com/linux/v7.2.7/source/drivers/clk/imx/clk-composite-93.c#L83

