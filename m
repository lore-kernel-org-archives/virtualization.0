Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B154BC433FE
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:43:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6793B6103D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6793B6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2ADB6402DB;
	Tue, 12 Oct 2021 06:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMSsmsdHU-Oy; Tue, 12 Oct 2021 06:43:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 242E940273;
	Tue, 12 Oct 2021 06:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06D28C000F;
	Tue, 12 Oct 2021 06:43:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1EFC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CA76405CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M4pveLvEqhs8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:43:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5045B4028C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634021008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W390FrjXxeXjnKet3sM0Jh3/nx2JTaDKLct7RHoJ/nE=;
 b=cmTp5SVgbjLDCEEQmXoL2wEqyNsJLVAxZHdAAqnb3+7SIo9Zz73le/xlR1H0jqctLp2auq
 foCzwCr6SRCEzXK7vi2iD1smVHiyFmttO+sokD53E5PIiB2RE36aJM6QzItPEzf1lQx9yE
 rrB4Br7Bvlurulul1uDbipHBaHWtYdQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-4vVZVVXPNvOGH-z20XidGw-1; Tue, 12 Oct 2021 02:43:26 -0400
X-MC-Unique: 4vVZVVXPNvOGH-z20XidGw-1
Received: by mail-lf1-f71.google.com with SMTP id
 k8-20020a0565123d8800b003fd6e160c77so9522159lfv.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 23:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W390FrjXxeXjnKet3sM0Jh3/nx2JTaDKLct7RHoJ/nE=;
 b=OdGh02yoxHozz0VepmbA4Q3Y4mCMIsAIqHK0/zqhuozkQEqrtV1dEehDh4gM+YxvRy
 ywdbWOFL7TsXcVupVY42/85Zm7n0srz/P9yNpOVtKnM2NE9qZggUNDO/uY9uk09ip2g4
 KnKztRSRNLuMGOXB9kaskYuC3EIOW/3JjH+0B2qQ0YHov3lo/Wi5bNsTxvIzI/OEXs4J
 4wF5ZLfCw0Zs0+tsQNuExnz9K9tlWw1tMs+9dJq6U/nHxu5HHm7BofMC9ElL1BFVAVDj
 Wvb0s8Tdmk7b2n7/xHkwhZhXesHdIdYaxUK3PodfhNNs4QlbnjFJK0Url5dJBWe4ouVj
 n60w==
X-Gm-Message-State: AOAM5339nAqvixW6IPKs5HsqmteOozmjiP8coudUP871JVY1mCb8iocP
 GPiuEUxYRwIsDZCFv9EudjrKTkcKGJu1He+RdwgnMvJdhpJa0e7GBbGbViYEhIq+o2L/IndiTCq
 DSFerzcbujXeW+mRAEpN3V6xsD+pUGqtG4Maw6XnvHwyzFKMiqIPA471qsg==
X-Received: by 2002:a2e:a553:: with SMTP id e19mr28492037ljn.420.1634021005067; 
 Mon, 11 Oct 2021 23:43:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoy+gcs2eNCuGhKxv4BOP2gevTlYF6Z+9SYHdphBSamNOOPOqU1bhAbAjzt6njDFZ5bADKXIU4B0VtS7YbKuw=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr28492018ljn.420.1634021004831; 
 Mon, 11 Oct 2021 23:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
 <20211011082640-mutt-send-email-mst@kernel.org>
 <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
 <20211012012617-mutt-send-email-mst@kernel.org>
 <CACGkMEu5oP=vix8gZgQi0Y==VBvxqoTg+yG-cu1FenZH6csepw@mail.gmail.com>
 <20211012022024-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211012022024-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Oct 2021 14:43:13 +0800
Message-ID: <CACGkMEvtobDX-bvjhFtDGa8N6PFrvcwnM_5EXGOEgEAVY517=A@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 2:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:11:10PM +0800, Jason Wang wrote:
> > On Tue, Oct 12, 2021 at 1:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 10:43:57AM +0800, Jason Wang wrote:
> > > > On Mon, Oct 11, 2021 at 8:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> > > > > > On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > > > > > > Hi All:
> > > > > > > >
> > > > > > > > This series treis to do more hardening for virito.
> > > > > > > >
> > > > > > > > patch 1 validates the num_queues for virio-blk device.
> > > > > > > > patch 2-4 validates max_nr_ports for virito-console device.
> > > > > > > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > > > > > > interrupt handler is tiggered. If this makes sense we can do similar
> > > > > > > > things in other transport drivers.
> > > > > > > > patch 8-9 validate used ring length.
> > > > > > > >
> > > > > > > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > > > > > > >
> > > > > > > > Please review.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > So I poked at console at least, and I think I see
> > > > > > > an issue: if interrupt handler queues a work/bh,
> > > > > > > then it can still run while reset is in progress.
> > > > > >
> > > > > > Looks like a bug which is unrelated to the hardening?
> > > > >
> > > > > Won't preventing use after free be relevant?
> > > >
> > > > Oh right.
> > > >
> > > > > I frankly don't know what does hardening means then.
> > > > > > E.g the driver
> > > > > > should sync with work/bh before reset.
> > > > >
> > > > > No, there's no way to fix it ATM without extra locks and state which I
> > > > > think we should strive to avoid or make it generic, not per-driver,
> > > > > since sync before reset is useless, new interrupts will just arrive and
> > > > > queue more work. And a sync after reset is too late since driver will
> > > > > try to add buffers.
> > > >
> > > > Can we do something like
> > > >
> > > > 1) disable interrupt
> > > > 2) sync bh
> > > >
> > > > Or I guess this is somehow you meant in the following steps.
> > >
> > > So that would mean a new API to disable vq interrupts.
> > > reset will re-enable.
> > > E.g. virtqueue_cancel_cb_before_reset()?
> > >
> > > Then drivers can sync, then reset.
> > > This means maintaining more state though, which I don't like.
> > >
> > > An alternative is something like this:
> > >
> > > static void (*virtio_flush_device)(struct virtio_device *dev);
> > >
> > > void virtio_reset_device(struct virtio_device *dev, virtio_flush_device flush)
> > > {
> > >         might_sleep();
> > >         if (flush) {
> > >                 dev->config->disable_interrupts(dev);
> > >                 flush(dev);
> > >                 dev->config->reset(dev);
> > >                 dev->config->enable_interrupts(dev);
> >
> > I wonder whether this is needed. As done in this series,
> > enable_interrupt should be done in virtio_device_ready().
> >
> > Others should work.
> >
> > >         } else {
> > >                 dev->config->reset(dev);
> > >         }
> > > }
> > >
> > > I have patches wrapping all reset calls in virtio_reset_device
> > > (without the flush parameter but that's easy to tweak).
> >
> > Does it work if I post V2 and you post those patches on top?
>
> The reset things? Sure.

Ok.

>
> > >
> > >
> > > > >
> > > > > Maybe we can break device. Two issues with that
> > > > > - drivers might not be ready to handle add_buf failures
> > > > > - restore needs to unbreak then and we don't have a way to do that yet
> > > > >
> > > > > So .. careful reading of all device drivers and hoping we don't mess
> > > > > things up even more ... here we come.
> > > >
> > > > Yes.
> > >
> > > The biggest issue with this trick is drivers not handling add_buf
> > > errors, adding a failure path here risks creating memory leaks.
> > > OTOH with e.g. bounce buffers maybe it's possible for add buf to
> > > fail anyway?
> >
> > I'm not sure I get this, a simple git grep told me at least the return
> > value of add_inbuf() were all checked.
> >
> > Thanks
>
> Checked locally, but not always error is handled all the way
> to the top. E.g. add_port in console returns an error code
> but that is never checked. Well, console is a mess generally.

I see. I can try to audit all virtio drivers for the add_inbuf() case.

Thanks

>
> > >
> > > > >
> > > > > > >
> > > > > > > I sent a patch to fix it for console removal specifically,
> > > > > > > but I suspect it's not enough e.g. freeze is still broken.
> > > > > > > And note this has been reported without any TDX things -
> > > > > > > it's not a malicious device issue, can be triggered just
> > > > > > > by module unload.
> > > > > > >
> > > > > > > I am vaguely thinking about new APIs to disable/enable callbacks.
> > > > > > > An alternative:
> > > > > > >
> > > > > > > 1. adding new remove_nocb/freeze_nocb calls
> > > > > > > 2. disabling/enabling interrupts automatically around these
> > > > > > > 3. gradually moving devices to using these
> > > > > > > 4. once/if all device move, removing the old callbacks
> > > > > > >
> > > > > > > the advantage here is that we'll be sure calls are always
> > > > > > > paired correctly.
> > > > > >
> > > > > > I'm not sure I get the idea, but my feeling is that it doesn't
> > > > > > conflict with the interrupt hardening here (or at least the same
> > > > > > method is required e.g NO_AUTO_EN).
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Right.  It's not that it conflicts, it's that I was hoping that
> > > > > since you are working on hardening you can take up fixing that.
> > > > > Let me know whether you have the time. Thanks!
> > > >
> > > > I can do that.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > Jason Wang (9):
> > > > > > > >   virtio-blk: validate num_queues during probe
> > > > > > > >   virtio: add doc for validate() method
> > > > > > > >   virtio-console: switch to use .validate()
> > > > > > > >   virtio_console: validate max_nr_ports before trying to use it
> > > > > > > >   virtio_config: introduce a new ready method
> > > > > > > >   virtio_pci: harden MSI-X interrupts
> > > > > > > >   virtio-pci: harden INTX interrupts
> > > > > > > >   virtio_ring: fix typos in vring_desc_extra
> > > > > > > >   virtio_ring: validate used buffer length
> > > > > > > >
> > > > > > > >  drivers/block/virtio_blk.c         |  3 +-
> > > > > > > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > > > > > > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > > > > > > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > > > > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > > > > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > > > > > > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > > > > > > >  include/linux/virtio.h             |  1 +
> > > > > > > >  include/linux/virtio_config.h      |  6 ++++
> > > > > > > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
