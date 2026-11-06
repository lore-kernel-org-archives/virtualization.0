Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941390;
	b=15tQN/W5So/JdDqZLLsqlOz0SWxdi+hWiJ+S4CkooxM5O4/lQfSs2vnZ5qvOoV9ynDOL
	 fjOJAK4y2UYtccKVPX3NlsB1tYJ2y+IvQkBSvLbEQ3inGV+QfihNXQJJgxInueutFfBEt
	 vt0mJjDCgj6DwwI/PJ2HrGZ9nmw94HQ0kcVZmRmXVHNXx6Ox84t0z6DSmuyKhYHKoE1Cw
	 NJgLqBy2JXL1YOmV+pVf3fb96M7kS1ZeZQCt+cOxa/9ECmPijQcPbwzUEbvOeLkl6Wtwb
	 3uG8AxXlh08DxP0bz7UaWE/TXJ3TWNehYiGLb4zApxvgx4dMHdEOz6yLLYwKAJ1gTOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941390;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LmdTj8g581thkbq3W6hV05B622ecW9OswUVr0f7diMI=;
	b=TtSGcdsBEuPQu72ufDPkpmycrEUghY/MxSH9uWldZFSjxv25cpbKDwA+V+yBEFO2byPI
	 J7vV5AQaV2l+fbZGi7XLloykWNHKDKhDnhJgaCvvIQe1my0fNx4IK/3nnLHcwRYEBmQaS
	 uODwUCh/NlckkX+ncqtI+O4mGsUeaGFd19SFepat8yJC5KYpFnG4iMrNlr5Jr5FRETdcT
	 vhoPZRcaW6kMPl/n01HE76i/eRJGTfxCOibRMVoM+FgAmJBWeDlIDImMeaQI2HWJ/2OEr
	 POkDJ4nNNRiEC2MmSFy5u11CKhpva/PIxs0usttzIkEYi4+58p7ZUzI1v7yAqQuqmpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxhacker.ru;
	spf=pass smtp.mailfrom=linuxhacker.ru;
	dkim=pass header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=fPJnRPDk;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A5C606D807
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 05:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A5C606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=fPJnRPDk
Received: from intelbox1.virtnet (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 965B2BEE69;
	Fri,  6 Nov 2026 05:03:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 eagle.linuxhacker.ru 965B2BEE69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxhacker.ru;
	s=mail; t=1793941388;
	bh=acMYEvEpV8jfvisnvb63rQCzMw51WKbSROFjMmVDins=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPJnRPDk8sveS2rigxh9EIUBYzGo2kNg3EHZjvTkkqBhTj/k1tPNpeN0W9NXP6Uf3
	 cxgYkpQaftFUDsDNX5dC5Q2FUuT9pQ3JpV2eJ84PxRpGdT0gamegSsmmDbeJp4V9q8
	 sIRFCFe4C8QDP6EngQgbuq20hxYZqKdyzQZiT7WjImMAswaW/hasi7Bsv5tEWz/I40
	 nUFtA0Ks1RYTvkAOXhYqkCbwPU83n65/QiCmfttU4bCQZhO6Wt3EcZLBLgsIeZiPiQ
	 lD3RKjw2ctoYITpspevINK9CPuTfSCpmZlluejmVl40Bdd/h07zIk7QhP9RELlZDGB
	 2SsbVKPXEdCjA==
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
Subject: [PATCH net v2 2/3] vsock/virtio: bound the send credit by bytes not yet consumed by the transport
Date: Fri,  6 Nov 2026 00:02:43 -0500
Message-ID: <20261106050244.602625-3-green@linuxhacker.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106050244.602625-1-green@linuxhacker.ru>
References: <20261106050244.602625-1-green@linuxhacker.ru>
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
nothing stalls and nothing changes on the wire. The writer is woken by
sock_wfree() once enough of the queued skbs are freed, as it already is
when credit comes back.

With a user-space vhost-vsock "guest" that posts no rx buffers and
acknowledges everything, one host socket queued 256 MiB in under 2 s
(SIOCOUTQ 268304384, where the test stops); with this patch it stays at
one window (SIOCOUTQ 262144).

Found by an LLM-assisted security review of vhost-vsock, done while
porting a project from Xen to KVM, and reproduced as above.

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

