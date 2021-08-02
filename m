Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E4C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:40:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6856360E09
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6856360E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6D4B401EA;
	Mon,  2 Aug 2021 19:40:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BzZNPTNt1Z57; Mon,  2 Aug 2021 19:40:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 662C040022;
	Mon,  2 Aug 2021 19:40:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39143C0010;
	Mon,  2 Aug 2021 19:40:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 842EEC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B3FB40394
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsNK_tpZ3EBc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com
 [209.85.166.177])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73AA940393
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:32 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id z3so17466065ile.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 12:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J8SamgvZjMzZn8SFG0WG31f9EjYNKG8kJLg4LvePeV4=;
 b=dOzSFcUuTmuZtNBQulagr+PGmH3dX8VhNjKHKw4SGl8YMmFSx65mceFRne7sBFlql2
 DwcFYER8BjuVhVHFjhVuzQqp4k7R7ibO6O7MJ6YYcXGZBmj8IBorEfT5qr90C1ho58Ll
 kl/9SyKpZ33jLxMexZhrrje/9ca3fxdGtZ3ru3CJhzCe+366+5uWwlEWsrPPFcCv42Gz
 iOXcenl6OtFqIC7gk0ctRnn+sqUT+kPVVOh8+qz+0sSOe8JXEFp7SF3X+GcF+bA/AhIs
 RygpnIvVdgaj+E7lDX0c1WoYcPq6sxRl3hwKQQU6UJgRxkrv1XHYT5ROkaremnib5m1K
 1TUA==
X-Gm-Message-State: AOAM533QRj4tBbhqeOXetZ9bs5ong3NZpZSALm7rLy4F7haLiIz1PBM0
 c+IWK725/IqdX8VMJIWxvg==
X-Google-Smtp-Source: ABdhPJyPJE+Qj7qQn68NldmLQPEMe/MUrKp2yfQyf7zytJe8uOU6ZNPkulS1r9hRjNuLeHzyrwrO/Q==
X-Received: by 2002:a92:b108:: with SMTP id t8mr605095ilh.6.1627933231644;
 Mon, 02 Aug 2021 12:40:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id c8sm7708834ioa.51.2021.08.02.12.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 12:40:30 -0700 (PDT)
Received: (nullmailer pid 1475286 invoked by uid 1000);
 Mon, 02 Aug 2021 19:40:27 -0000
Date: Mon, 2 Aug 2021 13:40:27 -0600
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
Message-ID: <YQhKKyPmOUE8z+US@robh.at.kernel.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <acf7402ef4aabc0ad6295c32846f2bef1cd9b56a.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acf7402ef4aabc0ad6295c32846f2bef1cd9b56a.1627362340.git.viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bill Mills <bill.mills@linaro.org>
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

On Tue, Jul 27, 2021 at 10:53:50AM +0530, Viresh Kumar wrote:
> This patch adds binding for virtio GPIO controller, it is based on
> virtio-device bindings.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/gpio/gpio-virtio.yaml | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
> new file mode 100644
> index 000000000000..601d85754577
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-virtio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtio GPIO controller
> +
> +maintainers:
> +  - Viresh Kumar <viresh.kumar@linaro.org>
> +
> +allOf:
> +  - $ref: /schemas/virtio/virtio-device.yaml#
> +
> +description:
> +  Virtio GPIO controller, see /schemas/virtio/virtio-device.yaml for more
> +  details.
> +
> +properties:
> +  $nodename:
> +    const: gpio
> +
> +  compatible:
> +    const: virtio,device29
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2

Humm, how does one implement interrupts without a parent interrupt? It 
uses the parent virtio,mmio interrupt?

> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    virtio@3000 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3000 0x100>;
> +        interrupts = <41>;
> +
> +        gpio {
> +            compatible = "virtio,device29";
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };
> +    };
> +
> +...
> -- 
> 2.31.1.272.g89b43f80a514
> 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
