Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F176C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:49:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0D764DBD
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0D764DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CF2F6060E;
	Tue, 23 Feb 2021 13:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKn-sHRSMIJB; Tue, 23 Feb 2021 13:49:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81064605FB;
	Tue, 23 Feb 2021 13:49:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E06AC000A;
	Tue, 23 Feb 2021 13:49:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99A72C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 952AC87205
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1tkGoy15QHaX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:49:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E188387196
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614088168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOvexyYc/ObMQAaHFdie5/nomXHMwOs8rdABZEM/9Ps=;
 b=K0ItB7EQyxic1DYoMmmsyQTV9a0z1KHzipxJc1w24WSzqQ3M30NkXl9hLs/EVxyukVuTtQ
 9KGDAClM5/NvaXM6vtVK4HB8eLTF8L8V3xg+KuypfiiWntJJy+T/PL0zn0mHJQXwxtUFJv
 aIJX/iJXv+N0MCQszS0XKbBvn3dDuv0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-miiTYMjvMZGrB0LZxmJ2lw-1; Tue, 23 Feb 2021 08:49:24 -0500
X-MC-Unique: miiTYMjvMZGrB0LZxmJ2lw-1
Received: by mail-wm1-f70.google.com with SMTP id n6so62119wmd.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 05:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GOvexyYc/ObMQAaHFdie5/nomXHMwOs8rdABZEM/9Ps=;
 b=ofjIG69MMrL1DdyjHKaf5ElYdqnecMNOQ+GmlVOPD+bVSebNKoy0d/7c+OUswEmHXW
 EUGJyVmq1ER+o4XU8jqHhbRsPQLfOE8AijxdttaXsyhEdil/0RR1s8h2IWQWA2PqPw0y
 YlQ2fa6yplm3Yn5ykEaXbRl6GsFm+3tEZ79s8QvpEcHkZl+GvZ7C8aBwmJdh+ypJrcyx
 3Db1bWGKBoBBT+iVicF2onZSeJJtu2eOfzi66DjRDgJJdnlA1Lup0GG4Bxh3/jmDPjdS
 B2Qxb16gOyJfyJgbmGd2MJie9npdxCkDIHMK06Wp5pGlgw4L3XvsTPJd0pNXK0FFYquH
 0Jpw==
X-Gm-Message-State: AOAM5335WjWxk+2PQKeUYfByw4BmKIGgPmYYm6/nslTdy5q53HPtqtrw
 o/mryHVsic/P7CLQY/yuFtv32U5UK5DIXKqLoFCdPtw3yUifYwECYywJuAuI4Oo+E+nSrJtw//Z
 ggRWai+/q7dAOGU5fQsf+sWYCiZHv4UGQvYK+Mpnbqw==
X-Received: by 2002:a1c:b741:: with SMTP id h62mr17331299wmf.85.1614088163363; 
 Tue, 23 Feb 2021 05:49:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWyIcShiLHe07mw9HE/r5BInLl+NukEK8C2wh6/ekL9Dgw0dtDjxRuJKOsywf6vYjLteh5cg==
X-Received: by 2002:a1c:b741:: with SMTP id h62mr17331273wmf.85.1614088163149; 
 Tue, 23 Feb 2021 05:49:23 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s84sm198526wme.11.2021.02.23.05.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 05:49:22 -0800 (PST)
Date: Tue, 23 Feb 2021 14:49:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 10/19] virtio/vsock: simplify credit update
 function API
Message-ID: <20210223134920.nvecqujytdfcqnbt@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053926.1068053-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053926.1068053-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Thu, Feb 18, 2021 at 08:39:23AM +0300, Arseny Krasnov wrote:
>'virtio_transport_send_credit_update()' has some extra args:
>1) 'type' may be set in 'virtio_transport_send_pkt_info()' using type
>   of socket.
>2) This function is static and 'hdr' arg was always NULL.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 15 ++++-----------
> 1 file changed, 4 insertions(+), 11 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1c9d71ca5e8e..833104b71a1c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -271,13 +271,10 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_put_credit);
>
>-static int virtio_transport_send_credit_update(struct vsock_sock *vsk,
>-					       int type,
>-					       struct virtio_vsock_hdr *hdr)
>+static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
>-		.type = type,
> 		.vsk = vsk,
> 	};

I don't know if it's better to remove type with the others changes in 
the previous patch, maybe it's more consistent.

I mean only the removal of 'type' parameter, the 'hdr' parameter should 
be removed with this patch.

>
>@@ -385,11 +382,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * messages, we set the limit to a high value. TODO: experiment
> 	 * with different values.
> 	 */
>-	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
>-		virtio_transport_send_credit_update(vsk,
>-						    
>VIRTIO_VSOCK_TYPE_STREAM,
>-						    NULL);
>-	}
>+	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>
>@@ -498,8 +492,7 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val)
>
> 	vvs->buf_alloc = *val;
>
>-	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
>-					    NULL);
>+	virtio_transport_send_credit_update(vsk);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_notify_buffer_size);
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
