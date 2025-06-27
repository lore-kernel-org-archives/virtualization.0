Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3C224893
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021191; cv=none; b=Dw7RXFREarWg+aXAVbjSKfkjsGyCm9AddhRJfR9DhdaUFSN4gRKS2YCnMxY0Pk+hXmtOeDmOblmNwCw1PUi4d31820iUEe+cxXJgck4RL771g4S0BZmfdinsQI4VpkGyV5xtObXzaOUnFyePLl6rmZ9epbnsX4wLMGQ5Y2BvT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021191; c=relaxed/simple;
	bh=H9cfOW7/9BOVcWtdnIje6hKT1HQvPyY4W0Mbubki7jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CSBlqDH3viHo04LjPcnBn5gDHlgYHh9TV+MItP+Sut/HcHjoaaQsaukBRaEUNGBNIn/CdEcAJkvWYpqIMTEj47wzwK0WSr134q+2r3HmMiNYuVYIrViRDXVVrWxJ33rqCBCkACBP4iegzPlG5yCuHsXjX3seN6WPpxPycYGNCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cb49pQZS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cb49pQZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2U6yQaN5C0bZ1f1NN3/TqG5WpiCkSwG+8B6FK7qmmgQ=;
	b=Cb49pQZSy0tNkqKQyYifUqyxSyP8sVFi6cm8Alt9a2+p90aIMlFiU60kjAqyvu0wgQd0qt
	FB646obpbcREM4egv2FFrAZHCP7knygRiVBGCRX0B27SktTeq3wVt9tAS/CgyxSkpAC9bA
	Xeo6hXTqBrYdFO6ofikb1TthUiKkRwU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-P-e4EalSNea5QxNsaxY_WA-1; Fri, 27 Jun 2025 06:46:27 -0400
X-MC-Unique: P-e4EalSNea5QxNsaxY_WA-1
X-Mimecast-MFC-AGG-ID: P-e4EalSNea5QxNsaxY_WA_1751021186
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748fd21468cso1746700b3a.1
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 03:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021186; x=1751625986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U6yQaN5C0bZ1f1NN3/TqG5WpiCkSwG+8B6FK7qmmgQ=;
        b=vmDe1PXXitqqm0p/TyVa3H2uy3eykiPbB5bj2DlLA8v6BVWSleLWHTIBHPW2/MIOEK
         7OQUerFbMO7t6q4iy9NFw+wiILQmcezY5Mg1PTv+rL0wy1ce/OlYPo1lWAKi+/H7Lf/m
         9/NJoGosHGKDVTMBwxXkGvInhBJN6dKZztDMBgUq9nQw3JeadCcR0VY5egiiViI4Hn+6
         hO/7J9trNcYgA0SIeAKrmPHokf4bwAdyOvITcFUCd+KT4XW1QOFDiO7bLiO5O3rmI2jn
         f70gurzU1xzr4ZTW6d3VbvZL5V4SGU6h3vkjfLctE3vZlmzKqO4myCgDzXO29bZrO3md
         hKLg==
X-Forwarded-Encrypted: i=1; AJvYcCUn5EgVliVjrqNJ7CBDYGzPS0JmXP7xf5dVf6TUHE0nPKt3LWyauNSri5nA2umPiRcx17vh3GO2NjNuEjxERw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWlX7Z1ppD0DKv2XE8ErPMi/Rb8lS9IeVDReuXoneuU/C1c8KA
	Iok3G3YugACw0BDuick7wZgMj5YGhw0UQ1ZLP2kLUTYJ0m31W/7DofrACZwoBYBY4stscO0EZMO
	kcI9XVWTNwoyWkD7B7FNxRJCHllVBLj5ZYZ6K2MTF/LRm9ycsMXYZNA9uMtP3jVDOhqNf
X-Gm-Gg: ASbGncsRzMDEhGnhM4lKCzVS8Mw9V+IU26gzFpEgkTY9+7DefUai+eWjSRb1inFCmTH
	esHxqtdpnjBkht9gNAkeI9JrBCG+Ik9uBT67M75ijYqEAzoPtFflN0Da2JNPJvbqKfECVO124po
	RFXHV0TjR/N2lHSb5ErTpkRfefymEUbu2erYWx0WBbfN5uGM/mZn/XZpan4sjLI3OxkzsXpgU1Q
	ju6M0pppTlR9iwKtU21cKEhm2MMSPn1kkrYTbU2j2t+HSM+5MVA9a4ZhhfBnEbXK0+R2iMdgA24
	J61KdD5E8k41KnEaMxdPS4W0rwQ=
X-Received: by 2002:a05:6a00:1a8f:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-74af6fcd495mr4401841b3a.23.1751021185856;
        Fri, 27 Jun 2025 03:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1QscKRumL1vYeE62JJDCxmp5mPz+2z7tzSDNki5kV7FVhY5xV2DPg4aIB+BhjiSrwycgrew==
X-Received: by 2002:a05:6a00:1a8f:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-74af6fcd495mr4401798b3a.23.1751021185441;
        Fri, 27 Jun 2025 03:46:25 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c5837sm2009378b3a.116.2025.06.27.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:46:25 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:46:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 4/5] vsock/virtio: Rename virtio_vsock_skb_rx_put() to
 virtio_vsock_skb_put()
Message-ID: <oxnd4uescl5fhdvkyrhndygud5io7qwwajjg5h2bkmhz5kdhbx@zontoh2qdsuw>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-5-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250625131543.5155-5-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C5qeO0ysRLsB_J6b1IrPKNF4_7pqDQwiPiw-rj6oGe4_1751021186
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 25, 2025 at 02:15:42PM +0100, Will Deacon wrote:
>In preparation for using virtio_vsock_skb_rx_put() when populating SKBs
>on the vsock TX path, rename virtio_vsock_skb_rx_put() to
>virtio_vsock_skb_put().
>
>No functional change.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c            | 2 +-
> include/linux/virtio_vsock.h     | 2 +-
> net/vmw_vsock/virtio_transport.c | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)

LGMT!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index cfa4e1bcf367..3799c0aeeec5 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -380,7 +380,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	virtio_vsock_skb_rx_put(skb);
>+	virtio_vsock_skb_put(skb);
>
> 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
> 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 8f9fa1cab32a..d237ca0fc320 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -47,7 +47,7 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
> 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
> }
>
>-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
>+static inline void virtio_vsock_skb_put(struct sk_buff *skb)
> {
> 	u32 len;
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..3319be2ee3aa 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -648,7 +648,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>-			virtio_vsock_skb_rx_put(skb);
>+			virtio_vsock_skb_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>-- 
>2.50.0.714.g196bf9f422-goog
>
>

