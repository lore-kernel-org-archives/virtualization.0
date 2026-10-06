Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC94A4984;
	Tue,  6 Oct 2026 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311954; cv=none; b=nm7LUjcRQ/+x/hxrRUWkc0PdH6ATmUBWm/nvlqYXTGoxRE8hM+hYvCJ5AG6Khxy1vOG0WBjRyzSrkbwRF0CPlvVMU42kSccn+adPGfIe6O16ZHPJ1yB78jyPsUsjg3PsubOS99IF7sKhQN5JPgs7c4JIRLjK9ZGRROlOsGn/kJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311954; c=relaxed/simple;
	bh=SgYVEBbK9gokPeiiA7ouZX+NAJnfVYbgExuEMlh0ws4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYyAqZgNR4BnwvmjMFdU7iO+EP07F5tQB7htZV2dcOdJZjDw4mkKjXt2AqjegrxYdcQpJWzNsTX8ZbteuAzV9alqDhWIaQqr56kNyGI5RKCkDr5z1/2xO+pQfXWy5juGDtjME0GmJxlk9cBmU74gCAn0vBSuTjUxD10TM+I281k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk6GjwcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk6GjwcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC881F0089B;
	Tue,  6 Oct 2026 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791311951;
	bh=YnuOeuo/LodeBx6Sgln5fFHIlb9TcaUTmkgxnYAmmVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gk6GjwcCcwF0BnSp+fwOsMz0okjMzU7Y/H0nrSZLiq3H85mI/+8VFmvi3VKF6fyoY
	 xBCKO+AfsNCIyiZrJyvKwJ2Xjgg//Vo+gDM/ZiDDjDJqpcPoq5IHk5OQPGy4s+9HBE
	 NYdVEAvQ0bTbspMPorb+92ddphVavQaAi2RaT4cduu2n+oGoZVnQu/ChThV8JbTPYm
	 ZG5v6xaNhUuSefo2vtOiUTyzvwW+IxWn6UyyGeX+JzvBf2YKiQdy92Qk/Acb3A0Snw
	 3qRPnljHIzJY07gIvWLxtyPGT2KUMim+rkeVEqIVSZYrb0QPORNVZE8dM6HaBYnwbD
	 aLxOhdzU0sFRA==
Date: Tue, 6 Oct 2026 13:39:10 -0500
From: Rob Herring <robh@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
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
Message-ID: <20261006183910.GA2890477-robh@kernel.org>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>
 <arKhbxi3Snbt1_Mn@p14s>
 <arLZj2DxBazf3wMd@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arLZj2DxBazf3wMd@bywater>

On Tue, Sep 22, 2026 at 09:44:20PM +0200, Francesco Valla wrote:
> On Tue, Sep 22, 2026 at 09:40:31AM -0600, Mathieu Poirier wrote:
> > On Wed, Sep 16, 2026 at 11:10:53PM +0200, Francesco Valla wrote:
> > > Add a new binding to describe remoteproc-provided virtio devices; while
> > > these are discovered through a resource table parsed by the remoteproc
> > > infrastructure at runtime, their description can be needed to probe
> > > non-discoverable buses (such as I2C) or to link consumers and suppliers.
> > > 
> > > Each vdev is described by a dedicated "group" node, which then includes
> > > a virtio-device node, which binding is already existent and used by
> > > virtio-mmio. Each vdev shall be stattically linked to a "group" node
> > > using its index inside the resource table as the reg property of the
> > > node; this permits to have multiple instances of the same type of
> > > device.
> > > 
> > > The binding is intended to be generic and adopted by any remoteproc
> > > provider.
> > > 
> > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > ---
> > >  .../bindings/remoteproc/remoteproc-virtio.yaml     | 89 ++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > new file mode 100644
> > > index 000000000000..c4a0d84b1460
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > @@ -0,0 +1,89 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/remoteproc/remoteproc-virtio.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Virtio devices over remoteproc
> > > +
> > > +description: |
> > > +  Virtio devices ("vdevs") can be exposed using the remoteproc infrastructure
> > > +  and its resource table. For some of them, a device tree node might be needed
> > > +  to describe remote undiscoverable hardware and/or connect consumers and
> > > +  providers.
> > > +
> > > +maintainers:
> > > +  - Francesco Valla <francesco@valla.it>
> > > +
> > > +properties:
> > > +  virtio:
> > > +    description: Contains a group of Virtio devices exposed by the remoteproc.
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      "^vdev@[0-9a-f]+$":
> > > +        type: object
> > > +
> > > +        properties:
> > > +          reg:
> > > +            description: Virtio device index inside the resource table.

Who/what defines the resource table?

> > > +            maxItems: 1
> > > +
> > > +        additionalProperties:
> > > +          type: object
> > > +          $ref: /schemas/virtio/virtio-device.yaml
> > > +          maxItems: 1
> > > +
> > > +        required:
> > > +          - reg
> > > +
> > > +    additionalProperties: false

Preferred to put this before 'properties' in the indented cases. Easier 
to see what level it belongs to.

> > > +
> > > +    required:
> > > +      - '#address-cells'
> > > +      - '#size-cells'
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    remoteproc-cm33 {
> > > +      virtio {
> > > +          #address-cells = <1>;
> > > +          #size-cells = <0>;
> > > +
> > > +          vdev@0 {
> > > +              reg = <0>;
> > > +
> > 
> > Do we need the 'reg' since we already have vdev@X?  I'll let the DT people
> > provide their input on this.
> >
> 
> AFAIK yes, because the rproc_get_vdev_fwnode() helpers search for indexed
> child nodes using the 'reg' property, not the node name. This I believe
> is the preferred way of doing things.

It is either both unit-address and reg or neither. It's preferred to 
have them unless you are just making up numbers.

Rob
