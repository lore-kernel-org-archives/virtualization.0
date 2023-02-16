Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E59C636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 14:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5937A60736;
	Thu, 16 Feb 2023 14:19:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5937A60736
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XoPKYFho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jof9ZZSLgcOp; Thu, 16 Feb 2023 14:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A345F605B1;
	Thu, 16 Feb 2023 14:19:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A345F605B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D928C0032;
	Thu, 16 Feb 2023 14:19:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 309DAC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F13BC418C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:19:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F13BC418C0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XoPKYFho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4U_BfU2RgKTG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:19:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 042F1418BB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 042F1418BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676557143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pchzyi+iGSx4x4FUy9UsNRB/fTEcGnGSHaYZsjr+hLc=;
 b=XoPKYFhoHfI6N26kj0JoQveaX/HNnEFqoM9JpCATC93jVFp6LsGQZ9NTMW2RY6JRauZuRu
 QBBiiSQOPrsxuC3Ph4ud9D6aCwPQicIJAsTwN8b0d3GR4NmB8ARjhQH1LJcWgaXp9QPThu
 pdA9SRpCiu9lFZXWxJhHbtA7w8kUoRM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-v_2Xl1TWMF2yUgtT7dCbug-1; Thu, 16 Feb 2023 09:19:02 -0500
X-MC-Unique: v_2Xl1TWMF2yUgtT7dCbug-1
Received: by mail-qv1-f71.google.com with SMTP id
 v10-20020a0cf90a000000b0056f060452adso323674qvn.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 06:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pchzyi+iGSx4x4FUy9UsNRB/fTEcGnGSHaYZsjr+hLc=;
 b=Z/wPY72sE8ekc9HWnsgs6dB+35MDmGBV3Mf2VcX9bEDPPrUOtbxI2p28EccDDR593p
 f7JyIEaW+UYSZpdIOYr2iUxH8O8hlKW7fYRnTGzv8wMiT5GEcXpXdSI+5BsREpnFUMgN
 CDsDJPnI2agiR9FqybzFKtzQrgJh6Y2dxPzRSFbdkJCP3xOZecuu5+V/9EimyqyIh2SR
 ftMBLif7IyqHAo5THF6FrLOjFMN3C5NL+cZO0SAMJAjyW70Aw5chr6ZdnnIPJ3vdH57G
 +Kg+B3WhN9PBYa38CelvysBFhSq7MuxsKprnXWlNgkr0aBU0U8WAnw4LBsD25urqqdAA
 rlvw==
X-Gm-Message-State: AO0yUKWfIkPz2yJ2TyVrWZnxSgQPl1PnXJ6xffN+IsKl/6FqmvWVwcX5
 KlAZzha7TP1ykSw0W03CI7rEgyqXYfGWWWUh3V7LlSqGoijkR5/lFO2QrCViuu9/OSCa8SS5Za+
 CZfpOjX2UwPL+Wq2ZvTwZ7s9wBel9H14oXHAeacX0Ig==
X-Received: by 2002:a05:622a:1492:b0:3b8:52b6:a313 with SMTP id
 t18-20020a05622a149200b003b852b6a313mr11672819qtx.30.1676557142031; 
 Thu, 16 Feb 2023 06:19:02 -0800 (PST)
X-Google-Smtp-Source: AK7set+fxS4JhBoepOcXeUJoLRmfP/igXjolczTeDHypWOV4T3CC6+zz+5nMobryi+/8kbpvaTg/2g==
X-Received: by 2002:a05:622a:1492:b0:3b8:52b6:a313 with SMTP id
 t18-20020a05622a149200b003b852b6a313mr11672776qtx.30.1676557141742; 
 Thu, 16 Feb 2023 06:19:01 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 205-20020a370ad6000000b0073b76f9409csm1278267qkk.14.2023.02.16.06.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 06:19:01 -0800 (PST)
Date: Thu, 16 Feb 2023 15:18:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 05/12] vsock/virtio: non-linear skb support
Message-ID: <20230216141856.fnczv3ui6d3lpujy@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <b3060caf-df19-f1df-6d27-4e58f894c417@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <b3060caf-df19-f1df-6d27-4e58f894c417@sberdevices.ru>
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

On Mon, Feb 06, 2023 at 06:58:24AM +0000, Arseniy Krasnov wrote:
>Use pages of non-linear skb as buffers in virtio tx queue.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport.c | 31 +++++++++++++++++++++++++------
> 1 file changed, 25 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 28b5a8e8e094..b8a7d6dc9f46 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -100,7 +100,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 	vq = vsock->vqs[VSOCK_VQ_TX];
>
> 	for (;;) {
>-		struct scatterlist hdr, buf, *sgs[2];
>+		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>+		struct scatterlist bufs[MAX_SKB_FRAGS + 1];

+ 1 is for the header, right?
I'd add a comment just to be clear ;-)

> 		int ret, in_sg = 0, out_sg = 0;
> 		struct sk_buff *skb;
> 		bool reply;
>@@ -111,12 +112,30 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
>+		sg_init_one(&bufs[0], virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
>+		sgs[out_sg++] = &bufs[0];
>+
>+		if (skb_is_nonlinear(skb)) {
>+			int i;
>+
>+			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
>+				struct page *data_page = skb_shinfo(skb)->frags[i].bv_page;
>+
>+				/* We will use 'page_to_virt()' for userspace page here,
>+				 * because virtio layer will call 'virt_to_phys()' later
>+				 * to fill buffer descriptor. We don't touch memory at
>+				 * "virtual" address of this page.
>+				 */

IIUC data_page is a user page, so since we are exposing it to the host,
I think we should pin it.

Is data_page always a user page, or can it be a kernel page when skb is 
nonlinear?

Thanks,
Stefano

>+				sg_init_one(&bufs[i + 1],
>+					    page_to_virt(data_page), PAGE_SIZE);
>+				sgs[out_sg++] = &bufs[i + 1];
>+			}
>+		} else {
>+			if (skb->len > 0) {
>+				sg_init_one(&bufs[1], skb->data, skb->len);
>+				sgs[out_sg++] = &bufs[1];
>+			}
>
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
