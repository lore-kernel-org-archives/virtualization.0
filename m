Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE3FEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 15:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DE89821E3;
	Mon, 26 Jun 2023 15:37:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DE89821E3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CdFiZJm/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZK-SXoqiLQAB; Mon, 26 Jun 2023 15:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 185C08215F;
	Mon, 26 Jun 2023 15:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 185C08215F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2D0AC0037;
	Mon, 26 Jun 2023 15:37:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87725C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54492821E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:37:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54492821E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8VGC-W7Qet6e
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:37:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08AF28215F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08AF28215F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687793819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=71PcUdXHzfbmeSLaqcZwK2r6pjSreCaY9XzRHkKEiCA=;
 b=CdFiZJm/+1I8lAU+2OZeHvydTxeDU6cvsuCV9z1CFoZNj85/bD8F3MaxN+iTOiPZitz6YF
 k4kih3PKEFPdYwbzhv26AMJ1ftjVrXm4IPgTMDSjM3x37sK7cwZPxNwR4alr24aNahCPi/
 sVsR3SR0swa6bjK5r324HM7lTeLsVP8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-mqieuk5EP0eXg5NM6kCalA-1; Mon, 26 Jun 2023 11:36:58 -0400
X-MC-Unique: mqieuk5EP0eXg5NM6kCalA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62e85844711so35086906d6.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 08:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793817; x=1690385817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71PcUdXHzfbmeSLaqcZwK2r6pjSreCaY9XzRHkKEiCA=;
 b=Rr+xa0CAYLBoBGKKVWP2MCwJtN2yFR/P6PXBqQU/uHHmac9I6R0wjh5JY6Lt1nUMzO
 Xf5Nd7Rm8jf1gzLmMzuJyHsn2SMRn0ZQGZydczNWGOQLeeC/s6nKt8qGz93eEm4b15F6
 nNCMMMj46UeXT7FrUDeW2ZL4ZxBy2U4MfQKunoAnTia0isqeN7K9U9ImwBhrr1yYosrY
 SPFItxmCRH/hN73gu0fgtnzbviLnj24SwWnBA3MGdYs/Jf72TN4OBtx5dQmRWTtOAf5D
 eCTsH61LhEni2EmIjONERUuDieWY3UC+iXJkkau3OcGNVP35xuUyStfD7eOI87+Cu1EO
 LH/Q==
X-Gm-Message-State: AC+VfDxyoxiqjEXxna4Ls8MAeUuab8QXGV2tr3UA1Z7KqrlW8JxUrBs9
 z5/5+Hhm+eUkTGO8HKdAOdjyf7GAkBXWqjOeet1uFDMyUhDaD15fal/aDk0nJYWppSDqiLKpaTf
 gsThy8J56zjqQcjbMDQ6EHveqZSOub16md+ii5AjKXw==
X-Received: by 2002:a05:6214:2346:b0:62f:f13e:bd73 with SMTP id
 hu6-20020a056214234600b0062ff13ebd73mr39396843qvb.20.1687793817548; 
 Mon, 26 Jun 2023 08:36:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40I5NnfBD7e9UXdCL5E/tGBEB8QeoD2KkkaZxvewAgMci79nu2OXGaIhbm0FmSDkshqOeiBQ==
X-Received: by 2002:a05:6214:2346:b0:62f:f13e:bd73 with SMTP id
 hu6-20020a056214234600b0062ff13ebd73mr39396823qvb.20.1687793817297; 
 Mon, 26 Jun 2023 08:36:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 dd12-20020ad4580c000000b00632191a70aesm3299770qvb.88.2023.06.26.08.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:36:56 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:36:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 03/17] vsock/virtio: support to send non-linear skb
Message-ID: <3lg4apldxdrpbkgfa2o4wxe4qyayj2h7b2lfcw3q5a7u3hnofi@z2ifmmzt4xpc>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-4-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-4-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:25PM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport.c | 37 ++++++++++++++++++++++++++------
> 1 file changed, 31 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..6053d8341091 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 	vq = vsock->vqs[VSOCK_VQ_TX];
>
> 	for (;;) {
>-		struct scatterlist hdr, buf, *sgs[2];
>+		/* +1 is for packet header. */
>+		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>+		struct scatterlist bufs[MAX_SKB_FRAGS + 1];
> 		int ret, in_sg = 0, out_sg = 0;
> 		struct sk_buff *skb;
> 		bool reply;
>@@ -111,12 +113,35 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
>+		sg_init_one(&bufs[0], virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>+		sgs[out_sg++] = &bufs[0];

Can we use out_sg also to index bufs (here and in the rest of the code)?

E.g.

		sg_init_one(&bufs[out_sg], ...)
		sgs[out_sg] = &bufs[out_sg];
		++out_sg;

		...
			if (skb->len > 0) {
				sg_init_one(&bufs[out_sg], skb->data, skb->len);
				sgs[out_sg] = &bufs[out_sg];
				++out_sg;
			}

		etc...

>+

For readability, I would move the smaller branch above:

		if (!skb_is_nonlinear(skb)) {
			// small block
			...
		} else {
			// big block
			...
		}

>+		if (skb_is_nonlinear(skb)) {
>+			struct skb_shared_info *si;
>+			int i;
>+
>+			si = skb_shinfo(skb);
>+
>+			for (i = 0; i < si->nr_frags; i++) {
>+				skb_frag_t *skb_frag = &si->frags[i];
>+				void *va = page_to_virt(skb_frag->bv_page);
>+
>+				/* We will use 'page_to_virt()' for userspace page here,
>+				 * because virtio layer will call 'virt_to_phys()' later
>+				 * to fill buffer descriptor. We don't touch memory at
>+				 * "virtual" address of this page.
>+				 */
>+				sg_init_one(&bufs[i + 1],
>+					    va + skb_frag->bv_offset,
>+					    skb_frag->bv_len);
>+				sgs[out_sg++] = &bufs[i + 1];
>+			}
>+		} else {
>+			if (skb->len > 0) {

Should we do the same check (skb->len > 0) for nonlinear skb as well?
Or do the nonlinear ones necessarily have len > 0?

>+				sg_init_one(&bufs[1], skb->data, skb->len);
>+				sgs[out_sg++] = &bufs[1];
>+			}
>
    ^
Blank line that we can remove.

Stefano

>-		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>-		sgs[out_sg++] = &hdr;
>-		if (skb->len > 0) {
>-			sg_init_one(&buf, skb->data, skb->len);
>-			sgs[out_sg++] = &buf;
> 		}
>
> 		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
