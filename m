Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC64ED46D
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881075; cv=none; b=NX/nkXnXkGrs73IxKyZOEHGLq6koIrrlsetKGCd9lKXtLK7ByynluIrM3RAWh5780I6BrjNl9qydMp5HDR7rmBSKXcZRGFvdcCOgFPNh+8rVVVHO/HvLwiPOK/t5WAmZSTIym924kyZ+wJaaS7yXsde9nD/PqkFe+/9GGUohljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881075; c=relaxed/simple;
	bh=yXMok8JlOEM2sgAIipul0a74lzFqWXRhO2Aov20FAgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u6HiEgbmrmzpIog27bQrmtLFr3CYDif7jO7470pitvCxge7nuDfbqSUipkC0ALGrNh0IbFcQOna6Bw8EQA5CKARpAC5U1DhofC5AgjMQ3VeYAcRz1FAObn9j5xDAgjFlckfIphv7UfoIPRSPNmJnEZGjN1vl9Tj5XVgAEOO6I68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSdozVKY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSdozVKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmGHhC+vkdZJgHO0r54G5/mI53k1eZnkbsYL2uSG2DQ=;
	b=XSdozVKYXBNjvB+ZlPsV79UCFPNGi4KnvkXr9ibhG4FB6rwkF7ldAwjyfnKfepj1vK1OTU
	20DFdlNgKknP7JpQj4v5XhiBGJ5zlEMIHQgppjG/0G0LNAMDOv7QfAFzRWqZN284ji68I9
	ashA7yvIZYn72G1xiZfWopd1ua0ZfQc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-8Td0qPKiMqWJ0z1opSnX9g-1; Thu, 08 Jan 2026 09:04:28 -0500
X-MC-Unique: 8Td0qPKiMqWJ0z1opSnX9g-1
X-Mimecast-MFC-AGG-ID: 8Td0qPKiMqWJ0z1opSnX9g_1767881068
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8012f5f7a3so359447266b.2
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 06:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881068; x=1768485868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmGHhC+vkdZJgHO0r54G5/mI53k1eZnkbsYL2uSG2DQ=;
        b=eZLpfxpN91U3yXeYkZs/greyoQFc/vMNUoVkNtPjE+OoXbA+JN8/IaO+zycmpazrn2
         SyuxNfOFCkGlOCqOtq2GczqD3TDmpXprE4gf9fFHEnXkvME8N4TLCKquCEhvxnuyPqyf
         Y4YIyAU+N6n02swY4iLjsPAwAs7M+NhDBYA+LFUnKuK2O/S/6K06esGNubJh4aXl/+cg
         n61pJAuV83/8k4hc9F46eUVRPYgCiJQPGVdJPe0er+aiH6nuquzbKrkkjb7M+Rrduw+s
         lm7tbhkunUiwCw55BtaY96/fiXcnBLCzdaTRPIEUek3ixssRYS5GfXgUD0pO+LWrOQVu
         W1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0vsBcjyFktvBqr5EHsT7kgI3q5h4bexREMRo/y/0KlIZP34Qo5Qf3hXQbCVvxRGGa+wM3oLa3ppPQdQ+axA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO6j2Q3ikUBovK6BQbMAYNxmVpqbqi705212lWT1ABDRUUEBrI
	ah9UToly7wAhaPBQCj2lEArL/nHLKBnanFPPMsKClvaYP+MlBPW5QIRSAHpzxKndF4JgX7oztMr
	QcI+KLvW2WthMWqaRig9w5q1rZV7tFoLRL5xbvC5CHDPMGgu766Ffokv+Z74v+sbwZZUr
X-Gm-Gg: AY/fxX76Mgwgev3dVnRKQpsqNsSuxpOHb61z4b+1HM6340c5nJrM19VXJHt1LCuJasn
	hQg3umPFVdGvnFz0y0+hiIvdg1+Sfa6QRzt1LLCfBZOhAtyxu4HCceBSQoO1SNg0wF5D5+SwtDQ
	yh0chQhCYh1qsD24o9c7ja0VOsh7OMcgZS/4QFeIxTTxlKfjgHz1kWqYTkbI4hkH3IJnilVIkt5
	8bBAXzbC9e9KspXSpul0FGS8cD/wtkQm49UM0hjcrTcYrvZUIq9SR3NsUfUlpY6nIXWswySkw37
	P/rYCOGnBVM8JdmImR4zpSQA6cPbyxP4a2tmnykgzRX1HcgYSWQDxRBVMJ4MESFpHH4PjUALUjX
	MJpNYovnGgKlaYoi4
X-Received: by 2002:a17:907:3da6:b0:b7d:11ae:4006 with SMTP id a640c23a62f3a-b8444fd6743mr637893466b.52.1767881067713;
        Thu, 08 Jan 2026 06:04:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgw/BdfC1kapmuRYU6+l1S1c4vqL+ygT6gHm7yV/BgYYGWFixI2eOd8lpv0XHKoQQX3Zl7xQ==
X-Received: by 2002:a17:907:3da6:b0:b7d:11ae:4006 with SMTP id a640c23a62f3a-b8444fd6743mr637888166b.52.1767881067171;
        Thu, 08 Jan 2026 06:04:27 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a564284sm830039366b.62.2026.01.08.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:04:26 -0800 (PST)
Date: Thu, 8 Jan 2026 15:04:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <aV-4mPQYn3MUW10A@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p7vwe_PCQcnP5GUsqaIuzp33_xKMiCQdrPZU9n_y7kg_1767881068
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 05, 2026 at 03:23:17AM -0500, Michael S. Tsirkin wrote:
>On non-cache-coherent platforms, when a structure contains a buffer
>used for DMA alongside fields that the CPU writes to, cacheline sharing
>can cause data corruption.
>
>The event_list array is used for DMA_FROM_DEVICE operations via
>virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
>written by the CPU while the buffer is available, so mapped for the
>device. If these share cachelines with event_list, CPU writes can
>corrupt DMA data.
>
>Add __dma_from_device_group_begin()/end() annotations to ensure event_list
>is isolated in its own cachelines.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 8c867023a2e5..bb94baadfd8b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -17,6 +17,7 @@
> #include <linux/virtio_ids.h>
> #include <linux/virtio_config.h>
> #include <linux/virtio_vsock.h>
>+#include <linux/dma-mapping.h>
> #include <net/sock.h>
> #include <linux/mutex.h>
> #include <net/af_vsock.h>
>@@ -59,8 +60,9 @@ struct virtio_vsock {
> 	 */
> 	struct mutex event_lock;
> 	bool event_run;
>+	__dma_from_device_group_begin();
> 	struct virtio_vsock_event event_list[8];
>-
>+	__dma_from_device_group_end();

Can we keep the blank line before `guest_cid` so that the comment before 
this section makes sense? (regarding the lock required to access these 
fields)

Thanks,
Stefano

> 	u32 guest_cid;
> 	bool seqpacket_allow;
>
>-- 
>MST
>

