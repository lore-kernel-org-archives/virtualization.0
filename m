Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F5495508;
	Fri, 15 May 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858517; cv=none; b=ucE32IqpWdepOMqETK/Ug0OiwIWcTX1M2ePifkFuWweIVWnlb4PBqgKQ+ORkF5ECgkLGSGeQlSefnCtIoGZwuz2wjIeIKUf31+lIhA8CC5z0XYfaouGuvaN6W3dnO53FMY9PbAWOc4YEwt5ukPBcIhHXKzGDZNgM3LfvkKvs87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858517; c=relaxed/simple;
	bh=7SBXD7B50cHDAkxRq5IleKTgbEVZ99E4nNX15mGG1zg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KCuguj+NZrayzbti3/ndLHATSkTNCbUeYB7pQ849bnKrZpSpi91w9nxpbahOI9OKaNw1bZhSJflcikOFyPNSfcM4siFPzz/WwSJ90lzNDtBTU4xjrx0GOw6NJHTuTe49QfeIMXRU4a+WyZEewFy1nnRMpxS9tCtln2RBIs1GqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yxTaf85A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yxTaf85A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B19C2BCB0;
	Fri, 15 May 2026 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778858517;
	bh=7SBXD7B50cHDAkxRq5IleKTgbEVZ99E4nNX15mGG1zg=;
	h=Subject:To:Cc:From:Date:From;
	b=yxTaf85AVhXZVSlk8tBP+9jaDr1A7q0uBV3S1n5gV3OKedRdVQtIb1GgPvH8mD3C3
	 Phaix741S4rns/jalLW8uqwQpmRy9prwT0qK3bbYTVyM7jRtURT4RNyGuCJCLttYV3
	 KXTaDrx7gsCxfdKeUfNT1NWPDYwuPt75C41SviuQ=
Subject: Patch "vsock/virtio: fix potential unbounded skb queue" has been added to the 6.6-stable tree
To: AVKrasnov@sberdevices.ru,edumazet@google.com,eperezma@redhat.com,gregkh@linuxfoundation.org,jasowang@redhat.com,kuba@kernel.org,leonardi@redhat.com,mst@redhat.com,sgarzare@redhat.com,stefanha@redhat.com,virtualization@lists.linux.dev,xuanzhuo@linux.alibaba.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 17:21:53 +0200
Message-ID: <2026051553-santa-unretired-a417@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     vsock-virtio-fix-potential-unbounded-skb-queue.patch
and it can be found in the queue-6.6 subdirectory.

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
[LL: Fixed conflict since this tree does not use buf_used added by commit
 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/virtio_transport_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_inf
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->rx_bytes + len > vvs->buf_alloc)
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+
+	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;


Patches currently in stable-queue which might be from edumazet@google.com are

queue-6.6/net-fix-icmp-host-relookup-triggering-ip_rt_bug.patch
queue-6.6/tcp-call-sk_data_ready-after-listener-migration.patch
queue-6.6/net-sched-sch_red-replace-direct-dequeue-call-with-peek-and-qdisc_dequeue_peeked.patch
queue-6.6/ip6_gre-use-cached-t-net-in-ip6erspan_changelink.patch
queue-6.6/vsock-virtio-fix-potential-unbounded-skb-queue.patch
