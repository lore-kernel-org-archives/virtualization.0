Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671CB3D3307
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881283; cv=none; b=bni9rSBANEi0sGolXIAnCiqc5EgCNsfeouIRhSRHP1vXn8Nm1AKBrzdBdKblXrPFT8an6sUh0DDD1IpxhU7ph1tPcz2pCqinw44DOggYMqo0Xzt2zGFRyjxWko/IjPRJLGLmkxwyoo2YH6jvG2Es9QrTQrg+bevYql8E3tD1EMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881283; c=relaxed/simple;
	bh=KaqiKIrSwJ+ZnBNZThkRID6OHOTJLOwB/Uij0QQJV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bwIcCR6IfpqmWxeUiOlzW8wuFZhVvn0D4dvNgW/BcFS+t0DatQGidntbjf5jiXDrEQnjzZ7W9za6gXN1pk4seStWzTyHK57JbfMydkxBYdgjsqLijcDxU2DxZAaA0Ym7SqbX1hiZsaYz+8kCU8JsUPC9uU9gzBkzPlhrQRSv/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC+z1wRw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC+z1wRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3dV3iJKWcALTHlfMC1TmWQCBk2jAXP+lliSQZRypr4=;
	b=DC+z1wRwPZkoDB0V0nMq+zA2bs5MIJYw6bINgXSFjswyryJ2mTCrLatbKQcGDywcl4AY4c
	eKHEl1A+UnE4VMdCeTw7WV+p9T6ZhhZ4lswneW3nNG770YRFTVy5tkuXUu05TSgrEMyhMM
	1paeVsIad1KhDgwvR2ZRh4+89SfFcdc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-7lWRbx37PMy4u0A8OZM7aA-1; Thu, 08 Jan 2026 09:07:59 -0500
X-MC-Unique: 7lWRbx37PMy4u0A8OZM7aA-1
X-Mimecast-MFC-AGG-ID: 7lWRbx37PMy4u0A8OZM7aA_1767881278
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d1622509eso20961455e9.3
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 06:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881278; x=1768486078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3dV3iJKWcALTHlfMC1TmWQCBk2jAXP+lliSQZRypr4=;
        b=mURnczztt8GrY4kJA68GvhrXRgJBN7ydIqKZ+hfjk93xgBe7+GZVmwKfjb7LnO6Oe5
         +UhKGV4P1Ovsd6RHy2x3yyWirq1ysalUVf7qH9InYgCV8yQ8y9f37LGD/k4g2Jsgz0vk
         WPpxgAEF9SEuYGUbs8/jpafFYMo8Pm4QlkXczxS7hLLqevGjJea99PQwmGUscY3TTReK
         uSR/dUFYWjjooaJc5EO8mENAoEUoz/52viVXZfoWqJRD0qg5O0CVh1U89NbVITMA5WnI
         qaiusHIC8o0+H1syeVAqyqmaWuWQtrKxBCR5dfOeEIFPFbbwOJk74FLWezr2IE4A5vAj
         jfyw==
X-Forwarded-Encrypted: i=1; AJvYcCVpFkmgSaRJcPdo3NIbPnVYSPI4nVtjwDopDhzVYYAB5Dl/flh8u5RMDeHJdPC0xPE4NGUbgCybdEy2/SIykQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz7HSkeylTtWtqIG1L2f9VYxTpe5FoxU54NOpqpEhtgVLU9NVD
	HHxMKMjiyc+PF9qLX7UpI06FpNhq+pskpLiJAMu4poHQmshCim3caFdF7uf18NTL7X+Xj+Gmd0m
	R4qV3t+CldZaAYEpRbZsAi/svLb1cu+0gR5WfGVbd1OSDSE082XB7gDX+XR44dpS4DHeo
X-Gm-Gg: AY/fxX6RdcawhwY+EP/n90IE8z8B6nQNdqBf5syK85s52NIDuMqYFKmAAulEgnzHMNS
	uhN4x8GRCtc+/jTk3udBNN2SoZbqEyoBRdOoecmSKdTL+RCelJVO8PdqV1Co8vRs3xPmDxZFviz
	N/gTj3ePfQJxGu9mqpAyVfXtNmrHXL68M8WBBLgkmXtT423uqzHjKPHCFuY9qQExtQrZRbBj6Gq
	K4VqzlJkbj9wikXZpjFGgUjSigFnhzYaoBW2R3AJbHcG5zypQ+HO82+W7jJabKm/p7GqdmkDt/b
	kHFQZwlg4rhYuKK714oERKmkOmVsATo/sHw+Ceq2f90OFiZd0GULv/+GH0yFt0pMjw6FCz1yOBd
	2csjkiMAkTsYue+2YZ6rVw/uRF1potxwSQQ==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47d84b2cd6dmr72553025e9.12.1767881277891;
        Thu, 08 Jan 2026 06:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRCfp6entO3V/BR31Far6TJcGMp3EAPQ3dAY6QbDFNrKF2+2e3Jhs1Nmifuq8757Npv4Rh0Q==
X-Received: by 2002:a05:600c:1385:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47d84b2cd6dmr72552445e9.12.1767881277386;
        Thu, 08 Jan 2026 06:07:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm160806445e9.2.2026.01.08.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:07:56 -0800 (PST)
Date: Thu, 8 Jan 2026 09:07:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <20260108090639-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
 <aV-4mPQYn3MUW10A@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aV-4mPQYn3MUW10A@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gPJgF4822W4hlNgNpNGBG4A5ka8kizdQAFXYKh79ge4_1767881278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2026 at 03:04:07PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 05, 2026 at 03:23:17AM -0500, Michael S. Tsirkin wrote:
> > On non-cache-coherent platforms, when a structure contains a buffer
> > used for DMA alongside fields that the CPU writes to, cacheline sharing
> > can cause data corruption.
> > 
> > The event_list array is used for DMA_FROM_DEVICE operations via
> > virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
> > written by the CPU while the buffer is available, so mapped for the
> > device. If these share cachelines with event_list, CPU writes can
> > corrupt DMA data.
> > 
> > Add __dma_from_device_group_begin()/end() annotations to ensure event_list
> > is isolated in its own cachelines.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > net/vmw_vsock/virtio_transport.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 8c867023a2e5..bb94baadfd8b 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -17,6 +17,7 @@
> > #include <linux/virtio_ids.h>
> > #include <linux/virtio_config.h>
> > #include <linux/virtio_vsock.h>
> > +#include <linux/dma-mapping.h>
> > #include <net/sock.h>
> > #include <linux/mutex.h>
> > #include <net/af_vsock.h>
> > @@ -59,8 +60,9 @@ struct virtio_vsock {
> > 	 */
> > 	struct mutex event_lock;
> > 	bool event_run;
> > +	__dma_from_device_group_begin();
> > 	struct virtio_vsock_event event_list[8];
> > -
> > +	__dma_from_device_group_end();
> 
> Can we keep the blank line before `guest_cid` so that the comment before
> this section makes sense? (regarding the lock required to access these
> fields)
> 
> Thanks,
> Stefano

A follow up patch re-introduces it, so I don't think it matters?

> > 	u32 guest_cid;
> > 	bool seqpacket_allow;
> > 
> > -- 
> > MST
> > 

