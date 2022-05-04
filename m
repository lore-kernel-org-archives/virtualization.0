Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0560C433F5
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 00:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49DB3405D9;
	Wed,  4 May 2022 00:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XD461GBdjCrN; Wed,  4 May 2022 00:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8FC6B40111;
	Wed,  4 May 2022 00:02:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71CBFC0039;
	Wed,  4 May 2022 00:02:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA7AEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 00:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A92640111
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 00:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HIJVwUlfEZa
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 00:02:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A39E4049A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 00:02:10 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-deb9295679so18795822fac.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 May 2022 17:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XPALVs8tri7925YP8yP2QcFpx7h0JSNeGifZWhU99Ro=;
 b=cpqjDQcEJstRZEt9U5y9zj5IdlfNFitzw9BogXPhUq4EWoqSpOV9zYaXzdqQui0Wbz
 dAC37ia5CYlTJ0zYpZOxUlaoWRRwn0g75sVy7ARYXhA+AhXwdpHIsMTcvqd1P/XFJcSS
 gRKGgN4B0cSCOFkMeTJo+N+tjsM7kSaa5Q+TmUnBbCfqDpDKfoL+pcz2JHMQGHo6w1nS
 Q4LEke3F2Xea2YWbjt/URx34D2cEaaeBSYBjKVCXPQBLaSxGleQKBPYNo99pjhLs+kHK
 oWS1hJ8g5Vw4DMY+vPaO5w/nMQfXRTQebXosiLORSYKhioLHXqqbonpzU/CJpB+ShXtH
 MVtA==
X-Gm-Message-State: AOAM5310ymU1jyxDtWBTQfcGT/uxED5AFydmVl6PUxzfAFGxbEKkrnQd
 eEXHHMxTlvyNXLcVs0e51g==
X-Google-Smtp-Source: ABdhPJzDGRHxbFONbrvkkP2SSUKrYke5y7WcShS5ZvQNY7jHJAryoCIKp3IBbg4qJhIn8naxdCDyWw==
X-Received: by 2002:a05:6870:b292:b0:ec:ec79:4842 with SMTP id
 c18-20020a056870b29200b000ecec794842mr2769207oao.145.1651622529455; 
 Tue, 03 May 2022 17:02:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 b14-20020a056870160e00b000e915a9121csm8077296oae.52.2022.05.03.17.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 17:02:08 -0700 (PDT)
Received: (nullmailer pid 275646 invoked by uid 1000);
 Wed, 04 May 2022 00:02:08 -0000
Date: Tue, 3 May 2022 19:02:08 -0500
From: Rob Herring <robh@kernel.org>
To: Oleksandr <olekstysh@gmail.com>
Subject: Re: [PATCH V1 4/6] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
Message-ID: <YnHCgBsQ90cJ58+0@robh.at.kernel.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
 <YnBUUclJqkvKsV2o@robh.at.kernel.org>
 <accbc6be-82c1-dfd2-586f-816141415d7c@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <accbc6be-82c1-dfd2-586f-816141415d7c@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, devicetree@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, May 03, 2022 at 08:09:32PM +0300, Oleksandr wrote:
> =

> On 03.05.22 00:59, Rob Herring wrote:
> =

> Hello Rob
> =

> =

> > On Fri, Apr 22, 2022 at 07:51:01PM +0300, Oleksandr Tyshchenko wrote:
> > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > =

> > > Introduce Xen specific binding for the virtualized device (e.g. virti=
o)
> > > to be used by Xen grant DMA-mapping layer in the subsequent commit.
> > > =

> > > This binding indicates that Xen grant mappings scheme needs to be
> > > enabled for the device which DT node contains that property and speci=
fies
> > > the ID of Xen domain where the corresponding backend resides. The ID
> > > (domid) is used as an argument to the grant mapping APIs.
> > > =

> > > This is needed for the option to restrict memory access using Xen gra=
nt
> > > mappings to work which primary goal is to enable using virtio devices
> > > in Xen guests.
> > > =

> > > Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > ---
> > > Changes RFC -> V1:
> > >     - update commit subject/description and text in description
> > >     - move to devicetree/bindings/arm/
> > > ---
> > >   .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 +++++++++++=
+++++++++++
> > >   1 file changed, 37 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-do=
mid.yaml
> > > =

> > > diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml=
 b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> > > new file mode 100644
> > > index 00000000..ef0f747
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> > > @@ -0,0 +1,37 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Xen specific binding for the virtualized device (e.g. virtio)
> > > +
> > > +maintainers:
> > > +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > +
> > > +select: true
> > Do we really need to support this property everywhere?
> =

> From my understanding - yes.
> =

> As, I think, any device node describing virtulized device in the guest
> device tree can have this property.=A0 Initially (in the RFC series) the
> "solution to restrict memory access using Xen grant mappings" was
> virtio-specific.
> =

> Although the support of virtio is a primary target of this series, we
> decided to generalize this work and expand it to any device [1]. So the X=
en
> grant mappings scheme (this property to be used for) can be theoretically
> used for any device emulated by the Xen backend.
> =

> =

> > > +
> > > +description:
> > > +  This binding indicates that Xen grant mappings scheme needs to be =
enabled
> > > +  for that device and specifies the ID of Xen domain where the corre=
sponding
> > > +  device (backend) resides. This is needed for the option to restric=
t memory
> > > +  access using Xen grant mappings to work.
> > > +
> > > +properties:
> > > +  xen,dev-domid:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      The domid (domain ID) of the domain where the device (backend)=
 is running.
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    virtio_block@3000 {
> > virtio@3000
> =

> ok, will change
> =

> =

> > =

> > > +            compatible =3D "virtio,mmio";
> > > +            reg =3D <0x3000 0x100>;
> > > +            interrupts =3D <41>;
> > > +
> > > +            /* The device is located in Xen domain with ID 1 */
> > > +            xen,dev-domid =3D <1>;
> > This fails validation:
> > =

> > Documentation/devicetree/bindings/arm/xen,dev-domid.example.dtb: virtio=
_block@3000: xen,dev-domid: [[1]] is not of type 'object'
> >          From schema: /home/rob/proj/git/linux-dt/Documentation/devicet=
ree/bindings/virtio/mmio.yaml
> =

> Thank you for pointing this out, my fault, I haven't "properly" checked t=
his
> before. I think, we need to remove "compatible =3D "virtio,mmio"; here

Uhh, no. That just means the example is incomplete. You need to add this =

property or reference this schema from virtio/mmio.yaml.


> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> index 2daa8aa..d2f2140 100644
> --- a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> @@ -28,7 +28,7 @@ additionalProperties: true
> =A0examples:
> =A0=A0 - |
> =A0=A0=A0=A0 virtio_block@3000 {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "virtio,mmio";
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* ... */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x3000 0x100>;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <41>;
> =

> =

> =

> > =

> > The property has to be added to the virtio/mmio.yaml schema. If it is
> > not needed elsewhere, then *just* add the property there.
> =

> As I described above, the property is not virtio specific and can be used
> for any virtualized device for which Xen grant mappings scheme needs to be
> enabled (xen-grant DMA-mapping layer).

But that's a finite list of devices, right? In any case, you have to =

list the property anywhere it can be used.

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
