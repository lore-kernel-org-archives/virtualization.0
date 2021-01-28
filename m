Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB13BC433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 16:10:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFF861492
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 16:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFF861492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 72E222E0EC;
	Thu, 28 Jan 2021 16:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ymh0xVp4-ta5; Thu, 28 Jan 2021 16:10:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 788A42E0DF;
	Thu, 28 Jan 2021 16:10:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A66C0FA8;
	Thu, 28 Jan 2021 16:10:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2987FC08A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1490686E2A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5eciX1U+FV58
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:10:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C6FF686E1D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611850237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3+GaWOJcVoS280BO4ZTgt8MtsvmJpeZvLy5xokg2jk=;
 b=QJTPhyV1S5iQa5g7hOkXF/Fn6ZuDq+5txppfBjVBydJzkAxdDt81jbxK2pN9+B14vvEnbP
 ajn0aOjoTBG0fj2oe8S66tq7Bf8gWhZLDmFcuOzBR7T/9R4cE5S/P8sL4lHtA6Sqh1Mfrt
 Gv5wCV4eLLzRKKDm4HPnNe7HG/veMVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-luHypN-RMRi_d85MD5419Q-1; Thu, 28 Jan 2021 11:10:34 -0500
X-MC-Unique: luHypN-RMRi_d85MD5419Q-1
Received: by mail-wr1-f69.google.com with SMTP id c1so3363999wrx.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 08:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q3+GaWOJcVoS280BO4ZTgt8MtsvmJpeZvLy5xokg2jk=;
 b=h333WSEBmvdBkh87Qe5JErH+GQ952Oat5T81qMn2si2F/GBmaRmUWg810fNMfXvdbP
 9KyjWN88H7idMM3LiE8QjTQbdjRxd/d9aejEIWeyQoUCQa6FpKeax05/FOqcyv1D0+0h
 cQ78QLegbJNOCL+FuIUsrUiGFaX+Otg3a/J7JPF0Lc7U/MPX6H8EJ44ujFnPgMmTL+Yn
 mLvz8/abtqvWZlE/IPRZMs+V9Joh4SkXn/Bf6OVgIDjT76bQOLhlNWDyvs003eCsEQ9I
 hG2m67qduuqnEIL+DMPIc7RsuEEI3WSm1KzIc27UIUHL3KDkJRYz+0BE8YVYRjc5HN5w
 FXzg==
X-Gm-Message-State: AOAM533gvOYxzkAaJK8UScrGrcQEUfau68tqKzhEVfPX5dF4aEKf4hVK
 9xl6gKVc4318QaIVM1FM4y4P3gQvQBTszT+5VI2+fJw0tYHV1oCeBmnGZY7PcK7nf7bGICYNbCf
 hxBHjGVDzRmAsFQVQyWpPiDZ/4qyP3hI61Jvgof3Iww==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr17858687wrd.29.1611850233400; 
 Thu, 28 Jan 2021 08:10:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCJxet7P/Zrk9KZEMXq8X1p9C2h5zi7JFYpLswRvkfkQWra6ZTD64HKpdUGYoJqTRtuXS7kQ==
X-Received: by 2002:a5d:5910:: with SMTP id v16mr17858644wrd.29.1611850233122; 
 Thu, 28 Jan 2021 08:10:33 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id l10sm7495512wro.4.2021.01.28.08.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 08:10:32 -0800 (PST)
Date: Thu, 28 Jan 2021 17:10:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 01/13] af_vsock: prepare for SOCK_SEQPACKET support
Message-ID: <20210128161029.a53la6e3dv5bzazn@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111131.597930-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125111131.597930-1-arseny.krasnov@kaspersky.com>
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

I think the patch title should be more explicit, so something like

vsock: generalize function to manage connectible sockets

On Mon, Jan 25, 2021 at 02:11:28PM +0300, Arseny Krasnov wrote:
>This prepares af_vsock.c for SEQPACKET support:
>1) As both stream and seqpacket sockets are connection oriented, add
>   check for SOCK_SEQPACKET to conditions where SOCK_STREAM is checked.
>2) Some functions such as setsockopt(), getsockopt(), connect(),
>   recvmsg(), sendmsg() are shared between both types of sockets, so
>   rename them in general manner and create entry points for each type
>   of socket to call these functions(for stream in this patch, for
>   seqpacket in further patches).
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 91 +++++++++++++++++++++++++++++-----------
> 1 file changed, 67 insertions(+), 24 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index b12d3a322242..c9ce57db9554 100644
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
>+	return (type == SOCK_STREAM || type == SOCK_SEQPACKET);
>+}
>+

I think it's okay to add this function in this patch, but until 
SOCK_SEQPACKET is not supported, I would check only SOCK_STREAM and add 
SOCK_SEQPACKET only when you add 'vsock_seqpacket_ops' later.

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
> 		const struct vsock_transport *transport = vsk->transport;
> 		lock_sock(sk);
>
>@@ -1259,8 +1264,8 @@ static void vsock_connect_timeout(struct work_struct *work)
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
>@@ -1395,6 +1400,12 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
> 	return err;
> }
>
>+static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
>+				int addr_len, int flags)
>+{
>+	return vsock_connect(sock, addr, addr_len, flags);
>+}
>+

I think you can directly use vsock_connect in 'vsock_stream_ops'.

> static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
> 			bool kern)
> {
>@@ -1410,7 +1421,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
>
> 	lock_sock(listener);
>
>-	if (sock->type != SOCK_STREAM) {
>+	if (!sock_type_connectible(sock->type)) {
> 		err = -EOPNOTSUPP;
> 		goto out;
> 	}
>@@ -1487,7 +1498,7 @@ static int vsock_listen(struct socket *sock, int 
>backlog)
>
> 	lock_sock(sk);
>
>-	if (sock->type != SOCK_STREAM) {
>+	if (!sock_type_connectible(sk->sk_type)) {
> 		err = -EOPNOTSUPP;
> 		goto out;
> 	}
>@@ -1531,11 +1542,11 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
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
>@@ -1612,10 +1623,20 @@ static int vsock_stream_setsockopt(struct socket *sock,
> 	return err;
> }
>
>-static int vsock_stream_getsockopt(struct socket *sock,
>-				   int level, int optname,
>-				   char __user *optval,
>-				   int __user *optlen)
>+static int vsock_stream_setsockopt(struct socket *sock,
>+				   int level,
>+				   int optname,
>+				   sockptr_t optval,
>+				   unsigned int optlen)
>+{
>+	return vsock_connectible_setsockopt(sock, level, optname, optval,
>+					    optlen);
>+}

As before, I think you can directly use vsock_connectible_setsockopt in 
'vsock_stream_ops'.

>+
>+static int vsock_connectible_getsockopt(struct socket *sock,
>+					int level, int optname,
>+					char __user *optval,
>+					int __user *optlen)
> {
> 	int err;
> 	int len;
>@@ -1683,8 +1704,17 @@ static int vsock_stream_getsockopt(struct socket *sock,
> 	return 0;
> }
>
>-static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>-				size_t len)
>+static int vsock_stream_getsockopt(struct socket *sock,
>+				   int level, int optname,
>+				   char __user *optval,
>+				   int __user *optlen)
>+{
>+	return vsock_connectible_getsockopt(sock, level, optname, optval,
>+					    optlen);
>+}
>+

Ditto.

>+static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>+				     size_t len)
> {
> 	struct sock *sk;
> 	struct vsock_sock *vsk;
>@@ -1822,10 +1852,16 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return err;
> }
>
>+static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>+				size_t len)
>+{
>+	return vsock_connectible_sendmsg(sock, msg, len);
>+}
>+

Ditto.

>
> static int
>-vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-		     int flags)
>+vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+			  int flags)
> {
> 	struct sock *sk;
> 	struct vsock_sock *vsk;
>@@ -1995,6 +2031,13 @@ vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int
>+vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+		     int flags)
>+{
>+	return vsock_connectible_recvmsg(sock, msg, len, flags);
>+}
>+

Ditto.

> static const struct proto_ops vsock_stream_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
