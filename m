Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C3C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 13:21:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C8A60F39
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 13:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07C8A60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE3744274F;
	Mon,  4 Oct 2021 13:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emv1aUFnAYyS; Mon,  4 Oct 2021 13:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B98F4274D;
	Mon,  4 Oct 2021 13:21:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2AD3C0011;
	Mon,  4 Oct 2021 13:21:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD0AAC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6D5740134
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GzGRGkoV__kq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:21:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66782400C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:21:35 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id x7so63234893edd.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Oz9vve8zThdv/wPK7/DByuqhiCMubVfBEBzCDs6tqrs=;
 b=m6AMYsE89oo56yvenoWJ5bhL0vlQJeSsBI3wfBZ8GcyyJCXpFQhNNniTO5Q+wWhbs0
 aKNVi77NhYG2SiPMcCCiQUaSQ2prjJiUw6ieb2F8QLEIw3In7fZElaHwt7x6z24LBVLC
 Jm+6+Ci1NHBdT9ksTYlKWeMCFqpiHFoaIuDly/KZ5zysTnxLc3b+NkBdb5uXfUkY3kN9
 cGDowUlx2ZE92sr/pBEda83jPMMit5++C8vIxgHz8+Xa9ve+O3V8Nmw6CjGvulKFq1MM
 w0vSlT53Txdy6PG7YlRbhdF90Ycdw09c1fx5xci8Z/67rJ5ouIwHz4R12wyY//88W4JG
 H1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oz9vve8zThdv/wPK7/DByuqhiCMubVfBEBzCDs6tqrs=;
 b=FZol5iUMmmVZ1Ub+PqkAG6HQdWVf7E2M9LkV02bhxLa3WcEXF+/dtE6BmEm7eg6j83
 bN5rcSzGP7rn0BBInsJ8+pzkU3YgBL81BExdiE67BW8ceN1ouXiSR7faPkigozI1p0yg
 j1MYdWRNCXqtlKLi80+rzWSAQLtyAVE0dmeSq1dvDeRaOVUNFjhfUhyd2Ge1Y0Q1dTW8
 m2tTz4M0PRM3z3pouTdhg+CGjl6jWoti8AI9Ff6xD9ZTvxLGHUmLgMtMj+G+8x5YkT1N
 IuuCbBfOC11myXyP4Xa04c+swFOKEIVPwcIrYI1C87oQSfAk7vtsf96cskyGfktKnvLw
 KdNQ==
X-Gm-Message-State: AOAM533+5spgMLltSzBIlDSIOQNVRX4zeS+uVjiuwX1a+JPRIFvzAE9x
 Q5QjuNY2UeYssLGL/XLZ6+ugAE/aUctjXP8NE88=
X-Google-Smtp-Source: ABdhPJyB3mVHFW/Z2z99Kl1krfVJ19hPkVyGDYuhOKM2hgM0Nlp/7d+7tBPyeCypP0sv0InVT8Ak3dL+wYa8oeaxOmw=
X-Received: by 2002:a50:e142:: with SMTP id i2mr17841867edl.107.1633353666627; 
 Mon, 04 Oct 2021 06:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
In-Reply-To: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Oct 2021 16:20:30 +0300
Message-ID: <CAHp75VcBVGLbNxnZ4FwvdoyxQjA_V8MVHdrSYOQdxTm5bFDc5g@mail.gmail.com>
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Enrico@rox.of.borg, Arnd Bergmann <arnd@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
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

On Mon, Oct 4, 2021 at 3:45 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Currently the GPIO Aggregator does not support interrupts.  This means
> that kernel drivers going from a GPIO to an IRQ using gpiod_to_irq(),
> and userspace applications using line events do not work.
>
> Add interrupt support by providing a gpio_chip.to_irq() callback, which
> just calls into the parent GPIO controller.
>
> Note that this does not implement full interrupt controller (irq_chip)
> support, so using e.g. gpio-keys with "interrupts" instead of "gpios"
> still does not work.

...

> @@ -414,7 +421,8 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
>         for (i = 0; i < ngpios; i++) {
>                 struct gpio_chip *parent = gpiod_to_chip(descs[i]);
>
> -               dev_dbg(dev, "%u => gpio-%d\n", i, desc_to_gpio(descs[i]));
> +               dev_dbg(dev, "%u => gpio %d irq %d\n", i,
> +                       desc_to_gpio(descs[i]), gpiod_to_irq(descs[i]));

This is an unconditional call that will allocate the IRQ descriptor
even if we don't use it. Correct?
If so, I don't like this.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
