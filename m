Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026949EC43
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436563; cv=none; b=bJjzXwn26u3/tspd2m+HDMPjcObicRjRlA0+SkL4lGJqU8YhtxF4eamBSxjSmnZ9w3FHn6nCqvUXLBQmezCNh/Ge3M74TaEFj23m2p4pEhj0pgM7lbJqYu59f4KFf1FxWunxvElJSOEMcp3gVb993k4FTRNmI3xyUDq/L0Iud4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436563; c=relaxed/simple;
	bh=CdAz7fh+1ltkQ4tM2hXdLcQnn+Tcf3gIIBOSSClnYDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gTdh0Z2ITc9X2hkbMhxJaRnSo+EJXhm81DmYI54XQOmdwXKlsB7Zkou86b3uK1Z9SjkbnKcSoNjLgVSPPbxQh1ZKOR3wWuCGteSul/1frb14vsonaW5J9BAvrUoZ/tN+xoxPiMfhFVw/fMTMRlvBJyu0RpLaJUgm4sti60yPqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijVnPGEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijVnPGEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcb5WjUE5AVdlBj8rvAyCS6YYznNN90xNsiTu4NwOR4=;
	b=ijVnPGEwlSmRtVsbvOB384r7m7pT5g78WGkFX8KeOv//UsyWhzPtqYWjR87MhKsNPCfi+Y
	cs1Z55jploTlOJdy7idsrXqIC3pW9KRCmpkwy0g8L8LcjkR7uKgQ6uNPUJgaDmFpvTPlba
	V4ivs5kuEZ6s8YokG2WVFcatwKwkk6s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-fdTp2IXnO3uAJCZseXWGiQ-1; Thu, 03 Sep 2026 07:55:55 -0400
X-MC-Unique: fdTp2IXnO3uAJCZseXWGiQ-1
X-Mimecast-MFC-AGG-ID: fdTp2IXnO3uAJCZseXWGiQ_1788436554
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4843d9ab895so1988121f8f.0
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 04:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436554; x=1789041354;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bcb5WjUE5AVdlBj8rvAyCS6YYznNN90xNsiTu4NwOR4=;
        b=AYGEjkWny4vHCynzwLaYi88+YT3xAB71I7cEZbr7bm6Heiiw1p/2lMOnyMKEYtVT+C
         9fX2JWI6MU4KmJnsVjyZCUCEGObkpOmyZX1nz73RZCV6GFEeDsh3ydJNaXJUYuh6Min5
         ONQrJhjt7ilr9XJlkJcJl8Cj7j1Vop6bf4ngoSIGGVue6+NVx4oKEupzVQJCnr7wcTWQ
         9jRWJQrQpAa9MX3WiipayEbSl+4jnRGMVOWoWRy28C6rteisjSJ5tw9kio4HfbaODT5E
         Z66cVuKYOL/949+aG35yDfIOtzGa8pvKjlhGAhYo97yN6/mmFPe9TXko7q6jSJbc4X6B
         EZJA==
X-Forwarded-Encrypted: i=1; AKwUvBznUOXDlJkglga4jqLofqG4s6QdpX4NLsXRIexQozQWTpH3PJH70ytPEoDcwaGaAH9Wx39AGbfIbLZUlEagQg==@lists.linux.dev
X-Gm-Message-State: AFuF++nAKDpNtm08+oFasxMSTF8MQhcuUu+RGbRjE5HbX/SEjE2YGsOF
	BdPpkbjwfJfHVVDSHFIzyHPaKhfkMA4QnQ5sGpYrgkZqKfJHtBLvxN7N7MZAVjy0Z8I814r4j6k
	WO5VX3uoAqBbD9Hq7iWndlTBSLmFsbxGMPsFQ/Bfvlm9g5Uym2C16yw9bfDGS5efJATRQ
X-Gm-Gg: AYBFou0R+KKt00KOKsk69at/WEdgqT9GX4CVghwpfEKGTJr42IexP+XG24elGUqZ+A9
	h+jUpBtIsEUYRUgys50eRz/WOfKX3hpwbuUolbAcZsu1ZXv+B0IK7vcjMt4rFuslf+4SkTPpU/c
	qK9g1zy9hDxVU6hsPbzvDIHrdKwx1l5l+neUZPmsFWYRPAjDi3em2DgQURHyteInQETWkENHnxm
	16wT01CZ979OzIMKgHSeZymqg56Fjl/0QivUlCrGoJHs8zR4N4zhIGUliW5epZijjUDJoCT/bWG
	6apwhwAD3q6XB+7KNCnxeh7lES8ZNFgronKmI6Sda3OCqZ3YPdoU97t+g5tf/AMUy5cwoLpRftx
	wwxRypbpIAwHW3vt+O/T/Y8U=
X-Received: by 2002:a05:6000:2086:b0:47f:96e3:530e with SMTP id ffacd0b85a97d-48488efd18fmr19364417f8f.8.1788436553768;
        Thu, 03 Sep 2026 04:55:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2086:b0:47f:96e3:530e with SMTP id ffacd0b85a97d-48488efd18fmr19364312f8f.8.1788436553272;
        Thu, 03 Sep 2026 04:55:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed38cfsm12369287f8f.19.2026.09.03.04.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:55:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:55:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio-mmio: synchronize callbacks during device
 reset
Message-ID: <20260903075143-mutt-send-email-mst@kernel.org>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
 <20260818040433.66986-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260818040433.66986-2-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vJMYDpeGxCP8HOyh_f36ZicO3NXciu5fDNwxt-4XAs8_1788436554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2026 at 06:04:32AM +0200, Karl Mehltretter wrote:
> virtio_reset_device() promises that vq callbacks are not in progress
> once it returns, but vm_reset() only writes 0 to the status register.
> A callback that has already entered vring_interrupt() keeps running
> while the driver tears down the state it uses.
> 
> Wait for a status read to return 0, so the device has stopped raising
> interrupts, then synchronize_irq() as vp_reset() does with
> vp_synchronize_vectors().
> 
> Fixes: edfd52e63672 ("virtio: Add platform bus driver for memory mapped virtio device")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>


I htink we should  instead drop 

vp_synchronize_vectors

from vp_reset

and instead call virtio_synchronize_cbs from virtio_reset_device.



> ---
>  drivers/virtio/virtio_mmio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 510b7c4efdff8..a2ca03dbe803d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -55,6 +55,7 @@
>  #define pr_fmt(fmt) "virtio-mmio: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
> @@ -254,6 +255,11 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +
> +	/* Wait for reset completion before flushing callbacks. */
> +	while (vm_get_status(vdev))
> +		fsleep(1000);


only needed for v3 and up

> +	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));


>  }
>  
>  
> -- 
> 2.53.0

