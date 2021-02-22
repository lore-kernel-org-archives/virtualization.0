Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A492C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 14:12:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A7F64E20
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 14:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A7F64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C1F3839E6;
	Mon, 22 Feb 2021 14:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u_EMNC3qBIot; Mon, 22 Feb 2021 14:12:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71895839D8;
	Mon, 22 Feb 2021 14:12:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38610C000B;
	Mon, 22 Feb 2021 14:12:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2D80C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF3BB6F52F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fY_BDvCqPbtT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:12:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CCF56F51A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614003146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C4ob/HwZY6JToPa6OIARFnOVuWbb8EWH4Jtjs9jshMI=;
 b=ZJzeBd3FVu9OByQEluSXqLAxIaaA+l8rj3B7FAUNatpqBwKy5wI7Ak6GGvRUxbLDT9EsYc
 pJWPkcz9eTGJGPBhHDMGuBu7t4DHMxM2w8Wune7o4q6umXgKkEYMWe7rubfC9HrvXtM9qU
 7FzrvRRnrY47BlS6D/5s3Dx4w4zR7Uo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-gGJgsnFBMoOsbuwHLtof1g-1; Mon, 22 Feb 2021 09:12:24 -0500
X-MC-Unique: gGJgsnFBMoOsbuwHLtof1g-1
Received: by mail-wr1-f69.google.com with SMTP id v1so6158548wru.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 06:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C4ob/HwZY6JToPa6OIARFnOVuWbb8EWH4Jtjs9jshMI=;
 b=m9mJQEFXicljaJd50cuPfzR6gSgYF426bzqASnTeOLYOSyrjNKUzsJ2M/CPJ3AuLDd
 gkla91dparwllurOvuW5ZXw5r7oVI1RJFrtNOusFfdjmn4tWCgAKoP/9hrAaC/iunCPx
 GyQP7xoBTLHfryIne+zgHzyyvwgousF3GGjW6YzfYkEA5Mh/M6hvBqx4UKN71sKurbHl
 kgQmtjyEkOas30gYGbnlDtlkApslmVQBrlaSPh6s0z2hb8ysnc79xcjOaTGxWjav+dH+
 LuEnYdVQ70+Qx6j5TUhJIUh2N4XEWf2jHsG83DR3x3v1XZ9Sl0LAcbCKumvkulK/wIS7
 EpkQ==
X-Gm-Message-State: AOAM531x+A8eN9rGKTLRbPWFV5dtHO2cUzqyBjmaBiQlfsOOnD67yJdQ
 eGgaPLg1uKf8ZRAKdK1VyFPn6QSl5Y41Q+eIKr8nOoeYwvnBS4l0qIMkx6aTsrh3I1pkohxCWfi
 6JHR9eleioYS9hlCQ9CSkJDnjnqDjFzjEaANnBtThLA==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr21614566wrv.366.1614003142875; 
 Mon, 22 Feb 2021 06:12:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvUh6+RKpz1p9mHjfUgu/bHee+H13baHG8nnXHUSqARjGTCoY6aSGxXiwzPvqOvhgWfA6Rew==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr21614537wrv.366.1614003142640; 
 Mon, 22 Feb 2021 06:12:22 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id i1sm25218726wmq.12.2021.02.22.06.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 06:12:22 -0800 (PST)
Date: Mon, 22 Feb 2021 15:12:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 07/19] af_vsock: rest of SEQPACKET support
Message-ID: <20210222141219.nvw4323sizvsud5d@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053831.1067678-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053831.1067678-1-arseny.krasnov@kaspersky.com>
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

On Thu, Feb 18, 2021 at 08:38:28AM +0300, Arseny Krasnov wrote:
>This does rest of SOCK_SEQPACKET support:
>1) Adds socket ops for SEQPACKET type.
>2) Allows to create socket with SEQPACKET type.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 36 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 35 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f352cd9d91ce..f4b02c6d35d1 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -452,6 +452,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		new_transport = transport_dgram;
> 		break;
> 	case SOCK_STREAM:
>+	case SOCK_SEQPACKET:
> 		if (vsock_use_local_transport(remote_cid))
> 			new_transport = transport_local;
> 		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>@@ -484,6 +485,14 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	if (!new_transport || !try_module_get(new_transport->module))
> 		return -ENODEV;
>
>+	if (sk->sk_type == SOCK_SEQPACKET) {
>+		if (!new_transport->seqpacket_seq_send_len ||
>+		    !new_transport->seqpacket_seq_send_eor ||
>+		    !new_transport->seqpacket_seq_get_len ||
>+		    !new_transport->seqpacket_dequeue)

We must release the module reference acquired above:

			module_put(new_transport->module);

>+			return -ESOCKTNOSUPPORT;
>+	}
>+
> 	ret = new_transport->init(vsk, psk);
> 	if (ret) {
> 		module_put(new_transport->module);
>@@ -684,6 +693,7 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
>
> 	switch (sk->sk_socket->type) {
> 	case SOCK_STREAM:
>+	case SOCK_SEQPACKET:
> 		spin_lock_bh(&vsock_table_lock);
> 		retval = __vsock_bind_connectible(vsk, addr);
> 		spin_unlock_bh(&vsock_table_lock);
>@@ -769,7 +779,7 @@ static struct sock *__vsock_create(struct net *net,
>
> static bool sock_type_connectible(u16 type)
> {
>-	return type == SOCK_STREAM;
>+	return (type == SOCK_STREAM) || (type == SOCK_SEQPACKET);
> }
>
> static void __vsock_release(struct sock *sk, int level)
>@@ -2191,6 +2201,27 @@ static const struct proto_ops vsock_stream_ops = {
> 	.sendpage = sock_no_sendpage,
> };
>
>+static const struct proto_ops vsock_seqpacket_ops = {
>+	.family = PF_VSOCK,
>+	.owner = THIS_MODULE,
>+	.release = vsock_release,
>+	.bind = vsock_bind,
>+	.connect = vsock_connect,
>+	.socketpair = sock_no_socketpair,
>+	.accept = vsock_accept,
>+	.getname = vsock_getname,
>+	.poll = vsock_poll,
>+	.ioctl = sock_no_ioctl,
>+	.listen = vsock_listen,
>+	.shutdown = vsock_shutdown,
>+	.setsockopt = vsock_connectible_setsockopt,
>+	.getsockopt = vsock_connectible_getsockopt,
>+	.sendmsg = vsock_connectible_sendmsg,
>+	.recvmsg = vsock_connectible_recvmsg,
>+	.mmap = sock_no_mmap,
>+	.sendpage = sock_no_sendpage,
>+};
>+
> static int vsock_create(struct net *net, struct socket *sock,
> 			int protocol, int kern)
> {
>@@ -2211,6 +2242,9 @@ static int vsock_create(struct net *net, struct socket *sock,
> 	case SOCK_STREAM:
> 		sock->ops = &vsock_stream_ops;
> 		break;
>+	case SOCK_SEQPACKET:
>+		sock->ops = &vsock_seqpacket_ops;
>+		break;
> 	default:
> 		return -ESOCKTNOSUPPORT;
> 	}
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
