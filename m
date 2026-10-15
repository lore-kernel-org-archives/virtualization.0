Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB863E275F
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084075; cv=none; b=TlAb4InvK36fkt8Mu1cukA/FRg1AD6ctBwE7w10e+iaYwFg2fFIVS+JMXWLOEc78CUEiZmWFhQjtyqjX9joHfIB5VbJfqOsfNWyUGbHdYPqAX9+CcQYirepn5rmJl7tDykxA/m4bj9C3sq98ld9nslWHdM7H+T2j1o3LNrq4WNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084075; c=relaxed/simple;
	bh=PSVBHJzDjf+cebHOc9eSx8giEVaXgMK5QQ9c35c1xLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP2dMruR5/ArkMIgjeOoxGd62+OfZgZlBFMzHAwt7tfvrlFvjJCNFBatNIcZ+Z/xTed94GsF5k5WSX8eOSdSo6ZqVdb1f45XVfwyNHPgOk/oi4TebNo3PMnyUrDc7dZlfbMkuURhSCadttE8/Fi1852SfMLkNcBEJaAofo2zCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As20m1tD; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As20m1tD"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-53656465d1dso218471b6e.2
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084057; x=1792688857; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RGKsANacdZMd9ipQ62NebQime+gEaLlPbg00vy9J+5I=;
        b=As20m1tDllpJp8nYhXgBjq7X6offSS6Y1UYRnnCDRJG9ofRJFWdvl461/psS80m08X
         QE/RgWle9+7jMuEVI17HSZ9HnTx4fb6byYMd9zNpk4EO/0/qNneBeOo9N0xhFsjYHWLC
         lLJro6t7u7Y0+PaZqnNfRwJctdWvjdxyWq4A1sWzyelve2P5jQEKfRouUkXFYGjfkLpX
         ORj7bJsQHV09lEQrXu54UKWAE1v2IBdDrHAYxTXHwO6vaIZI2ZJhe+h8qCZmqXgsflQY
         ndRDFm52sd9kBhWXMR+tDAYz56MlFfaRKYs13y7JKPuVdX0gp3y5E9fem2A3NIPh7Jjd
         hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084057; x=1792688857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGKsANacdZMd9ipQ62NebQime+gEaLlPbg00vy9J+5I=;
        b=VvsrPcshY7kmGYJqKgzg+SOUtjJnOYW9u1RY8ijY7ESmmHVvmdnOvPm1DTuFuxqDkV
         dOt/3/U5Mjjr0CTG3ltQ2hFlgd/w5gyP4pJfkUTjLjBT6qjSn40G3xtHGqPiBjG1mDfT
         FhbaSITasbZ/Rgl8aF2jKxPCD22c1kgvIEpk+XXXe7qxl8Uogo2DqLkHZLoVOC7NpS42
         o8o+wwHXdmxnX2YhfKXTu8LEsZfy+Kuv31ZrKeN+Hs4mllB+u87fNHMeqtnwbQB21vsr
         zPaLs7lDTJ1B1fwRLI09/0HoQp2gNt3FvccFXsbebFNm20DqR2KDolcfXBxmzDVz1b8J
         41lg==
X-Forwarded-Encrypted: i=1; AKwUvBwWZIl2aKngcpsiQUsJReEAnNMnbdMx6KMyoT0YppEMB70CXVm6wZBEEm2+G2AXAMf65xx/1Cf06KZDjdpkhw==@lists.linux.dev
X-Gm-Message-State: AFq9FYINWql7tYTuwxFUKouSw46dLfNRicQ+m8PUQ2NXvoSIIjrLkkbR
	XPXNtgVhV+KCl9kk8yFYkQmOElRsu8KxuY8ZIyiyb5BMiWGDsVFedbB6
X-Gm-Gg: AYBFou3NlzffeQ+dyshmhx4OSD4LCHK+H4dhh+un5g8j6Yzb/Wbpa4XgbuPdAsTwtWB
	2Mz/mFqQHnj3Z8l9m9Wk2OhLc0zK+4AB6VIWE9saCLd888ZaPEy2uuXrQIokVDuwIAvme+0vwu3
	4YqL8s8p2R32+zMFwLgNjN5xoMZK0Ansz8U8wjVLq7bdWgxF4Ck/1GNL5HYuMCosPLhvQ1dq5pK
	egZsI7s74jWs65FlEPmcVrV/S6v5E8t+mK+rMg0EgVeWNJdNYJ1uzRAcCGhtZCXtb7F0YNvfg5X
	aMfIsW5HkTX3CUUzCDPxow6SiNFpOts/l/Em3AhgwEFtiC9r7JbXXQnzjj4UaKBzkRkw5JljRu1
	V8aoEegpVohcTdtMX07+JRJhjgwWFvjHalDWEdcT8n64715rtNJbvzUiCav2m0WvO4FH6ltxc+G
	8CsMaCPoEzraqK/2qPku+94oZYzcTgOu3jTFNGs/REcq/dJ6E7Hi0w3vluZ8ZqwBIOyA==
X-Received: by 2002:a05:6808:4fde:b0:4f3:e98f:fa26 with SMTP id 5614622812f47-50c56deebe6mr17460836b6e.58.1792084056686;
        Thu, 15 Oct 2026 10:07:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-537b247b531sm39258b6e.5.2026.10.15.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:07:36 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:07:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] vsock: support SO_INQ on stream sockets
Message-ID: <atEIVxvrCELGtdmM@devvm29614.prn0.facebook.com>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015154334.3217358-2-devnexen@gmail.com>

On Thu, Oct 15, 2026 at 04:43:33PM +0100, David Carlier wrote:
> SO_INQ makes recvmsg() return the bytes left in the receive queue in an
> SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
> support it, AF_VSOCK fails with ENOPROTOOPT.
> 
> Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
> As with TCP_INQ, 1 is reported once the stream is finished so the caller
> reads again and sees EOF, and accepted sockets inherit the setting from
> the listener. No cmsg is sent when the transport cannot report the queue
> length.
> 
> SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
> messages, not bytes.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  include/net/af_vsock.h   |   1 +
>  net/vmw_vsock/af_vsock.c | 111 +++++++++++++++++++++++++++++----------
>  2 files changed, 84 insertions(+), 28 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1ec6..e8481f12312e 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -68,6 +68,7 @@ struct vsock_sock {
>  	u64 buffer_size;
>  	u64 buffer_min_size;
>  	u64 buffer_max_size;
> +	bool recvmsg_inq;
>  
>  	/* Private to transport. */
>  	void *trans;
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1c2d1cea67f4..186ed57fd797 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -984,6 +984,7 @@ static struct sock *__vsock_create(struct net *net,
>  		vsk->buffer_size = psk->buffer_size;
>  		vsk->buffer_min_size = psk->buffer_min_size;
>  		vsk->buffer_max_size = psk->buffer_max_size;
> +		vsk->recvmsg_inq = psk->recvmsg_inq;
>  		security_sk_clone(parent, sk);
>  	} else {
>  		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
> @@ -2014,6 +2015,66 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
>  	vsk->buffer_size = val;
>  }
>  
> +static bool vsock_custom_sockopt(int optname)
> +{
> +	switch (optname) {
> +	case SO_ZEROCOPY:
> +	case SO_INQ:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int vsock_sol_socket_setsockopt(struct sock *sk, int optname,
> +				       sockptr_t optval, unsigned int optlen)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	int err = 0;
> +	int val;
> +
> +	/* Use 'int' type here, because variable to
> +	 * set these options usually has this type.
> +	 */
> +	if (optlen < sizeof(val))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	if (val < 0 || val > 1)
> +		return -EINVAL;
> +
> +	lock_sock(sk);
> +
> +	switch (optname) {
> +	case SO_ZEROCOPY:
> +		if (vsk->transport && !vsock_msgzerocopy_allow(vsk->transport)) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}
> +
> +		sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
> +		break;
> +
> +	case SO_INQ:
> +		if (sk->sk_type != SOCK_STREAM) {
> +			err = -ENOPROTOOPT;
> +			break;
> +		}
> +
> +		vsk->recvmsg_inq = val;
> +		break;
> +
> +	default:
> +		err = -ENOPROTOOPT;
> +		break;
> +	}
> +
> +	release_sock(sk);
> +	return err;
> +}
> +
>  static int vsock_connectible_setsockopt(struct socket *sock,
>  					int level,
>  					int optname,
> @@ -2045,36 +2106,16 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  	sk = sock->sk;
>  	vsk = vsock_sk(sk);
>  
> -	lock_sock(sk);
> -
> -	transport = vsk->transport;
> -
>  	if (level == SOL_SOCKET) {
> -		int zerocopy;
> -
> -		if (optname != SO_ZEROCOPY) {
> -			release_sock(sk);
> +		if (!vsock_custom_sockopt(optname))
>  			return sock_setsockopt(sock, level, optname, optval, optlen);
> -		}
> -
> -		/* Use 'int' type here, because variable to
> -		 * set this option usually has this type.
> -		 */
> -		COPY_IN(zerocopy);
>  
> -		if (zerocopy < 0 || zerocopy > 1) {
> -			err = -EINVAL;
> -			goto exit;
> -		}
> +		return vsock_sol_socket_setsockopt(sk, optname, optval, optlen);
> +	}
>  
> -		if (transport && !vsock_msgzerocopy_allow(transport)) {
> -			err = -EOPNOTSUPP;
> -			goto exit;
> -		}
> +	lock_sock(sk);
>  
> -		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
> -		goto exit;
> -	}
> +	transport = vsk->transport;
>  
>  	switch (optname) {
>  	case SO_VM_SOCKETS_BUFFER_SIZE:
> @@ -2581,6 +2622,7 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	struct sock *sk;
>  	struct vsock_sock *vsk;
>  	const struct vsock_transport *transport;
> +	bool do_cmsg = false;
>  	int err;
>  
>  	sk = sock->sk;
> @@ -2637,13 +2679,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>  
>  out:
> -	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
> -	 * a byte length when sizing retries, so only streams report a hint.
> +	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
> +	 * io_uring treats msg_inq as a byte length when sizing retries, so
> +	 * only streams report it.
>  	 */
> -	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
> +	if ((vsk->recvmsg_inq || msg->msg_get_inq) && err >= 0 &&
> +	    sk->sk_type == SOCK_STREAM) {
>  		msg->msg_inq = vsock_stream_inq_hint(sk);
>  
> +		/* A negative hint means the transport could not tell. SCM_INQ
> +		 * has no encoding for that, so report nothing.
> +		 */
> +		do_cmsg = vsk->recvmsg_inq && msg->msg_inq >= 0;
> +	}
> +
>  	release_sock(sk);
> +
> +	if (do_cmsg)
> +		put_cmsg(msg, SOL_SOCKET, SCM_INQ, sizeof(msg->msg_inq),
> +			 &msg->msg_inq);
> +
>  	return err;
>  }
>  
> -- 
> 2.55.0
> 

All LGTM.

Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
