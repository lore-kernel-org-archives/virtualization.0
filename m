Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A24FC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 10:38:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A99264F58
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 10:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A99264F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC94E870BD;
	Wed,  3 Feb 2021 10:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qFwjBbuvL5p; Wed,  3 Feb 2021 10:38:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 033278704C;
	Wed,  3 Feb 2021 10:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD0F9C0174;
	Wed,  3 Feb 2021 10:38:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9FE2C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A801F87051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQMjKrq7qf5u
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:38:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 73AF68704C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612348688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3HhHobMYPlFQFvUioE6L5w9d4HmDVhf6ksQ/kPlrnbc=;
 b=WCaOgIbvywegvHRj9m91Mm4NaU0mMdgzx/J44cD+cGxmtS8kZaHJR4VAD9olnRjuy4RbnS
 oh6cNzDBLSYwxS3cDtgSB3xjYVUeYbp1v8VuFRaOMFjMS2CI+HG/19R1ZegG7r6lK5F8Ec
 WQ61liWvQm55vPVKp3RAaHhpX4aYRu0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-Yj_EYtDwPtu3lRrQosy4Kg-1; Wed, 03 Feb 2021 05:38:05 -0500
X-MC-Unique: Yj_EYtDwPtu3lRrQosy4Kg-1
Received: by mail-ej1-f71.google.com with SMTP id w16so4176893ejk.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Feb 2021 02:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3HhHobMYPlFQFvUioE6L5w9d4HmDVhf6ksQ/kPlrnbc=;
 b=RL8JwrLGqrrCoTE0btpSe7g9PhK4K9OxQYtqPlN3oHxuHTzppMc/tNbBgAOPakpusy
 rq9pw/3YDojId9zQ/sleUc+sVW9IQ1eD21WS3SV7nBuPWLfgsg6mr7ghLtYh9AHa9aUZ
 xD3/y6G1T8jd8A9GTRrmzJgdd1yOfII8nHon37HScdYGyZNNkUMby5A5YojIFv0vV4ce
 2k8JJcax6JR3852nwybI9RtnY70bP+kaOSLKOY5ml2fdCVvBRwguVln3HtosyM1Jj1A7
 Ye6xJ96kfTPK+Jb1BAdpIP+z+XuOIrx+6sgEgw51Vno1c3HuIC6qyTR03eIav7pcF47D
 P5bw==
X-Gm-Message-State: AOAM532+X1yQfgIgCo/V9j5fUfmYzOHimlJFgFNr3iHSBs7qnM7Wmjn8
 m9FZQUsAtDHqNMjUovqADyV3HTSqZRVuig5MieTO9upVC3vgPPjJL3dDFef66PeQs/cN6HyOWKx
 kN5nkeyFD2Ov0I6PG/qzPAdH3L/cJFI3dIe9N0Lj6vQ==
X-Received: by 2002:a17:906:8612:: with SMTP id
 o18mr273042ejx.435.1612348684510; 
 Wed, 03 Feb 2021 02:38:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3BttvpnMp9X40MrIlhHe3DQXpcUanIXY0JNhaRMWqQ677k1dGvdGIQidvFbsT1CZuMHmd5w==
X-Received: by 2002:a17:906:8612:: with SMTP id
 o18mr273035ejx.435.1612348684314; 
 Wed, 03 Feb 2021 02:38:04 -0800 (PST)
Received: from redhat.com (bzq-109-67-102-221.red.bezeqint.net.
 [109.67.102.221])
 by smtp.gmail.com with ESMTPSA id hr3sm792896ejc.41.2021.02.03.02.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 02:38:03 -0800 (PST)
Date: Wed, 3 Feb 2021 05:38:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210203052924-mutt-send-email-mst@kernel.org>
References: <20210129002136.70865-1-weiwan@google.com>
 <20210202180807-mutt-send-email-mst@kernel.org>
 <CAEA6p_Arqm2cgjc7rKibautqeVyxPkkMV7y20DU1sDaoCnLvzQ@mail.gmail.com>
 <CA+FuTSe-6MSpB4hwwvwPgDqHkxYJoxMZMDbOusNqiq0Gwa1eiQ@mail.gmail.com>
 <CA+FuTSdkJcj_ikNnJmGadBZ1fa7q26MZ1g3ERf8Ax+YbXvgcng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSdkJcj_ikNnJmGadBZ1fa7q26MZ1g3ERf8Ax+YbXvgcng@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Wei Wang <weiwan@google.com>, virtualization@lists.linux-foundation.org,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
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

On Tue, Feb 02, 2021 at 07:06:53PM -0500, Willem de Bruijn wrote:
> On Tue, Feb 2, 2021 at 6:53 PM Willem de Bruijn <willemb@google.com> wrote:
> >
> > On Tue, Feb 2, 2021 at 6:47 PM Wei Wang <weiwan@google.com> wrote:
> > >
> > > On Tue, Feb 2, 2021 at 3:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 28, 2021 at 04:21:36PM -0800, Wei Wang wrote:
> > > > > With the implementation of napi-tx in virtio driver, we clean tx
> > > > > descriptors from rx napi handler, for the purpose of reducing tx
> > > > > complete interrupts. But this could introduce a race where tx complete
> > > > > interrupt has been raised, but the handler found there is no work to do
> > > > > because we have done the work in the previous rx interrupt handler.
> > > > > This could lead to the following warning msg:
> > > > > [ 3588.010778] irq 38: nobody cared (try booting with the
> > > > > "irqpoll" option)
> > > > > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > > > > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > > > > [ 3588.017940] Call Trace:
> > > > > [ 3588.017942]  <IRQ>
> > > > > [ 3588.017951]  dump_stack+0x63/0x85
> > > > > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > > > > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > > > > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > > > > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > > > > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > > > > [ 3588.017961]  handle_irq+0x20/0x30
> > > > > [ 3588.017964]  do_IRQ+0x50/0xe0
> > > > > [ 3588.017966]  common_interrupt+0xf/0xf
> > > > > [ 3588.017966]  </IRQ>
> > > > > [ 3588.017989] handlers:
> > > > > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > > > > [ 3588.025099] Disabling IRQ #38
> > > > >
> > > > > This patch adds a new param to struct vring_virtqueue, and we set it for
> > > > > tx virtqueues if napi-tx is enabled, to suppress the warning in such
> > > > > case.
> > > > >
> > > > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> > > > > Reported-by: Rick Jones <jonesrick@google.com>
> > > > > Signed-off-by: Wei Wang <weiwan@google.com>
> > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > >
> > > >
> > > > This description does not make sense to me.
> > > >
> > > > irq X: nobody cared
> > > > only triggers after an interrupt is unhandled repeatedly.
> > > >
> > > > So something causes a storm of useless tx interrupts here.
> > > >
> > > > Let's find out what it was please. What you are doing is
> > > > just preventing linux from complaining.
> > >
> > > The traffic that causes this warning is a netperf tcp_stream with at
> > > least 128 flows between 2 hosts. And the warning gets triggered on the
> > > receiving host, which has a lot of rx interrupts firing on all queues,
> > > and a few tx interrupts.
> > > And I think the scenario is: when the tx interrupt gets fired, it gets
> > > coalesced with the rx interrupt. Basically, the rx and tx interrupts
> > > get triggered very close to each other, and gets handled in one round
> > > of do_IRQ(). And the rx irq handler gets called first, which calls
> > > virtnet_poll(). However, virtnet_poll() calls virtnet_poll_cleantx()
> > > to try to do the work on the corresponding tx queue as well. That's
> > > why when tx interrupt handler gets called, it sees no work to do.
> > > And the reason for the rx handler to handle the tx work is here:
> > > https://lists.linuxfoundation.org/pipermail/virtualization/2017-April/034740.html
> >
> > Indeed. It's not a storm necessarily. The warning occurs after one
> > hundred such events, since boot, which is a small number compared real
> > interrupt load.
> 
> Sorry, this is wrong. It is the other call to __report_bad_irq from
> note_interrupt that applies here.
> 
> > Occasionally seeing an interrupt with no work is expected after
> > 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi"). As
> > long as this rate of events is very low compared to useful interrupts,
> > and total interrupt count is greatly reduced vs not having work
> > stealing, it is a net win.

Right, but if 99900 out of 100000 interrupts were wasted, then it is
surely an even greater win to disable interrupts while polling like
this.  Might be tricky to detect, disabling/enabling aggressively every
time even if there's nothing in the queue is sure to cause lots of cache
line bounces, and we don't want to enable callbacks if they were not
enabled e.g. by start_xmit ...  Some kind of counter?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
