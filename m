Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0199CC46467
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 16:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A21A417A7;
	Tue, 10 Jan 2023 16:04:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A21A417A7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F75OgL0M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KD9nYmK3y8uE; Tue, 10 Jan 2023 16:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2C9A41719;
	Tue, 10 Jan 2023 16:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2C9A41719
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87428C0033;
	Tue, 10 Jan 2023 16:04:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 475F4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D5E841719
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:04:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D5E841719
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-7VSVjxf0tD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:04:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F1D041703
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F1D041703
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673366670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+UQWuQQ2hWnb94auPrEHg5V/et7HlWjToWuHhMbff+8=;
 b=F75OgL0MWjyCUt7C1hrt+ByxCcl4KfnxAIkhfz9kS/m8vPzUfmXfyajeINRZygziUShfm7
 hPhxzH7DyxMcMyxI2r0cqTAa0ZJE/+lYY14hoh11Ec/7YKiss4XQdyxCbJV2SEA96U/PYL
 6iwpoY7z6wxLARjaSa/n8lrYuAAUUj4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-RAYcIA9KNjugcemx9v26IQ-1; Tue, 10 Jan 2023 11:04:28 -0500
X-MC-Unique: RAYcIA9KNjugcemx9v26IQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-46839d9ca5dso132329307b3.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UQWuQQ2hWnb94auPrEHg5V/et7HlWjToWuHhMbff+8=;
 b=0rEkZej26ra4hp5u0l1LarTwyoEN/mJmw4BbftGDJXMoVkIxkNHnm+SgmCPwQxqR3x
 sdjHgQeSZvS/5n4v3d5jYTncVyZ+IkCN6W6qBexnXA+3Rx6TrpR/bDNFiqMZezcqEkNL
 LYF2Smxn6w3h7gqh4Os/qx/RrgzrA7EwblBHnTYKAxgrYjwCU9hQ1jS2DclSygQwvZDf
 0QhuLyRe1r/l8G1sur/NFshYrNBzxXggjOjNB48FClC0IO7RGNT6OlTfe//dS8BTNSyb
 ZQo/3nRgqIhdoBn0WvroSMzLDCIJBm2d23TkKxZ5DCtF/mro4DuOhV63hBgxAVax7M9X
 Cd9A==
X-Gm-Message-State: AFqh2kpaUNDcxm1WgGtClgxXayihwktyQfIXfhqNeWrZUdMaIXkOOVb6
 Qm+AWJBy7lypCAeCIXlCVj8HWvQ929hgdm2jzRiT+mg751ta1jQuYgKwLRNfkJk7sLQkvxIMOqh
 ga4zTkvMzDgOjPwC4lZTj9FLPKq/oDExJVoMHRRj1ng==
X-Received: by 2002:a05:7500:2848:b0:ea:624a:f66c with SMTP id
 cu8-20020a057500284800b000ea624af66cmr4098557gab.20.1673366666891; 
 Tue, 10 Jan 2023 08:04:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtpjpPgCmxtMTiVhV00hjC5xRZqmPfZ5kHxv53zvfvuP9p+ucazHavv1bC+fFn2+lO53a2eUg==
X-Received: by 2002:a05:7500:2848:b0:ea:624a:f66c with SMTP id
 cu8-20020a057500284800b000ea624af66cmr4098511gab.20.1673366666192; 
 Tue, 10 Jan 2023 08:04:26 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it.
 [79.46.200.244]) by smtp.gmail.com with ESMTPSA id
 u6-20020a05620a0c4600b007054feab4aesm7344844qki.27.2023.01.10.08.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 08:04:25 -0800 (PST)
Date: Tue, 10 Jan 2023 17:04:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v9] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20230110160420.gbrr33g4guntxenm@sgarzare-redhat>
References: <20230107002937.899605-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230107002937.899605-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Jan 07, 2023 at 12:29:37AM +0000, Bobby Eshleman wrote:
>This commit changes virtio/vsock to use sk_buff instead of
>virtio_vsock_pkt. Beyond better conforming to other net code, using
>sk_buff allows vsock to use sk_buff-dependent features in the future
>(such as sockmap) and improves throughput.
>
>This patch introduces the following performance changes:
>
>Tool/Config: uperf w/ 64 threads, SOCK_STREAM
>Test Runs: 5, mean of results
>Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
>
>Test: 64KB, g2h
>Before: 21.63 Gb/s
>After: 25.59 Gb/s (+18%)
>
>Test: 16B, g2h
>Before: 11.86 Mb/s
>After: 17.41 Mb/s (+46%)
>
>Test: 64KB, h2g
>Before: 2.15 Gb/s
>After: 3.6 Gb/s (+67%)
>
>Test: 16B, h2g
>Before: 14.38 Mb/s
>After: 18.43 Mb/s (+28%)
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Acked-by: Paolo Abeni <pabeni@redhat.com>
>---
>
>Tested using vsock_test g2h and h2g.  I'm not sure if it is standard
>practice here to carry Acks and Reviews forward to future versions, but
>I'm doing that here to hopefully make life easier for maintainers.
>Please let me know if it is not standard practice.
>
>Changes in v9:
>- check length in rx header
>- guard alloactor from small requests
>- squashed fix for v8 bug reported by syzbot:
>    syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com
>
>Changes in v8:
>- vhost/vsock: remove unused enum
>- vhost/vsock: use spin_lock_bh() instead of spin_lock()
>- vsock/loopback: use __skb_dequeue instead of skb_dequeue
>
>Changes in v7:
>- use skb_queue_empty() instead of skb_queue_empty_lockless()
>
>Changes in v6:
>- use skb->cb instead of skb->_skb_refdst
>- use lock-free __skb_queue_purge for rx_queue when rx_lock held
>
>Changes in v5:
>- last_skb instead of skb: last_hdr->len = cpu_to_le32(last_skb->len)
>
>Changes in v4:
>- vdso/bits.h -> linux/bits.h
>- add virtio_vsock_alloc_skb() helper
>- virtio/vsock: rename buf_len -> total_len
>- update last_hdr->len
>- fix build_skb() for vsockmon (tested)
>- add queue helpers
>- use spin_{unlock/lock}_bh() instead of spin_lock()/spin_unlock()
>- note: I only ran a few g2h tests to check that this change
>  had no perf impact. The above data is still from patch
>  v3.
>
>Changes in v3:
>- fix seqpacket bug
>- use zero in vhost_add_used(..., 0) device doesn't write to buffer
>- use xmas tree style declarations
>- vsock_hdr() -> virtio_vsock_hdr() and other include file style fixes
>- no skb merging
>- save space by not using vsock_metadata
>- use _skb_refdst instead of skb buffer space for flags
>- use skb_pull() to keep track of read bytes instead of using an an
>  extra variable 'off' in the skb buffer space
>- remove unnecessary sk_allocation assignment
>- do not zero hdr needlessly
>- introduce virtio_transport_skb_len() because skb->len changes now
>- use spin_lock() directly on queue lock instead of sk_buff_head helpers
>  which use spin_lock_irqsave() (e.g., skb_dequeue)
>- do not reduce buffer size to be page size divisible
>- Note: the biggest performance change came from loosening the spinlock
>  variation and not reducing the buffer size.
>
>Changes in v2:
>- Use alloc_skb() directly instead of sock_alloc_send_pskb() to minimize
>  uAPI changes.
>- Do not marshal errors to -ENOMEM for non-virtio implementations.
>- No longer a part of the original series
>- Some code cleanup and refactoring
>- Include performance stats
>
> drivers/vhost/vsock.c                   | 215 +++++-------
> include/linux/virtio_vsock.h            | 129 ++++++--
> net/vmw_vsock/virtio_transport.c        | 149 +++------
> net/vmw_vsock/virtio_transport_common.c | 422 +++++++++++++-----------
> net/vmw_vsock/vsock_loopback.c          |  51 +--
> 5 files changed, 500 insertions(+), 466 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index cd6f7776013a..1f6542c7070b 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -51,8 +51,7 @@ struct vhost_vsock {
> 	struct hlist_node hash;
>
> 	struct vhost_work send_pkt_work;
>-	spinlock_t send_pkt_list_lock;
>-	struct list_head send_pkt_list;	/* host->guest pending packets */
>+	struct sk_buff_head send_pkt_queue; /* host->guest pending packets */
>
> 	atomic_t queued_replies;
>
>@@ -108,40 +107,33 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 	vhost_disable_notify(&vsock->dev, vq);
>
> 	do {
>-		struct virtio_vsock_pkt *pkt;
>+		struct virtio_vsock_hdr *hdr;
>+		size_t iov_len, payload_len;
> 		struct iov_iter iov_iter;
>+		u32 flags_to_restore = 0;
>+		struct sk_buff *skb;
> 		unsigned out, in;
> 		size_t nbytes;
>-		size_t iov_len, payload_len;
> 		int head;
>-		u32 flags_to_restore = 0;
>
>-		spin_lock_bh(&vsock->send_pkt_list_lock);
>-		if (list_empty(&vsock->send_pkt_list)) {
>-			spin_unlock_bh(&vsock->send_pkt_list_lock);
>+		spin_lock_bh(&vsock->send_pkt_queue.lock);
>+		skb = __skb_dequeue(&vsock->send_pkt_queue);
>+		spin_unlock_bh(&vsock->send_pkt_queue.lock);

Can we use virtio_vsock_skb_dequeue() here?

>+
>+		if (!skb) {
> 			vhost_enable_notify(&vsock->dev, vq);
> 			break;
> 		}
>
>-		pkt = list_first_entry(&vsock->send_pkt_list,
>-				       struct virtio_vsock_pkt, list);
>-		list_del_init(&pkt->list);
>-		spin_unlock_bh(&vsock->send_pkt_list_lock);
>-
> 		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
> 					 &out, &in, NULL, NULL);
> 		if (head < 0) {
>-			spin_lock_bh(&vsock->send_pkt_list_lock);
>-			list_add(&pkt->list, &vsock->send_pkt_list);
>-			spin_unlock_bh(&vsock->send_pkt_list_lock);
>+			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> 			break;
> 		}
>
> 		if (head == vq->num) {
>-			spin_lock_bh(&vsock->send_pkt_list_lock);
>-			list_add(&pkt->list, &vsock->send_pkt_list);
>-			spin_unlock_bh(&vsock->send_pkt_list_lock);
>-
>+			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> 			/* We cannot finish yet if more buffers snuck in while
> 			 * re-enabling notify.
> 			 */
>@@ -153,26 +145,27 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		}
>
> 		if (out) {
>-			virtio_transport_free_pkt(pkt);
>+			kfree_skb(skb);
> 			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
> 			break;
> 		}
>
> 		iov_len = iov_length(&vq->iov[out], in);
>-		if (iov_len < sizeof(pkt->hdr)) {
>-			virtio_transport_free_pkt(pkt);
>+		if (iov_len < sizeof(*hdr)) {
>+			kfree_skb(skb);
> 			vq_err(vq, "Buffer len [%zu] too small\n", iov_len);
> 			break;
> 		}
>
> 		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
>-		payload_len = pkt->len - pkt->off;
>+		payload_len = skb->len;
>+		hdr = virtio_vsock_hdr(skb);
>
> 		/* If the packet is greater than the space available in the
> 		 * buffer, we split it using multiple buffers.
> 		 */
>-		if (payload_len > iov_len - sizeof(pkt->hdr)) {
>-			payload_len = iov_len - sizeof(pkt->hdr);
>+		if (payload_len > iov_len - sizeof(*hdr)) {
>+			payload_len = iov_len - sizeof(*hdr);
>
> 			/* As we are copying pieces of large packet's buffer to
> 			 * small rx buffers, headers of packets in rx queue are
>@@ -185,31 +178,30 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			 * bits set. After initialized header will be copied to
> 			 * rx buffer, these required bits will be restored.
> 			 */
>-			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
>-				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
>+				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
> 				flags_to_restore |= VIRTIO_VSOCK_SEQ_EOM;
>
>-				if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
>-					pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+				if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR) {
>+					hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
> 					flags_to_restore |= VIRTIO_VSOCK_SEQ_EOR;
> 				}
> 			}
> 		}
>
> 		/* Set the correct length in the header */
>-		pkt->hdr.len = cpu_to_le32(payload_len);
>+		hdr->len = cpu_to_le32(payload_len);
>
>-		nbytes = copy_to_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
>-		if (nbytes != sizeof(pkt->hdr)) {
>-			virtio_transport_free_pkt(pkt);
>+		nbytes = copy_to_iter(hdr, sizeof(*hdr), &iov_iter);
>+		if (nbytes != sizeof(*hdr)) {
>+			kfree_skb(skb);
> 			vq_err(vq, "Faulted on copying pkt hdr\n");
> 			break;
> 		}
>
>-		nbytes = copy_to_iter(pkt->buf + pkt->off, payload_len,
>-				      &iov_iter);
>+		nbytes = copy_to_iter(skb->data, payload_len, &iov_iter);
> 		if (nbytes != payload_len) {
>-			virtio_transport_free_pkt(pkt);
>+			kfree_skb(skb);
> 			vq_err(vq, "Faulted on copying pkt buf\n");
> 			break;
> 		}
>@@ -217,31 +209,28 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		/* Deliver to monitoring devices all packets that we
> 		 * will transmit.
> 		 */
>-		virtio_transport_deliver_tap_pkt(pkt);
>+		virtio_transport_deliver_tap_pkt(skb);
>
>-		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
>+		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> 		added = true;
>
>-		pkt->off += payload_len;
>+		skb_pull(skb, payload_len);
> 		total_len += payload_len;
>
> 		/* If we didn't send all the payload we can requeue the packet
> 		 * to send it with the next available buffer.
> 		 */
>-		if (pkt->off < pkt->len) {
>-			pkt->hdr.flags |= cpu_to_le32(flags_to_restore);
>+		if (skb->len > 0) {
>+			hdr->flags |= cpu_to_le32(flags_to_restore);
>
>-			/* We are queueing the same virtio_vsock_pkt to handle
>+			/* We are queueing the same skb to handle
> 			 * the remaining bytes, and we want to deliver it
> 			 * to monitoring devices in the next iteration.
> 			 */
>-			pkt->tap_delivered = false;
>-
>-			spin_lock_bh(&vsock->send_pkt_list_lock);
>-			list_add(&pkt->list, &vsock->send_pkt_list);
>-			spin_unlock_bh(&vsock->send_pkt_list_lock);
>+			virtio_vsock_skb_clear_tap_delivered(skb);
>+			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> 		} else {
>-			if (pkt->reply) {
>+			if (virtio_vsock_skb_reply(skb)) {
> 				int val;
>
> 				val = atomic_dec_return(&vsock->queued_replies);
>@@ -253,7 +242,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 					restart_tx = true;
> 			}
>
>-			virtio_transport_free_pkt(pkt);
>+			consume_skb(skb);
> 		}
> 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> 	if (added)
>@@ -278,28 +267,26 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
> }
>
> static int
>-vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
>+vhost_transport_send_pkt(struct sk_buff *skb)
> {
>+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct vhost_vsock *vsock;
>-	int len = pkt->len;
>+	int len = skb->len;
>
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
>+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
> 	if (!vsock) {
> 		rcu_read_unlock();
>-		virtio_transport_free_pkt(pkt);
>+		kfree_skb(skb);
> 		return -ENODEV;
> 	}
>
>-	if (pkt->reply)
>+	if (virtio_vsock_skb_reply(skb))
> 		atomic_inc(&vsock->queued_replies);
>
>-	spin_lock_bh(&vsock->send_pkt_list_lock);
>-	list_add_tail(&pkt->list, &vsock->send_pkt_list);
>-	spin_unlock_bh(&vsock->send_pkt_list_lock);
>-
>+	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
> 	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
>
> 	rcu_read_unlock();
>@@ -310,10 +297,8 @@ static int
> vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> {
> 	struct vhost_vsock *vsock;
>-	struct virtio_vsock_pkt *pkt, *n;
> 	int cnt = 0;
> 	int ret = -ENODEV;
>-	LIST_HEAD(freeme);
>
> 	rcu_read_lock();
>
>@@ -322,20 +307,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 	if (!vsock)
> 		goto out;
>
>-	spin_lock_bh(&vsock->send_pkt_list_lock);
>-	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
>-		if (pkt->vsk != vsk)
>-			continue;
>-		list_move(&pkt->list, &freeme);
>-	}
>-	spin_unlock_bh(&vsock->send_pkt_list_lock);
>-
>-	list_for_each_entry_safe(pkt, n, &freeme, list) {
>-		if (pkt->reply)
>-			cnt++;
>-		list_del(&pkt->list);
>-		virtio_transport_free_pkt(pkt);
>-	}
>+	cnt = virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
>
> 	if (cnt) {
> 		struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
>@@ -352,12 +324,14 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 	return ret;
> }
>
>-static struct virtio_vsock_pkt *
>-vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
>+static struct sk_buff *
>+vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		      unsigned int out, unsigned int in)
> {
>-	struct virtio_vsock_pkt *pkt;
>+	struct virtio_vsock_hdr *hdr;
> 	struct iov_iter iov_iter;
>+	struct sk_buff *skb;
>+	size_t payload_len;
> 	size_t nbytes;
> 	size_t len;
>
>@@ -366,50 +340,49 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
>-	if (!pkt)
>+	len = iov_length(vq->iov, out);
>+
>+	/* len contains both payload and hdr */
>+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>+	if (!skb)
> 		return NULL;
>
> 	len = iov_length(vq->iov, out);

Can this line be removed? (as it was in the previous version)
It seems unnecessary since we are reading it a few lines above.

> 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
>
>-	nbytes = copy_from_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
>-	if (nbytes != sizeof(pkt->hdr)) {
>+	hdr = virtio_vsock_hdr(skb);
>+	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
>+	if (nbytes != sizeof(*hdr)) {
> 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
>-		       sizeof(pkt->hdr), nbytes);
>-		kfree(pkt);
>+		       sizeof(*hdr), nbytes);
>+		kfree_skb(skb);
> 		return NULL;
> 	}
>
>-	pkt->len = le32_to_cpu(pkt->hdr.len);
>+	payload_len = le32_to_cpu(hdr->len);
>
> 	/* No payload */
>-	if (!pkt->len)
>-		return pkt;
>+	if (!payload_len)
>+		return skb;
>
>-	/* The pkt is too big */
>-	if (pkt->len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
>-		kfree(pkt);
>+	/* The pkt is too big or the length in the header is invalid */
>+	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>+	    payload_len > len) {

Should we also consider the header?
I mean something like this:
             payload_len + sizeof(*hdr) > len

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
