Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602248;
	b=GpRiOoktJ1v7lVtSYXIYfdaJ6VYycENupjnHP4UtM2i7w6wnSqhCgkZ8JpTqyK9Mksyu
	 BLHBb0Si8BylvoPUYPVEW5iaM9o9Qqed/2tQS5aj1SUDC8l76cFVFDM4GHNZncI71D7Vb
	 n5E1yyLkAZ1CosBg60vLLKKhNLCUh2a0C6eXsTr3KnWFZShJv9YiXvmnOG0zf1FPJkpzN
	 UBzpKLantxAZ8hQUj4ULTUZKqONoS/+Hw7hRqlgflO5+wx9tzdrwpHiOT6jHxjGLVQ5zI
	 Sj6U2KJcsv0y316I4gM/KKTQWsr1yZRZWW8mbsD2oH1yOU4x72vDMBAhPHYRDupmVIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602248;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Qofc/C3ulxNQPffK4mS2418qbHbzkMfHjhjhVdFF1AY=;
	b=V/dNkTxyKXZyAWVQ2dJrVBt4b9FI2sg7+NAR3lbWVbOkTWCyD0O/2ABdwptuJ6WgjNeV
	 MT75WehO0ozatG2H2KTs0fdTVSoCsvaZkj1Bdn26HRRAJmYCe9Wud+LFg5S6aAFsbR8Ff
	 FSiIZ0VRYPlaF8ndo6X8JYEFXFQJKxgu/jisGF/ewSPBO0lrYfOfMzDQi9MuZFkgXbC71
	 7qpkv8gaD3eRI19boAt8eYrujWkuDrxLGHUznIX++uiVAfJaXCxkFsc272DTNNOe3LgOf
	 Pxm2k86/4s6hEpIuWUYXQdcPxmyeqxv4/jTrkZ5efWIsPCbg0I5f8KxK4veYAGWYxhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IU2w1HmK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7B606A31F
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 17:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C7B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IU2w1HmK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792602246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qofc/C3ulxNQPffK4mS2418qbHbzkMfHjhjhVdFF1AY=;
	b=IU2w1HmK2HI5Po45pvt67nBdMmzEbGpuEe6WIYFT9XcWOlsRZv9XvEux6dS6jGgtBFaOXm
	MQOP4JI/XnbRIACkli9joGAJiPc4vPAeyqFgtpTBwqo4NjZpFhJJ8cqC/Z7yCXeePeh4dX
	JjA8A/TpeJuzCm6yOIR7yooylxx06NE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-3rSwQoFXOpuDbxCnWaEfyw-1; Wed, 21 Oct 2026 17:04:05 +0000
X-MC-Unique: 3rSwQoFXOpuDbxCnWaEfyw-1
X-Mimecast-MFC-AGG-ID: 3rSwQoFXOpuDbxCnWaEfyw_1792602244
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso660736f8f.3
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 10:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602244; x=1793207044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qofc/C3ulxNQPffK4mS2418qbHbzkMfHjhjhVdFF1AY=;
        b=qHopIJENHPZtoLKQD9Tg9/ejSP1RQqzvrNgOVDJtf6Svzh7bXuue/SZivHSgy2YN/X
         7iTunv1YSzM1jlpJVfvNYXl/ewY9opUlSA1eji83CSyJBC0iU58DIAwv0SlU6iuGhQBQ
         LC2CBMMofqutrAGwHYofT7jSQyfjxD5V/Y1M4BgDHTRnse96FqYaf20SsCB8sh2Mk3nK
         D6BzWYdZS340IVC2vkHoHlIuzJHNOlSloUOg5YunVwuR/Wg/lUR1Juj5AWSZWTj2Hjjh
         WkTJS6uPJMgRY7AXjP57gnMuI+dFfHe4kihib3s1c5tUvMr3FKdejh0+zZwU3PBhLZHb
         I21g==
X-Forwarded-Encrypted: i=1; AKwUvBxRVhdoUp8ygjHZ+kzYxCIz4WbSZf3L+Crmui30I2DGK8JhETKBY3isXht8OaDka+mtB90leGUN0+CgjKKUNw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKOyL8JrBGVY0vYa3QYf8/XzR9vHIUpA8SWdZI6wbZljUJGhJts
	EeNp5Hzo3kRIwrN5caxetMItK12kuML+1CMrafQj63GgPPu8zWmu0GEjH31/5WgF/gQ8h8EX8Sl
	DZX5lgS034yCD/tk7+uitfTdvcEhuATpQRjzJvScTHeVb++wrar0FeFMMoWg7RXxoXIx4
X-Gm-Gg: AYBFou2tiRY6nkjTejbvW9KUkHK9OF+JrOgXohVrb7kKyfM6eB20DHFiRP/H9WD3+fm
	NvI62mJi/auwK0i9hzxocv4ZH/novBrrS9nLSnmNUbqug8EiJGHxbXFjyRKDJ9l5hVIFIFb1Ecd
	9eTtajBRt1Q5Ff4X/83C4b1NB1jusqkOCVGV+fwB7cykDlvBh3IFUa0BMvfGEsTHtVa2auaVjZ2
	vVbZeab7V9ctyn9OKWWRmiiCUMvv+j+LUn5Iolm28NLF7/ca8P8exGXjTnUgoC0A1t8w+v2v2wj
	ai1tYM27i7hxb/XVQ1EAoBZ6R4MTQn63IOoWKK7ZF8pubk1UO/W6o8LzL1eG+31nqVTUbJnWu07
	rsV3KxQ==
X-Received: by 2002:a05:600c:c16e:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a1fdd2aa12mr60550975e9.12.1792602244046;
        Wed, 21 Oct 2026 10:04:04 -0700 (PDT)
X-Received: by 2002:a05:600c:c16e:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-4a1fdd2aa12mr60550105e9.12.1792602243508;
        Wed, 21 Oct 2026 10:04:03 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.143.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a350b0sm6349215e9.9.2026.10.21.10.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:04:02 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:03:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 5/7] vsock/virtio: support guest device
 network namespace
Message-ID: <atjvzn-zPYJjLAhy@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-5-047527cfccfc@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261020-vsock-guest-ns-v4-5-047527cfccfc@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UNgKWhfZoIHI3dEWADEusAFyRjelKdZkV2_uvHx5HL8_1792602244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Oct 20, 2026 at 06:15:08PM -0700, Bobby Eshleman wrote:
>virtio-vsock did not have namespace support (the device was always
>accessible to any global namespace).
>
>Make the virtio-vsock device assignable to a namespace and initialize it
>to init_net. Because virtio-vsock and init_net are both hardcoded to
>global mode, nothing changes until the assign command is issued.
>
>An assign can land while virtio_transport_rx_work() is draining a
>batch, so the assigned namespace is re-read per packet rather than once
>per batch. Matching the rest of the batch against the namespace the
>device has left would reset connections that belong to the new one.
>
>When a device is assigned to a namespace, every already established
>vsock socket that is no longer able to reach the device is forcibly
>closed. For that reason, adding new sockets to the connected table must
>be performed atomically with regards to namespace assignment. This
>ensures that when the socket is added to the connected table that it
>actually passes the new reachability conditions set by ns assignment. If
>it wins the race to the table and does NOT pass the reachability tests,
>then it will be reset. This is the purpose of the new helper
>'vsock_maybe_set_connected()'.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v4:
>- Drop packets in virtio_transport_send_pkt() from a netns that cannot
>  reach the device, e.g. shutdown() or credit updates on a swept socket
>  (Sashiko)
>
>Changes in v3:
>- Re-read the assigned netns per packet in virtio_transport_rx_work()
>  rather than once per batch, so a mid-batch assign cannot reset the new
>  namespace's connections (Sashiko)
>- Drop the NULL netns reset in virtio_transport_rx_work(), the assigned
>  netns is now pinned
>- Drop the .reset op and the virtio_transport_reset{,_no_sock}() exports,
>  the sweep no longer sends a RST (Sashiko)
>
>Changes in v2:
>- Export virtio_transport_reset(), wire it to the new .reset op (Stefano)
>- netns_assign_allow is now a bool (Stefano)
>- Pass NULL, not &init_net, in virtio_transport_rx_work(), and
>  comment why (Stefano)
>- Drop the if (net) guard around put_net() (Stefano)
>- Drop the comments at the vsock_maybe_set_connected() call sites,
>  the commit msg seems sufficient
>---
> net/vmw_vsock/virtio_transport.c        | 32 +++++++++++++++++++++++++++-----
> net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++-----
> 2 files changed, 40 insertions(+), 10 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index eced6929405d..06df82b130cf 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -256,6 +256,15 @@ virtio_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		goto out_rcu;
> 	}
>
>+	/* A socket reset by an assign can still send credit updates from
>+	 * recvmsg() and setsockopt(SO_RCVLOWAT).
>+	 */
>+	if (!vsock_g2h_net_reachable(net)) {
>+		kfree_skb(skb);
>+		len = -ENETUNREACH;
>+		goto out_rcu;
>+	}
>+
> 	/* If send_pkt_queue is empty, we can safely bypass this queue
> 	 * because packet order is maintained and (try) to put the packet
> 	 * on the virtqueue using virtio_transport_send_skb_fast_path.
>@@ -542,7 +551,7 @@ static bool virtio_transport_msgzerocopy_allow(void)
>
> bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
> {
>-	return vsock_net_mode_global(vsk);
>+	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
> }
>
> static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
>@@ -587,6 +596,7 @@ static struct virtio_transport virtio_transport = {
> 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>
> 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
>+		.netns_assign_allow       = true,
>
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
>@@ -616,7 +626,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> 	struct virtio_vsock *vsock;
> 	bool seqpacket_allow;
>
>-	if (!vsock_net_mode_global(vsk))
>+	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
> 		return false;
>
> 	seqpacket_allow = false;
>@@ -633,7 +643,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
> {
> 	struct virtio_vsock *vsock =
> 		container_of(work, struct virtio_vsock, rx_work);
>+	struct virtio_transport *t = &virtio_transport;
>+	netns_tracker ns_tracker;
> 	struct virtqueue *vq;
>+	struct net *net;
>+
>+	net = vsock_g2h_net_get(&ns_tracker);
>
> 	mutex_lock(&vsock->rx_lock);
>
>@@ -682,10 +697,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
>
> 			virtio_transport_deliver_tap_pkt(skb);
>
>-			/* Force virtio-transport into global mode since it
>-			 * does not yet support local-mode namespacing.
>+			/* Only grab a reference if the net changes underneath
>+			 * us.
> 			 */
>-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
>+			if (unlikely(!vsock_g2h_net_eq(net))) {
>+				put_net_track(net, &ns_tracker);
>+				net = vsock_g2h_net_get(&ns_tracker);
>+			}
>+
>+			virtio_transport_recv_pkt(t, skb, net);
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>
>@@ -694,6 +714,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 		virtio_vsock_rx_fill(vsock);
> out_nofill:
> 	mutex_unlock(&vsock->rx_lock);
>+
>+	put_net_track(net, &ns_tracker);
> }
>
> static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1e762a480df4..0c864db2bc65 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1478,9 +1478,13 @@ virtio_transport_recv_connecting(struct sock *sk,
>
> 	switch (le16_to_cpu(hdr->op)) {
> 	case VIRTIO_VSOCK_OP_RESPONSE:
>-		sk->sk_state = TCP_ESTABLISHED;
>+		if (!vsock_maybe_set_connected(vsk)) {
>+			skerr = ECONNRESET;
>+			err = -ENETUNREACH;
>+			goto destroy;
>+		}
>+
> 		sk->sk_socket->state = SS_CONNECTED;
>-		vsock_insert_connected(vsk);
> 		sk->sk_state_change(sk);
> 		break;
> 	case VIRTIO_VSOCK_OP_INVALID:
>@@ -1736,8 +1740,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>
> 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
>
>-	child->sk_state = TCP_ESTABLISHED;
>-
> 	vchild = vsock_sk(child);
> 	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
> 			le32_to_cpu(hdr->dst_port));
>@@ -1758,7 +1760,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	if (virtio_transport_space_update(child, skb))
> 		child->sk_write_space(child);
>
>-	vsock_insert_connected(vchild);
>+	if (!vsock_maybe_set_connected(vchild)) {
>+		release_sock(child);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));

We might be facing the same issue here that we were discussing a few 
days ago in another patch.

I mean, is it correct to send the reset to `sock_net(sk)`?
Or should we use the one of the sender?

Thanks,
Stefano

>+		sock_put(child);
>+		return -ENETUNREACH;
>+	}
>+
> 	vsock_enqueue_accept(sk, child);
> 	virtio_transport_send_response(vchild, skb);
>
>
>-- 
>2.53.0-Meta
>

