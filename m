Return-Path: <SRS0=J9So=JQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA5C433B4
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 08:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D162610CC
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 08:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D162610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45D034013C;
	Mon, 19 Apr 2021 08:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zzyMpAT2cmc1; Mon, 19 Apr 2021 08:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAAEC4014D;
	Mon, 19 Apr 2021 08:01:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94009C000F;
	Mon, 19 Apr 2021 08:01:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B00BC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 08:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24B964014D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 08:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u5MDJ5UEcvmC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 08:01:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C8E34014C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 08:01:08 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id j8so8205958uak.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 01:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BUpGwjpEu/4vLb0RdqZG1KLsDpmabVtYAByt0suTszU=;
 b=A6hSeMSizFkwQdU9ooPgcVQ0aVLujYab0qWaG1jcCzxFmYGaxOUlP8xpsxuJriMMLU
 rfJmwKzsw6V+7UAqIDJJNIygrmHFizDV6mWEDctW+oSC28kRaxS5b4uOObB7tJFoM99W
 q9RLj+m74yYuXOg2Q3ZhMk8VoNi+wtpw45slwA/73ub/V8JGuqtpWFaGUQIUUkX+5S9E
 +je7FqhcTwJ7KdjnSunNixfu8D59ytKA6cyFygSmz7Vorx8gOO8yAJcYvEX6Tuli7vQZ
 wS2Qnl28jy+8nuoQVNrB/1eVqlj2HoJcF3/EvIRzzn2mAAc2QttlLCsOoJM4+SKRuppD
 cJow==
X-Gm-Message-State: AOAM530Yd4kca8G4bVZ6ls0H/KE6YqTHtVDtBg1/voxB4cWg1jb1/oo0
 xqig9M0b+atNF8MbwQFfw/H/3bf1OMy2tpeKUh0=
X-Google-Smtp-Source: ABdhPJxWhSqaSXDdtxTrt8N0QC9ouc95t3YD202R1UAd81UELN2SUsFdr7jUmXmQOOF/DBgt7DAQOC6q/DvsGEPBMvg=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr6342516uar.100.1618819267298; 
 Mon, 19 Apr 2021 01:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210416090048.11492-1-tzimmermann@suse.de>
In-Reply-To: <20210416090048.11492-1-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Apr 2021 10:00:56 +0200
Message-ID: <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
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
 Greg KH <gregkh@linuxfoundation.org>, Sam Ravnborg <sam@ravnborg.org>
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

On Fri, Apr 16, 2021 at 11:00 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> This patchset adds support for simple-framebuffer platform devices and
> a handover mechanism for native drivers to take-over control of the
> hardware.
>
> The new driver, called simpledrm, binds to a simple-frambuffer platform
> device. The kernel's boot code creates such devices for firmware-provided
> framebuffers, such as EFI-GOP or VESA. Typically the BIOS, UEFI or boot
> loader sets up the framebuffers. Description via device tree is also an
> option.

I guess this can be used as a replacement for offb, too...

> Patches 4 to 8 add the simpledrm driver. It's build on simple DRM helpers
> and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. During

.... if support for 8-bit frame buffers would be added?

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
