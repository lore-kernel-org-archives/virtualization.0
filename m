Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD02EB64DC
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1D2D6100B;
	Thu,  6 Jul 2023 16:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1D2D6100B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bj0ucICt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrhL5OnevaDZ; Thu,  6 Jul 2023 16:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4DEA660E3C;
	Thu,  6 Jul 2023 16:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DEA660E3C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A416C0071;
	Thu,  6 Jul 2023 16:51:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8750C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A08C882280
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A08C882280
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bj0ucICt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aWf1q-hqaolm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C49758227F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C49758227F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lY92+ddtv43Js0GKJTCX1QniXKfhiDq46fV1jZcI+8=;
 b=Bj0ucICt/onfvxHKN45HfGrBZ5E6VLStsuFldGwzIHoXeclm114G+PGN44R3IE4pIEqQeP
 zS8BEAxXPb82tyuQlTJC3qXuJcnWdkLisnnqqTL/MtzsawbyEIFxRDKMev1/n620pasEdM
 mpkCVqPOTVk2rsmdt2cvzvlaH/E6WF8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-JEgCZ0i_OrK3QaVxjlaw_Q-1; Thu, 06 Jul 2023 12:51:06 -0400
X-MC-Unique: JEgCZ0i_OrK3QaVxjlaw_Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-98890dda439so46961366b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662265; x=1691254265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lY92+ddtv43Js0GKJTCX1QniXKfhiDq46fV1jZcI+8=;
 b=JX6YHvSaJcllfxtSO3SV5N1kXffiJkv0bqfc8PfTj92xs/KErt2xPoS4L1pMbeQ5ED
 5A7oY6cuWBO/eF5Ajl+AOSPAbJbbn1Tsghl1InoR3qBVLOFInPBqBo3Ueg7Qf8PB5niI
 9+gHH4BV9ztb/mN1m7jF4c9pMVhpxWqO0UjFiCLsHpWBmwWgA5UZRrAN3+YyavjHd3U7
 60xIfFsGQWbMTBrno3Jbog69iYkMpnZQHxOP7wB/hyImTgGz9Y00UCMnHA25uR7Dvhy2
 qV5cJPZ6LOpHweMlxo91y6QgRkboRqd8fvyHrw1T6JynEYVcVUhyhohMsYIpWB0Mi6pm
 mtkg==
X-Gm-Message-State: ABy/qLYXDWUqnliGDXFjYLNklscXh1pFS1+sP0VZoRiPsFTFejxgN9PT
 WcSWwUOUP3l5j4KNIQulz6dn9gYQeRtPY3GQ1lxaQ6BY9fKIalpEhL1W3gilErEi3Tx7+3FmMLk
 mfgKyy3W+zlUpjM0XCqPzSZNekC01FHlS4iD4DPQV5g==
X-Received: by 2002:a17:906:7046:b0:992:b9f4:85db with SMTP id
 r6-20020a170906704600b00992b9f485dbmr1815341ejj.39.1688662264980; 
 Thu, 06 Jul 2023 09:51:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqgmU14xEa56II5zxLyRGIPXThOhEyLQmB+kMCm8D12EMDJhS0ZJLYiNGRDuHhor0mACYvpg==
X-Received: by 2002:a17:906:7046:b0:992:b9f4:85db with SMTP id
 r6-20020a170906704600b00992b9f485dbmr1815324ejj.39.1688662264645; 
 Thu, 06 Jul 2023 09:51:04 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 s24-20020a170906169800b0096f7500502csm1023286ejd.199.2023.07.06.09.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:51:04 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:51:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 03/17] vsock/virtio: support to send non-linear skb
Message-ID: <joml4wolu5r2wpetvbfezu6buwfnfntu5okxjacfgdsp7uaebk@onkmwg7r7fod>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-4-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-4-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:33AM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Use 'out_sgs' variable to index 'bufs', not only 'sgs'.
>  * Move smaller branch above, see 'if (!skb_is_nonlinear(skb)').
>  * Remove blank line.
>  * R-b from Bobby Eshleman removed due to patch update.
>
> net/vmw_vsock/virtio_transport.c | 40 +++++++++++++++++++++++++++-----
> 1 file changed, 34 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..6cbb45bb12d2 100644
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
>@@ -111,12 +113,38 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
>+		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
>+			    sizeof(*virtio_vsock_hdr(skb)));
>+		sgs[out_sg] = &bufs[out_sg];
>+		out_sg++;
>+
>+		if (!skb_is_nonlinear(skb)) {
>+			if (skb->len > 0) {
>+				sg_init_one(&bufs[out_sg], skb->data, skb->len);
>+				sgs[out_sg] = &bufs[out_sg];
>+				out_sg++;
>+			}
>+		} else {
>+			struct skb_shared_info *si;
>+			int i;
>+
>+			si = skb_shinfo(skb);
>+
>+			for (i = 0; i < si->nr_frags; i++) {
>+				skb_frag_t *skb_frag = &si->frags[i];
>+				void *va = page_to_virt(skb_frag->bv_page);
>
>-		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>-		sgs[out_sg++] = &hdr;
>-		if (skb->len > 0) {
>-			sg_init_one(&buf, skb->data, skb->len);
>-			sgs[out_sg++] = &buf;
>+				/* We will use 'page_to_virt()' for userspace page here,
>+				 * because virtio layer will call 'virt_to_phys()' later
>+				 * to fill buffer descriptor. We don't touch memory at
>+				 * "virtual" address of this page.
>+				 */
>+				sg_init_one(&bufs[out_sg],
>+					    va + skb_frag->bv_offset,
>+					    skb_frag->bv_len);
>+				sgs[out_sg] = &bufs[out_sg];
>+				out_sg++;
>+			}
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
