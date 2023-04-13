Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF9AC77B61
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 09:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2422641F64;
	Thu, 13 Apr 2023 09:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2422641F64
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ICcPmDg7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9DQtHI1Lf-J; Thu, 13 Apr 2023 09:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6190241DF3;
	Thu, 13 Apr 2023 09:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6190241DF3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17FB6C0036;
	Thu, 13 Apr 2023 09:14:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93336C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 09:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DA1260D78
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 09:14:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DA1260D78
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ICcPmDg7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IH3i6BV6Ctau
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 09:14:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6AB560ABB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6AB560ABB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681377251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dyzRm431VL1Fbej5RMckdPouF+WGu3yZlZlqm5Jr8zA=;
 b=ICcPmDg7rcYwuNJ8Hh9oS3zUfWcCq/9tQRTZzu6Hva/ToAqYuTTOaHQgdLUKvbHFsz02XL
 W7QLPiS2YM1tB7uvWa+z8pQoRdsN+kyw2VvyqZjeBG3t9oclCWBhfDVnycwYIqi1DqPGGe
 PSU2/5M8bWzFlMxNGhEP4S7MC7u0Xe4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-8RMq-z5mP-WUFpdI7uBIpQ-1; Thu, 13 Apr 2023 05:14:07 -0400
X-MC-Unique: 8RMq-z5mP-WUFpdI7uBIpQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 d184-20020a37b4c1000000b007467c5d3abeso7191877qkf.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 02:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681377247; x=1683969247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyzRm431VL1Fbej5RMckdPouF+WGu3yZlZlqm5Jr8zA=;
 b=iTS+T/5Kq/zaUb5Ynnd4tPhVF1IavMMRCIo5t42XGa18dw5+kctilLv9mI7Y89jS7o
 bgM/OVNjHqlhUfQgSpZekMGVdDae/sJPWfwYbAPYAGKRta+c0weJIP1LkdXMsxoEadlz
 UHVqAC3wnWtIhIXMNUmUUBPrj4ovrRGFfzZrE4V2/LQdtt9cBLDGo2nCWaNKXWPc8yI5
 geUI4/DcbxqoeEItIyx4nfKb+fPBrqz8eUgpn7VSgo13YpQZ5yfyT0eksgn+6WMQo4fW
 Rn+ri/EqlfsBChRSlnMNeO0FvrcTYikhDg5V6fFag/HXWZNFRNF0KIEnvDNKH+4fMAoR
 UOeA==
X-Gm-Message-State: AAQBX9eaT7kwX4Y48ipcePvKx7IxcMGB8IX1hHkEbgkMe5IwnkZB0Foe
 2EleJKEnAEsmcH9rBjuVH9zJs/s768ojPG1f4ObE7v/89SZjGVd3Ciu4WHq7ZYXQm0qqda6IDlR
 lMYFONrKGnEx0ygTi5sgu8PPZNbJM0jgEOoHusYeS3Q==
X-Received: by 2002:ac8:7e95:0:b0:3e3:8e55:1e64 with SMTP id
 w21-20020ac87e95000000b003e38e551e64mr2377952qtj.14.1681377247476; 
 Thu, 13 Apr 2023 02:14:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350YIU+TgyV60nszZOUUj8q3myAkq179cnjkKyv9e28PXemEbrxintxbe43QqEzW46gKSh3J/rw==
X-Received: by 2002:ac8:7e95:0:b0:3e3:8e55:1e64 with SMTP id
 w21-20020ac87e95000000b003e38e551e64mr2377935qtj.14.1681377247280; 
 Thu, 13 Apr 2023 02:14:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 l22-20020ac81496000000b003e4c6b2cc35sm359795qtj.24.2023.04.13.02.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Apr 2023 02:14:06 -0700 (PDT)
Date: Thu, 13 Apr 2023 11:14:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] vsock/loopback: don't disable irqs for queue access
Message-ID: <m6zafomiasxi7fdlejxqebvq5lkjwo3wvpkc7xa6tzfa7ywfy6@bswd76cx772g>
References: <b6dd26b3-97d7-ef8e-d8f8-a0e728fa2b02@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <b6dd26b3-97d7-ef8e-d8f8-a0e728fa2b02@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, oxffffaa@gmail.com, kernel@sberdevices.ru,
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

On Sun, Apr 09, 2023 at 10:17:51PM +0300, Arseniy Krasnov wrote:
>This replaces 'skb_queue_tail()' with 'virtio_vsock_skb_queue_tail()'.
>The first one uses 'spin_lock_irqsave()', second uses 'spin_lock_bh()'.
>There is no need to disable interrupts in the loopback transport as
>there is no access to the queue with skbs from interrupt context. Both
>virtio and vhost transports work in the same way.

Yep, this is a good point!

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vsock_loopback.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

LGTM! (net-next material)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index e3afc0c866f5..5c6360df1f31 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -31,8 +31,7 @@ static int vsock_loopback_send_pkt(struct sk_buff *skb)
> 	struct vsock_loopback *vsock = &the_vsock_loopback;
> 	int len = skb->len;
>
>-	skb_queue_tail(&vsock->pkt_queue, skb);
>-
>+	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>
> 	return len;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
