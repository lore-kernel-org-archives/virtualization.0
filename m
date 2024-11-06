Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E14208202
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917452; cv=none; b=JI05M4/0plpnIksJiPxro87ERAesginvosrslXTydJy6u/LBWZPnioOdPhJcGSJB/GiO/htLJikigqrmmThIlpe/acaIkfBK0rCpdcp1vqENHOC/wO7MAa2xF8GemllTDE61BYavUdLc+z6KhWJFLvhq8850pVjiQzjYJONWh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917452; c=relaxed/simple;
	bh=7JRzx1UgEQQWBP6Jr+1QV83wR6xUeWOjkJYXM4uWv3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgCzjoCHTOKRM8ROAVdA6bsYh4Yo6EAK1YJzWn3CVXHzR8/ld6LDxuSR3cfuuvs1ZpjgsiDS336NT+cQUM4Bn8dIrhzeG3YgPcAzbxi1nFZ6cXyBK19++7TXOswXrvlytwLY1s04+nmaS4NN1R5f6cbIYNSb4AwrjPfQpRxM+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=k3pff0QC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="k3pff0QC"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t8kCT-00FDuf-B3; Wed, 06 Nov 2024 18:52:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=LBac3zL9ZPZQLfgdHj+CoiRzpyIdxumYQNZim816CMc=; b=k3pff0QC4zOecxiIeK12Ts7Hgb
	174ZP04mieJ5KwiHE3EvQe2BG+/CuMM/xqsYHt/QTtivl3wNTqOafKT6w+3OhZOaKPku7zzDASJek
	30JO8LHkUWL2DL0BMZVf6ZIW5U0soIr1ZvrIxHlXJzCBnnJC6bJuE0ZomoJ+Z+FsZ16t1LPvWTet2
	dWnxd50XuejmChBQVP+hh6mde3j7nvQAeEzl7ElNyUvZIDhdl+87X+7mHn6TM8zNj0Hzasa829ZZG
	1S4XQ1ZDlSlH4MuVlMv2CsfPdtn+dnfP1BTg/UoFLVYCdnFnTXv5D75pNZ9+9qEt5mrKUk8LSLCml
	964E/QuA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t8kCS-0001o6-Lh; Wed, 06 Nov 2024 18:52:13 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t8kCH-002ver-Vw; Wed, 06 Nov 2024 18:52:02 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 06 Nov 2024 18:51:18 +0100
Subject: [PATCH net 1/4] virtio/vsock: Fix accept_queue memory leak
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-vsock-mem-leaks-v1-1-8f4ffc3099e6@rbox.co>
References: <20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co>
In-Reply-To: <20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jia He <justin.he@arm.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
 George Zhang <georgezhang@vmware.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

As the final stages of socket destruction may be delayed, it is possible
that virtio_transport_recv_listen() will be called after the accept_queue
has been flushed, but before the SOCK_DONE flag has been set. As a result,
sockets enqueued after the flush would remain unremoved, leading to a
memory leak.

vsock_release
  __vsock_release
    lock
    virtio_transport_release
      virtio_transport_close
        schedule_delayed_work(close_work)
    sk_shutdown = SHUTDOWN_MASK
(!) flush accept_queue
    release
                                        virtio_transport_recv_pkt
                                          vsock_find_bound_socket
                                          lock
                                          if flag(SOCK_DONE) return
                                          virtio_transport_recv_listen
                                            child = vsock_create_connected
                                      (!)   vsock_enqueue_accept(child)
                                          release
close_work
  lock
  virtio_transport_do_close
    set_flag(SOCK_DONE)
    virtio_transport_remove_sock
      vsock_remove_sock
        vsock_remove_bound
  release

Introduce a sk_shutdown check to disallow vsock_enqueue_accept() during
socket destruction.

unreferenced object 0xffff888109e3f800 (size 2040):
  comm "kworker/5:2", pid 371, jiffies 4294940105
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
  backtrace (crc 9e5f4e84):
    [<ffffffff81418ff1>] kmem_cache_alloc_noprof+0x2c1/0x360
    [<ffffffff81d27aa0>] sk_prot_alloc+0x30/0x120
    [<ffffffff81d2b54c>] sk_alloc+0x2c/0x4b0
    [<ffffffff81fe049a>] __vsock_create.constprop.0+0x2a/0x310
    [<ffffffff81fe6d6c>] virtio_transport_recv_pkt+0x4dc/0x9a0
    [<ffffffff81fe745d>] vsock_loopback_work+0xfd/0x140
    [<ffffffff810fc6ac>] process_one_work+0x20c/0x570
    [<ffffffff810fce3f>] worker_thread+0x1bf/0x3a0
    [<ffffffff811070dd>] kthread+0xdd/0x110
    [<ffffffff81044fdd>] ret_from_fork+0x2d/0x50
    [<ffffffff8100785a>] ret_from_fork_asm+0x1a/0x30

Fixes: 3fe356d58efa ("vsock/virtio: discard packets only when socket is really closed")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ccbd2bc0d2109aea4f19e79a0438f85893e1d89c..cd075f608d4f6f48f894543e5e9c966d3e5f22df 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1512,6 +1512,14 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return -ENOMEM;
 	}
 
+	/* __vsock_release() might have already flushed accept_queue.
+	 * Subsequent enqueues would lead to a memory leak.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		virtio_transport_reset_no_sock(t, skb);
+		return -ESHUTDOWN;
+	}
+
 	child = vsock_create_connected(sk);
 	if (!child) {
 		virtio_transport_reset_no_sock(t, skb);

-- 
2.46.2

