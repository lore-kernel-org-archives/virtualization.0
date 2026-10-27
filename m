Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793105220;
	b=FKEjWf20dT7UVCf8eyGOkqL2+K0p7HAaGzOrwr6KtgK8UIQadw6NFQRnyiDxfcPbTok7
	 ZkKmZ+nGNUN6vib0++t84DF9oFRYOdZbsmyyTojpfPnpK13fCYhAppsv6rD6yPgWvhBXl
	 8vYswGGWv3yxI/nBlGCVqqRLbD6Pkrmnr5iPdVKbOYPCKbxOPrpTzmNwM/6JXVUNBshgH
	 //OOi8PMfAVHiVo3MeRlEmRaV/LNwDQQmIoXJmcdy970NUqB9/axo+puZVRQucJYVycRx
	 p7t6e0PRHfwz8VD5SiyPgbesY5C9YguqjxIwIcalwccu+06outx87D8rHLpD9TjlaQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105220;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=hUeibnzF1uSqvTtLlcSxfQ5iJwAaK0G87ncKUYrpVJI=;
	b=Ug+JgrQ57MifZq6eMsD3OMV4ONytDePAH8pLnBsUDIWfNQpiH01JnQNSQu6KZuPNDYsE
	 hmzLqPBp9nlACNWDP/9w2aFBWpltMSy0vixVOlqMrQIHv5T6LIBiYErutKrENczd9SSf6
	 dJS14XZK9FJ38rcX2cqSNln/1MgFUdLHJBTPdkRhpiNZJlMaojTabQleBSSoTRBhlXn9r
	 GkUIps2r2R+VyMPRY1e/2i6esjT64Mk5UM9TMtjBIolsq7/uiUF5RGjwBroLL1gJF1ha2
	 HPOKxSl9QkzRHQ6PgA2U8/upD3LTMAeDSsbMvSFChrNsmxdgdRokcen11YiOpQyRXIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=QENUnASA;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=uqG4Jxwk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.2
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888FC606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 12:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 888FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=QENUnASA;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=uqG4Jxwk
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-ppfh.prod.antispam.mailspamprotection.com; s=arckey; t=1793105218;
	 b=eQUwAYFFwtiBEOBV33d8vasPK5FR9SSpHdbPyjORezomnqBMPL1qQpbKEzAfQ8lUgQVFHvWo3d
	  ViSNl6Ej5YX2hA17bg3LNyKChvgDoBGcrzxSmtKBEGr3uutatFP2wyBVzgXs4AwE3CxkrpbsWq
	  lXsQPYB8QnKfz10kex3warVXZnCVQO2OHgNhssEZfUPtDEecWutKVJ31ODNAhMZFtNKOfdpn7h
	  YbLSjdgKGEa/EJ2kBy7WikhpbP7uLwXbPNNyaCO/UTmA95oWPf2f229poEFr5tAVdKa+jKXR5p
	  lhZOIdQ4Nqlfyb824KPDgAbQjyNByCnr8E0TqJB+UrMSwA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-ppfh.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-ppfh.prod.antispam.mailspamprotection.com; s=arckey; t=1793105218;
	bh=LeQ+3UkITZwFZJh2nj89Q3CM/bUnqFi56QC8hkbo5dk=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=cvDkA4w4gy14sVITDvaYrT/I02VV0y4eUfWEpwP4PuC/MhHP6iT2Q8+NSFRB+eYWD2nyhn46MX
	  ZGrKi+qeJv3lnoVUvMuk/E2EdTcIkUGbANzEUqMkH/BQ/vsOYTmsEfIsMo45PeS+gB9jBl054f
	  9DJSqGodqT+WtdvrwTcm5l/Hgy6XwS7XcU62Y3D7sI9YQjHAC0wWFycIUnE+2zwEueLjeYC+5U
	  U4u5oY6YaAjViNVj0+in7lZyLx5mlLAshUE2D1Lk1Q8/MCattNvyf3TakODluVLMUSDnwjRiZg
	  D/9Bl6NdSYwkfsQge1mhK75N9L3+3+OXt7fcUx7g4tFhgw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=hUeibnzF1uSqvTtLlcSxfQ5iJwAaK0G87ncKUYrpVJI=; b=QENUnASAqCo1+GwufkmMpu+K+G
	PXt0fGXbNEZyB4JrmpdOeUjQnC1CmbhhxHgPY0NjgK2uD1Qz/tLZi30uNfthJs62lfrL8mNXzDReJ
	E6yN9be9AN8Is2s4p3Lo2kJYuGUDxuXtJE3KXzpyUXH3H38yt7L1WZSiYOVrU0ORrp18=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-ppfh.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLgZr-00000007AFW-3mo7
	for virtualization@lists.linux.dev;
	Tue, 27 Oct 2026 12:46:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=hUeibnzF1uSqvTtLlcSxfQ5iJwAaK0G87ncKUYrpVJI=; b=uqG4JxwkWwKujXNDCc08S2TlWU
	XYWWXCxKHZVX1MgagD1Ltt+HzCm7j9R2Qo6uU0bdwRSNm1VjEL4Z4mAB/yb96W+5v3yaWpCYuP9P7
	OiR3YYrQcp5JA51VP3xm3hxlZyAL2dAurV5KmLvJDwWfriU8gFoSD6oLYbuSm8P8gTS8=;
Received: from [87.16.26.129] (port=63095 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xLgZY-0000000015e-3p8g;
	Tue, 27 Oct 2026 12:46:36 +0000
Date: Tue, 27 Oct 2026 13:46:35 +0100
From: Francesco Valla <francesco@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haixu Cui <quic_haixcui@quicinc.com>, Jason Wang <jasowangio@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Add devicetree bindings for spi-virtio
Message-ID: <auCb8_ROuyXdTkQ4@bywater>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027065001-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027065001-mutt-send-email-mst@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 024a85839bff303e8b4877a98be63b78
X-AntiAbuse: ID - 024a85839bff303e8b4877a98be63b78
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xLgZr-00000007AFW-3mo7-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ppfh.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Michael,

On Tue, Oct 27, 2026 at 06:50:51AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 27, 2026 at 08:26:32AM +0100, Francesco Valla wrote:
> > When a virtio transport exposes a non-discoverable bus, the devicetree
> > can be used to declare its child devices (if any) and/or other
> > properties. To allow for that, the virtio framework searches for a node
> > with a suitable compatible in virtio_device_of_init() when registering
> > a device [1]; such compatible takes the form "virtio,deviceXX", where
> > XX is the hexadecimal representation of the virtio device ID as defined
> > by the virtio specification.
> > 
> > This patchset thus does not introduce a new functionality, but allows
> > proper validation of nodes tied to spi-virtio devices, aligning SPI to
> > what is already being done for e.g. I2C and GPIO virtio devices.
> > It was sent initially as part of a different patchset [2], but since it
> > complements a functionality that is de-facto already there and is useful
> > beyond that specific use case it was sent separately (also following the
> > maintainer's feedback there to separate it from remoteproc-specific
> > changes).
> > 
> > This was tested both with virtio-mmio using qemu-system-aarch64 and with
> > remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
> > parts still not not upstreamed - see [2]).
> > 
> > I added myself as reviewer for the spi-virtio driver to be CC'd on any
> > patch involving the new bindings.
> > 
> > Thank you!
> > 
> > Regards,
> > Francesco
> > 
> > [1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
> > [2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> 
> I hope this can be merged through the devicetree maintainers,
> I have no idea.
> MAINTAINERS changes needs an ack from existing maintainers, of
> course.
> 

This might prove... difficult. My e-mails to the maintainer (Haixu Cui
@quicinc.com) continue to be bounced back by the Qualcomm postmaster
with a RecipientNotFound error. Maybe someone from Qualcomm can give me
a lead on how to contact them?

> > Changes in v2:
> > - Expanded the commit message to better explain the functionality and
> >   the chosen compatible.
> > - Redundant pieces dropped from bindings.
> > - Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it
> > 
> > To: Haixu Cui <quic_haixcui@quicinc.com>
> > To: Francesco Valla <francesco@valla.it>
> > To: Mark Brown <broonie@kernel.org>
> > To: Rob Herring <robh@kernel.org>
> > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > To: Conor Dooley <conor+dt@kernel.org>
> > Cc: virtualization@lists.linux.dev
> > Cc: linux-spi@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > ---
> > Francesco Valla (2):
> >       dt-bindings: spi: add spi-virtio
> >       MAINTAINERS: add Francesco as spi-virtio reviewer
> > 
> >  .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  2 +
> >  2 files changed, 48 insertions(+)
> > ---
> > base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> > change-id: 20260927-spi-virtio-bindings-f4e350b2709a
> > 
> > Best regards,
> > --  
> > Francesco Valla <francesco@valla.it>
> 

Regards,
Francesco

