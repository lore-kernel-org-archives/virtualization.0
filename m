Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306F251781
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121060; cv=none; b=W1TvD1opL6Xyy8TwlwzKvwG2D7j2kH7o3Hm6ufcaCTdvy2E25gvneFbfmCklxiPBSKdA2qCIfQfO9AAESaNE1ZlxKxKrVFNdDOsNvTB67H4uRrEJW7LgQxoPsVsoZZRTq1a8JHTCVovNVZom86f5Bbpcj+Rb6AsX0CHKTM+t7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121060; c=relaxed/simple;
	bh=7y6Ozzze4KwoBgjyzA+U/rpI+/mDiB9TlO4Of3/kd6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV9MuGz0W6wHtR9VyAzVMdY6GtYNoJkqznRFmBJDDdSsfw7TUIYq34sXaZxUyvYl4ccz0ac2jG7t/BNUECVfwsYBw+wzWBk6752Fq9Furvp9GFbMgs6WvD7JXLwOgIQ9AE72Y5D7H7MGe5H69i79aM1TP3OaFXm53ZpqRU0Urfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgtsn+EA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgtsn+EA"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2237a32c03aso275ad.1
        for <virtualization@lists.linux.dev>; Tue, 04 Mar 2025 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741121056; x=1741725856; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6GyiO/b+/JHP4j/mZ3p/+VCJ12NtmyK1qhKdqkLMCk=;
        b=cgtsn+EAVBwljfP9K0SCG81a2WminrI1zHv88FupcvJrA5JHlYR5y4cgjMhB1CTuvc
         FvxsfgEA1U9QUKB+jklGhhRLb/l3DHa7IaLHLCKP+2ypUAduEAmXdLpeAS5TWk4AQxqM
         RKemzwPkJYfmbx+1Mmkk9ZmT6yTjRxs9331IBul9T6e28lvrNLvhdeKoEGJWgFdqoUSY
         k2p2gjs2mpV0QqJVgoAsVLu6UQevlJYVHjcdqjBRQSGJKRXmCAGceVqtldTzvqNA+VpL
         ygWggw7I/usmPIiOCgHx8DfzLuF9yxOINqSIi22tnLunmDnagHxqf2xvmPU6Qjuhrv0Q
         bAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121056; x=1741725856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6GyiO/b+/JHP4j/mZ3p/+VCJ12NtmyK1qhKdqkLMCk=;
        b=Q3euA+7sqzXvdzt/UKw4gZuNzNQnH8IVUGQbO4mU47vYSS5FaT+Mm9GJuFPW7w1fSP
         UMmZRQWwaLxbmSpfpdv2MXjei38keU2GMRHWjVjQLZEx7Lsa9dwPJLJihDdbzb2p4zU4
         PQaQYT1Lfu7ZbLF3HhVmonLV5CM5pW3NNsFmWpCvS3PnGRw1RqVPvkSs7sdBiyHb70J1
         d7iSfscrAKaMzRkzls0qhNOgL/R1BZm6ZewjGOp19PvNMylwEAljaT6cT3MRPGJ8hol2
         BemM83yrfCLGWv58DRpi/h0n1rz/mv9ZHGjuDiRxvgxoMVxM4y2m1s3EtVYaPBBnvVd/
         OCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUshLZyaHS0faG3FvJr5625ylYUuhziPo8KlJAtAcTszfKJBC85OPnbBoHFDaPwfwUs+YV70Ot6zpQgoSC3Ng==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdloDLUmFMOUrxlh3y/Qq2ok5txdIw/LHXT4J6PGMjQQQ3l0Mi
	y31pTWjvOJ5vrc6O7mdiRarM37EKE5wVsZltA7uHULwtQckk6QHuX+ZvV1j9Gg==
X-Gm-Gg: ASbGncsXIHO9+L8sv3BXNYDlBFRuz/dNN95QrVO4ZTjWJ9B4o8IoODv2dvGhBYTqgFh
	zOA1eba0Mx/kI8fIoiLcsPhk4xGgPIIAW7xq0bTRVeHmi7baquLT5zyjQHyiyYsx96WXPepnh90
	xbGJSAJ87kj5KThUT+a0JZ59IoaR+mHUiyDsH8cVKhCdeJKegARpOsodou+dyw1LTh9t9qFrrO8
	1M4oW090EcEl5hl4Ve6QtH+oLhqrSOe7IR6qrrOpJEM0Lyj2rCTumNFk4AZf7VAMbgjFjHoFJzL
	uje35W66gv4lQbEgg7WjePU1t2TLFzItOSxSZzjwwGPnlKZMBcF9Q8Y8FBkzLL0gf5h0o8gIVqf
	lSIJUeQ==
X-Google-Smtp-Source: AGHT+IF9jAAYtjI1xJD9q8aFzdqcCf3EBmPfCXO9SbqGxq/rnItvqWNyYmnWqD98oJASF+nZMTNy6g==
X-Received: by 2002:a17:902:f681:b0:21f:56e5:daee with SMTP id d9443c01a7336-223f268a154mr502695ad.6.1741121056131;
        Tue, 04 Mar 2025 12:44:16 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c5csm100141995ad.113.2025.03.04.12.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:44:15 -0800 (PST)
Date: Tue, 4 Mar 2025 20:44:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v6 3/8] net: devmem: Implement TX path
Message-ID: <Z8dmEu_p68X7tfq7@google.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227041209.2031104-4-almasrymina@google.com>

On Thu, Feb 27, 2025 at 04:12:04AM +0000, Mina Almasry wrote:
>  int mp_dmabuf_devmem_init(struct page_pool *pool)
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 946f2e015746..67168aae5e5b 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -23,8 +23,9 @@ struct net_devmem_dmabuf_binding {
>  
>  	/* The user holds a ref (via the netlink API) for as long as they want
>  	 * the binding to remain alive. Each page pool using this binding holds
> -	 * a ref to keep the binding alive. Each allocated net_iov holds a
> -	 * ref.
> +	 * a ref to keep the binding alive. The page_pool does not release the
> +	 * ref until all the net_iovs allocated from this binding are released
> +	 * back to the page_pool.
>  	 *
>  	 * The binding undos itself and unmaps the underlying dmabuf once all
>  	 * those refs are dropped and the binding is no longer desired or in
> @@ -32,7 +33,10 @@ struct net_devmem_dmabuf_binding {
>  	 *
>  	 * net_devmem_get_net_iov() on dmabuf net_iovs will increment this
>  	 * reference, making sure that the binding remains alive until all the
> -	 * net_iovs are no longer used.
> +	 * net_iovs are no longer used. net_iovs allocated from this binding
> +	 * that are stuck in the TX path for any reason (such as awaiting
> +	 * retransmits) hold a reference to the binding until the skb holding
> +	 * them is freed.
>  	 */
>  	refcount_t ref;
>  
> @@ -48,6 +52,14 @@ struct net_devmem_dmabuf_binding {
>  	 * active.
>  	 */
>  	u32 id;
> +
> +	/* Array of net_iov pointers for this binding, sorted by virtual
> +	 * address. This array is convenient to map the virtual addresses to
> +	 * net_iovs in the TX path.
> +	 */
> +	struct net_iov **tx_vec;
> +
> +	struct work_struct unbind_w;
>  };
>  
>  #if defined(CONFIG_NET_DEVMEM)
> @@ -64,14 +76,17 @@ struct dmabuf_genpool_chunk_owner {
>  	dma_addr_t base_dma_addr;
>  };
>  
> -void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
> +void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
>  struct net_devmem_dmabuf_binding *
> -net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> -		       struct netlink_ext_ack *extack);
> +net_devmem_bind_dmabuf(struct net_device *dev,
> +		       enum dma_data_direction direction,
> +		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack);
> +struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>  				    struct net_devmem_dmabuf_binding *binding,
>  				    struct netlink_ext_ack *extack);
> +void net_devmem_bind_tx_release(struct sock *sk);
>  
>  static inline struct dmabuf_genpool_chunk_owner *
>  net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
> @@ -100,10 +115,10 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
>  	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
>  }
>  
> -static inline void
> +static inline bool
>  net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
>  {
> -	refcount_inc(&binding->ref);
> +	return refcount_inc_not_zero(&binding->ref);
>  }
>  
>  static inline void
> @@ -112,7 +127,8 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
>  	if (!refcount_dec_and_test(&binding->ref))
>  		return;
>  
> -	__net_devmem_dmabuf_binding_free(binding);
> +	INIT_WORK(&binding->unbind_w, __net_devmem_dmabuf_binding_free);
> +	schedule_work(&binding->unbind_w);
>  }
>  
>  void net_devmem_get_net_iov(struct net_iov *niov);
> @@ -123,6 +139,11 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
>  void net_devmem_free_dmabuf(struct net_iov *ppiov);
>  
>  bool net_is_devmem_iov(struct net_iov *niov);
> +struct net_devmem_dmabuf_binding *
> +net_devmem_get_binding(struct sock *sk, unsigned int dmabuf_id);
> +struct net_iov *
> +net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
> +		       size_t *off, size_t *size);
>  
>  #else
>  struct net_devmem_dmabuf_binding;
> @@ -140,18 +161,23 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
>  {
>  }
>  
> -static inline void
> -__net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
> +static inline void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  {
>  }
>  
>  static inline struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       enum dma_data_direction direction,
>  		       struct netlink_ext_ack *extack)

The order of arguments differs from the above definition (and also with
the one in the net/core/devmem.c file) which could cause a failure in
case CONFIG_NET_DEVMEM=n. I think it should instead be:

 static inline struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, 
+		       enum dma_data_direction direction,
+		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack)

>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  

Thanks,
Praan
