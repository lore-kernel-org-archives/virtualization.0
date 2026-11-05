Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836929;
	b=hFhGaBB4RNC//EdDLS1KBpPg2rli7Udel9yAz2Z1N8O1NgDqXuZ4V9Jlgv4CLdQDQiUr
	 noaew908MTE/HoZI1kaTCHiz/4vYZ2jylneydi9U+wP3XQ28P/VKOK8fmF22BcJe/qhGE
	 Tf/8Tx1UN8TyVY7+VwkyWs2BtlNvXavX5aqiKPMyYIHUTUk9hmSvqBIhZ3iujz5GcWPPK
	 VnWOvm9dWUf+iD87xf9q2cBMcvJ3PEcuLQ+/YwS4cGgln4fU71hw+PHDB/q6NykYpQQZa
	 QsU89bfcD0tebOoGd+LFVxGkYaYgpyuYCDJ8IC03Q0t7m34ZLF9UThoUhBhDIrAFMwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836929;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=gvXZud60WW8KOHt3CUZkR9JbkQ/A5YVK6z5NEHxZryM=;
	b=LMY4rsOS8ZFZmBFUeh4EP5vLF7XNOz7lduqnkHk0gc0itoQFp8tGnCALYS+tQRKG9FxE
	 vKjE4FA0PhoLwTkDrKnN7U5/drmm9fCsyoP8kH+M4jli3GfvoLVgEOfWlOh1CsCTQTqCz
	 YkZA0piEApXnMLiWc8qyxskUfERiBdWmLzxIcn2gLzGggnh60dIDUzyseBOBOUBASygiw
	 F5w8HCcj/4p7bmGjpLde8fh0wfQoq/mxtQJv3nBc3pExee/U3E2jCfdLVmTiZDBZ6evAG
	 tCpHq6Tss0IjfiDHJli1KIfsJSnsw4GBNRY8pwFCeMT0fEk2s6oV5SDUrdYiU5gt1rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linuxhacker.ru;
	spf=none smtp.mailfrom=linuxhacker.ru;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F7606A33A
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 336F7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxhacker.ru
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id BAE43BEE69;
	Thu,  5 Nov 2026 00:02:04 +0000 (UTC)
From: Oleg Drokin <green@linuxhacker.ru>
To: sgarzare@redhat.com,
	stefanha@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] vsock/virtio: bound the send credit by bytes not yet consumed by the transport
Date: Wed,  4 Nov 2026 19:01:40 -0500
Message-ID: <20261105000141.3617241-3-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105000141.3617241-1-green@linuxhacker.ru>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The send credit is

    min(peer_buf_alloc, buf_alloc) - (tx_cnt - peer_fwd_cnt)

where peer_fwd_cnt is taken unchecked from every header the peer sends.
A peer that never consumes what it is sent but keeps reporting
fwd_cnt == tx_cnt gets unlimited credit: every send() is accepted and
the skbs pile up in the transport's queue (on a host, vhost's
send_pkt_queue, for a guest that posts no rx buffers). The skbs are
GFP_KERNEL allocations charged to no memory cgroup. The peer learns
tx_cnt easily when the host side relays a stream it also controls.

Commit 8ee784fdf006 ("vsock/virtio: cap TX credit to local buffer size")
bounded peer_buf_alloc, but not peer_fwd_cnt.

bytes_unsent (maintained for SIOCOUTQ) counts what was handed to the
transport and not yet consumed by the device. It is local knowledge, so
bounding it by the same window limits a lying peer to one window of
queued data per socket.

For an honest peer, bytes_unsent can exceed tx_cnt - peer_fwd_cnt only
by data the peer already has but the transport has not yet released:

 - on a host, the delivered part of an skb that vhost splits across rx
   buffers smaller than the skb: the peer acknowledges the pieces, but
   bytes_unsent drops only once the whole skb is delivered, so at most
   one skb (64 KiB);
 - in a guest, tx buffers the host has consumed but
   virtio_transport_tx_work() has not reaped yet: vhost passes the
   packet to the host socket before it marks the buffer used, so the
   host's credit update can arrive first.

Either way the window shrinks only until the transport catches up;
nothing stalls and nothing changes on the wire. The writer is woken when
bytes_unsent drops (sock_wfree() calls sk_write_space()).

With a user-space vhost-vsock "guest" that posts no rx buffers and
acknowledges everything, one host socket queued 256 MiB in under 2 s
(SIOCOUTQ 268304384, where the test stops); with this patch it stays at
one window (SIOCOUTQ 262144).

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e762a480df4..74a8fdf825d5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1031,14 +1031,17 @@ EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
 
 static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 {
+	s64 tx_buf_size = virtio_transport_tx_buf_size(vvs);
 	s64 bytes;
 
 	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
 	 * does not underflow.
 	 */
-	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
-		(vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = tx_buf_size - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+
+	/* peer_fwd_cnt is peer-controlled, bytes_unsent is not. */
+	bytes = min_t(s64, bytes, tx_buf_size - (s64)vvs->bytes_unsent);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.56.0

