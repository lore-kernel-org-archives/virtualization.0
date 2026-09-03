Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018434CA29D
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448499; cv=none; b=MxyPp3cydxxxvqfnyJljcC08TmJgkuoEoPLSoU1gPrcG3lhD1kOvwqSpgmRr4AysoECp8j/Pxaey6ludBFj7nXMyCBZPF2t8FbFtL/raEvacQKACMVwV5zhoRVlMnfdxND9krXxRv8n6wnFpFNWJNs1++iHyECm7dqbgkkDsl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448499; c=relaxed/simple;
	bh=uo3WLZyoZDxrpRlviYeHcUcxieiomugsyPOWE5vlvvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=anzA/upRhiJom+42ovSDpVFcF+0hTEXKy+5LO+xm2YYeSHwAdv535YX3Pt/tFibnNPxgKx3lA4R64Sp9PJI46Oi+fU812VPsLzjUC/Lm3mosRHr2sLmZ6U8Arx5ZN42JTa5fkNdTYgbPfhzHfQCXvxKZmyEOsc+AxBp3GOgcNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFuPnVW/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFuPnVW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788448496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=de+PY6dNG6KtU1zsfD22kVwaSYth3rO7t0LRHsbtIxU=;
	b=HFuPnVW/Pnj+fDMgnaOcBYwZL398mrLT9PxRzWqWBFwnRa+YYs1vbzCCU/HhgdPulf36hX
	j5X6/eZRCkbr4/3686oO1bdVW+YZLuWb3kpxkpVszHqar6tZavQWYV9HavV+aK7RyU+efA
	2eJ5yOJNCa7sZO1Xdb3pjM8R6Px/U24=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-ddDvF5L6PJes1Cx5eoMHVA-1; Thu, 03 Sep 2026 11:14:55 -0400
X-MC-Unique: ddDvF5L6PJes1Cx5eoMHVA-1
X-Mimecast-MFC-AGG-ID: ddDvF5L6PJes1Cx5eoMHVA_1788448494
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482f763db88so1488984f8f.2
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 08:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448494; x=1789053294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=de+PY6dNG6KtU1zsfD22kVwaSYth3rO7t0LRHsbtIxU=;
        b=btkAWUcCNJnN8nHiFbL4AFxjU5F19GIL9INMVVgZ0bGEMuMFoLCpbm8+dP4Lxaz8Qi
         bGSaW1N3UE3aOA2/8UOGDMQixfV8ZcrHzh27khiLhM0Doy4z/ewAYI1EkfZ2Fg6HvRwT
         MjGEr1cU+I2yoEo7RJHGzso2dUMlKXPxK34bJixgRx6qOjmN0hKJlPk+O12VV7xI29+c
         Dq8FmNoRWEzkHmDG0BHBr5wtt8/XMvZJjSwMszUCPrnzk2r19QWE2zj318n9fNRQAMst
         Xbdbn0w8JGo0wB8rW3G2m8b6m+ScGkh1TKmPNgHjsuMPNs+1v4TY4MGlrL5SOCZKbqi9
         Lngw==
X-Forwarded-Encrypted: i=1; AKwUvBx5Nwup6Yl65EeAPlG47QTgB9fUrEPdaPxybdaRIirtmkrKd77I2JuRMnBXO+NPN/Max/9OQcWiCLgjGbI+Eg==@lists.linux.dev
X-Gm-Message-State: AFuF++lzIB1aaBM547Oo1FD01qNSDlxKrU+oa+9wNnrmcZCVH3t1CnSg
	b4vln1mTZtGr4+O03QUJeVG1V6RVeneO/+RwSDZtzmoVoort/R5XY2mL2xhG7VF31g4xrBvY3K8
	h8OdSkuapFFA3JfLoRMgMrq0zLa+eH19HdYhtTdnvuyJwiAgTe1Yc8nkhJviztbIjhc1R
X-Gm-Gg: AYBFou1qPG63Qrmm19sXwPLZegMRZLZUHCb1vV0RdVLgdF0nf0CK9xVIAkQm6OUBSyE
	bKUZjkMWyjYJR7ytW+pX5Oz0KkKJzRX95lqiP1xbwhsKsXmB4ucd2/sxMJwcrOIKyg+GNBpKHG9
	2zVYpnx60/YLmk6Tm7B+S/Pbh1xfIj4XC4rXCHyFMdu4WphFyLfVwsuqNUSymitTCp5ZdugJw3o
	73buCI0bLVK5B3RoOjzbAmJTZKRiEdNYq3JciGhfSKGSc6ebsUf/KNgVThH+WrD8JZ0DYh8t49f
	K/McVudvzFMHTrYSsIghpuJo5pYywEKb0m4rs946WXBovZ8UUacGFMnFO6LG0QWk+PH9O1Lxmo3
	K2VWiczyggFgo6s4+9MtTI/4=
X-Received: by 2002:a05:6000:2dc8:b0:482:f270:65c5 with SMTP id ffacd0b85a97d-48488f07d61mr22594742f8f.9.1788448494059;
        Thu, 03 Sep 2026 08:14:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc8:b0:482:f270:65c5 with SMTP id ffacd0b85a97d-48488f07d61mr22594574f8f.9.1788448493419;
        Thu, 03 Sep 2026 08:14:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeae34sm15529433f8f.32.2026.09.03.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:14:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:14:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 3/4] virtio-pci: return IRQ_HANDLED for config-change
 interrupts
Message-ID: <20260903111342-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-4-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407123904.6390-4-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hXmJLytBGxveciZueB2JZ-YDN8Af6jC5vDnOTQ7klgE_1788448494
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 07, 2026 at 08:39:03AM -0400, Andrew Stellman wrote:
> vp_interrupt() unconditionally returns the result of
> vp_vring_interrupt(). When a config-change interrupt fires but no vring
> activity is pending, vp_vring_interrupt() returns IRQ_NONE — even
> though the interrupt was legitimately handled by vp_config_changed().
> Over time this causes the IRQ subsystem to flag the line as spurious.
> 
> Track the return value explicitly: set ret to IRQ_HANDLED when the
> config-change bit is set, OR it with the vring result, and return the
> combined value.
> 
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 0b9d66b..1d1ab02 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -106,6 +106,7 @@ static irqreturn_t vp_vring_interrupt(int irq, void *opaque)
>  static irqreturn_t vp_interrupt(int irq, void *opaque)
>  {
>  	struct virtio_pci_device *vp_dev = opaque;
> +	irqreturn_t ret = IRQ_NONE;
>  	u8 isr;
>  
>  	/* reading the ISR has the effect of also clearing it so it's very
> @@ -117,10 +118,15 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  		return IRQ_NONE;
>  
>  	/* Configuration change?  Tell driver if it wants to know. */
> -	if (isr & VIRTIO_PCI_ISR_CONFIG)
> +	if (isr & VIRTIO_PCI_ISR_CONFIG) {
>  		vp_config_changed(irq, opaque);
> +		ret = IRQ_HANDLED;
> +	}
>  
> -	return vp_vring_interrupt(irq, opaque);
> +	if (vp_vring_interrupt(irq, opaque) == IRQ_HANDLED)
> +		ret = IRQ_HANDLED;
> +
> +	return ret;
>  }



So I think as long as we are looking at isr, let's look
at isr exclusively?

we cleared it so ... all well?

return IRQ_HANDLED and be done with it?

>  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> -- 
> 2.34.1

