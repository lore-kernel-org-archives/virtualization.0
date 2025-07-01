Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FB1946AA
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397246; cv=none; b=oX8nSetabe5jK/PFcy/LI+DzWmInAdpB8427iJ3/jHh0gZTCY2c+e6gBQDi6rIsv2DK8j/UWmhUYO9nYPdDCfgXoMmSqfw+rHP5zcAmtQdaOySae8igzEci8nq6oA91BIIuKvreg2rKk7s3xlPFvKgNII0MById622DZBMFW0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397246; c=relaxed/simple;
	bh=4Rr5RDJD2k8VW/HH+xcrwUxWOxdEDKOztvVdojYX7xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSRn+zjbhSovRfscyNMbhPeOS1uvVfjH9eMdbx4C2tPZF0YD9udqXbu68L+ghS9zCgxPUp6+bq/WcK/3LqvQbAvW46CfYD7/it0Ni4QnFHn78gcEe+HZAVCrM2XulfAsJjfKFrXFMAJaiCmCnI0vG/zUm3wcFwaNuq7SJ9V4ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldrpjwhq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldrpjwhq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a575a988f9so3977231f8f.0
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397243; x=1752002043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRAT6iMVdZZIF+G8MBWdHZBgavvJ5RJLj6iKsHMAdfE=;
        b=ldrpjwhq028xkFXpul5+5YCpXeF4mxpR7Jl/rP7QlnnGAPsB96TuVVytPYfnvcevsY
         O2WIwHBhnyWQr1GIaKFonJgsd+f54zZtBAxpiIfGq8OHrYefOGy3VGoJ1T0YDDMdnEq/
         O9euXLHj6egLHq9k/5tWefmHknD6FU7gmE8NENFc3Ua13BD7c8yMkcSxlOlCIzXmxAui
         iW7+0zVPmgqgU9jetd868HOGiib/uWxVMtnjXp0C2w3z37ZCeevvW0f14a3IEavq94Dc
         1DwuEvXO3MDdFynoe2y2c03viPbBqwSgnc/XjZQRSiIU6EEJDZH96iHShqio+R45RZYO
         Gc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397243; x=1752002043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRAT6iMVdZZIF+G8MBWdHZBgavvJ5RJLj6iKsHMAdfE=;
        b=ULQkUmjqw2QRKlZyZ4CEfcevX4OBcZ3Kc1CVAFqzpjJwp1bjjckkR48bV2emUKbJNA
         B21e9IS1ERe+tgCSHu7bDeIiwNteqkIPzkoXoumNte1NyFkKPdcFgCMubIkqC2ibR2Uk
         AmPulfuNpoo0Q6AjpSlHANM7mA89/GumtIODV5cGOgaEDKWSCJut9HrreJ8gk/YFe2tK
         dtpdeb+7NVS+gE9G7Ktr4zArX1EIm0L7VZYlAdre18upwQCPkOj1/8A2aWfQKhtuNB2u
         dH9kyj8g6hDWVYfE33n20Hb6OoGYOpD4Hll2PCzp+MWnoh1f2kHSoQ+c8ZliigBf0irw
         XONA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVWNEe8lIzgvzCSYWn6tq1ZfouJaiR076d3pySe/MOs7UqoYuIkgiKtGvedt2q2dzqXNMszS7vRKYO7rZhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2s7XYn+FozcLE5Xl/jxiFeEe1fsI2VxFlxxOvDiqAnOSJ5R6R
	oC2ZlWFHTqFEYW7WiHyrHn2Ini+wmHkEZiBUq94R7HBHGE1Y4EzjCS7t
X-Gm-Gg: ASbGncsBNYDg6wNIRPkG+h0LbqZu2oQ93sau7j7dF8wdeXKTQ8WTf6KFlNLzeDx5lFt
	BNUJz3YBJgJRYTecqWrwXsAEvmG5iLfBqsTwWmOPyRiPnpvXW34OyteGYrbnFlR7Uxt16bd+GSd
	Xbkzqlnw/g1VGsXwEkhFInX6nXVNOe93WhRRrhrWLDl1SJjNoQeVTn6+UNkERLhjoQt+jdEZxQT
	QRPQ/1PnhT+ns9WiAV5G7tZMCQVF/Q4T0lg7QVhR9QVOQJz47COKFbm+7qGsWkoh0rM83Yq9H7y
	vhx6G5RHbW8KqEga6oQmLJut1M9frYdhgTRIGp5J1c2SfVApzjtVSAzBtGBH2AiBFiRlEht5LEX
	t7hDGoaT6QC9n19/ZAw==
X-Google-Smtp-Source: AGHT+IEKI/YCYtufBuGYyN654gnbiKtO4OJiT+a1rYiFQFL//Efs4Zhe4rDt90TqgDTijo7rz+z8LA==
X-Received: by 2002:a5d:5f4b:0:b0:3a5:2848:2e78 with SMTP id ffacd0b85a97d-3a8ffbd4cffmr17167671f8f.28.1751397242504;
        Tue, 01 Jul 2025 12:14:02 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm204864645e9.20.2025.07.01.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:14:02 -0700 (PDT)
Date: Tue, 1 Jul 2025 20:14:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, Steven
 Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 4/8] vsock/virtio: Resize receive buffers so that
 each SKB fits in a page
Message-ID: <20250701201400.52442b0e@pumpkin>
In-Reply-To: <20250701164507.14883-5-will@kernel.org>
References: <20250701164507.14883-1-will@kernel.org>
	<20250701164507.14883-5-will@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Jul 2025 17:45:03 +0100
Will Deacon <will@kernel.org> wrote:

> When allocating receive buffers for the vsock virtio RX virtqueue, an
> SKB is allocated with a 4140 data payload (the 44-byte packet header +
> VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
> overhead, the resulting 8KiB allocation thanks to the rounding in
> kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
> higher-order page allocation for the sake of a few hundred bytes of
> packet data.
> 
> Limit the vsock virtio RX buffers to a page per SKB, resulting in much
> better memory utilisation and removing the need to allocate higher-order
> pages entirely.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/virtio_vsock.h     | 1 -
>  net/vmw_vsock/virtio_transport.c | 7 ++++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index eb6980aa19fd..1b5731186095 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -109,7 +109,6 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
>  	return (size_t)(skb_end_pointer(skb) - skb->head);
>  }
>  
> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>  #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
>  #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>  
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 488e6ddc6ffa..3daba06ed499 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -307,7 +307,12 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>  
>  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>  {
> -	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
> +	/* Dimension the SKB so that the entire thing fits exactly into
> +	 * a single page. This avoids wasting memory due to alloc_skb()
> +	 * rounding up to the next page order and also means that we
> +	 * don't leave higher-order pages sitting around in the RX queue.
> +	 */
> +	int total_len = SKB_WITH_OVERHEAD(PAGE_SIZE);

Should that be an explicit 4096?
Otherwise it is very wasteful of memory on systems with large pages.

	David

>  	struct scatterlist pkt, *p;
>  	struct virtqueue *vq;
>  	struct sk_buff *skb;

