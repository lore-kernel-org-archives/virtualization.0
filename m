Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA53C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 20:48:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0509264F44
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 20:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0509264F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8B810868BF;
	Thu,  4 Feb 2021 20:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhgAsrrVbPmc; Thu,  4 Feb 2021 20:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8788F8688B;
	Thu,  4 Feb 2021 20:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AF9FC0174;
	Thu,  4 Feb 2021 20:48:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F697C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 20:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AAD402077C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 20:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5ze+EBRTy+3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 20:48:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by silver.osuosl.org (Postfix) with ESMTPS id 33B55204C6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 20:48:24 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id u127so2454188vsc.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Feb 2021 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WHFhDe+wp14ydAMJQsCAOtxDAvzRUvWoj03qsINAbNU=;
 b=VI+4aHT6enALQkySTWA2qQrEBFtizPSCI55ptQ4sWY2L1/U0dgfsfKjYvrcHLzW3kq
 MPmLjyc4jXsJpr2UcULBP7w3R4Oa7RsTnOAuH+5SnjtkVQvqGzJr/x6a/3BRwIMDNw+z
 wHm28JUAYwOlAMgoh0A3lZzyLd8NjY/4r9toI8zwX1aafd2xmA4Ljazkk4lwi/+52+/w
 W9O2Q9uuBpfqnJc2vyGOMeI6Kbg9s69eaSFcEtFYDGJj6sRi1jMUe9f8wpa8UNa8I1zb
 716QdrpD1PFOJUKbs0rTloxT8h66gsC/jkjDmMcXbhwr+ilPc+pKoQ7XL0wMRKXz7QbB
 18Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WHFhDe+wp14ydAMJQsCAOtxDAvzRUvWoj03qsINAbNU=;
 b=UEO3faHEO/wC/AlTDxP1CRDLxhvd8yROFnhj+DKvpA7eBXjpIaAesWl31qSH3Cz4T1
 D12wj/bvukJmTqtasfz6t/+SnhhHijqUDfy8MuBzz0GePN0U6TUQ5XeWW2XfEjh/vzll
 tNtDUkPOoUvOA26Qs0KzJMAryn0Ims61X8T0u5VYXk8pp6Q9ZUS0hJD/T4PRIo91Qcox
 kwZfUYOVKG37dUQddAbUQXpnHO3KCtjKj6CY3XydcRcQEh0/LtMRK0lGEBAx4UvdzMdY
 zKUXpLr8wx6Nx/hbJ67Q0M+j1m9wBXE+pHncWrE3mNYc/V9+Y9zec2FCUDBZ8hFA9idS
 bHPw==
X-Gm-Message-State: AOAM532quVu3RLPAC/+UbbJ464ZKrj1/7Gphbx5+kdYmYWJvQniRiUj1
 b5BhrAw5qOymc7CviuEfFMxHqdm5Gnw=
X-Google-Smtp-Source: ABdhPJxA8/HYgeez9NFhqsX/mugS2QFktNvXcPur5SNkuO7JSoqRhhY9TfC70cHL9zWbXZj1P4fIDA==
X-Received: by 2002:a67:fb8b:: with SMTP id n11mr1367065vsr.22.1612471702617; 
 Thu, 04 Feb 2021 12:48:22 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com.
 [209.85.217.45])
 by smtp.gmail.com with ESMTPSA id x12sm813030vkn.43.2021.02.04.12.48.21
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Feb 2021 12:48:21 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id d14so2453712vsh.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Feb 2021 12:48:21 -0800 (PST)
X-Received: by 2002:a67:fd74:: with SMTP id h20mr1071337vsa.51.1612471700741; 
 Thu, 04 Feb 2021 12:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20210129002136.70865-1-weiwan@google.com>
 <20210202180807-mutt-send-email-mst@kernel.org>
 <CAEA6p_Arqm2cgjc7rKibautqeVyxPkkMV7y20DU1sDaoCnLvzQ@mail.gmail.com>
 <CA+FuTSe-6MSpB4hwwvwPgDqHkxYJoxMZMDbOusNqiq0Gwa1eiQ@mail.gmail.com>
 <CA+FuTSdkJcj_ikNnJmGadBZ1fa7q26MZ1g3ERf8Ax+YbXvgcng@mail.gmail.com>
 <20210203052924-mutt-send-email-mst@kernel.org>
 <CAF=yD-J8rsr9JWdMGBSc-muFGMG2=YCWYwWOiQBQZuryioBUoA@mail.gmail.com>
 <20210203175837-mutt-send-email-mst@kernel.org>
 <CAEA6p_BqKECAU=C55TpJedG9gkZDakiiN27dcWOTJYH0YOFA_w@mail.gmail.com>
In-Reply-To: <CAEA6p_BqKECAU=C55TpJedG9gkZDakiiN27dcWOTJYH0YOFA_w@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 4 Feb 2021 15:47:44 -0500
X-Gmail-Original-Message-ID: <CA+FuTSf-uWyK6Jz=G67p+ep693oTczF55EUzrH9fXzBqTnoMQA@mail.gmail.com>
Message-ID: <CA+FuTSf-uWyK6Jz=G67p+ep693oTczF55EUzrH9fXzBqTnoMQA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: Wei Wang <weiwan@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
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

On Wed, Feb 3, 2021 at 6:53 PM Wei Wang <weiwan@google.com> wrote:
>
> On Wed, Feb 3, 2021 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 03, 2021 at 01:24:08PM -0500, Willem de Bruijn wrote:
> > > On Wed, Feb 3, 2021 at 5:42 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 02, 2021 at 07:06:53PM -0500, Willem de Bruijn wrote:
> > > > > On Tue, Feb 2, 2021 at 6:53 PM Willem de Bruijn <willemb@google.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 2, 2021 at 6:47 PM Wei Wang <weiwan@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 2, 2021 at 3:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 28, 2021 at 04:21:36PM -0800, Wei Wang wrote:
> > > > > > > > > With the implementation of napi-tx in virtio driver, we clean tx
> > > > > > > > > descriptors from rx napi handler, for the purpose of reducing tx
> > > > > > > > > complete interrupts. But this could introduce a race where tx complete
> > > > > > > > > interrupt has been raised, but the handler found there is no work to do
> > > > > > > > > because we have done the work in the previous rx interrupt handler.
> > > > > > > > > This could lead to the following warning msg:
> > > > > > > > > [ 3588.010778] irq 38: nobody cared (try booting with the
> > > > > > > > > "irqpoll" option)
> > > > > > > > > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > > > > > > > > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > > > > > > > > [ 3588.017940] Call Trace:
> > > > > > > > > [ 3588.017942]  <IRQ>
> > > > > > > > > [ 3588.017951]  dump_stack+0x63/0x85
> > > > > > > > > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > > > > > > > > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > > > > > > > > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > > > > > > > > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > > > > > > > > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > > > > > > > > [ 3588.017961]  handle_irq+0x20/0x30
> > > > > > > > > [ 3588.017964]  do_IRQ+0x50/0xe0
> > > > > > > > > [ 3588.017966]  common_interrupt+0xf/0xf
> > > > > > > > > [ 3588.017966]  </IRQ>
> > > > > > > > > [ 3588.017989] handlers:
> > > > > > > > > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > > > > > > > > [ 3588.025099] Disabling IRQ #38
> > > > > > > > >
> > > > > > > > > This patch adds a new param to struct vring_virtqueue, and we set it for
> > > > > > > > > tx virtqueues if napi-tx is enabled, to suppress the warning in such
> > > > > > > > > case.
> > > > > > > > >
> > > > > > > > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> > > > > > > > > Reported-by: Rick Jones <jonesrick@google.com>
> > > > > > > > > Signed-off-by: Wei Wang <weiwan@google.com>
> > > > > > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > > >
> > > > > > > >
> > > > > > > > This description does not make sense to me.
> > > > > > > >
> > > > > > > > irq X: nobody cared
> > > > > > > > only triggers after an interrupt is unhandled repeatedly.
> > > > > > > >
> > > > > > > > So something causes a storm of useless tx interrupts here.
> > > > > > > >
> > > > > > > > Let's find out what it was please. What you are doing is
> > > > > > > > just preventing linux from complaining.
> > > > > > >
> > > > > > > The traffic that causes this warning is a netperf tcp_stream with at
> > > > > > > least 128 flows between 2 hosts. And the warning gets triggered on the
> > > > > > > receiving host, which has a lot of rx interrupts firing on all queues,
> > > > > > > and a few tx interrupts.
> > > > > > > And I think the scenario is: when the tx interrupt gets fired, it gets
> > > > > > > coalesced with the rx interrupt. Basically, the rx and tx interrupts
> > > > > > > get triggered very close to each other, and gets handled in one round
> > > > > > > of do_IRQ(). And the rx irq handler gets called first, which calls
> > > > > > > virtnet_poll(). However, virtnet_poll() calls virtnet_poll_cleantx()
> > > > > > > to try to do the work on the corresponding tx queue as well. That's
> > > > > > > why when tx interrupt handler gets called, it sees no work to do.
> > > > > > > And the reason for the rx handler to handle the tx work is here:
> > > > > > > https://lists.linuxfoundation.org/pipermail/virtualization/2017-April/034740.html
> > > > > >
> > > > > > Indeed. It's not a storm necessarily. The warning occurs after one
> > > > > > hundred such events, since boot, which is a small number compared real
> > > > > > interrupt load.
> > > > >
> > > > > Sorry, this is wrong. It is the other call to __report_bad_irq from
> > > > > note_interrupt that applies here.
> > > > >
> > > > > > Occasionally seeing an interrupt with no work is expected after
> > > > > > 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi"). As
> > > > > > long as this rate of events is very low compared to useful interrupts,
> > > > > > and total interrupt count is greatly reduced vs not having work
> > > > > > stealing, it is a net win.
> > > >
> > > > Right, but if 99900 out of 100000 interrupts were wasted, then it is
> > > > surely an even greater win to disable interrupts while polling like
> > > > this.  Might be tricky to detect, disabling/enabling aggressively every
> > > > time even if there's nothing in the queue is sure to cause lots of cache
> > > > line bounces, and we don't want to enable callbacks if they were not
> > > > enabled e.g. by start_xmit ...  Some kind of counter?
> > >
> > > Yes. It was known that the work stealing is more effective in some
> > > workloads than others. But a 99% spurious rate I had not anticipated.
> > >
> > > Most interesting is the number of interrupts suppressed as a result of
> > > the feature. That is not captured by this statistic.
> > >
> > > In any case, we'll take a step back to better understand behavior. And
> > > especially why this high spurious rate exhibits in this workload with
> > > many concurrent flows.
> >
> >
> > I've been thinking about it. Imagine work stealing working perfectly.
> > Each time we xmit a packet, it is stolen and freed.
> > Since xmit enables callbacks (just in case!) we also
> > get an interrupt, which is automatically spurious.
> >
> > My conclusion is that we shouldn't just work around it but instead
> > (or additionally?)
> > reduce the number of interrupts by disabling callbacks e.g. when
> > a. we are currently stealing packets
> > or
> > b. we stole all packets

Agreed. This might prove a significant performance gain at the same time :)

> >
> Thinking along this line, that probably means, we should disable cb on
> the tx virtqueue, when scheduling the napi work on the rx side, and
> reenable it after the rx napi work is done?
> Also, I wonder if it is too late to disable cb at the point we start
> to steal pkts or have stolen all pkts.

The earlier the better. I see no benefit to delay until the rx handler
actually runs.

> Because the steal work is done
> in the napi handler of the rx queue. But the tx interrupt must have
> been raised before that. Will we come back to process the tx interrupt
> again after we re-enabled the cb on the tx side?
>
> > This should be enough to reduce the chances below 99% ;)
> >
> > One annoying thing is that with split and event index, we do not disable
> > interrupts. Could be worth revisiting, for now maybe just disable the
> > event index feature? I am not sure it is actually worth it with
> > stealing.

With event index, we suppress interrupts when another interrupt is
already pending from a previous packet, right? When the previous
position of the producer is already beyond the consumer. It doesn't
matter whether the previous packet triggered a tx interrupt or
deferred to an already scheduled rx interrupt? From that seems fine to
leave it out.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
