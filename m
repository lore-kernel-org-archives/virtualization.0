Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C14FE2E6
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785359; cv=pass; b=kOQMiz8Nx6Gu97q+VESfmPa2wCXi/afZUmyh32RE/YWcByX6wMpwGvGHNZlyx1iWl7hbGsF+N/4W6waC5+RJv14dETjl6B+XCxlCN4GuFuBKyVaABgfsqTYiyF7QM2qKmCkbDgWiwf1+wX3fy8V7a4jMwqDzDx71iYDgEuvqzlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785359; c=relaxed/simple;
	bh=XG+XEXFoE7m3XUnzJGwtjUCRx6qhsjftZVKQZqjmcl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYTyk9P9joFITkXcDuUcih/NpiT/tc/brZReB1et+g/f7EAILZbTMHYlzcVCDePiAwAj1wtbnxsH+FUUC67Uy9mopH3xVhVNu0UnAJzQxjFjwmW6T1z0c3pnJSeR5xUPIdLX3TgZzQCDqvrylkdhWJn46VFDBdcCd8MCeNUKwGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Nb55/b8+; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=q7m5FpCS; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Nb55/b8+";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="q7m5FpCS"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-tcqr.prod.antispam.mailspamprotection.com; s=arckey; t=1790785349;
	 b=UbK3sKq3+Eq+MXMEVd/I3iAOdO85kN0v1NJmXe7Sj35bDIc0BajwhGCO93n6qEV9dGuAujjL6a
	  u6XKx6683fmRpljWyDJ/72xbPaeG1a1vJC69KL60C4dXVe8QKbJeNksaE+1x6fQyY6Gi+3FQ2M
	  q3tiBK0QfOxGFwIT+dZ9gGjDYIzgUFKhcRUGXVNxrqqn9JsiNGBtIlGjSNWU/LqAxrSnqAl0a0
	  8TNTIQPGZYtzwgqmNcHTN51lETa7Vh7djYSsla67b0FYnsqZXkFD16tdtnmR0GP4QFimLgJFYh
	  wYagw0Gu8FyOAKgDzI+A0Zl/uB//b1zZocgia+Ox3i6bRg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-tcqr.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-tcqr.prod.antispam.mailspamprotection.com; s=arckey; t=1790785349;
	bh=XG+XEXFoE7m3XUnzJGwtjUCRx6qhsjftZVKQZqjmcl4=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=eg1gWTAraoH/fQdLrkls3oL7ae09u0sP+BM9a4VwzelYwRGd6qFwjSFfGirzbv8uN0G3CHPXnU
	  Si2n4nadSB5Xpah28bMLxHYcmg2sz6KyT5dQA1+yVy8Dd6UOjRzd+rd2RLhxsW2rlr/nMQkEcA
	  52i9qzdXNEId551obyk5g1X1dgEFG1QmpPbE5pNoLO3SHaPLOwSMoNUSRwkrad08c8AD2Cc97q
	  9bpM0L4a/sNOZHITm8mUMxg6A8ftL+wtRODBzcswNEbY0+sTNJpLEQaSusz4kYsBT9aY4Mu1Ul
	  Y7FdBsFhqWr67k5e+gqsu0TaWBWuEqAXouM2yIG4X1k6Jg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=6t7GnASuY8iu8DCfqMcvSr3pNVQGJGkV48AosuqHfVo=; b=Nb55/b8+0IfOG8TYqiAWpFXmwA
	5rCsH4hgkQ3bKX41fgQ6LyN4VOo+/0hPKXOwp/YsLhw/sAFyW1tkIgDWo6MMzKvBP9Q7XvAisezMs
	1a/zQzfQKsPXDNSuHFg4wSRH9CQYxPtiy4nI16FYUbImRwJyg0aYH6cuD581jWN9UbkQ=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-tcqr.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBx4Z-00000004guu-2RyW
	for virtualization@lists.linux.dev;
	Wed, 30 Sep 2026 16:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=6t7GnASuY8iu8DCfqMcvSr3pNVQGJGkV48AosuqHfVo=; b=q7m5FpCSf0KtWKBUFio0+C5svc
	B43jcg/vGa6IV6vn0X4Ni476MudeYiILU4tCXZOaT5M8XS6vuYP8aPocatBzRjQnFAoz7hKcIPVys
	lVU0XVLKK5209DViqfD0nvLsBMKPeaycXLk8ojgY0QVwgyUIISyKtndZqb3UEsNZ04Yk=;
Received: from [87.14.44.235] (port=60776 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xBx4H-00000000GOS-3C3X;
	Wed, 30 Sep 2026 16:22:05 +0000
Date: Wed, 30 Sep 2026 18:22:03 +0200
From: Francesco Valla <francesco@valla.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Jason Wang <jasowangio@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: spi: add bindings for spi-virtio
Message-ID: <ar0yXZotiVZmNJQw@bywater>
References: <20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it>
 <20260929-spi-virtio-bindings-v1-1-6a0eef3213b3@valla.it>
 <20260930-arcane-pheasant-of-infinity-ecff83@quoll>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-arcane-pheasant-of-infinity-ecff83@quoll>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 8d56aaf48683fdbb18a5e540b85ba956
X-AntiAbuse: ID - 8d56aaf48683fdbb18a5e540b85ba956
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xBx4Z-00000004guu-2RyW-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-tcqr.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Krzysztof,

On Wed, Sep 30, 2026 at 02:03:17PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 29, 2026 at 06:41:55PM +0200, Francesco Valla wrote:
> > Add bindings for spi-virtio based on virtio-device, reflecting what
> > already exists for gpio-virtio and i2c-virtio. A node using the bindings
> 
> Existing code is not a reason to add more code. Existing bugs are not a
> reason to add more bugs. Please provide proper rationale why this suits
> DT.
> 

When a non-discoverable bus (SPI in this case, but that's true also for
e.g. the I2C and GPIO cases I mentioned) made available by a virtio
transport is registered, the devicetree can be used to declare its child
devices (if any) and/or other properties (say,i GPIOs tied to CS lines
for the SPI usecase).

The virtio framework already searches for a node with a suitable
compatible when registering a device [1]; this binding is thus not
introducing a new functionality, but allowing proper validation of
nodes tied to spi-virtio devices.

> > is not used to instantiate the device, which is registered by the
> > transport (e.g.: virtio-mmio), but to define its properties and
> > establish dependencies with other nodes.
> > 
> > Add the new bindings inside the MAINTAINERS file.
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >  .../devicetree/bindings/spi/spi-virtio.yaml        | 53 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 54 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
> > new file mode 100644
> > index 000000000000..5b8639dd2e1f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/spi-virtio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Virtio SPI controller device
> > +
> > +maintainers:
> > +  - Francesco Valla <francesco@valla.it>
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-controller.yaml#
> > +  - $ref: /schemas/virtio/virtio-device.yaml#
> > +
> > +description:
> > +  Virtio SPI controller device, see /schemas/virtio/virtio-device.yaml for
> > +  more details.
> > +
> > +properties:
> > +  $nodename:
> > +    const: spi
> > +
> > +  compatible:
> > +    const: virtio,device2d
> 
> From where does the compatible come from?
>

This is the compatible the virtio framework is expecting [1]; '2d' is the
hexadecimal representation of 45, which is the virtio identifier for a
SPI device [2].

> Best regards,
> Krzysztof
>

Thank you

Regards,
Francesco

[1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
[2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html @ 5.21.1


