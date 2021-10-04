Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD9C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:14:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC25F61154
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC25F61154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9915884A0D;
	Mon,  4 Oct 2021 15:14:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r9pZ01GaHrlb; Mon,  4 Oct 2021 15:14:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21552849E4;
	Mon,  4 Oct 2021 15:14:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE640C0011;
	Mon,  4 Oct 2021 15:14:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80C9CC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DDAF84A0D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iMwPSLhUSEiK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:14:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58980849FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:14:07 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id u11so12569705uaw.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 08:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=04u9HrHvopK+Qx0rr9TojIrIzwVyQ9P12bAyng4Dcac=;
 b=qP2f+xUsTZTeulZvKN1YKpYTwy/47y/DhlBIYHacHKEbnVuyux+0GyZ5rkx2Tz/Rq+
 VUCdew8pq5NsL9xncYTN3r/9L2E9yVa15hoILGAu0eOCREFhds0k60LLud+TZKtB77ZZ
 E9nsNouFh8s1FAQxQ5RxFtYTjXQ2UFPqCvW6wykQ9Komy1hdPRqojM3+5eWU4EK+LQ+C
 j9eYHDspusE+XAX88WsBBtkOBKtS2NuasIjlPicXAQS1jpmI6XR0mCdWHDnhQwAnQvY2
 IHf52dr/hv3d4Z3Ji3AIQ+hmuljRxShFog8qOBf7iMyU9+VT9K2BMpT8OGGK1QyoUCQc
 8HvA==
X-Gm-Message-State: AOAM532wbyE10JY7uob5laLyaoePvJL5WaCzRRTwXLMwY+i1IOyNNaG7
 Zv0BDN6y0W3M/WZ2RZhcrNfJBNAPGeqNIyOos5Q=
X-Google-Smtp-Source: ABdhPJyV7757NDGwKZMKgvNplAl+Z/hrqly7udXrzzrg4UvhsbNv5XCDntVWXukH0mEfWvrMrHX+meN/Yb93gpCse5g=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr7168725uac.89.1633360446142;
 Mon, 04 Oct 2021 08:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
 <CAHp75VcBVGLbNxnZ4FwvdoyxQjA_V8MVHdrSYOQdxTm5bFDc5g@mail.gmail.com>
In-Reply-To: <CAHp75VcBVGLbNxnZ4FwvdoyxQjA_V8MVHdrSYOQdxTm5bFDc5g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Oct 2021 17:13:54 +0200
Message-ID: <CAMuHMdWctqTZRzrHfTsxnK0JNDa1k0o8SNcGMCG1DejoZM70yw@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 metux IT consult <lkml@metux.net>,
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

Hi Andy,

On Mon, Oct 4, 2021 at 3:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Oct 4, 2021 at 3:45 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
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
> ...
>
> > @@ -414,7 +421,8 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
> >         for (i = 0; i < ngpios; i++) {
> >                 struct gpio_chip *parent = gpiod_to_chip(descs[i]);
> >
> > -               dev_dbg(dev, "%u => gpio-%d\n", i, desc_to_gpio(descs[i]));
> > +               dev_dbg(dev, "%u => gpio %d irq %d\n", i,
> > +                       desc_to_gpio(descs[i]), gpiod_to_irq(descs[i]));
>
> This is an unconditional call that will allocate the IRQ descriptor

If DEBUG and CONFIG_DYNAMIC_DEBUG* are not enabled, it's a no-op
(protected by if (0) { ... }).
If CONFIG_DYNAMIC_DEBUG is enabled, the operation is a no-op if not
enabled dynamically (if (dynamic_checl) { ... }).
If DEBUG (CONFIG_DEBUG_GPIO) is enabled, the output is wanted.

(yes, I've just checked the preprocessor and assembler output ;-).

> even if we don't use it. Correct?

It calls .to_irq() of the parent GPIO controller, which is usually
just doing some offset addition.  But that's driver-dependent.

> If so, I don't like this.

No worries, desc_to_gpio() and gpiod_to_irq() are only evaluated when
the debug output is wanted.

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
