Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D2C43461
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 21:45:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC4A613F0
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 21:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC4A613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22364845DF;
	Tue, 13 Apr 2021 21:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToPdi5rni2af; Tue, 13 Apr 2021 21:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14946845D9;
	Tue, 13 Apr 2021 21:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E06A7C000B;
	Tue, 13 Apr 2021 21:45:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A111BC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 21:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78BAE402B6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 21:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zF3pDf_1kw9h
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 21:45:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB49C4011B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 21:45:24 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id l4so28218908ejc.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZtrQUYaQ1DNhvexbHv80y5K6lB9AUwatNXLoT+S6QRQ=;
 b=l6L0IRxR8mNsE8rknbUzNijupzedPU2v4qLqSEqJ48RMJgFdDRjzy34uiA5zh3lfLL
 RsMyAYg+6rXFTzguI0d14YpGlsYiiXTAZ7kY4r+YimEfmd209ZvzgdI90KuwLTKDSZfn
 0PKySFgZoTo9y7dGJOrzVVF/ruk0qTvPqfzR2Ny45nHnTCRmdmHHGOSbO3F9UraMUdZ7
 zuwL7JMSq/L8E5kTAztS/D75inJd9msvh1j4/yoI07U3FfYyQeNHX0UBlE8m0K2PtqE7
 LnkxcKJPNp4RV/KT2YN9JyaK2TqDppeAOihjhrG9wxsFyr5Unb2DFnynqPPbxL9vk//v
 54Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZtrQUYaQ1DNhvexbHv80y5K6lB9AUwatNXLoT+S6QRQ=;
 b=FhzawNDtAdNMNTnJln8prJdRapHriO1ob6ZUooiDhvEwNFRfncleVbmm05kTGkw390
 BqC3vak4EcVY6YCk4O0KE8r15wLAAPrBhiy6t7NWYYeipogUpaB6U11EYk0UBfIMwywA
 wDaWP9MjMOG2EXPygMoRMGrBWwiN0QfYzEEu3ld3lEgtGpTiVbSuPwIE2Sod3pOJUGwO
 uAoXT6THvqX6hn2OobdHm1+7Upwlydx++p8tmL531ylKQsrMQeun/DGD0Q+7VOJIWkA3
 T7qaO5HunCqGnDG+AHglTLkXZ71IExuAyojJLSyZ/8Jkbwz8CJCCoU06meHMv0VNiMlV
 BMaw==
X-Gm-Message-State: AOAM531Ki3WRde9pbXAg9b3L4ap+ImtZrWIZrTn5fVkRdLTs744L5XQN
 e99bnp5Cs45cD4pHq7MuWL57J0s7Nhk9eQ==
X-Google-Smtp-Source: ABdhPJzpeVK6bxWyw73r3QIpzQinM2SpiP+PLCUxEYuZye0W9VileG9HYvFb1lJCpM4hWEwen9+KaQ==
X-Received: by 2002:a17:906:95cb:: with SMTP id
 n11mr3239406ejy.251.1618350322443; 
 Tue, 13 Apr 2021 14:45:22 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id t1sm5754055eju.88.2021.04.13.14.45.21
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 14:45:21 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id
 b136-20020a1c1b8e0000b029012c69da2040so2106854wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:45:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc8:: with SMTP id
 o8mr1832923wmq.87.1618350321080; 
 Tue, 13 Apr 2021 14:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-2-mst@redhat.com>
 <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com>
 <20210413153951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413153951-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Apr 2021 17:44:42 -0400
X-Gmail-Original-Message-ID: <CA+FuTSd7qagJAN0wpvudvi2Rvxn-SvQaBZ1SU9rwdb1x0j1s3g@mail.gmail.com>
Message-ID: <CA+FuTSd7qagJAN0wpvudvi2Rvxn-SvQaBZ1SU9rwdb1x0j1s3g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

On Tue, Apr 13, 2021 at 3:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 13, 2021 at 10:01:11AM -0400, Willem de Bruijn wrote:
> > On Tue, Apr 13, 2021 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > virtio_disable_cb is currently a nop for split ring with event index.
> > > This is because it used to be always called from a callback when we know
> > > device won't trigger more events until we update the index.  However,
> > > now that we run with interrupts enabled a lot we also poll without a
> > > callback so that is different: disabling callbacks will help reduce the
> > > number of spurious interrupts.
> >
> > The device may poll for transmit completions as a result of an interrupt
> > from virtnet_poll_tx.
> >
> > As well as asynchronously to this transmit interrupt, from start_xmit or
> > from virtnet_poll_cleantx as a result of a receive interrupt.
> >
> > As of napi-tx, transmit interrupts are left enabled to operate in standard
> > napi mode. While previously they would be left disabled for most of the
> > time, enabling only when the queue as low on descriptors.
> >
> > (in practice, for the at the time common case of split ring with event index,
> > little changed, as that mode does not actually enable/disable the interrupt,
> > but looks at the consumer index in the ring to decide whether to interrupt)
> >
> > Combined, this may cause the following:
> >
> > 1. device sends a packet and fires transmit interrupt
> > 2. driver cleans interrupts using virtnet_poll_cleantx
> > 3. driver handles transmit interrupt using vring_interrupt,
> >     detects that the vring is empty: !more_used(vq),
> >     and records a spurious interrupt.
> >
> > I don't quite follow how suppressing interrupt suppression, i.e.,
> > skipping disable_cb, helps avoid this.
> > I'm probably missing something. Is this solving a subtly different
> > problem from the one as I understand it?
>
> I was thinking of this one:
>
>  1. device is sending packets
>  2. driver cleans them at the same time using virtnet_poll_cleantx
>  3. device fires transmit interrupts
>  4. driver handles transmit interrupts using vring_interrupt,
>      detects that the vring is empty: !more_used(vq),
>      and records spurious interrupts.

I think that's the same scenario

>
>
> but even yours is also fixed I think.
>
> The common point is that a single spurious interrupt is not a problem.
> The problem only exists if there are tons of spurious interrupts with no
> real ones. For this to trigger, we keep polling the ring and while we do
> device keeps firing interrupts. So just disable interrupts while we
> poll.

But the main change in this patch is to turn some virtqueue_disable_cb
calls into no-ops. I don't understand how that helps reduce spurious
interrupts, as if anything, it keeps interrupts enabled for longer.

Another patch in the series disable callbacks* before starting to
clean the descriptors from the rx interrupt. That I do understand will
suppress additional tx interrupts that might see no work to be done. I
just don't entire follow this patch on its own.

*(I use interrupt and callback as a synonym in this context, correct
me if I'm glancing over something essential)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
