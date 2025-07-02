Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8572F3C13
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473730; cv=none; b=aeVtGqoOJIoAmP6tPGHu7iIUiLIFfvU1f+K0cYzqHeXLjrl9xvDhTEi3zMT8XzTPEuxC9MX1gcocMAuz5SrJA9yi9U7O+DZJOxNtxUuOIdvEprsQjzCJoLgtzg0BITb71fu7HCrciJsW97Lo0ItjJjFn7ayeyZIHIm0e//l6xIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473730; c=relaxed/simple;
	bh=3cOhVNRurGPxaeIw/7+m+PZy6wlwiza6W0eLxC4gdvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aapTO4pJx2ocyx0zzt1ZxMYHVHtMZFsWy5zatoWsBqOEMCoWJzA5rEOZLRgrHt2fg/6eqxcuUvaxa4qOJfU9OrG/JtExgZanqC1jOuL8BMgsCfru/tWTDy8b4fLDStWX8RnEst9SFEVaTBoAmEJk8U/DlScS19Z0UpG8d9/v8NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrM2oMGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrM2oMGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751473727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NG8jUsMOCdk8QP8hLYJJABR34rscESNoucVpKrlQhUA=;
	b=hrM2oMGWxWQOtdvIN0QmFCtSPYG6yJCW0s8oMOOMZ92GRGjgatuo1KmutR2fVLkZsxKcpf
	aD/Q92YvgHDUSqT/hFur9Xo6iMbgjSKSbjBT2oIfgRBB9C6O1zO2CED+7hlz/B5rr3HA2X
	ZNlwMFttNrOB/JiK8ZjWDKPTVnbxOVA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-odH7HnkTMzmjzXzr1fZv1g-1; Wed, 02 Jul 2025 12:28:44 -0400
X-MC-Unique: odH7HnkTMzmjzXzr1fZv1g-1
X-Mimecast-MFC-AGG-ID: odH7HnkTMzmjzXzr1fZv1g_1751473723
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso2336707f8f.3
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 09:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473723; x=1752078523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG8jUsMOCdk8QP8hLYJJABR34rscESNoucVpKrlQhUA=;
        b=hpuKU7nDvi5sOdlNT/osIhdaz3HN//HvkOe4sTXJfmQeemZo9BKBsBd0AMpalVZUyZ
         WWbKDM/d9AzhxlyyMES44Pvbdk+0e/WLkv2Eg4+rFDeBfY6VXPxvFuKRqud/CfvA3hj1
         vih7P7aQe/xYGGwXBYQM5lRuj6kSXSpjt5VY0U/G4ynIjP41UJJ7E2Np3Ce4L3F9SM3c
         HoW9eu++sWT4KzIbY+qTZkjqLZa75h1gbTtevY60X64nMEzg++xGlr5ZlS7yrbmszlq5
         ixwRqRciY9N2EDWvZ6j/Lh4iWobEj2/4+GMPMsVuunIMKxKeVGJcsFIj+BFRN59KBqfQ
         ZUsg==
X-Forwarded-Encrypted: i=1; AJvYcCXPdtvy5U0gnKmYsrPlSOQO/yMLuww8a83XbYugOhEfqIpGFX4fo8O4BRACyAt0fn2CKw5Si8z5s5dXNC9grg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMLWVAq2D4SY2G0NJXoZrQ7DJRrRacffSGKCJWcNbcKAzY1g8S
	80WxWzdnJW6IgCF9XIY+q8IkVOknSV+Ljdo4/IdbI6sw9Zh2/Vxl48ODayQgJTxNQ1o+Y+8Mzmd
	Wk+bAnd+VO0A4CZ0WVJKWF/lflixvfr2RG+ATAYO/p63ODYQabCQa/k2WjHmGP1vDrQx1
X-Gm-Gg: ASbGnctwTCR0XvG5tH8K0P0V93iPVEn/hL2ZHbp4C5y9SfVxNvoomllBfYkT59h6NyD
	BWsk3JbC2C4IcSze0pIf0Xf105dRbrF0N2Pcwk5zFcJLHepAIWlex2Tib057pCwA7LO8y8gP0nq
	bUWZq9Z2qfz3lASuUXiut65bz5ZnZIqMBZ1Xu3VMMrvcRg3CZW+eGj1Uy3z79VxEIAaU6nM7rPI
	WBHtsCiKJy83D9qiRflEeVUA3lHaHtfzYEtu+LjPN25yok8rElbSVcjXmNz4Y+FKG1dy4wdyF/4
	qunxxZD9ThLWF7WWhWSuqQJ2mpzF
X-Received: by 2002:a5d:5888:0:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3b1ff42f9b6mr2955389f8f.22.1751473722730;
        Wed, 02 Jul 2025 09:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH509kf9vFGj6z4R6xZfwGPmfKpg2fLP7ZQfSUt7IFbDwWC1CAH/5JCS3EUz2u2b0JuI21xGg==
X-Received: by 2002:a5d:5888:0:b0:3a4:d0ed:257b with SMTP id ffacd0b85a97d-3b1ff42f9b6mr2955367f8f.22.1751473722074;
        Wed, 02 Jul 2025 09:28:42 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.130.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c8esm16610161f8f.55.2025.07.02.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:28:41 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:28:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 3/8] vsock/virtio: Move length check to callers of
 virtio_vsock_skb_rx_put()
Message-ID: <g3h6k6vqfxwqsvojptaqy63qsn2vwo7i45segjgwjgmotysmwr@dmgbwacytag7>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-4-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701164507.14883-4-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hqK15TQp74e9RS3SLqNDRPB1fPX5KLPhgCLDem2rxC4_1751473723
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 05:45:02PM +0100, Will Deacon wrote:
>virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
>packet header is not zero even though skb_put() handles this case
>gracefully.
>
>Remove the functionally redundant check from virtio_vsock_skb_rx_put()
>and, on the assumption that this is a worthwhile optimisation for
>handling credit messages, augment the existing length checks in
>virtio_transport_rx_work() to elide the call for zero-length payloads.
>Note that the vhost code already has similar logic in
>vhost_vsock_alloc_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> include/linux/virtio_vsock.h     | 4 +---
> net/vmw_vsock/virtio_transport.c | 4 +++-
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 36fb3edfa403..eb6980aa19fd 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -52,9 +52,7 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> 	u32 len;
>
> 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>-
>-	if (len > 0)
>-		skb_put(skb, len);
>+	skb_put(skb, len);

Since the caller is supposed to check the len, can we just pass it as 
parameter?

So we can avoid the `le32_to_cpu(virtio_vsock_hdr(skb)->len)` here.

Thanks,
Stefano

> }
>
> static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index bd2c6aaa1a93..488e6ddc6ffa 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -656,7 +656,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>-			virtio_vsock_skb_rx_put(skb);
>+			if (payload_len)
>+				virtio_vsock_skb_rx_put(skb);
>+
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

