Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B6C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 18:24:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E87E64DF0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 18:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E87E64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA5068653F;
	Wed,  3 Feb 2021 18:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04ksSms7eAuu; Wed,  3 Feb 2021 18:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3EE7860BC;
	Wed,  3 Feb 2021 18:24:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAD49C0FA7;
	Wed,  3 Feb 2021 18:24:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2409C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DDD1C860BC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tAs5Y-ehUEGo
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:24:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D715685EE8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:24:46 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id y8so780198ede.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Feb 2021 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oY0TcE1a4DSWz3EgLFBAADUQav36p1KQYXYIRZJq9L0=;
 b=GaSvL9Tk7zgbbH9vi0YPyPV7TVE+kpFUbTcR1+acEN9NXB4cjxZPIp+52w8JdWXZDU
 kOON6j47VHBLWWGqqhPG8SdG4fuH/2dB5YPYA+xGy748J6PO+ct3r8J2Bq9Hc/++mqUq
 mfCeB1CWy14YFB1taXnaCs02WBaGjsSTKPiQRxULBR2ulNHhL44tQ58FKMvYQC7ose7e
 bkX2e3L35VbwG5yxCaU5B7LxiMcHI0KOgB5zp5hKtTdP9lsJJqBQIYMmeLtFCa2NxoYq
 XKkSvmY6E2/mPcALNqXEnF6zZrVV9q0lRUAcM0txTP06TrfdwXnYZ7g8qepZohrcYApd
 m5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oY0TcE1a4DSWz3EgLFBAADUQav36p1KQYXYIRZJq9L0=;
 b=aPnKVz+WHiTuwqzPZ03/8F4A6OiFC3IXX4NRmgxfgDGqcmlYeq/kj+8iLxiqZJFrzq
 5e1uTOZPExKGfY41N8P+T7EtBeUUztK3FnyoRVGpaFrSOHwKDxLTM28NsqLP93AusUtn
 DVZ7lXVNLEEpcIZnOR3Cx/RDlcwMbnH2WPTliquJhMjdLIY4oixMgGHvqxkHj6a0bKzb
 kHLVEcrRlpNrTQjDZ6gekZxGqDXNQErN9ZfjVDCNhmJX/JF2dEFOaOBd92og7r9vhgNZ
 0Cgf8nDdP+gYLl0KPkNVy8W2VouK+JNPw9w4ejCv/qXcf/2dLLiILgvCFUqc/K8axh3M
 eGNA==
X-Gm-Message-State: AOAM5325CWvGItr5KIHwyM0o4nBGqPfgc+AIScK4L7EOG4QNb8m0jX+m
 SM3F6IuYyehPjkOrrZ9xmi3NJx7aYXbr6YYIKDc=
X-Google-Smtp-Source: ABdhPJzFshwQO2bn1TILb1cFknq7cV4tCgPb6tjb30dB3qf3kv3dorJqVo2l4uoAyqlc21ENcHyLfNK2VEHqipzwgHE=
X-Received: by 2002:a05:6402:149a:: with SMTP id
 e26mr4469624edv.254.1612376685385; 
 Wed, 03 Feb 2021 10:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20210129002136.70865-1-weiwan@google.com>
 <20210202180807-mutt-send-email-mst@kernel.org>
 <CAEA6p_Arqm2cgjc7rKibautqeVyxPkkMV7y20DU1sDaoCnLvzQ@mail.gmail.com>
 <CA+FuTSe-6MSpB4hwwvwPgDqHkxYJoxMZMDbOusNqiq0Gwa1eiQ@mail.gmail.com>
 <CA+FuTSdkJcj_ikNnJmGadBZ1fa7q26MZ1g3ERf8Ax+YbXvgcng@mail.gmail.com>
 <20210203052924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210203052924-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 3 Feb 2021 13:24:08 -0500
Message-ID: <CAF=yD-J8rsr9JWdMGBSc-muFGMG2=YCWYwWOiQBQZuryioBUoA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Feb 3, 2021 at 5:42 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 02, 2021 at 07:06:53PM -0500, Willem de Bruijn wrote:
> > On Tue, Feb 2, 2021 at 6:53 PM Willem de Bruijn <willemb@google.com> wrote:
> > >
> > > On Tue, Feb 2, 2021 at 6:47 PM Wei Wang <weiwan@google.com> wrote:
> > > >
> > > > On Tue, Feb 2, 2021 at 3:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jan 28, 2021 at 04:21:36PM -0800, Wei Wang wrote:
> > > > > > With the implementation of napi-tx in virtio driver, we clean tx
> > > > > > descriptors from rx napi handler, for the purpose of reducing tx
> > > > > > complete interrupts. But this could introduce a race where tx complete
> > > > > > interrupt has been raised, but the handler found there is no work to do
> > > > > > because we have done the work in the previous rx interrupt handler.
> > > > > > This could lead to the following warning msg:
> > > > > > [ 3588.010778] irq 38: nobody cared (try booting with the
> > > > > > "irqpoll" option)
> > > > > > [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> > > > > > 5.3.0-19-generic #20~18.04.2-Ubuntu
> > > > > > [ 3588.017940] Call Trace:
> > > > > > [ 3588.017942]  <IRQ>
> > > > > > [ 3588.017951]  dump_stack+0x63/0x85
> > > > > > [ 3588.017953]  __report_bad_irq+0x35/0xc0
> > > > > > [ 3588.017955]  note_interrupt+0x24b/0x2a0
> > > > > > [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> > > > > > [ 3588.017957]  handle_irq_event+0x3b/0x60
> > > > > > [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> > > > > > [ 3588.017961]  handle_irq+0x20/0x30
> > > > > > [ 3588.017964]  do_IRQ+0x50/0xe0
> > > > > > [ 3588.017966]  common_interrupt+0xf/0xf
> > > > > > [ 3588.017966]  </IRQ>
> > > > > > [ 3588.017989] handlers:
> > > > > > [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> > > > > > [ 3588.025099] Disabling IRQ #38
> > > > > >
> > > > > > This patch adds a new param to struct vring_virtqueue, and we set it for
> > > > > > tx virtqueues if napi-tx is enabled, to suppress the warning in such
> > > > > > case.
> > > > > >
> > > > > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> > > > > > Reported-by: Rick Jones <jonesrick@google.com>
> > > > > > Signed-off-by: Wei Wang <weiwan@google.com>
> > > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > >
> > > > > This description does not make sense to me.
> > > > >
> > > > > irq X: nobody cared
> > > > > only triggers after an interrupt is unhandled repeatedly.
> > > > >
> > > > > So something causes a storm of useless tx interrupts here.
> > > > >
> > > > > Let's find out what it was please. What you are doing is
> > > > > just preventing linux from complaining.
> > > >
> > > > The traffic that causes this warning is a netperf tcp_stream with at
> > > > least 128 flows between 2 hosts. And the warning gets triggered on the
> > > > receiving host, which has a lot of rx interrupts firing on all queues,
> > > > and a few tx interrupts.
> > > > And I think the scenario is: when the tx interrupt gets fired, it gets
> > > > coalesced with the rx interrupt. Basically, the rx and tx interrupts
> > > > get triggered very close to each other, and gets handled in one round
> > > > of do_IRQ(). And the rx irq handler gets called first, which calls
> > > > virtnet_poll(). However, virtnet_poll() calls virtnet_poll_cleantx()
> > > > to try to do the work on the corresponding tx queue as well. That's
> > > > why when tx interrupt handler gets called, it sees no work to do.
> > > > And the reason for the rx handler to handle the tx work is here:
> > > > https://lists.linuxfoundation.org/pipermail/virtualization/2017-April/034740.html
> > >
> > > Indeed. It's not a storm necessarily. The warning occurs after one
> > > hundred such events, since boot, which is a small number compared real
> > > interrupt load.
> >
> > Sorry, this is wrong. It is the other call to __report_bad_irq from
> > note_interrupt that applies here.
> >
> > > Occasionally seeing an interrupt with no work is expected after
> > > 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi"). As
> > > long as this rate of events is very low compared to useful interrupts,
> > > and total interrupt count is greatly reduced vs not having work
> > > stealing, it is a net win.
>
> Right, but if 99900 out of 100000 interrupts were wasted, then it is
> surely an even greater win to disable interrupts while polling like
> this.  Might be tricky to detect, disabling/enabling aggressively every
> time even if there's nothing in the queue is sure to cause lots of cache
> line bounces, and we don't want to enable callbacks if they were not
> enabled e.g. by start_xmit ...  Some kind of counter?

Yes. It was known that the work stealing is more effective in some
workloads than others. But a 99% spurious rate I had not anticipated.

Most interesting is the number of interrupts suppressed as a result of
the feature. That is not captured by this statistic.

In any case, we'll take a step back to better understand behavior. And
especially why this high spurious rate exhibits in this workload with
many concurrent flows.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
