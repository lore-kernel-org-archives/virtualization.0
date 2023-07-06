Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CD7EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93B5160EF2;
	Thu,  6 Jul 2023 16:49:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93B5160EF2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aGYc0LVg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gex2hYug3kyg; Thu,  6 Jul 2023 16:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED9D960BD8;
	Thu,  6 Jul 2023 16:49:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED9D960BD8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF410C0071;
	Thu,  6 Jul 2023 16:49:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1CBBC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8FB14186D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:49:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8FB14186D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aGYc0LVg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8oxBxmUE1D2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A7C0402BD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A7C0402BD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJektsoy0misgOoLPFYa4+3boQJ8dt+dK5kdqOR27mc=;
 b=aGYc0LVgnsTlZ3zLww9ck3SK0WI03d3LzohrpbpDVUWVDn1Jos06olBKK1OjHgqQhKWllR
 YpdxYJHOfZVQOw74NKSAakWsOW2J94AKPXYbWO+Sv8rgQWg96PxPOEIW5NWa0ymhLZ1OIL
 iL0ggFmQDuBe67+E4cOVK38m8Gi8y5Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-A5gAkppCMk2LGic-jnrKNQ-1; Thu, 06 Jul 2023 12:49:10 -0400
X-MC-Unique: A5gAkppCMk2LGic-jnrKNQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993c2d9e496so32908166b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662150; x=1691254150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJektsoy0misgOoLPFYa4+3boQJ8dt+dK5kdqOR27mc=;
 b=CLZ9t65mNIhyTOuKlrmf/ZKhR/J1GK1UrpItC37tJehxLWVhdGJ4CTlLtjVuurm/Pr
 KvxkO/xfCtRzD8Q/iXnaKvYNGnWmOyWW1YGomHFASpo4+W0ZVKC3bIlo5IB6on/NTjiI
 tTpTZ67mQBugHZ+VaTWpvUlEz8GaNIMLyWWeZF6FI8zgYQeRbxogWMbF2hor481TqO37
 gKO1IuL0l5JPgFhg6DEqd+NwyhHlEYK9jdllqyqhhhujCj/HU/Z3j7rfSYuPzJKKTP8N
 5MuaVVVA00LV11t9yN4hfI46Lw9baxwb0QcFcJQA0ggWbcoQNO1N788kc849WEDYOgIJ
 Z73w==
X-Gm-Message-State: ABy/qLYAdNcbq8/L8AK3+4NT+76HPllP4Bnal3MFrW2GObt3pzSiygjv
 42s6DU+T1Wousl8Y4odNisdCEGr3kVgdHM0D3cXSG+W7NoLnFgaN/rSAk/mrupcmhqqu3r5kp4+
 kJLrTDdpvX9CjgItDear/KhtomptsW7rTSmZ/c+BizA==
X-Received: by 2002:a17:907:a07c:b0:96a:2acf:61e1 with SMTP id
 ia28-20020a170907a07c00b0096a2acf61e1mr2160896ejc.64.1688662149877; 
 Thu, 06 Jul 2023 09:49:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMy+yG5KRW2pkXS6lw2Ew3M/i1KwRrsz6O8/7lmajYiW6fkNqwbOfOSxce1oyo/cRPsTA5HA==
X-Received: by 2002:a17:907:a07c:b0:96a:2acf:61e1 with SMTP id
 ia28-20020a170907a07c00b0096a2acf61e1mr2160884ejc.64.1688662149602; 
 Thu, 06 Jul 2023 09:49:09 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 s6-20020a170906454600b00992c92af6f4sm1039367ejq.144.2023.07.06.09.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:49:09 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:49:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 02/17] vhost/vsock: read data from non-linear skb
Message-ID: <cgq3d3j25doy7qar6xsepsrly5ypyjwahf2gybfi3fnozp3kjx@hh5q5bps37ws>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-3-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:32AM +0300, Arseniy Krasnov wrote:
>This adds copying to guest's virtio buffers from non-linear skbs. Such
>skbs are created by protocol layer when MSG_ZEROCOPY flags is used. It
>replaces call of 'copy_to_iter()' to 'skb_copy_datagram_iter()'- second
>function can read data from non-linear skb. Also this patch uses field
>'frag_off' from skb control block. This field shows current offset to
>read data from skb which could be both linear or not.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Use local variable for 'frag_off'.
>  * Update commit message by adding some details about 'frag_off' field.
>  * R-b from Bobby Eshleman removed due to patch update.

I think we should merge this patch with the previous one, since
vhost-vsock for example uses virtio_transport_stream_do_dequeue()
that we change in the previous commit, so we will break the bisection.

The patch LGTM!

Stefano

>
> drivers/vhost/vsock.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 6578db78f0ae..cb00e0e059e4 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -114,6 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		struct sk_buff *skb;
> 		unsigned out, in;
> 		size_t nbytes;
>+		u32 frag_off;
> 		int head;
>
> 		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>@@ -156,7 +157,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		}
>
> 		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
>-		payload_len = skb->len;
>+		frag_off = VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>+		payload_len = skb->len - frag_off;
> 		hdr = virtio_vsock_hdr(skb);
>
> 		/* If the packet is greater than the space available in the
>@@ -197,8 +199,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			break;
> 		}
>
>-		nbytes = copy_to_iter(skb->data, payload_len, &iov_iter);
>-		if (nbytes != payload_len) {
>+		if (skb_copy_datagram_iter(skb,
>+					   frag_off,
>+					   &iov_iter,
>+					   payload_len)) {
> 			kfree_skb(skb);
> 			vq_err(vq, "Faulted on copying pkt buf\n");
> 			break;
>@@ -212,13 +216,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> 		added = true;
>
>-		skb_pull(skb, payload_len);
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += payload_len;
> 		total_len += payload_len;
>
> 		/* If we didn't send all the payload we can requeue the packet
> 		 * to send it with the next available buffer.
> 		 */
>-		if (skb->len > 0) {
>+		if (VIRTIO_VSOCK_SKB_CB(skb)->frag_off < skb->len) {
> 			hdr->flags |= cpu_to_le32(flags_to_restore);
>
> 			/* We are queueing the same skb to handle
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
