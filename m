Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752B153519
	for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565763; cv=none; b=vCJEfEE4TkLpvl8S7vrtunIVRffDJniXWmlWVEwKjtKiyjMcU04BKpA4Dfzh8+IrvtWzxV/NxTqs2XWYJPvFRDoCOJv/2LkQxfzEi/BFWi3rEXR+4XqYxIvGG8RCzG3f8xf+O/3wiXCzLyU1pfpjGahvdMVmBXAlxJBeH/WyawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565763; c=relaxed/simple;
	bh=SIySpQCkV++Gn01uCQqrsxns8iu5uDxRGSSIfvZ6WqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B0AirlYf2zQ93+xBE/ivlbVJQ9+139VWpCTjKJWfebsvmE0X1E3wW8innZq7V+rGezQM0C7A8OTSp6Zsw5Z54q8mOr+/+2WrsmrO1SbMBbGnq+x6fCff51PuQ04fhrGC4wPVNXkGq1f9/qDONdQHeHT9gyZTdjbpP7flCGddE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsifPcFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsifPcFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719565760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yWBbb3piCGdDy7HD6ZzfPnqrZTOJPMpN0iR2xh32w0=;
	b=VsifPcFn+H7KiB6cunIidud6ZM5LD3s9BL2pUWT0e/r3QTn313+FFmsZfqXmxkXltHOwgN
	/SYQN0RKsO0aLTRGLBSQvyNVkXLr8vosuMCVI4l27fTYmZTtaAqlEffmgT6Q1XJxWsaFO1
	zPimsbMmTsTPHqV7NiLEP/y7PAiIg6E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-hZZDREl_OFKAm-N-u1knfA-1; Fri, 28 Jun 2024 05:09:19 -0400
X-MC-Unique: hZZDREl_OFKAm-N-u1knfA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42490aed594so3633035e9.3
        for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 02:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565758; x=1720170558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yWBbb3piCGdDy7HD6ZzfPnqrZTOJPMpN0iR2xh32w0=;
        b=txJXPSZKamkrAw8MPSbqtIal+E0vSdx0nDsAhrOnTp4hrZE65IbWI9lBOz8Hln3Yjx
         AtqQwhL7Hp1EvQUkheEvc4TIlRM7tfiyFGEFZg4vTovjX2KUzTiK3Sl4l9YbXjr3sOHx
         xdTx3JXZrfAbNnLTwSdc1Yj0sgPdte6ZtwGE6gf6hb3NeRKBxkZd+jIB8FXpu47VURka
         zEfjSCtRbLKQDW94XDQwKvgRZ6tr6bxHXNP4eFzbOXBIsI23xRa7FPkpyd/C09z3P2lW
         hRXhtkcDDF/CAoQ7UHrZo9zLlKtZQjX7kVUopMs1u7hqlgaC+q8usz5X/pLFvX41oz1G
         1FMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy8e0x+JYwV5Ey8ff4dMQ5Er+RS+/m5bdhHFD5wGYV2zQDhlZ0biL3a8NOQFvzTybztv6oFgYBK10vrt/Om9QjquQMNUp7THpIsPDbm8k=
X-Gm-Message-State: AOJu0YyUQXPL6JgFfxgY6WjtGlecTIj8vvlLQFAYuKl0L7lzTUzKwhv9
	9r0e8oN3CvmEcjV08vrIwynEW3TCUWvZwEnrZsgx4e0XVR8c5eAUIW9pmyt53zUb/skLGPyUYNm
	6ujwGKV79sA23Y85fwv7h7XkEAfvIqEQ1pG6cFcYfi+3ldvy51IkCxty8XKPxpbzs
X-Received: by 2002:a05:600c:2e16:b0:425:5f25:c926 with SMTP id 5b1f17b1804b1-4255f25ca11mr49899625e9.19.1719565757847;
        Fri, 28 Jun 2024 02:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLU+57BTTkzFmhEgyrNonqIAqaUPJ6LrIcPsHkgfDROh96pQSfJWSfs9ZVKQcYxxBa29DKHg==
X-Received: by 2002:a05:600c:2e16:b0:425:5f25:c926 with SMTP id 5b1f17b1804b1-4255f25ca11mr49899415e9.19.1719565757149;
        Fri, 28 Jun 2024 02:09:17 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.132.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0fb3sm25546245e9.40.2024.06.28.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:09:16 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:09:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] vsock: add support for SIOCOUTQ ioctl
 for all vsock socket types.
Message-ID: <nasvwizxcxeu64dux7yop3bwxdpbneu2bts6ob6ahwwietoxh6@wtffmxmiq5g3>
References: <20240626-ioctl_next-v3-0-63be5bf19a40@outlook.com>
 <20240626-ioctl_next-v3-1-63be5bf19a40@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240626-ioctl_next-v3-1-63be5bf19a40@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

nit: in theory in this patch we don't support it for any of the 
transports, so I wouldn't confuse and take that part out of the title.

WDYT with someting like:

     vsock: add support for SIOCOUTQ ioctl

On Wed, Jun 26, 2024 at 02:08:35PM GMT, Luigi Leonardi via B4 Relay 
wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>Add support for ioctl(s) for SOCK_STREAM SOCK_SEQPACKET and SOCK_DGRAM
>in AF_VSOCK.
>The only ioctl available is SIOCOUTQ/TIOCOUTQ, which returns the number
>of unsent bytes in the socket. This information is transport-specific
>and is delegated to them using a callback.
>
>Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> include/net/af_vsock.h   |  3 +++
> net/vmw_vsock/af_vsock.c | 60 +++++++++++++++++++++++++++++++++++++++++++++---
> 2 files changed, 60 insertions(+), 3 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 535701efc1e5..7b5375ae7827 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -169,6 +169,9 @@ struct vsock_transport {
> 	void (*notify_buffer_size)(struct vsock_sock *, u64 *);
> 	int (*notify_set_rcvlowat)(struct vsock_sock *vsk, int val);
>
>+	/* SIOCOUTQ ioctl */
>+	size_t (*unsent_bytes)(struct vsock_sock *vsk);

If you want to return also errors, maybe better returning ssize_t.
This should fix one of the error reported by kernel bots.

>+
> 	/* Shutdown. */
> 	int (*shutdown)(struct vsock_sock *, int);
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 4b040285aa78..d6140d73d122 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -112,6 +112,7 @@
> #include <net/sock.h>
> #include <net/af_vsock.h>
> #include <uapi/linux/vm_sockets.h>
>+#include <uapi/asm-generic/ioctls.h>
>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -1292,6 +1293,59 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> }
> EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
>
>+static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>+			  int __user *arg)
>+{
>+	struct sock *sk = sock->sk;
>+	struct vsock_sock *vsk;
>+	int retval;
>+
>+	vsk = vsock_sk(sk);
>+
>+	switch (cmd) {
>+	case SIOCOUTQ: {
>+		size_t n_bytes;
>+
>+		if (!vsk->transport || !vsk->transport->unsent_bytes) {
>+			retval = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (vsk->transport->unsent_bytes) {

This if is not necessary after the check we did earlier, right?

Removing it should fix the other issue reported by the bot.

>+			if (sock_type_connectible(sk->sk_type) && sk->sk_state == TCP_LISTEN) {
>+				retval = -EINVAL;
>+				break;
>+			}
>+
>+			n_bytes = vsk->transport->unsent_bytes(vsk);
>+			if (n_bytes < 0) {
>+				retval = n_bytes;
>+				break;
>+			}
>+
>+			retval = put_user(n_bytes, arg);
>+		}
>+		break;
>+	}
>+	default:
>+		retval = -ENOIOCTLCMD;
>+	}
>+
>+	return retval;
>+}
>+
>+static int vsock_ioctl(struct socket *sock, unsigned int cmd,
>+		       unsigned long arg)
>+{
>+	int ret;
>+
>+	lock_sock(sock->sk);
>+	ret = vsock_do_ioctl(sock, cmd, (int __user *)arg);
>+	release_sock(sock->sk);
>+
>+	return ret;
>+}
>+
> static const struct proto_ops vsock_dgram_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -1302,7 +1356,7 @@ static const struct proto_ops vsock_dgram_ops = {
> 	.accept = sock_no_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = sock_no_listen,
> 	.shutdown = vsock_shutdown,
> 	.sendmsg = vsock_dgram_sendmsg,
>@@ -2286,7 +2340,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = vsock_listen,
> 	.shutdown = vsock_shutdown,
> 	.setsockopt = vsock_connectible_setsockopt,
>@@ -2308,7 +2362,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = vsock_listen,
> 	.shutdown = vsock_shutdown,
> 	.setsockopt = vsock_connectible_setsockopt,
>
>-- 
>2.45.2
>
>
>

