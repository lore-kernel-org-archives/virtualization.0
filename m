Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7008039E6C6
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881322; cv=none; b=lq4ENPYA03BDV9VQChPkDiIiukKUmAC6F2egtLoBDJ37GcRPylpoFwvjhXDSxy6/Ez6hiHTpYLbzTzZch/DwOKC/9eSrTWu1SzSPDOcUdaXCMyUjDTGdmuZoJX8DNOlRg4W7x54IWNYISZ7FKB0iA59LnsF6DXKEUCrXgzuF+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881322; c=relaxed/simple;
	bh=Tv7zh9Hk92kdNn+K2fPlpE9fTBNWYFWSvOonEurgOJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KnA2DN7t5RpQue2qbL06PUb0V+Vwtq0i7toe99ShKWOJA3fGEamQQXDAxb8jor5mHoZ3U3hjmIJ3ZSQrgYtLzmS5LjEd/Pd7KR7jSAlrJgT2LoFh2IuZLvza1esLiZ23eG1i27gzHOsS9lWubANN1rxzPPxDnQpnj3noqA4r3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMv34wXl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMv34wXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qb0opi0EkMyYcYBrprImauJ5+csaYa0bSdovEgtQBZs=;
	b=JMv34wXl46/FnDYIPBeZ51sXipwgk6pezAGY39bqTlzPzqGLwhRvYA/iMaoSBPaRx9mLmE
	WPsMmMtnHKxBdSGceUrsdOCiOOR846ppp2hyrm4iDkWlsJ7yXyPyGNQfRhlC14giF8oheA
	VeRS8FI//u7LGUMkUMyNIwT1lF2XALc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-PRpcyi4RMU696V32FuF6cw-1; Thu, 08 Jan 2026 09:08:38 -0500
X-MC-Unique: PRpcyi4RMU696V32FuF6cw-1
X-Mimecast-MFC-AGG-ID: PRpcyi4RMU696V32FuF6cw_1767881317
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b831e10ba03so499397066b.1
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 06:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881317; x=1768486117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb0opi0EkMyYcYBrprImauJ5+csaYa0bSdovEgtQBZs=;
        b=ULQhiiH/zUEGs0CyLBAqk6x/HUkS7QAcWaTrVJfWlG7zSiTZ+emrtnUBE3olQZaIs6
         Bnatxmpi4YJ5EF26HY3Jj876REEm5fv5JT2SSmr68pZza1nUdLPrdRGcvkqXBQ1a5esy
         BMFCI3eiQ51t9VKxBabPcU44r8t54fyA7NZbzGGHhk6zBV1zsEePZclB7sdoXyj3820Z
         dR3iJ+5rXD451YffpzaciXCaqj7gZ7KE1KOA0bu+qsqUBRG+izdJz1UWMpe3BCEg4x/L
         h/zRG3F6X3mBofJMqRq7K2o6e8QTu+OvLM9YMR+ccw/9oHX/fnO1J9d/lfBY/bDvNTvb
         Qa7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOESJIazO+6AkK06rYoD1WSuktSQ7swUCC7lqFuaTSYmZG6FH5xc2se6Blc0nqT6vj0q80dWD35zGla8qbPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyadiMyBW1ymy+O5I7E6i4Vom/9xRN41mgMMm3ksw2APC5rYVia
	d2Zf0vTW7HrKwGjOvi+MSGWy3BTNFtpva5pERCOk4Yt15sUfmUu+n/d7t6B2DNZ5fEg5dChhIW0
	zYUse0ZJZVCw1AW28Z+LU/0Aymhy3lL4H+RrIFJJO/4oweU9pYue5TOaroi/If1k6LqMu
X-Gm-Gg: AY/fxX5D8yUQLihGJrTn7yn458FcBnBYzbe8yy3HRomE5J+2D6qjJsrJ0dw/6YUiVbW
	uu1saKPEC1Es4PozKY4c5TRCipQxU7fFCkaQI7muZDe2bmPEsioORskulj29QpDUDkyP9B0xQLF
	AZ3+5QuNnm4CcrSCpghr0N6pPhoMNJx5BIX3J2Qa/Ytia5ud0vIIy7kzqpwRfLEoj/4C6BdPtSz
	wWX8Cs+5UeQ+tEd5ahUaRnJYai5+QsvNyYfCDHHIzGDulRqbG+AcCgZVPyBZ3EIPMUZ4u7Dv0lq
	lrTJhvHx2MvZ6v3dpXb5KGVEsL4Ta56H1fftLtnwhvG7IaXVvtEmUB6k/YUI2jXUh5b841hZBEo
	pFVh1mxolb4ibaIbU
X-Received: by 2002:a17:907:7b89:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b8444fd453amr620665466b.49.1767881317042;
        Thu, 08 Jan 2026 06:08:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7HOHiWGYK4xorotJbNX0jMidX1ixXQJJ1VdDBrRK+mMgTkrWVhdGn0FKO7KNa9bc9HZtucg==
X-Received: by 2002:a17:907:7b89:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b8444fd453amr620660466b.49.1767881316491;
        Thu, 08 Jan 2026 06:08:36 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2cb447sm843387866b.29.2026.01.08.06.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:08:35 -0800 (PST)
Date: Thu, 8 Jan 2026 15:08:31 +0100
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
Subject: Re: [PATCH v2 08/15] vsock/virtio: use
 virtqueue_add_inbuf_cache_clean for events
Message-ID: <aV-6UTKChBhiTynA@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <4b5bf63a7ebb782d87f643466b3669df567c9fe1.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4b5bf63a7ebb782d87f643466b3669df567c9fe1.1767601130.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W29HZ1IqYw9NVYv3QUKoiEZyfX8o5rEgHQvrvDWPoQE_1767881317
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 05, 2026 at 03:23:21AM -0500, Michael S. Tsirkin wrote:
>The event_list array contains 8 small (4-byte) events that share
>cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
>this can trigger warnings about overlapping DMA mappings within
>the same cacheline.
>
>The previous patch isolated event_list in its own cache lines
>so the warnings are spurious.
>
>Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
>write into these fields, suppressing the warnings.
>
>Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index bb94baadfd8b..ef983c36cb66 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -392,7 +392,7 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
>
> 	sg_init_one(&sg, event, sizeof(*event));
>
>-	return virtqueue_add_inbuf(vq, &sg, 1, event, GFP_KERNEL);
>+	return virtqueue_add_inbuf_cache_clean(vq, &sg, 1, event, GFP_KERNEL);
> }
>
> /* event_lock must be held */
>-- 
>MST
>

