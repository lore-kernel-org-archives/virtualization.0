Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE07FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 03:47:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7476F61040
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 03:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7476F61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D451607AC;
	Mon, 25 Oct 2021 03:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id if9ud3LPkcFe; Mon, 25 Oct 2021 03:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4ADF6072A;
	Mon, 25 Oct 2021 03:46:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DE78C0019;
	Mon, 25 Oct 2021 03:46:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 900D5C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6376840312
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IG9wbph6ifkl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:46:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DB7D40311
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 03:46:56 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id f11so9401047pfc.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 20:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/AFzt9a03HvrzF/aUcgwiHi6Uj4MGjCuRw7CvjIeKX4=;
 b=vRD7I9Iqo/IdEJamLZ+mSLIqTJLY4hw9nYeDuf4mXsWCteFyfOUwkyEwHXGDKeQ49h
 o2XCiirScHDWlVq/Ucy87qtW/H0r5gJ+m4HTzohlY39OaSvyNh29zpgyuXl3SEZD3GRU
 4A4PK2+shid7pzrq8Tkni1OUkXpHlPmsweTKC5TjuJqsJifv9aiXyoF48brHiMogybsc
 jDoBEF8rR9vT6zgpOjWC1Q3G6n7cqX6xjG1h2Si2Uvo8rU/Xj4TFEe4cJHCpBMCcydnl
 Tsh+H286ynxrS2MidBThuOCVOnpd4P8CN+NnvRHctkG8FkLHLmN06WMk+6yYavqw2WS0
 pZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/AFzt9a03HvrzF/aUcgwiHi6Uj4MGjCuRw7CvjIeKX4=;
 b=SQyGUa4yDdyw+toJGbprKmFoN5MXV3sAZcflWqa6OkcEviAPnQNcyQvO9r7OyeazaL
 adWiMEfp551T6XZ4oWxpoGT2N4uWpKRcxZYIpNDMJvLHc/El2x7SY9ebZ105iH9NwKUI
 E4PGcvwxIl28t37xT+gdP1CSdKjJE7wzwZjTPFJ7ax9HGxa8ZwR1qNMr9elkXioF7cJK
 vq2EVtj9uHGXedGsrAHbL+3IMkRlLrb1Y0c+Hxrmm58o5+aq2JqN8DI5kAiI8P3YI5gy
 veqpyTkTx8+SieWS+ELpkdok+AN+KlNT294y4tzC+Y3/afJXpRDM+SNO2vlktVxy51BE
 irZQ==
X-Gm-Message-State: AOAM533OR2Xt8Pf7RTIhXRGwIKIDuaI/pkKH+465cLPsTQd9INXiAnJZ
 I3kPBO9k35c4VYuzZjr2txCFOg==
X-Google-Smtp-Source: ABdhPJxt2uJ//k1UJHoYEOz48FeXXbEX1gBN3xG1Lxq7tI1tBMysKqYM2K7XLXlqrZRNBNRVYL2QjQ==
X-Received: by 2002:a05:6a00:cce:b0:44c:af88:eb00 with SMTP id
 b14-20020a056a000cce00b0044caf88eb00mr15920107pfv.45.1635133615614; 
 Sun, 24 Oct 2021 20:46:55 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id t2sm14432258pgf.35.2021.10.24.20.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 20:46:54 -0700 (PDT)
Date: Mon, 25 Oct 2021 09:16:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V7] gpio: virtio: Add IRQ support
Message-ID: <20211025034645.liblqgporc53lkg2@vireshk-i7>
References: <ae639da42050ee0ffd9ba1fffc2c86a38d66cec4.1634813977.git.viresh.kumar@linaro.org>
 <20211022060746-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211022060746-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-gpio@vger.kernel.org,
 stratos-dev@op-lists.linaro.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Bill Mills <bill.mills@linaro.org>
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

On 22-10-21, 06:11, Michael S. Tsirkin wrote:
> On Thu, Oct 21, 2021 at 04:34:19PM +0530, Viresh Kumar wrote:
> > This patch adds IRQ support for the virtio GPIO driver. Note that this
> > uses the irq_bus_lock/unlock() callbacks, since those operations over
> > virtio may sleep.
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I think this can be merged - while ballot did not close yet
> you already have a majority vote Yes. Worst case we'll revert
> but I don't expect that.

Thanks.

Bartosz,

Can you please pick this up for upcoming merge window then ?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
