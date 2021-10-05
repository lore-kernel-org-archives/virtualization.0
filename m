Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D98C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 06:53:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83208613B5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 06:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83208613B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A25A83CFA;
	Tue,  5 Oct 2021 06:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJg4J0kYqjg3; Tue,  5 Oct 2021 06:53:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E16E480E41;
	Tue,  5 Oct 2021 06:53:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0013C0011;
	Tue,  5 Oct 2021 06:53:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13108C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 06:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8C0340183
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 06:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nH75mHnyeCf4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 06:53:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C866C400B9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 06:53:11 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id 64so14117746uab.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 23:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n5rvDJLT46KKVmj57QzEkEkQwVXnYVpO8DvlptVRyCA=;
 b=WHR0xC0cTNoBOUhAulfgz14x4TPqKDltIuz8T3JLnuoffJUXw4LanTXw0E6K02Iug3
 ixuZaSwZXT5TfVEXYcXt+7wduB4NSaFmhtpmQl81SR4/OoOfMsI7wAGJvLyYF8vePCyy
 M6AWxQehoJ/fZfZceCKiOncC60GmPq7Tosr3oBO1dhtPvFu6YhilOCwRXpo3M71/xCHP
 9wfXbHgkjbXwQLzpuyR+F4rA5hg8SUZzcu/iUPCDS8Lw2EyvFI0G6uFkEiU3R2qzSuzJ
 HjOkuf9uLOSoPQDbnrshkxHyT6HpX3psrPV8kC7mtyUZkREl7pHexhoEQ5EWHCLn/r09
 yBAw==
X-Gm-Message-State: AOAM530OAZjewMoHdX4qYN5onLaxt8Ee2ZLXVqcJAe5XGW8gw+0jvv/M
 pTYEgyn1vmdfxpNYVnXrK5LEcQk8FzGhIz+pwvo=
X-Google-Smtp-Source: ABdhPJy5k1nMkYMYkWxdc7yorDKtTzk8W9HuAKjJZVnHbBCfhiYAPghoP07JTjh7MLd8GwhUpT80oTqR0wBZYVkKy3U=
X-Received: by 2002:ab0:16d4:: with SMTP id g20mr10581513uaf.114.1633416790751; 
 Mon, 04 Oct 2021 23:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
 <20211005055050.ggimidaqis5tfxav@vireshk-i7>
In-Reply-To: <20211005055050.ggimidaqis5tfxav@vireshk-i7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Oct 2021 08:52:59 +0200
Message-ID: <CAMuHMdVk6gDcHtYSM=Y8BAK=GVJuLqxTHk7zS4-MJPi0H0T=jQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Enrico@rox.of.borg, Arnd Bergmann <arnd@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 metux IT consult <lkml@metux.net>, Weigelt@rox.of.borg,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 stratos-dev@op-lists.linaro.org
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

Hi Viresh,

On Tue, Oct 5, 2021 at 7:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 04-10-21, 14:44, Geert Uytterhoeven wrote:
> > Currently the GPIO Aggregator does not support interrupts.  This means
> > that kernel drivers going from a GPIO to an IRQ using gpiod_to_irq(),
> > and userspace applications using line events do not work.
> >
> > Add interrupt support by providing a gpio_chip.to_irq() callback, which
> > just calls into the parent GPIO controller.
> >
> > Note that this does not implement full interrupt controller (irq_chip)
> > support, so using e.g. gpio-keys with "interrupts" instead of "gpios"
> > still does not work.
>
> Thanks for looking into this. I am not sure of the difference it makes
> with and without full irq-chip, but lemme explain the use case that we
> are concerned about with virtio.
>
> Eventually the interrupt should be visible to userspace, with
> something like libgpiod. Which can then send the information over
> virtio to the guest.

Exactly, that was what I had in mind, too.

> Will the interrupts be visible in userspace with your patch ?

Yes they are.
Before, gpiomon (test app from libgpiod) didn't work, now it does.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
