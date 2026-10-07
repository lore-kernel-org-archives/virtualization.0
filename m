Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF049A3A1;
	Wed,  7 Oct 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380542; cv=none; b=PpMkIpry8EgTfy2Vpqb82ZWpA78nnwuyuQrdVA2fplaWCXRQWkfxZLzWePVejuSlNyl62eLUXkLaG/+zRtuhloOdB06jZvbAtgPXmPA49+Lxj4EMLkcJxD/Juq1qDBkRiFBkb5iRgrT17OK+ibz1oTPVS01ZTbA7qB30d7JxAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380542; c=relaxed/simple;
	bh=qmpa9rE6GJHLG//YEJz01A1fPrtit8l6U5tzJjoqjdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqWRhWrSRm3cqzLiUPiKSzNe7A12+iB6St56AvRSotmyTEccWlzDCVHLDVFFp/ZBOnlrUnfH1yIQTuieQ6Y+5gA0QfgCcttOwlBsm2wfaabYQ/qEoam+jCVs4OtnbdD5WVLw7JLQcJS8/1IoRDPVTY0qT9/4pOawMTFzXR+SeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOujq+Nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOujq+Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652E31F0089B;
	Wed,  7 Oct 2026 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791380527;
	bh=/Ac6jmKXgYnbA5+fLFbamqJmh4YrIFsnTxkJqKIfZ64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOujq+NjKY4kUQCwPij4R9g8Vgk5cdS/+8teCrbeQKpDJ9tM01853QeN24meJxzCp
	 jm7dvnD0zVR0MgPnABNb8hHR22Pf18/DNqxIhTBVY3wFHk4jA//m+1YST9aRStCtEX
	 ERnFB6TgRgP6P9JV1cCEFcMMsNRhEPVcKC5KE/Qytx+liQq0yalntT71rECE4AI5Di
	 unTXArgcVMXmkNSYUwyLu+Oadp4gB+0bwZCYebcDHlVKB1+j8JYmSaV86+GOCuJUOW
	 uXqxqSVmonEln0+9JRSlcFdt8vm11NDlt+Idpxq4QvOlukB1lMpt8GNMbMPcKDo+fZ
	 KJIwVmaieLZow==
Date: Wed, 7 Oct 2026 08:42:06 -0500
From: Rob Herring <robh@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 08/12] dt-bindings: remoteproc: add remoteproc-virtio
Message-ID: <20261007134206.GB2792240-robh@kernel.org>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>
 <arKhbxi3Snbt1_Mn@p14s>
 <arLZj2DxBazf3wMd@bywater>
 <20261006183910.GA2890477-robh@kernel.org>
 <CANLsYkwhrqk0nQNFuP_5aMYQCLGsLrzm-z9YP+Fvv-C1Ug8trg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwhrqk0nQNFuP_5aMYQCLGsLrzm-z9YP+Fvv-C1Ug8trg@mail.gmail.com>

On Tue, Oct 06, 2026 at 06:51:52PM -0600, Mathieu Poirier wrote:
> On Tue, 6 Oct 2026 at 12:39, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Sep 22, 2026 at 09:44:20PM +0200, Francesco Valla wrote:
> > > On Tue, Sep 22, 2026 at 09:40:31AM -0600, Mathieu Poirier wrote:
> > > > On Wed, Sep 16, 2026 at 11:10:53PM +0200, Francesco Valla wrote:
> > > > > Add a new binding to describe remoteproc-provided virtio devices; while
> > > > > these are discovered through a resource table parsed by the remoteproc
> > > > > infrastructure at runtime, their description can be needed to probe
> > > > > non-discoverable buses (such as I2C) or to link consumers and suppliers.
> > > > >
> > > > > Each vdev is described by a dedicated "group" node, which then includes
> > > > > a virtio-device node, which binding is already existent and used by
> > > > > virtio-mmio. Each vdev shall be stattically linked to a "group" node
> > > > > using its index inside the resource table as the reg property of the
> > > > > node; this permits to have multiple instances of the same type of
> > > > > device.
> > > > >
> > > > > The binding is intended to be generic and adopted by any remoteproc
> > > > > provider.
> > > > >
> > > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > > ---
> > > > >  .../bindings/remoteproc/remoteproc-virtio.yaml     | 89 ++++++++++++++++++++++
> > > > >  1 file changed, 89 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..c4a0d84b1460
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > > > @@ -0,0 +1,89 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/remoteproc/remoteproc-virtio.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Virtio devices over remoteproc
> > > > > +
> > > > > +description: |
> > > > > +  Virtio devices ("vdevs") can be exposed using the remoteproc infrastructure
> > > > > +  and its resource table. For some of them, a device tree node might be needed
> > > > > +  to describe remote undiscoverable hardware and/or connect consumers and
> > > > > +  providers.
> > > > > +
> > > > > +maintainers:
> > > > > +  - Francesco Valla <francesco@valla.it>
> > > > > +
> > > > > +properties:
> > > > > +  virtio:
> > > > > +    description: Contains a group of Virtio devices exposed by the remoteproc.
> > > > > +
> > > > > +    properties:
> > > > > +      '#address-cells':
> > > > > +        const: 1
> > > > > +
> > > > > +      '#size-cells':
> > > > > +        const: 0
> > > > > +
> > > > > +    patternProperties:
> > > > > +      "^vdev@[0-9a-f]+$":
> > > > > +        type: object
> > > > > +
> > > > > +        properties:
> > > > > +          reg:
> > > > > +            description: Virtio device index inside the resource table.
> >
> 
> There are 2 configurations we need to account for: (1) each device
> located behind the remote processor gets its own set of virtqueues and
> adheres to the virtio specifications.  This is the configuration
> targeted by this thread.  The other configuration (2), discussed in
> the other thread, involves virtio piggy-backed over RPMSG.  The hope
> is to represent both configurations using the same bindings.  For (1),
> virtio devices will be advertised in the resource table and for (2),
> virtio devices will be announced via the existing remoteproc namespace
> service.
> 
> > Who/what defines the resource table?
> 
> The resource table is part of the firmware image and is parsed by the
> remoteproc core.  For (1), as presented in this set, "reg" links the
> entry in the resource table with the device definition in the DT.  For
> (2), the definition is also a device index, but said index is
> communicated to the remoteproc core using a namespace announcement
> rather than the resource table.
> 
> I hope to establish bindings for configuration (1) and merge that work
> first.  Once that is done we can extend it to cover (2).

"Defined by firmware" is all I needed. Please make sure the binding 
patches include this information or I'll forget and just ask again.

Rob
