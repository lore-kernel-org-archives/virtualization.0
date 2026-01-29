Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFC2FFF8C
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676139; cv=none; b=KeTzkyJKKcy91RQ58/REZt93Gysmp9OweKcYGy/7ljZrUXSMon9WqGmHlRxUfJG+wn0BQ1Ot48KbBLU8ndE/jL+cvypjsaGHjK09uwiEjV8Yu+RozrFwo60pxlJeaFf4aQ1dA+P4vWx5/eIJjP+EkcF1wz8raOG6dfuISuN4kiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676139; c=relaxed/simple;
	bh=Bs6mTjUeA5qkWiBJBxqsJFMQQCY3VsRZlZa2vBfNivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pa/aLEs2FzDvVPG8Pj3ZwRsHhJ8lK2Pr2ldR6uUjGzN+wUoa00sDhh4glDCPIaINwG1vIeVWgWVrgENJCxwha2BYXGQ9p8EvclhU7mV8EdGBtcJV8HZyOaWN8HYvc1zYi2U6I+M6DCQZbykvrrGwTXvx5AvYeY0yVINZLI0AYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqQPhQON; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqQPhQON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769676136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THtu/B0OMAesHMQ0Tb4jSeVco+ToRrfio4hfGUipZDw=;
	b=WqQPhQONFa2xgtY6FBUAeIbXFCTAvCuFKxuXVwW6zq0DYtlxNpxOS2osvwfH0/SL8bTb5O
	AckT9otx/kX+y/MsmyFDjwfDDgVr6ZXZRSgVNqz0H8JW/pB+WHnbijchuKS4J0lUxLAD29
	1X1vbeV2nQ32OyB2yjk7QFjxxphmpJA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-ezmgDomiMUaWXkhggC9yPg-1; Thu, 29 Jan 2026 03:42:15 -0500
X-MC-Unique: ezmgDomiMUaWXkhggC9yPg-1
X-Mimecast-MFC-AGG-ID: ezmgDomiMUaWXkhggC9yPg_1769676134
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43065ad16a8so417440f8f.1
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 00:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676134; x=1770280934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THtu/B0OMAesHMQ0Tb4jSeVco+ToRrfio4hfGUipZDw=;
        b=XvoRPfwYdPgwFqKC3zWW7Lay7Csm0sKWYV7c+zcu8FDQj9vVA7vlRrFva7iT6wZK71
         daOyFEOnZPPUajoRIDUiLY4wt3WIoP29GLw4aX2wyXsW8cXZ8vC3gJBzHntqkL6YKx9d
         v93kWY2IjhgJpRiLCdT3TaP3HsQU9Gs0tvNN5OXlZyT0JAwx/5zpgzQ/PiPRvPseWcho
         /944L9vS09RyekPUQM6HnN/zMSYwNvUeymQaxzVnU1I3ZsBFLjwpNgAy3QX9ScB41/pK
         TO7oU2gYozE3PjkdP164CQ4jmQ2thJvztnT2dH9lI/s4f4U7spvKlwi448K6psGPWKLw
         /+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUkHA7vK9YjEN2TyzKVBVsbnq4t757wLgzS4tCm5TcvhFt5kF9DeIQVJEu67T63jlGocHbvWn2QfSeIB1B+qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy05wDwcm9RAD/WTpLoHXhxYTW/tYZzZCSRB/jUmuxYVtDioVH6
	efOglf8fV9vPW9ZOVyHmn/Su+SbeQDKAb2pChEptJt2qgg2L6g7g0I1pegIY3kbIQw7kV7TKZXq
	lp+5wETs2UBNxVYeJ5R31j4pvY0swSQkUzbhfiXhqe1EjbhleTFLqh9AYmT8Zq2hZOQk+
X-Gm-Gg: AZuq6aKbjztzDn0AT+hcBr6e+p9AoCLWD0Q3fcSyq9d1tcx5P0DKkOganM/7dM5GXum
	gWi40MAHotCM1c73jj8BuNzVOJYGQTen4p5TLSHI9n2Jf0bRU3mDYMtNY/yBOGFURvmeKspI8yZ
	eLklcjPUs3rjOWDAzWcUrg+tYC8HlcR5m/5V2wBOZ9ROOVnA2i6F4NPGImpN7h5LP1lfjAbJBcj
	Ajq4qkuFZrDRB8AasOYBdI6nM69noSSL6P6t5C01xBVso388P8T1V9IAgqueffTZdEVBnS6gl90
	x+2IPWPsxjqWzEmY7lyTpE53G5jklbgHa7zYlk9J9ZrbxsAMqFpVTdh5VGdCAJrSl8aUanO1mo5
	9K2tUcdOz+Cf6b4zMrpBbBDzR9cgprTyqPQUeVxGeHaJHkadBR4I1
X-Received: by 2002:a05:6000:178b:b0:435:9116:c713 with SMTP id ffacd0b85a97d-435dd02db27mr12237797f8f.5.1769676133922;
        Thu, 29 Jan 2026 00:42:13 -0800 (PST)
X-Received: by 2002:a05:6000:178b:b0:435:9116:c713 with SMTP id ffacd0b85a97d-435dd02db27mr12237753f8f.5.1769676133482;
        Thu, 29 Jan 2026 00:42:13 -0800 (PST)
Received: from sgarzare-redhat (ip110-139-192-82.pool-bba.aruba.it. [82.192.139.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm12807318f8f.11.2026.01.29.00.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:42:12 -0800 (PST)
Date: Thu, 29 Jan 2026 09:42:06 +0100
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
Subject: Re: [PATCH v3 15/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <aXsclvInQFIuFe5i@sgarzare-redhat>
References: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
 <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ciIZXXxXBQpY0SOF5ZKNfBKcyI8d3_--UWhoxiBhhPY_1769676134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 28, 2026 at 03:31:21PM -0500, Michael S. Tsirkin wrote:
>Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>last. This eliminates the padding from aligning the struct size on
>ARCH_DMA_MINALIGN.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
>
>changes from v2:
>	move event_lock and event_run too, to keep
>	event things logically together, as suggested by
>	Stefano Garzarella.

Thanks for that!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Note: this is the only change in v3 and it's cosmetic, so I am
>not reposting the whole patchset.
>
>
> net/vmw_vsock/virtio_transport.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 999a0839726a..b333a7591b26 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -55,15 +55,6 @@ struct virtio_vsock {
> 	int rx_buf_nr;
> 	int rx_buf_max_nr;
>
>-	/* The following fields are protected by event_lock.
>-	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
>-	 */
>-	struct mutex event_lock;
>-	bool event_run;
>-	__dma_from_device_group_begin();
>-	struct virtio_vsock_event event_list[8];
>-	__dma_from_device_group_end();
>-
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>
>@@ -77,6 +68,15 @@ struct virtio_vsock {
> 	 */
> 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>+
>+	/* The following fields are protected by event_lock.
>+	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
>+	 */
>+	struct mutex event_lock;
>+	bool event_run;
>+	__dma_from_device_group_begin();
>+	struct virtio_vsock_event event_list[8];
>+	__dma_from_device_group_end();
> };
>
> static u32 virtio_transport_get_local_cid(void)
>-- 
>MST
>

