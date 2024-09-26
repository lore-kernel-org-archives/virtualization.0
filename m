Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBA18D642
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333222; cv=none; b=XbXvRQIeRyEHbevYMQABexZnmUaa/+AOiqFz+kKT3J4ztZVeF+dDthIQCbDht7ufkG9KsO4onk8d85GN0vT5IWEramCozaUT+loxHsYe7wiHrUmEBEa2mSzJSQInmjwL0n9lIHjAt4wJnlJlfRpXPFuuvvFVjPU5JgGqDMajUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333222; c=relaxed/simple;
	bh=W9Q9qF/i9Qv1+MP6E3R9THJb3D4Ym4jOcIVoMFxev6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uCXCnUuu+2DoQiLWkZmUUtriaEUgRzf+p0fK+H+oCx5Z19Emr2U6AD7ufuR1V5g+gdxE70/Vxq2VhAFeyo4L+aB9YFYanc1mM5BeGlJbcVP2WqMEG/4YUE4pEY4sHxGsKbQniLWv5N6lYvfnZYEeKVnxhHXAT1Y5MS4yZ7sbteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8frFlJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8frFlJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727333220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7ph+jmjLlXI5r1/pUA2XEeC1lLjfRKxVSeZXnUielM=;
	b=D8frFlJKSyLYpEBz2qlLwjv2muLSEGBRZEIhmFiucvuVTivL+fR+hfF6l0hJSQdtC6Y+Kn
	3kQAbWBrChauY79j1jn/bL1l++e/A88B0FkuB1+gY39x2eE86Y7MNZTl2d0M45NxfPRxne
	xNkAFhDyX2XiZmLHLlac8Ii4RYnV6bY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-1mvHz5H0NumtkzpPTHpl1A-1; Thu, 26 Sep 2024 02:46:58 -0400
X-MC-Unique: 1mvHz5H0NumtkzpPTHpl1A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42f310f0ed2so5546275e9.1
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 23:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333217; x=1727938017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7ph+jmjLlXI5r1/pUA2XEeC1lLjfRKxVSeZXnUielM=;
        b=IpyeWreVal6MXAp/tQge97kLUYb+TU4/QI7kI989WlM0OvgOLjR6qcQg4L01ycXlHP
         kJnj/GNPuB90M04FH8tCjsRPX4Dwrm+xtGeIZW9+p+QPqIYqpiNFCdr/2s9oAhFW3zP9
         Vex76pqkaunwaQAXG0VS2ArkKyLz49XZeQIz5rF6+t7s5RBJjJ2Z1kWBhVVraWDOvqql
         Lwqmy2F531iW80TLZ82NIRLiN53F+CDi01dh7m3eMGq47Lsg0rkoUF+dwfM7vUFyOkrm
         tRNUKNoENB5HEy87zUSWUIVopHKDJg0YXm2LVRA1sd+SYohlN7DQoc3AKLERY+2EWFxD
         sKTw==
X-Forwarded-Encrypted: i=1; AJvYcCVnuYYUnCQ3FkuojJYyv3kVja2v2HKzVF54dxR71i0t+X99FcQnbELmzquRlZKJqmoZUlptnKU0Yj9Qb7oOyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP5mgXv9+CXOcjqf5OziU2SHv3Nl8tQ2o16V23FcbaWezC/Oqu
	maHOrxJqFBmqhZDm4kl4zI0n0fS/F4J9h7i3iBVQ1paa+cPbELduomfdJDBgwoU9pzFp7ll1fDW
	yxXWMLx6yQYW3MKCgsfaZo7GWc2AJQs2IWlAyqexnCpXK9CS2ZCPeALI2duRQHwGx
X-Received: by 2002:a05:600c:190a:b0:42c:b995:20db with SMTP id 5b1f17b1804b1-42e96102f2cmr43291015e9.5.1727333217585;
        Wed, 25 Sep 2024 23:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmIOfKJVJuXgn3itaibcpHWKCGIT4bawJixwn7atYQvYKY1g4lI3zJ+mzuHqKsourLP0Y42g==
X-Received: by 2002:a05:600c:190a:b0:42c:b995:20db with SMTP id 5b1f17b1804b1-42e96102f2cmr43290795e9.5.1727333217140;
        Wed, 25 Sep 2024 23:46:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:1ead:3828:4c0c:a50:df14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2cf12dsm5638716f8f.59.2024.09.25.23.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:46:56 -0700 (PDT)
Date: Thu, 26 Sep 2024 02:46:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jianguo Sun <quic_jianguos@quicinc.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev,
	Sreenad Menon <quic_sreemeno@quicinc.com>,
	Anant Goel <quic_anantg@quicinc.com>
Subject: Re: [PATCH 2/2] virtio: Add polling virtio-mmio device reset
 completion
Message-ID: <20240926024619-mutt-send-email-mst@kernel.org>
References: <20240922123435.17946-1-quic_jianguos@quicinc.com>
 <20240922123435.17946-2-quic_jianguos@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240922123435.17946-2-quic_jianguos@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 22, 2024 at 08:34:35PM +0800, Jianguo Sun wrote:
> We write 0 to device_status to initiate reset of a virtio-mmio device.
> The reset operation itself may or may not be completed by the time
> write instruction completes. Add polling device_status to return
> 0 to ensure reset completion before reinitializing the device.
> 
> Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
> Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
> Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> ---
>  drivers/virtio/virtio_mmio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 90e784e7b721..c34ad1782145 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -70,6 +70,7 @@
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
> +#include <linux/delay.h>
>  
>  
>  
> @@ -269,6 +270,13 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +#ifdef CONFIG_VIRTIO_MMIO_POLL_RESET
> +	/* After writing 0 to device_status, the driver MUST wait for a read of
> +	 * device_status to return 0 before reinitializing the device.
> +	 */

This is not in the spec, is it? First you need a spec patch. Then implement it.


> +	while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> +		usleep_range(1000, 1100);
> +#endif
>  }
>  
>  
> -- 
> 2.17.1

