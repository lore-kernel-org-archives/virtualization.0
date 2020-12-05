Return-Path: <SRS0=Hf4y=FJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39458C433FE
	for <virtualization@archiver.kernel.org>; Sat,  5 Dec 2020 19:32:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EA922DBF
	for <virtualization@archiver.kernel.org>; Sat,  5 Dec 2020 19:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EA922DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF50687936;
	Sat,  5 Dec 2020 19:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CGVMEfxAqOIK; Sat,  5 Dec 2020 19:32:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ECD7E8792B;
	Sat,  5 Dec 2020 19:32:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD37EC0FA8;
	Sat,  5 Dec 2020 19:32:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17C5DC013B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 19:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 062A087930
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 19:32:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8agbW---kJua
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 19:32:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3313F8792B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607196733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0EK7Xx+WJiCxdoOjpYgymlmknRa2p5m+dwzuMaOFjc=;
 b=CsZ2ecsWkH9aZ7TQrI8ZO8vKeTWj/6G6l/KP0XCzPPH11IyPN3ReCyBZhPOMg7SfADZ1FL
 jxuSkqyFwE4svtyAV6jv1MNMUQStGry0ewGSFKU70X4qBGax42WZTw362TU6yAu3jPQ3L6
 iYDOYSI8ZKmVM7d+h+Ofmx0CeFO31Ho=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-PQXYH78PMMyQzlTYnM62hg-1; Sat, 05 Dec 2020 14:32:12 -0500
X-MC-Unique: PQXYH78PMMyQzlTYnM62hg-1
Received: by mail-wm1-f72.google.com with SMTP id q17so2953827wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 05 Dec 2020 11:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ofSC9lpwG6+UCSNudemJILG6AFj0fHelQy+fBqMM60g=;
 b=tgh1YJvKeIdYHzaS7V6yp1LcXJLOg4zqoJwrIgWKJ0pcB6HBAjt20qqLS0NwGbBi74
 9+a1O/CCIkt0l8QhUHSJ6Z0hPXEbQLhmjjmhhLPsZOW6PFSiGx/4oEu5Dr53oP9+c60y
 JzcXxjEQFkbV48uQpZzUFbs2PCefTJfMf0UKgbtrLHx0xh/+HpBWf6z5iOdqbX7+qHep
 adajuoeOuKgdh37z16Qcc0V4QGP4bu/uOQaxYoZ215RMcXTonlmE8E53baGiYmXXXt02
 8eE2WzclsqVsDdm4MJ3U3pQ4HyS14L11Ex4R1NZ7g6lPVIdOs1qL5g86/d0g3i5mfEU5
 i5Hw==
X-Gm-Message-State: AOAM533koL4yuuQTg508VBnPQ99iFy1r0JL1fl8lEyDi/vXo8rEmK7eu
 c6pz9rYeit7F6B3hNgQWVlgPaJxTFqa45sTmce+U7AZHi4JEXtOUCXRd+UAnSSZh2a8thWHVZ02
 bxuMSj20ztcml8gJAxPyglmlMggt1ATu9FtOy14tLww==
X-Received: by 2002:a1c:9d85:: with SMTP id
 g127mr10659853wme.118.1607196729259; 
 Sat, 05 Dec 2020 11:32:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTZFGnBU4zJ3vNUAlp7Lk23tATWWb8vX7NoCe2Rd1SBGhMQ9NKv0j2hhmXa23rEif7aIjTgQ==
X-Received: by 2002:a1c:9d85:: with SMTP id
 g127mr10659834wme.118.1607196729032; 
 Sat, 05 Dec 2020 11:32:09 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id b14sm8512163wrq.47.2020.12.05.11.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Dec 2020 11:32:08 -0800 (PST)
Date: Sat, 5 Dec 2020 14:32:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20201205142218-mutt-send-email-mst@kernel.org>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
MIME-Version: 1.0
In-Reply-To: <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: stefanha@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
 linux-riscv@lists.infradead.org, msuchanek@suse.de, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, linus.walleij@linaro.org
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

On Sat, Dec 05, 2020 at 08:59:55AM +0100, Enrico Weigelt, metux IT consult =
wrote:
> On 04.12.20 04:35, Jason Wang wrote:
> =

> >> --- a/drivers/gpio/Kconfig
> >> +++ b/drivers/gpio/Kconfig
> >> @@ -1615,6 +1615,15 @@ config GPIO_MOCKUP
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tools/testing/selftests/gpi=
o/gpio-mockup.sh. Reference the
> >> usage in
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 it.
> >> =C2=A0 +config GPIO_VIRTIO
> >> +=C2=A0=C2=A0=C2=A0 tristate "VirtIO GPIO support"
> >> +=C2=A0=C2=A0=C2=A0 depends on VIRTIO
> > =

> > =

> > Let's use select, since there's no prompt for VIRTIO and it doesn't have
> > any dependencies.
> =

> whoops, it's not that simple:
> =

> make: Entering directory '/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git'
> make[1]: Entering directory
> '/home/nekrad/src/dk/DistroKit/platform-x86_64/build-target/linux-5.8.9-b=
uild'
>   GEN     Makefile
> drivers/gpu/drm/Kconfig:74:error: recursive dependency detected!
> drivers/gpu/drm/Kconfig:74:	symbol DRM_KMS_HELPER is selected by
> DRM_VIRTIO_GPU
> drivers/gpu/drm/virtio/Kconfig:2:	symbol DRM_VIRTIO_GPU depends on VIRTIO
> drivers/virtio/Kconfig:2:	symbol VIRTIO is selected by GPIO_VIRTIO
> drivers/gpio/Kconfig:1618:	symbol GPIO_VIRTIO depends on GPIOLIB
> drivers/gpio/Kconfig:14:	symbol GPIOLIB is selected by I2C_MUX_LTC4306
> drivers/i2c/muxes/Kconfig:47:	symbol I2C_MUX_LTC4306 depends on I2C
> drivers/i2c/Kconfig:8:	symbol I2C is selected by FB_DDC
> drivers/video/fbdev/Kconfig:63:	symbol FB_DDC depends on FB
> drivers/video/fbdev/Kconfig:12:	symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:80:	symbol DRM_KMS_FB_HELPER depends on
> DRM_KMS_HELPER
> =

> Seems that we can only depend on or select some symbol - we run into
> huge trouble if thats mixed. Just changed DRM_VIRTIO_GPU to just select
> VIRIO instead of depending on it, and now it works.
> =

> I've posted another patch for fixing drivers/gpu/drm/virtio/Kconfig
> to use 'select' instead of 'depends on'.

It seems a bit of a mess, at this point I'm not entirely sure when
should drivers select VIRTIO and when depend on it.

The text near it says:

# SPDX-License-Identifier: GPL-2.0-only
config VIRTIO
        tristate
        help
          This option is selected by any driver which implements the virtio
          bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
          or CONFIG_S390_GUEST.

Which seems clear enough and would indicate drivers for devices *behind*
the bus should not select VIRTIO and thus presumably should "depend on" it.
This is violated in virtio console and virtio fs drivers.

For console it says:

commit 9f30eb29c514589e16f2999ea070598583d1f6ec
Author: Michal Suchanek <msuchanek@suse.de>
Date:   Mon Aug 31 18:58:50 2020 +0200

    char: virtio: Select VIRTIO from VIRTIO_CONSOLE.
    =

    Make it possible to have virtio console built-in when
    other virtio drivers are modular.
    =

    Signed-off-by: Michal Suchanek <msuchanek@suse.de>
    Reviewed-by: Amit Shah <amit@kernel.org>
    Link: https://lore.kernel.org/r/20200831165850.26163-1-msuchanek@suse.de
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

which seems kind of bogus - why do we care about allowing a builtin
virtio console driver if the pci virtio bus driver is a module?
There won't be any devices on the bus to attach to ...

And for virtio fs it was like this from the beginning.

I am inclined to fix console and virtio fs to depend on VIRTIO:
select is harder to use correctly ...

Jason?


> -- =

> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
