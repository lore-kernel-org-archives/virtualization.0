Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC51BC001DF
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 08:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 502CC60B0D;
	Tue, 25 Jul 2023 08:18:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 502CC60B0D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UY/ETZbi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u117nAbkxkSB; Tue, 25 Jul 2023 08:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BDBA160A6D;
	Tue, 25 Jul 2023 08:18:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDBA160A6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93F45C0072;
	Tue, 25 Jul 2023 08:18:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7DA3C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B291981E00
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:18:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B291981E00
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UY/ETZbi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cG3J5xACFLGz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:18:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E321081DF2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:18:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E321081DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690273082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yzqiXhC1UF6kcx0o3Qs1VmhKMD7xafUTqbIR8LZgYk=;
 b=UY/ETZbi8M0rGUo7espBkO0ribUT/9mwPiH2f24hxmc3iCPbBc/SCSdU+MHS/+3hfButYe
 qteO7ZAKL+2fwX75pBFdGt0hKgiC1bzUFSJjZu6cz/GUeOK/KdpieshUJRMYTOMQWIO9SX
 fMgiuIoxSRlIQXJhOxsrZ1xsLWQ0EOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-yRrHLL8RMViGxbVcpg2pAw-1; Tue, 25 Jul 2023 04:18:01 -0400
X-MC-Unique: yRrHLL8RMViGxbVcpg2pAw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3141c6f4173so2474064f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 01:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690273080; x=1690877880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yzqiXhC1UF6kcx0o3Qs1VmhKMD7xafUTqbIR8LZgYk=;
 b=Pfok0wuwce0x1tiGhg23KKkBGrsTUWGHdRunxH7m9DQgr981VZvjPtwci3eC3VgWWy
 /tNJadclb3fY+N4b6Yuc5njYiIwDiR/mQzqciQS6NMm0tmzds5hI/6ZNpadGS0XqrZSe
 vJQ9w2BrIj+eodiAIVYkOQrmq+EmrR16POBtKSlcosMgZHJS21RG0GwiovnS0Wftu8Av
 yRCyutfb5sf4Iw0uCG9GvL1Lb65rrCnSb+TK95CIeRxhyNVLfDZd9E/dclaF/wI+JAXQ
 vx19MtuVox08PhC/QVFUi9SBmbIs9dOyELipZyMllqKeshq1buNd0hfP8XUqa41Je0Hh
 sE2g==
X-Gm-Message-State: ABy/qLbLUVal7SVbH6S6Roz0ILyG+tWyD9q6giQ0FSVu0tLQh+WWeMPL
 iiOWhtT1CgcIPGb99xUuBvy4PenEvHmXKs6rZO/5H8XGNIh6zRWVgq1o6ohtiIkTQ6d4INPRtLG
 jTi6hr1BjHVzGhxAuIfgzYcpMT1IVZqmy8Ntck+5Abg==
X-Received: by 2002:a5d:6507:0:b0:313:ef96:84c8 with SMTP id
 x7-20020a5d6507000000b00313ef9684c8mr8687897wru.67.1690273080450; 
 Tue, 25 Jul 2023 01:18:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPc/VAU250QGQYgpOMkW4RaBwKVZ3ddrW1YR4h8aiQOpLSV8Prs3MtGQBtJV+o8e48BrZ/aw==
X-Received: by 2002:a5d:6507:0:b0:313:ef96:84c8 with SMTP id
 x7-20020a5d6507000000b00313ef9684c8mr8687872wru.67.1690273080102; 
 Tue, 25 Jul 2023 01:18:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.123])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adfff86000000b0031274a184d5sm15506412wrr.109.2023.07.25.01.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 01:17:59 -0700 (PDT)
Date: Tue, 25 Jul 2023 10:17:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <5lemb27slnjt3hieixwa744ghzu6zj5fc3eimfng7a2ba7y2as@ueve2vn2cxpl>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230720214245.457298-3-AVKrasnov@sberdevices.ru>
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

On Fri, Jul 21, 2023 at 12:42:43AM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> Changelog:
> v2 -> v3:
>  * Comment about 'page_to_virt()' is updated. I don't remove R-b,
>    as this change is quiet small I guess.

Ack!

Thanks,
Stefano

>
> net/vmw_vsock/virtio_transport.c | 41 +++++++++++++++++++++++++++-----
> 1 file changed, 35 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..7bbcc8093e51 100644
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
>@@ -111,12 +113,39 @@ virtio_transport_send_pkt_work(struct work_struct *work)
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
>+				void *va;
>
>-		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>-		sgs[out_sg++] = &hdr;
>-		if (skb->len > 0) {
>-			sg_init_one(&buf, skb->data, skb->len);
>-			sgs[out_sg++] = &buf;
>+				/* We will use 'page_to_virt()' for the userspace page
>+				 * here, because virtio or dma-mapping layers will call
>+				 * 'virt_to_phys()' later to fill the buffer descriptor.
>+				 * We don't touch memory at "virtual" address of this page.
>+				 */
>+				va = page_to_virt(skb_frag->bv_page);
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
