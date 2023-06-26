Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A142EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B30140948;
	Mon, 26 Jun 2023 16:23:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B30140948
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gCTyNLqh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AxNVJRnXm-jA; Mon, 26 Jun 2023 16:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE54D408E6;
	Mon, 26 Jun 2023 16:23:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE54D408E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9377DC007A;
	Mon, 26 Jun 2023 16:23:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 379B1C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 124EA81441
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 124EA81441
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gCTyNLqh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqoKMRp2hU-4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:23:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A917E81420
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A917E81420
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687796619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goJ82gfmaMLDwx1lebPuhQrFW0gpPX2fa0/sdreNvaA=;
 b=gCTyNLqhU4T8dOEJszJBEFhBPMv1ovrOEghXB5werMd0F04B5ydNW51GqjC/BtbWK32q1y
 bsBqlAUV5EsblBRkRoaS7wwyBom1vOpWrTIsRUT7jtxE6tb4wguxvmh6ydSG/eRrergdpD
 jClKDodLXbFH5muSIL1j4uvAEe3vDhk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-aPva5xwiNDatNMV-XAOQrg-1; Mon, 26 Jun 2023 12:23:38 -0400
X-MC-Unique: aPva5xwiNDatNMV-XAOQrg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-400a5d66a5bso13711931cf.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687796617; x=1690388617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goJ82gfmaMLDwx1lebPuhQrFW0gpPX2fa0/sdreNvaA=;
 b=PQsjJ3T2q0C9bkbXkdbu8GpvWZBIdCofOmyZ80q5qoEwjSKfvaczmDvt85Bq6x2eFO
 RXuZYtA45mVkwKyD+8+44mDtC7TnuDm5GKwxTqIqu1HwzPl0aD2Tejqf/jI2pgPbic3f
 t1JhqtMnZ1a5wv0FZCb/SwW85HRmuJzMYxlWMu4w+4NJTir/2H6i09B/cW4sBpo/l29R
 KEqBKC2/EtY6GvlGGGOzSvlcgRPMCqcnFkeAB5gfK6slU8ns09viTKlhZPfCq3hoPKYW
 5KUIhVS3VoCEOHGqYUNbv3u7RdfHKexw6VhbpjoSx4yAOZMoYXziCnV+jZPYvTEWN7ab
 koCg==
X-Gm-Message-State: AC+VfDxXhovWAB9DBa+hgzrrLj3UJUKezQV6lOqJ6SPgb70Ycui/CfaF
 roMavLWz7avXmRoy3f84t97R88ADUuJVFGCyFpt6Ms3fgMBhLnw58tNsW+a8mdtUSEpD8YP7c54
 za9+M/5eqyomgkG6MhxpkjHSO1ufcAyx3lLgrcIS9zw==
X-Received: by 2002:a05:622a:5cc:b0:3ff:28a6:b507 with SMTP id
 d12-20020a05622a05cc00b003ff28a6b507mr27045076qtb.62.1687796617354; 
 Mon, 26 Jun 2023 09:23:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Fcw3HZ9CsPSMizS0+mFl35ikBhcBByAiRtmV5dvu+j35EXovmFwfSrDE8p+YUssGNZi+Ntg==
X-Received: by 2002:a05:622a:5cc:b0:3ff:28a6:b507 with SMTP id
 d12-20020a05622a05cc00b003ff28a6b507mr27045049qtb.62.1687796617099; 
 Mon, 26 Jun 2023 09:23:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 cm23-20020a05622a251700b003e4ee0f5234sm3211789qtb.87.2023.06.26.09.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:23:36 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:23:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [RFC PATCH v1 1/4] virtio/vsock: rework MSG_PEEK for SOCK_STREAM
Message-ID: <fumoatu4z5pvqntnqa6hnuripfa4zrtb5m2rsfkfsdn23pn5y5@f7yy23tjxwwa>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
 <20230618062451.79980-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230618062451.79980-2-AVKrasnov@sberdevices.ru>
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

On Sun, Jun 18, 2023 at 09:24:48AM +0300, Arseniy Krasnov wrote:
>This reworks current implementation of MSG_PEEK logic:
>1) Replaces 'skb_queue_walk_safe()' with 'skb_queue_walk()'. There is
>   no need in the first one, as there are no removes of skb in loop.
>2) Removes nested while loop - MSG_PEEK logic could be implemented
>   without it: just iterate over skbs without removing it and copy
>   data from each until destination buffer is not full.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 41 ++++++++++++-------------
> 1 file changed, 19 insertions(+), 22 deletions(-)

Great clean up!

LGTM, but @Bobby can you also take a look?

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..2ee40574c339 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -348,37 +348,34 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 				size_t len)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>-	size_t bytes, total = 0, off;
>-	struct sk_buff *skb, *tmp;
>-	int err = -EFAULT;
>+	struct sk_buff *skb;
>+	size_t total = 0;
>+	int err;
>
> 	spin_lock_bh(&vvs->rx_lock);
>
>-	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
>-		off = 0;
>+	skb_queue_walk(&vvs->rx_queue, skb) {
>+		size_t bytes;
>
>-		if (total == len)
>-			break;
>+		bytes = len - total;
>+		if (bytes > skb->len)
>+			bytes = skb->len;
>
>-		while (total < len && off < skb->len) {
>-			bytes = len - total;
>-			if (bytes > skb->len - off)
>-				bytes = skb->len - off;
>+		spin_unlock_bh(&vvs->rx_lock);
>
>-			/* sk_lock is held by caller so no one else can dequeue.
>-			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>-			 */
>-			spin_unlock_bh(&vvs->rx_lock);
>+		/* sk_lock is held by caller so no one else can dequeue.
>+		 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+		 */
>+		err = memcpy_to_msg(msg, skb->data, bytes);
>+		if (err)
>+			goto out;
>
>-			err = memcpy_to_msg(msg, skb->data + off, bytes);
>-			if (err)
>-				goto out;
>+		total += bytes;
>
>-			spin_lock_bh(&vvs->rx_lock);
>+		spin_lock_bh(&vvs->rx_lock);
>
>-			total += bytes;
>-			off += bytes;
>-		}
>+		if (total == len)
>+			break;
> 	}
>
> 	spin_unlock_bh(&vvs->rx_lock);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
