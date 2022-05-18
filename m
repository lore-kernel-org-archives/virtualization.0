Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87665C433F5
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 18:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25CEE405CF;
	Wed, 18 May 2022 18:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KhaQMw2D5a5L; Wed, 18 May 2022 18:59:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B353C41015;
	Wed, 18 May 2022 18:59:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A963C0032;
	Wed, 18 May 2022 18:59:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B716C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9AC941015
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nq7kXQLX1-Fc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:59:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04CA8405CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 18:59:06 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id q10so3791086oia.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 11:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hl6vHR8m/JLovYO2gNE3ChbiYGqpt17k+OnwcqxZkjo=;
 b=KoFYhxUA5NlephtwG9bAA3Z7uUf4LRpQO2btPxc9waPMCTqMqv+R6eWk0D2F13BB/u
 Re4UQelV6+M+7X/txK8z/1oDqbUG46ANd4zpKWqe6MjNuooTuFopTUHm/B2AiGJ16XOo
 hpWRUAEPc5CIBzbQfayHl6SySBL20kbFGhgK9fXs580nHu0HVvzkUzNt95Wxprp3qlUU
 k5+H3Nj4r2BlIXUiIYCvcEAxDhmbsahT/pYCO+nWm207muLRpSa2yRkriRA332Q/QxZr
 s0Jb5s/YBkcc4iyMOPZr6VnAjOIZ4SxnrQ95tNd/Ck4b2DRGeDVEP+IYsVlituPS474G
 W6Rg==
X-Gm-Message-State: AOAM532o/5KJ+3Yc9WdUxhJpFJLVG8Hmw2NayVjXRGAWxAX7254N4+r/
 vPWle32L1aROsx/OBYKTgA==
X-Google-Smtp-Source: ABdhPJyZK52/lZYsS9R3kKj1OyynJ0P1NooNpNVdFnOOXczUhwNDyIXF2qHiL1sltyV70oHQTWK1Fg==
X-Received: by 2002:a05:6808:aa4:b0:325:91ff:43cc with SMTP id
 r4-20020a0568080aa400b0032591ff43ccmr623013oij.166.1652900345928; 
 Wed, 18 May 2022 11:59:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 bd15-20020a056870d78f00b000e686d1389esm1202223oab.56.2022.05.18.11.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 11:59:05 -0700 (PDT)
Received: (nullmailer pid 3695375 invoked by uid 1000);
 Wed, 18 May 2022 18:59:04 -0000
Date: Wed, 18 May 2022 13:59:04 -0500
From: Rob Herring <robh@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
Message-ID: <20220518185904.GA3685644-robh@kernel.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
 <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
Cc: Juergen Gross <jgross@suse.com>, DTML <devicetree@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Christoph Hellwig <hch@infradead.org>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, May 18, 2022 at 03:32:27PM +0100, Arnd Bergmann wrote:
> On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
> >
> > diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > index 10c22b5..29a0932 100644
> > --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> > +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> > @@ -13,6 +13,9 @@ description:
> >    See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
> >    more details.
> >
> > +allOf:
> > +  - $ref: /schemas/arm/xen,dev-domid.yaml#
> > +
> >  properties:
> >    compatible:
> >      const: virtio,mmio
> > @@ -33,6 +36,10 @@ properties:
> >      description: Required for devices making accesses thru an IOMMU.
> >      maxItems: 1
> >
> > +  xen,dev-domid:
> > +    description: Required when Xen grant mappings need to be enabled for device.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >  required:
> >    - compatible
> >    - reg
> 
> Sorry for joining the discussion late. Have you considered using the
> generic iommu
> binding here instead of a custom property? This would mean having a device
> node for the grant-table mechanism that can be referred to using the 'iommus'
> phandle property, with the domid as an additional argument.
> 
> It does not quite fit the model that Linux currently uses for iommus,
> as that has an allocator for dma_addr_t space, but it would think it's
> conceptually close enough that it makes sense for the binding.

Something common is almost always better.

That may also have the issue that fw_devlink will make the 'iommu' 
driver a dependency to probe.

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
