Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D46EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 15:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38290418E1;
	Mon, 26 Jun 2023 15:43:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38290418E1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eH7cFdmX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDADIxdGCfrp; Mon, 26 Jun 2023 15:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F1B2D418DD;
	Mon, 26 Jun 2023 15:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1B2D418DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C441CC0037;
	Mon, 26 Jun 2023 15:43:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 713F1C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36B00418DE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36B00418DE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Op6pmPbTJyfK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:43:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24D56418DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24D56418DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687794207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHL9J0eB4Sdz9Nc78m+y6P53irdo4gKn3Uc9907MynE=;
 b=eH7cFdmXiDbiwYoc/Q920Y2+Ggl8p/XObW+QJNhB0hl4N+UobPYc90m9YgUNs14T8434vC
 jXg0HL6qJiB92FWH6WW3B7hbmZ6KZpdVGZ15/1vILsmNkeXtDme7k4U4lqnD4kNxJBoy1H
 IKN7NURyc9kYO1ZSAqaH0JTuZ7ISPJA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-W5C56YH3OaKtmXAHIE6mHg-1; Mon, 26 Jun 2023 11:43:23 -0400
X-MC-Unique: W5C56YH3OaKtmXAHIE6mHg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-763a36c3447so329725485a.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 08:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687794199; x=1690386199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHL9J0eB4Sdz9Nc78m+y6P53irdo4gKn3Uc9907MynE=;
 b=fgNckK50u7NWIm26ar2+yPvX4H6tex8Vbz3vPZHAEzbhzjopwWLBygnosasIHV/vG9
 938/kolGvkeH42Rw+Oysw9FZJ5VSySISFbL8extemk2cRwbdROFQ5yOi9X6zju6O6Ts6
 WwiwXPkQ+A3wzncw6oHBQs3FCpLrr2dMYPPd0AyLstQKpaPkFNU83fhcpfYZ79mNC/9+
 TuNmibB0nq+flWMMHNpPP2wCzQGvtybu/Vsk6Bvb/ZM9h6jupf9UVNP0WMf8PLabBgq6
 SCQGbJ++25mZF4Y1nJZNByDO0qxKWEFa0WqfvPQtV9mHsZHLwDitsg7zgb4lzVqPAJHR
 A12Q==
X-Gm-Message-State: AC+VfDwyGDqgyPZOPqTAZ8NzZ2X4dUCBPTQDwQ9/Jk4TMRBQQiKVEugK
 tzB/64tzia4SkMrqc9CXFdxE4KPURc/K7Jt5NY9sCWYcGTatDTuVra4tpG5U+4AFWTIzLslcjh2
 KOvxm51vkbsZmZLQtWM/Pd26/Cg/iZIaKRDWQsSZNOg==
X-Received: by 2002:a05:620a:24cf:b0:765:a828:7d02 with SMTP id
 m15-20020a05620a24cf00b00765a8287d02mr4274661qkn.24.1687794199782; 
 Mon, 26 Jun 2023 08:43:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wo4oIIXt+M60hxTpJtMEqYtBvIw+eoptPK+6HuXbpu6oq7q8v2GIbBoAcgQwaiCeGYHwlTw==
X-Received: by 2002:a05:620a:24cf:b0:765:a828:7d02 with SMTP id
 m15-20020a05620a24cf00b00765a8287d02mr4274641qkn.24.1687794199542; 
 Mon, 26 Jun 2023 08:43:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 w10-20020a05620a148a00b00761fae866c7sm2807410qkj.76.2023.06.26.08.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:43:19 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:43:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 04/17] vsock/virtio: non-linear skb handling for tap
Message-ID: <gp4xniaudmgaeij677g4eylbizhjtk6e7l5modpxb2dwqygnse@5ceugoevrtht>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-5-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:26PM +0300, Arseniy Krasnov wrote:
>For tap device new skb is created and data from the current skb is
>copied to it. This adds copying data from non-linear skb to new
>the skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 31 ++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 5819a9cd4515..0de562c1dc4b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -106,6 +106,27 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	return NULL;
> }
>
>+static void virtio_transport_copy_nonlinear_skb(struct sk_buff *skb,

`const struct sk_buff *skb` should be better also to understand that
the function copy data from *skb to *dst.

>+						void *dst,
>+						size_t len)
>+{
>+	struct iov_iter iov_iter = { 0 };
>+	struct kvec kvec;
>+	size_t to_copy;
>+
>+	kvec.iov_base = dst;
>+	kvec.iov_len = len;
>+
>+	iov_iter.iter_type = ITER_KVEC;
>+	iov_iter.kvec = &kvec;
>+	iov_iter.nr_segs = 1;
>+
>+	to_copy = min_t(size_t, len, skb->len);
>+
>+	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+			       &iov_iter, to_copy);
>+}
>+
> /* Packet capture */
> static struct sk_buff *virtio_transport_build_skb(void *opaque)
> {
>@@ -114,7 +135,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	struct af_vsockmon_hdr *hdr;
> 	struct sk_buff *skb;
> 	size_t payload_len;
>-	void *payload_buf;
>
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
>@@ -122,7 +142,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 	payload_len = pkt->len;
>-	payload_buf = pkt->data;
>
> 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
> 			GFP_ATOMIC);
>@@ -165,7 +184,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>
> 	if (payload_len) {
>-		skb_put_data(skb, payload_buf, payload_len);
>+		if (skb_is_nonlinear(pkt)) {
>+			void *data = skb_put(skb, payload_len);
>+
>+			virtio_transport_copy_nonlinear_skb(pkt, data, 
>payload_len);
>+		} else {
>+			skb_put_data(skb, pkt->data, payload_len);
>+		}
> 	}
>
> 	return skb;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
