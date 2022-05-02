Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FBCC433EF
	for <virtualization@archiver.kernel.org>; Mon,  2 May 2022 21:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 963EE404E9;
	Mon,  2 May 2022 21:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KwHhdohx4n3i; Mon,  2 May 2022 21:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CAAC403BF;
	Mon,  2 May 2022 21:59:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA933C0032;
	Mon,  2 May 2022 21:59:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE2ECC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 21:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DDE4403BF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 21:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9flxyUUABMSe
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 21:59:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA76440445
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 21:59:47 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 m3-20020a4ac683000000b0035f13dde9ccso42892ooq.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 May 2022 14:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OfkNLJQzEZ7e5xPqfxUYJG64Wv+bQWkevq09mi7Lx3c=;
 b=OUDX9wWBoimWD8I614vxjq7ROLgDDPQFxDmvdBekG6FciHY2UgBhsHWnm8O4MetyAu
 1Ky5E012fiy0In36Rxv3b8sgL2TA7RWJeN/PrkmIng1B3XDKoSFF/gZxBVKssUlLsYUY
 T3xmmnxGX984ZSNgjMumLHQHFIbFxqjPlnBziWUNnmBFFu4YGpx0Wg04B3TCk0tBYD/u
 R5GBQZsMLwmtZWZAflefsrSE4D1AryvBripwWFF8vI8bN4HIMat39hhEMxh9hZKmNthu
 Gtmp3FDTaiCFFJashJeS/UtFutKQTKDhMPpUjmRAPm8Wp1RC6kyzCuwUuTci1hgD9GmX
 02JA==
X-Gm-Message-State: AOAM531kVhbtbiQIEAw4/3PyXeQUevGa3W8sroqDZyL4eXlgFG1T3XoS
 lIIGUaGZ2aG7s0uU0tF3qQ==
X-Google-Smtp-Source: ABdhPJx1LDExPGSXpHz8IMEURBsoMHXT9iZfDmEKZxw3kRgHSp4/DSf2T1IKY9UfgGxULbEh9lAUBQ==
X-Received: by 2002:a4a:ac45:0:b0:35e:a8f2:7f55 with SMTP id
 q5-20020a4aac45000000b0035ea8f27f55mr4805941oon.46.1651528786470; 
 Mon, 02 May 2022 14:59:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 s1-20020a4ae541000000b0035eb4e5a6c8sm4329464oot.30.2022.05.02.14.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 14:59:46 -0700 (PDT)
Received: (nullmailer pid 1863055 invoked by uid 1000);
 Mon, 02 May 2022 21:59:45 -0000
Date: Mon, 2 May 2022 16:59:45 -0500
From: Rob Herring <robh@kernel.org>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH V1 4/6] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
Message-ID: <YnBUUclJqkvKsV2o@robh.at.kernel.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1650646263-22047-5-git-send-email-olekstysh@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Apr 22, 2022 at 07:51:01PM +0300, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Introduce Xen specific binding for the virtualized device (e.g. virtio)
> to be used by Xen grant DMA-mapping layer in the subsequent commit.
> 
> This binding indicates that Xen grant mappings scheme needs to be
> enabled for the device which DT node contains that property and specifies
> the ID of Xen domain where the corresponding backend resides. The ID
> (domid) is used as an argument to the grant mapping APIs.
> 
> This is needed for the option to restrict memory access using Xen grant
> mappings to work which primary goal is to enable using virtio devices
> in Xen guests.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Changes RFC -> V1:
>    - update commit subject/description and text in description
>    - move to devicetree/bindings/arm/
> ---
>  .../devicetree/bindings/arm/xen,dev-domid.yaml     | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> new file mode 100644
> index 00000000..ef0f747
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xen,dev-domid.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/xen,dev-domid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific binding for the virtualized device (e.g. virtio)
> +
> +maintainers:
> +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> +
> +select: true

Do we really need to support this property everywhere?

> +
> +description:
> +  This binding indicates that Xen grant mappings scheme needs to be enabled
> +  for that device and specifies the ID of Xen domain where the corresponding
> +  device (backend) resides. This is needed for the option to restrict memory
> +  access using Xen grant mappings to work.
> +
> +properties:
> +  xen,dev-domid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The domid (domain ID) of the domain where the device (backend) is running.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    virtio_block@3000 {

virtio@3000

> +            compatible = "virtio,mmio";
> +            reg = <0x3000 0x100>;
> +            interrupts = <41>;
> +
> +            /* The device is located in Xen domain with ID 1 */
> +            xen,dev-domid = <1>;

This fails validation:

Documentation/devicetree/bindings/arm/xen,dev-domid.example.dtb: virtio_block@3000: xen,dev-domid: [[1]] is not of type 'object'
        From schema: /home/rob/proj/git/linux-dt/Documentation/devicetree/bindings/virtio/mmio.yaml

The property has to be added to the virtio/mmio.yaml schema. If it is 
not needed elsewhere, then *just* add the property there.

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
