Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585FEEB64DA
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 15:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D845B4093C;
	Mon, 26 Jun 2023 15:24:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D845B4093C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EMJD1d0k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ftc5zBA5r8FH; Mon, 26 Jun 2023 15:24:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C94E40945;
	Mon, 26 Jun 2023 15:24:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C94E40945
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E34E6C0037;
	Mon, 26 Jun 2023 15:24:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6526BC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EB3940945
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:24:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EB3940945
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kBVmV79flKri
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:24:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 364594093C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 364594093C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687793061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNcIf8DGlU4ngflbaStrLY/OgH3ZgZfAt2j/tScjlPs=;
 b=EMJD1d0kiJIFP239eocucgc83eHmiJHXrGzPkkqrddhHn5WwmfMHZ3PsYliEMe+ffmMNNR
 zoJCQGZ/l33VNoQpIaQXGzDMYWRdPkFugmofEtoEe8K0JSkcgY9jDHLOy1oKCXyXtCugT/
 sgvf2hMxAb4g7joz+qiPPO0yxSmvc20=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-e7j2x4NpO6mSteMeWk8RNg-1; Mon, 26 Jun 2023 11:24:18 -0400
X-MC-Unique: e7j2x4NpO6mSteMeWk8RNg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765986c0568so212687285a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 08:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793052; x=1690385052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNcIf8DGlU4ngflbaStrLY/OgH3ZgZfAt2j/tScjlPs=;
 b=Oeb394WAWrneYD7f+9Hp0mXfwvDENiNJ/e4CYMfMzsrbPSCYV4VPx77+X94HA9ghiT
 Sdc7HdOytbFpe+dlHrKrrO9ETvFqRfcbU0QZwjnmCz+1TSQu8C1W+yha7V0JQpjnwEy2
 ynOt1ZQfZ5qABU7oolZFcOObXF58osyOlMZj/SY2/c9uLIoRn8nRVZ+H/GFn+6cjmo+0
 pHlr9UZJIUFcW/VB9IiPanKlOLXAS/LlhhnjzOdmhWZ47ESWptC5DxCoZHJcdOshgwkl
 6KCsAAZUjhU1GvtHbVJv6zxz8gwFdI3/XnQ0LekQjZlgVogvdH1tJ6zKkuTk54aqPv9G
 uZ1Q==
X-Gm-Message-State: AC+VfDyF4yMT24c0hFAZxMlsa1MXWvisqW8hWbqNLfD8tLDf1xH5chFb
 Tmo9KDrTWTW4kA4kZwPuVUec2cm3Hg8MQj1HZ+dnyKCzXwWYJwQUjsyIVM0LoRTriIkUVg+Q5/7
 s20fCYhCN3xDsS7q+FlqnLdZSgFOZHERoHOMTWj6rBg==
X-Received: by 2002:a05:620a:880f:b0:75b:23a1:363d with SMTP id
 qj15-20020a05620a880f00b0075b23a1363dmr20468179qkn.78.1687793052464; 
 Mon, 26 Jun 2023 08:24:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67krRALDwbYzxNGPfYizrvdl7LS+HU+avZAWHRkye9gBvomn4n/ypyeI8Y0aTbS2T5cmmDUw==
X-Received: by 2002:a05:620a:880f:b0:75b:23a1:363d with SMTP id
 qj15-20020a05620a880f00b0075b23a1363dmr20468165qkn.78.1687793052227; 
 Mon, 26 Jun 2023 08:24:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 y24-20020a37e318000000b007579ea33cdesm2785460qki.62.2023.06.26.08.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:24:11 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:24:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 02/17] vhost/vsock: read data from non-linear skb
Message-ID: <vpcrdclcic7oiuat4oapnkj54dolld6hh2wixe3fozlthyt2ni@omyjyem3uj3t>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-3-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:24PM +0300, Arseniy Krasnov wrote:
>This adds copying to guest's virtio buffers from non-linear skbs. Such
>skbs are created by protocol layer when MSG_ZEROCOPY flags is used. It
>changes call of 'copy_to_iter()' to 'skb_copy_datagram_iter()'. Second
>function can read data from non-linear skb.
>
>See commit to 'net/vmw_vsock/virtio_transport_common.c' with the same
>name for more details.

I think it's okay if we report the same details here.

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> drivers/vhost/vsock.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 6578db78f0ae..b254aa4b756a 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -156,7 +156,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		}
>
> 		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
>-		payload_len = skb->len;
>+		payload_len = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off;

Also here a variable should make the code more readable.

Stefano

> 		hdr = virtio_vsock_hdr(skb);
>
> 		/* If the packet is greater than the space available in the
>@@ -197,8 +197,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			break;
> 		}
>
>-		nbytes = copy_to_iter(skb->data, payload_len, &iov_iter);
>-		if (nbytes != payload_len) {
>+		if (skb_copy_datagram_iter(skb,
>+					   VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+					   &iov_iter,
>+					   payload_len)) {
> 			kfree_skb(skb);
> 			vq_err(vq, "Faulted on copying pkt buf\n");
> 			break;
>@@ -212,13 +214,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
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
