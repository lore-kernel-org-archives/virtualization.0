Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B06BC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 12:53:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88367238A0
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 12:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88367238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0ED9C8780A;
	Wed,  9 Dec 2020 12:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PT+c1yF5VnIW; Wed,  9 Dec 2020 12:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63E9C877FB;
	Wed,  9 Dec 2020 12:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 462D1C0FA7;
	Wed,  9 Dec 2020 12:53:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A5CEC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 681D32DDC9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B+XFNhFJcWb4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 32B3A2E2BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:53:29 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id 23so2910956lfg.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q0ERmRel5zMK0HrfUyBGbMf84SViVXTKgfugx46LJdc=;
 b=CfQeSl03RYY1/kP1aY6rXJzJvM6wQuj5UDNft7mpgVbb/7Cw6Y14eAKeJR4Mj/0n4k
 wf8XYouCzKoh0cr64LOl/BxkYu4qURmZGRf+6tS58CDr5U0SDILSMmayCqifmbKnGGe2
 2o+N8h3Z8EFN58HRS1yMpC0D3WjPp4xqfhzVVrJwq8rj2CR2spDLG5URfVjGAwDcckBM
 vl02o6JImgvybbR4RtSNCbcPpHzi+inU7G7AODAsNZV7IQYZ57Ibs9O3ZOIbi6sUXgg7
 A8HzLGoX1upy2ah+cmO0uxehRoUznRxLapDvw22E6BErQb9i7k2+P4gUB4pCTBkowOES
 cixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q0ERmRel5zMK0HrfUyBGbMf84SViVXTKgfugx46LJdc=;
 b=DurPmhz6gkCAfdqWR/fkTGDMp53blUIiw/uipG1c4JRYMEvfMQQsDrJB6awg1iDUzJ
 3xVDX9Dzn1+eQErrATmdLpWyObdWwBhYVlKthMelbkD34n3VX9FJCVl8M0TPDWMVWuLJ
 tdvlJrom92RJxk0a7yDj9uO8i0OvmH6nCY0X8dJgBOzVPtWArDPdqfcnExriDaVL5Ndk
 SEaRthPLnBiDcRdp7Y35fnM5xC19CtKmXL7csttn79S3KYubIBMPcyVobSNawBZ4zQsQ
 trX1T24HZJYyjc9/g69B41ofLsMh5a2JkfnJl/UrJCATt4/ux8sKo+7SZw33Vt4KaB8T
 a7fA==
X-Gm-Message-State: AOAM530rlCJDRXSqP84iyLexEzICMVEAu9mlzsZVKV735jHwXELG3Zg7
 PFaz/k8/WJfOIqy/gqH5fffKX0JZlHxg2F8OXddOpw==
X-Google-Smtp-Source: ABdhPJxT4z0Ly0kEdV4gEy+8cd3A9g/cl+KJVYjIXwDP/GLVbi+NiYbB3EufDbPF5UWEAxrY4q6VUw8juxsLEvIm0Og=
X-Received: by 2002:a19:8384:: with SMTP id f126mr877455lfd.649.1607518407214; 
 Wed, 09 Dec 2020 04:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <0080d492-2f07-d1c6-d18c-73d4204a5d40@metux.net>
 <CACRpkdb4R4yHcUV2KbGEC_RkU+QmH6Xg7X+qee8sEa9TURGr8A@mail.gmail.com>
 <51d3efb7-b7eb-83d7-673a-308dd51616d3@metux.net>
 <CACRpkdbqVoT56H88hoZwDqV0kW_8XTaE5TkMQsg-RRrPqgF=cQ@mail.gmail.com>
 <CAK8P3a1PRQGUXkjdSmqxXSONX_ZoCgsfx8hJBUdBUk14tyzErA@mail.gmail.com>
In-Reply-To: <CAK8P3a1PRQGUXkjdSmqxXSONX_ZoCgsfx8hJBUdBUk14tyzErA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Dec 2020 13:53:15 +0100
Message-ID: <CACRpkdbNAeDsi9B14kbkAeoqX7NE_Ua_yOX1iNF75oNK0ELefQ@mail.gmail.com>
Subject: Re: Howto listen to/handle gpio state changes ? Re: [PATCH v2 2/2]
 drivers: gpio: add virtio-gpio guest driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, "Enrico Weigelt,
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

On Wed, Dec 9, 2020 at 12:19 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Wed, Dec 9, 2020 at 9:51 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Dec 8, 2020 at 3:07 PM Enrico Weigelt, metux IT consult <lkml@metux.net> wrote:
>
> > What we need to understand is if your new usecase is an outlier
> > so it is simplest modeled by a "mock" irq_chip or we have to design
> > something new altogether like notifications on changes. I suspect
> > irq_chip would be best because all drivers using GPIOs for interrupts
> > are expecting interrupts, and it would be an enormous task to
> > change them all and really annoying to create a new mechanism
> > on the side.
>
> I would expect the platform abstraction to actually be close enough
> to a chained irqchip that it actually works: the notification should
> come in via vring_interrupt(), which is a normal interrupt handler
> that calls vq->vq.callback(), calling generic_handle_irq() (and
> possibly chained_irq_enter()/chained_irq_exit() around it) like the
> other gpio drivers do should just work here I think, and if it did
> not, then I would expect this to be just a bug in the driver rather
> than something missing in the gpio framework.

Performance/latency-wise that would also be strongly encouraged.

Tglx isn't super-happy about the chained interrupts at times, as they
can create really nasty bugs, but a pure IRQ in fastpath of some
kinde is preferable and intuitive either way.

Yours,
Linus Walleij
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
