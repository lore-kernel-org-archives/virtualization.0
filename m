Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7940C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 23:10:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D97364E46
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 23:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D97364E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8DB7861E3;
	Wed,  3 Feb 2021 23:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1LQvSImii58o; Wed,  3 Feb 2021 23:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B8A3861DD;
	Wed,  3 Feb 2021 23:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86F79C0FA7;
	Wed,  3 Feb 2021 23:10:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E237FC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 23:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BEDA220484
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 23:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNnViiLa+a2C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 23:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 9A5AD2034A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612393803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LtzGg6dZpqPJQB7lGKdN2ttxSh+zZAXIh6EOub7tjwE=;
 b=VRj8c6KbOyBuGTIFsYU3XTLx3Vd5PjBDiWm1BJ2riGdY011Ek9ONRqwrFR/gMPGnL6R+9h
 Evu0MRI6CZ8TPFHNaS3bSgSBf/WnmPdWb2994NFswQOj5uoQn7dGx1PDRX039QHy11GjJR
 x5OLn/t0N0JhZaI1dxJRxYrt7t0UuLw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-DOjAcu6cN22-abpq-QKUNQ-1; Wed, 03 Feb 2021 18:10:00 -0500
X-MC-Unique: DOjAcu6cN22-abpq-QKUNQ-1
Received: by mail-ed1-f71.google.com with SMTP id g6so1001838edy.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Feb 2021 15:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LtzGg6dZpqPJQB7lGKdN2ttxSh+zZAXIh6EOub7tjwE=;
 b=r3b9fAQext7Vt19lIdmS15EHvvr7IidFjVr/1sVc9sbl1MOHolpOHNBOwwqSN3DeOh
 oZf1XQEYpHBfc7SjSxR8XKZHvygQimcSYar7AAIR0BPEZb2dfJRW2TqCiKH+QdrOs4HF
 tXKkidnsAemRp42NG49kMAXaaH60YmH5ovucPVvk5BKJUGb1wpUgw6iCj/fqJZMfw1mW
 57t+WHBSpNx0y+/S4v1x+mXVHylBbzYvpWDW1qLaw1dLU4Iv6tdOiFbsIuw5qd11avsk
 S9jKw/PAFLQl6k8bISujzpb7i9iiiefqKmudYVxynRbIg64UDCGWYqQtISGHhAGuOSK5
 81NA==
X-Gm-Message-State: AOAM533n1sd0F3VYfKOJQLc2J9q/qZ8fYu1F3Iw9E0ujH3QigO/7VObg
 YK9qJ4aie7ak2gGE/YTFd5aFj8u0l6w7SV+E2J/1RpYUIwxF6qu/hplFVDxTg+UfnKq0omVytU6
 IDJ67nQTgYaqbTTE8uqRvFBvSg8ULOJFMc02NlHYvvA==
X-Received: by 2002:a05:6402:702:: with SMTP id
 w2mr5619999edx.78.1612393799497; 
 Wed, 03 Feb 2021 15:09:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7uuyn7GsgjD7SgLw/k1gUkxWYIzXI9BcVKuOiANjROSuZVhWfyl1m56Xp7IHob7FtY1oJzg==
X-Received: by 2002:a05:6402:702:: with SMTP id
 w2mr5619986edx.78.1612393799288; 
 Wed, 03 Feb 2021 15:09:59 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id r11sm1558107edt.58.2021.02.03.15.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 15:09:58 -0800 (PST)
Date: Wed, 3 Feb 2021 18:09:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210203175837-mutt-send-email-mst@kernel.org>
References: <20210129002136.70865-1-weiwan@google.com>
 <20210202180807-mutt-send-email-mst@kernel.org>
 <CAEA6p_Arqm2cgjc7rKibautqeVyxPkkMV7y20DU1sDaoCnLvzQ@mail.gmail.com>
 <CA+FuTSe-6MSpB4hwwvwPgDqHkxYJoxMZMDbOusNqiq0Gwa1eiQ@mail.gmail.com>
 <CA+FuTSdkJcj_ikNnJmGadBZ1fa7q26MZ1g3ERf8Ax+YbXvgcng@mail.gmail.com>
 <20210203052924-mutt-send-email-mst@kernel.org>
 <CAF=yD-J8rsr9JWdMGBSc-muFGMG2=YCWYwWOiQBQZuryioBUoA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAF=yD-J8rsr9JWdMGBSc-muFGMG2=YCWYwWOiQBQZuryioBUoA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
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

On Wed, Feb 03, 2021 at 01:24:08PM -0500, Willem de Bruijn wrote:
> On Wed, Feb 3, 2021 at 5:42 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Feb 02, 2021 at 07:06:53PM -0500, Willem de Bruijn wrote:
> > > On Tue, Feb 2, 2021 at 6:53 PM Willem de Bruijn <willemb@google.com> wrote:
> > > >
> > > > On Tue, Feb 2, 2021 at 6:47 PM Wei Wang <weiwan@google.com> wrote:
> > > > >
> > > > > On Tue, Feb 2, 2021 at 3:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 28, 2021 at 04:21:36PM -0800, Wei Wang wrote:
> > > > > > > With the implementation of napi-tx in virtio driver, we clean tx
> > > > > > > descriptors from rx napi handler, for the purpose of reducing tx
> > > > > > > complete interrupts. But this could introduce a race where tx complete
> > > > > > > interrupt has been raised, but the handler found there is no work to do
> > > > > > > because we have done the work in the previous rx interrupt handler.
> > > > > > > This could lead to the following warning msg:
> > > > > > > [ 3588.010778] irq 38: nobody cared (try booting with the
> > > > > > > "irqpoll" option)
> > > > > > > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > > > > > > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > > > > > > [ 3588.017940] Call Trace:
> > > > > > > [ 3588.017942]  <IRQ>
> > > > > > > [ 3588.017951]  dump_stack+0x63/0x85
> > > > > > > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > > > > > > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > > > > > > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > > > > > > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > > > > > > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > > > > > > [ 3588.017961]  handle_irq+0x20/0x30
> > > > > > > [ 3588.017964]  do_IRQ+0x50/0xe0
> > > > > > > [ 3588.017966]  common_interrupt+0xf/0xf
> > > > > > > [ 3588.017966]  </IRQ>
> > > > > > > [ 3588.017989] handlers:
> > > > > > > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > > > > > > [ 3588.025099] Disabling IRQ #38
> > > > > > >
> > > > > > > This patch adds a new param to struct vring_virtqueue, and we set it for
> > > > > > > tx virtqueues if napi-tx is enabled, to suppress the warning in such
> > > > > > > case.
> > > > > > >
> > > > > > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> > > > > > > Reported-by: Rick Jones <jonesrick@google.com>
> > > > > > > Signed-off-by: Wei Wang <weiwan@google.com>
> > > > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > >
> > > > > >
> > > > > > This description does not make sense to me.
> > > > > >
> > > > > > irq X: nobody cared
> > > > > > only triggers after an interrupt is unhandled repeatedly.
> > > > > >
> > > > > > So something causes a storm of useless tx interrupts here.
> > > > > >
> > > > > > Let's find out what it was please. What you are doing is
> > > > > > just preventing linux from complaining.
> > > > >
> > > > > The traffic that causes this warning is a netperf tcp_stream with at
> > > > > least 128 flows between 2 hosts. And the warning gets triggered on the
> > > > > receiving host, which has a lot of rx interrupts firing on all queues,
> > > > > and a few tx interrupts.
> > > > > And I think the scenario is: when the tx interrupt gets fired, it gets
> > > > > coalesced with the rx interrupt. Basically, the rx and tx interrupts
> > > > > get triggered very close to each other, and gets handled in one round
> > > > > of do_IRQ(). And the rx irq handler gets called first, which calls
> > > > > virtnet_poll(). However, virtnet_poll() calls virtnet_poll_cleantx()
> > > > > to try to do the work on the corresponding tx queue as well. That's
> > > > > why when tx interrupt handler gets called, it sees no work to do.
> > > > > And the reason for the rx handler to handle the tx work is here:
> > > > > https://lists.linuxfoundation.org/pipermail/virtualization/2017-April/034740.html
> > > >
> > > > Indeed. It's not a storm necessarily. The warning occurs after one
> > > > hundred such events, since boot, which is a small number compared real
> > > > interrupt load.
> > >
> > > Sorry, this is wrong. It is the other call to __report_bad_irq from
> > > note_interrupt that applies here.
> > >
> > > > Occasionally seeing an interrupt with no work is expected after
> > > > 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi"). As
> > > > long as this rate of events is very low compared to useful interrupts,
> > > > and total interrupt count is greatly reduced vs not having work
> > > > stealing, it is a net win.
> >
> > Right, but if 99900 out of 100000 interrupts were wasted, then it is
> > surely an even greater win to disable interrupts while polling like
> > this.  Might be tricky to detect, disabling/enabling aggressively every
> > time even if there's nothing in the queue is sure to cause lots of cache
> > line bounces, and we don't want to enable callbacks if they were not
> > enabled e.g. by start_xmit ...  Some kind of counter?
> 
> Yes. It was known that the work stealing is more effective in some
> workloads than others. But a 99% spurious rate I had not anticipated.
> 
> Most interesting is the number of interrupts suppressed as a result of
> the feature. That is not captured by this statistic.
> 
> In any case, we'll take a step back to better understand behavior. And
> especially why this high spurious rate exhibits in this workload with
> many concurrent flows.


I've been thinking about it. Imagine work stealing working perfectly.
Each time we xmit a packet, it is stolen and freed.
Since xmit enables callbacks (just in case!) we also
get an interrupt, which is automatically spurious.

My conclusion is that we shouldn't just work around it but instead
(or additionally?)
reduce the number of interrupts by disabling callbacks e.g. when
a. we are currently stealing packets
or
b. we stole all packets

This should be enough to reduce the chances below 99% ;)

One annoying thing is that with split and event index, we do not disable
interrupts. Could be worth revisiting, for now maybe just disable the
event index feature? I am not sure it is actually worth it with
stealing.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
