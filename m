Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EE4C433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 22:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4266405A3;
	Fri, 15 Apr 2022 22:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fedpfHshETtT; Fri, 15 Apr 2022 22:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50CC740283;
	Fri, 15 Apr 2022 22:01:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C0BBC0033;
	Fri, 15 Apr 2022 22:01:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D8CAC002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 22:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79DA760F5C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 22:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NrWcaTJRrw12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 22:01:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A73260E30
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 22:01:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 95673B83120;
 Fri, 15 Apr 2022 22:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D90C385A4;
 Fri, 15 Apr 2022 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650060085;
 bh=3nAlILfONam3A1vF12+Z//hbMZsSoLMl3r4snyjFDkg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=R5ACtTmRa1lWffZNP40CcYwujsVyYLvLu7t4cuSkHx/zaTDgutlQ4iwTl0T+OF46E
 KTk2+o63Z5vwr6TH66atXLG4sAjRb/3Fu3/lo+Yd3s4T2y408M4g5eshPM00FXsruY
 gnQywd9MCBBru4u0+hmOTmRr5Sf6fOH6A8aUY3iN3hikuJ5hZX6mYNnkvR8sfqbHJZ
 6cwdJQMOfy9nf5UrBix4ZArxlSXSr5cEKNoGxqL5AE9/8QMWl5q0TSv2lORkNvm+eu
 0mpduXkufAAx6byB3UeBLcqIFKHPEHxW+sH7kFA7AyIzaxOVMzTIUGBGsnuhnJ9rtg
 ul349pv5wZ/2g==
Date: Fri, 15 Apr 2022 15:01:24 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [RFC PATCH 3/6] dt-bindings: xen: Add xen,dev-domid property
 description for xen-virtio layer
In-Reply-To: <1649963973-22879-4-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204151300130.915916@ubuntu-linux-20-04-desktop>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-4-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, devicetree@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Rob Herring <robh+dt@kernel.org>, xen-devel@lists.xenproject.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
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

On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Introduce Xen specific binding for the virtio-mmio device to be used
> by Xen virtio support driver in a subsequent commit.
> 
> This binding specifies the ID of Xen domain where the corresponding
> device (backend) resides. This is needed for the option to restrict
> memory access using Xen grant mappings to work.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
>  .../devicetree/bindings/virtio/xen,dev-domid.yaml  | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
> new file mode 100644
> index 00000000..78be993
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/xen,dev-domid.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/xen,dev-domid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen specific binding for the virtio device
> +
> +maintainers:
> +  - Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> +
> +select: true
> +
> +description:
> +  This binding specifies the ID of Xen domain where the corresponding device
> +  (backend) resides. This is needed for the option to restrict memory access
> +  using Xen grant mappings to work.
> +
> +  Note that current and generic "iommus" bindings are mutually exclusive, since
> +  the restricted memory access model on Xen behaves as a kind of software IOMMU.

I don't think that this last statement is necessary or fully accurate, so
I would remove it. Other than that, this looks good to me.


> +properties:
> +  xen,dev-domid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Should contain the ID of device's domain.

Maybe better as:
"The domid (domain ID) of the domain where the device (backend) is running"



> +additionalProperties: true
> +
> +examples:
> +  - |
> +    virtio_block@3000 {
> +            compatible = "virtio,mmio";
> +            reg = <0x3000 0x100>;
> +            interrupts = <41>;
> +
> +            /* The device is located in Xen domain with ID 1 */
> +            xen,dev-domid = <1>;
> +    };
> -- 
> 2.7.4
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
