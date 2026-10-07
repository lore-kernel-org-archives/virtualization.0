Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC23128B6
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334327; cv=pass; b=UHuT4Gj71mjAzdkS9qQgz+eGGi0PEujO9HvCbIdIwDui3EgErkCFKk5cOjeGcpcaA5pRpIzy+iFF1PGIg30H5aPRQ/vBLD1wBEUIPuE14Um53HQscQj3tu6dOZmSFiH2LgCYT7oU2sGfHHPchgsRjPhD54fUChvp+GMELpOMJJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334327; c=relaxed/simple;
	bh=BX1JTxbJEXnqNqVkUffmNNj1V50eTcs9S7BDpSMKKPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwtRJRPTFkVTEUbC3VXvvympmIwzPfS6WdyH5KdNDrJC2wQ9WTWBH6l+DTcBwn7maMnRkhYdEq+VVZAvCAQE0ogWoNJ01YnD3MrKH4kve/742K6/Ppl31HDbdjToHlD7h7xocq/sNOmphjajAaWftC5JIMx9hbJGhPF7b2FiCuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIknHIIe; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIknHIIe"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6af9befd04cso4855294a12.2
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 17:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791334324; cv=none;
        d=google.com; s=arc-20260327;
        b=KzsY5mgXVxD7TOkf6BqV1jRGOa27CaOsLm63lWYnMVI3MQ1tRIrGgMv2EGuh/Q/UJe
         VBQ/Q39naL/wP2Ee09YcRe9u9dkLeIexgc3BT777394RpP2jPOUrWBnw792p4G6iXl1O
         z22ADH+x7v6C90XcH2LBx8Vc3iUhnNCDaKeeSTBClyKAOtbYMry2brPhpb64UUWDJkaC
         0ywMPSvfMnAIbaxPIHELYkdfRUV3MJ257DnG1GSgUJWgkVld+T6t2opwOOHoWfLq/u4S
         wnmsbC72XfF5dxENaBuebrCDMRApHGWqO+cZqDFgUicFRGUXMNDy8sT5KCERYl3vXyA4
         oshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aNKeIlua+JayoelHkZCjyJRAYpDffnOMiZGr6BfxirU=;
        fh=vJd9xyTsS83M/l4A77yfZGJlIfcKAfHMljyl4FlZJOU=;
        b=WcXbBOxQXTQteUkZtZ6fnNgeMX4GLjFbkCo9Hvd3DT3/2ZpWDe83rwImTs2C51VArV
         BfB72jwQ7VthnzSnIQmGmHzGhYnE2PwFlcZCXXDnptsq1zEFkp/3PGDeCCR/qil3fp/H
         GTXvjqJSwGq3UPnCrXstjyexRMf8M9LE1uGeDBKc4kUW4cBStbyJQLLZmJ9o4whJGUq3
         uUfNDzBSkajC5kwZRTePiciyZQq2ti5XLwWyFlpGOijuxrVT8Ed6IlpgNwfQlF+t675p
         Hp1mSC3NolW08lAJjwd7FuCZUYsbY3vyaSYvnICDreMC7tQlMSTYkqbnyE/XZ+RFCTxj
         W0OQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791334324; x=1791939124; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNKeIlua+JayoelHkZCjyJRAYpDffnOMiZGr6BfxirU=;
        b=CIknHIIe5anjI2aJpcZ09YQgbN/KvyH3x2Fxi2VVp+n7Vn48YpRgCaEm/4gT/nYS1b
         OA5Q+A4mSiayXAkS3FtjIn0vdyWmUfTnOUqMNA4SAFeFybi9J0zfVUl+PS4aB2WNSGrJ
         ns/Ozf73EneaDthE1l0ugfm924W4OFm/gXJuLg8RJqdCgZqRlbEW/rKZnTBkz9mqelmE
         Zm9kiSbJlv7myQnPhmb96PQAbAPIFrTju6LACsEq6Dy7aUVdPuRjZ6HxdBxh7qP8hBQU
         hpPnLFSpIS/Xv0B9552+VEQ1BjRmqgafYUNXUPICFz+Q+V4Q0ZgUv6ODGwVFNUbarYYm
         5yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791334324; x=1791939124;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aNKeIlua+JayoelHkZCjyJRAYpDffnOMiZGr6BfxirU=;
        b=21LUTObTihMAEete7/T2EAjU8GK+yhAqOnPd/gHxKKhm7N1nK9gAf/B0cwcxx2RNU6
         fqW17LM2NbzsgAv5hS7IPHe7amZ8sdVwbmkbsCEMPrON654NOpg7hDXfSHjUschIm0gn
         PJorl9GvWCjvJZi9W9Dq2E4Hm6c+rze5u+lzgbEdNIIo4MvZxqqtszemykZQT1SElCJj
         f4jLhFhObsliVIPXqQ7ry+vNTz00jKBanKfPlSrNxbo2EBgYzZg13/1/QFw9xTfC36ME
         2/wu7Dtil0H/+0+3SYCwXKUCl0QRDOcf5Khl87SWPXsli5nLJX5ZzmwPJmFnqio/PFB2
         x2lA==
X-Forwarded-Encrypted: i=1; AKwUvBxmxM6HlzIoSrZeMzsEr1Y1g7ROB3dhOzOmUKFIxdiQ91H2XgLQ2gpnbN7yKlyAndqYWFqwR3oI9MlU+ZJthg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLBYtsK/kEqPi7lpdv+jGMzaa6yigkAkt4dEZ01DoSfk9/WLB/b
	FiqZ2zmSSi87DoDZh7qITSNJg8dsixDRdHEm8EQ/LRUj5dNjRosVI+qiK1xbMHiPpr6LNR6ygDB
	oZvD9erQA8cOcG9gDitXRLaZVbzF01CYIpacEH1lvBw==
X-Gm-Gg: AYBFou08cerFFfq+eGmWUyfv5Kc1cWasoygg5CqDre/rePK8RpGm/K4MkRtRQJhrdwO
	55Fl+VIxlWtKidBm09T9H+UDaEIXS18TzJRwN5aul8PNgKyynrhcdZeUNVNMuIme+5aDSFCUgg6
	JrCEsxSyezfFdwtlWsYpjFQaylcXrIUmCJllD+JI/i/hblKksR1pETq5Zsd3F6DYTmp3mba80bw
	37f6a0cuweN81fmPQvDv219jWkGyndakmqsSoIztHC0sH8A44233ZMlX4ZbRULBYDllzuAz9P6E
	EqtKqnOaCyKhWDWjAF9n1+1XeI+/Uv1cSPc2crchWsr8uSr1uivDdA==
X-Received: by 2002:a05:6402:455a:b0:6ac:73f8:2e50 with SMTP id
 4fb4d7f45d1cf-6aff29b8a9dmr558035a12.43.1791334323774; Tue, 06 Oct 2026
 17:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>
 <arKhbxi3Snbt1_Mn@p14s> <arLZj2DxBazf3wMd@bywater> <20261006183910.GA2890477-robh@kernel.org>
In-Reply-To: <20261006183910.GA2890477-robh@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 6 Oct 2026 18:51:52 -0600
X-Gm-Features: AclHuK8OpBmmKBzqQvP8CWwB7vUNA7khdkA2Xv5tnX4fcSWpzyBVTx2EHup08IU
Message-ID: <CANLsYkwhrqk0nQNFuP_5aMYQCLGsLrzm-z9YP+Fvv-C1Ug8trg@mail.gmail.com>
Subject: Re: [PATCH RFC 08/12] dt-bindings: remoteproc: add remoteproc-virtio
To: Rob Herring <robh@kernel.org>
Cc: Francesco Valla <francesco@valla.it>, Bjorn Andersson <andersson@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	virtualization@lists.linux.dev, imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 12:39, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 22, 2026 at 09:44:20PM +0200, Francesco Valla wrote:
> > On Tue, Sep 22, 2026 at 09:40:31AM -0600, Mathieu Poirier wrote:
> > > On Wed, Sep 16, 2026 at 11:10:53PM +0200, Francesco Valla wrote:
> > > > Add a new binding to describe remoteproc-provided virtio devices; while
> > > > these are discovered through a resource table parsed by the remoteproc
> > > > infrastructure at runtime, their description can be needed to probe
> > > > non-discoverable buses (such as I2C) or to link consumers and suppliers.
> > > >
> > > > Each vdev is described by a dedicated "group" node, which then includes
> > > > a virtio-device node, which binding is already existent and used by
> > > > virtio-mmio. Each vdev shall be stattically linked to a "group" node
> > > > using its index inside the resource table as the reg property of the
> > > > node; this permits to have multiple instances of the same type of
> > > > device.
> > > >
> > > > The binding is intended to be generic and adopted by any remoteproc
> > > > provider.
> > > >
> > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > ---
> > > >  .../bindings/remoteproc/remoteproc-virtio.yaml     | 89 ++++++++++++++++++++++
> > > >  1 file changed, 89 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > > new file mode 100644
> > > > index 000000000000..c4a0d84b1460
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml
> > > > @@ -0,0 +1,89 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/remoteproc/remoteproc-virtio.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Virtio devices over remoteproc
> > > > +
> > > > +description: |
> > > > +  Virtio devices ("vdevs") can be exposed using the remoteproc infrastructure
> > > > +  and its resource table. For some of them, a device tree node might be needed
> > > > +  to describe remote undiscoverable hardware and/or connect consumers and
> > > > +  providers.
> > > > +
> > > > +maintainers:
> > > > +  - Francesco Valla <francesco@valla.it>
> > > > +
> > > > +properties:
> > > > +  virtio:
> > > > +    description: Contains a group of Virtio devices exposed by the remoteproc.
> > > > +
> > > > +    properties:
> > > > +      '#address-cells':
> > > > +        const: 1
> > > > +
> > > > +      '#size-cells':
> > > > +        const: 0
> > > > +
> > > > +    patternProperties:
> > > > +      "^vdev@[0-9a-f]+$":
> > > > +        type: object
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            description: Virtio device index inside the resource table.
>

There are 2 configurations we need to account for: (1) each device
located behind the remote processor gets its own set of virtqueues and
adheres to the virtio specifications.  This is the configuration
targeted by this thread.  The other configuration (2), discussed in
the other thread, involves virtio piggy-backed over RPMSG.  The hope
is to represent both configurations using the same bindings.  For (1),
virtio devices will be advertised in the resource table and for (2),
virtio devices will be announced via the existing remoteproc namespace
service.

> Who/what defines the resource table?

The resource table is part of the firmware image and is parsed by the
remoteproc core.  For (1), as presented in this set, "reg" links the
entry in the resource table with the device definition in the DT.  For
(2), the definition is also a device index, but said index is
communicated to the remoteproc core using a namespace announcement
rather than the resource table.

I hope to establish bindings for configuration (1) and merge that work
first.  Once that is done we can extend it to cover (2).

>
> > > > +            maxItems: 1
> > > > +
> > > > +        additionalProperties:
> > > > +          type: object
> > > > +          $ref: /schemas/virtio/virtio-device.yaml
> > > > +          maxItems: 1
> > > > +
> > > > +        required:
> > > > +          - reg
> > > > +
> > > > +    additionalProperties: false
>
> Preferred to put this before 'properties' in the indented cases. Easier
> to see what level it belongs to.
>
> > > > +
> > > > +    required:
> > > > +      - '#address-cells'
> > > > +      - '#size-cells'
> > > > +
> > > > +additionalProperties: true
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    remoteproc-cm33 {
> > > > +      virtio {
> > > > +          #address-cells = <1>;
> > > > +          #size-cells = <0>;
> > > > +
> > > > +          vdev@0 {
> > > > +              reg = <0>;
> > > > +
> > >
> > > Do we need the 'reg' since we already have vdev@X?  I'll let the DT people
> > > provide their input on this.
> > >
> >
> > AFAIK yes, because the rproc_get_vdev_fwnode() helpers search for indexed
> > child nodes using the 'reg' property, not the node name. This I believe
> > is the preferred way of doing things.
>
> It is either both unit-address and reg or neither. It's preferred to
> have them unless you are just making up numbers.
>
> Rob
