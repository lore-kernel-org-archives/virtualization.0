Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38812C433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:16:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF55613AB
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF55613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C71683BCF;
	Tue, 13 Apr 2021 05:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07FnOhb2NLBo; Tue, 13 Apr 2021 05:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB0D983B4B;
	Tue, 13 Apr 2021 05:16:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1426C000C;
	Tue, 13 Apr 2021 05:16:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F38BFC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0AC240659
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0xcEkg5fFFre
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:16:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34A7C40657
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618290964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3W4uWt4OLPQic/Th9smtxt2spAgszN4IWF8idvC3BgA=;
 b=JhBUstzhKOMkeNf16H4LxuhBpvjnnizz+naAwl1RPuVohaZdyaMnLZVj7pMeDb+euzx9HD
 i2ee/+qiS0RClW2aFePTYKNBWAyEFZls+/XhdXo+PzArzIFx+4OcOqVzAE7AtE8eepRbtY
 iQIdf9OAzF0Rrdb5B5OGVDxzMUhPrkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-nJn2Xhe5NCeAQIb0h0_cvg-1; Tue, 13 Apr 2021 01:16:02 -0400
X-MC-Unique: nJn2Xhe5NCeAQIb0h0_cvg-1
Received: by mail-wr1-f70.google.com with SMTP id f3so283974wrt.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3W4uWt4OLPQic/Th9smtxt2spAgszN4IWF8idvC3BgA=;
 b=DIt2PFy0YM4GcbpqTUA3CjuuIFCL0gug8CbNHbN6+OTmQxv9bygRNJyP1psIVgF3su
 OvrrAz+egkjS5l607vvz6x/8Cm1A+uvgm5UdjA+rb02mCPl2OoTE83tBbRnbcUTF6FSN
 RQ8m0/A0SKHchYQr051oocC3iJEAioe1Irlf9QpW5cssaETli5CFvJsiYBcYTY+p0tz7
 3WKIa0nUc89AWO9wUEDAzr36cHGyw+die4T6dWJ5Hk1ObajLVHfxItKJjlgPdOdNgeQF
 3joyMUqqN6Um9v9VGDt6V9ANu7u0BG94hI5d/sFhZMf/O8NUJFsF9QOyx+23pm5Ek2i6
 x3ew==
X-Gm-Message-State: AOAM532cx3JjNPsqVkEqgYIkcLk7shdRKf6FzE2iJSEVulCzryN3TG/4
 c6cuYYSJNkuD9hej8BYxxwdBuS1UWI13eLSHvmWitwhEQIhn55IWXUSVogfqSagjUn5BwOxsVyE
 q3LYcThRFnVkl9OeehBSwniOPmmqNBfucDKh4rq/UbA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr2165019wmh.151.1618290961022; 
 Mon, 12 Apr 2021 22:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd5Hen/ZODe5l7ru6xtN3FYH1APADmx4q6XSlyuF8M9C2Bc5QmebL69nG+s3B8OPG57cA7rQ==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr2165001wmh.151.1618290960808; 
 Mon, 12 Apr 2021 22:16:00 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id p27sm1228769wmi.12.2021.04.12.22.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 22:16:00 -0700 (PDT)
Date: Tue, 13 Apr 2021 01:15:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <weiwan@google.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210413011508-mutt-send-email-mst@kernel.org>
References: <20210202180807-mutt-send-email-mst@kernel.org>
 <CAEA6p_Arqm2cgjc7rKibautqeVyxPkkMV7y20DU1sDaoCnLvzQ@mail.gmail.com>
 <CA+FuTSe-6MSpB4hwwvwPgDqHkxYJoxMZMDbOusNqiq0Gwa1eiQ@mail.gmail.com>
 <CA+FuTSdkJcj_ikNnJmGadBZ1fa7q26MZ1g3ERf8Ax+YbXvgcng@mail.gmail.com>
 <20210203052924-mutt-send-email-mst@kernel.org>
 <CAF=yD-J8rsr9JWdMGBSc-muFGMG2=YCWYwWOiQBQZuryioBUoA@mail.gmail.com>
 <20210203175837-mutt-send-email-mst@kernel.org>
 <CAEA6p_BqKECAU=C55TpJedG9gkZDakiiN27dcWOTJYH0YOFA_w@mail.gmail.com>
 <CA+FuTSf-uWyK6Jz=G67p+ep693oTczF55EUzrH9fXzBqTnoMQA@mail.gmail.com>
 <CAEA6p_DGgErG6oa1T9zJr+K6CosxoMb-TA=f2kQ_1bFdeMWAcg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEA6p_DGgErG6oa1T9zJr+K6CosxoMb-TA=f2kQ_1bFdeMWAcg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Willem de Bruijn <willemb@google.com>,
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

On Fri, Feb 05, 2021 at 02:28:33PM -0800, Wei Wang wrote:
> On Thu, Feb 4, 2021 at 12:48 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Wed, Feb 3, 2021 at 6:53 PM Wei Wang <weiwan@google.com> wrote:
> > >
> > > On Wed, Feb 3, 2021 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Feb 03, 2021 at 01:24:08PM -0500, Willem de Bruijn wrote:
> > > > > On Wed, Feb 3, 2021 at 5:42 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 02, 2021 at 07:06:53PM -0500, Willem de Bruijn wrote:
> > > > > > > On Tue, Feb 2, 2021 at 6:53 PM Willem de Bruijn <willemb@google.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Feb 2, 2021 at 6:47 PM Wei Wang <weiwan@google.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Feb 2, 2021 at 3:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jan 28, 2021 at 04:21:36PM -0800, Wei Wang wrote:
> > > > > > > > > > > With the implementation of napi-tx in virtio driver, we clean tx
> > > > > > > > > > > descriptors from rx napi handler, for the purpose of reducing tx
> > > > > > > > > > > complete interrupts. But this could introduce a race where tx complete
> > > > > > > > > > > interrupt has been raised, but the handler found there is no work to do
> > > > > > > > > > > because we have done the work in the previous rx interrupt handler.
> > > > > > > > > > > This could lead to the following warning msg:
> > > > > > > > > > > [ 3588.010778] irq 38: nobody cared (try booting with the
> > > > > > > > > > > "irqpoll" option)
> > > > > > > > > > > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > > > > > > > > > > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > > > > > > > > > > [ 3588.017940] Call Trace:
> > > > > > > > > > > [ 3588.017942]  <IRQ>
> > > > > > > > > > > [ 3588.017951]  dump_stack+0x63/0x85
> > > > > > > > > > > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > > > > > > > > > > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > > > > > > > > > > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > > > > > > > > > > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > > > > > > > > > > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > > > > > > > > > > [ 3588.017961]  handle_irq+0x20/0x30
> > > > > > > > > > > [ 3588.017964]  do_IRQ+0x50/0xe0
> > > > > > > > > > > [ 3588.017966]  common_interrupt+0xf/0xf
> > > > > > > > > > > [ 3588.017966]  </IRQ>
> > > > > > > > > > > [ 3588.017989] handlers:
> > > > > > > > > > > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > > > > > > > > > > [ 3588.025099] Disabling IRQ #38
> > > > > > > > > > >
> > > > > > > > > > > This patch adds a new param to struct vring_virtqueue, and we set it for
> > > > > > > > > > > tx virtqueues if napi-tx is enabled, to suppress the warning in such
> > > > > > > > > > > case.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> > > > > > > > > > > Reported-by: Rick Jones <jonesrick@google.com>
> > > > > > > > > > > Signed-off-by: Wei Wang <weiwan@google.com>
> > > > > > > > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > This description does not make sense to me.
> > > > > > > > > >
> > > > > > > > > > irq X: nobody cared
> > > > > > > > > > only triggers after an interrupt is unhandled repeatedly.
> > > > > > > > > >
> > > > > > > > > > So something causes a storm of useless tx interrupts here.
> > > > > > > > > >
> > > > > > > > > > Let's find out what it was please. What you are doing is
> > > > > > > > > > just preventing linux from complaining.
> > > > > > > > >
> > > > > > > > > The traffic that causes this warning is a netperf tcp_stream with at
> > > > > > > > > least 128 flows between 2 hosts. And the warning gets triggered on the
> > > > > > > > > receiving host, which has a lot of rx interrupts firing on all queues,
> > > > > > > > > and a few tx interrupts.
> > > > > > > > > And I think the scenario is: when the tx interrupt gets fired, it gets
> > > > > > > > > coalesced with the rx interrupt. Basically, the rx and tx interrupts
> > > > > > > > > get triggered very close to each other, and gets handled in one round
> > > > > > > > > of do_IRQ(). And the rx irq handler gets called first, which calls
> > > > > > > > > virtnet_poll(). However, virtnet_poll() calls virtnet_poll_cleantx()
> > > > > > > > > to try to do the work on the corresponding tx queue as well. That's
> > > > > > > > > why when tx interrupt handler gets called, it sees no work to do.
> > > > > > > > > And the reason for the rx handler to handle the tx work is here:
> > > > > > > > > https://lists.linuxfoundation.org/pipermail/virtualization/2017-April/034740.html
> > > > > > > >
> > > > > > > > Indeed. It's not a storm necessarily. The warning occurs after one
> > > > > > > > hundred such events, since boot, which is a small number compared real
> > > > > > > > interrupt load.
> > > > > > >
> > > > > > > Sorry, this is wrong. It is the other call to __report_bad_irq from
> > > > > > > note_interrupt that applies here.
> > > > > > >
> > > > > > > > Occasionally seeing an interrupt with no work is expected after
> > > > > > > > 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi"). As
> > > > > > > > long as this rate of events is very low compared to useful interrupts,
> > > > > > > > and total interrupt count is greatly reduced vs not having work
> > > > > > > > stealing, it is a net win.
> > > > > >
> > > > > > Right, but if 99900 out of 100000 interrupts were wasted, then it is
> > > > > > surely an even greater win to disable interrupts while polling like
> > > > > > this.  Might be tricky to detect, disabling/enabling aggressively every
> > > > > > time even if there's nothing in the queue is sure to cause lots of cache
> > > > > > line bounces, and we don't want to enable callbacks if they were not
> > > > > > enabled e.g. by start_xmit ...  Some kind of counter?
> > > > >
> > > > > Yes. It was known that the work stealing is more effective in some
> > > > > workloads than others. But a 99% spurious rate I had not anticipated.
> > > > >
> > > > > Most interesting is the number of interrupts suppressed as a result of
> > > > > the feature. That is not captured by this statistic.
> > > > >
> > > > > In any case, we'll take a step back to better understand behavior. And
> > > > > especially why this high spurious rate exhibits in this workload with
> > > > > many concurrent flows.
> > > >
> > > >
> > > > I've been thinking about it. Imagine work stealing working perfectly.
> > > > Each time we xmit a packet, it is stolen and freed.
> > > > Since xmit enables callbacks (just in case!) we also
> > > > get an interrupt, which is automatically spurious.
> > > >
> > > > My conclusion is that we shouldn't just work around it but instead
> > > > (or additionally?)
> > > > reduce the number of interrupts by disabling callbacks e.g. when
> > > > a. we are currently stealing packets
> > > > or
> > > > b. we stole all packets
> >
> > Agreed. This might prove a significant performance gain at the same time :)
> >
> > > >
> > > Thinking along this line, that probably means, we should disable cb on
> > > the tx virtqueue, when scheduling the napi work on the rx side, and
> > > reenable it after the rx napi work is done?
> > > Also, I wonder if it is too late to disable cb at the point we start
> > > to steal pkts or have stolen all pkts.
> >
> > The earlier the better. I see no benefit to delay until the rx handler
> > actually runs.
> >
> 
> I've been thinking more on this. I think the fundamental issue here is
> that the rx napi handler virtnet_poll() does the tx side work by
> calling virtnet_poll_cleantx() without any notification to the tx
> side.
> I am thinking, in virtnet_poll(), instead of directly call
> virtnet_poll_cleantx(), why not do virtqueue_napi_schedule() to
> schedule the tx side napi, and let the tx napi handler do the cleaning
> work. This way, we automatically call virtqueue_disable_cb() on the tx
> vq, and after the tx work is done, virtqueue_napi_complete() is called
> to re-enable the cb on the tx side. This way, the tx side knows what
> has been done, and will likely reduce the # of spurious tx interrupts?
> And I don't think there is much cost in doing that, since
> napi_schedule() basically queues the tx napi to the back of its
> napi_list, and serves it right after the rx napi handler is done.
> What do you guys think? I could quickly test it up to see if it solves
> the issue.


Sure pls test. I think you will want to disable event index
for now to make sure disable cb is not a nop (I am working on
fixing that).

> > > Because the steal work is done
> > > in the napi handler of the rx queue. But the tx interrupt must have
> > > been raised before that. Will we come back to process the tx interrupt
> > > again after we re-enabled the cb on the tx side?
> > >
> > > > This should be enough to reduce the chances below 99% ;)
> > > >
> > > > One annoying thing is that with split and event index, we do not disable
> > > > interrupts. Could be worth revisiting, for now maybe just disable the
> > > > event index feature? I am not sure it is actually worth it with
> > > > stealing.
> >
> > With event index, we suppress interrupts when another interrupt is
> > already pending from a previous packet, right? When the previous
> > position of the producer is already beyond the consumer. It doesn't
> > matter whether the previous packet triggered a tx interrupt or
> > deferred to an already scheduled rx interrupt? From that seems fine to
> > leave it out.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
