Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60495C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:28:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52B560FC1
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E52B560FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B21CD4041A;
	Mon, 13 Sep 2021 06:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wsCnbvMhBJ1q; Mon, 13 Sep 2021 06:28:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1439140406;
	Mon, 13 Sep 2021 06:28:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB9D5C0011;
	Mon, 13 Sep 2021 06:28:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3D16C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7B964041A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VkE8aVV7hbPm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A10340406
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631514501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BYAS07LqRKjKh4D9k7FNbxnrfqn/32QnLabKdU5x4Y=;
 b=EYBFAWaz++rKqT/8X3HjQMFBLMsdJvKt8djpGmmyNCzEujw6ImeqyxxOjzuGGeUq7OK+3/
 tU3FWOqrkHvOqkUVNpeHjIOm6u5/fUk1GZRIRdlCaea6SwHKFew/mDB5464N2uzhohHbta
 I/6Clrmbc9CqZ4uGJWVhNG2nCBIdJG8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Wz-mY1aKNBay1KruJ4j1ZA-1; Mon, 13 Sep 2021 02:28:18 -0400
X-MC-Unique: Wz-mY1aKNBay1KruJ4j1ZA-1
Received: by mail-ed1-f71.google.com with SMTP id
 b8-20020a056402350800b003c5e3d4e2a7so4411498edd.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2BYAS07LqRKjKh4D9k7FNbxnrfqn/32QnLabKdU5x4Y=;
 b=Jtl715gBRkof4RsrYhJTR8sXJ4saTp56uDuxJ+N15+NEmH+gHmbz4kwyiRdKy87Zo2
 nFwLAA3b7Fc2XLZmt+5ngCFy3Uz9KHzjATOWPEG4NZTu3Q3eotNZsV9gpKMpC5ZH3Cln
 Hxp228ubmIQ2ECGLL9DKzsLOrHeEGdyS6MMas38RNt/awjWFd6AgONiXroMobpNWJlcU
 QdhXCzVkd94axha0RS/tRkdrx+MWXvYFl3+iJUmvP2XKqzDZGoXBsdYCbkdLTkHalyL5
 V/MysxY6MlGK0VrnUz2+n3TDQo65mAWwTH9IkumSFWKvngBNC/z7i3IVSR1rRSYoWFCV
 e3DA==
X-Gm-Message-State: AOAM530xiyftkV46sqKEo7nMHQrA/jYhrtvsq03G/3cbrgOs9oSJ583L
 zNr429KzHaWvBJDtXK/BLSgeYXznu3GcVZ0aZ1tL1geTeyNwjrdfOvHtqnBYsrbr6Qujzn86C9/
 3IxBf6bjieqmAES4R3RvSZBBFEz8oNSI2qRAB7Vi7YQ==
X-Received: by 2002:a17:906:6b93:: with SMTP id
 l19mr11192515ejr.26.1631514497632; 
 Sun, 12 Sep 2021 23:28:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywTIRrKo4AAwjnRKPDGrx6fxO7qKVjLAHhYnnhxm+Kplf4NaW7QfkSTmbs9Yyc0l+8mt2OzQ==
X-Received: by 2002:a17:906:6b93:: with SMTP id
 l19mr11192492ejr.26.1631514497426; 
 Sun, 12 Sep 2021 23:28:17 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id t1sm3314220edq.31.2021.09.12.23.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 23:28:16 -0700 (PDT)
Date: Mon, 13 Sep 2021 02:28:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
Message-ID: <20210913022257-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, pbonzini <pbonzini@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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

On Mon, Sep 13, 2021 at 02:08:02PM +0800, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 01:53:50PM +0800, Jason Wang wrote:
> > > We used to synchronize pending MSI-X irq handlers via
> > > synchronize_irq(), this may not work for the untrusted device which
> > > may keep sending interrupts after reset which may lead unexpected
> > > results. Similarly, we should not enable MSI-X interrupt until the
> > > device is ready. So this patch fixes those two issues by:
> > >
> > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > >    handlers to be called after the device is reset.
> > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > >
> > > This can make sure the virtio interrupt handler won't be called before
> > > virtio_device_ready() and after reset.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > I don't get the threat model here. Isn't disabling irqs done by the
> > hypervisor anyway? Is there a reason to trust disable_irq but not
> > device reset?
> 
> My understanding is that e.g in the case of SEV/TDX we don't trust the
> hypervisor. So the hypervisor can keep sending interrupts even if the
> device is reset. The guest can only trust its own software interrupt
> management logic to avoid call virtio callback in this case.
> 
> Thanks

Hmm but I don't see how do these patches do this.
They call disable_irq but can't the hypervisor keep
sending interrupts after disable_irq, too?



> >
> > Cc a bunch more people ...
> >
> >
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index b35bb2d57f62..0b9523e6dd39 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > >                "Force legacy mode for transitional virtio 1 devices");
> > >  #endif
> > >
> > > -/* wait for pending irq handlers */
> > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > +/* disable irq handlers */
> > > +void vp_disable_vectors(struct virtio_device *vdev)
> > >  {
> > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >       int i;
> > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > >               synchronize_irq(vp_dev->pci_dev->irq);
> > >
> > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > -             synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > +             disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > +}
> > > +
> > > +/* enable irq handlers */
> > > +void vp_enable_vectors(struct virtio_device *vdev)
> > > +{
> > > +     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +     int i;
> > > +
> > > +     if (vp_dev->intx_enabled)
> > > +             return;
> > > +
> > > +     for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > +             enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > >  }
> > >
> > >  /* the notify function used when creating a virt queue */
> > > @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > >       snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > >                "%s-config", name);
> > >       err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > -                       vp_config_changed, 0, vp_dev->msix_names[v],
> > > +                       vp_config_changed, IRQF_NO_AUTOEN,
> > > +                       vp_dev->msix_names[v],
> > >                         vp_dev);
> > >       if (err)
> > >               goto error;
> > > @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > >               snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > >                        "%s-virtqueues", name);
> > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > -                               vp_vring_interrupt, 0, vp_dev->msix_names[v],
> > > +                               vp_vring_interrupt, IRQF_NO_AUTOEN,
> > > +                               vp_dev->msix_names[v],
> > >                                 vp_dev);
> > >               if (err)
> > >                       goto error;
> > > @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> > >                        "%s-%s",
> > >                        dev_name(&vp_dev->vdev.dev), names[i]);
> > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > > -                               vring_interrupt, 0,
> > > +                               vring_interrupt, IRQF_NO_AUTOEN,
> > >                                 vp_dev->msix_names[msix_vec],
> > >                                 vqs[i]);
> > >               if (err)
> > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > index beec047a8f8d..a235ce9ff6a5 100644
> > > --- a/drivers/virtio/virtio_pci_common.h
> > > +++ b/drivers/virtio/virtio_pci_common.h
> > > @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> > >       return container_of(vdev, struct virtio_pci_device, vdev);
> > >  }
> > >
> > > -/* wait for pending irq handlers */
> > > -void vp_synchronize_vectors(struct virtio_device *vdev);
> > > +/* disable irq handlers */
> > > +void vp_disable_vectors(struct virtio_device *vdev);
> > > +/* enable irq handlers */
> > > +void vp_enable_vectors(struct virtio_device *vdev);
> > >  /* the notify function used when creating a virt queue */
> > >  bool vp_notify(struct virtqueue *vq);
> > >  /* the config->del_vqs() implementation */
> > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > index d62e9835aeec..bdf6bc667ab5 100644
> > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> > >       /* Flush out the status write, and flush in device writes,
> > >        * including MSi-X interrupts, if any. */
> > >       ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> > > -     /* Flush pending VQ/configuration callbacks. */
> > > -     vp_synchronize_vectors(vdev);
> > > +     /* Disable VQ/configuration callbacks. */
> > > +     vp_disable_vectors(vdev);
> > >  }
> > >
> > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> > >  }
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > +     .ready          = vp_enable_vectors,
> > >       .get            = vp_get,
> > >       .set            = vp_set,
> > >       .get_status     = vp_get_status,
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index 30654d3a0b41..acf0f6b6381d 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> > >        */
> > >       while (vp_modern_get_status(mdev))
> > >               msleep(1);
> > > -     /* Flush pending VQ/configuration callbacks. */
> > > -     vp_synchronize_vectors(vdev);
> > > +     /* Disable VQ/configuration callbacks. */
> > > +     vp_disable_vectors(vdev);
> > >  }
> > >
> > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> > >  }
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > +     .ready          = vp_enable_vectors,
> > >       .get            = NULL,
> > >       .set            = NULL,
> > >       .generation     = vp_generation,
> > > @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > >  };
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > +     .ready          = vp_enable_vectors,
> > >       .get            = vp_get,
> > >       .set            = vp_set,
> > >       .generation     = vp_generation,
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
