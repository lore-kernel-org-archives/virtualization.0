Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEDC636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 14:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE3AF60A79;
	Thu, 16 Feb 2023 14:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE3AF60A79
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jC6Hh2dI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pGLd1899FrV6; Thu, 16 Feb 2023 14:09:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3284060812;
	Thu, 16 Feb 2023 14:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3284060812
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 067E8C0032;
	Thu, 16 Feb 2023 14:09:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D593C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 187454031D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:09:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 187454031D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jC6Hh2dI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0mR3EJ1zMTo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:09:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 514AE4023B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 514AE4023B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676556566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIv/znYayUURQPypPRVti8rBugentUV5lP2jcUhz0tw=;
 b=jC6Hh2dIiKap3VE4qAvCHuaHD1cQC/XksDA1irezzKbFvVd1fxiZ4XgMcjGa2zpcW9/wDX
 m8zq7zQh1uInefOpEALBwLjH54PlTYaFF6XDMehWEMp4fqoIcNzmSAG2xs/eplgylEAK/a
 LtBtCdsfukB/u2cLDQDEGK8asUfn0Nc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-f7aYvGwPMF2pmzC3n7Z03w-1; Thu, 16 Feb 2023 09:09:25 -0500
X-MC-Unique: f7aYvGwPMF2pmzC3n7Z03w-1
Received: by mail-qt1-f197.google.com with SMTP id
 bs11-20020ac86f0b000000b003b9b4ec27c4so1237245qtb.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 06:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIv/znYayUURQPypPRVti8rBugentUV5lP2jcUhz0tw=;
 b=UVuanZpZjnB+VAtLgVzXSrWOJLskiyAUD4Fk7YntgEunsKtpLGOpW9ZGvn28PiE5Pj
 nXrmozKhisYTKIO79Qsti6bKQTwyObfbl2DIi3WLiTAKQkR54w23EkJTZNRI0fHqOgNm
 JHgJtqVZhXHXg1yPLHdXU+ten9ixLPL0voWNTPRs4dOuyZGec4kjpvoQHeNgU9Tf7UtB
 tQHNMzAwSCoJpBOoNWpf7VAY5IntC50SSF3LxoDw8Hcf2ZFQfoT299U7E1EG7Q0A3u50
 SY1P1GQVBeN7sYEIqrg0WJRM53AnJwTXBwmGScfvAjBmiGnyh8Q/N+v4M8UlsvdCbL3G
 nY6Q==
X-Gm-Message-State: AO0yUKWzzvmkRq2euMp1zwy5Jlija9dMmd+yhtXenyIsZfl3cu3Cjq9C
 KxG4QX+WNUXh5IexkKe2/u2qdGcl2mPG071+Q80Qr74u6tF0xOcHilArfqWQtaNTgBm6OyCMq12
 euOO4nZb5Gmvfh37v8JrwYZMMqnKAxVXXNUJNatoj6A==
X-Received: by 2002:ad4:5c66:0:b0:56b:f308:caab with SMTP id
 i6-20020ad45c66000000b0056bf308caabmr12608763qvh.13.1676556564490; 
 Thu, 16 Feb 2023 06:09:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/6LTFM2e6dQZOBByDiucEi9Lpba61BrCfPHXHquEYhMRipHLkb91i0Fk5WcPqTp3fViwTP9w==
X-Received: by 2002:ad4:5c66:0:b0:56b:f308:caab with SMTP id
 i6-20020ad45c66000000b0056bf308caabmr12608717qvh.13.1676556564160; 
 Thu, 16 Feb 2023 06:09:24 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 x4-20020ac84d44000000b003b82a07c4d6sm1236152qtv.84.2023.02.16.06.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 06:09:23 -0800 (PST)
Date: Thu, 16 Feb 2023 15:09:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 04/12] vhost/vsock: non-linear skb handling support
Message-ID: <20230216140917.jpcmfrwl5gpdzdzi@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <c1570fa9-1673-73cf-5545-995e9aac1dbb@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <c1570fa9-1673-73cf-5545-995e9aac1dbb@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Feb 06, 2023 at 06:57:16AM +0000, Arseniy Krasnov wrote:
>This adds copying to guest's virtio buffers from non-linear skbs. Such
>skbs are created by protocol layer when MSG_ZEROCOPY flags is used.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> drivers/vhost/vsock.c        | 56 ++++++++++++++++++++++++++++++++----
> include/linux/virtio_vsock.h | 12 ++++++++
> 2 files changed, 63 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 1f3b89c885cc..60b9cafa3e31 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -86,6 +86,44 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
> 	return NULL;
> }
>
>+static int vhost_transport_copy_nonlinear_skb(struct sk_buff *skb,
>+					      struct iov_iter *iov_iter,
>+					      size_t len)
>+{
>+	size_t rest_len = len;
>+
>+	while (rest_len && virtio_vsock_skb_has_frags(skb)) {
>+		struct bio_vec *curr_vec;
>+		size_t curr_vec_end;
>+		size_t to_copy;
>+		int curr_frag;
>+		int curr_offs;
>+
>+		curr_frag = VIRTIO_VSOCK_SKB_CB(skb)->curr_frag;
>+		curr_offs = VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>+		curr_vec = &skb_shinfo(skb)->frags[curr_frag];
>+
>+		curr_vec_end = curr_vec->bv_offset + curr_vec->bv_len;
>+		to_copy = min(rest_len, (size_t)(curr_vec_end - curr_offs));
>+
>+		if (copy_page_to_iter(curr_vec->bv_page, curr_offs,
>+				      to_copy, iov_iter) != to_copy)
>+			return -1;
>+
>+		rest_len -= to_copy;
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += to_copy;
>+
>+		if (VIRTIO_VSOCK_SKB_CB(skb)->frag_off == (curr_vec_end)) {
>+			VIRTIO_VSOCK_SKB_CB(skb)->curr_frag++;
>+			VIRTIO_VSOCK_SKB_CB(skb)->frag_off = 0;
>+		}
>+	}

Can it happen that we exit this loop and rest_len is not 0?

In this case, is it correct to decrement data_len by len?

Thanks,
Stefano

>+
>+	skb->data_len -= len;
>+
>+	return 0;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -197,11 +235,19 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			break;
> 		}
>
>-		nbytes = copy_to_iter(skb->data, payload_len, &iov_iter);
>-		if (nbytes != payload_len) {
>-			kfree_skb(skb);
>-			vq_err(vq, "Faulted on copying pkt buf\n");
>-			break;
>+		if (skb_is_nonlinear(skb)) {
>+			if (vhost_transport_copy_nonlinear_skb(skb, &iov_iter,
>+							       payload_len)) {
>+				vq_err(vq, "Faulted on copying pkt buf from page\n");
>+				break;
>+			}
>+		} else {
>+			nbytes = copy_to_iter(skb->data, payload_len, &iov_iter);
>+			if (nbytes != payload_len) {
>+				kfree_skb(skb);
>+				vq_err(vq, "Faulted on copying pkt buf\n");
>+				break;
>+			}
> 		}
>
> 		/* Deliver to monitoring devices all packets that we
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 3f9c16611306..e7efdb78ce6e 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -12,6 +12,10 @@
> struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
>+	/* Current fragment in 'frags' of skb. */
>+	u32 curr_frag;
>+	/* Offset from 0 in current fragment. */
>+	u32 frag_off;
> };
>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>@@ -46,6 +50,14 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
> 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
> }
>
>+static inline bool virtio_vsock_skb_has_frags(struct sk_buff *skb)
>+{
>+	if (!skb_is_nonlinear(skb))
>+		return false;
>+
>+	return VIRTIO_VSOCK_SKB_CB(skb)->curr_frag != skb_shinfo(skb)->nr_frags;
>+}
>+
> static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> {
> 	u32 len;
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
