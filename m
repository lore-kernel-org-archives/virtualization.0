Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E1233722
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573326; cv=none; b=KoEolrHR+KYayZ0xxrzn8cGOG4VPQvjEURVzHTvg3HzWFTjZbbcupWld6LK7pZczy/MnKLRO3fJ/lHoFMmY+l8JxBkMzrS9u0vj4kH2EUtQ9echXCulYdcXHt+xg1fyo9H5yfihTEY+t9cHMdP1Tr+ab+NgNjBmFqzDKgSmoYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573326; c=relaxed/simple;
	bh=+amJMGPMe6DvicjWF80SXyO9oVTDL+ida1EY6ELCfas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nzzsZ1hisCnTUbzx4kzeongvM2DsFmXvpVDtBaPZfFnfKbtzlq6b5KRihhYTdP6BFyCAHc1VSb7W2rtJ1ptEhcKP+55+l/ZRRu1+IxMg23c3kR61dtnLO0f+dcbzlJNc01o8z8/dVDKXFzz6I79SaYHfHB22TnrNr5mcG6gyWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gs2qrHe6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs2qrHe6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKOPJBHf5+FoxYfBH8MZ4lVKlkTlG0XkNAjkThBHE5k=;
	b=gs2qrHe64Y6+qqaB3bH/PEBKwU1gStv65XH66OaR8/t5n4G5kDmlhLVVFKU066g4ln2zTo
	3iFwnKuSND22gdiEWi8Iy4VXNxEh95I682z5sBkI9LW2fM+vhXDC0kZ6Qgp74LZ2McgFH1
	vxSnk1qdGiF++GMhkbcR54Za/2MYgcQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-aUNUV2JGPoSyrv89HtgGvg-1; Tue, 15 Jul 2025 05:55:22 -0400
X-MC-Unique: aUNUV2JGPoSyrv89HtgGvg-1
X-Mimecast-MFC-AGG-ID: aUNUV2JGPoSyrv89HtgGvg_1752573322
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab5e2b96ecso54051521cf.3
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 02:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573322; x=1753178122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKOPJBHf5+FoxYfBH8MZ4lVKlkTlG0XkNAjkThBHE5k=;
        b=aW6Py3uzrfJopBpTs3p6J0dragbWTRpph3sSxzit/tAgE5bwwoUvzt0G7DoZt467AH
         IU/9pyDWQfibj1Z5fCw/ACLOkl/Yf8S/Ffgkmf7APYNktfK+bL7q36deHS7D+e4fvhKk
         o/MM8BraUW704d73/OVGriFjDALWt2QAY8lO7rOfAIvFM6df3unlA9tJrdZ9LrG9AFcF
         l71SlXlRvSUF7abklsiKhOhLw2i4684iWfodbgidrrz9VHm9Fjl5Bs5u0WZPASyUVIet
         m9v6lkrLh/JiwigcZOM3qCHJ4bBOFW+jijIRYaJ6kDUNMG0qVzhlGJv+kUDVVh+CgZpH
         GYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwVu1K2Lqdf1DA9VT34JxmmaOx5l5dJ6P19pbkrJZt9BV6fDXNnnbu3ykHqVqhtBe3UNFuXhKvquBSLg9u2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgxNkZFqjihb4Hc/o8dsxzEIvaDvm73s9HP87Uq5iJTw+mFQXP
	871gRSRCFliHpZ2pGAxgYYtuuoe3FR5FWeHUIk3czbG8gAabP7tStQRBW4Y892GtGGYeOwDGoLU
	8W/xymKieEsYE7qmQMWwNie0ftLI2mrnNE7g/vG9xbMBCQ22HqRhxV18le8OAB+/8IQyI
X-Gm-Gg: ASbGncvJSgyM3kKhoA2+9ePyf5VcfVu2JqlC2ZiaWRQPmVXjKBAPelE8/sfCCGY89LB
	qnsEj4SOqCP6MEkCOkuEo0ougN64LnEhYB+Q9ltCY3XXxCW6NCBg689IdYHUgHv6vP2xFSLDq4V
	E6ALdLJPOwpiwN8JmO8NtgnJoy5jMhlWdtA1fteu3FHPuvvLaW/ng1wcl3Ww81NgkUSgPBtL0B8
	N+wBTx+AOhQkzRiSTfLIQL4Z+REkgrIrMHGdNrpCDnCdCPpqa7+4O80URHK1CAcGXoRYHKnwhKu
	xmpBQTFZXtuCWqDgsHduaoX89GYPKeuDluAlXKCcLw==
X-Received: by 2002:a05:622a:5ca:b0:4ab:7262:893a with SMTP id d75a77b69052e-4ab824a322amr24393531cf.18.1752573322308;
        Tue, 15 Jul 2025 02:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeWoRAlpmTeV16PHDRVin9Qf8zLbTd5Snp7dshvSQ6NI7guHEP1XHwoIcK6laQEHjMzcohNg==
X-Received: by 2002:a05:622a:5ca:b0:4ab:7262:893a with SMTP id d75a77b69052e-4ab824a322amr24393191cf.18.1752573321802;
        Tue, 15 Jul 2025 02:55:21 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab75211016sm14135681cf.45.2025.07.15.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:55:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:55:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 3/9] vsock/virtio: Move length check to callers of
 virtio_vsock_skb_rx_put()
Message-ID: <ho6edx2uqqazyeoe3vm4oruas44ozngsoyhcuilremkzqg7u44@b6xeevkxtlmc>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-4-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-4-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ioqxf-0YntdS_TbusmYMxonvg7laLWJELB4_a6XdqPg_1752573322
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:20:57PM +0100, Will Deacon wrote:
>virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
>packet header is not zero even though skb_put() handles this case
>gracefully.
>
>Remove the functionally redundant check from virtio_vsock_skb_rx_put()
>and, on the assumption that this is a worthwhile optimisation for
>handling credit messages, augment the existing length checks in
>virtio_transport_rx_work() to elide the call for zero-length payloads.
>Since the callers all have the length, extend virtio_vsock_skb_rx_put()
>to take it as an additional parameter rather than fish it back out of
>the packet header.
>
>Note that the vhost code already has similar logic in
>vhost_vsock_alloc_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c            | 2 +-
> include/linux/virtio_vsock.h     | 9 ++-------
> net/vmw_vsock/virtio_transport.c | 4 +++-
> 3 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 66a0f060770e..4c4a642945eb 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -375,7 +375,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	virtio_vsock_skb_rx_put(skb);
>+	virtio_vsock_skb_rx_put(skb, payload_len);
>
> 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
> 	if (nbytes != payload_len) {
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 36fb3edfa403..97465f378ade 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -47,14 +47,9 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
> 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
> }
>
>-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
>+static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> {
>-	u32 len;
>-
>-	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>-
>-	if (len > 0)
>-		skb_put(skb, len);
>+	skb_put(skb, len);
> }
>
> static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index bd2c6aaa1a93..1af7723669cb 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -656,7 +656,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>-			virtio_vsock_skb_rx_put(skb);
>+			if (payload_len)
>+				virtio_vsock_skb_rx_put(skb, payload_len);
>+
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

