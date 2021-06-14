Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5382C48BE6
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 10:21:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C99B60241
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 10:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C99B60241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5487383B0F;
	Mon, 14 Jun 2021 10:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pHn6Blzd3mhx; Mon, 14 Jun 2021 10:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F386783AB1;
	Mon, 14 Jun 2021 10:21:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C482FC000E;
	Mon, 14 Jun 2021 10:21:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC993C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A86D440387
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OLaiNx2UcwV8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:21:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C14A440383
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 10:21:22 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id e22so8225107pgv.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YZpft7OI/68AkdpRkEG65YPdqz6N6jjlPeJBBm/DAcc=;
 b=ZEy9JljT0S7v4JKqlZp2tbrvTcXn7OssJFRLOCaLdsngU1E0T6hHlKfSOiLofzz+Qd
 CYD89wjmQkJ5qg24VB+qPG1CnGLkXuNVaRjZBqMFxJaq/qlIrixiP8M7mzSgo4aunXgX
 uaYZReiLfSn/RF8T5pFp5dg577Aj4ePvKGNXgtLNhY8SJF2CSwV8F4wLY1rH66F7Bf8V
 aMW6O23psUcC5KK3Z4bqR0a2fUmCTqtHdn1hopGeMV45XRZRBqg8ZEsYR0Ri60IiODOv
 Y9QGP+Tgn3YheWVxFMqjQdkb8ga4uJ1eUqNycNFbG5579Ztpkw2Po4hruC9fiShU+8nY
 6Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YZpft7OI/68AkdpRkEG65YPdqz6N6jjlPeJBBm/DAcc=;
 b=oHDkvddOMxkcTOSPKgAqO7Q4pnCW6WZOzJqlPaD5tUhfR0l8hj/lBKW6OV8EDsB/hG
 O56EoJqedpM/6QPTqyupGfUKjvMv9Sujgijo5GQXtGFGhUumSDEYKKjH/7VaEevq+ibb
 RatAezrrQylOGQUmLkv1wGTaz/BC04qOp/WI1UzpcI+hS8uJoojR6vwXgpk9QdmaZcAD
 4Hfqx2TcdUF1AhrgRZfWb8y4GExqgeALWUgYB6mM/e5BzfKEleqHsygyM6QAmFekQ6sN
 RirVejK9CfmzRTlPXOKEl7rZpBnJVylAZKOTrLBOe9gzcPTKFb6QFdiaF8WbwDq5mxqa
 /e/A==
X-Gm-Message-State: AOAM532T2NYldnYX27TsCGoaPEt+ko1jJ3/XHOOnjFR6vMvacZyG9JFb
 g96GEoHPWe1BEY5SoZkDFjFPBw==
X-Google-Smtp-Source: ABdhPJxqBUAdifrUMvs2Xcf/ymaxIYCbX+e1eFh0GE+mXpPaQBN6YqQMBz8f9vC6UKEwRGT9SoikIA==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr16224536pgp.259.1623666082072; 
 Mon, 14 Jun 2021 03:21:22 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id k25sm12058962pfa.213.2021.06.14.03.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 03:21:21 -0700 (PDT)
Date: Mon, 14 Jun 2021 15:51:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210614102119.qifm5sj7fpg54iqo@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CAK8P3a11YhcEOjauWc872BQv+SO-E5+gnz7Lk6UK42iVw7Oyfg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a11YhcEOjauWc872BQv+SO-E5+gnz7Lk6UK42iVw7Oyfg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Stratos Mailing List <stratos-dev@op-lists.linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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

On 10-06-21, 15:22, Arnd Bergmann wrote:
> Can you give an example of how this would be hooked up to other drivers
> using those gpios. Can you give an example of how using the "gpio-keys" or
> "gpio-leds" drivers in combination with virtio-gpio looks like in the DT?
> 
> Would qemu simply add the required DT properties to the device node that
> corresponds to the virtio device in this case?
> 
> From what I can tell, both the mmio and pci variants of virtio can have their
> dev->of_node populated, but I don't see the logic in register_virtio_device()
> that looks up the of_node of the virtio_device that the of_gpio code then
> tries to refer to.

To be honest, I haven't tried this yet and I was expecting it to be
already taken care of. I was relying on the DTB automatically
generated by Qemu to get the driver probed and didn't have a look at
it as well.

I now understand that it won't be that straight forward. The same must
be true for adding an i2c device to an i2c bus over virtio (The way I
tested that earlier was by using the sysfs file to add a device to a
bus).

This may be something lacking generally for virtio-pci thing, not
sure though.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
