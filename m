Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAD215067
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792585; cv=none; b=A2+Y7tMGzSSDLjo5bIM6FqsOp1Bwu5tgKqHbPCFiICUT3PWA/YzQXHGKOJXmVSLuz07WmTCt9ll9NBkPY+BqORUUiXn1iQXKACjANoE5VtpeEJm3zqBIJOM5rMwPpcGTixF+JecUDjmNK0AB3ZNnj1j2+4UdpIDm1GTK2GS0TKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792585; c=relaxed/simple;
	bh=aK4znbSBlzCXvDjjmG56/kAUnE1HtKriM2kwXRXVdL0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iY2PcAUKDnqKiGcBb5zBd5J9dUE7Sku9A7zGJkqV66WJ103jaouyqEHAIykRo+py8Vgu38f8+BEsMdmTZGnAYxvjBr0CJaLxtUgV6jN0RE6XhgWkioJ06FzU1BTfpDOjS42z9hEleUKZsiFGvSLm8EelH3iwtI370xf/B2fOk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix/UxR6L; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix/UxR6L"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46fcbb96ba9so3793731cf.0
        for <virtualization@lists.linux.dev>; Wed, 05 Feb 2025 13:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738792582; x=1739397382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oernhFzJvDHR/AMo6PZewM8ZACtPVAaEoHou4hT+kg=;
        b=ix/UxR6L8g2WIq2VWlTMAYko6oWVGT/Bj7GUlzseZup1huqA8MhJ6fg9V2bFfECuPl
         r/3oiVhr2QvlMh0xtO59KJsDRo3uxPFSEybUhJpuzeRo5PP+TjHrmFQofxjiCNmekvQD
         mtkLs92sHpbVp4pVcVoE0doqn2vJdJdJgvJTiHMcCZwZ/wiwiNUrPrOXKOueL8uFlXJK
         Jz0nqSipRn/aANW0WEK9brCnEsK7hUkxbVvXUYndhPzozCx/Fn6miu0c7ZmKGzQJ/yDt
         OrgJ4tlTL33etCxVCqcC1YkwUFBSy64HSTWfc6mTsMj5KclVVFOsBBYPyZ8PzSaowZAG
         S2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738792582; x=1739397382;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/oernhFzJvDHR/AMo6PZewM8ZACtPVAaEoHou4hT+kg=;
        b=Ftpito1CUqfaRe3rfNPgruz3JyXqoiZCoAO2MtfkS9bCjkKwQv9vwgcLVhhwdXkrUZ
         0rCoHjgz4q7tBjMdWAmEQnFodt/huyuJRPQ0hqeYghLvoxArrtOh0xtkyafTK/pjUrbr
         NqDyGPpCoBaA7aOBSfpIeuc9wEeeY1Ui7zGgbw2d/O4t5uBa833WRoXpUB7kAGwKbH8A
         S72fJAKaXsxNx8mRjXHNCcARBr0CdVdqbvZP6nGQEr8NtSsyM79i5FT0YYAnYOurU3Oy
         FHPY8xcm7AEnEo+NqHvkh+qBAPiMLahZSLFfiNIvFqtiGSVI9Sn/ND8vPNYU4ImqQ+9t
         My1w==
X-Forwarded-Encrypted: i=1; AJvYcCXsvrxG7W+wa762Te1+elkVQiqXoZ2MXBnZcxhDviWRIwR2Q+ZRI8/VF3uAmeLWAz3szyiiCgE6EdfpVm2cPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8poyhD75UjmrgrTJDehzBXUeHqjUSIPftFYzLTus349auG+yD
	yjjlrUZsi624uOHDLTQfpeHgc1l+rweiGm9l3X6KDrUmraUwqVhup7otug==
X-Gm-Gg: ASbGncsJzWlVM6NlifyjJKQ/W2xImoDq4vXr3aCfKCduoabe0a9AWsbwCTi9cbw4T0P
	eakjuMZLiNWT+6vLLn1daEhHPZM33AfQs/Pwxhr88qPFfIvlB9Kag1snzyY5fmepcyNYX5lypK1
	R4m5/EiGpmZ5Ns8D1lHb6qth1fDUaPk0YEGugvXPDR1YfDEdye+gYw8V2W/wli3EF53LTe3AKFp
	nngAFcuy5qbyGxzBtZxpyv+sSo5+G8ku48sf6DdByn5SVey+Ga0sw3Duj19HK93PiY3wRQOnUMM
	HTwfBr/IjGBGXsG4tpmbQoJ6jQ+PljETVkx0iwNq96lJ1kTRkLh1n6DB3E2jlcA=
X-Google-Smtp-Source: AGHT+IHbOY388ZmdWR7rHmoL/oJ6pGDlUDUjpam1RRzlDYT8ShKi0Qn4oZw9X5+02UC859r3BHlW4g==
X-Received: by 2002:ac8:7fc4:0:b0:46d:faa2:b6e0 with SMTP id d75a77b69052e-47028168976mr62005331cf.18.1738792582288;
        Wed, 05 Feb 2025 13:56:22 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf189497sm74858601cf.73.2025.02.05.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:56:21 -0800 (PST)
Date: Wed, 05 Feb 2025 16:56:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf@fomichev.me, 
 asml.silence@gmail.com, 
 dw@davidwei.uk, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Victor Nogueira <victor@mojatatu.com>, 
 Pedro Tammela <pctammela@mojatatu.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>
Message-ID: <67a3de8559316_17745c29479@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250203223916.1064540-6-almasrymina@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com>
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally pipe the binding down to the new
> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> 
> ---
> 
> v3:
> - Use kvmalloc_array instead of kcalloc (Stan).
> - Fix unreachable code warning (Simon).
> 
> v2:
> - Remove dmabuf_offset from the dmabuf cmsg.
> - Update zerocopy_fill_skb_from_devmem to interpret the
>   iov_base/iter_iov_addr as the offset into the dmabuf to send from
>   (Stan).
> - Remove the confusing binding->tx_iter which is not needed if we
>   interpret the iov_base/iter_iov_addr as offset into the dmabuf (Stan).
> - Remove check for binding->sgt and binding->sgt->nents in dmabuf
>   binding.
> - Simplify the calculation of binding->tx_vec.
> - Check in net_devmem_get_binding that the binding we're returning
>   has ifindex matching the sending socket (Willem).
> ---
>  include/linux/skbuff.h                  | 15 +++-
>  include/net/sock.h                      |  1 +
>  include/uapi/linux/uio.h                |  6 +-
>  net/core/datagram.c                     | 41 ++++++++++-
>  net/core/devmem.c                       | 97 +++++++++++++++++++++++--
>  net/core/devmem.h                       | 42 ++++++++++-
>  net/core/netdev-genl.c                  | 64 +++++++++++++++-
>  net/core/skbuff.c                       |  6 +-
>  net/core/sock.c                         |  8 ++
>  net/ipv4/tcp.c                          | 36 ++++++---
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  11 files changed, 285 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..3ff8f568c382 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>  
>  void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
>  
> +struct net_devmem_dmabuf_binding;
> +
>  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  			    struct sk_buff *skb, struct iov_iter *from,
> -			    size_t length);
> +			    size_t length,
> +			    struct net_devmem_dmabuf_binding *binding);
>  
>  int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  				struct iov_iter *from, size_t length);
> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>  					  struct msghdr *msg, int len)
>  {
> -	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
> +	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
> +				       NULL);
>  }
>  
>  int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
>  			     struct msghdr *msg, int len,
> -			     struct ubuf_info *uarg);
> +			     struct ubuf_info *uarg,
> +			     struct net_devmem_dmabuf_binding *binding);
>  
>  /* Internal */
>  #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))
> @@ -3697,6 +3702,10 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
>  					    size_t offset, size_t size,
>  					    enum dma_data_direction dir)
>  {
> +	if (skb_frag_is_net_iov(frag)) {
> +		return netmem_to_net_iov(frag->netmem)->dma_addr + offset +
> +		       frag->offset;
> +	}
>  	return dma_map_page(dev, skb_frag_page(frag),
>  			    skb_frag_off(frag) + offset, size, dir);
>  }
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8036b3b79cd8..09eb918525b6 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1822,6 +1822,7 @@ struct sockcm_cookie {
>  	u32 tsflags;
>  	u32 ts_opt_id;
>  	u32 priority;
> +	u32 dmabuf_id;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 649739e0c404..866bd5dfe39f 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -38,10 +38,14 @@ struct dmabuf_token {
>  	__u32 token_count;
>  };
>  
> +struct dmabuf_tx_cmsg {
> +	__u32 dmabuf_id;
> +};
> +

Why a wrapper struct instead of just __u32?


