Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E813F9A1E
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138486; cv=none; b=Dc2RlyeHoTuSqJoogtnFE5+ZVD6xtWWs6dCJ8AxCVdTD2/CPXxOmCxKsagtW/lwUOjweRR5aRJ8JD9ABYU8PKx35vADh/bSxGYb52572lh0JDUQzqXRDNoWVlg8B9t+sXVgM57hovtJteRs2fqexus4w60fnKggEogB6RqMUthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138486; c=relaxed/simple;
	bh=6URY0D6oYme6xz01rwrlqB2zCECHzV8y7FzNmRlu6EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T0FSQL/KG+aN9o7dsu7B7YGj0TKXjjIMHIQKyfT2NsRaPWCxRgvMivFtCLsfeCCEWXxz31p7f+pKgtLif87qnsbIQAWHBB2rl7KntYrNp4W3RkUd8oULzy7tavGoaTEJDJRetmvvB9OxBrJPsQMbNg1Dj7xJtQVhASi1kxBUZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5piqYmh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5piqYmh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792138484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56RICpgwGhNm6LSWh8AoomM8aDXtuq7tL8RIbQGojuE=;
	b=M5piqYmh/ljmPlI/iQu4YfRZBvRXdMRXb4nFhe+g3fWv3GnyhZqwoCKkQyCeogLKyLlEeQ
	+4Iqa2UVfJdC9On0rd3swGsNOsWJvIQuxgB/yj5vY2DlZf+Y53SL6m74l+wZ2LkfaBBUee
	eFfIo8Xh6IEZKtOIQzmuHiuQ1Jwou24=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-lgIfqu-mPf2SijQ9zmB7RA-1; Fri, 16 Oct 2026 08:14:42 +0000
X-MC-Unique: lgIfqu-mPf2SijQ9zmB7RA-1
X-Mimecast-MFC-AGG-ID: lgIfqu-mPf2SijQ9zmB7RA_1792138481
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so20139545e9.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 01:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792138481; x=1792743281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56RICpgwGhNm6LSWh8AoomM8aDXtuq7tL8RIbQGojuE=;
        b=1S/2bV4cczTf/ELg/9MvhgdB3ys4w8c4ig2JPJBhrg7ZJr3EAV/aK6dVTlMQKn/t6e
         7a+E+nH0DKhlS4ZdtBlewunhFqVpXkkutjycFLgJIzJIjBc6HnUziCk79d2gFg7EPlCp
         meapJGilykQ7K+Gs+WjtlQG63+Y6hDqlRSsTX8OTUhoRYO0WIhyd2vpowKVITrACFXdn
         H9VtnxZg30zL6KEULJE3n/2Sk7i2Ot/GR0nyDhIyyQMIQyMCu4sjXATrdM5/sD99VbHY
         PnD48u9GRKIQDdHmHf/tFgZww8kcZ/4HZAWce31XDiYebFw1dSUsYtWMgB7ORHYih1h+
         C2xw==
X-Forwarded-Encrypted: i=1; AKwUvBy66RRHDpxDkwxq690HhhPG2oJZG1uC3GixjiYvWrq8hUyqzTD/CoLarNMO1PNnz+q+X1pdrVin+dS/nOFO/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLdf9EXtkC+yLKkxbBkKoky9NWKYihoR9+7phTdUo3uMKU3A3hl
	RS981I+9v7ODCY/Ts7msyC/a6VB7hIFtUeNSgEXlngpY4CPK3vNg8r1pJTYJgnhli2OXZJ1e6VM
	timukucqcHl56GQWX8nlrf43YAiuPwRYkbuMCFFm9QBsAq1H5X81knTS8x2vwB3z+hiu5
X-Gm-Gg: AYBFou2VEzIIj3LfohCADMZ5IJsgp0xelZiMPidKeZ9hLdrSPPr6joIaYCkjiINxJu0
	ECtTbbRI1Vn63IhXgrvvo+JhrfEL+4goHfneRcWIHYIqpxAEZxjzDpuH7o+z0Z3K99WZ4idGOA9
	/0wWyfovv/d6l45hJP7WQsaT7dymcjDUWNySMWMWDIfwr7pEfyoWRvcavgJxt9J0habjgkU00dr
	k3lNxwPxoA69yqFh6dMFFqsdQXPCQTcI/TpGzK8rmH/iYvDSxPw4E/Pt5M+sGpz89RcGm1IPcVq
	kYHIPwVKCCrHmiSzHiYKhDeODtQ3Ku42r9rpXRqmvkaGOyP91nHq1mCtDYnGky4epjcI27oiCZm
	tCWkO
X-Received: by 2002:a05:600c:19cf:b0:4a0:168f:d962 with SMTP id 5b1f17b1804b1-4a18e44363dmr423676065e9.3.1792138481259;
        Fri, 16 Oct 2026 01:14:41 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:4a0:168f:d962 with SMTP id 5b1f17b1804b1-4a18e44363dmr423675585e9.3.1792138480725;
        Fri, 16 Oct 2026 01:14:40 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd47104csm3835450f8f.8.2026.10.16.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:14:39 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:14:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] vsock: support SO_INQ on stream sockets
Message-ID: <atHT4vOo39HBEBva@sgarzare-redhat>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261015154334.3217358-2-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 038vm1Lyeg34ExFaNAASiRPEeHeIa8FoT_PMhm34H4M_1792138481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 15, 2026 at 04:43:33PM +0100, David Carlier wrote:
>SO_INQ makes recvmsg() return the bytes left in the receive queue in an
>SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
>support it, AF_VSOCK fails with ENOPROTOOPT.
>
>Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
>As with TCP_INQ, 1 is reported once the stream is finished so the caller
>reads again and sees EOF, and accepted sockets inherit the setting from
>the listener. No cmsg is sent when the transport cannot report the queue
>length.
>
>SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
>messages, not bytes.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> include/net/af_vsock.h   |   1 +
> net/vmw_vsock/af_vsock.c | 111 +++++++++++++++++++++++++++++----------
> 2 files changed, 84 insertions(+), 28 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 5549298c1ec6..e8481f12312e 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -68,6 +68,7 @@ struct vsock_sock {
> 	u64 buffer_size;
> 	u64 buffer_min_size;
> 	u64 buffer_max_size;
>+	bool recvmsg_inq;
>
> 	/* Private to transport. */
> 	void *trans;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 1c2d1cea67f4..186ed57fd797 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -984,6 +984,7 @@ static struct sock *__vsock_create(struct net *net,
> 		vsk->buffer_size = psk->buffer_size;
> 		vsk->buffer_min_size = psk->buffer_min_size;
> 		vsk->buffer_max_size = psk->buffer_max_size;
>+		vsk->recvmsg_inq = psk->recvmsg_inq;
> 		security_sk_clone(parent, sk);
> 	} else {
> 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
>@@ -2014,6 +2015,66 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
> 	vsk->buffer_size = val;
> }
>
>+static bool vsock_custom_sockopt(int optname)

Looking at the other function, what about vsock_sol_socket_custom()?

>+{
>+	switch (optname) {
>+	case SO_ZEROCOPY:
>+	case SO_INQ:
>+		return true;
>+	default:
>+		return false;
>+	}
>+}
>+
>+static int vsock_sol_socket_setsockopt(struct sock *sk, int optname,
>+				       sockptr_t optval, unsigned int optlen)
>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	int err = 0;
>+	int val;
>+
>+	/* Use 'int' type here, because variable to

nit: why not using at least 80 columns for this comment?

>+	 * set these options usually has this type.
>+	 */
>+	if (optlen < sizeof(val))
>+		return -EINVAL;
>+
>+	if (copy_from_sockptr(&val, optval, sizeof(val)))
>+		return -EFAULT;
>+
>+	if (val < 0 || val > 1)
>+		return -EINVAL;

What about adding an helper with this code, and call it after checks for 
each SO_, in this way using SO_INQ on sock_dgram with 2 will return 
-ENOPROTOOPT.

Oh wait, we can use COPY_IN and duplicate the check in each place or add 
an helper just for that.

>+
>+	lock_sock(sk);
>+
>+	switch (optname) {
>+	case SO_ZEROCOPY:
>+		if (vsk->transport && !vsock_msgzerocopy_allow(vsk->transport)) {
>+			err = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
>+		break;
>+
>+	case SO_INQ:
>+		if (sk->sk_type != SOCK_STREAM) {
>+			err = -ENOPROTOOPT;
>+			break;
>+		}
>+
>+		vsk->recvmsg_inq = val;
>+		break;
>+
>+	default:
>+		err = -ENOPROTOOPT;
>+		break;
>+	}
>+
>+	release_sock(sk);
>+	return err;
>+}

Now it's much better, but we should not mix a refactoring with a new 
feature, so please split this patch in 2 patches, first one introducing 
vsock_sol_socket_setsockopt() just for SO_ZEROCOPY, second one 
introducing SO_INQ handling.

In this way, if we have to backport a fix to SO_ZEROCOPY handling in a 
stable branch, we can do it easily.

The rest LGTM,
Stefano

>+
> static int vsock_connectible_setsockopt(struct socket *sock,
> 					int level,
> 					int optname,
>@@ -2045,36 +2106,16 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	sk = sock->sk;
> 	vsk = vsock_sk(sk);
>
>-	lock_sock(sk);
>-
>-	transport = vsk->transport;
>-
> 	if (level == SOL_SOCKET) {
>-		int zerocopy;
>-
>-		if (optname != SO_ZEROCOPY) {
>-			release_sock(sk);
>+		if (!vsock_custom_sockopt(optname))
> 			return sock_setsockopt(sock, level, optname, optval, optlen);
>-		}
>-
>-		/* Use 'int' type here, because variable to
>-		 * set this option usually has this type.
>-		 */
>-		COPY_IN(zerocopy);
>
>-		if (zerocopy < 0 || zerocopy > 1) {
>-			err = -EINVAL;
>-			goto exit;
>-		}
>+		return vsock_sol_socket_setsockopt(sk, optname, optval, optlen);
>+	}
>
>-		if (transport && !vsock_msgzerocopy_allow(transport)) {
>-			err = -EOPNOTSUPP;
>-			goto exit;
>-		}
>+	lock_sock(sk);
>
>-		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
>-		goto exit;
>-	}
>+	transport = vsk->transport;
>
> 	switch (optname) {
> 	case SO_VM_SOCKETS_BUFFER_SIZE:
>@@ -2581,6 +2622,7 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	struct sock *sk;
> 	struct vsock_sock *vsk;
> 	const struct vsock_transport *transport;
>+	bool do_cmsg = false;
> 	int err;
>
> 	sk = sock->sk;
>@@ -2637,13 +2679,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>
> out:
>-	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
>-	 * a byte length when sizing retries, so only streams report a hint.
>+	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
>+	 * io_uring treats msg_inq as a byte length when sizing retries, so
>+	 * only streams report it.
> 	 */
>-	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
>+	if ((vsk->recvmsg_inq || msg->msg_get_inq) && err >= 0 &&
>+	    sk->sk_type == SOCK_STREAM) {
> 		msg->msg_inq = vsock_stream_inq_hint(sk);
>
>+		/* A negative hint means the transport could not tell. SCM_INQ
>+		 * has no encoding for that, so report nothing.
>+		 */
>+		do_cmsg = vsk->recvmsg_inq && msg->msg_inq >= 0;
>+	}
>+
> 	release_sock(sk);
>+
>+	if (do_cmsg)
>+		put_cmsg(msg, SOL_SOCKET, SCM_INQ, sizeof(msg->msg_inq),
>+			 &msg->msg_inq);
>+
> 	return err;
> }
>
>-- 
>2.55.0
>

