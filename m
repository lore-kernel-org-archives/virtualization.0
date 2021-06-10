Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A43C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 16:57:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059C5601FA
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 16:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059C5601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B17F840665;
	Thu, 10 Jun 2021 16:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YMJcW1DVrXuo; Thu, 10 Jun 2021 16:57:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C291540657;
	Thu, 10 Jun 2021 16:57:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E0DFC000E;
	Thu, 10 Jun 2021 16:57:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48856C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D07640664
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oBVtLOtmV3nJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:57:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D149440657
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:57:17 +0000 (UTC)
Received: by mail-il1-x12a.google.com with SMTP id d1so2514216ils.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0X69O8OJs898lKTihB59RN3w4SBwx9KHHnsAenVewI4=;
 b=MrDWnNTX6UU0dgPyVnPoaAwTdlrdSYBcFnMHsFmtnT5nmCLJZBqoxDdFl00SFduCeW
 fqk+vlydPeX9YBL3b+ulXL23uiuGPCVZtV4S90UCLscus1N0mm/jxeR7MHbyBQ8E2QxD
 jF0Nj0hhQ6HFsy7QrKDV1SgUHCWUwGWVfotwBtADyV+QHZwPkuCwTqq+HD83OYgrQOBn
 zjKzIMbJ3IxW903rDc/kU8TK49lWRCQ8dK9BYL6hqFqRmOHldjMuDcoHRfbqyE3lKzSs
 HO8YOIsWMkwxsUdX1KkZK00lqMvHCe3seWkcDIWMsEmskwgwO+tDyZkAh4pL0mG6fA2J
 1k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0X69O8OJs898lKTihB59RN3w4SBwx9KHHnsAenVewI4=;
 b=Al8BwmC14z6T6sXrJ/qJTTvWpa4HNb7kLSv5bq8GSDjtmFlegEQpGHeP1WCqvoLwd2
 cJMLjmysMjO12w2ajY7ufqL84M+GgfnBeou1RDGccBuCqFjnw5wtgxpTUBhsXFwx702e
 hSvSVojlE2LZcUOxBKkhvgb4V5FgLh8dKUz9dOu+7dQVrVi6HMLRN6r2DW2ik5BCMpiX
 y1XK5RwPL7KtABBcwspjAMujOiu1Yz//gtG43fNxVzDkzG29qpOG5mQ8SuLXagf3VqcY
 E7uWJMwo64Q5RFb2raHDhwfZf4uiLRfrcRfHfWyePXewgPCRZCSW2eLCs2axfSIuUPzM
 jPdQ==
X-Gm-Message-State: AOAM5314KWksSCn9pEbsDGnRdg2ZgpzT5VT8AE3eHIDeVYwBXZH3wTHY
 k5W9pp3J9CAl2BvmxhdCd9LUKsuJ0LS9rPfKlT4eFw==
X-Google-Smtp-Source: ABdhPJzvvpd9vpgMr61oKKUPqSKUbzq+CFCSV14x8+buD6sK508dF1frWVtuvrj42uvJsInWXupzdjC/cqHeREHAuvc=
X-Received: by 2002:a92:7607:: with SMTP id r7mr4800102ilc.31.1623344236838;
 Thu, 10 Jun 2021 09:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <96994f4c-8755-90a8-0c50-4e21c436f137@metux.net>
In-Reply-To: <96994f4c-8755-90a8-0c50-4e21c436f137@metux.net>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 10 Jun 2021 22:27:05 +0530
Message-ID: <CAKohpokxSoSVtAJkL-T_OOoS8dW-gYG1Gs5=_DwebvJETE48Xw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Stratos Mailing List <stratos-dev@op-lists.linaro.org>, "Enrico Weigelt,
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

Hi Enrico,

On Thu, 10 Jun 2021 at 21:24, Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 10.06.21 14:16, Viresh Kumar wrote:
> > From: "Enrico Weigelt, metux IT consult" <info@metux.net>
> >
> > This patch adds a new driver for Virtio based GPIO devices.
> >
> > This allows a guest VM running Linux to access GPIO device provided by
> > the host. It supports all basic operations for now, except interrupts
> > for the GPIO lines.
>
> What exactly did you change here from my original driver ?

I didn't write it from scratch and used your patch only to start with, and so
you are still the Author of this particular patch.

This just followed the specification updates and so changes only the stuff
that was different from your original specs. Apart from that as you know,
the irqs weren't working in your case as they needed to be implemented
differently (patch 2 does that) here.

> Your already changed the spec havily (w/o consulting me first),

Isn't that what we are doing on the list? I believe that's why the lists
exist, so people don't need to discuss in person, offline. I am happy to
make changes in spec if you want to suggest something and if something
breaks it for you.

> so I guess this driver hasn't so much in common w/ my original design.

It actually has as I said earlier, it is still based on your patch.

> Note that I made my original design decisions for good reaons
> (see virtio-dev list).

I tried to follow your patches from December on the Linux kernel list
and the ID allocation one on virtio-comments list. I wasn't able to search
for any other attempt at sending the specification, so may have missed
something.

I do understand that there were reasons why you (and me) chose a
particular way of doing things and if there is a good reason of following
that, then we can still modify the spec and fix things for everyone.
We just need to discuss our reasoning on the list and get through with
a specfication which works for everyone as this will become a standard
interface for many in the future and it needs to be robust and efficient
for everyone.

> It already support async notifications
> (IOW: irqs), had an easy upgrade path for future additions, etc.

I haven't changed irqs path, we still have a separate virtqueue
(named "interrupt" vq) which handles just the interrupts now. And so
will be faster than what you initially suggested.

In your original design you also received the responses for the requests
on this virtqueue, wihch I have changed to get the response synchronously
on the "command" virtqueue only.

This is from one of your earlier replies:

"
I've been under the impression that queues only work in only one
direction. (at least that's what my web research was telling).

Could you please give an example how bi-directional transmission within
the same queue could look like ?
"

It is actually possible and the right thing to do here as we aren't starting
multiple requests together. The operation needs to be synchronous anyway
and both request/response on the same channel work better there. Also that
makes the interrupts reach faster, without additional delay due to responses.

> Note #2: it's already implemented and running in the field (different
> kernels, different hypervisors, ...) - it just lacked the going through
> virtio comitte's formal specification process, which blocked mainlining.

I understand the pain you would be reqiured to go through because of this,
but this is how any open source community will work, like Linux.

There will be changes in specification and code once you post it and any
solutions already working in the field won't really matter during the
discussion.
That is why it is always the right thing to _upstream first_, so one can avoid
these problems later on. Though I understand that the real world
needs to move faster than community. But no one can really help in that.

> Is there anything fundamentally wrong w/ my original design, why you
> invented a completely new one ?

Not much, and I haven't changed a lot as well.

Lemme point out few things which have changed in specification since
your earlier
version (the code just followed the specification, that's it).

- config structure
  - version information is replaced with virtio-features.
  - Irq support is added as a feature, as you suggested.
  - extra padding space (24 bytes) removed. If you see this patch we can
    now read the entire config structure in a single go. Why should
anyone be required
    to copy extra 24 bytes? If we need more fields later, we can
always do that with help
    of another feature-flag. So this is still extendable.

- Virtqueues: we still have two virtqueues (command and interrupt),
just responses are
  moved to the command virtqueue only, as that is more efficient.

- Request/response: Request layout is same, added a new layout for response as
  the same layout is inefficient.

- IRQ support: Initial specification had no interface for configuring
irqs from the guest,
  I added that.

That's all I can gather right now.

I don't think that's a lot and it is mostly improvements only. But if
there is a good reason
on why we should do things differently, we can still discuss that. I
am open to suggestions.

Thanks

--
Viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
