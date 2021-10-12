Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 08:46:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E268A61056
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 08:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E268A61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F3D940688;
	Tue, 12 Oct 2021 08:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m6jPFzRU-74k; Tue, 12 Oct 2021 08:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03B5C4065E;
	Tue, 12 Oct 2021 08:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D56AAC000F;
	Tue, 12 Oct 2021 08:46:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC33CC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 08:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEFD9607B3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 08:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXobeSvAl-U1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 08:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EF7E6078E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 08:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634028376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jbtmrvdydVcbKtmwH0mVqKY5lC9q0zSEeq9Jm8aa9s=;
 b=Ewo3xpeiDZ1moTIsdsSNa6Lg3iyjfn9IuJl4R7rhkBj0sRvl1fjrwNvbKps8jFkyIPS7FF
 Nfe/Hxh8pjaEPvu9PqZsCs4Ug/kQJhKpCfxDYhkDUAGyPtKOyshXmF7IC4Xvl9ZYIoBzhP
 k2zcmvMe9EvtfA5k/CM/fwkC8HyFcD0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-KcPEGhxWPzm6WBLELXCrUA-1; Tue, 12 Oct 2021 04:46:13 -0400
X-MC-Unique: KcPEGhxWPzm6WBLELXCrUA-1
Received: by mail-lf1-f70.google.com with SMTP id
 k8-20020a0565123d8800b003fd6e160c77so9747604lfv.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 01:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8jbtmrvdydVcbKtmwH0mVqKY5lC9q0zSEeq9Jm8aa9s=;
 b=xLWLKOS0FS54N1r95cVTPzJsc3MC3tEiirBZtJGzE3EV9qoo3XUqygHvuwBcWGhDUH
 OtU8Scqpa7GSMpXq2ozSCmBmblVitAIEqT9H7uYIffpbKHtQFFsn3DEebbSjq+FaqWGk
 ztYPhv4hk8BSKkask/mA+MJAHjgk6bhsUbKJdz1gl5A97m0rSQAa6ClrpHW2bblalmb3
 QrSV54lsKUy0uBZvbhQOd9NvEWrou5+urgvaT5XXTTf0l1XnMgf2lUT1v55Bk7Dq7Zfe
 BrEQGQU30HNimcz0CfBlj/4mlw3/0VCRh3+pSN9MU8VfQC/+u49ySqg9TJ5FJfkqZaKp
 OwkA==
X-Gm-Message-State: AOAM5319W5BXHE3Zw3ZIGnQ2e7MM5GbBAnFtyDB0Qf+EcA/bqQBq5PVK
 NxubRS1iBGHKpF0IAIq4yVZi6TugVaAwSI6xBPIqZBUYe7m05ZdGQQVBFKzGv68YtwYYMeWPKpY
 M2HlVsEZKnpEIBoiK0RA16RA+vYc6NT3qJxtsaeBTouImHlII4ldZcrqwzg==
X-Received: by 2002:ac2:43d1:: with SMTP id u17mr12793475lfl.348.1634028371643; 
 Tue, 12 Oct 2021 01:46:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbfo+wRlZQ4toG3xfT67w0misrN1XCgXks2u7IG1JuYC3sMCHZSrIKtMdp5Aamvp7Pxwzc53Wod5ofiphwDE8=
X-Received: by 2002:ac2:43d1:: with SMTP id u17mr12793452lfl.348.1634028371392; 
 Tue, 12 Oct 2021 01:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
 <20211011082640-mutt-send-email-mst@kernel.org>
 <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
 <20211012012617-mutt-send-email-mst@kernel.org>
 <CACGkMEu5oP=vix8gZgQi0Y==VBvxqoTg+yG-cu1FenZH6csepw@mail.gmail.com>
 <20211012022024-mutt-send-email-mst@kernel.org>
 <CACGkMEvtobDX-bvjhFtDGa8N6PFrvcwnM_5EXGOEgEAVY517=A@mail.gmail.com>
 <20211012030143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211012030143-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Oct 2021 16:46:00 +0800
Message-ID: <CACGkMEv9hFk6efhikY+CtpiCTAT3_at+ww7rPQ9tWP5qC+JWsw@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 3:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:43:13PM +0800, Jason Wang wrote:
> > On Tue, Oct 12, 2021 at 2:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 02:11:10PM +0800, Jason Wang wrote:
> > > > On Tue, Oct 12, 2021 at 1:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 12, 2021 at 10:43:57AM +0800, Jason Wang wrote:
> > > > > > On Mon, Oct 11, 2021 at 8:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> > > > > > > > On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > > > > > > > > Hi All:
> > > > > > > > > >
> > > > > > > > > > This series treis to do more hardening for virito.
> > > > > > > > > >
> > > > > > > > > > patch 1 validates the num_queues for virio-blk device.
> > > > > > > > > > patch 2-4 validates max_nr_ports for virito-console device.
> > > > > > > > > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > > > > > > > > interrupt handler is tiggered. If this makes sense we can do similar
> > > > > > > > > > things in other transport drivers.
> > > > > > > > > > patch 8-9 validate used ring length.
> > > > > > > > > >
> > > > > > > > > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > > > > > > > > >
> > > > > > > > > > Please review.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > So I poked at console at least, and I think I see
> > > > > > > > > an issue: if interrupt handler queues a work/bh,
> > > > > > > > > then it can still run while reset is in progress.
> > > > > > > >
> > > > > > > > Looks like a bug which is unrelated to the hardening?
> > > > > > >
> > > > > > > Won't preventing use after free be relevant?
> > > > > >
> > > > > > Oh right.
> > > > > >
> > > > > > > I frankly don't know what does hardening means then.
> > > > > > > > E.g the driver
> > > > > > > > should sync with work/bh before reset.
> > > > > > >
> > > > > > > No, there's no way to fix it ATM without extra locks and state which I
> > > > > > > think we should strive to avoid or make it generic, not per-driver,
> > > > > > > since sync before reset is useless, new interrupts will just arrive and
> > > > > > > queue more work. And a sync after reset is too late since driver will
> > > > > > > try to add buffers.
> > > > > >
> > > > > > Can we do something like
> > > > > >
> > > > > > 1) disable interrupt
> > > > > > 2) sync bh
> > > > > >
> > > > > > Or I guess this is somehow you meant in the following steps.
> > > > >
> > > > > So that would mean a new API to disable vq interrupts.
> > > > > reset will re-enable.
> > > > > E.g. virtqueue_cancel_cb_before_reset()?
> > > > >
> > > > > Then drivers can sync, then reset.
> > > > > This means maintaining more state though, which I don't like.
> > > > >
> > > > > An alternative is something like this:
> > > > >
> > > > > static void (*virtio_flush_device)(struct virtio_device *dev);
> > > > >
> > > > > void virtio_reset_device(struct virtio_device *dev, virtio_flush_device flush)
> > > > > {
> > > > >         might_sleep();
> > > > >         if (flush) {
> > > > >                 dev->config->disable_interrupts(dev);
> > > > >                 flush(dev);
> > > > >                 dev->config->reset(dev);
> > > > >                 dev->config->enable_interrupts(dev);
> > > >
> > > > I wonder whether this is needed. As done in this series,
> > > > enable_interrupt should be done in virtio_device_ready().
> > > >
> > > > Others should work.
> > > >
> > > > >         } else {
> > > > >                 dev->config->reset(dev);
> > > > >         }
> > > > > }
> > > > >
> > > > > I have patches wrapping all reset calls in virtio_reset_device
> > > > > (without the flush parameter but that's easy to tweak).
> > > >
> > > > Does it work if I post V2 and you post those patches on top?
> > >
> > > The reset things? Sure.
> >
> > Ok.
> >
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > Maybe we can break device. Two issues with that
> > > > > > > - drivers might not be ready to handle add_buf failures
> > > > > > > - restore needs to unbreak then and we don't have a way to do that yet
> > > > > > >
> > > > > > > So .. careful reading of all device drivers and hoping we don't mess
> > > > > > > things up even more ... here we come.
> > > > > >
> > > > > > Yes.
> > > > >
> > > > > The biggest issue with this trick is drivers not handling add_buf
> > > > > errors, adding a failure path here risks creating memory leaks.
> > > > > OTOH with e.g. bounce buffers maybe it's possible for add buf to
> > > > > fail anyway?
> > > >
> > > > I'm not sure I get this, a simple git grep told me at least the return
> > > > value of add_inbuf() were all checked.
> > > >
> > > > Thanks
> > >
> > > Checked locally, but not always error is handled all the way
> > > to the top. E.g. add_port in console returns an error code
> > > but that is never checked. Well, console is a mess generally.
> >
> > I see. I can try to audit all virtio drivers for the add_inbuf() case.
> >
> > Thanks
>
> Why inbuf specifically?

Typo :(

> I mean, re-reading code often finds bugs, sure ;)

Yes.

>
> But I don't think just to fix remove we need to audit them all
> as such, as long as we are not modifying core, whatever
> driver remove we are poking for, that driver needs to be
> audited.

Right.

Thanks

>
>
> > >
> > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > I sent a patch to fix it for console removal specifically,
> > > > > > > > > but I suspect it's not enough e.g. freeze is still broken.
> > > > > > > > > And note this has been reported without any TDX things -
> > > > > > > > > it's not a malicious device issue, can be triggered just
> > > > > > > > > by module unload.
> > > > > > > > >
> > > > > > > > > I am vaguely thinking about new APIs to disable/enable callbacks.
> > > > > > > > > An alternative:
> > > > > > > > >
> > > > > > > > > 1. adding new remove_nocb/freeze_nocb calls
> > > > > > > > > 2. disabling/enabling interrupts automatically around these
> > > > > > > > > 3. gradually moving devices to using these
> > > > > > > > > 4. once/if all device move, removing the old callbacks
> > > > > > > > >
> > > > > > > > > the advantage here is that we'll be sure calls are always
> > > > > > > > > paired correctly.
> > > > > > > >
> > > > > > > > I'm not sure I get the idea, but my feeling is that it doesn't
> > > > > > > > conflict with the interrupt hardening here (or at least the same
> > > > > > > > method is required e.g NO_AUTO_EN).
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Right.  It's not that it conflicts, it's that I was hoping that
> > > > > > > since you are working on hardening you can take up fixing that.
> > > > > > > Let me know whether you have the time. Thanks!
> > > > > >
> > > > > > I can do that.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Jason Wang (9):
> > > > > > > > > >   virtio-blk: validate num_queues during probe
> > > > > > > > > >   virtio: add doc for validate() method
> > > > > > > > > >   virtio-console: switch to use .validate()
> > > > > > > > > >   virtio_console: validate max_nr_ports before trying to use it
> > > > > > > > > >   virtio_config: introduce a new ready method
> > > > > > > > > >   virtio_pci: harden MSI-X interrupts
> > > > > > > > > >   virtio-pci: harden INTX interrupts
> > > > > > > > > >   virtio_ring: fix typos in vring_desc_extra
> > > > > > > > > >   virtio_ring: validate used buffer length
> > > > > > > > > >
> > > > > > > > > >  drivers/block/virtio_blk.c         |  3 +-
> > > > > > > > > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > > > > > > > > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > > > > > > > > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > > > > > > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > > > > > > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > > > > > > > > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > > > > > > > > >  include/linux/virtio.h             |  1 +
> > > > > > > > > >  include/linux/virtio_config.h      |  6 ++++
> > > > > > > > > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
