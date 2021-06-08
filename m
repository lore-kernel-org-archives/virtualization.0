Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14687C47082
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 07:37:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B1A60FE8
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 07:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B1A60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F46883B85;
	Tue,  8 Jun 2021 07:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6KlAzBjcqv3Y; Tue,  8 Jun 2021 07:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F02983B4B;
	Tue,  8 Jun 2021 07:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD27BC000B;
	Tue,  8 Jun 2021 07:37:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C169C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 07:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 318AD403EC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 07:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NfC4qh4GAcvU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 07:37:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 574AD401E8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 07:37:25 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id q5so20416025wrm.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aqDgIwi6bwB437aBxOTYSUXtzGWCe3kLLCFEAAZHgPE=;
 b=Vpc382BZXgKI+GfBZyUIhbEgmNFLd82NW08+0mEeJ8HfsGRRCVVpAJwqS/hGoecG4s
 nRA7+aThXbCjfNNMeKIpHTsesA+eOVgvSS+2026dPwBhnEadCcbSyP2CEfzjsatMmGD1
 i++SBMgCskIn3ilVuuD8naom7oh2KsO+w/IsWCxezyyODRCPEMBPzHZ4igLxZjbSBaLR
 cNJt4NM0l0SfHRZW4mjIL9eBfZu3UrdbweOnWuYsHod2PQIODnASqoNnUbnlGkgFmhYm
 F8X6Y5+GiN2w4EOtwXzP1baR8EbW9By3dtBX9xOa/8iHqOJSvT7i4vQlcD0oS90fyWuG
 HJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aqDgIwi6bwB437aBxOTYSUXtzGWCe3kLLCFEAAZHgPE=;
 b=ekmOi4nxPqsaBApF53rJTw31iu5gNRhLYGkrEJn+DVtkobvqCZsL313M/nCQNypy8q
 Sc0QG823ToBXQbPoXXl/BxzjUwWg0V3y1noiqLD9u+v+vfsb407unw3L7rHTadxhVKlD
 +mFpYOZ7I7Uef5BuM83/+Oyu4Mmg8VAT69+7aWzRAAoe/GzV9ikE7xqKPVQ5srcdvz5X
 qfUnKnO8+s3xvqnYB9ERcCXnvcQyyxpHiAdSyABHqHJJewyssPPT4cQF/76ZjhiVggo2
 GQf83pkRdFM5WdqgrImtPfNr37SRYhU3U65YHT4xTjKnKG6Wkw0yImkMi0w2IVA/y3N7
 vxfQ==
X-Gm-Message-State: AOAM530uOhgNI5xaZAr1XEJwB3uLaQm++g0Vjia6hcKs2f1+QHaRhlxy
 fXaN3qlDaS0FEBLlq3rvamBbjA==
X-Google-Smtp-Source: ABdhPJy+68l5PmJs0kj9agOIcHClM5Q1p0eRyup1PdePPYEjZ1YGVRvm0vt7N6cOavVqcnc0O1llwg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr16041869wrm.46.1623137843374; 
 Tue, 08 Jun 2021 00:37:23 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id u7sm15406086wrt.18.2021.06.08.00.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 00:37:22 -0700 (PDT)
Date: Tue, 8 Jun 2021 09:37:03 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: virtio: Convert virtio-mmio to DT schema
Message-ID: <YL8eHxe4dpE4R2Bm@myrica>
References: <20210607193928.3092186-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607193928.3092186-1-robh@kernel.org>
Cc: devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Jun 07, 2021 at 02:39:28PM -0500, Rob Herring wrote:
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

Sure, no problem. I can work on the conversion of virtio/iommu.txt as
well, so I'll learn a bit more about the yaml syntax.

Acked-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

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
> -- compatible:	"virtio,mmio" compatibility string
> -- reg:		control registers base address and size including configuration space
> -- interrupts:	interrupt generated by the device
> -
> -Required properties for virtio-iommu:
> -
> -- #iommu-cells:	When the node corresponds to a virtio-iommu device, it is
> -		linked to DMA masters using the "iommus" or "iommu-map"
> -		properties [1][2]. #iommu-cells specifies the size of the
> -		"iommus" property. For virtio-iommu #iommu-cells must be
> -		1, each cell describing a single endpoint ID.
> -
> -Optional properties:
> -
> -- iommus:	If the device accesses memory through an IOMMU, it should
> -		have an "iommus" property [1]. Since virtio-iommu itself
> -		does not access memory through an IOMMU, the "virtio,mmio"
> -		node cannot have both an "#iommu-cells" and an "iommus"
> -		property.
> -
> -Example:
> -
> -	virtio_block@3000 {
> -		compatible = "virtio,mmio";
> -		reg = <0x3000 0x100>;
> -		interrupts = <41>;
> -
> -		/* Device has endpoint ID 23 */
> -		iommus = <&viommu 23>
> -	}
> -
> -	viommu: iommu@3100 {
> -		compatible = "virtio,mmio";
> -		reg = <0x3100 0x100>;
> -		interrupts = <42>;
> -
> -		#iommu-cells = <1>
> -	}
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
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#iommu-cells':
> +    description: Required when the node corresponds to a virtio-iommu device.
> +    const: 1
> +
> +  iommus:
> +    description: Required for devices making accesses thru an IOMMU.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    virtio@3000 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3000 0x100>;
> +        interrupts = <41>;
> +
> +        /* Device has endpoint ID 23 */
> +        iommus = <&viommu 23>;
> +    };
> +
> +    viommu: iommu@3100 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3100 0x100>;
> +        interrupts = <42>;
> +
> +        #iommu-cells = <1>;
> +    };
> +
> +...
> -- 
> 2.27.0
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
