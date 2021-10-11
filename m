Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3CBC433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 07:37:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A42606A5
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 07:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7A42606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FC6581B70;
	Mon, 11 Oct 2021 07:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6_WYsVqlFPx; Mon, 11 Oct 2021 07:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 27E5B81B0A;
	Mon, 11 Oct 2021 07:37:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C680DC0011;
	Mon, 11 Oct 2021 07:37:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74327C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 07:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5715581B17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 07:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgOsVDlR3Qup
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 07:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 123DF81B0A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633937825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+zePsLaJ5jk9l+H2Z7aJXGzmwFM0MVSiI7p4UCnEWY=;
 b=WYN43ZCkQyp6uLMOyesZPL6wyJn9P3iCLXeBTfvvxq/tGyQFJqAdcTOy2Qxix3PNcDlFE4
 kRlrSW3Fl8+BTRrhR01BOAfGpDipwDdUHnvTlRoGB0PNvrsXB3oJjgxvprELdjWj5RZ0PI
 yuGpqw0LXXXW6a+UhWvhKEyKJE1poUM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-rK7Ip3F3Mbe6YOdxdmQ9rw-1; Mon, 11 Oct 2021 03:37:03 -0400
X-MC-Unique: rK7Ip3F3Mbe6YOdxdmQ9rw-1
Received: by mail-lf1-f70.google.com with SMTP id
 u17-20020a05651206d100b003fd714d9a38so6532501lff.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t+zePsLaJ5jk9l+H2Z7aJXGzmwFM0MVSiI7p4UCnEWY=;
 b=o6xjLBuT78FF2Wf8TmVCwkzzbl7N/RUQTKnwQQVIt7o9bCyq5UGNq/U234ICSVXdyF
 u/8tI5hfoxH5hgYRD3sFYGvUFlYV29RArgDzD4f1nwHSpOqeW1azFi9AEqeNZsJ3jVWO
 +lo+xrqxLPpw3a2S64g6NSy+yW9g8oiC4EQ5zESYhvTOy7DzqJJ8JBukZHGWLANiYM7V
 qm/L389o5cOSJCK9Yk6xOLjb7Wo8cuhw5n8BI7FjDUBZuoL8Ai1cCBBTPx1Spmywgy+K
 BD7QNTZa7uKYfndxZDrAX9qUIEsrkh4gBhSlnplXElmdcIdhPVWI+EZOh52IiFlsJIVX
 4Sdg==
X-Gm-Message-State: AOAM530O2kNapj1rQQomn5QAQcv4LZ69GVxjLLtZ5dNJyhDrMwnipzEy
 JeQlAsUps6UgCYV2IltSuPbhBmwdn2cRbiRGWoXu5kGzqDSd9PdvS1k9srXIjG+iaaEOi8LzOTf
 H4IyhV7R82TWXQak8Nranljy8FkdnmXWCKMtqM5kOasn+KkmCyjyxVbpV0A==
X-Received: by 2002:a2e:a553:: with SMTP id e19mr21985060ljn.420.1633937822200; 
 Mon, 11 Oct 2021 00:37:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHF43Bv4a442lrS3Inm2wP5avpUoj52WKebeHxwAtu27Oel/SY3K49AAyzdQxaxbDPKhgTNCLNKOFGhPaYcA0=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr21985044ljn.420.1633937821988; 
 Mon, 11 Oct 2021 00:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20211005032924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211005032924-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Oct 2021 15:36:51 +0800
Message-ID: <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > Hi All:
> >
> > This series treis to do more hardening for virito.
> >
> > patch 1 validates the num_queues for virio-blk device.
> > patch 2-4 validates max_nr_ports for virito-console device.
> > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > interrupt handler is tiggered. If this makes sense we can do similar
> > things in other transport drivers.
> > patch 8-9 validate used ring length.
> >
> > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> >
> > Please review.
> >
> > Thanks
>
> So I poked at console at least, and I think I see
> an issue: if interrupt handler queues a work/bh,
> then it can still run while reset is in progress.

Looks like a bug which is unrelated to the hardening? E.g the driver
should sync with work/bh before reset.

>
> I sent a patch to fix it for console removal specifically,
> but I suspect it's not enough e.g. freeze is still broken.
> And note this has been reported without any TDX things -
> it's not a malicious device issue, can be triggered just
> by module unload.
>
> I am vaguely thinking about new APIs to disable/enable callbacks.
> An alternative:
>
> 1. adding new remove_nocb/freeze_nocb calls
> 2. disabling/enabling interrupts automatically around these
> 3. gradually moving devices to using these
> 4. once/if all device move, removing the old callbacks
>
> the advantage here is that we'll be sure calls are always
> paired correctly.

I'm not sure I get the idea, but my feeling is that it doesn't
conflict with the interrupt hardening here (or at least the same
method is required e.g NO_AUTO_EN).

Thanks

>
>
>
>
>
> > Jason Wang (9):
> >   virtio-blk: validate num_queues during probe
> >   virtio: add doc for validate() method
> >   virtio-console: switch to use .validate()
> >   virtio_console: validate max_nr_ports before trying to use it
> >   virtio_config: introduce a new ready method
> >   virtio_pci: harden MSI-X interrupts
> >   virtio-pci: harden INTX interrupts
> >   virtio_ring: fix typos in vring_desc_extra
> >   virtio_ring: validate used buffer length
> >
> >  drivers/block/virtio_blk.c         |  3 +-
> >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> >  drivers/virtio/virtio_pci_common.h |  7 ++--
> >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> >  include/linux/virtio.h             |  1 +
> >  include/linux/virtio_config.h      |  6 ++++
> >  9 files changed, 118 insertions(+), 31 deletions(-)
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
