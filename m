Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8682C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 19:14:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7937764E20
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 19:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7937764E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA1B443011;
	Tue, 23 Feb 2021 19:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUzdL4f8-MjJ; Tue, 23 Feb 2021 19:14:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2788E42FFF;
	Tue, 23 Feb 2021 19:14:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE4CAC000A;
	Tue, 23 Feb 2021 19:14:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7A96C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C354942FFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8tdScxMdeY1p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:14:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0656142FF6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:14:05 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id e13so32981746ejl.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 11:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LRyWoeuvYI6b9kccGVyJGial42rq2A+y7eUcdElFOUc=;
 b=QSMsMQr7lTL6E+gmYRiiNLixKP9rJV1636JbjSak1OZC5ogxu4FBe+QaGgn1LhHRAi
 +UeqwH2pPUz2M2BBft4nuhnzaAnujfxvWU+YhbFqw0GsmtSzj4gMb9GEpD+0fHhI2Q2s
 MnE39qX7ju2e/so3TgVe9KiqRxUsnhfykx+sNoJrkEk4fIQFwq0lhQxvY3VoN1fzbyZL
 LZvt7TXoCz3VLivwxjHXy1AmQ38Q/LXC2AhXKZxuqGevdlr3YjAT07e+mFo1PqDAGRxd
 YF8/fixLn1Z27/hfxde1bHDtP+XUQ9d+Xs7RCrA0nG9iL3XmrKjcYX4srQotg6VAPYyk
 bqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LRyWoeuvYI6b9kccGVyJGial42rq2A+y7eUcdElFOUc=;
 b=k0LFcRdcHu+fkIv3+jTi27qG9iU+mPYAuw+Hx8nOwOvLWnCL9yt15wUQsHRR2584af
 wNd9+IehTJpscD9tHaL8X00Wqr7Rg9NOAmXcI0tNvIwW5t/jqHZSGR1jEaFFEM/zAJ9k
 H7mYZZQ08KGDe/lmYzO0OINeSfcdhvSrj9HIg0DnYiJaaj+lYhnNS+bYudGKsNB9FASu
 uyf/cxzqWndzlozQXtJTdHNlAkpsOuH1No4D8ujWbW6k0bDOK+T19F0E87hnNlzcYvHS
 fM+1kaIiP3AQBaRUEwsI/5UZuQ1ZZ3H9qNTxDIy+nA6V9Dh8Jubq8h2XGKc/ygXJIFuS
 4vLw==
X-Gm-Message-State: AOAM5321I5Wh9nG4kuoc5JR3tNf2D2fDOxgeE7r18vsAt32mUsq2uG7Y
 3ru2goUvR4iy1zGZMtKJcoYZwHBljqk=
X-Google-Smtp-Source: ABdhPJzn3CZ794YhNdYZwQUbPRzgN6rKYxvB/lHvAzFqqzdO+GWuzIG7mbGwdY19feQce5SRTeL8YA==
X-Received: by 2002:a17:906:d19b:: with SMTP id
 c27mr1888411ejz.304.1614107643735; 
 Tue, 23 Feb 2021 11:14:03 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50])
 by smtp.gmail.com with ESMTPSA id l61sm13988115edl.37.2021.02.23.11.14.02
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Feb 2021 11:14:03 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id b3so23690257wrj.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 11:14:02 -0800 (PST)
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr318545wra.419.1614107642214; 
 Tue, 23 Feb 2021 11:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20210220014436.3556492-1-weiwan@google.com>
 <20210223092434-mutt-send-email-mst@kernel.org>
 <CAEA6p_DDTnbhP2TXsScthnHuaHDW4gSOETwVPRz4uqcmbuDeUg@mail.gmail.com>
In-Reply-To: <CAEA6p_DDTnbhP2TXsScthnHuaHDW4gSOETwVPRz4uqcmbuDeUg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 23 Feb 2021 14:13:24 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfTEoba-M43MkoQbqC09aa+TFGVWKvVRJqUifEkpDrFSw@mail.gmail.com>
Message-ID: <CA+FuTSfTEoba-M43MkoQbqC09aa+TFGVWKvVRJqUifEkpDrFSw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] virtio-net: suppress bad irq warning for tx
 napi
To: Wei Wang <weiwan@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
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

On Tue, Feb 23, 2021 at 12:37 PM Wei Wang <weiwan@google.com> wrote:
>
> On Tue, Feb 23, 2021 at 6:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Feb 19, 2021 at 05:44:34PM -0800, Wei Wang wrote:
> > > With the implementation of napi-tx in virtio driver, we clean tx
> > > descriptors from rx napi handler, for the purpose of reducing tx
> > > complete interrupts. But this could introduce a race where tx complete
> > > interrupt has been raised, but the handler found there is no work to do
> > > because we have done the work in the previous rx interrupt handler.
> > > This could lead to the following warning msg:
> > > [ 3588.010778] irq 38: nobody cared (try booting with the
> > > "irqpoll" option)
> > > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > > [ 3588.017940] Call Trace:
> > > [ 3588.017942]  <IRQ>
> > > [ 3588.017951]  dump_stack+0x63/0x85
> > > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > > [ 3588.017961]  handle_irq+0x20/0x30
> > > [ 3588.017964]  do_IRQ+0x50/0xe0
> > > [ 3588.017966]  common_interrupt+0xf/0xf
> > > [ 3588.017966]  </IRQ>
> > > [ 3588.017989] handlers:
> > > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > > [ 3588.025099] Disabling IRQ #38
> > >
> > > This patch series contains 2 patches. The first one adds a new param to
> > > struct vring_virtqueue to control if we want to suppress the bad irq
> > > warning. And the second patch in virtio-net sets it for tx virtqueues if
> > > napi-tx is enabled.
> >
> > I'm going to be busy until March, I think there should be a better
> > way to fix this though. Will think about it and respond in about a week.
> >
> OK. Thanks.

Yes, thanks for helping to think about a solution.

The warning went unreported for years. I'm a bit hesitant to make
actual datapath changes to suppress it, if those may actually have a
higher risk of regressions for some workloads.

Unless they actually might show a clear progression. Which may very
well be possible given the high spurious interrupt rate.

But the odd thing is that by virtue of the interrupt getting masked
once the warning hits, it may actually be difficult to improve on the
efficiency today.

As you pointed out, just probabilistically throttling how often to
steal work from the rx interrupt handler would be another low risk
approach to reduce the incidence rate.

Anyway, definitely no rush. This went unreported for a long time.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
