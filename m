Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC53C678D4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 11:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6397C408FC;
	Mon,  6 Mar 2023 11:57:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6397C408FC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CN+febEf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7CwU-e2V9un9; Mon,  6 Mar 2023 11:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A64A408EF;
	Mon,  6 Mar 2023 11:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A64A408EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59B17C0035;
	Mon,  6 Mar 2023 11:57:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47C1CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 11:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1451B813C7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 11:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1451B813C7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CN+febEf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k5eAhc8GrRxm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 11:57:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 250EB813B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 250EB813B7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678103847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pPpIjkKFXmzX5D1Lt9KnLFbKezSVbVCSbxUA3anhA3E=;
 b=CN+febEf7AbMMKfNJF3rO89UsUXVslqRBDXwRVtHJ9fiUirr2j7jc6QtkIlae/rwszx9Y3
 MIHswrUNOa93THO5oDz4ruEhmJZjJrCaNntoK2ULIcPXkJSqaE+nhlbyVLKkwgfIx1923q
 KQ+cJLkm9O7+vUSE1InUJZ0bu6A14PM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-ck0LE6_iNA6Fnscjh1JwxA-1; Mon, 06 Mar 2023 06:57:25 -0500
X-MC-Unique: ck0LE6_iNA6Fnscjh1JwxA-1
Received: by mail-qv1-f72.google.com with SMTP id
 m1-20020a05621402a100b004bb706b3a27so5349590qvv.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 03:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678103845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPpIjkKFXmzX5D1Lt9KnLFbKezSVbVCSbxUA3anhA3E=;
 b=DzjWvK7gunPPp41W+z8VrSMKc1ckKR1zJeBnNcE9t7IgUnr8dSNaQwLXamDfkCk5gz
 tdPcDIyxXHkkwEv3SGCF7+bO8Esu84aS1rM/jm4hS1WDY6eSL1/hPEnt8GCeEVtbwuhM
 stlQ9P/D3RK7L3RvWLNT7BH1jnD5Lwz0wINlCmjFlzgxvqUxffRM3tEDNrn9qlo6b11v
 fmHcKbW+zJ7ZN4tLZ1tcEeDbQKfdz1Bq+F5aQp1y/iludrZ4C8PB+P2995SZijZthGD7
 PsMWCqbUMjj57AbKaltACyIBG/1k2YhB/Gu5OytyY8XR7/L8KJRq4Z2T2C869mepaU8G
 jYaA==
X-Gm-Message-State: AO0yUKU/H8tod3ozAvNKXZHsXDhjlIxK87VDkV85mZMpZwMB2KC4gXtQ
 WPW9hUEs0wCxgiQvtHOQvFccQ0HFzcJtDeVXrQ2WUtqRQe+ICUYjqzU0wOBJ9VgMqvN2MxNrCSc
 qjuMNfFnxRgnjROzrXEjxup1EfVj3LIHx64DtXA40ig==
X-Received: by 2002:a05:6214:410d:b0:56e:b1e0:3ff2 with SMTP id
 kc13-20020a056214410d00b0056eb1e03ff2mr15201392qvb.9.1678103845434; 
 Mon, 06 Mar 2023 03:57:25 -0800 (PST)
X-Google-Smtp-Source: AK7set9fZZTVv9FvGEcGdunZeC28/B+zMV+iRBJXM9Wbl6wp+Gpc50VQTGrmBz+6u9VcqXUQGM9WAg==
X-Received: by 2002:a05:6214:410d:b0:56e:b1e0:3ff2 with SMTP id
 kc13-20020a056214410d00b0056eb1e03ff2mr15201363qvb.9.1678103845151; 
 Mon, 06 Mar 2023 03:57:25 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 j2-20020a37b902000000b0074231ac1723sm7398083qkf.28.2023.03.06.03.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 03:57:24 -0800 (PST)
Date: Mon, 6 Mar 2023 12:57:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/4] virtio/vsock: fix 'rx_bytes'/'fwd_cnt'
 calculation
Message-ID: <20230306115718.2h7munjxd2royuzq@sgarzare-redhat>
References: <a7ab414b-5e41-c7b6-250b-e8401f335859@sberdevices.ru>
 <4a3f3978-1093-4c0a-663f-28d77eeb0806@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <4a3f3978-1093-4c0a-663f-28d77eeb0806@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Sun, Mar 05, 2023 at 11:06:26PM +0300, Arseniy Krasnov wrote:
>Substraction of 'skb->len' is redundant here: 'skb_headroom()' is delta
>between 'data' and 'head' pointers, e.g. it is number of bytes returned
>to user (of course accounting size of header). 'skb->len' is number of
>bytes rest in buffer.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a1581c77cf84..2e2a773df5c1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -255,7 +255,7 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
> {
> 	int len;
>
>-	len = skb_headroom(skb) - sizeof(struct virtio_vsock_hdr) - skb->len;
>+	len = skb_headroom(skb) - sizeof(struct virtio_vsock_hdr);

IIUC virtio_transport_dec_rx_pkt() is always called after skb_pull(),
so skb_headroom() is returning the amount of space we removed.

Looking at the other patches in this series, I think maybe we should
change virtio_transport_dec_rx_pkt() and virtio_transport_inc_rx_pkt()
by passing the value to subtract or add directly.
Since some times we don't remove the whole payload, so it would be
better to call it with the value in hdr->len.

I mean something like this (untested):

index a1581c77cf84..9e69ae7a9a96 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -241,21 +241,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
  }

  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-                                       struct sk_buff *skb)
+                                       u32 len)
  {
-       if (vvs->rx_bytes + skb->len > vvs->buf_alloc)
+       if (vvs->rx_bytes + len > vvs->buf_alloc)
                 return false;

-       vvs->rx_bytes += skb->len;
+       vvs->rx_bytes += len;
         return true;
  }

  static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
-                                       struct sk_buff *skb)
+                                       u32 len)
  {
-       int len;
-
-       len = skb_headroom(skb) - sizeof(struct virtio_vsock_hdr) - skb->len;
         vvs->rx_bytes -= len;
         vvs->fwd_cnt += len;
  }
@@ -388,7 +385,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
                 skb_pull(skb, bytes);

                 if (skb->len == 0) {
-                       virtio_transport_dec_rx_pkt(vvs, skb);
+                       virtio_transport_dec_rx_pkt(vvs, bytes);
                         consume_skb(skb);
                 } else {
                         __skb_queue_head(&vvs->rx_queue, skb);
@@ -437,17 +434,17 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,

         while (!msg_ready) {
                 struct virtio_vsock_hdr *hdr;
+               size_t pkt_len;

                 skb = __skb_dequeue(&vvs->rx_queue);
                 if (!skb)
                         break;
                 hdr = virtio_vsock_hdr(skb);
+               pkt_len = (size_t)le32_to_cpu(hdr->len);

                 if (dequeued_len >= 0) {
-                       size_t pkt_len;
                         size_t bytes_to_copy;

-                       pkt_len = (size_t)le32_to_cpu(hdr->len);
                         bytes_to_copy = min(user_buf_len, pkt_len);

                         if (bytes_to_copy) {
@@ -484,7 +481,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
                                 msg->msg_flags |= MSG_EOR;
                 }

-               virtio_transport_dec_rx_pkt(vvs, skb);
+               virtio_transport_dec_rx_pkt(vvs, pkt_len);
                 kfree_skb(skb);
         }

@@ -1040,7 +1037,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,

         spin_lock_bh(&vvs->rx_lock);

-       can_enqueue = virtio_transport_inc_rx_pkt(vvs, skb);
+       can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
         if (!can_enqueue) {
                 free_pkt = true;
                 goto out;

When we used vsock_pkt, we were passing the structure because the `len`
field was immutable (and copied from the header), whereas with skb it
can change and so we introduced these errors.

What do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
