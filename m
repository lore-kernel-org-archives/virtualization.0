Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD97C433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 17:27:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2EE61151
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 17:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB2EE61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC8BA407FC;
	Fri, 15 Oct 2021 17:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0maIck7st0GY; Fri, 15 Oct 2021 17:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 135494050C;
	Fri, 15 Oct 2021 17:27:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4C43C0011;
	Fri, 15 Oct 2021 17:27:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09A3FC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 17:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E645E407FA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 17:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAiy2L6zo-38
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 17:27:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E25814050C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634318856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lgUgodXT3ew/1/poH4FFTkR+Gpon+z6sOsfUAcBcy7o=;
 b=IJhUfRvMXo/9urjyAVu8yxbydNpav9AKUMVsybwi/6jrv/w3OlVOMP5/H8DM431daMDfjT
 0Yy7tYsfPrInCpEOzDId/Gc6eC6WeAZP5vt6HITrCcwJv1Mse/NzIdfe//hBfLI6dWCTVb
 oqE3p44FMoceKcruuMYZgKi1VjSKeho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-3l1JlZtGPFiR2oafy-rMHw-1; Fri, 15 Oct 2021 13:27:32 -0400
X-MC-Unique: 3l1JlZtGPFiR2oafy-rMHw-1
Received: by mail-wr1-f71.google.com with SMTP id
 c2-20020adfa302000000b0015e4260febdso6132969wrb.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 10:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lgUgodXT3ew/1/poH4FFTkR+Gpon+z6sOsfUAcBcy7o=;
 b=pIrPutkTDHrXzFZBzsr0PuVOutvJCA4wOmjC16IzoLELD6a6fY4ux8VIUpyxRzMTSy
 zF6QfmB3D+ddZlGTGjdvODRu7mQRy4spB7aBym9tB6WjorN7OtvsEO56adPIzSvcsLLd
 bFzZak+3Yb7Y7VmkWga1ZbRYTidrDS3iMPO3+aJf4FnawX3ipR6k5UOEo75j5xFjPBQY
 wPpf9Tiflf/RyWEvXn5SGpAGRtHOpmONwGC0j7UdMBkyZvVdTpf6qkiku5LGcsQSwT11
 5GNYXovO59SgUxefu2L59MK02V+nY4LZFqCzPPX8oLy5Hc6LDbhDTG0sqUVfybHvZ8nI
 7hGg==
X-Gm-Message-State: AOAM531j+rI7ml5MKt9EpvyExdTnIGhC1J9U6khHJq9LXwXkcjHXautT
 Gk/aOz8Bj8SUcPfATiIXND6Zhx2hbD8gX2KrZsRWnB/c9uf1A0nybOuKSRmGf38TtKzCysqH6YR
 uL09JVkxvGg2vqpcnNWx/gAwvvvnSD88kzLjfv3lRkQ==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr15545193wrc.372.1634318851303; 
 Fri, 15 Oct 2021 10:27:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyniCpVVGwD3uQwJ+f6T7Gy66HM/GMv9wYj823SBDHQUwApD3oA7BmKODsodMZTORVH4fqonA==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr15545165wrc.372.1634318851038; 
 Fri, 15 Oct 2021 10:27:31 -0700 (PDT)
Received: from redhat.com ([2.55.147.75])
 by smtp.gmail.com with ESMTPSA id d9sm5430908wrm.96.2021.10.15.10.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Oct 2021 10:27:30 -0700 (PDT)
Date: Fri, 15 Oct 2021 13:27:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
Message-ID: <20211015132639-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
 <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E . McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Oct 15, 2021 at 05:09:38AM -0700, Dongli Zhang wrote:
> Hi Jason,
> 
> On 10/11/21 11:52 PM, Jason Wang wrote:
> > We used to synchronize pending MSI-X irq handlers via
> > synchronize_irq(), this may not work for the untrusted device which
> > may keep sending interrupts after reset which may lead unexpected
> > results. Similarly, we should not enable MSI-X interrupt until the
> 
> About "unexpected results", while you mentioned below in v1 ...
> 
> "My understanding is that e.g in the case of SEV/TDX we don't trust the
> hypervisor. So the hypervisor can keep sending interrupts even if the
> device is reset. The guest can only trust its own software interrupt
> management logic to avoid call virtio callback in this case."
> 
> .. and you also mentioned to avoid the panic (due to untrusted device) in as
> many scenarios as possible.
> 
> 
> Here is my understanding.
> 
> The reason we do not trust hypervisor is to protect (1) data/code privacy for
> most of times and sometimes (2) program execution integrity.
> 
> The bad thing is: the hypervisor is able to panic/destroy the VM in the worst case.
> 
> It is reasonable to re-configure/recover if we assume there is BUG at
> hypervisor/device side. That is, the hypervisor/device is buggy, but not malicious.
> 
> However, how about to just detect and report the hypervisor/device is malicious
> and shutdown/panic the VM immediately? If we have detected the malicious
> hypervisor, we should avoid running VMs on the malicious hypervisor further. At
> least how about to print error message to reminder users that the hypervisor is
> malicious?
> 
> 
> About "unexpected results", it should not be hang/panic. I suggest ...
> 
> Assuming SEV/TDX is involved, the hypervisor should never be able to derive the
> VM privacy (at least secure memory data) by providing malicious configuration,
> e.g., num_queues=0. If we detect hypervisor is malicious, the VM is
> panic/shutdown immediately. At least how about to print error message to
> reminder users.
> 
> 
> BTW, while I always do care about the loss of interrupt issue, the malicious
> device is able to hang a VM by dropping a single interrupt on purpose for
> virtio-scsi :)
> 
> 
> Thank you very much!


Can't say I understand what it's about. TDX does not protect against
hypervisor DoS attacks.

> Dongli Zhang
> 
> > device is ready. So this patch fixes those two issues by:
> > 
> > 1) switching to use disable_irq() to prevent the virtio interrupt
> >    handlers to be called after the device is reset.
> > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > 
> > This can make sure the virtio interrupt handler won't be called before
> > virtio_device_ready() and after reset.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> >  4 files changed, 32 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index b35bb2d57f62..0b9523e6dd39 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> >  		 "Force legacy mode for transitional virtio 1 devices");
> >  #endif
> >  
> > -/* wait for pending irq handlers */
> > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > +/* disable irq handlers */
> > +void vp_disable_vectors(struct virtio_device *vdev)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	int i;
> > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >  		synchronize_irq(vp_dev->pci_dev->irq);
> >  
> >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > +}
> > +
> > +/* enable irq handlers */
> > +void vp_enable_vectors(struct virtio_device *vdev)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	int i;
> > +
> > +	if (vp_dev->intx_enabled)
> > +		return;
> > +
> > +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >  }
> >  
> >  /* the notify function used when creating a virt queue */
> > @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> >  	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> >  		 "%s-config", name);
> >  	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > -			  vp_config_changed, 0, vp_dev->msix_names[v],
> > +			  vp_config_changed, IRQF_NO_AUTOEN,
> > +			  vp_dev->msix_names[v],
> >  			  vp_dev);
> >  	if (err)
> >  		goto error;
> > @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> >  		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> >  			 "%s-virtqueues", name);
> >  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> > -				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
> > +				  vp_vring_interrupt, IRQF_NO_AUTOEN,
> > +				  vp_dev->msix_names[v],
> >  				  vp_dev);
> >  		if (err)
> >  			goto error;
> > @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >  			 "%s-%s",
> >  			 dev_name(&vp_dev->vdev.dev), names[i]);
> >  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> > -				  vring_interrupt, 0,
> > +				  vring_interrupt, IRQF_NO_AUTOEN,
> >  				  vp_dev->msix_names[msix_vec],
> >  				  vqs[i]);
> >  		if (err)
> > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > index beec047a8f8d..a235ce9ff6a5 100644
> > --- a/drivers/virtio/virtio_pci_common.h
> > +++ b/drivers/virtio/virtio_pci_common.h
> > @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
> >  	return container_of(vdev, struct virtio_pci_device, vdev);
> >  }
> >  
> > -/* wait for pending irq handlers */
> > -void vp_synchronize_vectors(struct virtio_device *vdev);
> > +/* disable irq handlers */
> > +void vp_disable_vectors(struct virtio_device *vdev);
> > +/* enable irq handlers */
> > +void vp_enable_vectors(struct virtio_device *vdev);
> >  /* the notify function used when creating a virt queue */
> >  bool vp_notify(struct virtqueue *vq);
> >  /* the config->del_vqs() implementation */
> > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > index d62e9835aeec..bdf6bc667ab5 100644
> > --- a/drivers/virtio/virtio_pci_legacy.c
> > +++ b/drivers/virtio/virtio_pci_legacy.c
> > @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
> >  	/* Flush out the status write, and flush in device writes,
> >  	 * including MSi-X interrupts, if any. */
> >  	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> > -	/* Flush pending VQ/configuration callbacks. */
> > -	vp_synchronize_vectors(vdev);
> > +	/* Disable VQ/configuration callbacks. */
> > +	vp_disable_vectors(vdev);
> >  }
> >  
> >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
> >  }
> >  
> >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > +	.ready		= vp_enable_vectors,
> >  	.get		= vp_get,
> >  	.set		= vp_set,
> >  	.get_status	= vp_get_status,
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 30654d3a0b41..acf0f6b6381d 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
> >  	 */
> >  	while (vp_modern_get_status(mdev))
> >  		msleep(1);
> > -	/* Flush pending VQ/configuration callbacks. */
> > -	vp_synchronize_vectors(vdev);
> > +	/* Disable VQ/configuration callbacks. */
> > +	vp_disable_vectors(vdev);
> >  }
> >  
> >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> >  }
> >  
> >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > +	.ready		= vp_enable_vectors,
> >  	.get		= NULL,
> >  	.set		= NULL,
> >  	.generation	= vp_generation,
> > @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> >  };
> >  
> >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > +	.ready		= vp_enable_vectors,
> >  	.get		= vp_get,
> >  	.set		= vp_set,
> >  	.generation	= vp_generation,
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
