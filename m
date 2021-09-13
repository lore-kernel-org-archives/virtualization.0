Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01431C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:43:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BD160F92
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88BD160F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F63B8186B;
	Mon, 13 Sep 2021 06:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZWVl6Ec399f; Mon, 13 Sep 2021 06:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BA7681770;
	Mon, 13 Sep 2021 06:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D402C0011;
	Mon, 13 Sep 2021 06:43:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03D23C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2FA36084D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9rgBYzwGSvew
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:43:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE9FA607A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631515404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m4qBs0whHMZrBcYpNXJ0L3/i355q3tD50cJmfAl7u7Q=;
 b=PtP8p1VCdB6ZC1OzxvJSzwlECcxnZqS7qoJIEyoVNPcEWBL6+BFRSpM7V8rUIsapWNivj8
 R+JTij4EsFeiVUEEHLNiFmPH5C0I4tPz8d/PkDX8WZJVn+/2JEAiLrAghOLEzAJdUjDq+g
 eKSPvwsgUAeV1hhNFzFus1Fyc9KBEqI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-VzR0VtH8ORuAk07-9zWUlw-1; Mon, 13 Sep 2021 02:43:21 -0400
X-MC-Unique: VzR0VtH8ORuAk07-9zWUlw-1
Received: by mail-lj1-f197.google.com with SMTP id
 m10-20020a2e97ca000000b001bb5da17f7dso3700160ljj.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m4qBs0whHMZrBcYpNXJ0L3/i355q3tD50cJmfAl7u7Q=;
 b=Ez7vXyYUSpf/yKP/sYkGwvXUQlovjePJNEkzb2WPVe0qYjSNEOosEj6yCRdfw5ZViA
 4I3VYjVPoS83oRVt65U5z9O2+LSbVNrMMNOY+4ZKgzRjLIs8ZQHeBMc/ds1kF3Giw9fJ
 TZKYpmG6k/T3m7Hyv8A/Owy441Tjvr9fohuKahiHzpwjs3iUTy/seLWQaSn1+Q+bZEqc
 hOFZxFYZ8vf0OCw56AYGikIJ0R2RCmVpBk+8tbtbUJ03GvADrjUMksYD3XS51PqKKVDm
 /zi/8TSf0aUg07kfTk1ayJV2+tFRb/nWCqSD6NvS+MSakLMcZtJM4cqdEnvgEoH3ADsr
 0/Cw==
X-Gm-Message-State: AOAM5307S7XpAIkt5GEN/lEgyzcXyj9qXFrZnHWquhYStqLU/cUF857a
 uNtJlO4uu1WsAwfTLJ/gHdz3cHd/fOkP5Ga3iS9gt3OHKRf+uvEjm9kCSU2WJkkr4gzvVQGkr6f
 65YiWCmKJdsbqhmk7CkltJuuBtYGjV2OZIt7ugQrdS+Dpbk8SwYUin5LOPA==
X-Received: by 2002:a05:6512:3d0a:: with SMTP id
 d10mr2850402lfv.481.1631515399821; 
 Sun, 12 Sep 2021 23:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeAUYJgEwSVUQxPNeI0wgFwmkEzrkWmiyB47WJ0N+nawH3a9DWReKRzfau5nP7vPsMYtzYX9tHr/kvUW4GFHI=
X-Received: by 2002:a05:6512:3d0a:: with SMTP id
 d10mr2850362lfv.481.1631515399552; 
 Sun, 12 Sep 2021 23:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210913023626-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Sep 2021 14:43:08 +0800
Message-ID: <CACGkMEuP=uHXrpeUa4Fku3ZoHm12y2R4_htA=_0nr-0HYBiB0A@mail.gmail.com>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Mon, Sep 13, 2021 at 2:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 02:34:01PM +0800, Jason Wang wrote:
> > On Mon, Sep 13, 2021 at 2:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 02:08:02PM +0800, Jason Wang wrote:
> > > > On Mon, Sep 13, 2021 at 2:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Sep 13, 2021 at 01:53:50PM +0800, Jason Wang wrote:
> > > > > > We used to synchronize pending MSI-X irq handlers via
> > > > > > synchronize_irq(), this may not work for the untrusted device which
> > > > > > may keep sending interrupts after reset which may lead unexpected
> > > > > > results. Similarly, we should not enable MSI-X interrupt until the
> > > > > > device is ready. So this patch fixes those two issues by:
> > > > > >
> > > > > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > > > > >    handlers to be called after the device is reset.
> > > > > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > > > > >
> > > > > > This can make sure the virtio interrupt handler won't be called before
> > > > > > virtio_device_ready() and after reset.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > I don't get the threat model here. Isn't disabling irqs done by the
> > > > > hypervisor anyway? Is there a reason to trust disable_irq but not
> > > > > device reset?
> > > >
> > > > My understanding is that e.g in the case of SEV/TDX we don't trust the
> > > > hypervisor. So the hypervisor can keep sending interrupts even if the
> > > > device is reset. The guest can only trust its own software interrupt
> > > > management logic to avoid call virtio callback in this case.
> > > >
> > > > Thanks
> > >
> > > Hmm but I don't see how do these patches do this.
> > > They call disable_irq but can't the hypervisor keep
> > > sending interrupts after disable_irq, too?
> >
> > Yes, but since the irq is disabled, the vring or config callback won't
> > be called in this case.
> >
> > Thanks
>
> But doen't "irq is disabled" basically mean "we told the hypervisor
> to disable the irq"?  What extractly prevents hypervisor from
> sending the irq even if guest thinks it disabled it?

It can't prevent the hypersior from sending irq. But it can make sure
the irq descriptor is disabled (e.g IRQD_IRQ_DISABLED). Is this
sufficient?

Thanks

>
> > >
> > >
> > >
> > > > >
> > > > > Cc a bunch more people ...
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > > > > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > > > > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > index b35bb2d57f62..0b9523e6dd39 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > > > > >                "Force legacy mode for transitional virtio 1 devices");
> > > > > >  #endif
> > > > > >
> > > > > > -/* wait for pending irq handlers */
> > > > > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > > +/* disable irq handlers */
> > > > > > +void vp_disable_vectors(struct virtio_device *vdev)
> > > > > >  {
> > > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >       int i;
> > > > > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > >
> > > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > -             synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > +             disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > > +}
> > > > > > +
> > > > > > +/* enable irq handlers */
> > > > > > +void vp_enable_vectors(struct virtio_device *vdev)
> > > > > > +{
> > > > > > +     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > +     int i;
> > > > > > +
> > > > > > +     if (vp_dev->intx_enabled)
> > > > > > +             return;
> > > > > > +
> > > > > > +     for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > > +             enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > >  }
> > > > > >
> > > > > >  /* the notify function used when creating a virt queue */
> > > > > > @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > > > > >       snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > > > > >                "%s-config", name);
> > > > > >       err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > > > > -                       vp_config_changed, 0, vp_dev->msix_names[v],
> > > > > > +                       vp_config_changed, IRQF_NO_AUTOEN,
> > > > > > +                       vp_dev->msix_names[v],
> > > > > >                         vp_dev);
> > > > > >       if (err)
> > > > > >               goto error;
> > > > > > @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > > > > >               snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > > > > >                        "%s-virtqueues", name);
> > > > > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > > > > > -                               vp_vring_interrupt, 0, vp_dev->msix_names[v],
> > > > > > +                               vp_vring_interrupt, IRQF_NO_AUTOEN,
> > > > > > +                               vp_dev->msix_names[v],
> > > > > >                                 vp_dev);
> > > > > >               if (err)
> > > > > >                       goto error;
> > > > > > @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> > > > > >                        "%s-%s",
> > > > > >                        dev_name(&vp_dev->vdev.dev), names[i]);
> > > > > >               err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > > > > > -                               vring_interrupt, 0,
> > > > > > +                               vring_interrupt, IRQF_NO_AUTOEN,
> > > > > >                                 vp_dev->msix_names[msix_vec],
> > > > > >                                 vqs[i]);
> > > > > >               if (err)
> > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > index beec047a8f8d..a235ce9ff6a5 100644
> > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> > > > > >       return container_of(vdev, struct virtio_pci_device, vdev);
> > > > > >  }
> > > > > >
> > > > > > -/* wait for pending irq handlers */
> > > > > > -void vp_synchronize_vectors(struct virtio_device *vdev);
> > > > > > +/* disable irq handlers */
> > > > > > +void vp_disable_vectors(struct virtio_device *vdev);
> > > > > > +/* enable irq handlers */
> > > > > > +void vp_enable_vectors(struct virtio_device *vdev);
> > > > > >  /* the notify function used when creating a virt queue */
> > > > > >  bool vp_notify(struct virtqueue *vq);
> > > > > >  /* the config->del_vqs() implementation */
> > > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > > > > index d62e9835aeec..bdf6bc667ab5 100644
> > > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > > @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > >       /* Flush out the status write, and flush in device writes,
> > > > > >        * including MSi-X interrupts, if any. */
> > > > > >       ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> > > > > > -     /* Flush pending VQ/configuration callbacks. */
> > > > > > -     vp_synchronize_vectors(vdev);
> > > > > > +     /* Disable VQ/configuration callbacks. */
> > > > > > +     vp_disable_vectors(vdev);
> > > > > >  }
> > > > > >
> > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> > > > > >  }
> > > > > >
> > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > +     .ready          = vp_enable_vectors,
> > > > > >       .get            = vp_get,
> > > > > >       .set            = vp_set,
> > > > > >       .get_status     = vp_get_status,
> > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > > index 30654d3a0b41..acf0f6b6381d 100644
> > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > >        */
> > > > > >       while (vp_modern_get_status(mdev))
> > > > > >               msleep(1);
> > > > > > -     /* Flush pending VQ/configuration callbacks. */
> > > > > > -     vp_synchronize_vectors(vdev);
> > > > > > +     /* Disable VQ/configuration callbacks. */
> > > > > > +     vp_disable_vectors(vdev);
> > > > > >  }
> > > > > >
> > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> > > > > >  }
> > > > > >
> > > > > >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > > +     .ready          = vp_enable_vectors,
> > > > > >       .get            = NULL,
> > > > > >       .set            = NULL,
> > > > > >       .generation     = vp_generation,
> > > > > > @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > >  };
> > > > > >
> > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > +     .ready          = vp_enable_vectors,
> > > > > >       .get            = vp_get,
> > > > > >       .set            = vp_set,
> > > > > >       .generation     = vp_generation,
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
