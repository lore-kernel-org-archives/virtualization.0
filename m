Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D56C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:04:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B01E60FC0
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B01E60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D61C76137F;
	Mon, 13 Sep 2021 06:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aqlI39CCzrIM; Mon, 13 Sep 2021 06:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFB9560BA0;
	Mon, 13 Sep 2021 06:04:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C76F9C000F;
	Mon, 13 Sep 2021 06:04:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93E1AC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BB9D607AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5N7MiSctMFx8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A04F6605D8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631513045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsctpVGQyV6/v25aTDpvQ7QvrlAiAoDMHUqgBQtcFic=;
 b=URoJmHCXDZXpaKtG9NArGQZzdUffswsXxtoFIppXFHmVCtOQ531j6BU6RkJz/4tGTXghl4
 foikBqAlcOCEopHyNZOvpyhhhPn2vKjKB9LhxzYwtn4f2TeeD2bw+o7fy+CGlR7iYgRbsK
 IImQ5E0XnUma0IXB6CuMFfntg6FSkZ0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-YgBbHxxDPcaZ0vWHK9O0wA-1; Mon, 13 Sep 2021 02:04:02 -0400
X-MC-Unique: YgBbHxxDPcaZ0vWHK9O0wA-1
Received: by mail-ej1-f71.google.com with SMTP id
 v12-20020a170906858c00b005f03d2ccaf5so792064ejx.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MsctpVGQyV6/v25aTDpvQ7QvrlAiAoDMHUqgBQtcFic=;
 b=En2nrkPvItfahPAf8hjzFQ81AQqiYDVTAu/7iRLbCDQlUib0m+YZeizLRQG8GRKzkc
 YTDHPUfT8X/qVyhLA4lVbrVCIOpp1D9rLC8/iBD64mFvNtJkjEjt4JUAHi965LdDyOeO
 778/fNZlQxgUZggJN8GauVa8NRhQHk3I8wB01cIWUJMjUZp3NJ/9vt5/AcDrvsXEVOX8
 e6O4nM1jvtsPJrjuvH2GI93UqCxFjQg/JB9GaJ/yJaxGFQrcpVRxv48dZU1ahprC59kJ
 QjJ5rqQ7PUgyxXEk1eaGD3QYtJEt62LSq7PC75k5y2ajmYdtxVd32Rz2seiaQdegLmu/
 iQqQ==
X-Gm-Message-State: AOAM530qTawT7/PKGWh4j6BcKyGVecSQ3xxkaQejul9W6wTvYDq4ztEq
 tdAw/UBNyHvxVGmi7DSMvAlluHVOJRRh+BL8Wz3yXTU5IokBoF4piq1EZPVdIYvfTXlIHljY3g8
 1H8osCQ0iXUUQgckF1RUN/D0aEgPRTWiUTPhr7qbQDA==
X-Received: by 2002:a17:906:5d6:: with SMTP id
 t22mr10909808ejt.98.1631513040931; 
 Sun, 12 Sep 2021 23:04:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm1Vcn6NiQyB4mKJJv2BPvNXfCEw4nbTwxBVWrIIE5IykDgNkBqc1gcdkp/JIonsUfnn89vg==
X-Received: by 2002:a17:906:5d6:: with SMTP id
 t22mr10909795ejt.98.1631513040747; 
 Sun, 12 Sep 2021 23:04:00 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id t16sm2881663ejj.54.2021.09.12.23.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 23:03:59 -0700 (PDT)
Date: Mon, 13 Sep 2021 02:03:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
Message-ID: <20210913015711-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210913055353.35219-7-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, david.kaplan@amd.com,
 Peter Zijlstra <peterz@infradead.org>,
 virtualization@lists.linux-foundation.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 pbonzini@redhat.com, "David S . Miller" <davem@davemloft.net>,
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

On Mon, Sep 13, 2021 at 01:53:50PM +0800, Jason Wang wrote:
> We used to synchronize pending MSI-X irq handlers via
> synchronize_irq(), this may not work for the untrusted device which
> may keep sending interrupts after reset which may lead unexpected
> results. Similarly, we should not enable MSI-X interrupt until the
> device is ready. So this patch fixes those two issues by:
> 
> 1) switching to use disable_irq() to prevent the virtio interrupt
>    handlers to be called after the device is reset.
> 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> 
> This can make sure the virtio interrupt handler won't be called before
> virtio_device_ready() and after reset.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I don't get the threat model here. Isn't disabling irqs done by the 
hypervisor anyway? Is there a reason to trust disable_irq but not
device reset?

Cc a bunch more people ...


> ---
>  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
>  drivers/virtio/virtio_pci_common.h |  6 ++++--
>  drivers/virtio/virtio_pci_legacy.c |  5 +++--
>  drivers/virtio/virtio_pci_modern.c |  6 ++++--
>  4 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index b35bb2d57f62..0b9523e6dd39 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
>  		 "Force legacy mode for transitional virtio 1 devices");
>  #endif
>  
> -/* wait for pending irq handlers */
> -void vp_synchronize_vectors(struct virtio_device *vdev)
> +/* disable irq handlers */
> +void vp_disable_vectors(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
> @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>  		synchronize_irq(vp_dev->pci_dev->irq);
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +}
> +
> +/* enable irq handlers */
> +void vp_enable_vectors(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	int i;
> +
> +	if (vp_dev->intx_enabled)
> +		return;
> +
> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>  }
>  
>  /* the notify function used when creating a virt queue */
> @@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>  		 "%s-config", name);
>  	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> -			  vp_config_changed, 0, vp_dev->msix_names[v],
> +			  vp_config_changed, IRQF_NO_AUTOEN,
> +			  vp_dev->msix_names[v],
>  			  vp_dev);
>  	if (err)
>  		goto error;
> @@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
>  			 "%s-virtqueues", name);
>  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
> -				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
> +				  vp_vring_interrupt, IRQF_NO_AUTOEN,
> +				  vp_dev->msix_names[v],
>  				  vp_dev);
>  		if (err)
>  			goto error;
> @@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>  			 "%s-%s",
>  			 dev_name(&vp_dev->vdev.dev), names[i]);
>  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> -				  vring_interrupt, 0,
> +				  vring_interrupt, IRQF_NO_AUTOEN,
>  				  vp_dev->msix_names[msix_vec],
>  				  vqs[i]);
>  		if (err)
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index beec047a8f8d..a235ce9ff6a5 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
>  	return container_of(vdev, struct virtio_pci_device, vdev);
>  }
>  
> -/* wait for pending irq handlers */
> -void vp_synchronize_vectors(struct virtio_device *vdev);
> +/* disable irq handlers */
> +void vp_disable_vectors(struct virtio_device *vdev);
> +/* enable irq handlers */
> +void vp_enable_vectors(struct virtio_device *vdev);
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq);
>  /* the config->del_vqs() implementation */
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d62e9835aeec..bdf6bc667ab5 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
> +	/* Disable VQ/configuration callbacks. */
> +	vp_disable_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> @@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  }
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= vp_get,
>  	.set		= vp_set,
>  	.get_status	= vp_get_status,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 30654d3a0b41..acf0f6b6381d 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
>  	 */
>  	while (vp_modern_get_status(mdev))
>  		msleep(1);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
> +	/* Disable VQ/configuration callbacks. */
> +	vp_disable_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> @@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  }
>  
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= NULL,
>  	.set		= NULL,
>  	.generation	= vp_generation,
> @@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> +	.ready		= vp_enable_vectors,
>  	.get		= vp_get,
>  	.set		= vp_set,
>  	.generation	= vp_generation,
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
