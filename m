Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697ECC433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 17:04:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C3F64E15
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 17:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C3F64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACD6186224;
	Thu, 28 Jan 2021 17:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RuamLmnykiTg; Thu, 28 Jan 2021 17:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0217A844A7;
	Thu, 28 Jan 2021 17:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC612C0FA8;
	Thu, 28 Jan 2021 17:04:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 665D9C08A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 17:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5428F864D4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 17:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fuEilijQzPJZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 17:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 74B2D86E6B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611853473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LvcQzCTMhw0EZfzlSb3F515FxbS4cvGqc8hLzWtIraw=;
 b=JcDnJh5pewXv5NoDV+Wsn4MLDtPKTQJHuCf1YH3OcwfNxXwsCoImJLW1YdIKyib2q8nluV
 a2hg3Pb7mAujnj0zj8AKS6UrscBXebqoLA06j/BJ9LDOVqJQ7WeUwy67X7YcuFrLIfDo97
 dld42Mua92RJOIDALSNiLBW9n+aEwgc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-P6B1LwvsNpWbMNTGZrVGiw-1; Thu, 28 Jan 2021 12:04:31 -0500
X-MC-Unique: P6B1LwvsNpWbMNTGZrVGiw-1
Received: by mail-wr1-f71.google.com with SMTP id n14so3446493wru.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 09:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LvcQzCTMhw0EZfzlSb3F515FxbS4cvGqc8hLzWtIraw=;
 b=Q03s7la/dY0OioEkDO4rKDgzItSwbIKDhZuNAYh70AMe+9FKRlwQhsFU19U+sBOjtH
 EI24Zch+Jn1PspZOKtA0UcgaxObv8uGsGVcJDylkW19OJ9oG7okc2JQ3xWXHV0BBxt2b
 ydgus+M5FWs0fjmMY5s8cQWro4IFqIcdXUWCiCmFKA0on4/8jNT+XA0mt1OksoX7bkMA
 sMgWrynTuq1o3BD098En0QoDVL9oTwt5UlLSca4CT4rsNQM03DnCJYo/o3rRQmiI+x/L
 O8BkB/sFxVvb9mTIEeAc8p3dt+VRdkQ2/ByNPAoCdv+XEx4zhtGPJ5gqkVRrASYUZjG+
 YE3A==
X-Gm-Message-State: AOAM533kSafbdb+uAFhFG5AfcD7yceML3Rc3hDRdvCP+PRUA9rG1i+hN
 sNYCxTeHente3izwdDLOCTopDcKN/Ceo95+fWuozXA9ElnaTmvlpunCyo9mWLaLYzl4lVz3xz3m
 zG4iGZVR3LNIdYPUKQef1w0mixfA3ibp6BX9EU2AlOA==
X-Received: by 2002:adf:9148:: with SMTP id j66mr47597wrj.28.1611853470441;
 Thu, 28 Jan 2021 09:04:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFXNXAEEeUISjmsj6o5JuE/Q8ctqnwUsP41thgGGDQLpC8xK5225WjWWJKnBOg3AVOH+RIYQ==
X-Received: by 2002:adf:9148:: with SMTP id j66mr47572wrj.28.1611853470215;
 Thu, 28 Jan 2021 09:04:30 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id v4sm8574382wrw.42.2021.01.28.09.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 09:04:29 -0800 (PST)
Date: Thu, 28 Jan 2021 18:04:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 05/13] af_vsock: rest of SEQPACKET support
Message-ID: <20210128170426.522mpkocdd35bt2e@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111321.598653-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125111321.598653-1-arseny.krasnov@kaspersky.com>
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

On Mon, Jan 25, 2021 at 02:13:18PM +0300, Arseny Krasnov wrote:
>This does rest of SOCK_SEQPACKET support:
>1) Adds socket ops for SEQPACKET type.
>2) Allows to create socket with SEQPACKET type.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 71 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 71 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 4600c1ec3bb3..bbc3c31085aa 100644
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
>@@ -459,6 +460,13 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			new_transport = transport_g2h;
> 		else
> 			new_transport = transport_h2g;
>+
>+		if (sk->sk_type == SOCK_SEQPACKET) {

I think you must also check that new_transport is not NULL.

>+			if (!new_transport->seqpacket_seq_send_len ||
>+			    !new_transport->seqpacket_seq_get_len ||
>+			    !new_transport->seqpacket_dequeue)
>+				return -ENODEV;

I'm not sure about ENODEV is the better choice in this case, since the 
transport exists, but it doesn't support SOCK_SEQPACKET, so maybe is 
better ESOCKTNOSUPPORT.

>+		}
> 		break;
> 	default:
> 		return -ESOCKTNOSUPPORT;
>@@ -684,6 +692,7 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
>
> 	switch (sk->sk_socket->type) {
> 	case SOCK_STREAM:
>+	case SOCK_SEQPACKET:
> 		spin_lock_bh(&vsock_table_lock);
> 		retval = __vsock_bind_connectible(vsk, addr);
> 		spin_unlock_bh(&vsock_table_lock);
>@@ -1406,6 +1415,12 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
> 	return vsock_connect(sock, addr, addr_len, flags);
> }
>
>+static int vsock_seqpacket_connect(struct socket *sock, struct sockaddr *addr,
>+				   int addr_len, int flags)
>+{
>+	return vsock_connect(sock, addr, addr_len, flags);
>+}
>+
> static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
> 			bool kern)
> {
>@@ -1633,6 +1648,16 @@ static int vsock_stream_setsockopt(struct socket *sock,
> 					    optlen);
> }
>
>+static int vsock_seqpacket_setsockopt(struct socket *sock,
>+				      int level,
>+				      int optname,
>+				      sockptr_t optval,
>+				      unsigned int optlen)
>+{
>+	return vsock_connectible_setsockopt(sock, level, optname, optval,
>+					    optlen);
>+}
>+
> static int vsock_connectible_getsockopt(struct socket *sock,
> 					int level, int optname,
> 					char __user *optval,
>@@ -1713,6 +1738,15 @@ static int vsock_stream_getsockopt(struct socket *sock,
> 					    optlen);
> }
>
>+static int vsock_seqpacket_getsockopt(struct socket *sock,
>+				      int level, int optname,
>+				      char __user *optval,
>+				      int __user *optlen)
>+{
>+	return vsock_connectible_getsockopt(sock, level, optname, optval,
>+					    optlen);
>+}
>+
> static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 				     size_t len)
> {
>@@ -1870,6 +1904,12 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return vsock_connectible_sendmsg(sock, msg, len);
> }
>
>+static int vsock_seqpacket_sendmsg(struct socket *sock, struct msghdr *msg,
>+				   size_t len)
>+{
>+	return vsock_connectible_sendmsg(sock, msg, len);
>+}
>+
> static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
> 			   long timeout,
> 			   struct vsock_transport_recv_notify_data *recv_data,
>@@ -2184,6 +2224,13 @@ vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return vsock_connectible_recvmsg(sock, msg, len, flags);
> }
>
>+static int
>+vsock_seqpacket_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+			int flags)
>+{
>+	return vsock_connectible_recvmsg(sock, msg, len, flags);
>+}
>+

As I said, I think you don't need to implement all of this helpers and 
you can directly assign the vsock_connectible_* functions in the 
'vsock_seqpacket_ops'.

> static const struct proto_ops vsock_stream_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -2205,6 +2252,27 @@ static const struct proto_ops vsock_stream_ops = {
> 	.sendpage = sock_no_sendpage,
> };
>
>+static const struct proto_ops vsock_seqpacket_ops = {
>+	.family = PF_VSOCK,
>+	.owner = THIS_MODULE,
>+	.release = vsock_release,
>+	.bind = vsock_bind,
>+	.connect = vsock_seqpacket_connect,
>+	.socketpair = sock_no_socketpair,
>+	.accept = vsock_accept,
>+	.getname = vsock_getname,
>+	.poll = vsock_poll,
>+	.ioctl = sock_no_ioctl,
>+	.listen = vsock_listen,
>+	.shutdown = vsock_shutdown,
>+	.setsockopt = vsock_seqpacket_setsockopt,
>+	.getsockopt = vsock_seqpacket_getsockopt,
>+	.sendmsg = vsock_seqpacket_sendmsg,
>+	.recvmsg = vsock_seqpacket_recvmsg,
>+	.mmap = sock_no_mmap,
>+	.sendpage = sock_no_sendpage,
>+};
>+
> static int vsock_create(struct net *net, struct socket *sock,
> 			int protocol, int kern)
> {
>@@ -2225,6 +2293,9 @@ static int vsock_create(struct net *net, struct socket *sock,
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
