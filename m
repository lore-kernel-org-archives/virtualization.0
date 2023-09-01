Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB5ECA0FE1
	for <virtualization@archiver.kernel.org>; Fri,  1 Sep 2023 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E677542013;
	Fri,  1 Sep 2023 12:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E677542013
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fH9rtLuM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3RcP8JvhjyOO; Fri,  1 Sep 2023 12:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E5294200F;
	Fri,  1 Sep 2023 12:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E5294200F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F8C3C0039;
	Fri,  1 Sep 2023 12:37:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1D9FC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98A4583B58
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:37:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98A4583B58
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fH9rtLuM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZnYvQkB3YRXj
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:37:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF6C183B56
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF6C183B56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693571820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4h0vgqDbXZ9cKpY1IY0NrIgMllN6xWh52Qc3BdpfdQ=;
 b=fH9rtLuMJfFJPbaQtiWW86rfh4Ue45kcl5kiushrWShaP98sezZeEYzIF/FNmRUhaOjEaV
 v3HEWk876Rre0yk5vsz0p4UZTl3GN3Dm6S+Jbp7VAyT8mBqw4XX9/V0HvpMo6LIPiAcDb3
 nDLJ4Fs+O/hh3ZS7Vu3wvihHwD4yOhY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-SjFlieN0PYyAqdKkABGcgg-1; Fri, 01 Sep 2023 08:36:59 -0400
X-MC-Unique: SjFlieN0PYyAqdKkABGcgg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a5952a0b20so133018666b.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Sep 2023 05:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693571818; x=1694176618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4h0vgqDbXZ9cKpY1IY0NrIgMllN6xWh52Qc3BdpfdQ=;
 b=Ea3XasteaGMIRWpEeo4RS4b68k4HiUEPSkU3WGitQ0BcI2UYQeDsmI3K//8peyqiLp
 Q/VBzjG1jDOEYWklRoCdHY4euAr2KaJChfFRofMSmbFfjJQ6AEDAZ/OT395yNV6ukeD/
 g6CGQh17Iypk9T+8PYk7MMGRLOPy5JgH38LqzTjZA9ZjSH5BH2N3l9SkR5QeC4uiPjvg
 uut1XRSGGNPDJ0hCl/6BM/WgLSN4ypsPOvXNQ4FRa77jTqgu8Zh2waSXqcLBj4THihMr
 RGk9Qe2hwNzoYNkxA9kSdAbgvOjHpmWFH11Oi1wM6Bnfmyp8QgeiHGvfEQuhw98vcvkV
 f9Fg==
X-Gm-Message-State: AOJu0Yyj38jn9crB5TR/WruiZnYgQSgkozRdJQEBUOpPd/aGHmPQycQi
 NEU8meV+OEnjlwQ12wtj3aZHo6s+qwL4a+mDOraOXgsEOIDGxaV0fx0SpYvcUzCikTpIYa5MVJH
 MIhFBE5UAfw186CwVIR61O8A11bKjIVRs0Vrh8zozzw==
X-Received: by 2002:a17:906:113:b0:99b:4a29:fb6a with SMTP id
 19-20020a170906011300b0099b4a29fb6amr1706292eje.59.1693571818101; 
 Fri, 01 Sep 2023 05:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnc7ku06Rb323HLHpbRqxeg5/4zOqE3MmS5rXNzpID4yPpYKwGJsgULx/Y2zOMng08MkVbQg==
X-Received: by 2002:a17:906:113:b0:99b:4a29:fb6a with SMTP id
 19-20020a170906011300b0099b4a29fb6amr1706279eje.59.1693571817799; 
 Fri, 01 Sep 2023 05:36:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 tk26-20020a170907c29a00b009a1082f423esm1880381ejc.88.2023.09.01.05.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 05:36:57 -0700 (PDT)
Date: Fri, 1 Sep 2023 14:36:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v7 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <goakwa53hmon4aspdrjv3vrimy2b4sbv3unjwzhvn5fv5w7eqo@lvugg3vlrwga>
References: <20230827085436.941183-1-avkrasnov@salutedevices.com>
 <20230827085436.941183-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230827085436.941183-3-avkrasnov@salutedevices.com>
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

On Sun, Aug 27, 2023 at 11:54:34AM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v2 -> v3:
>  * Comment about 'page_to_virt()' is updated. I don't remove R-b,
>    as this change is quiet small I guess.
> v6 -> v7:
>  * Move arrays '*sgs' and 'bufs' to 'virtio_vsock' instead of being
>    local variables. This allows to save stack space in cases of too
>    big MAX_SKB_FRAGS.
>  * Add 'WARN_ON_ONCE()' for handling nonlinear skbs - it checks that
>    linear part of such skb contains only header.
>  * R-b tag removed due to updates above.
>
> net/vmw_vsock/virtio_transport.c | 54 +++++++++++++++++++++++++++-----
> 1 file changed, 47 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..8636477cf088 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -63,6 +63,10 @@ struct virtio_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+

I'd add a comment here specifying specifying what we need these fields
for and why we put them here (basically Paolo's suggestion).

>+	/* +1 is for packet header. */
>+	struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>+	struct scatterlist bufs[MAX_SKB_FRAGS + 1];
> };
>
> static u32 virtio_transport_get_local_cid(void)
>@@ -100,8 +104,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 	vq = vsock->vqs[VSOCK_VQ_TX];
>
> 	for (;;) {
>-		struct scatterlist hdr, buf, *sgs[2];
> 		int ret, in_sg = 0, out_sg = 0;
>+		struct scatterlist **sgs;
>+		struct scatterlist *bufs;
> 		struct sk_buff *skb;
> 		bool reply;
>
>@@ -111,12 +116,47 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
>-
>-		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>-		sgs[out_sg++] = &hdr;
>-		if (skb->len > 0) {
>-			sg_init_one(&buf, skb->data, skb->len);
>-			sgs[out_sg++] = &buf;
>+		sgs = vsock->sgs;
>+		bufs = vsock->bufs;
>+		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
>+			    sizeof(*virtio_vsock_hdr(skb)));
>+		sgs[out_sg] = &bufs[out_sg];

IIUC `sgs[i]` always contains `&bufs[i]`.

Could we initialize it once when we allocate `struct virtio_vsock` in
`virtio_vsock_probe`?

Of course putting a comment in `struct virtio_vsock` about it.

Since we are using them only for out buffers, I'd also rename them in
out_sgs and out_bufs.

The rest LGTM.

Stefano

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
>+			/* If skb is nonlinear, then its buffer must contain
>+			 * only header and nothing more. Data is stored in
>+			 * the fragged part.
>+			 */
>+			WARN_ON_ONCE(skb_headroom(skb) != sizeof(*virtio_vsock_hdr(skb)));
>+
>+			si = skb_shinfo(skb);
>+
>+			for (i = 0; i < si->nr_frags; i++) {
>+				skb_frag_t *skb_frag = &si->frags[i];
>+				void *va;
>+
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
