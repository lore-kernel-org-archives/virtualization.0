Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C3C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:39:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FE264E77
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FE264E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5A26F8733C;
	Thu, 11 Feb 2021 14:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd6M7vFJ+v7Y; Thu, 11 Feb 2021 14:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 884F986791;
	Thu, 11 Feb 2021 14:39:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58F56C0891;
	Thu, 11 Feb 2021 14:39:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 273B8C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 16649871C8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ya--Oh-bM7LA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:39:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 63FE786791
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613054371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cQ4WX5LrjUBO2B/BlX8QGxVMDWmqK2VEqVOioz82st4=;
 b=cZ8pnvnnnzMs+eHVnsqMEWjHhTyKalYKAXshNOuYTMRVMs2vP3M71P3B2vlzk5c0eIbOsE
 ZZLaL/9lH5btaAbr7N5wc4e/lumOKbrQiDo0yShTwLOurUTfPh7AK+oy97LIxhXwzQTWy+
 2Mnj5+/tV0a0PiM49jVvJBgiDFU42v0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-0JF3Y9LANS2WMHnB2u0Dog-1; Thu, 11 Feb 2021 09:39:27 -0500
X-MC-Unique: 0JF3Y9LANS2WMHnB2u0Dog-1
Received: by mail-ej1-f72.google.com with SMTP id hx26so4809439ejc.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 06:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cQ4WX5LrjUBO2B/BlX8QGxVMDWmqK2VEqVOioz82st4=;
 b=rtBbV8jqyM4oMcc3UxUYgBdsFHWK0XTYgcxMlu4KWYFEKzzztfoIZX41yqBdeqAvR4
 2ueWF7Nn6IEyXGpw4ypdnfGT58eDWZNRPk+gIyjUO9ReU+R9nDcLNNoEJ/j05AxreeD6
 Y+EfixDkl8cM/TyXtA77grYET5XiWxdQ4qjUcdP5DujBPIkBVV8OaprKs87DdtK+S4dO
 H/U4AAmWXf+rI0VSBqr/zWmYLGSzRIqxmWSvj78BTbc25fROvHoGoNLJsZlcMXtv0CWM
 r8vuF3eHm9j5ot9gDDuIaT9fj9Wz+sV3bZb+Jh7LqLCuseYzhGMwP9+u1aB50ZJ+IoTz
 8xfg==
X-Gm-Message-State: AOAM533EqnJSmPXFbdMV9UIOGqZnEr3PIwS5nL5jRGTJi+5aBwZRR6dd
 nnCBvmcq2qtVl8stnztq8DEkSYPXIUSMQtxmKve1N95A/IXBQxe4obY4KJ7LZNnAi7MXRSEcFOp
 hM9eCJoHJH2eVOO1CPobpn1pIMn5Omhiqsy4LhNqAiA==
X-Received: by 2002:aa7:da55:: with SMTP id w21mr8927641eds.138.1613054366354; 
 Thu, 11 Feb 2021 06:39:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeSfLIg11TiFZiqkHyTCpLEsRrFR4Oa/VLugYW1mgKMahXhYPQG9fA0BChZD7qP/oqS9HACQ==
X-Received: by 2002:aa7:da55:: with SMTP id w21mr8927629eds.138.1613054366198; 
 Thu, 11 Feb 2021 06:39:26 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id bm9sm4539585ejb.14.2021.02.11.06.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 06:39:25 -0800 (PST)
Date: Thu, 11 Feb 2021 15:39:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 17/17] virtio/vsock: simplify credit update
 function API
Message-ID: <20210211143922.pfvngujv6k7lutll@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151906.806343-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151906.806343-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Sun, Feb 07, 2021 at 06:19:03PM +0300, Arseny Krasnov wrote:
>'virtio_transport_send_credit_update()' has some extra args:
>1) 'type' may be set in 'virtio_transport_send_pkt_info()' using type
>   of socket.
>2) This function is static and 'hdr' arg was always NULL.
>

Okay, I saw this patch after my previous comment.

I think this looks good, but please move this before your changes (e.g.  
before patch 'virtio/vsock: dequeue callback for SOCK_SEQPACKET').

In this way you don't need to modify 
virtio_transport_notify_buffer_size(), calling 
virtio_transport_get_type() and then remove these changes.

It's generally not a good idea to make changes in a patch and then 
remove them a few patches later in the same series. This should ring a 
bell about moving these changes before others.

Thanks,
Stefano

>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 20 +++++---------------
> 1 file changed, 5 insertions(+), 15 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c 
>b/net/vmw_vsock/virtio_transport_common.c
>index 0aa0fd33e9d6..46308679c8a4 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -286,13 +286,10 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit)
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
>
>@@ -401,9 +398,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * with different values.
> 	 */
> 	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
>-		virtio_transport_send_credit_update(vsk,
>-						    VIRTIO_VSOCK_TYPE_STREAM,
>-						    NULL);
>+		virtio_transport_send_credit_update(vsk);
> 	}
>
> 	return total;
>@@ -525,9 +520,7 @@ size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk)
> 	spin_unlock_bh(&vvs->rx_lock);
>
> 	if (bytes_dropped)
>-		virtio_transport_send_credit_update(vsk,
>-						    VIRTIO_VSOCK_TYPE_SEQPACKET,
>-						    NULL);
>+		virtio_transport_send_credit_update(vsk);
>
> 	return vvs->user_read_seq_len;
> }
>@@ -624,8 +617,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>-	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_SEQPACKET,
>-					    NULL);
>+	virtio_transport_send_credit_update(vsk);
>
> 	return err;
> }
>@@ -735,15 +727,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_do_socket_init);
> void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>-	int type;
>
> 	if (*val > VIRTIO_VSOCK_MAX_BUF_SIZE)
> 		*val = VIRTIO_VSOCK_MAX_BUF_SIZE;
>
> 	vvs->buf_alloc = *val;
>
>-	type = virtio_transport_get_type(sk_vsock(vsk));
>-	virtio_transport_send_credit_update(vsk, type, NULL);
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
