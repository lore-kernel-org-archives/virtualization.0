Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F90635
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730775; cv=none; b=re2J3HQ07FEDR6uH30y8VGdzuLjyREvwz6luIhl+4HLaSpWFSD9zwfR7yBBZSR13xJm08W3dS1UPfH9LpdRbaHDkPA8PO/CwNONY9LwN6gTTqGyiF08bugXpCjWEsb56Ub5rfwLDQ7dW1ppq73/ldOOzw/rHxZqZ1GtC8YCHtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730775; c=relaxed/simple;
	bh=8xTFfl67wIQOufxQ/XTxHmawmYTtXy92FH7wmrqBR60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Se5Iy+wOYjxfLQJcRv2n13HkiFnLpYO7IiAwNMsaPhLP5Z/HoMf5qxINjqVpioCBEg/oc7ucbxSOWESefscckDLv7luI3xhkPjdwXmXcgkpgbIKzpkeBaSD+tlO2PiTwI8r50REF8NUdibSkahwSH+DyVlEKhIRr4u/6ReMM6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/I3lHaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/I3lHaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747730772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOPxyI8xvsODmW2CXsEeAiOYmTmUpftyoQUfAgolB4o=;
	b=g/I3lHaqgMkL95SxwMON+Yb930f53bDS3ZSrZYvwNKTlrCFzdHtTf7BXzJRVPl/eRUFIWp
	gkUP1tFS7muVSY21D5+8ZzzICYlpQgLPwxfjmNxoRn54wWwmKWihOWW1WczX6o1GCD05eW
	vK8tyxgRX8rrmWkhKyP9PzaAqeI8AHo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-C1-RjievPr2RaJqZhe5ttw-1; Tue, 20 May 2025 04:46:11 -0400
X-MC-Unique: C1-RjievPr2RaJqZhe5ttw-1
X-Mimecast-MFC-AGG-ID: C1-RjievPr2RaJqZhe5ttw_1747730770
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acf00f500d2so100038966b.2
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 01:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747730770; x=1748335570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOPxyI8xvsODmW2CXsEeAiOYmTmUpftyoQUfAgolB4o=;
        b=mFXQUtaovjqZsMfKK6jVHyFL+3ycDQXY2CGLPKx+oF4OI5dh2Etre3p8XwSSiqQk8a
         qEYJ2/gVstXiiDf/2c3xYPfu4WYgQASHmH8bN0u5brAUo3jQcgwegzP76TX5nNVSl8MI
         hWwh2M/eEpdR2HOj681C6XTQPnl8K0tj+bAHhE94+fcqucwkEr9FzaORvAF4JUV5S7Zk
         f7Ora1PzMYV0MyMMHv5y7aXGUzUMBUBHV6xZxSyT/00PStAH3xSBel5eNgR2aWRjg2DU
         1WFO9xaoSOstpz9J5RogE0iBzKjisJEBpbg70P/O+V91g/XasaskusNzsRHNdCFp/HgL
         i8tw==
X-Forwarded-Encrypted: i=1; AJvYcCXVdiNiApVJ91A1gv0QDHo5GrlrWOZt1a0V5a9kdi4gnWdxbFKOhTLS8vJlMSyFhN8+SsGMFQzpyN/Q8PzGRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxfw37DV646yAFLTie/6L60PUPEhBUUX0mnak4jjZHUROYIjsD+
	r42ZafnT887ylBnUJSJG+Wpej3yQFTzI2ey4aGEYCdgT/JMncc/DZEq2bgX2rTdJogAdNhWtyyv
	6TfGP5mtpL93FOtOBjDBig4hDnS1D/QO7qLOPvmJi4fqbu8ZHyr8cTyIGCZCX6yrjXXBR
X-Gm-Gg: ASbGncuUAr/GFJjGnml06CXmBU2Ef6UHYWVCl/nWYxZikw2BmXtbaYXNwYtx4J788uH
	CGmpNUV8jvlq2bY1W9QOy8SAxQi2H8GC43LhmM5DzcfFj/B+2zBcDLeECDL0XVB5nTJUOK/NEEL
	3t3hXsSzwX01ZCljNZ8sFOHH3LHcFkWQIpeqSNu8tYI+ORjyzNVTur+ZNE22mPvGUzVocgk8TUN
	u9LyFzX7MzJIG2nJWnotbrzQXCzyWP5lMscfQMu/30G6bm+CeYj4IdsLmGwXR6GSn45OZgCTsID
	2h0zxi/XFqaAt9Rp1xo8W7q+uzZbpoUqR7UK57sI03Pg6QXQnZEqjKjZp+3O
X-Received: by 2002:a17:907:d8b:b0:ad5:719d:3e88 with SMTP id a640c23a62f3a-ad5719d5958mr608963266b.44.1747730770004;
        Tue, 20 May 2025 01:46:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhQGUr9rfzMJHGnlV8hllI6xbhRlkYFydEwrW3ZoqExjBDhlLpqKETdyFe+3K/njihrbep/Q==
X-Received: by 2002:a17:907:d8b:b0:ad5:719d:3e88 with SMTP id a640c23a62f3a-ad5719d5958mr608959666b.44.1747730769386;
        Tue, 20 May 2025 01:46:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06dc99sm702438566b.62.2025.05.20.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:46:08 -0700 (PDT)
Date: Tue, 20 May 2025 10:46:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, fupan.lfp@antgroup.com, pabeni@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	stefanha@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH 2/3] vsock/virtio: Add SIOCINQ support for all virtio
 based transports
Message-ID: <ca3jkuttkt3yfdgcevp7s3ejrxx3ngkoyuopqw2k2dtgsqox7w@fhicoics2kiv>
References: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
 <20250519070649.3063874-3-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250519070649.3063874-3-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KmR7UbbjhFfnF4AhIpPfd0XaXPyLvy6dBZ9HN1WG874_1747730770
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 19, 2025 at 03:06:48PM +0800, Xuewei Niu wrote:
>The virtio_vsock_sock has a new field called bytes_unread as the return
>value of the SIOCINQ ioctl.
>
>Though the rx_bytes exists, we introduce a bytes_unread field to the
>virtio_vsock_sock struct. The reason is that it will not be updated
>until the skbuff is fully consumed, which causes inconsistency.
>
>The byte_unread is increased by the length of the skbuff when skbuff is
>enqueued, and it is decreased when dequeued.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> drivers/vhost/vsock.c                   |  1 +
> include/linux/virtio_vsock.h            |  2 ++
> net/vmw_vsock/virtio_transport.c        |  1 +
> net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  1 +
> 5 files changed, 22 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..0f20af6e5036 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -452,6 +452,7 @@ static struct virtio_transport vhost_transport = {
> 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
> 		.unsent_bytes             = virtio_transport_unsent_bytes,
>+		.unread_bytes             = virtio_transport_unread_bytes,
>
> 		.read_skb = virtio_transport_read_skb,
> 	},
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0387d64e2c66..0a7bd240113a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -142,6 +142,7 @@ struct virtio_vsock_sock {
> 	u32 buf_alloc;
> 	struct sk_buff_head rx_queue;
> 	u32 msg_count;
>+	size_t bytes_unread;

Can we just use `rx_bytes` field we already have?

Thanks,
Stefano

> };
>
> struct virtio_vsock_pkt_info {
>@@ -195,6 +196,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
> u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk);
>
> ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk);
>+ssize_t virtio_transport_unread_bytes(struct vsock_sock *vsk);
>
> void virtio_transport_consume_skb_sent(struct sk_buff *skb,
> 				       bool consume);
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..917881537b63 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -585,6 +585,7 @@ static struct virtio_transport virtio_transport = {
> 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
> 		.unsent_bytes             = virtio_transport_unsent_bytes,
>+		.unread_bytes             = virtio_transport_unread_bytes,
>
> 		.read_skb = virtio_transport_read_skb,
> 	},
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7f7de6d88096..11eae88c60fc 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -632,6 +632,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	free_space = vvs->buf_alloc - fwd_cnt_delta;
> 	low_rx_bytes = (vvs->rx_bytes <
> 			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>+	vvs->bytes_unread -= total;
>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>@@ -782,6 +783,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 		}
>
> 		virtio_transport_dec_rx_pkt(vvs, pkt_len);
>+		vvs->bytes_unread -= pkt_len;
> 		kfree_skb(skb);
> 	}
>
>@@ -1132,6 +1134,19 @@ ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_unsent_bytes);
>
>+ssize_t virtio_transport_unread_bytes(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	size_t ret;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+	ret = vvs->bytes_unread;
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_unread_bytes);
>+
> static int virtio_transport_reset(struct vsock_sock *vsk,
> 				  struct sk_buff *skb)
> {
>@@ -1365,6 +1380,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 		goto out;
> 	}
>
>+	vvs->bytes_unread += len;
>+
> 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> 		vvs->msg_count++;
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 6e78927a598e..13a77db2a76f 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -99,6 +99,7 @@ static struct virtio_transport loopback_transport = {
> 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
> 		.unsent_bytes             = virtio_transport_unsent_bytes,
>+		.unread_bytes             = virtio_transport_unread_bytes,
>
> 		.read_skb = virtio_transport_read_skb,
> 	},
>-- 
>2.34.1
>

