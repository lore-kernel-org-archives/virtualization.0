Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572EAC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 13:52:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF11C2343F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 13:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF11C2343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6AA3B2E203;
	Mon,  7 Dec 2020 13:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d4v6ChzosyMz; Mon,  7 Dec 2020 13:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 13B142E200;
	Mon,  7 Dec 2020 13:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07A3CC0893;
	Mon,  7 Dec 2020 13:52:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E59ADC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E14448789A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0Pnr7l4Hq9u
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:52:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C42587899
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607349150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwkrY6cjQW6l0lAUCv8oVDdwg/KrYKuVcu8dAb8pkjA=;
 b=Oz/dz3qIZ8JZZQdc+6vRtAfh8FCPgZdTWXH1PfU/kOrisaU7Z4jMOuo/V/tebA9GBXHOAe
 WF0BKLg4O7Bz4U3dl2tWJ4rSLxgWjCnGgC4DZHCc5bTG+OrwGP4dpiveGeAyXP1Ez3oRHc
 TqndER+TWzjCNyAmGh5oXmfKMwLcYFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-UaKZ93CpOmaT8zMUTWbiKA-1; Mon, 07 Dec 2020 08:52:28 -0500
X-MC-Unique: UaKZ93CpOmaT8zMUTWbiKA-1
Received: by mail-wr1-f72.google.com with SMTP id r11so2938900wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 05:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=o2eDRpg2p3nscNNP24Y5Wwi2J4Ejtn5EoY7jP2IsnBU=;
 b=BZihnULGDizG94USnh3uBAhXtViVOe+vPTOc0/ZEcoMy3nA17pDMzQG0589gUSYFGN
 IO8utRWI8evF/ayd6tCulqJ1hMT5+8IrnruggYBfqpF0nPs2AxovWiDhjvEXZSj5v/A3
 r25Few9TeCQ/AkKWFa9vfajx+t+Ry2kYvYCUpvjn/oz20l1/N0SNdKQ+0Xz/CKH72lXa
 Pb8rtuu4z6lM5cAwESCstQ62TXvoU9FNXJIE7jAOGI1nWIlIVq4Bnn721HKZPmv8WFiZ
 MzU/WvaHp6c5SmeweyTG3GgHGmeKZiRjJ4mJBpMc9BozEdGSvOtQqXUGhnzMvZJKc30L
 29kw==
X-Gm-Message-State: AOAM533F0iB1u1WEEjF0nXz6SPOM8+gbF6euiGTa3KNyMVGHqC0Pawpy
 AzG6zX/vBxClIS4GfbHO/TVJqg0nulWbfjUrw9e7rNfaHHkjsEdsoLQ+f91GRzqCnbHeDbo6MJe
 8KSTuVnKS/xHeyemdsItL8HYR/TJuT+w5Pdy5bUwEAA==
X-Received: by 2002:a5d:5689:: with SMTP id f9mr19985952wrv.181.1607349145791; 
 Mon, 07 Dec 2020 05:52:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxry8r99XfuZsd9xpT/D3HhTrDgujG2fkSVGb9ILMFpXGDKe10crdm3NpHJ20Ml9kS7Zd7JfA==
X-Received: by 2002:a5d:5689:: with SMTP id f9mr19985923wrv.181.1607349145521; 
 Mon, 07 Dec 2020 05:52:25 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id h14sm13884316wrx.37.2020.12.07.05.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 05:52:24 -0800 (PST)
Date: Mon, 7 Dec 2020 08:52:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20201206075131-mutt-send-email-mst@kernel.org>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
 <20201205142218-mutt-send-email-mst@kernel.org>
 <e69569b5-0c45-e072-5de4-81a4acecdae3@metux.net>
MIME-Version: 1.0
In-Reply-To: <e69569b5-0c45-e072-5de4-81a4acecdae3@metux.net>
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

On Sat, Dec 05, 2020 at 09:05:16PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> On 05.12.20 20:32, Michael S. Tsirkin wrote:
> =

> Hi,
> =

> > It seems a bit of a mess, at this point I'm not entirely sure when
> > should drivers select VIRTIO and when depend on it.
> =

> if VIRTIO just enables something that could be seen as library
> functions, then select should be right, IMHO.
> =

> > The text near it says:
> > =

> > # SPDX-License-Identifier: GPL-2.0-only
> > config VIRTIO
> >         tristate
> =

> oh, wait, doesn't have an menu text, so we can't even explicitly enable
> it (not shown in menu) - only implicitly. Which means that some other
> option must select it, in order to become availe at all, and in order
> to make others depending on it becoming available.
> =

> IMHO, therefore select is the correct approach.
> =

> =

> >         help
> >           This option is selected by any driver which implements the vi=
rtio
> >           bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RP=
MSG
> >           or CONFIG_S390_GUEST.
> > =

> > Which seems clear enough and would indicate drivers for devices *behind*
> > the bus should not select VIRTIO and thus presumably should "depend on"=
 it.
> > This is violated in virtio console and virtio fs drivers.
> =

> See above: NAK. because it can't even be enabled directly (by the user).
> If it wasn't meant otherwise, we'd have to add an menu text.


The point is that user enables one of the bindings.
That in turn enables drivers. If we merely select VIRTIO
there's a chance user won't remember to select any bindings
and will be surprised not to see any devices.



> > For console it says:
> > =

> > commit 9f30eb29c514589e16f2999ea070598583d1f6ec
> > Author: Michal Suchanek <msuchanek@suse.de>
> > Date:   Mon Aug 31 18:58:50 2020 +0200
> > =

> >     char: virtio: Select VIRTIO from VIRTIO_CONSOLE.
> >     =

> >     Make it possible to have virtio console built-in when
> >     other virtio drivers are modular.
> >     =

> >     Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> >     Reviewed-by: Amit Shah <amit@kernel.org>
> >     Link: https://lore.kernel.org/r/20200831165850.26163-1-msuchanek@su=
se.de
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > =

> > which seems kind of bogus - why do we care about allowing a builtin
> > virtio console driver if the pci virtio bus driver is a module?
> > There won't be any devices on the bus to attach to ...
> =

> When using other transports ?

Any transport selects VIRTIO so if you enable that, you get
VIRTIO and thus it's enough to depend on it.

> In my current project, eg. I'm using mmio - my kernel has pci completely
> disabled.
> =

> > I am inclined to fix console and virtio fs to depend on VIRTIO:
> > select is harder to use correctly ...
> =

> I don't thinkt that would be good - instead everybody should just select
> VIRTIO, never depend on it (maybe depend on VIRTIO_MENU instead)

GPU depends on VIRTIO and on VIRTIO_MENU ... which seems even messier
...

> =

> --mtx
> =

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
