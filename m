Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897E1C433FE
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 12:36:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4268661038
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 12:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4268661038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1013E40333;
	Mon, 11 Oct 2021 12:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jx3b2XJ9f44v; Mon, 11 Oct 2021 12:36:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65A8C400A4;
	Mon, 11 Oct 2021 12:36:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D440C0011;
	Mon, 11 Oct 2021 12:36:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A18A0C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 12:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9187681AA7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 12:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oES52XaDqXmp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 12:36:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 948CF81AD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633955786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrUQkfy44LwX8fmQn2Zrl2/DU83nyPEQ3GJ0LUQ6ZjE=;
 b=N+Qp/hzMvwnnA4UD4yiCkBHPVCOM/5MHlNIilo7W0IPfOUgZuWQSbMnYyfDqsfvdc3kTEl
 HQlnc0hMjzOX25e35X+c+5Zsnp1SzJ6EVBKfkggqrO/m1V8aCW8lHj7QyriBP0JkYAldrO
 6m+VkWGjggM8uBPJ9lPDkGBvoj1FjaY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-tPxFgqTOOcKrMCtdIe0wiQ-1; Mon, 11 Oct 2021 08:36:25 -0400
X-MC-Unique: tPxFgqTOOcKrMCtdIe0wiQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 r11-20020aa7cfcb000000b003d4fbd652b9so13718148edy.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 05:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GrUQkfy44LwX8fmQn2Zrl2/DU83nyPEQ3GJ0LUQ6ZjE=;
 b=CGRjPgle8zqlHYU6Whnp/nYIDOoVoQyixC3hMgfZAcGkqXDYMENh6v5eahJpiQfBGt
 Cuar3h+bmv5CwVohE4hny0HniLcJMga5ATd4qftPE1wZQJWOrQAIEabpsF9nevwFRoYY
 KvzvJ7WbNa9hzv3RfIYCUnDQkTJsuyinEjwfT1SgslkrqhRnOg1lKJnxKQHsASV0m3Pw
 nFksQiaBMgWhiMwhwM4PgmksfpVaMrNyo7Ey2VATCaxzD0NItOlZqWh/W9UYX3b8EbZ1
 WmJYi1k7BJGzUTbJu1sFJKgsIgbPWPsP9xBYSdwGVShk61SKZuxpLplDymNGxvqd6f8U
 3UAQ==
X-Gm-Message-State: AOAM5330adN7u3eycBeHe3rj+TO0/R1eZVZGC0nT8mUo4YI+n08E4ajN
 VF2iyT3DRE4duKOVZH6IClJI1ExKeEBwojSypb+m07ur84vLBl3uCZnrJeLNF+TzJ4ulnEiP/Mx
 L8xpVVqyv1nRLGtIHf7U0OsydL5l5/t/Y0L6iFYfZxQ==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr40623247edj.85.1633955783979; 
 Mon, 11 Oct 2021 05:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUHUlowo8yKJap2dLlduI1p5gsrv1S32zcK1Jih//aSKoZhhLQqAIuRjYwg1HKIyO/huFh9Q==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr40623218edj.85.1633955783796; 
 Mon, 11 Oct 2021 05:36:23 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id e7sm4414518edk.3.2021.10.11.05.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Oct 2021 05:36:23 -0700 (PDT)
Date: Mon, 11 Oct 2021 08:36:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/9] More virtio hardening
Message-ID: <20211011082640-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > Hi All:
> > >
> > > This series treis to do more hardening for virito.
> > >
> > > patch 1 validates the num_queues for virio-blk device.
> > > patch 2-4 validates max_nr_ports for virito-console device.
> > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > interrupt handler is tiggered. If this makes sense we can do similar
> > > things in other transport drivers.
> > > patch 8-9 validate used ring length.
> > >
> > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > >
> > > Please review.
> > >
> > > Thanks
> >
> > So I poked at console at least, and I think I see
> > an issue: if interrupt handler queues a work/bh,
> > then it can still run while reset is in progress.
> 
> Looks like a bug which is unrelated to the hardening?

Won't preventing use after free be relevant?
I frankly don't know what does hardening means then.
> E.g the driver
> should sync with work/bh before reset.

No, there's no way to fix it ATM without extra locks and state which I
think we should strive to avoid or make it generic, not per-driver,
since sync before reset is useless, new interrupts will just arrive and
queue more work. And a sync after reset is too late since driver will
try to add buffers.

Maybe we can break device. Two issues with that
- drivers might not be ready to handle add_buf failures
- restore needs to unbreak then and we don't have a way to do that yet

So .. careful reading of all device drivers and hoping we don't mess
things up even more ... here we come.

> >
> > I sent a patch to fix it for console removal specifically,
> > but I suspect it's not enough e.g. freeze is still broken.
> > And note this has been reported without any TDX things -
> > it's not a malicious device issue, can be triggered just
> > by module unload.
> >
> > I am vaguely thinking about new APIs to disable/enable callbacks.
> > An alternative:
> >
> > 1. adding new remove_nocb/freeze_nocb calls
> > 2. disabling/enabling interrupts automatically around these
> > 3. gradually moving devices to using these
> > 4. once/if all device move, removing the old callbacks
> >
> > the advantage here is that we'll be sure calls are always
> > paired correctly.
> 
> I'm not sure I get the idea, but my feeling is that it doesn't
> conflict with the interrupt hardening here (or at least the same
> method is required e.g NO_AUTO_EN).
> 
> Thanks

Right.  It's not that it conflicts, it's that I was hoping that
since you are working on hardening you can take up fixing that.
Let me know whether you have the time. Thanks!

> >
> >
> >
> >
> >
> > > Jason Wang (9):
> > >   virtio-blk: validate num_queues during probe
> > >   virtio: add doc for validate() method
> > >   virtio-console: switch to use .validate()
> > >   virtio_console: validate max_nr_ports before trying to use it
> > >   virtio_config: introduce a new ready method
> > >   virtio_pci: harden MSI-X interrupts
> > >   virtio-pci: harden INTX interrupts
> > >   virtio_ring: fix typos in vring_desc_extra
> > >   virtio_ring: validate used buffer length
> > >
> > >  drivers/block/virtio_blk.c         |  3 +-
> > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > >  include/linux/virtio.h             |  1 +
> > >  include/linux/virtio_config.h      |  6 ++++
> > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > >
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
