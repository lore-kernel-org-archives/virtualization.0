Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37450347C6
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975515; cv=none; b=MaXroyhBEPlSn/hcA+3RpkSppPTDVYXs5xeqtOOjHPzc+dKWduCsEytFICfitFTE5drPZxC7nSXRWJNSgUgzUoBq64xo2b7lmG52U9w5RwwAjhUq/l6D46u1abxwdWBhowsR+AhvsBiwevQUqShyvFlX1kNCQl7TlBpUlO/9O00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975515; c=relaxed/simple;
	bh=a1/DesK3SdmsYTBBaArmoKyDaDj/3FIZv0uZ3aW3q6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rUkL5YLXO8JMlCYJKxiApqmyhSlLr02gDXVVCvqCkvdNqck1qR9mUDg/3tYGNdmj3LJXXanBG/pSLalh5Lk0q4fLcwkTjoPhfcC14hxlq0tzcEGl2p6zpDpzFhtGQ5h/hwHuRDXWSnajddICfNgUilrGW8ICWuDx65EuhWD5bYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKiAbeLy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKiAbeLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767975510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/krVGPsvJddi7hg5z9iCRy/aoNIgxBgy+h5yAK6W1kg=;
	b=cKiAbeLyx1v+pyYLplqORQGMeAGJNFSLGROg77KxFMO6OExlwKL+wVxk+A44NxURO+OnaD
	G9Nv767X6VOHr7Dk79V9DHGeGg8yndM3HFCoVokb3PvEDdH84u46ygfRFm8aWabYuzf/SS
	9BDdpAZsi3NDbloAm9DWgzrz7X44NDI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-e3txoAcsNgGPszEbT_GDqA-1; Fri, 09 Jan 2026 11:18:29 -0500
X-MC-Unique: e3txoAcsNgGPszEbT_GDqA-1
X-Mimecast-MFC-AGG-ID: e3txoAcsNgGPszEbT_GDqA_1767975508
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b79fcc35ab2so375386166b.2
        for <virtualization@lists.linux.dev>; Fri, 09 Jan 2026 08:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975508; x=1768580308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krVGPsvJddi7hg5z9iCRy/aoNIgxBgy+h5yAK6W1kg=;
        b=RxArjm0rsCFHCjgfqgBBxGCTS2UQAGk6R1OeLp2jAs3QxB7b1Z/EqN2DSMPHQT6L58
         kcrvBTcRLDKWuOTlTTRHcy+VKIvmeA7nstO62/Q9xMtsbaqpI6ryPkyG1ccLoG6rYpzK
         +B6QUnxrThZkzRQVNDFYTIbs5UvYfE5EyMcZnFZwYEzW+X3g09eaNf4OeFT+bXNQ8oVT
         +c/Lmkb+LlqCvjevsryAersB4EXBZOG1nHDxdcHf3DBHt40Cz5IVIN60kHUp1V1xRyEz
         THDKnqhzGa7LCX/LDa1M3/B1MBVhYKn68zHE+cUJhGuTgpUZHB0jqnOoWCJuddVhsVPS
         KIBw==
X-Forwarded-Encrypted: i=1; AJvYcCUiT4ho6LEulPgqBuHP9wlaKk34yqaKYR3dS5G1ourZ41Ku0Etx+j8L8ee32vQ4o8sXP8Mszieird7GihNu3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0lwrXr1aGoHLv26DS2hSOwVbUZBdh9cyhQpgOdj65mpfXt8i6
	YmN0U44CjQw/wCjAmlPZGUMiPwJhnVslPsTH9ooQRycykCHpM7b5EuCWelhm6ndhZILYYK3/MGj
	EzVd/1f+EcWfvdnwrotZMBFuooadFiprlZKN0OzSBEOPLhF1xarGC1sj/lO8HAcekP9t+
X-Gm-Gg: AY/fxX7xiZFXPKiyHsiyNWli9rN9t7Esf6+X0nXb7IJIG0P4I6OhuLXYHA6hWb4Z/9u
	DtrpE0Y5hbTP4aIKDZZxZDUaVyHSQT78nL+mdKel+VaIjyAHPgpiaDSZ2hIlczLFGQ+a9Q5YCUS
	8+ulkFvhrou0QZTsnahOWqcgVn7U5de3DwPM/13FgB0svlGF7KxRwMTcnBfvhwAplmSK836Hgmz
	fy+F4kVdx+Ss7nHprFcvcU9yg0hOrH/1YL16sng9Bx0CRJLbn2pbfR3NVxDL9gJ+qwDBktnqXGj
	QYM6ITCZalaIYK86NByhmotJ99qoNc88cozuapMeN4OEXSq2+D5iYsAtjkWhOm1NbjC7TnxvI++
	pNJ3LAsg9U2JX0nU=
X-Received: by 2002:a17:907:1b0f:b0:b6d:9bab:a7ba with SMTP id a640c23a62f3a-b8445179d97mr1040652266b.42.1767975507957;
        Fri, 09 Jan 2026 08:18:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr2olBdquSj4gJBneVi4T80pCx/5PM/5koZL1efVNkWaXxHFkv/Bw2psyCF7rUeZB6h9BHnw==
X-Received: by 2002:a17:907:1b0f:b0:b6d:9bab:a7ba with SMTP id a640c23a62f3a-b8445179d97mr1040648366b.42.1767975507266;
        Fri, 09 Jan 2026 08:18:27 -0800 (PST)
Received: from sgarzare-redhat ([193.207.176.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51183asm1175084666b.49.2026.01.09.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:18:26 -0800 (PST)
Date: Fri, 9 Jan 2026 17:18:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsock/virtio: Coalesce only linear skb
Message-ID: <aWEnYm6ePitdHPQe@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-1-26f97bb9a99b@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260108-vsock-recv-coalescence-v1-1-26f97bb9a99b@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gZde53hQa_SvUmQCSqwEgzkTqk-HHbFwpNQqbirxLRY_1767975508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 08, 2026 at 10:54:54AM +0100, Michal Luczaj wrote:
>Vsock/virtio common tries to coalesce buffers in rx queue: if a linear skb
>(with a spare tail room) is followed by a small skb (length limited by
>GOOD_COPY_LEN = 128), an attempt is made to join them.
>
>Since the introduction of MSG_ZEROCOPY support, assumption that a small skb
>will always be linear is incorrect (see loopback transport). In the
>zerocopy case, data is lost and the linear skb is appended with
>uninitialized kernel memory.
>
>Ensure only linear skbs are coalesced. Note that skb_tailroom(last_skb) > 0
>guarantees last_skb is linear.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..cf35eb7190cc 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1375,7 +1375,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 		 * of a new message.
> 		 */
> 		if (skb->len < skb_tailroom(last_skb) &&
>-		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
>+		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) &&
>+		    !skb_is_nonlinear(skb)) {

Why here? I mean we can do the check even early, something like this:

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1361,7 +1361,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
          * to avoid wasting memory queueing the entire buffer with a small
          * payload.
          */
-       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
+       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue) &&
+           !skb_is_nonlinear(skb)) {
                 struct virtio_vsock_hdr *last_hdr;
                 struct sk_buff *last_skb;


I would also add the reason in the comment before that to make it clear.

Thanks for the fix!
Stefano

> 			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
> 			free_pkt = true;
> 			last_hdr->flags |= hdr->flags;
>
>-- 
>2.52.0
>

