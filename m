Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90CFC48BE6
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 08:31:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665AC61369
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 08:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665AC61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2869F60690;
	Wed, 16 Jun 2021 08:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9sWMNB3zdM3f; Wed, 16 Jun 2021 08:31:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD7F760685;
	Wed, 16 Jun 2021 08:31:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D259C000E;
	Wed, 16 Jun 2021 08:31:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 845ACC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69A2A40219
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TvqOIWTFMF8z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:31:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15AAE4017D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:31:14 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id r14so2624290ljd.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GQWVokfQZgVGHdyHPg/yFmcebJpq41KrWGaOdOQKipI=;
 b=m0/Lt4BIjXjdpqGSJBLEKjOIX3eirzK2CqDEpDte2Sj3Gc7g8xgdCxCBn5e95uOn1v
 ydDh6KT8HjktRKBXr1sdmueW7V4AkYTsqPeNXbUVcW/kihKPAvf6QZEZ26aLyCwGCXrg
 B0NFEy2eKiuPOZbOScS8JT/qvFA26HvVb5TVNHXylkJDGQ+WF7lLmhyxfj0lH189yFUe
 WbameZzm/vatSMhg+KQhcKgMzrom/GUB5AQ4qAJPeNo2uMheV3oy2PfOEwlMbfyR503e
 S6lCpLduJS7PzOZ448xLpkvuUTIhu8BKQefZo9YXer3ULTU44FfVpVAeNhv+OXRp2LkD
 kCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GQWVokfQZgVGHdyHPg/yFmcebJpq41KrWGaOdOQKipI=;
 b=EZh0OxqXHtoxWHPPwlffqFgnyoC9LQXDywGs4m9YR2L/g9lYSZ96glYCRh/awU3kcC
 Wi1ByB6/dQ7KoFqnQcOmk6irVsFpS7mHe+s8OX5AdAYMEax0KKBFgNydX4xpup0paHEX
 uOq0uFZwjeBPgKFj1pHJBUrbeKJ1AOZyRapGYcvHtP42xpqKaNuucupFXJqly7JAT8cm
 9nWcjcaVAHZTjE0WJr7tr6eZqiIhVMpRYvS1Rb6W9kSYN4PqWyMIkhzZx26nVOcULYeA
 tt4VKQk3UTfUKG840H4XqXxUf5Ue7Xa7mfkbXLwv6JqxCjmM8AvcMK8cr17ocdjcbhx9
 9Y+w==
X-Gm-Message-State: AOAM533QNr9G5ZgH4fskiZpiP9KjfT51p+Le3i9pR8Smc7F/c0SugsPN
 fxsVdmeJPVqArdk/v5qjeRgqqAY490tkWmJOkTdzGQ==
X-Google-Smtp-Source: ABdhPJzxWPvgV7p6eSpQF1eWW888O48hzZKsx5O5oRnUA6LyT2IOxPBYEipMULn1541CTP+g3/b9As5YqpuN8cY58j0=
X-Received: by 2002:a05:651c:1501:: with SMTP id
 e1mr3610433ljf.74.1623832272136; 
 Wed, 16 Jun 2021 01:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210615174911.973-1-info@metux.net>
In-Reply-To: <20210615174911.973-1-info@metux.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Jun 2021 10:31:00 +0200
Message-ID: <CACRpkdbwLOOT6nuhpkT5x-AZVipsD2qG8Qu4xoiRotHQNknwzw@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Anton Vorontsov <anton@enomsg.org>, Kees Cook <keescook@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Tony Luck <tony.luck@intel.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Colin Cross <ccross@android.com>,
 linux-riscv <linux-riscv@lists.infradead.org>
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

Hi Enrico,

On Tue, Jun 15, 2021 at 7:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Introduce new GPIO driver for virtual GPIO devices via virtio.
>
> The driver implements the virtio-gpio protocol (ID 41), which can be
> used by either VM guests (e.g. bridging virtual gpios from the guest
> to real gpios in the host or attaching simulators for automatic
> application testing), as well as virtio-gpio hardware devices.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

So now there are two contesting patches for this and that creates a
social problem for us as maintainers. I am not too happy about that.

This situation activates the kernel management style document so
I advise involved parties to familiarize themselves with it:
https://www.kernel.org/doc/html/latest/process/management-style.html

Can we get the discussion down to actual technical points?
We really need a virtio GPIO driver, no doubt, so if everyone could
just work toward that goal and compromise with their specific pet
peeves that would be great.

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
