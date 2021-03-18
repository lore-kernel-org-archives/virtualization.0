Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00044C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 10:39:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF9464F3B
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 10:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF9464F3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0946C82B94;
	Thu, 18 Mar 2021 10:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NsKN4PwdRkbG; Thu, 18 Mar 2021 10:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B7048300C;
	Thu, 18 Mar 2021 10:39:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63D7EC000B;
	Thu, 18 Mar 2021 10:39:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F932C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3FE182CD4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id brlwwsGX1EC6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:39:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0694482B94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:39:19 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id a15so1260693vsi.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tAvzu8nz5iln6WgpiSW86z6S3Eft+tfyr3DeEjUUSh8=;
 b=MQUMsAi1IzMG9Qu/5/QXohuUPoATQbxvCe5VXeVYMIBuzEC6AE88raWQJzCLoqXrck
 R+Tz0lntjHLMLN9uqcOPQat2kRrR3kv+IRL/SkNP8W5lyEVE6s1yO2bH/I3LAtHBiuqt
 EnT82Od6X03uk7sNSEo+qgDYC/Zkc3TfAQ2gspp02aFtq1j29CGGEUh72Jtuq3N4ZoCD
 Lap8x5fzLMYRoa1/9V0LFsaRlINKXmLRCmzsYWq/9htkysmrSkXE0W2ESjZG31Xt9YWI
 UzKF51zQB7nOFm/4dce2QKPXs7oRDBodAbFf0/BCg6BOLNoWqJ97rHR2APT/1JSTOPU4
 vXzQ==
X-Gm-Message-State: AOAM530BGIInJiKWWG9vD4hBWxYlNSNthofHffo1/kxnSzvJ1lrd/PUy
 pDf6dcC1wnTT1dWp3w7OOVDW7yv67WTTudLF9p4=
X-Google-Smtp-Source: ABdhPJyLRkuI65bcr5OT1r++d1vw1tuL9YMffz3SQ5rZYOlZEhaTfC7OjKL8YtBiPs1j+K6eLMB172cH0IogWEpFT0k=
X-Received: by 2002:a67:ef0e:: with SMTP id j14mr5704768vsr.40.1616063958823; 
 Thu, 18 Mar 2021 03:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210318102921.21536-1-tzimmermann@suse.de>
 <20210318102921.21536-9-tzimmermann@suse.de>
In-Reply-To: <20210318102921.21536-9-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Mar 2021 11:39:07 +0100
Message-ID: <CAMuHMdVa6hw89zr5nRFaKG0sZYLXdTOktGN7pU2LiAPPbsHEdw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drm/simpledrm: Acquire clocks from DT device node
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Rob Herring <robh@kernel.org>, bluescreen_avenger@verizon.net,
 Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 virtualization@lists.linux-foundation.org, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>
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

Hi Thomas,

On Thu, Mar 18, 2021 at 11:29 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Make sure required hardware clocks are enabled while the firmware
> framebuffer is in use.
>
> The basic code has been taken from the simplefb driver and adapted
> to DRM. Clocks are released automatically via devres helpers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: nerdopolis <bluescreen_avenger@verizon.net>

Thanks for your patch!

> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c

> +static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
> +{
> +       struct drm_device *dev = &sdev->dev;
> +       struct platform_device *pdev = sdev->pdev;
> +       struct device_node *of_node = pdev->dev.of_node;
> +       struct clk *clock;
> +       unsigned int i;
> +       int ret;
> +
> +       if (dev_get_platdata(&pdev->dev) || !of_node)
> +               return 0;
> +
> +       sdev->clk_count = of_clk_get_parent_count(of_node);
> +       if (!sdev->clk_count)
> +               return 0;
> +
> +       sdev->clks = drmm_kzalloc(dev, sdev->clk_count * sizeof(sdev->clks[0]),
> +                                 GFP_KERNEL);
> +       if (!sdev->clks)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < sdev->clk_count; ++i) {
> +               clock = of_clk_get(of_node, i);
> +               if (IS_ERR(clock)) {
> +                       ret = PTR_ERR(clock);
> +                       if (ret == -EPROBE_DEFER)
> +                               goto err;
> +                       drm_err(dev, "clock %u not found: %d\n", i, ret);
> +                       continue;
> +               }
> +               ret = clk_prepare_enable(clock);
> +               if (ret) {
> +                       drm_err(dev, "failed to enable clock %u: %d\n",
> +                               i, ret);
> +                       clk_put(clock);
> +               }
> +               sdev->clks[i] = clock;
> +       }

of_clk_bulk_get_all() + clk_bulk_prepare_enable()?

There's also devm_clk_bulk_get_all(), but not for the OF variant.

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
