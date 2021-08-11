Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FCAC432BE
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:25:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EB460FC4
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 12:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60EB460FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26E3240336;
	Wed, 11 Aug 2021 12:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b2fTWhVwD0go; Wed, 11 Aug 2021 12:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB36D403EE;
	Wed, 11 Aug 2021 12:25:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99716C001A;
	Wed, 11 Aug 2021 12:25:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08F1DC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBEF5829A9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yBH74ExfU3Te
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:25:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76F6C8276E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 12:25:32 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id h2so4262411lji.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zEH3nbdjRk3iKKEKjuiI8MahBqLUdJ0ANeHswehlAC4=;
 b=fryX8NC6y6XlhC7j8uc53VpWuPhaK1RvrhW4QxLCjceOa1J59cngm58Q5breUEAZbO
 OdlWLshstDrjt6UOfytqzUzuH9ayTdiWPqaDLgUlsUlCyZld1UlCCVRE0nBVaW4paNh6
 1a3FNJ14ZhQ8hNw03miW5hJUrtt3hETfd0HLclQFNJOttkWqXJ3IQJ2dZonNKhWThxNV
 s25hAQibOskooQ2GsZBsZ7KyVni2733OGYGblU+c4qNb68oeRVGM9Zmcpn+boaMC4754
 13X17tG6W+wmrmnj86w4abOEdedO5ZYDks6sohT3FniDvvsgkv/WrYVhuuAwaLgJG3Rb
 a1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zEH3nbdjRk3iKKEKjuiI8MahBqLUdJ0ANeHswehlAC4=;
 b=Z8ru7jt9PBSQJnkpAn/Nx24+A9rDs4U22UzDr9/rf+BTyPt3ms5k5qr/Aqf2ZehQYn
 OuBwtsEcGdI+3L0yF27ud624JqYVWeBbow2xj+bKblsA989DY5g+SnuvZrRjxy0kqRSP
 yygj5YKyCQq63gnXQ3bqhpWx77xtE6WLZVX7JqZkvLYKR8rSF/4cAFejhlOQLmUaEa6M
 0L5sQUbtCZFEWkuJhKCzd9+OzDsFOMUuQXmGwyvOTMeeXKLLhJ960GAuY7BfsQWp/OBS
 zR9iWXUI3WwyMRtlc4aAy+ETZAQf7wSTx6fRVkYplqWQ2HY+/moQSKRKL30Ipj3kAzmz
 zdwg==
X-Gm-Message-State: AOAM531Ym1r37uFarewvfUyIqtBZkiuasgaoOL0jnimEF2LzsgjkwfXw
 i2GFhI4qKQCil4/BrNaWySWZQCEYjsLACX0bqpVQPg==
X-Google-Smtp-Source: ABdhPJz/gGHq1zq1jYiqFyFHQT7Hh0KkvI1s2Ai88t2QU+nt6YVYNQmSr60cJpcwWEILkaeEmBjD5VELf9BFPZPEGi4=
X-Received: by 2002:a2e:9a4b:: with SMTP id k11mr12624317ljj.368.1628684730077; 
 Wed, 11 Aug 2021 05:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628590591.git.viresh.kumar@linaro.org>
 <afc7b34cee856f1ed1a65034f4a9fe705dd04d6a.1628590591.git.viresh.kumar@linaro.org>
In-Reply-To: <afc7b34cee856f1ed1a65034f4a9fe705dd04d6a.1628590591.git.viresh.kumar@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Aug 2021 14:25:18 +0200
Message-ID: <CACRpkdajnPsD01ztx5xdVnR=cEK78KY+D169HXeDKuaOMS9qfQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] gpio: Add virtio-gpio driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>,
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

On Tue, Aug 10, 2021 at 12:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This patch adds a new driver for Virtio based GPIO devices.
>
> This allows a guest VM running Linux to access GPIO lines provided by
> the host. It supports all basic operations, except interrupts for the
> GPIO lines.
>
> Based on the initial work posted by:
> "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I see there is a dependency that needs to be fixed but
the driver looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
