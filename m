Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7B8C433EF
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 14:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 997AF417D5;
	Wed, 18 May 2022 14:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NOpz3KW1Wfev; Wed, 18 May 2022 14:32:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E5CA141803;
	Wed, 18 May 2022 14:32:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C52C0032;
	Wed, 18 May 2022 14:32:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 104D0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 14:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2D38408E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 14:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wW3kMxV9Mt7O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 14:32:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B972404D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 14:32:34 +0000 (UTC)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N3bnP-1nj2w01X1f-010czE for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:32:31 +0200
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-2fedd26615cso26481517b3.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 07:32:30 -0700 (PDT)
X-Gm-Message-State: AOAM5320I5cMsJl/pm5Y2nJ48ohLQf0X+0HbIhYcjBqCjSb9/OpEAmYA
 0qiVMSuUkBFCqEdLIP9wsZl2jaqzGYZobga2xoQ=
X-Google-Smtp-Source: ABdhPJxlE4uUCuxvYT1DUTMaDWGZzPyyY5pBzmvWGxQQ4rCwL5f9fheKzGazF0y+V/+NQaENE1GQBL2EymP+kgt99NY=
X-Received: by 2002:a81:6283:0:b0:2ff:2443:6f3c with SMTP id
 w125-20020a816283000000b002ff24436f3cmr9731868ywb.135.1652884349891; Wed, 18
 May 2022 07:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1651947548-4055-6-git-send-email-olekstysh@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 May 2022 15:32:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
Message-ID: <CAK8P3a2cAnXr8TDDYTiFxTWzQxa67sGnYDQRRD+=Q8_cSb1mEw@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] dt-bindings: Add xen,dev-domid property
 description for xen-grant DMA ops
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
X-Provags-ID: V03:K1:Kkmd/zkW1ukQBukbM5EpZTe/wNIh4iqEj7Xq79GR/0RfmsBPYN5
 oGCwXfbcaRwqLBor7W7YP4FmXVJ6OS27ZeWS3GyWdRKXTO19H+LaXVNyFFJkHxpZQsJe3EL
 /NScj93IQqSxPgwyuoQHEtItrk6GPM8HLiH3qYFpkldDb+B5WvmsJ1fLFKcvW0k9a4llLda
 qo9Lxwgo5dkv0EquOLfdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uiNBreb/xb0=:2LR0OV09RkhwCI5G5ZcqNL
 rCeYpOxkw6vGJ3vvTrQmTBNdffb7VmK76eeJucVeJEovrAPGEViXPkbftBu/Feuf8oGdbyvMZ
 FoMZTja5pehjd50OvoDEtbzR8Ooinh8BcleofqWBgadR9vFkc4jh5oCI9y7DdO7zyAUSD20Gc
 mIrN3iVikHX1MOg4wTRWyEUSOaaeIgYPSOCU+eQpLp5i8++Vtw6Y7Bzco99e0axLcHMyMf02n
 Z0eQa4y2M0jhwYYw62guKVBuHtsH0waEq5kYD7p4HH0V5umfbaXleQ9zOBHOcd4ey+2XTBVgG
 xmv/BTrPbfjLVNU94Q68SaFhQX7yI1A5/QnylxoDzetcPsq0TnflthuvSAP9aK2NK8mlbC/6L
 +tpp3ltGSMS3Oj9dl0wfCN5N9oEbINjD2yE53g0o/zen1C7cgAYdB8HLvq/Zw16JhYWr5RGKf
 S8AFxnW8T3I8Fx+tSYoMoIwvkUltIWKVrXPtlYGhuGS390Y47HgbJhjfQHdHBHTwW+0P4WsdN
 IDo3c6ScYehIfEkt8XwHtnWAIQYA1eC5NlXOi3LzUDEv0HC82tYL0x5JM3sPsgYRg1Uyc/kJ+
 cEOwwhgOmlpzZl2ehmTVjmRQRQOPZxzR4mSFtKCyoxAo1fDpnAMbdOVpHo5VCwXD2vUZgCY99
 G6phZhZcquFpkGTzgBkEjO3ru/oOsD4GOFFeTyK3kMlCaQ8mH6BVFMzgOgXtnApJjlXxwrXJn
 +bgJxseAg7W1hRPW1N5IjrNBjE+vghwTTovLlE/vfXSr+CwU1i0/lzQJNQMoHG3z4MgbQt+lT
 uT4j0fEKwCpbmZYVpPAmznY/n26icY6raCuWWwglA7IKq4RH8REWuc0Hr8y7gRt9C1zFUMNyd
 iiKr0Z4kpSMUv3q4haBA==
Cc: Juergen Gross <jgross@suse.com>, DTML <devicetree@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>,
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

On Sat, May 7, 2022 at 7:19 PM Oleksandr Tyshchenko <olekstysh@gmail.com> wrote:
>
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index 10c22b5..29a0932 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -13,6 +13,9 @@ description:
>    See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
>    more details.
>
> +allOf:
> +  - $ref: /schemas/arm/xen,dev-domid.yaml#
> +
>  properties:
>    compatible:
>      const: virtio,mmio
> @@ -33,6 +36,10 @@ properties:
>      description: Required for devices making accesses thru an IOMMU.
>      maxItems: 1
>
> +  xen,dev-domid:
> +    description: Required when Xen grant mappings need to be enabled for device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>  required:
>    - compatible
>    - reg

Sorry for joining the discussion late. Have you considered using the
generic iommu
binding here instead of a custom property? This would mean having a device
node for the grant-table mechanism that can be referred to using the 'iommus'
phandle property, with the domid as an additional argument.

It does not quite fit the model that Linux currently uses for iommus,
as that has an allocator for dma_addr_t space, but it would think it's
conceptually close enough that it makes sense for the binding.

         Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
