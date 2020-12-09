Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46889C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 08:51:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE93F23609
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 08:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE93F23609
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8555C86D67;
	Wed,  9 Dec 2020 08:51:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMBmcBaDN7Xm; Wed,  9 Dec 2020 08:51:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE2C086D92;
	Wed,  9 Dec 2020 08:51:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F42FC0FA7;
	Wed,  9 Dec 2020 08:51:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30D15C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 17788873A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yg26z7bCYcB2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:51:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 18F1A873A2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:51:43 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id y16so1359121ljk.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 00:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2LZygKLdMeXtg6UECM3hwilY+T5j2Bz/7hXfM4FH8eM=;
 b=epPtSSR/7bb7N5MVhrvn8mmG61DUhbJ5ceSBz3zdi5ttU8hgJi895CvkV+jIJ/6Elk
 faLbAlJ0Ct8dkmLFvgIrcS2c+E739IaF5RCxecfGNHm3mm9cz8saP5sgGgYp+X1PV4bC
 8mhsjose2UwRapucDt1waykXBayMMNhXuMNDIMFXYNitjuaFIJIsgeaGcS06BwcAfxiT
 KnhaJQskTWoexBWR6Z8n6Tmma+HZsp8I7wCXBC5u3Xfmk6pam3fV2CZ4Ur7GSbOGsa+I
 mOEm5C+iR1V90Ai9/YLl2ZsKt3HZkVjDOpFbulodrKnOwGlU5c4D2BW0bjsEGeVxZrhT
 woEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2LZygKLdMeXtg6UECM3hwilY+T5j2Bz/7hXfM4FH8eM=;
 b=onV7hdXW32lcUBtzLcQKi0vxwBStd+M458Th8MKY4HpQOAfcRabvKbZQrY8MTmfK3E
 EJ7x05KBuLDby/+H4hmljT4eAMUqm347B2AcVC1YwIJAokjYYvIaAQ5W0rwOC7+gbeR8
 S4DnpkWmkWJPr9Ws5thPPFpmxK97t/SgGVF9mSCznGQF+5qxZUDobAyCsRTq9I75d1PF
 uLBAUQPikXP/yKuESnp86114TWAgMV8B6NL8ApQgxrzp2ObKMcmOWcS5dI1fwOFTPYhX
 he36H8mvJ/YF3pvxUW5tprEadRSSHoA2eBpuOnpZUdcBU7ldhz8zkC2VWRPYCha4nW06
 bcqQ==
X-Gm-Message-State: AOAM530uL4ovsfjoNabH3rCiOpeMwxSj9G6+//uI2SPjI1rg0sPA4nTF
 YaoK90TvhNWbSs1jd5LuCmhjyIE0cXYEvDleCWXidg==
X-Google-Smtp-Source: ABdhPJzppB0j8WgWv6IdUZKKIGJXOVBgkHuLGiXKbyH9OU440iaPPvmtmnyjuDh6a/e9QQ8jwdYfQNzIxLD6F6BmUpY=
X-Received: by 2002:a2e:910f:: with SMTP id m15mr622232ljg.467.1607503901332; 
 Wed, 09 Dec 2020 00:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <0080d492-2f07-d1c6-d18c-73d4204a5d40@metux.net>
 <CACRpkdb4R4yHcUV2KbGEC_RkU+QmH6Xg7X+qee8sEa9TURGr8A@mail.gmail.com>
 <51d3efb7-b7eb-83d7-673a-308dd51616d3@metux.net>
In-Reply-To: <51d3efb7-b7eb-83d7-673a-308dd51616d3@metux.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Dec 2020 09:51:30 +0100
Message-ID: <CACRpkdbqVoT56H88hoZwDqV0kW_8XTaE5TkMQsg-RRrPqgF=cQ@mail.gmail.com>
Subject: Re: Howto listen to/handle gpio state changes ? Re: [PATCH v2 2/2]
 drivers: gpio: add virtio-gpio guest driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-riscv@lists.infradead.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On Tue, Dec 8, 2020 at 3:07 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:

> I've been looking for some more direct notification callback for gpio
> consumers: here the consumer would register itself as a listener on
> some gpio_desc and called back when something changes (with data what
> exactly changed, eg. "gpio #3 input switched to high").
>
> Seems we currently just have the indirect path via interrupts.

I don't know how indirect it is, it seems pretty direct to me. The subsystem
was designed in response to how the hardware in front of the developers
worked.

So far we have had:
- Cascaded interrupts
- Dedicated (hieararchical) interrupts
- Message Signalled Interrupts

And if you now bring something else to the show then it's not like the
subsystem was designed for some abstract quality such as
generic notification of events that occurred, all practical instances
have been around actual IRQs and that is why it is using
struct irq_chip.

What we need to understand is if your new usecase is an outlier
so it is simplest modeled by a "mock" irq_chip or we have to design
something new altogether like notifications on changes. I suspect
irq_chip would be best because all drivers using GPIOs for interrupts
are expecting interrupts, and it would be an enormous task to
change them all and really annoying to create a new mechanism
on the side.

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
