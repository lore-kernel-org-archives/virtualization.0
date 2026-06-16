Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC1421890;
	Tue, 16 Jun 2026 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603517; cv=none; b=T+889f6CswXvBWeie/ACL4NL7WgJbKlF6pcQdE+SnbefzoAFYGWJQpYVWc8FE7NCcaDi7pf6W0FQRTJoiPBgvFA8aQtdkrsNQnl7yhHd8cCPOSg3GBaODw5pIgH+i+3T4B+h8S5nYnS0GKXHJklQ3ogAa2W9KiFMftWJj4jeGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603517; c=relaxed/simple;
	bh=U8HwN3VYMDd5bskXM/9sH9FJg9WoMPOOFDfyLp7dUpg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O1LPOIGs6GtQV1FTr1fT9KwTy589cgTkTP7U38Y3KDZG5kWSQiaG6SRJNMtCMicXhoEoVm2rFmDRvORMmtX8Sdmt9Ae20wnt+g2mz1au/1iO+XQiB7Tx9PF9PzuFoP8cNnhPG/5gxJHdKQNKTftURXNKSX2X2QwMZ/ywwd9I7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yaogdgup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yaogdgup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7D71F000E9;
	Tue, 16 Jun 2026 09:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781603516;
	bh=pORy1EHAh/iOic1inn0t5fryP6v6Gu5VxDw8ZFRK/Jk=;
	h=Subject:To:Cc:From:Date;
	b=YaogdgupEC7WoerDqABfMJASDnY7oK2l5seFFJAt/eZW9C3YVHT5Kh9Cl9nTVwAdw
	 pYEAOqv2j/jF2mBb6B1iOSn0P8hw1vhuF5BpJe1ZNucW7Dyk55Nc/vk7d9vsA9lCVn
	 G2KbWJplwA8xCuSTh7W7ge9hmXIeocy+4K6y6hnU=
Subject: Patch "vsock/virtio: fix potential unbounded skb queue" has been added to the 6.18-stable tree
To: AVKrasnov@sberdevices.ru,edumazet@google.com,eperezma@redhat.com,gregkh@linuxfoundation.org,jasowang@redhat.com,kuba@kernel.org,mst@redhat.com,sgarzare@redhat.com,stefanha@redhat.com,virtualization@lists.linux.dev,xuanzhuo@linux.alibaba.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Jun 2026 15:20:50 +0530
Message-ID: <2026061650-appealing-lubricant-c11e@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    vsock/virtio: fix potential unbounded skb queue

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     vsock-virtio-fix-potential-unbounded-skb-queue.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 059b7dbd20a6f0c539a45ddff1573cb8946685b5 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 12:26:52 +0000
Subject: vsock/virtio: fix potential unbounded skb queue
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5 upstream.

virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.

virtio_transport_recv_enqueue() skips coalescing for packets
with VIRTIO_VSOCK_SEQ_EOM.

If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
a very large number of packets can be queued
because vvs->rx_bytes stays at 0.

Fix this by estimating the skb metadata size:

	(Number of skbs in the queue) * SKB_TRUESIZE(0)

Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -425,7 +425,9 @@ static int virtio_transport_send_pkt_inf
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->buf_used + len > vvs->buf_alloc)
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+
+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;


Patches currently in stable-queue which might be from edumazet@google.com are

queue-6.18/ipv6-sit-reload-inner-ipv6-header-after-gso-offloads.patch
queue-6.18/ieee802154-6lowpan-only-accept-ipv6-packets-in-lowpa.patch
queue-6.18/udp-clear-skb-dev-before-running-a-sockmap-verdict.patch
queue-6.18/inet-frags-fix-use-after-free-caused-by-the-fqdir_pre_exit-flush.patch
queue-6.18/net-add-pskb_may_pull-to-skb_gro_receive_list.patch
queue-6.18/net-sched-act_api-use-rcu-with-deferred-freeing-for-.patch
queue-6.18/ip6_vti-fix-incorrect-tunnel-matching-in-vti6_tnl_lo.patch
queue-6.18/tcp-restrict-so_attach_filter-to-priv-users.patch
queue-6.18/vsock-virtio-fix-potential-unbounded-skb-queue.patch
queue-6.18/ipv6-mcast-fix-use-after-free-when-processing-mld-queries.patch
queue-6.18/ip6_vti-set-netns_immutable-on-the-fallback-device.patch
queue-6.18/rxrpc-fix-the-ack-parser-to-extract-the-sack-table-for-parsing.patch
queue-6.18/ipv4-restrict-ipopt_ssrr-and-ipopt_lsrr-options.patch
