Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB75C64EC4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 16:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6424D80C83;
	Thu,  9 Mar 2023 16:27:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6424D80C83
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DR6HkWni
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJjLTDeXAyIU; Thu,  9 Mar 2023 16:27:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D795F80EAE;
	Thu,  9 Mar 2023 16:27:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D795F80EAE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3763C0035;
	Thu,  9 Mar 2023 16:27:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8690EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62EE241040
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62EE241040
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DR6HkWni
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4F9Evr_gMgA3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:27:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 975304016F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 975304016F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678379258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxt5/Bn7cdaTgX2DWKCr4A5WUfM36Gr/gY5+wUSWUT8=;
 b=DR6HkWniyavZWhuO/64ujnRKzcoPypI8jbrHAFKrXDyyNmUu5OmMmL1Df/iQ/xrEQFSQYj
 1rfHdYlbtEG7hatg534iU6OuvDz7pTnebzekQDDhWEQ3fYclJfcAZr0crFFYNcaAbcZB6B
 2YxjNHClTGiZK9bFyUvseFiHG/XvbLo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-MnlkQPelMpCVFQZFBzZvGQ-1; Thu, 09 Mar 2023 11:27:37 -0500
X-MC-Unique: MnlkQPelMpCVFQZFBzZvGQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 pv11-20020ad4548b000000b0056e96f4fd64so1448725qvb.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 08:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678379256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxt5/Bn7cdaTgX2DWKCr4A5WUfM36Gr/gY5+wUSWUT8=;
 b=kXuP5uxepcuA1pl4AB0buGiTJRJhkGfX3zIike00ZQNYlX8taNzs2cxpC1LjP6Gp81
 ysGq6MB2xTOlF7wC+IEx6QkqtXzj6HDUzz0KWpeDCaTn4ro2uwJILCOCZgBgBqwcKjP9
 SVSZ7yRngmAqDGGn5jo9oPWUaUgr2glX8+qRrhskfPH8XK1ryp9HOaI4bqAysaXadnNa
 muebjEtvparSCbZzMtF3gV4MBed6Z/SPSIVdI5cCRhaiNZpS4P6vuYCSLDOe2qKMcUTJ
 pGoKRiA+Dx0silxDbrCtF9ii5HoRr0fi2oA+VOLcC6YAi2WLyaB8ueDTugt9/zitODMz
 omgA==
X-Gm-Message-State: AO0yUKVW7mK7B2SEqjt44YsuZrGnygnGeq46vu8HshTL/HcQ/N+7me9q
 lKvPF8to9ZAXtptJeR0DjF69d5aJUdWO3GOHYGIMIpn1zSAWVUYtjV9Ri18sT1XKz9pTJgLzhhZ
 PG9570z2Fim8kDiz6lxWR/fdy3WQD4ISs0fBvOgf3GA==
X-Received: by 2002:ac8:4e8f:0:b0:3b8:ca58:ee4c with SMTP id
 15-20020ac84e8f000000b003b8ca58ee4cmr37414144qtp.2.1678379256609; 
 Thu, 09 Mar 2023 08:27:36 -0800 (PST)
X-Google-Smtp-Source: AK7set+MCqXSR1PGob1I4pk09gGcs+URcwUiCZ4YjiXliMTVJKdjLHjJ73m9gwkInj/O5e3oS12kjQ==
X-Received: by 2002:ac8:4e8f:0:b0:3b8:ca58:ee4c with SMTP id
 15-20020ac84e8f000000b003b8ca58ee4cmr37414110qtp.2.1678379256342; 
 Thu, 09 Mar 2023 08:27:36 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 6-20020a05620a040600b006f9ddaaf01esm13666192qkp.102.2023.03.09.08.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 08:27:35 -0800 (PST)
Date: Thu, 9 Mar 2023 17:27:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 1/4] virtio/vsock: don't use skbuff state to
 account credit
Message-ID: <20230309162726.lzkacyg3lfow4cfg@sgarzare-redhat>
References: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
 <453d77fd-8344-26d8-bb44-7ed829b7de47@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <453d77fd-8344-26d8-bb44-7ed829b7de47@sberdevices.ru>
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

On Thu, Mar 09, 2023 at 01:11:46PM +0300, Arseniy Krasnov wrote:
>This replaces use of skbuff state to calculate new 'rx_bytes'/'fwd_cnt'
>values with explicit value as input argument. This makes code more
>simple, because it is not needed to change skbuff state before each
>call to update 'rx_bytes'/'fwd_cnt'.

I think we should also describe the issues you found that we are fixinig
now, for example the wrong calculation in virtio_transport_dec_rx_pkt().

Something like this:

   `skb->len` can vary when we partially read the data, this complicates
   the calculation of credit to be updated in
   virtio_transport_inc_rx_pkt()/virtio_transport_dec_rx_pkt().

   Also in virtio_transport_dec_rx_pkt() we were miscalculating the
   credit since `skb->len` was redundant.

   For these reasons, let's replace the use ...
   (continue with what is written in this commit message)

And we should add the Fixes tag:

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 23 +++++++++++------------
> 1 file changed, 11 insertions(+), 12 deletions(-)
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

Good catch! In my proposal I used `bytes` wrongly!

The rest LGTM!

Stefano

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
