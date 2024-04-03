Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0536F083
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134814; cv=none; b=Jpv0z6x5SuKRYEe4UwYsnQPOvp/pqz49jp0xND0IcfSZl3JC4h41Zr10w13XxRk+5HODU2v+swXuHdnAzWR7OOWYUm9yZNsI6ROxemd4JJgNg1w2CUqb/xd3O07qrAloiRu25tLgfx6zxwC4hXk2GPe+aFSne1rGaQF+QHU67sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134814; c=relaxed/simple;
	bh=2d6ZUsBlgzR4T8JBDYxCVmRmClrqIlJvH/JnSOyemxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sxO+v7hsq1j7vNTl4mG3gWCBhgqfksbbOmKdh0f0qQxRH7CopxmytiggcrTAYuxng9MRrj42Yfaryh+yYFWnpYpJEXOV/6VJ73Yu5LKqdPWQHaLoLft320Yt4LbabdtTO6fAdBKsMLvgJpc9teyZlOReZ/7TwzUBaFwTEXmS7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hm5nBFe/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hm5nBFe/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712134812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JE5CsJ7kL74rep0BkNPkoZkZLlxXhnrOBkLMW12RKB8=;
	b=hm5nBFe/j7Wfqqf2ICSXT3b8DRDmfZxXhZG6jYs/nNetJzAWmUjSed57TkHokWslcC0ew0
	hw4+m1Acf4NqD9qDeUAwIcWVi2UpDj9bYk+pN+pZMCiitEVUuYAuLKfIc2vGOyKHSwQvYr
	8VBB1p6apo402yzsnVjekcqAGmrNFDE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-JWQLyl5UOFmlLGuiVCb6Ng-1; Wed, 03 Apr 2024 05:00:10 -0400
X-MC-Unique: JWQLyl5UOFmlLGuiVCb6Ng-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ed489edcaso3979908f8f.3
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 02:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712134809; x=1712739609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE5CsJ7kL74rep0BkNPkoZkZLlxXhnrOBkLMW12RKB8=;
        b=Ha1PF8vyptDpzoiQgNHVoGCUcvqaGjeVIN9Lz6saXwCva9zDdnIHHs+6+k7MjsumKl
         3RV3TlqhDh+6W2oGuSvuxAhUytsqSyhUKQOhMbHgwnd+WQyB1uUmvc7OkEikvmWZh47b
         krUiODd+8zMx7BxIakc6zlNO0teG8zWkW9SGuH+a8wjmg1rvb3Wyzdy6KY4wHC4qfQ4v
         /jh7QHagVEdUT+PBztsR/Xn2oWIiCdLdjSerpSGFbweOI99ZGRbL0cOKGqCeKqooVISv
         XFj9tutViP25XnK41fbwta3Np2GqNnjkliknU918d5SmK/nW5hbCdLF1ArazW3lDXAGf
         2HtA==
X-Forwarded-Encrypted: i=1; AJvYcCXDKEOBu3VhFdaVQOrUUpSfjJWcsFZO4X4uZhGvoxCv4BgTytaeNZT1EcEgxPuISdXEE0rujpM+PBlBG/aOInr32zNC9e9qNEyt0yXhS9k=
X-Gm-Message-State: AOJu0YxiYl7xhnNz5r6Mc6KDrztLeCAGyDi8ei1rG9VXEc4snDuOeOi1
	MIlBTsHEWdsmO04mwyfPQ8C1jxurfaLsMbT1/WzZWTu3fZ3PYiE0BjGEGAkr6hVE2ZOCd0FqDsV
	N0qQxngP4FQIzcxov4q/ZhtT5JLd20urevOLFVSc/N6EJJNooNWNe1LCxQykVyfyc
X-Received: by 2002:a5d:4a41:0:b0:341:cf18:70b3 with SMTP id v1-20020a5d4a41000000b00341cf1870b3mr12886241wrs.27.1712134809626;
        Wed, 03 Apr 2024 02:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0zdlwMZAbcSiFAU8KPHuLmc2v4KW+Pzfncb+ilq5cKvWI91wzQJ6twEst7GvvlCd18xMZYg==
X-Received: by 2002:a5d:4a41:0:b0:341:cf18:70b3 with SMTP id v1-20020a5d4a41000000b00341cf1870b3mr12886219wrs.27.1712134809235;
        Wed, 03 Apr 2024 02:00:09 -0700 (PDT)
Received: from sgarzare-redhat ([185.95.145.60])
        by smtp.gmail.com with ESMTPSA id by7-20020a056000098700b0033ec94c6277sm16729642wrb.115.2024.04.03.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:00:08 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:00:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, 
	virtualization@lists.linux.dev, mst@redhat.com, kuba@kernel.org, xuanzhuo@linux.alibaba.com, 
	netdev@vger.kernel.org, stefanha@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add support for SIOCOUTQ ioctl for
 all vsock socket types.
Message-ID: <weigxhmoj4qoiqz45eklm3n5c3gw75l7ml3pt2seq3jiip7xw6@alqavbovpdoy>
References: <20240402150539.390269-1-luigi.leonardi@outlook.com>
 <AS2P194MB2170C0FC43DDA2CB637CE6B29A3E2@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AS2P194MB2170C0FC43DDA2CB637CE6B29A3E2@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 02, 2024 at 05:05:37PM +0200, Luigi Leonardi wrote:
>This add support for ioctl(s) for SOCK_STREAM SOCK_SEQPACKET and SOCK_DGRAM
>in AF_VSOCK.
>The only ioctl available is SIOCOUTQ/TIOCOUTQ, which returns the number
>of unsent bytes in the socket. This information is transport-specific
>and is delegated to them using a callback.
>
>Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 42 +++++++++++++++++++++++++++++++++++++---
> 2 files changed, 40 insertions(+), 3 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 535701efc1e5..cd4311abd3c9 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -137,6 +137,7 @@ struct vsock_transport {
> 	u64 (*stream_rcvhiwat)(struct vsock_sock *);
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>+	int (*stream_bytes_unsent)(struct vsock_sock *vsk);
>
> 	/* SEQ_PACKET. */
> 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 54ba7316f808..991e9edfa743 100644
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
>@@ -1292,6 +1293,41 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> }
> EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
>
>+static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>+			  int __user *arg)
>+{
>+	struct sock *sk = sock->sk;
>+	int retval = -EOPNOTSUPP;
>+	struct vsock_sock *vsk;
>+
>+	vsk = vsock_sk(sk);
>+
>+	switch (cmd) {
>+	case SIOCOUTQ:
>+		if (vsk->transport->stream_bytes_unsent) {
>+			if (sk->sk_state == TCP_LISTEN)

Maybe we should do this check only if
`sock_type_connectible(sk->sk_type)` is true.

>+				return -EINVAL;
>+			retval = vsk->transport->stream_bytes_unsent(vsk);

IIUC `stream_bytes_unsent()` is used for any type of socket, so I
suggest using a name more generic, something like `unsent_bytes()`.

>+		}
>+		break;
>+	default:
>+		retval = -EOPNOTSUPP;

Should we return -ENOIOCTLCMD in this case?

>+	}
>+
>+	if (retval >= 0) {

IMHO mixing the the ioctl() return value and the value itself is
confusing.

I also suggest to move the put_user() in the `case SIOCOUTQ`,
other ioctls may no needs any value to copy to userspace.

>+		put_user(retval, arg);

put_user() can fail, we should return the failure to the user.

>+		retval = 0;
>+	}
>+
>+	return retval;
>+}
>+
>+static int vsock_ioctl(struct socket *sock, unsigned int cmd,
>+		       unsigned long arg)
>+{
>+	return vsock_do_ioctl(sock, cmd, (int __user *)arg);
>+}
>+
> static const struct proto_ops vsock_dgram_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -1302,7 +1338,7 @@ static const struct proto_ops vsock_dgram_ops = {
> 	.accept = sock_no_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = sock_no_listen,
> 	.shutdown = vsock_shutdown,
> 	.sendmsg = vsock_dgram_sendmsg,
>@@ -2286,7 +2322,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = vsock_listen,
> 	.shutdown = vsock_shutdown,
> 	.setsockopt = vsock_connectible_setsockopt,
>@@ -2308,7 +2344,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = vsock_listen,
> 	.shutdown = vsock_shutdown,
> 	.setsockopt = vsock_connectible_setsockopt,
>-- 
>2.34.1
>

