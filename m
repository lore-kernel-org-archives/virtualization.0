Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE4CC433E6
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 10:52:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244DB64ECA
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 10:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244DB64ECA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B5C4A86DF4;
	Thu, 11 Feb 2021 10:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGa4PNlV8uQZ; Thu, 11 Feb 2021 10:52:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E389486DEA;
	Thu, 11 Feb 2021 10:52:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D702C0891;
	Thu, 11 Feb 2021 10:52:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A032C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 10:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5FF328734F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 10:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id abbWWf992hL4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 10:52:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 60B2D8722B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613040757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6JIyxLiRHESwY6rJeK+rsmJNAoxnfQJq+AkTGikyDY=;
 b=BduuDeRBVNYOU859XFqQ8QN3O28Mctk9Egpgj4GBRohdB+FMlnt5VcqmXc15xmcN6+Ami6
 CRNa7VT8G/AIl/ZVH2o5sd/HLcpja9489ywc7a5WYCiQIl4mz0KX6+aMpHIl9H4lj7UUlF
 3wEK6HXLvD8J23e7jNUYbbfQRF6p9t0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-CQIfFkxmOyWNNoVp-oM3KQ-1; Thu, 11 Feb 2021 05:52:34 -0500
X-MC-Unique: CQIfFkxmOyWNNoVp-oM3KQ-1
Received: by mail-ej1-f69.google.com with SMTP id hx26so4569678ejc.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 02:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c6JIyxLiRHESwY6rJeK+rsmJNAoxnfQJq+AkTGikyDY=;
 b=X7QrX588F/rGP4zaGYMnk454e9xn5XZmZ6Lj8Dy0ng/q0ocrzsQcq80S1lsAZVVNaJ
 5d933T1RmBnwEHYE2GhbN7BoPTfw0Jn/s8gI/zn2txa3vj3YXPHoWmUUTPSiLGF9OzGI
 ryiTV5X17vR9PcSu9fOlcTlW5NrrvCVh1rW3UWYsSY4HbLWTye2IEvoDM8l1hEQgqJkN
 n10XU51H4x2ZGUKzSW8svud7jrxzL7rqdwjDaadG/uIdQs+kBowZQHj/XKST9pwXqVgx
 +vbLdqw39j46wgEteiQn32F5fu2pe1TgIHRZ4ntdBx0j75p9kSxeRupbpxXw/iez7U2o
 CVfA==
X-Gm-Message-State: AOAM532oD2paCamu5HStjd2IXOmQvfVN4PiBIj3uJBoSiBUnzWTf2CUv
 KkHU4M63w6IhqNRfG0X8eGdtMA6JIp6Ch2iO/+bYXoSrGgubrQajv+1w951Q9nqBk2cxUFmIYA2
 yIA0DCmbgwr1UM91vCeNctOCqYjZuFL18Pz0MtEbCgA==
X-Received: by 2002:a50:b765:: with SMTP id g92mr7847351ede.317.1613040752990; 
 Thu, 11 Feb 2021 02:52:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4L+tgVkXdxNZfo4WOdRQsyzuiJJ+oUQSD+Mof1i2r3UcuhRlRZ20qv++UXJ9lCcDs9kLlIA==
X-Received: by 2002:a50:b765:: with SMTP id g92mr7847336ede.317.1613040752718; 
 Thu, 11 Feb 2021 02:52:32 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id l12sm3613142edn.83.2021.02.11.02.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 02:52:32 -0800 (PST)
Date: Thu, 11 Feb 2021 11:52:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 01/17] af_vsock: update functions for connectible
 socket
Message-ID: <20210211105229.fmdonwqe3swhq6lb@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151426.804348-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151426.804348-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
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

On Sun, Feb 07, 2021 at 06:14:23PM +0300, Arseny Krasnov wrote:
>This prepares af_vsock.c for SEQPACKET support: some functions such
>as setsockopt(), getsockopt(), connect(), recvmsg(), sendmsg() are
>shared between both types of sockets, so rename them in general
>manner.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 64 +++++++++++++++++++++-------------------
> 1 file changed, 34 insertions(+), 30 deletions(-)

This patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 6894f21dc147..f4fabec50650 100644
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
>@@ -945,7 +950,7 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	sk = sock->sk;
> 	if (sock->state == SS_UNCONNECTED) {
> 		err = -ENOTCONN;
>-		if (sk->sk_type == SOCK_STREAM)
>+		if (sock_type_connectible(sk->sk_type))
> 			return err;
> 	} else {
> 		sock->state = SS_DISCONNECTING;
>@@ -960,7 +965,7 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 		sk->sk_state_change(sk);
> 		release_sock(sk);
>
>-		if (sk->sk_type == SOCK_STREAM) {
>+		if (sock_type_connectible(sk->sk_type)) {
> 			sock_reset_flag(sk, SOCK_DONE);
> 			vsock_send_shutdown(sk, mode);
> 		}
>@@ -1013,7 +1018,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		if (!(sk->sk_shutdown & SEND_SHUTDOWN))
> 			mask |= EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND;
>
>-	} else if (sock->type == SOCK_STREAM) {
>+	} else if (sock_type_connectible(sk->sk_type)) {
> 		const struct vsock_transport *transport;
>
> 		lock_sock(sk);
>@@ -1263,8 +1268,8 @@ static void vsock_connect_timeout(struct work_struct *work)
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
>@@ -1414,7 +1419,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
>
> 	lock_sock(listener);
>
>-	if (sock->type != SOCK_STREAM) {
>+	if (!sock_type_connectible(sock->type)) {
> 		err = -EOPNOTSUPP;
> 		goto out;
> 	}
>@@ -1491,7 +1496,7 @@ static int vsock_listen(struct socket *sock, int backlog)
>
> 	lock_sock(sk);
>
>-	if (sock->type != SOCK_STREAM) {
>+	if (!sock_type_connectible(sk->sk_type)) {
> 		err = -EOPNOTSUPP;
> 		goto out;
> 	}
>@@ -1535,11 +1540,11 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
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
>@@ -1617,10 +1622,10 @@ static int vsock_stream_setsockopt(struct socket *sock,
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
>@@ -1688,8 +1693,8 @@ static int vsock_stream_getsockopt(struct socket *sock,
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
>@@ -1828,10 +1833,9 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
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
>@@ -2007,7 +2011,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.owner = THIS_MODULE,
> 	.release = vsock_release,
> 	.bind = vsock_bind,
>-	.connect = vsock_stream_connect,
>+	.connect = vsock_connect,
> 	.socketpair = sock_no_socketpair,
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
>@@ -2015,10 +2019,10 @@ static const struct proto_ops vsock_stream_ops = {
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
