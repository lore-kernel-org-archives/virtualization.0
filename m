Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D83C433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 07:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EEF960AA0;
	Fri, 11 Feb 2022 07:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcR1QSEG9QWD; Fri, 11 Feb 2022 07:09:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DB7FA60806;
	Fri, 11 Feb 2022 07:09:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90914C0011;
	Fri, 11 Feb 2022 07:09:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0881DC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EADD860AA0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pXCgBLk43_jC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:09:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 035B660806
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644563391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ouvEgmpHPvkcz1CBibgw4xI0LETLRKvIkcsiMvXvtnI=;
 b=Ht9RKTXcRRK8OnBkuVmsyePJmJ0lE2ViP52x/p0DFzxevWPV4fI6Q08FD/um4m3aJUHmIY
 w5fCXdR0M03p8j8g/CF/GesqMLV4b//UM2orv4tT+NKx8jskWCws5TlpXlmRCBUhJ1Ssxq
 Z+AmXcqLq24OnnEigUJQ02CJsCJtwf0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-_-epXqreOrixF9VBMCf17Q-1; Fri, 11 Feb 2022 02:09:48 -0500
X-MC-Unique: _-epXqreOrixF9VBMCf17Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 a13-20020a2eb54d000000b0023f5f64ae4fso3715317ljn.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ouvEgmpHPvkcz1CBibgw4xI0LETLRKvIkcsiMvXvtnI=;
 b=bKHRRYegl2mSkG6X/jxvcQgV3mGtIQt32mXlBaJcMrf9z12SA/xpIvpUUQyDtyvdoz
 +NXejf//nT+Bh4BXHF02Remh+f9GqgP1fF1IKMfYPxEXpYr/aRz9IVlRHdvxN6yRZ7bP
 vwvsIE9VcAXI8l/bXOAn5st8q4N6f0rw+L3Z1OUXOobkI7kxL8I5prUJypsWvFMs6bu7
 1mPYYJ9oS1Eb6Dhb8CWgsYhxeicT+51ryX5voaQ2r2lTjlfx6Bl+rMzkD8fOAfrwt8zG
 W+41Op3okP2xRW10OaBWK6IEETjsmmUBExwpSDJrsApy+MHMKh4TFC+SHvzi8hv2P8Rp
 JrDg==
X-Gm-Message-State: AOAM530M0KC+nonAy2Xpo88DuzLlsav6quuoE04OIvSA3toTFM8g+Cnj
 FLL41mQQAxhLR63nsNX3zEhBiiIbVNa6lJw/jzBv4OOi1YseP0A7I4Sui5CnCYI/aL8QVR7sDaL
 W8ma59LmB1CwQmBc72nL2J/95C/ANIDJcBzRN1N5nJX0gY39Fo/5gLevLaw==
X-Received: by 2002:a19:610e:: with SMTP id v14mr281130lfb.348.1644563386868; 
 Thu, 10 Feb 2022 23:09:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7T0pNUkYHnBgdtsf+7u3obLYe2WN2VJUUG3OUT7y/TCDIwEor31Qs1dvfrLHmaIulCGKDS/nysYgDt3PruBA=
X-Received: by 2002:a19:610e:: with SMTP id v14mr281119lfb.348.1644563386644; 
 Thu, 10 Feb 2022 23:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com>
 <1644560833.8375504-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644560833.8375504-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Feb 2022 15:09:35 +0800
Message-ID: <CACGkMEv0C_y4BDa0UqO_mB90jy_BEftM7QYpZM8yhfPKM0v=Ew@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Fri, Feb 11, 2022 at 2:34 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Fri, 11 Feb 2022 13:40:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Feb 9, 2022 at 8:29 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > The virtio spec already supports the virtio queue reset function. This patch set
> > > is to add this function to the kernel. The relevant virtio spec information is
> > > here:
> > >
> > >     https://github.com/oasis-tcs/virtio-spec/issues/124
> > >
> > > Also regarding MMIO support for queue reset, I plan to support it after this
> > > patch is passed.
> >
> > So I had an idea, we can implement ethtool_set_ringparam() in this
> > series to get one real users.
>
> I agree, in fact my local test is using this feature.

Right.

>
> >
> > But this came into another question: it looks to me current virito-net
> > just uses the maximum ring size, so it basically means we just can
> > decrease the number from startup, so I wonder how much value if we
> > don't limit the startup queue size to a dedicated value.
>
> I also have this consideration, so I want to add a virtio-net module parameter
> to specify an initial value.

But module parameters are not user friendly. Let it be changed via
ethtool should be sufficient.

>
> This initial value also has another meaning. In order to achieve high
> performance, the backend can provide a large ring size capability, but we also
> hope that the ring size can only be increased through ethtool -G when the user
> needs it.
>
> To implement this function, we need to add a new parameter to find_vqs().
>
> If there is no problem, I will bring this function in the next version.

I think so, and we need to choose a sane default value. I guess
something up to 1024 should be sufficient.

Thanks

>
> Thannks.
>
>
> >
> > Thanks
> >
> > >
> > > Please review. Thanks.
> > >
> > > v4:
> > >   1. just the code of virtio, without virtio-net
> > >   2. Performing reset on a queue is divided into these steps:
> > >     1. reset_vq: reset one vq
> > >     2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> > >     3. release the ring of the vq by vring_release_virtqueue()
> > >     4. enable_reset_vq: re-enable the reset queue
> > >   3. Simplify the parameters of enable_reset_vq()
> > >   4. add container structures for virtio_pci_common_cfg
> > >
> > > v3:
> > >   1. keep vq, irq unreleased
> > >
> > > Xuan Zhuo (14):
> > >   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
> > >   virtio: queue_reset: add VIRTIO_F_RING_RESET
> > >   virtio_ring: queue_reset: add function vring_setup_virtqueue()
> > >   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
> > >   virtio_ring: queue_reset: split: support enable reset queue
> > >   virtio_ring: queue_reset: packed: support enable reset queue
> > >   virtio_ring: queue_reset: extract the release function of the vq ring
> > >   virtio_ring: queue_reset: add vring_release_virtqueue()
> > >   virtio: queue_reset: struct virtio_config_ops add callbacks for
> > >     queue_reset
> > >   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
> > >     option functions
> > >   virtio_pci: queue_reset: release vq by vp_dev->vqs
> > >   virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
> > >   virtio_pci: queue_reset: vp_setup_vq() support ring_num
> > >   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
> > >
> > >  drivers/virtio/virtio_pci_common.c     |  65 +++++++---
> > >  drivers/virtio/virtio_pci_common.h     |  11 +-
> > >  drivers/virtio/virtio_pci_legacy.c     |   5 +-
> > >  drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
> > >  drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
> > >  drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
> > >  include/linux/virtio.h                 |   6 +
> > >  include/linux/virtio_config.h          |  13 ++
> > >  include/linux/virtio_pci_modern.h      |   2 +
> > >  include/linux/virtio_ring.h            |  37 ++++--
> > >  include/uapi/linux/virtio_config.h     |   7 +-
> > >  include/uapi/linux/virtio_pci.h        |  14 ++
> > >  12 files changed, 375 insertions(+), 93 deletions(-)
> > >
> > > --
> > > 2.31.0
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
