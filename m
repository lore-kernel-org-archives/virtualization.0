Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DE2905
	for <virtualization@lists.linux.dev>; Sat, 21 Dec 2024 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734757018; cv=none; b=ne0QbYSR+pThoe1JRmvZNuiGer7/mTzTnH8XKudh1tVk58ioosWAWpuXu2nwkwP4WW5SGj3lcvckoL0yLVsSAv2/UsOdQgrx+iKfE0SirK40CpDKrNogEvMABMQoFMg/gdoPiaV6PDv0UuqhNg983fUbFw2B/Z6HH/E286ia5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734757018; c=relaxed/simple;
	bh=7FOuw4VW1dXOygL6l/VKO0gU+qDMoRnFHtkKs7ZTQ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGrhGCyu50GDz3qo2fvmhS/UWpjotp5Fj9tgXbhbvi6Jrb7VfpgYV1nhT+nPSNxEaC4CUaDDszTWStE7DLhTonEvFBp0Fh+FC4lKhCVtn+caUAC/IpOsc45Z/WJGYo+3BKRNem9b0r2u9+e7gibJDGO+V6xZKdq0mPCGtNFzwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbUt616R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbUt616R"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725f4025e25so2181602b3a.1
        for <virtualization@lists.linux.dev>; Fri, 20 Dec 2024 20:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734757016; x=1735361816; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Js+ugt0MaMMBMpUMnM+FoX1wTi5eOGT/5uX13Q4DL5U=;
        b=GbUt616RCDnq04eJyFqY0heQyDdgtRE3psDBuhfxqGtUn4Kn9fUTZKapZum1rlZZ1r
         Y/6TZTWuarL7Dy69XMM0JKGgsmfSlTA1tY8dC470tTsZkop/8QxZKvuDvSMmU+U2XEcU
         C8shgQKN0wRkmiNtTsLs6Al+WAmxdVpvY4b3srNg8d2ZC8z7fF7o1dEXEpMklcFo1un9
         WFMSWH9V5nSTZuFR/V9eJXmTCMZAoN3zKw8ifOi8spN1AcjtZSCuOgm0HNP8YLHg3qDx
         fArhDvZQFzv2Ij7LZXcvpfRF4vBttEA5H4jQ4M+m5lSB/dIpZThqDrwAPMcpmjJ10L0k
         B2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734757016; x=1735361816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js+ugt0MaMMBMpUMnM+FoX1wTi5eOGT/5uX13Q4DL5U=;
        b=ZKfvSeC0ggOKWAbiz+I4UxMZOATqG9BV9e5DVufGpDOy7eGddq3QdE8Qgwh9DLzFnq
         YMQifOqTn0NqxrQkuNAkHNrleAQV1fjVzTZnl5wkm2sl+X9GE//wGhibYJRh2qYUtkgw
         xvu7H06rCetZqXBHBJ5ACA5c7VEn78IziDJT2IGfYEFQr9gyI91T1IP7bxZMv+aDjIPT
         DFZPH7R67D6tYHnLq9lRlM4VHJkgIBBbOpIb+7X4VVO9/ibUKg4Sgr7bfQLIS40qCNDN
         rEi0ODeJb15Q2WYiBqdQNw0D1iBG0FUF0onswu3z+5K5ZvKQCqDCp7OAN3Ltj251yeve
         jScA==
X-Forwarded-Encrypted: i=1; AJvYcCUkFy7HHVWTWfnLwsPwypbJXvWUGb/kZtZFTkawZu2UfrlWruanhtFG0n86Hg0bmPrzxxFpNekNs9hdgt1PMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxW+Rnmc0+xBAjhbSL0n/x1U+S3gt1OBDVN0M8kotJ/L2VOulQ+
	wiH6onYEVJn2Pcho+IOYL4LRjKH4bXgOfGJXhOUv3aAWKtZH80E=
X-Gm-Gg: ASbGncvv5+WpxxOaq4wCiy2Z+3U3nQ6l+6pWrpU03o/wsRZgrcIib3HqPCPU5ijHZSk
	HRTCJk50Ykc5TlB19hihCALjTAnScak9GokFUtg1nOni4ea1LlnsjV+Q9aFYII8FzVzelIK8Qph
	R2SiSFoFReBwXEkWoS8yM/5SBySMYTkzvWvVmD8rq8NrnIaRwMsg98QBmAGeAHNkgbHP7T5rsGw
	v3ec+uAF80WlstwBnrRK3hRVpfv/ZKt9KdSF+mB5Ny3+r1j0omp1M3h
X-Google-Smtp-Source: AGHT+IGDzYnWBVN+HX6JFj/d4xjvTo76tHC5MRGFofOtmFjioyS7aCaKvbwNNSAd1pzgo/vnymqfvg==
X-Received: by 2002:a05:6a00:21c2:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-72abdeaae11mr7942842b3a.16.1734757016524;
        Fri, 20 Dec 2024 20:56:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd610sm3944287b3a.136.2024.12.20.20.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 20:56:56 -0800 (PST)
Date: Fri, 20 Dec 2024 20:56:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 1/5] net: add devmem TCP TX documentation
Message-ID: <Z2ZKl_t5e6rutAZ1@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-2-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
> Add documentation outlining the usage and details of the devmem TCP TX
> API.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  Documentation/networking/devmem.rst | 140 +++++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> index d95363645331..9be01cd96ee2 100644
> --- a/Documentation/networking/devmem.rst
> +++ b/Documentation/networking/devmem.rst
> @@ -62,15 +62,15 @@ More Info
>      https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
>  
>  
> -Interface
> -=========
> +RX Interface
> +============
>  
>  
>  Example
>  -------
>  
> -tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
> -the RX path of this API.
> +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an example of
> +setting up the RX path of this API.
>  
>  
>  NIC Setup
> @@ -235,6 +235,138 @@ can be less than the tokens provided by the user in case of:
>  (a) an internal kernel leak bug.
>  (b) the user passed more than 1024 frags.
>  
> +TX Interface
> +============
> +
> +
> +Example
> +-------
> +
> +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an example of
> +setting up the TX path of this API.
> +
> +
> +NIC Setup
> +---------
> +
> +The user must bind a TX dmabuf to a given NIC using the netlink API::
> +
> +        struct netdev_bind_tx_req *req = NULL;
> +        struct netdev_bind_tx_rsp *rsp = NULL;
> +        struct ynl_error yerr;
> +
> +        *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +
> +        req = netdev_bind_tx_req_alloc();
> +        netdev_bind_tx_req_set_ifindex(req, ifindex);
> +        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> +
> +        rsp = netdev_bind_tx(*ys, req);
> +
> +        tx_dmabuf_id = rsp->id;
> +
> +
> +The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
> +that has been bound.
> +
> +The user can unbind the dmabuf from the netdevice by closing the netlink socket
> +that established the binding. We do this so that the binding is automatically
> +unbound even if the userspace process crashes.
> +
> +Note that any reasonably well-behaved dmabuf from any exporter should work with
> +devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
> +this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
> +
> +Socket Setup
> +------------
> +
> +The user application must use MSG_ZEROCOPY flag when sending devmem TCP. Devmem
> +cannot be copied by the kernel, so the semantics of the devmem TX are similar
> +to the semantics of MSG_ZEROCOPY.
> +
> +	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +
> +Sending data
> +--------------
> +
> +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> +

[...]

> +The user should create a msghdr with iov_base set to NULL and iov_len set to the
> +number of bytes to be sent from the dmabuf.

Should we verify that iov_base is NULL in the kernel?

But also, alternatively, why not go with iov_base == offset? This way we
can support several offsets in a single message, just like regular
sendmsg with host memory. Any reason to not do that?

> +The user passes the dma-buf id via the dmabuf_tx_cmsg.dmabuf_id, and passes the
> +offset into the dmabuf from where to start sending using the
> +dmabuf_tx_cmsg.dmabuf_offset field::
> +

[...]

> +        char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> +        struct dmabuf_tx_cmsg ddmabuf;
> +        struct msghdr msg = {};
> +        struct cmsghdr *cmsg;
> +        uint64_t off = 100;
> +        struct iovec iov;
> +
> +	iov.iov_base = NULL;
> +	iov.iov_len = line_size;

nit: indent seems to be different (tabs vs spaces)
