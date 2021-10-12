Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C395FC433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 02:44:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C12A60296
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 02:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C12A60296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C5FF40332;
	Tue, 12 Oct 2021 02:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQ6PZ1leQjuT; Tue, 12 Oct 2021 02:44:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A713F402E7;
	Tue, 12 Oct 2021 02:44:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AA62C0011;
	Tue, 12 Oct 2021 02:44:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60088C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 02:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 328E8401A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 02:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPGlAOugOU9l
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 02:44:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EED08401A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 02:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634006653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2fREGIk8jReLlGTNXAectxIpYSI3IYPQI22eSOPGC+M=;
 b=fpwk6oEeB2i2yFqDYHc9kPm93TDefJsORNUKoQmITKTNzo6/np1cWgMMm8MdUkTiVfOGzm
 h31zpHAX6LoRBaRazCZkRq3/dNFgAX7aY9FhA2p7/mMFB1q6gPkhLptQFxJN9O3TSLgg5G
 v5vK4rv6MLHWWQayiNCdFPCUA3TvvVg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-YA7UwJTQN0iIgvnJgVT3eA-1; Mon, 11 Oct 2021 22:44:10 -0400
X-MC-Unique: YA7UwJTQN0iIgvnJgVT3eA-1
Received: by mail-lf1-f69.google.com with SMTP id
 bt36-20020a056512262400b003fd7e6a96e8so5517319lfb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 19:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2fREGIk8jReLlGTNXAectxIpYSI3IYPQI22eSOPGC+M=;
 b=TRcwQ9Hh7goddZOY+FSlNVX2/PK+7B1eCxC/lj+/AK2TK9z/RCLLFI0Y6uDexrNRRv
 vxK5EDVvKVU8TcNvCNixzs8QSWKZLtNWKJiIXiuZ4IoSKD5SIFvWDqhCBtkCKN+QYqDU
 lxsCYD51h+pI3xuZ12LV6bY4KnuB+8KQavdqrUh9t99LuQUQFRoxY5ECp//EhlaIExm0
 pesLEzsYLcVRvndLG4w7XEx1ADHYNKX5u5u0LQSDyaHRJaggtY21kJlq+IpDbUgGxuGc
 K1VYhsi8gQipW4g2jw+Pu/F3tKWjeLQcKLYQgucGeWt1psNBDWM7mfXTqO1lulklT5Im
 T4cQ==
X-Gm-Message-State: AOAM530hjyvk/QfMpZIE6rqB1QdtG+ZGVQXjXVaJS78wEOBgnmArwcQp
 ZhOFLUfKc7UrefwVbzTQy7DZtrA74F5NleyI1Hs8lt/y97G1LDfDYc/GguuxAiRvUuqf3csiwew
 Xod7ji9N4LeXS+MyI3BBpeuC+n+VTBB75zRTxq/QQUD4bH7mNJTODTqu/zw==
X-Received: by 2002:a05:6512:3b22:: with SMTP id
 f34mr29419442lfv.629.1634006648603; 
 Mon, 11 Oct 2021 19:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyx/KLlNrfkt0VZFwEzX8ZyEI7j45+2mfl4fPCObn1at2NnMfMijAQfk9/2snYOZBE/4Ph6vOTEckI0S3tYRs=
X-Received: by 2002:a05:6512:3b22:: with SMTP id
 f34mr29419417lfv.629.1634006648300; 
 Mon, 11 Oct 2021 19:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
 <20211011082640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211011082640-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Oct 2021 10:43:57 +0800
Message-ID: <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
Subject: Re: [PATCH 0/9] More virtio hardening
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Oct 11, 2021 at 8:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> > On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > > Hi All:
> > > >
> > > > This series treis to do more hardening for virito.
> > > >
> > > > patch 1 validates the num_queues for virio-blk device.
> > > > patch 2-4 validates max_nr_ports for virito-console device.
> > > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > > interrupt handler is tiggered. If this makes sense we can do similar
> > > > things in other transport drivers.
> > > > patch 8-9 validate used ring length.
> > > >
> > > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > > >
> > > > Please review.
> > > >
> > > > Thanks
> > >
> > > So I poked at console at least, and I think I see
> > > an issue: if interrupt handler queues a work/bh,
> > > then it can still run while reset is in progress.
> >
> > Looks like a bug which is unrelated to the hardening?
>
> Won't preventing use after free be relevant?

Oh right.

> I frankly don't know what does hardening means then.
> > E.g the driver
> > should sync with work/bh before reset.
>
> No, there's no way to fix it ATM without extra locks and state which I
> think we should strive to avoid or make it generic, not per-driver,
> since sync before reset is useless, new interrupts will just arrive and
> queue more work. And a sync after reset is too late since driver will
> try to add buffers.

Can we do something like

1) disable interrupt
2) sync bh

Or I guess this is somehow you meant in the following steps.

>
> Maybe we can break device. Two issues with that
> - drivers might not be ready to handle add_buf failures
> - restore needs to unbreak then and we don't have a way to do that yet
>
> So .. careful reading of all device drivers and hoping we don't mess
> things up even more ... here we come.

Yes.

>
> > >
> > > I sent a patch to fix it for console removal specifically,
> > > but I suspect it's not enough e.g. freeze is still broken.
> > > And note this has been reported without any TDX things -
> > > it's not a malicious device issue, can be triggered just
> > > by module unload.
> > >
> > > I am vaguely thinking about new APIs to disable/enable callbacks.
> > > An alternative:
> > >
> > > 1. adding new remove_nocb/freeze_nocb calls
> > > 2. disabling/enabling interrupts automatically around these
> > > 3. gradually moving devices to using these
> > > 4. once/if all device move, removing the old callbacks
> > >
> > > the advantage here is that we'll be sure calls are always
> > > paired correctly.
> >
> > I'm not sure I get the idea, but my feeling is that it doesn't
> > conflict with the interrupt hardening here (or at least the same
> > method is required e.g NO_AUTO_EN).
> >
> > Thanks
>
> Right.  It's not that it conflicts, it's that I was hoping that
> since you are working on hardening you can take up fixing that.
> Let me know whether you have the time. Thanks!

I can do that.

Thanks

>
> > >
> > >
> > >
> > >
> > >
> > > > Jason Wang (9):
> > > >   virtio-blk: validate num_queues during probe
> > > >   virtio: add doc for validate() method
> > > >   virtio-console: switch to use .validate()
> > > >   virtio_console: validate max_nr_ports before trying to use it
> > > >   virtio_config: introduce a new ready method
> > > >   virtio_pci: harden MSI-X interrupts
> > > >   virtio-pci: harden INTX interrupts
> > > >   virtio_ring: fix typos in vring_desc_extra
> > > >   virtio_ring: validate used buffer length
> > > >
> > > >  drivers/block/virtio_blk.c         |  3 +-
> > > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > > >  include/linux/virtio.h             |  1 +
> > > >  include/linux/virtio_config.h      |  6 ++++
> > > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
