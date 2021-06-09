Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2741FC4743D
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 00:56:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D70613AD
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 00:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D70613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D0C283BC8;
	Wed,  9 Jun 2021 00:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzWI9CH8BTHy; Wed,  9 Jun 2021 00:56:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0AD6283B8C;
	Wed,  9 Jun 2021 00:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9332C000E;
	Wed,  9 Jun 2021 00:56:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDBB0C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 00:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90DB583BF1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 00:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Kkzgs3jz8IW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 00:56:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BF8383022
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 00:56:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02560613AD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 00:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623200163;
 bh=9VZZ3dYanjL4pxobsOVDXf3FlQOUGrTbEBeIxBUzJTQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tLBhk39oiVK3KpRQaR9YZJmDnvie7AhI5c+WuPF6RoxdnEx8R8EcKu9pj6YjNz6Rw
 iCkSI+WA3UrEKwqfJxfhbOIwo1PpF3ycLyivyoRxpC7FkoK0FFx/1NZTVnh6axY/pM
 yRt2bevX07Y3CVnoAEnHLTB/Jjq9OqMC8k3RsxjbCndzvMFDZjqyONiRpnHMOZAjYw
 KSGfH9aQimoW6bwYyFuOXk1EjFtOZj0ldN/a5B9LuT7BGl68oLd9k5Lc6iJMyRzoDX
 9dhEbAxjvPrhtJ4QfMZCTZqXQnmDvuzxOfDpJwcCs/W22tm9bsO20k5P6ZnKrSxb53
 w4wNwY2rbI8mw==
Received: by mail-qt1-f169.google.com with SMTP id e3so5147645qte.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 17:56:02 -0700 (PDT)
X-Gm-Message-State: AOAM530aWAh2GcbNjQiI0o0/xvQRTzOxYYxMwPWN18k4p+sfs3jw5btN
 vF2my4QKNH2/vwNrcqslluPmAgjPmAOf/sUVMw==
X-Google-Smtp-Source: ABdhPJysm9gRFl1Ia/PV0WqH78X/KYQI39DaJW4wUxJODVFqslxntRsKzyfSkVIMQAf0+Yem27Ky25KQdgLXYnkXk1s=
X-Received: by 2002:aed:30cd:: with SMTP id 71mr23683635qtf.31.1623200162179; 
 Tue, 08 Jun 2021 17:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210607193928.3092186-1-robh@kernel.org>
In-Reply-To: <20210607193928.3092186-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Jun 2021 19:55:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBYnLixhgVaMRACLAny_3_stqvgxyot2frhiiKP56KXA@mail.gmail.com>
Message-ID: <CAL_JsqKBYnLixhgVaMRACLAny_3_stqvgxyot2frhiiKP56KXA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: virtio: Convert virtio-mmio to DT schema
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: devicetree@vger.kernel.org, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
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

On Mon, Jun 7, 2021 at 2:39 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert the virtio-mmio binding to DT schema format.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Jean-Philippe, hopefully you are okay with being listed as the
> maintainer here. You're the only active person that's touched this
> binding.
>
>  .../devicetree/bindings/virtio/mmio.txt       | 47 ---------------
>  .../devicetree/bindings/virtio/mmio.yaml      | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/virtio/mmio.txt
>  create mode 100644 Documentation/devicetree/bindings/virtio/mmio.yaml
>
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.txt b/Documentation/devicetree/bindings/virtio/mmio.txt
> deleted file mode 100644
> index 0a575f329f6e..000000000000
> --- a/Documentation/devicetree/bindings/virtio/mmio.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -* virtio memory mapped device
> -
> -See https://ozlabs.org/~rusty/virtio-spec/ for more details.
> -
> -Required properties:
> -
> -- compatible:  "virtio,mmio" compatibility string
> -- reg:         control registers base address and size including configuration space
> -- interrupts:  interrupt generated by the device
> -
> -Required properties for virtio-iommu:
> -
> -- #iommu-cells:        When the node corresponds to a virtio-iommu device, it is
> -               linked to DMA masters using the "iommus" or "iommu-map"
> -               properties [1][2]. #iommu-cells specifies the size of the
> -               "iommus" property. For virtio-iommu #iommu-cells must be
> -               1, each cell describing a single endpoint ID.
> -
> -Optional properties:
> -
> -- iommus:      If the device accesses memory through an IOMMU, it should
> -               have an "iommus" property [1]. Since virtio-iommu itself
> -               does not access memory through an IOMMU, the "virtio,mmio"
> -               node cannot have both an "#iommu-cells" and an "iommus"
> -               property.
> -
> -Example:
> -
> -       virtio_block@3000 {
> -               compatible = "virtio,mmio";
> -               reg = <0x3000 0x100>;
> -               interrupts = <41>;
> -
> -               /* Device has endpoint ID 23 */
> -               iommus = <&viommu 23>
> -       }
> -
> -       viommu: iommu@3100 {
> -               compatible = "virtio,mmio";
> -               reg = <0x3100 0x100>;
> -               interrupts = <42>;
> -
> -               #iommu-cells = <1>
> -       }
> -
> -[1] Documentation/devicetree/bindings/iommu/iommu.txt
> -[2] Documentation/devicetree/bindings/pci/pci-iommu.txt
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> new file mode 100644
> index 000000000000..444bfa24affc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/mmio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: virtio memory mapped devices
> +
> +maintainers:
> +  - Jean-Philippe Brucker <jean-philippe@linaro.org>
> +
> +description:
> +  See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
> +  more details.
> +
> +properties:
> +  compatible:
> +    const: virtio-mmio

This should be virtio,mmio.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
