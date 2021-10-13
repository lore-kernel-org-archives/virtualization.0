Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6050DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 09:42:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D658D60ED4
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 09:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D658D60ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88288402B9;
	Wed, 13 Oct 2021 09:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pq8k8BBkWLJO; Wed, 13 Oct 2021 09:42:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3C104047C;
	Wed, 13 Oct 2021 09:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7562FC0011;
	Wed, 13 Oct 2021 09:42:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E9D1C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53DA460817
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJEywmcImQcL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:42:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F2FE6076A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634118128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U68OI4OeCzb+i7/ugVEhD/bkOqefRrn7yZ62rOLQMr0=;
 b=Sp8eo/iqGbg/r0btsoRnelbObI6MwLYFAKqUU6nY0b0ta46oeu/qhfXVZHgw2pA0UpvbTm
 L8IPUWketd+kvUxwzhkcyrOqDQGMNHxFsovm/lzA4DAE+NDBCSQsWKzZDfwkg3jGiNzU/a
 Wz+V9ipU9tEyAZXEnmjJJBzau07zTyU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-uPZo84yfM16k1BnaYuMGqA-1; Wed, 13 Oct 2021 05:42:07 -0400
X-MC-Unique: uPZo84yfM16k1BnaYuMGqA-1
Received: by mail-wr1-f72.google.com with SMTP id
 d13-20020adf9b8d000000b00160a94c235aso1537420wrc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 02:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U68OI4OeCzb+i7/ugVEhD/bkOqefRrn7yZ62rOLQMr0=;
 b=ZMCLAvu+Nz1O7A8qTypUQJQ+DVQ/urza1zosZk69/YOTQlq3ghBmO2C9nDKCW5Boig
 5/zZfVBCvgiSGdCFKTlRh2djJSr6U/pRN8mLP0tHVJ+qg8I0AC87X/0qBfzH3RnGHoBC
 j9ZK4CqIjz1+Zh9Aqwgr3awP4o/aEHh99Ra4S1HyYwoEkQh3kuwJREdyfXwOhVOsddd5
 vE23JfJx9zGiMQW53RgQ53QZV75Gmp4wE3sOBLnqTlDXyIbcPa2oAvtJBKt9hBbgJ9I2
 NFlUstFOkRSVDZyQCvFDIH1pVOn/L1dy3L3vJNwekm2cNYh0CUipHcAh7yVbw6rSyLQb
 /5hg==
X-Gm-Message-State: AOAM530paxaROb02zdBZ+LtIaFywnmFat7yutAAhZoOB0wdVPenJnyI+
 C2gTP3MEDMfJKXrgK88DfMGEkXZEQBhcxzinKYc+fhTZwfav7cMMx+x82FRHIsR7m9Ln/eQjCAK
 ILlFlUD7w9GI2dlP0gctmun//Y2EK7DwHwPly/aWfcQ==
X-Received: by 2002:a05:600c:154f:: with SMTP id
 f15mr11963046wmg.195.1634118125871; 
 Wed, 13 Oct 2021 02:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn/WvcYSD7wMef0lNnYuPUlX4EALP+Md0v/JLHsPep5rirJoC9RpK1Qa6aqmeDkrkWjH1gbw==
X-Received: by 2002:a05:600c:154f:: with SMTP id
 f15mr11963020wmg.195.1634118125653; 
 Wed, 13 Oct 2021 02:42:05 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id u2sm12504081wrr.35.2021.10.13.02.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 02:42:05 -0700 (PDT)
Date: Wed, 13 Oct 2021 05:42:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 07/12] virtio-pci: harden INTX interrupts
Message-ID: <20211013053627-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-8-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211012065227.9953-8-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E . McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

On Tue, Oct 12, 2021 at 02:52:22PM +0800, Jason Wang wrote:
> This patch tries to make sure the virtio interrupt handler for INTX
> won't be called after a reset and before virtio_device_ready(). We
> can't use IRQF_NO_AUTOEN since we're using shared interrupt
> (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> intx_soft_enabled variable and toggle it during in
> vp_disable/enable_vectors(). The INTX interrupt handler will check
> intx_soft_enabled before processing the actual interrupt.
> 
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++++++--
>  drivers/virtio/virtio_pci_common.h |  1 +
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 0b9523e6dd39..5ae6a2a4eb77 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -30,8 +30,16 @@ void vp_disable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		/*
> +		 * The below synchronize() guarantees that any
> +		 * interrupt for this line arriving after
> +		 * synchronize_irq() has completed is guaranteed to see
> +		 * intx_soft_enabled == false.
> +		 */
> +		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
>  		synchronize_irq(vp_dev->pci_dev->irq);
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -43,8 +51,16 @@ void vp_enable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		disable_irq(vp_dev->pci_dev->irq);
> +		/*
> +		 * The above disable_irq() provides TSO ordering and
> +		 * as such promotes the below store to store-release.
> +		 */
> +		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> +		enable_irq(vp_dev->pci_dev->irq);
>  		return;
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -97,6 +113,10 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  	struct virtio_pci_device *vp_dev = opaque;
>  	u8 isr;
>  
> +	/* read intx_soft_enabled before read others */
> +	if (!smp_load_acquire(&vp_dev->intx_soft_enabled))
> +		return IRQ_NONE;
> +
>  	/* reading the ISR has the effect of also clearing it so it's very
>  	 * important to save off the value. */
>  	isr = ioread8(vp_dev->isr);

I don't see why we need this ordering guarantee here.

synchronize_irq above makes sure no interrupt handler
is in progress. the handler itself thus does not need
any specific order, it is ok if intx_soft_enabled is read
after, not before the rest of it.

Just READ_ONCE should be enough, and we can drop the comment.


> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index a235ce9ff6a5..3c06e0f92ee4 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -64,6 +64,7 @@ struct virtio_pci_device {
>  	/* MSI-X support */
>  	int msix_enabled;
>  	int intx_enabled;
> +	bool intx_soft_enabled;
>  	cpumask_var_t *msix_affinity_masks;
>  	/* Name strings for interrupts. This size should be enough,
>  	 * and I'm too lazy to allocate each name separately. */
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
