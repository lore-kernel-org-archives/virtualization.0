Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8AAC64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A37A160C0B;
	Fri, 10 Mar 2023 09:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A37A160C0B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hRekxHOl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hwDZw8ha1qf; Fri, 10 Mar 2023 09:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 193F660F62;
	Fri, 10 Mar 2023 09:04:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 193F660F62
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA1C1C0071;
	Fri, 10 Mar 2023 09:04:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E195C0071
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9773760F5E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:04:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9773760F5E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kPR74UEo2oIB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:04:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47FDA60B98
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47FDA60B98
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678439070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=46gl8Ai7V7dH+MCugjXS8UMr3cPoA8v6IdWxTjz1/ig=;
 b=hRekxHOlcmUp1LcugywHt9dQfLJNOA9VIRg+8EubQ8SkX1xwPWQA9Km3Z/8szXvhfS7xw0
 h7ZtH+4XwnOJ8gLw6BEySSx6hGikCLf6aofYN3C5qjglZIfPTntxXBJ3gDPBNZVX908uZZ
 TYl0cXmo8seqvHkAD6xMsAGg0LU9llc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-xPrOtw7YObyvE7BYzlznvA-1; Fri, 10 Mar 2023 04:04:26 -0500
X-MC-Unique: xPrOtw7YObyvE7BYzlznvA-1
Received: by mail-wm1-f70.google.com with SMTP id
 j32-20020a05600c1c2000b003e9bdf02c9fso3574208wms.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678439065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46gl8Ai7V7dH+MCugjXS8UMr3cPoA8v6IdWxTjz1/ig=;
 b=xIjhVHSdAxZxSaGNGMBQcicFNSAQvwM9rZGzF+eS2UigtvhI0D99KC+ERcUZkcqE3G
 QU9v+t54sHkMM/409Be2O/jXpJOvuN77YRwP8j7xZ5KKd2qRSAtlW7ZnjCtWFUpS5VUX
 66mCOUaXfrZhBxeM5vuTLDrRtqcbCBRyCaaAnAsCBExzYUTX5CQ1NaYYdOTs83ctYtH4
 ivm0O3p71uYI+f8SrfZxnNF9vcFzLpbW2BayoDTBtozTOz2JBx+FCZpyhNag8u5LWW+D
 5R/C7109BqgZsXhyUJfaLcWF4FHY1fvTEzZrDVPB5YI7ftel25qr9eHRAx3mAQ67tzkK
 xe8w==
X-Gm-Message-State: AO0yUKUddqzRJxvd3zYp1waoBSiWKQTk4OI/Boi205F0alpoR9SnywmN
 12yH0q7ADTl+L2aS5Q27fbWrxkZ5xaABZIzPdYkhp1AQAn8Kg53uY4eZ6Liao/+OUO3IWdE3MOz
 qk88iAYZGmI0IUrPWe/rDUhxEAP3Nm/QLPmuYhZBKZA==
X-Received: by 2002:a5d:4b46:0:b0:2cb:72c2:3d12 with SMTP id
 w6-20020a5d4b46000000b002cb72c23d12mr14641283wrs.68.1678439065788; 
 Fri, 10 Mar 2023 01:04:25 -0800 (PST)
X-Google-Smtp-Source: AK7set+Dj7EXVbKf4FaIRS7+hywjAPjXzlp5ChAxftqM7LqGTf3r7oKcF/ohX5pthjzSPMHrz72DBg==
X-Received: by 2002:a5d:4b46:0:b0:2cb:72c2:3d12 with SMTP id
 w6-20020a5d4b46000000b002cb72c23d12mr14641264wrs.68.1678439065444; 
 Fri, 10 Mar 2023 01:04:25 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 o18-20020a056000011200b002c559def236sm1592840wrx.57.2023.03.10.01.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 01:04:24 -0800 (PST)
Date: Fri, 10 Mar 2023 10:04:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 1/4] virtio/vsock: don't use skbuff state to
 account credit
Message-ID: <20230310090422.ybe72rkciekbit2g@sgarzare-redhat>
References: <1804d100-1652-d463-8627-da93cb61144e@sberdevices.ru>
 <71a296ad-6619-c8e6-14a1-9423ac2e4841@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <71a296ad-6619-c8e6-14a1-9423ac2e4841@sberdevices.ru>
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

On Thu, Mar 09, 2023 at 11:26:00PM +0300, Arseniy Krasnov wrote:
>'skb->len' can vary when we partially read the data, this complicates the
>calculation of credit to be updated in 'virtio_transport_inc_rx_pkt()/
>virtio_transport_dec_rx_pkt()'.
>
>Also in 'virtio_transport_dec_rx_pkt()' we were miscalculating the
>credit since 'skb->len' was redundant.
>
>For these reasons, let's replace the use of skbuff state to calculate new
>'rx_bytes'/'fwd_cnt' values with explicit value as input argument. This
>makes code more simple, because it is not needed to change skbuff state
>before each call to update 'rx_bytes'/'fwd_cnt'.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 23 +++++++++++------------
> 1 file changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a1581c77cf84..618680fd9906 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -241,21 +241,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> }
>
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>-					struct sk_buff *skb)
>+					u32 len)
> {
>-	if (vvs->rx_bytes + skb->len > vvs->buf_alloc)
>+	if (vvs->rx_bytes + len > vvs->buf_alloc)
> 		return false;
>
>-	vvs->rx_bytes += skb->len;
>+	vvs->rx_bytes += len;
> 	return true;
> }
>
> static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
>-					struct sk_buff *skb)
>+					u32 len)
> {
>-	int len;
>-
>-	len = skb_headroom(skb) - sizeof(struct virtio_vsock_hdr) - skb->len;
> 	vvs->rx_bytes -= len;
> 	vvs->fwd_cnt += len;
> }
>@@ -388,7 +385,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 		skb_pull(skb, bytes);
>
> 		if (skb->len == 0) {
>-			virtio_transport_dec_rx_pkt(vvs, skb);
>+			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>+
>+			virtio_transport_dec_rx_pkt(vvs, pkt_len);
> 			consume_skb(skb);
> 		} else {
> 			__skb_queue_head(&vvs->rx_queue, skb);
>@@ -437,17 +436,17 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>
> 	while (!msg_ready) {
> 		struct virtio_vsock_hdr *hdr;
>+		size_t pkt_len;
>
> 		skb = __skb_dequeue(&vvs->rx_queue);
> 		if (!skb)
> 			break;
> 		hdr = virtio_vsock_hdr(skb);
>+		pkt_len = (size_t)le32_to_cpu(hdr->len);
>
> 		if (dequeued_len >= 0) {
>-			size_t pkt_len;
> 			size_t bytes_to_copy;
>
>-			pkt_len = (size_t)le32_to_cpu(hdr->len);
> 			bytes_to_copy = min(user_buf_len, pkt_len);
>
> 			if (bytes_to_copy) {
>@@ -484,7 +483,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 				msg->msg_flags |= MSG_EOR;
> 		}
>
>-		virtio_transport_dec_rx_pkt(vvs, skb);
>+		virtio_transport_dec_rx_pkt(vvs, pkt_len);
> 		kfree_skb(skb);
> 	}
>
>@@ -1040,7 +1039,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->rx_lock);
>
>-	can_enqueue = virtio_transport_inc_rx_pkt(vvs, skb);
>+	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> 	if (!can_enqueue) {
> 		free_pkt = true;
> 		goto out;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
