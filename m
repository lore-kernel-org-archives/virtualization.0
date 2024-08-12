Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC82E3F7
	for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453598; cv=none; b=HnLlcjm1XfhFoqDCeocffBPskMkL9300euKrYG6iEVKMmhk3a3W9f3Q6WQEGfFkHcgkNcfeiXIA9nKmcPXazpVchZc6gDYXQW9wot5mXuVLVoSz3W9thdtx328E+PRuyCeid6L/PcUblijjHxoRvyASPawNvZBru+5iBZtCPsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453598; c=relaxed/simple;
	bh=4903o0Gxm9S2KRs2tL3qBkHRdHaKxdPP61YxuBSYSok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I5SxXb/gXWkIc8Z9qrxUpdSg2ZD87avMgfCFCnCknJIReLcArcxE/Nh8iQmjVyGN5j1+GZjwSD8wTexCfVDnDAV4p8gxwrfJiYQl0cI5cNVawTdmnSuToUU2fE7DUxHQ7Nds1O/A0KboD1PpeIw5fkw6Dl4zBFr8j6pQZ4dM5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG3h7As0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG3h7As0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723453594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/OK5TTFOJekdHMnGIUU3vizmn/d2YxTUJutAY1KYUk=;
	b=PG3h7As0nR9ZE8N/YHRXYLQhH6/r+F5mfWs2ddTjXohuEEnv+9tnGcv4RYkX+tHN6TOIEj
	HfWuaq4acmOVW5ar540CMe/U3fNa0tUpSJs4She9BMWMBR2JaPxDmSQmY56+kDhQgBeP0A
	+YJWozU8rfKjDQxwBGy7gDi6WUo21wg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-Ybds7Ta9MyGOVTxA6GOcvw-1; Mon, 12 Aug 2024 05:06:33 -0400
X-MC-Unique: Ybds7Ta9MyGOVTxA6GOcvw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef23ec8dceso40615551fa.0
        for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 02:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453591; x=1724058391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/OK5TTFOJekdHMnGIUU3vizmn/d2YxTUJutAY1KYUk=;
        b=vwIlh4BRQbE1ezaM+dtKg6FKewaYh6VJOco+KeeQw0Gs/KYHdD6NCqeXTJ79Zu5K8d
         +XisrNBWGgKvWaDPw5RdEWrhPQZg6Wp8zYSEyURPRiTg8U0cwyueUkv5gxu7Cvs1rnFA
         dYUwy3rsPT5rL6L3DhEmrUcEJH3ZN3GZRi70G/re/mhUFA3X5RMclO7+q9aSe5ncV4vM
         EZj/CfCytSQpmRXaz/Xia1x7NSCTM5cw7L5lcYr0Otu1Yl3SS4nb3FZ+eCDcR3kLxciJ
         CU4uTWS/GJmvJJIesmQEt5ysTGt8eK3obCQqkrYe5cpiFbh0NSfCDcxSqWRP6PriWyjL
         F/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWdxKl/5SdXAI2aodul+FX9ofT4pR+wsH+KJLMw7LLs2lh4wonL7W9fUTgItnBICVDusuiPCQMOnbjOBYNuZOALGly7bYoMiEExp9iYNYU=
X-Gm-Message-State: AOJu0Yym27DrgwexAiFzV61GTH6/gujdeTtiBXRv99d6x5Nh+Dz6O9wd
	xCVZfIPSqEO3x7SS29bzTfmvo4C7JPqptKzy2F6uaxilHDjo28Sg1JMMObDuLOFhMQZxseNfFM2
	YG9Yab7+DBfsYhMt4MmKDges8+GJgNcyXk4x7TVzwpNTuwd3XTNc/ovLUXkr+Srkm
X-Received: by 2002:a05:6512:68c:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-530ee981756mr6180584e87.11.1723453591583;
        Mon, 12 Aug 2024 02:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDiJnYt6CnszI4XqFKJUcy5IhAQ8K4wWN1bwE7aP4/eaq/ZWMytHZunrBfn3on4sNHZzKmPw==
X-Received: by 2002:a05:6512:68c:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-530ee981756mr6180540e87.11.1723453590576;
        Mon, 12 Aug 2024 02:06:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:d1a0:5d86:9899:95ec:4118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea09sm6908779f8f.71.2024.08.12.02.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 02:06:29 -0700 (PDT)
Date: Mon, 12 Aug 2024 05:06:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	virtualization@lists.linux.dev, Cong Wang <cong.wang@bytedance.com>,
	syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix recursive ->recvmsg calls
Message-ID: <20240812050620-mutt-send-email-mst@kernel.org>
References: <20240812022153.86512-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240812022153.86512-1-xiyou.wangcong@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 11, 2024 at 07:21:53PM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> After a vsock socket has been added to a BPF sockmap, its prot->recvmsg
> has been replaced with vsock_bpf_recvmsg(). Thus the following
> recursiion could happen:
> 
> vsock_bpf_recvmsg()
>  -> __vsock_recvmsg()
>   -> vsock_connectible_recvmsg()
>    -> prot->recvmsg()
>     -> vsock_bpf_recvmsg() again
> 
> We need to fix it by calling the original ->recvmsg() without any BPF
> sockmap logic in __vsock_recvmsg().
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
> Tested-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
> Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/net/af_vsock.h    |  4 ++++
>  net/vmw_vsock/af_vsock.c  | 50 +++++++++++++++++++++++----------------
>  net/vmw_vsock/vsock_bpf.c |  4 ++--
>  3 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 535701efc1e5..24d970f7a4fa 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -230,8 +230,12 @@ struct vsock_tap {
>  int vsock_add_tap(struct vsock_tap *vt);
>  int vsock_remove_tap(struct vsock_tap *vt);
>  void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
> +int __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +				int flags);
>  int vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			      int flags);
> +int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> +			  size_t len, int flags);
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags);
>  
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 4b040285aa78..0ff9b2dd86ba 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1270,25 +1270,28 @@ static int vsock_dgram_connect(struct socket *sock,
>  	return err;
>  }
>  
> +int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> +			  size_t len, int flags)
> +{
> +	struct sock *sk = sock->sk;
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +
> +	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
> +}
> +
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags)
>  {
>  #ifdef CONFIG_BPF_SYSCALL
> +	struct sock *sk = sock->sk;
>  	const struct proto *prot;
> -#endif
> -	struct vsock_sock *vsk;
> -	struct sock *sk;
>  
> -	sk = sock->sk;
> -	vsk = vsock_sk(sk);
> -
> -#ifdef CONFIG_BPF_SYSCALL
>  	prot = READ_ONCE(sk->sk_prot);
>  	if (prot != &vsock_proto)
>  		return prot->recvmsg(sk, msg, len, flags, NULL);
>  #endif
>  
> -	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
> +	return __vsock_dgram_recvmsg(sock, msg, len, flags);
>  }
>  EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
>  
> @@ -2174,15 +2177,12 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>  }
>  
>  int
> -vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> -			  int flags)
> +__vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +			    int flags)
>  {
>  	struct sock *sk;
>  	struct vsock_sock *vsk;
>  	const struct vsock_transport *transport;
> -#ifdef CONFIG_BPF_SYSCALL
> -	const struct proto *prot;
> -#endif
>  	int err;
>  
>  	sk = sock->sk;
> @@ -2233,14 +2233,6 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		goto out;
>  	}
>  
> -#ifdef CONFIG_BPF_SYSCALL
> -	prot = READ_ONCE(sk->sk_prot);
> -	if (prot != &vsock_proto) {
> -		release_sock(sk);
> -		return prot->recvmsg(sk, msg, len, flags, NULL);
> -	}
> -#endif
> -
>  	if (sk->sk_type == SOCK_STREAM)
>  		err = __vsock_stream_recvmsg(sk, msg, len, flags);
>  	else
> @@ -2250,6 +2242,22 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	release_sock(sk);
>  	return err;
>  }
> +
> +int
> +vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +			  int flags)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +	struct sock *sk = sock->sk;
> +	const struct proto *prot;
> +
> +	prot = READ_ONCE(sk->sk_prot);
> +	if (prot != &vsock_proto)
> +		return prot->recvmsg(sk, msg, len, flags, NULL);
> +#endif
> +
> +	return __vsock_connectible_recvmsg(sock, msg, len, flags);
> +}
>  EXPORT_SYMBOL_GPL(vsock_connectible_recvmsg);
>  
>  static int vsock_set_rcvlowat(struct sock *sk, int val)
> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index a3c97546ab84..c42c5cc18f32 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -64,9 +64,9 @@ static int __vsock_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int
>  	int err;
>  
>  	if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
> -		err = vsock_connectible_recvmsg(sock, msg, len, flags);
> +		err = __vsock_connectible_recvmsg(sock, msg, len, flags);
>  	else if (sk->sk_type == SOCK_DGRAM)
> -		err = vsock_dgram_recvmsg(sock, msg, len, flags);
> +		err = __vsock_dgram_recvmsg(sock, msg, len, flags);
>  	else
>  		err = -EPROTOTYPE;
>  
> -- 
> 2.34.1

