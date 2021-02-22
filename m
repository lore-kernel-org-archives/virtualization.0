Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A772EC433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 10:50:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40C464E04
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 10:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40C464E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A77985E95;
	Mon, 22 Feb 2021 10:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QU0XYhKDiAfY; Mon, 22 Feb 2021 10:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DEE8D85D68;
	Mon, 22 Feb 2021 10:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2E5DC000B;
	Mon, 22 Feb 2021 10:50:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E21E4C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A80626F562
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DjESRYxPS3Rf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:50:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98B5A6E750
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613991030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r/umkKobSl1oJ5nCTeCGkktIBMKXA0l63/V8yWAiXgY=;
 b=AKrRLCQGWCHFEwreUJmD5KHxfPRB0e45fG4PoO2NxVuL9v1w/ITXwEGT2tIBfjfA9+/fHA
 SH/O3kf1lzk+kwlJF2Lcr1uK/tw084FI/daYMbySWiZXo7fuKwmOcxR22DgXv7/Y00dbpp
 RTieycYtDPww80EYPQ/+qQ/KaOLbbm4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-wpLJ7uhkM8GXT5eUjs-Hcw-1; Mon, 22 Feb 2021 05:50:28 -0500
X-MC-Unique: wpLJ7uhkM8GXT5eUjs-Hcw-1
Received: by mail-wr1-f72.google.com with SMTP id r5so5938670wrw.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 02:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r/umkKobSl1oJ5nCTeCGkktIBMKXA0l63/V8yWAiXgY=;
 b=G0JTJ/mO5QhUvEkb4UsWoj3da3cQ6CyJbFwvPnl2Hfid5fvACRWZL/WlzVCsarrUl/
 HGKR6z3/nIiA8ljQkHT+mt3KC2E0g7Om5Cjk1yvDW506WOUp+t3cjQI4fWm6sfwD5P/7
 1LSn8Rjn+nF2ZanzMgUStkXuNpjPazJLRUk/okmM8g8CqGQ43jmEdQq/yqSxgGaTndFO
 xgWabb/zEOiUqhZ5UMXsi75ijRk+0DVvlr7zKr7PGm5gYdI5DeKOnvVLeuPtGLzi58y5
 QfzNyC9LHdvlYPZmXCBz/zlQyhUrZqrimFFcpgKWmjxHDumZMJ10t5Cdc6hVDpegBIvm
 t4aQ==
X-Gm-Message-State: AOAM5312eWPpt+TIl9kzIVQVsnZClHh5SN+3yIewWrONe1fdeDLJHgI2
 veWG6MKdPjH6aUGp0M9+sm3qe8QmiBdTEOouL6yRpHnDL2fElZ0Pm3v6jHTiCu3NFWTbonH69Qt
 aIdi/iGhskX2oagpqMcnp8B7sirzYlHCyhju/1m0JiA==
X-Received: by 2002:a1c:356:: with SMTP id 83mr20229595wmd.31.1613991027236;
 Mon, 22 Feb 2021 02:50:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGeo1jDQvRWIZunRRhVDnke7H4Q4D0daD7CIHbY/NWBlQs7bEj3/GryyH4ccKUfYqegxDaVg==
X-Received: by 2002:a1c:356:: with SMTP id 83mr20229567wmd.31.1613991027006;
 Mon, 22 Feb 2021 02:50:27 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id v15sm28696163wra.61.2021.02.22.02.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 02:50:26 -0800 (PST)
Date: Mon, 22 Feb 2021 11:50:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 01/19] af_vsock: update functions for connectible
 socket
Message-ID: <20210222105023.aqcu25irkeed6div@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053607.1066783-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053607.1066783-1-arseny.krasnov@kaspersky.com>
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

On Thu, Feb 18, 2021 at 08:36:03AM +0300, Arseny Krasnov wrote:
>This prepares af_vsock.c for SEQPACKET support: some functions such
>as setsockopt(), getsockopt(), connect(), recvmsg(), sendmsg() are
>shared between both types of sockets, so rename them in general
>manner.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 64 +++++++++++++++++++++-------------------
> 1 file changed, 34 insertions(+), 30 deletions(-)

IIRC I had already given my R-b to this patch. Please carry it over when 
you post a new version.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5546710d8ac1..656370e11707 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -604,8 +604,8 @@ static void vsock_pending_work(struct work_struct *work)
>
> /**** SOCKET OPERATIONS ****/
>
>-static int __vsock_bind_stream(struct vsock_sock *vsk,
>-			       struct sockaddr_vm *addr)
>+static int __vsock_bind_connectible(struct vsock_sock *vsk,
>+				    struct sockaddr_vm *addr)
> {
> 	static u32 port;
> 	struct sockaddr_vm new_addr;
>@@ -685,7 +685,7 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
> 	switch (sk->sk_socket->type) {
> 	case SOCK_STREAM:
> 		spin_lock_bh(&vsock_table_lock);
>-		retval = __vsock_bind_stream(vsk, addr);
>+		retval = __vsock_bind_connectible(vsk, addr);
> 		spin_unlock_bh(&vsock_table_lock);
> 		break;
>
>@@ -767,6 +767,11 @@ static struct sock *__vsock_create(struct net *net,
> 	return sk;
> }
>
>+static bool sock_type_connectible(u16 type)
>+{
>+	return type == SOCK_STREAM;
>+}
>+
> static void __vsock_release(struct sock *sk, int level)
> {
> 	if (sk) {
>@@ -785,7 +790,7 @@ static void __vsock_release(struct sock *sk, int level)
>
> 		if (vsk->transport)
> 			vsk->transport->release(vsk);
>-		else if (sk->sk_type == SOCK_STREAM)
>+		else if (sock_type_connectible(sk->sk_type))
> 			vsock_remove_sock(vsk);
>
> 		sock_orphan(sk);
>@@ -947,7 +952,7 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	lock_sock(sk);
> 	if (sock->state == SS_UNCONNECTED) {
> 		err = -ENOTCONN;
>-		if (sk->sk_type == SOCK_STREAM)
>+		if (sock_type_connectible(sk->sk_type))
> 			goto out;
> 	} else {
> 		sock->state = SS_DISCONNECTING;
>@@ -960,7 +965,7 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 		sk->sk_shutdown |= mode;
> 		sk->sk_state_change(sk);
>
>-		if (sk->sk_type == SOCK_STREAM) {
>+		if (sock_type_connectible(sk->sk_type)) {
> 			sock_reset_flag(sk, SOCK_DONE);
> 			vsock_send_shutdown(sk, mode);
> 		}
>@@ -1015,7 +1020,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
> 			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
>
>-	} else if (sock->type == SOCK_STREAM) {
>+	} else if (sock_type_connectible(sk->sk_type)) {
> 		const struct vsock_transport *transport;
>
> 		lock_sock(sk);
>@@ -1262,8 +1267,8 @@ static void vsock_connect_timeout(struct work_struct *work)
> 	sock_put(sk);
> }
>
>-static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
>-				int addr_len, int flags)
>+static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>+			 int addr_len, int flags)
> {
> 	int err;
> 	struct sock *sk;
>@@ -1413,7 +1418,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
>
> 	lock_sock(listener);
>
>-	if (sock->type != SOCK_STREAM) {
>+	if (!sock_type_connectible(sock->type)) {
> 		err = -EOPNOTSUPP;
> 		goto out;
> 	}
>@@ -1490,7 +1495,7 @@ static int vsock_listen(struct socket *sock, int backlog)
>
> 	lock_sock(sk);
>
>-	if (sock->type != SOCK_STREAM) {
>+	if (!sock_type_connectible(sk->sk_type)) {
> 		err = -EOPNOTSUPP;
> 		goto out;
> 	}
>@@ -1534,11 +1539,11 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
> 	vsk->buffer_size = val;
> }
>
>-static int vsock_stream_setsockopt(struct socket *sock,
>-				   int level,
>-				   int optname,
>-				   sockptr_t optval,
>-				   unsigned int optlen)
>+static int vsock_connectible_setsockopt(struct socket *sock,
>+					int level,
>+					int optname,
>+					sockptr_t optval,
>+					unsigned int optlen)
> {
> 	int err;
> 	struct sock *sk;
>@@ -1616,10 +1621,10 @@ static int vsock_stream_setsockopt(struct socket *sock,
> 	return err;
> }
>
>-static int vsock_stream_getsockopt(struct socket *sock,
>-				   int level, int optname,
>-				   char __user *optval,
>-				   int __user *optlen)
>+static int vsock_connectible_getsockopt(struct socket *sock,
>+					int level, int optname,
>+					char __user *optval,
>+					int __user *optlen)
> {
> 	int err;
> 	int len;
>@@ -1687,8 +1692,8 @@ static int vsock_stream_getsockopt(struct socket *sock,
> 	return 0;
> }
>
>-static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>-				size_t len)
>+static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>+				     size_t len)
> {
> 	struct sock *sk;
> 	struct vsock_sock *vsk;
>@@ -1827,10 +1832,9 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return err;
> }
>
>-
> static int
>-vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-		     int flags)
>+vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+			  int flags)
> {
> 	struct sock *sk;
> 	struct vsock_sock *vsk;
>@@ -2006,7 +2010,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.owner = THIS_MODULE,
> 	.release = vsock_release,
> 	.bind = vsock_bind,
>-	.connect = vsock_stream_connect,
>+	.connect = vsock_connect,
> 	.socketpair = sock_no_socketpair,
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
>@@ -2014,10 +2018,10 @@ static const struct proto_ops vsock_stream_ops = {
> 	.ioctl = sock_no_ioctl,
> 	.listen = vsock_listen,
> 	.shutdown = vsock_shutdown,
>-	.setsockopt = vsock_stream_setsockopt,
>-	.getsockopt = vsock_stream_getsockopt,
>-	.sendmsg = vsock_stream_sendmsg,
>-	.recvmsg = vsock_stream_recvmsg,
>+	.setsockopt = vsock_connectible_setsockopt,
>+	.getsockopt = vsock_connectible_getsockopt,
>+	.sendmsg = vsock_connectible_sendmsg,
>+	.recvmsg = vsock_connectible_recvmsg,
> 	.mmap = sock_no_mmap,
> 	.sendpage = sock_no_sendpage,
> };
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
