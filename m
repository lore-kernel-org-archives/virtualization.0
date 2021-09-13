Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442C0C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:33:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC4F60F9B
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 06:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAC4F60F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 91A384017A;
	Mon, 13 Sep 2021 06:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pw21MFzpqsDl; Mon, 13 Sep 2021 06:33:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D477B401EF;
	Mon, 13 Sep 2021 06:33:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F578C0011;
	Mon, 13 Sep 2021 06:33:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86927C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55D09401EF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7wvnJ0YC0Jp1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21B444017A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631514811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PhHmbd+vGEUJyrV5DLTBHy+hH4Q8g3MAN2ba0j9CKCQ=;
 b=MANHO9U4oiKwN99RdF8lY6ILjjTR+NtrlY3VwrCCkYRwlOFHCEviuVhv7cD4L5jkuqPB0J
 eLPgRSdk8SnoxZc7C97X/gjuCF6crkIzsX2n1CebrKUDbQn/ei5SlN8Tzh9cOsS6uufF8p
 zO7vB1/Pra9JLCdvoQUo2PKTnEY2Lro=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-XPf2RCcfOdKleb7yGlD8fA-1; Mon, 13 Sep 2021 02:33:30 -0400
X-MC-Unique: XPf2RCcfOdKleb7yGlD8fA-1
Received: by mail-ed1-f70.google.com with SMTP id
 g11-20020a056402090b00b003d114f9cb8aso1961752edz.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 23:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PhHmbd+vGEUJyrV5DLTBHy+hH4Q8g3MAN2ba0j9CKCQ=;
 b=Hm+IluEABNf/dFmjXHLEEK8HSHxDbSoQnpV/4+zzjGec2ijpOVoDHhqu8XfxkgJf07
 0RwNF2uDDlOMhFpXAUUHFjDPjnEJzGVOu/Q3BZWXX6EFEIGsvZdidA0ZDgklnLsGoJ49
 zc9WgXVFXZ0PTxdSwKD4QSbGqEzShr0KuekmrlE0ev91cMQ4i8vYedBZgY3AFkckmLQw
 2pddf/L8TfmPdegyltYPpBV7zRqP6nNA8oKoSjP1Br3asKKRX9N8OVk+xbU19wXCcNar
 Ab3UCLwa9PvU2wn5FXZMDbi0JAgEa12fzPOGGPUrFSktoDeqTMMvKD9N1GeUiagJCmT3
 0PvQ==
X-Gm-Message-State: AOAM530Jxzb7S0SlquUEkDAI5tYxGUHjt59m4wBeaseAme+sTq/SJKeU
 pV07sRU8RwU0336JEKQR6Bqi0GbHIHrgcXIdusV+zzWs2R5B7pOv5Zk8L5g4vnW2l9WrWfL/UOn
 UE35kEdoJLB/5+6SmCeS66aCf4cDsN9maIjI48w728A==
X-Received: by 2002:a17:906:919:: with SMTP id
 i25mr10772244ejd.171.1631514809691; 
 Sun, 12 Sep 2021 23:33:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIZT1R9ojuyk23OwxUJ6uHrkH/wVwqrhLF7z3AcQL8TGKDrdQpFBuRq64gNqFYnqY5oSsbIA==
X-Received: by 2002:a17:906:919:: with SMTP id
 i25mr10772233ejd.171.1631514809559; 
 Sun, 12 Sep 2021 23:33:29 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id o15sm2917942ejj.10.2021.09.12.23.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 23:33:28 -0700 (PDT)
Date: Mon, 13 Sep 2021 02:33:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <20210913022824-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210913055353.35219-8-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> This patch tries to make sure the virtio interrupt handler for INTX
> won't be called after a reset and before virtio_device_ready(). We
> can't use IRQF_NO_AUTOEN since we're using shared interrupt
> (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> intx_soft_enabled variable and toggle it during in
> vp_disable/enable_vectors(). The INTX interrupt handler will check
> intx_soft_enabled before processing the actual interrupt.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Not all that excited about all the memory barriers for something
that should be an extremely rare event (for most kernels -
literally once per boot). Can't we do better?

> ---
>  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
>  drivers/virtio/virtio_pci_common.h |  1 +
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 0b9523e6dd39..835197151dc1 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		vp_dev->intx_soft_enabled = false;
> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
> +		smp_wmb();
>  		synchronize_irq(vp_dev->pci_dev->irq);
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i;
>  
> -	if (vp_dev->intx_enabled)
> +	if (vp_dev->intx_enabled) {
> +		vp_dev->intx_soft_enabled = true;
> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
> +		smp_wmb();
>  		return;
> +	}
>  
>  	for (i = 0; i < vp_dev->msix_vectors; ++i)
>  		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  	struct virtio_pci_device *vp_dev = opaque;
>  	u8 isr;
>  
> +	if (!vp_dev->intx_soft_enabled)
> +		return IRQ_NONE;
> +
> +	/* read intx_soft_enabled before read others */
> +	smp_rmb();
> +
>  	/* reading the ISR has the effect of also clearing it so it's very
>  	 * important to save off the value. */
>  	isr = ioread8(vp_dev->isr);
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
