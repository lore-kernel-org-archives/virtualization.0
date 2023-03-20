Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C4C6FD1D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 14:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9899F61008;
	Mon, 20 Mar 2023 14:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9899F61008
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Met1hgLl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PO66DVdoSt3o; Mon, 20 Mar 2023 14:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0D98660FFF;
	Mon, 20 Mar 2023 14:30:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D98660FFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA25FC0071;
	Mon, 20 Mar 2023 14:30:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFA1AC008A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADC82813B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:30:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADC82813B8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Met1hgLl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UDORJ-JZ0SE0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:30:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF09C813B1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF09C813B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679322612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYYltObAoBAJHBew4d0/wtXHVG5SadqFvZoyE4YqRs0=;
 b=Met1hgLlnsG3dRBgOXTnLgUSMerMG6EAN01dOJpfP/BV8+uaCO5K1/ko0Rd35Hv1yXbJ3a
 YP9QVWhlh7VtHbfU8vwB9cPWeKx/LhO0ur/ws94yR1NkvXCQ7W/eLBdGghTMWHJMJgkqSM
 q3qkIkK61aGH7t5n3hJFwMRE1eivn+A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-uC7bCzKBOUGQJHctgIkO2Q-1; Mon, 20 Mar 2023 10:30:10 -0400
X-MC-Unique: uC7bCzKBOUGQJHctgIkO2Q-1
Received: by mail-qk1-f197.google.com with SMTP id
 d187-20020a3768c4000000b00746864b272cso1176477qkc.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 07:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679322605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYYltObAoBAJHBew4d0/wtXHVG5SadqFvZoyE4YqRs0=;
 b=3M+DN9YnTqVP0JbOdv7OHxUFA5gwHcSZvnalguIedD86ylkVIMfoKtgU2dB7nO6uke
 tsg9QaOGp89ONohrHAXHrOyS0CNTS8dppPm2qY6a3AOKwfhARLS2jV1p/OTqYASgZwNk
 zaa2McQjgMho5Fb9QQW5lF+hf/H2axalN5Oh4pU8J3Ke01Y86t95nQXylkQyHwgDxxy8
 kuTa7vriD89Y8wjpS6hn5OULcH4WPZZ9I7FpT5LYbyon7jlgt0+MFAf+gbmJfjwQUsLz
 +20IYnm8PJa3yX+SHv+X9BIOZ9+H+HFta9oEMwOXR5j7ZtYmUZV8sYenvDS3lE3ZkD6c
 qlBA==
X-Gm-Message-State: AO0yUKXfb4A4VvR6ivBa6Q8QSZz3mYhvar++O0Xx9+CFDSemnoBD+vi5
 LvQ9TKYRuWRnqKH9z8uySJFOlGdZjwFWb6pN9DwhQJf93W0OFZJHaoW7wP1FX2jIYVdPMCshGvT
 3QRRuw7qcX21MjJoAnhDaMtasZ7dgbUQYRNUXA5LTwA==
X-Received: by 2002:ac8:4e42:0:b0:3d7:57b:467c with SMTP id
 e2-20020ac84e42000000b003d7057b467cmr29522681qtw.43.1679322605284; 
 Mon, 20 Mar 2023 07:30:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set9hlZuyivlx1H18m4rYyb3oaING8patBHWuxdHYD2CvI9lsFliZKypqpOpiOcNd9X094fyYsg==
X-Received: by 2002:ac8:4e42:0:b0:3d7:57b:467c with SMTP id
 e2-20020ac84e42000000b003d7057b467cmr29522623qtw.43.1679322604965; 
 Mon, 20 Mar 2023 07:30:04 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 t10-20020ac86a0a000000b003b9b48cdbe8sm6446788qtr.58.2023.03.20.07.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 07:30:04 -0700 (PDT)
Date: Mon, 20 Mar 2023 15:29:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2] virtio/vsock: allocate multiple skbuffs on tx
Message-ID: <20230320142959.2wwf474fiyp3ex5z@sgarzare-redhat>
References: <ea5725eb-6cb5-cf15-2938-34e335a442fa@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <ea5725eb-6cb5-cf15-2938-34e335a442fa@sberdevices.ru>
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

On Sun, Mar 19, 2023 at 09:46:10PM +0300, Arseniy Krasnov wrote:
>This adds small optimization for tx path: instead of allocating single
>skbuff on every call to transport, allocate multiple skbuff's until
>credit space allows, thus trying to send as much as possible data without
>return to af_vsock.c.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Link to v1:
> https://lore.kernel.org/netdev/2c52aa26-8181-d37a-bccd-a86bd3cbc6e1@sberdevices.ru/
>
> Changelog:
> v1 -> v2:
> - If sent something, return number of bytes sent (even in
>   case of error). Return error only if failed to sent first
>   skbuff.
>
> net/vmw_vsock/virtio_transport_common.c | 53 ++++++++++++++++++-------
> 1 file changed, 39 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 6564192e7f20..3fdf1433ec28 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -196,7 +196,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	const struct virtio_transport *t_ops;
> 	struct virtio_vsock_sock *vvs;
> 	u32 pkt_len = info->pkt_len;
>-	struct sk_buff *skb;
>+	u32 rest_len;
>+	int ret;
>
> 	info->type = virtio_transport_get_type(sk_vsock(vsk));
>
>@@ -216,10 +217,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>
> 	vvs = vsk->trans;
>
>-	/* we can send less than pkt_len bytes */
>-	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>-		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>-
> 	/* virtio_transport_get_credit might return less than pkt_len credit */
> 	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
>
>@@ -227,17 +224,45 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>-	skb = virtio_transport_alloc_skb(info, pkt_len,
>-					 src_cid, src_port,
>-					 dst_cid, dst_port);
>-	if (!skb) {
>-		virtio_transport_put_credit(vvs, pkt_len);
>-		return -ENOMEM;
>-	}
>+	ret = 0;
>+	rest_len = pkt_len;
>+
>+	do {
>+		struct sk_buff *skb;
>+		size_t skb_len;
>+
>+		skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE, rest_len);
>+
>+		skb = virtio_transport_alloc_skb(info, skb_len,
>+						 src_cid, src_port,
>+						 dst_cid, dst_port);
>+		if (!skb) {
>+			ret = -ENOMEM;
>+			break;
>+		}
>+
>+		virtio_transport_inc_tx_pkt(vvs, skb);
>+
>+		ret = t_ops->send_pkt(skb);
>+
>+		if (ret < 0)
>+			break;
>
>-	virtio_transport_inc_tx_pkt(vvs, skb);
>+		rest_len -= skb_len;

t_ops->send_pkt() is returning the number of bytes sent. Current
implementations always return `skb_len`, so there should be no problem,
but it would be better to put a comment here, or we should handle the
case where ret != skb_len to avoid future issues.

>+	} while (rest_len);
>
>-	return t_ops->send_pkt(skb);
>+	/* Don't call this function with zero as argument:
>+	 * it tries to acquire spinlock and such argument
>+	 * makes this call useless.

Good point, can we do the same also for virtio_transport_get_credit()?
(Maybe in a separate patch)

I'm thinking if may be better to do it directly inside the functions,
but I don't have a strong opinion on that since we only call them here.

Thanks,
Stefano

>+	 */
>+	if (rest_len)
>+		virtio_transport_put_credit(vvs, rest_len);
>+
>+	/* Return number of bytes, if any data has been sent. */
>+	if (rest_len != pkt_len)
>+		ret = pkt_len - rest_len;
>+
>+	return ret;
> }
>
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
