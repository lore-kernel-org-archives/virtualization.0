Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6E7EB64DD
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70E9341753;
	Thu,  6 Jul 2023 16:48:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70E9341753
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKK2bspk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3LB4UC35mPuO; Thu,  6 Jul 2023 16:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9821D416D4;
	Thu,  6 Jul 2023 16:48:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9821D416D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AF12C0071;
	Thu,  6 Jul 2023 16:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3B48C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD29560E3C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:47:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD29560E3C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fKK2bspk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RbNksFNSVb5U
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5328860BD8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5328860BD8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CIjV3nrO4jNdql8yp29S+96UpDACpGjeOguVgyJZq6o=;
 b=fKK2bspkT+qVUAjRgYONxhA206wLU1mbjz1ZATdpQPUvPDEOE4fXIpEbExhjffcjUinaLe
 zN0670lagnnwN2GYNyR3h742CJ1dA7hZSI6zvZPK09qxKozCPREvmA1cZUCkqsRvm64nOy
 3lpJ6rVR2vxvjXsi8RgHB+hFF+h1QKY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-eRB-4mJTOCqGj62NUZE-_w-1; Thu, 06 Jul 2023 12:47:55 -0400
X-MC-Unique: eRB-4mJTOCqGj62NUZE-_w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so625051a12.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662074; x=1691254074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIjV3nrO4jNdql8yp29S+96UpDACpGjeOguVgyJZq6o=;
 b=F4/CS2JYodYQxYZNlLYBbkXACw6+zGAK6e6x7uyPFVynCiEGG0VcL2Rbu/CNyCvuyo
 t+UJeXp4E16uahj+KJ4Cxg/T5ii8xhsNeULc0803jiYNnIxLX722RzLAte6JtdaUVzpV
 TFgecvtKmZm+LrlGxezUqiM+8Jv6T3mUAVQrfprlFyTB0IyuH7F3jU7X8FIml/gsa9cx
 M8TWJwLkRGh1+EgOCAGSj+f3zfK14Xv4SofFlxK8QhF4Kf/YAEmUQFmppeWIFrdoqLIh
 qClimDL0S7MBeNUj9jjsburJQlt7tV8kWAu4b/M5asy7mFqeBRS+FoBrlUR5qAjihyey
 LJug==
X-Gm-Message-State: ABy/qLaVEjDZVr5Lg9TZ2SMEgbs8sCjvmuBv+SHdn5bePXNI2E6BY0Tw
 Y6Ql2qeVIaGNzQ3BXs+yr/Ume6+B6q6hyH7vuzIuTARPDbDgBN4I7zVaaoIxZ6itaBpiTihtn4n
 IHPyP4AHXHixG6dbzh6SIJAmAjpsqY5G5lasEv+KxgQ==
X-Received: by 2002:a50:ec99:0:b0:51d:f74c:1d44 with SMTP id
 e25-20020a50ec99000000b0051df74c1d44mr2453329edr.31.1688662074127; 
 Thu, 06 Jul 2023 09:47:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFsgBZKktKUKDnMD4AGXhJM/rSYMTYzoTBTMz/PUfXFIbgHcwyix502QSKdumliEmlDeazbpg==
X-Received: by 2002:a50:ec99:0:b0:51d:f74c:1d44 with SMTP id
 e25-20020a50ec99000000b0051df74c1d44mr2453315edr.31.1688662073762; 
 Thu, 06 Jul 2023 09:47:53 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 i22-20020aa7c716000000b0051df13f1d8fsm973950edq.71.2023.07.06.09.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:47:53 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:47:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 01/17] vsock/virtio: read data from non-linear skb
Message-ID: <xz2elkpzzgn6zfm2e7lpognwgwm3leexyjm65qn54xwxlvbxmb@l5mhnorcbuez>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-2-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:31AM +0300, Arseniy Krasnov wrote:
>This is preparation patch for non-linear skbuff handling. It replaces
>direct calls of 'memcpy_to_msg()' with 'skb_copy_datagram_iter()'. Main
>advantage of the second one is that is can handle paged part of the skb

s/is that is/is that it/

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

I would mention that this change is in preparation of zero-copy support.

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Use local variable for 'frag_off' in stream dequeue calback.
>  * R-b from Bobby Eshleman removed due to patch update.
>
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 30 ++++++++++++++++++-------
> 2 files changed, 23 insertions(+), 8 deletions(-)
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
>index b769fc258931..e5683af23e60 100644
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
>@@ -411,27 +414,35 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	}
>
> 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
>+		u32 skb_rest_len;
>+
> 		skb = skb_peek(&vvs->rx_queue);
>
> 		bytes = len - total;
>-		if (bytes > skb->len)
>-			bytes = skb->len;
>+		skb_rest_len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>+
>+		if (bytes > skb_rest_len)
>+			bytes = skb_rest_len;

What about just:
		bytes = min_t(size_t, len - total,
			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off);

The rest LGTM!

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
>@@ -503,7 +514,10 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
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
