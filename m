Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9822DFB5
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573381; cv=none; b=lVML9jmTDKfJCCY3dO/5vVfQuHdGJr53n7wIEMZ1JIumaBxVUmjB2NVbQcwbWuC7jNeFQQyAZjduu9OOXwWn+NK2MvugB7zFzz1Yj5f8Ti4P4OTFCkcqYD5p4OQlJtWyZVCqINZ3Y5XY7LZb2Rx1ZurF9leh23T+B2l9x73Mhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573381; c=relaxed/simple;
	bh=MJi+etYdzWp9bbuS3/ZtoZpHvZ+o85wo5Ie6Vrai3Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kdW1j1ByL98DGAw/5Qfp7hsoYp5PT+Pgh65M7GZxzbT98COPOVaOVyKVM5zmcZPXBJfK0vG+ncQ/1dyxBmzis1BBSHeaphB1uwTOfA34+YdMtRgcHpRFRyNX9t4tVqUvPzu24frboXS98jw6IB6A8Mw0jNP+pyDsULgVzhbQwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFDkf9Kk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFDkf9Kk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2FJHrc9DBBnLku6YbG4qZNKfRKciZ4CloiHEsZ1eSA=;
	b=hFDkf9KkV927fDa+b+SJEckQ9Hbb7lTRM+X1WEP1spTSb6mzBCpgbp23db1Lop6fjk9yGW
	TlYHP2/7lpUfMrcR2qdi+PiJkRGoDLqrCEqG4zHocJ/WU+QKl8dX5e6xRVsmjgYpmQcyuD
	3tHpFsGrY6541/dJy1fZJoX2pPMO0Cc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-X5xLWAH7NOq969MAhTQOMQ-1; Tue, 15 Jul 2025 05:56:17 -0400
X-MC-Unique: X5xLWAH7NOq969MAhTQOMQ-1
X-Mimecast-MFC-AGG-ID: X5xLWAH7NOq969MAhTQOMQ_1752573377
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fabd295d12so86224906d6.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 02:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573377; x=1753178177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2FJHrc9DBBnLku6YbG4qZNKfRKciZ4CloiHEsZ1eSA=;
        b=rrgkHhfjxLKacSq4GKygUSO0hjNvfNSL9QBjVMphTUeLUWsGoxvbK3NpRZClzuVN0w
         RquEwYi/yGtmO4OaeE23OME8YtITTQ8iHJGf0yYWVPFbwNi05OP35FZ/AecEujZcfXkf
         b/4KrkxDVW6sC/QxRTcmNy4krcvOrcXA//9eObYIbrXkCjBJJqMDDVOP6hshqKH0SFoH
         8PKGK9X9e/IB3KcDpy5o1G5aRFPs4zgl8s7NPwQfhzSbydg3sLL7NFP75U96dN8YLB10
         E77y91OPTA+yZLNU2kVDPP1/Z1wUiASbE9XOIrv2k+99DKfca+D9C66uq5R1/6B75Lkr
         K5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVkpAAqwlox8rShCN8uEnoLzsQV0ITSnjE4bTtc9YR1794cRPte9BAUJTnG5WvncQn5/F9e6bMn9iDbzjBSoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ/t4SgYp8fRqos45mmBKmvgonuUPWFDYSnlXGKw/uvF7zdeP9
	Oxe+KGGttYq2SpuwFgNAD9BfOjX5ycUYd0k/ayRS6or/br/JvKkmlhcTJDbfvxzgjeCQ7FF7d15
	w0nMxVTY3yl1mcbp0xDZCleFo80WdUP14iZkCDNJ7jj3tgtpUntlQKqxZpqNG6Br/dpxS
X-Gm-Gg: ASbGncuCZxibo65mAMWxlvpHNp64pUywgEAiXBgERPU4zimR72TAgAr6mvWt3SxY9jN
	IR4SS2LTTkQPWfIe9fLbmMetZugY7AClt0dA/zke+FbuYYbXWhbipkvxYl8tofdbr5TQmA1iQOn
	NuumX6NsaG/3Cr+aiJYDGV2b+07i+tnJw7ahr9eWdj2khH3dlCobpJaPMARHHtmy9SvAtjIzfO9
	etH57iIAXlA97pVscYNjnVlbhK1mnW6e2xALjlpTuV0YRPtLnlOjiuoISHt6KNmwNM39Tm6nmy1
	WxOv/I44RbdnlQIdXrVVfBkgsIAzSFT1W4QyKfRZqQ==
X-Received: by 2002:ad4:5d48:0:b0:702:c140:b177 with SMTP id 6a1803df08f44-704a6f0a0bfmr299514796d6.8.1752573376901;
        Tue, 15 Jul 2025 02:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHncLWJlra3O9RCPuPRVNz4dTmRyr/J1M2mv3kg+JaRnitmozIljcP/8mhgPfagbomiL7D0Dw==
X-Received: by 2002:ad4:5d48:0:b0:702:c140:b177 with SMTP id 6a1803df08f44-704a6f0a0bfmr299514466d6.8.1752573376483;
        Tue, 15 Jul 2025 02:56:16 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049775443esm56373906d6.0.2025.07.15.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:56:15 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:56:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 4/9] vsock/virtio: Resize receive buffers so that each
 SKB fits in a 4K page
Message-ID: <i5gsr2exiuhxdupdpbypr5mph3mbd2rfwdwxbg77kcclih2ffd@k5o7dwo3q2pw>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-5-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-5-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kzIVIZ20aTEQ1mknLQcR41xPgtqrKf2dE7MOnVWgrO8_1752573377
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:20:58PM +0100, Will Deacon wrote:
>When allocating receive buffers for the vsock virtio RX virtqueue, an
>SKB is allocated with a 4140 data payload (the 44-byte packet header +
>VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
>overhead, the resulting 8KiB allocation thanks to the rounding in
>kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
>higher-order page allocation on systems with 4KiB pages just for the
>sake of a few hundred bytes of packet data.
>
>Limit the vsock virtio RX buffers to 4KiB per SKB, resulting in much
>better memory utilisation and removing the need to allocate higher-order
>pages entirely.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> include/linux/virtio_vsock.h     | 7 ++++++-
> net/vmw_vsock/virtio_transport.c | 2 +-
> 2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 97465f378ade..879f1dfa7d3a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -106,7 +106,12 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>+/* Dimension the RX SKB so that the entire thing fits exactly into
>+ * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>+ * rounding up to the next page order and also means that we
>+ * don't leave higher-order pages sitting around in the RX queue.
>+ */
>+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
> #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
> #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1af7723669cb..5416214ae666 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -307,7 +307,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>
> static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> {
>-	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
>+	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> 	struct scatterlist pkt, *p;
> 	struct virtqueue *vq;
> 	struct sk_buff *skb;
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

