Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A404C48BE6
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 11:49:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AC66128B
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 11:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AC66128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 268D360A87;
	Wed, 16 Jun 2021 11:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LkTL38noEX87; Wed, 16 Jun 2021 11:49:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A916360A75;
	Wed, 16 Jun 2021 11:49:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8381BC000D;
	Wed, 16 Jun 2021 11:49:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25666C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 048684042A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbe3Zqdh7uXS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:49:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE767403E8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:49:37 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id k5so1566054pjj.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=WP4w1GpdYFm/lzVMj2S/oiM+wNAIY76Q4Vr8j4h2Ac8=;
 b=wa92YBrXbG86A9Z+067cELwEal7p07gTA7A7wsgnCbaOV0P4ed2S2onKpAtAa6YpoW
 Alrj7n+HHFlLh4cL0E/+vh6HaHfSTX2bVhimwLq3N+4ctPqCAHpFkwMqX9MfKwPLepi2
 N85/18jVLEznBvvqb78bkfmWMBfICgKqImLdL9QPFz2rkpym27NQHevR/NjGk8zwEna6
 QM9/KL4jOmdrxnmcHNNmLlLuC93GgJoyoCcEMQZTcd7xxhGFEIQ0/UQm1Jzn9+Z5XLEp
 YLIXvWj6DrJqOe4QCzTZ4zkbl7G2jU0Ez/9tYf25xw7D14jAR7EywGWy4PSJHgPhaoYK
 To4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WP4w1GpdYFm/lzVMj2S/oiM+wNAIY76Q4Vr8j4h2Ac8=;
 b=l+xn2lkDE4zEXJyaWrxAjheZjMtjf9AI39v2hFDq9XFeEykvuv6+5bgPzIoEBy0jf1
 boGTuuGDi/54qwITM+lV6gE7gDJp1bQybhf4lJZHlsUQUTRNrWbSmmK48a8ST1xU1ByR
 2sJKMvesDkdGMcGxJtMhwh8lsoT1lknZbzxmQWw/+z4QhO7zvdHNWdoJlZ7jsOP0zQ7f
 Q1JGzYF+a9CopWHjSkoIRU0pBW9lydGoaZHNGl5o8kS/teiPPKvzbt8IwErHwLsysth+
 iezJaiVfvy235vxG6rFFv4eZKdbG+b0DHMVT0Vz76jb581WdLXmorTvk0gMElHPgN82T
 gebg==
X-Gm-Message-State: AOAM53012AsRPdha+V37OlqY803Ok9Fc/F6+MmA6kNXwnm6L7efLYEy9
 kVtmeNpzdqWyDEgmzrJU4Z082A==
X-Google-Smtp-Source: ABdhPJw89fpFAisJqm9uKcXQ4Bv9sFpHwtsFqHMJR6kj3kZ7z5t5WDsu0PQ7GzVDY+EnmIFrNn1Yqw==
X-Received: by 2002:a17:90a:5401:: with SMTP id z1mr4452275pjh.7.1623844177210; 
 Wed, 16 Jun 2021 04:49:37 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id t14sm2541701pgm.9.2021.06.16.04.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 04:49:36 -0700 (PDT)
Date: Wed, 16 Jun 2021 17:19:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20210616114934.n3grzuh6c64wlaj6@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdbwLOOT6nuhpkT5x-AZVipsD2qG8Qu4xoiRotHQNknwzw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Anton Vorontsov <anton@enomsg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Kees Cook <keescook@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Tony Luck <tony.luck@intel.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Colin Cross <ccross@android.com>,
 linux-riscv <linux-riscv@lists.infradead.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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

On 16-06-21, 10:31, Linus Walleij wrote:
> Hi Enrico,
> 
> On Tue, Jun 15, 2021 at 7:49 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
> 
> > Introduce new GPIO driver for virtual GPIO devices via virtio.
> >
> > The driver implements the virtio-gpio protocol (ID 41), which can be
> > used by either VM guests (e.g. bridging virtual gpios from the guest
> > to real gpios in the host or attaching simulators for automatic
> > application testing), as well as virtio-gpio hardware devices.
> >
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> So now there are two contesting patches for this and that creates a
> social problem for us as maintainers. I am not too happy about that.
> 
> This situation activates the kernel management style document so
> I advise involved parties to familiarize themselves with it:
> https://www.kernel.org/doc/html/latest/process/management-style.html
> 
> Can we get the discussion down to actual technical points?

+1

I can not agree more to this.

> We really need a virtio GPIO driver, no doubt, so if everyone could
> just work toward that goal and compromise with their specific pet
> peeves that would be great.

Enrico,

I am not looking to get any credits for the code or spec here. I don't
really care about that. For the very same reason I kept you as the
author of the 1st patch in the kernel series, so git keeps showing you
as the original author.

All I wanted to work on was the backend (in rust). This is what
happened for I2C for example, Jie Deng (Intel) worked on the spec and
Linux driver and I helped review it, make him fix a thing or two and
that's all. I worked on the rust implementation for the backend then.

You only ever sent 1 real versions of the Linux driver, that too
"6-months-back", there were no real blockers anywhere and you never
attempted to upstream anything.

Similarly, you "never" sent the specification properly to the virtio
lists for review. You sent it once as an attachment to an email, which
no one ever received.

When I tried to move this forward, invested a lot of time into making
it better from specification to code, reviews started happening, you
decided to start blocking it again.

You should be rather happy that something that you worked on is making
progress, specially when you didn't get time to do the same.

You wrote this in your patch:

> > Status:
> >     * this driver is now field tested for about 6 month
> >       (against KVM+Qemu as well as some HW/FPGA implementation)

Linux upstream doesn't really care about this, you can ask any Linux
Maintainer about this. If your code and specification isn't doing the
right thing, and isn't good enough, you will be asked to update it
upon reviews.

YOU JUST CAN'T SAY I WON'T because I have products based on this
version.

This is not how any open source project works. The code and
specification here doesn't belong to a single person or company. It is
for everyone's use.

> >     * virtio device ID officially allocated

Correct.

> >     * virtio spec has been submitted to virtio TC

Which specification are you talking about here ? The only
specification I can see on virtio lists is the one I sent.

And the driver you tried to send isn't aligned to that for sure, and
it takes us back from all the improvements I tried to do.

I am not saying that my version of the specification is the best and
there is no flaw in it. There surely is, but that can't be fixed by
sending another version of it. You need to make a technical point
about it and convince people that what you are saying is correct and
it is required for your use-case (not existing downstream solution).

There is no point going backwards now after making so much of
progress. Even if you try to send your version, it will slowly and
slowly reach very close to my latest version of code and spec. Because
your version of the code and spec weren't good enough for everyone. It
doesn't matter if you have real products on your earlier version, you
can keep using that in your downstream solution, but Linux kernel and
specification are going to get an improved version (from yours or
mine, but that doesn't matter here). You need to accept that changes
to that are inevitable since there are many users of gpio-virtio, not
just you and me, but many more (Like Bjorn expressed his interest in
this today for Qcom stuff).

Again, it would be better if you can discuss further on technical
merits or demerits in the currently circulated specification and give
your invaluable suggestions on the same.

Else we will end up spending few more months with just this and it
won't get us anywhere.

Thanks.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
