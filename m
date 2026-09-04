Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F013CF1F8
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506846; cv=none; b=Inqh8S4BlQ7O9Bar1Ecvrdq8YwJhTiAETSLt3d1KoxZwj5F5iq2umrrsdURV0HAH8ZAHsw0TWG+97DUMD+nW8r3uengDv8hwUmosgJ0LT16EGc8UbECgqw0bpIk5srwB8xa/v4rBEmLL1WbhZdpQ71E1N5APwXOSFmykZJ0OHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506846; c=relaxed/simple;
	bh=FImc8olB6iiEAcxJXpIl6Unr5BNGTio46vtQo4W9d2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rQvAOgLbArvYJjvqru6auU9ZU3zKuuYRBbibVJRR3VBMqUi/DRAjantSboyrM/ItK4Eo2+PVDQoKcZ3TP+yXL0N/1XXbYiHe5MHo1COBCaQduvzlu6J6sp4AE85a3EbuSJKKm9bMq+2ncuyAiQMzdqyHAMVXFfJk+b0tJKJDUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANzTIH7H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANzTIH7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788506842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yf2VdnkVnF0AFVaR0wUAe8ZFVdfSfYoCIbCkbT52zjg=;
	b=ANzTIH7HP1VFD2GD6elkaowOiurudhy+Kuum3UC4rnsjktLUu1rKXLQVJW8lpCvm/idc0Q
	dvYkr5+OMNPjAIA6RLt/LQ6LcwZNFXxZQh/id9z8AtKSvmgy2gBAt5xIGQ68flz+1Xsy9v
	X0d978Kb6rs5bORiwNEcD5ynqswTvq8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Q6BSRAv6NXuWwWR5t26a6g-1; Fri, 04 Sep 2026 03:27:19 -0400
X-MC-Unique: Q6BSRAv6NXuWwWR5t26a6g-1
X-Mimecast-MFC-AGG-ID: Q6BSRAv6NXuWwWR5t26a6g_1788506838
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4843dc86dddso555713f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 00:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788506838; x=1789111638;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yf2VdnkVnF0AFVaR0wUAe8ZFVdfSfYoCIbCkbT52zjg=;
        b=mUPuFY10XOv1rbakZlKWHxpG6XQGLFIOU5z5om+eZQ8togs7bkEjg6+1A1RcXR7o0i
         qhws8wsDj/ooJ1jb5haoMDoTL+fVfqpEglKQ0lF5/+z1jPKV1noEHHJ3PRxRyqihUfv3
         QpQ46z9UASFRVpQbeLc9HYMNIx4jmDQqBGwLC+Dmc1LZjeXNdr0CByXmxnh8Pj0QZobC
         +vcDh2uYENTbLT4e4hmiIkXt0hpVDH2KxkNKBy6zNwEalx+5UQTfQWNfeG8z+96Tyn+1
         aQK0l/aUQOBjuZ0h1BUzT300Jx1a9WsG3nowPUrD3AKws/sE19VNGl/3Z+kl/Xu1JPi7
         0ruQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3jMcX+maPswNo5XvqgIczPSKtqh7VEPuqwsOi5C/eTqy47stYngPIc3QHlFcFe15Ow9dIBNlc2OFLD7ZR2Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lQO+6y8+ZQPyZYdEXDiqYOZiK8kF+KvtBF7VVnmicu4Euzs73z
	MndWhiCWZRl+ALRpZNzhFm3EF7uGmPafFVcFyxPy6uhFqIxqB7uB9CMpBVOxeVL/QDW3XXUqPkS
	3m4gMGucUY+WTuE+IWcIjBTrR62wKIsd7RWIsvq2+uezbbA1O1f7byKMojpWb8jbSfvbl
X-Gm-Gg: AYBFou2FDQsQX4mei8CoKQsFyWaYbdgw8X2Yl62ySuRnHVjbr8enaYFgpsrNNKLoePq
	q6XqPDqFe+EQ1VuI9esjT6+ymhz3SESMiaMlhULXCgQLlWiftlZ8gCV/P1PydCf+S0E+ye7ZgAo
	SBBQD8VzQ+iCE+gemU9jXrQflNJqJtN5m8OZ85/yCTsoRwckDu/qMs1ZBuHwy3zWsu70gEzMCb6
	ENop5d1e0WMaEGjaCHOXYSrBPDtifmUtPYcPRFqgK4wUlJM5fr1vsEDi6pVi5TOwg+3wcfYb5En
	DqyFzAJU/0zEjfTLjiJT4t8n+mhKYa4UckM9qoLxLLNknyInh6oEoJca3fT/3dVIVjJ0bJA29wE
	cYZ/OrVoGnoiyNOGfn4U+VFQ=
X-Received: by 2002:a05:6000:2003:b0:485:8a46:7050 with SMTP id ffacd0b85a97d-4858a467187mr2324779f8f.34.1788506838213;
        Fri, 04 Sep 2026 00:27:18 -0700 (PDT)
X-Received: by 2002:a05:6000:2003:b0:485:8a46:7050 with SMTP id ffacd0b85a97d-4858a467187mr2324732f8f.34.1788506837610;
        Fri, 04 Sep 2026 00:27:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm3729295f8f.17.2026.09.04.00.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:27:17 -0700 (PDT)
Date: Fri, 4 Sep 2026 03:27:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 3/4] virtio-pci: return IRQ_HANDLED after non-zero ISR
Message-ID: <20260904032258-mutt-send-email-mst@kernel.org>
References: <20260903111342-mutt-send-email-mst@kernel.org>
 <20260903190731.13783-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260903190731.13783-1-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q2ipFycCt-2an6FEBPSHnhT_zFxBTIWjyoCn_YgZLGQ_1788506838
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2026 at 03:07:31PM -0400, Andrew Stellman wrote:
> vp_interrupt() reads the ISR before dispatching config-change and
> vring handling. Reading the ISR also clears it, so once the read
> returns non-zero the interrupt was from this device and has already
> been consumed.
> 
> Currently vp_interrupt() returns the result of vp_vring_interrupt().
> For a config-change interrupt with no vring work, that can return
> IRQ_NONE even though the ISR was non-zero and the interrupt was
> handled.
> 
> Call vp_vring_interrupt() for any queue work, but once the ISR is
> non-zero return IRQ_HANDLED.
> 
> Tested with QEMU virtio-blk-pci forced to INTx using vectors=0 and
> pci=nomsi. On an idle device, 200 config-change interrupts were
> generated using QMP block_resize.
> 
> Before this change, irq_handler_exit reported ret=unhandled and
> /proc/irq/11/spurious increased from 0 to 200 unhandled interrupts.
> After this change, irq_handler_exit reported ret=handled and the
> unhandled count remained at 0.
> 
> Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")

Where did you get this fixes tag?
It's been like this from the beginning:


+static irqreturn_t vp_interrupt(int irq, void *opaque)
+{
+       struct virtio_pci_device *vp_dev = opaque;
+       struct virtio_pci_vq_info *info;
+       irqreturn_t ret = IRQ_NONE;
+       u8 isr;
+
+       /* reading the ISR has the effect of also clearing it so it's very
+        * important to save off the value. */
+       isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
+
+       /* It's definitely not us if the ISR was not high */
+       if (!isr)
+               return IRQ_NONE;
+
+       /* Configuration change?  Tell driver if it wants to know. */
+       if (isr & VIRTIO_PCI_ISR_CONFIG) {
+               struct virtio_driver *drv;
+               drv = container_of(vp_dev->vdev.dev.driver,
+                                  struct virtio_driver, driver);
+
+               if (drv->config_changed)
+                       drv->config_changed(&vp_dev->vdev);
+       }
+
+       spin_lock(&vp_dev->lock);
+       list_for_each_entry(info, &vp_dev->virtqueues, node) {
+               if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
+                       ret = IRQ_HANDLED;
+       }
+       spin_unlock(&vp_dev->lock);
+
+       return ret;
+}


So really:

Fixes: 3343660d8c62 ("virtio: PCI device")




> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> ---
> Changes from v1:
> - Return IRQ_HANDLED for any non-zero ISR, as suggested by Michael.
> - Add Fixes and Suggested-by tags.
> - Test the change with virtio-blk forced to legacy INTx under QEMU.
> 
> Full red/green test logs and the exact tested patch:
> https://github.com/andrewstellman/quality-playbook/tree/11ba61d/evidence/virtio-pci-intx
> 
>  drivers/virtio/virtio_pci_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 10371ecbc054..b90c174450b2 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -120,7 +120,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  	if (isr & VIRTIO_PCI_ISR_CONFIG)
>  		vp_config_changed(irq, opaque);
>  
> -	return vp_vring_interrupt(irq, opaque);
> +	vp_vring_interrupt(irq, opaque);
> +
> +	return IRQ_HANDLED;
>  }
>  
>  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> -- 
> 2.43.0

