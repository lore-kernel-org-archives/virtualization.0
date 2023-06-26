Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1AEEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 15:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F06294011A;
	Mon, 26 Jun 2023 15:21:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F06294011A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMz8ke4J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qI8IQjQ-agAt; Mon, 26 Jun 2023 15:21:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6AFB3402E0;
	Mon, 26 Jun 2023 15:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AFB3402E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44E40C0037;
	Mon, 26 Jun 2023 15:20:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15D23C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E496D402E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:20:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E496D402E0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGSRMisxT_1i
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:20:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 085594011A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 085594011A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687792855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HZvpxX10aYP99VlzwnMI/RQCwxTqEDpTN7KDyAKniNg=;
 b=cMz8ke4J0GDr+vL9cCbW4rYbMj3OYNNu/H22P5P3yMtyxeDEIhr6ODt9ozBRoLDWQC6R1g
 z7XP9YVdyEZgqRNd2hGd0/A5v8EtvrH/+mBnjPFJjAxBPqWrD2iVm8N7yHbZuvBTAA5g7o
 usVONZCjGAKey4uee2+tQuD6+1CXoWI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-93T40FPXOoKcqnyrpY6Q1w-1; Mon, 26 Jun 2023 11:20:54 -0400
X-MC-Unique: 93T40FPXOoKcqnyrpY6Q1w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62ff6a6b4f4so35150466d6.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 08:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687792853; x=1690384853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZvpxX10aYP99VlzwnMI/RQCwxTqEDpTN7KDyAKniNg=;
 b=PGyi6ErSYChxWnDJ1VVaBIlSmq40dMWI/aRas4akZpUwbr9NpyIBzLQdjVEUf0IjJv
 s0g4FzBTv7E3Z4t+6olsaWP7Heaf+jPjioEgvTVQ+OEdpM4MudqWsSwxQ6bFZQGGjjM1
 dkWl+o0m3+yf0fX0X6VWawAJYlBudzbJk0KFsSN7/EdzLcV4QXo10T42kq4qdDpN0Ytt
 vjRGcU+fiHqnApM6BoKlQbqVR4OL63FZXTg5FB8cq33mVSppoCD029N4GDHEhT99rqU0
 jjfQXheg4QXvL8sO5xi1XYl8dqLiZk5sBECWXWFYOpUlUl19+WjJWm6/YzaRXOnD1EMW
 ZgIQ==
X-Gm-Message-State: AC+VfDz2u/YUad8w3FIWmzrQQfjQ3t4Qbse9Xs+H6YTW/ODvQonLra6e
 4cJK8S4mom/OxZfHHvaZi2DglLtfs7mL5XbW2qgoDkIQKjCCtibyh27MC25QhEuYm5SBXAJmkrv
 ocwL7+WYW96DbYg8ID5EkPEKwkmCkKH3ZvDOhTkXCbA==
X-Received: by 2002:a05:6214:2486:b0:61a:c2bf:9f0b with SMTP id
 gi6-20020a056214248600b0061ac2bf9f0bmr29907869qvb.6.1687792853647; 
 Mon, 26 Jun 2023 08:20:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79txX5PUlEMmKBylhJEDfi2jPBI2lzhF1I3Y4ASIeZLv/SSsCD6iAI5fZZMX/mtlnCf92x8w==
X-Received: by 2002:a05:6214:2486:b0:61a:c2bf:9f0b with SMTP id
 gi6-20020a056214248600b0061ac2bf9f0bmr29907843qvb.6.1687792853402; 
 Mon, 26 Jun 2023 08:20:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056214030700b0062ff362d87fsm3199090qvu.105.2023.06.26.08.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:20:52 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:20:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 01/17] vsock/virtio: read data from non-linear skb
Message-ID: <tlovtchnzv4sq2dd67jhxpx4eafpwsu6m7hey55xa2broon7i3@2vhzqzqwovfp>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-2-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
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

On Sat, Jun 03, 2023 at 11:49:23PM +0300, Arseniy Krasnov wrote:
>This is preparation patch for non-linear skbuff handling. It replaces
>direct calls of 'memcpy_to_msg()' with 'skb_copy_datagram_iter()'. Main
>advantage of the second one is that is can handle paged part of the skb
>by using 'kmap()' on each page, but if there are no pages in the skb,
>it behaves like simple copying to iov iterator. This patch also adds
>new field to the control block of skb - this value shows current offset
>in the skb to read next portion of data (it doesn't matter linear it or
>not). Idea is that 'skb_copy_datagram_iter()' handles both types of
>skb internally - it just needs an offset from which to copy data from
>the given skb. This offset is incremented on each read from skb. This
>approach allows to avoid special handling of non-linear skbs:
>1) We can't call 'skb_pull()' on it, because it updates 'data' pointer.
>2) We need to update 'data_len' also on each read from this skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 26 +++++++++++++++++--------
> 2 files changed, 19 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c58453699ee9..17dbb7176e37 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -12,6 +12,7 @@
> struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
>+	u32 frag_off;
> };
>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..5819a9cd4515 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -355,7 +355,7 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 	spin_lock_bh(&vvs->rx_lock);
>
> 	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
>-		off = 0;
>+		off = VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>
> 		if (total == len)
> 			break;
>@@ -370,7 +370,10 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 			 */
> 			spin_unlock_bh(&vvs->rx_lock);
>
>-			err = memcpy_to_msg(msg, skb->data + off, bytes);
>+			err = skb_copy_datagram_iter(skb, off,
>+						     &msg->msg_iter,
>+						     bytes);
>+
> 			if (err)
> 				goto out;
>
>@@ -414,24 +417,28 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 		skb = skb_peek(&vvs->rx_queue);
>
> 		bytes = len - total;
>-		if (bytes > skb->len)
>-			bytes = skb->len;
>+		if (bytes > skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off)
>+			bytes = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off;

What about storing `VIRTIO_VSOCK_SKB_CB(skb)->frag_off` in a variable?
More for readability than optimization, which I hope the compiler
already does on its own.

The rest LGTM.

Stefano

>
> 		/* sk_lock is held by caller so no one else can dequeue.
> 		 * Unlock rx_lock since memcpy_to_msg() may sleep.
> 		 */
> 		spin_unlock_bh(&vvs->rx_lock);
>
>-		err = memcpy_to_msg(msg, skb->data, bytes);
>+		err = skb_copy_datagram_iter(skb,
>+					     VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+					     &msg->msg_iter, bytes);
>+
> 		if (err)
> 			goto out;
>
> 		spin_lock_bh(&vvs->rx_lock);
>
> 		total += bytes;
>-		skb_pull(skb, bytes);
>
>-		if (skb->len == 0) {
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += bytes;
>+
>+		if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->frag_off) {
> 			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>
> 			virtio_transport_dec_rx_pkt(vvs, pkt_len);
>@@ -503,7 +510,10 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 				 */
> 				spin_unlock_bh(&vvs->rx_lock);
>
>-				err = memcpy_to_msg(msg, skb->data, bytes_to_copy);
>+				err = skb_copy_datagram_iter(skb, 0,
>+							     &msg->msg_iter,
>+							     bytes_to_copy);
>+
> 				if (err) {
> 					/* Copy of message failed. Rest of
> 					 * fragments will be freed without copy.
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
