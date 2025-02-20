Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F222087
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085444; cv=none; b=uklRTBuq+SGd6uQVNk2ZqCh0wnuSHw1lwBa9kmYx/zcqVifjDWJaKuNBoBgZqwQVzl3fywYqT1NKfNLLHu5KixLphuIJgN49lcmN1PajS5If7Aun7fUU9mA9ho6XMjtyoY9CTmZxfkHQlIHsZHQN/A6vJSKDUUr40yeriobSgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085444; c=relaxed/simple;
	bh=KH6yptrVoHjVdEEYO4fzP+SSTQw2pLGG01gPyKQOk7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/WyXQvuRrxTSLFa+ZaZLeFZgmSfEzaIAXxZXFhtthYbtuyFCE3wDFvXUnCLtlbnlqXOTlh5on7rV3a5vdIKXC5BMnGEhhNjmYJvlGzA27bkRuFUQCw7cgs47CZE14tV/abF9TB2YWqHok0w+6uGhj7XwPHjJIVBx1xU7OHAtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0HsjrTl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0HsjrTl"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220ca204d04so20943925ad.0
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085442; x=1740690242; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=keV+C7HuG/BR9Xl+0GCyBf7ymrkmWeF1SazpD4+k360=;
        b=K0HsjrTltbvbYLH/Jll22KL2RQO+bRErPh0Os1CvoCSbAjZ1MykGNNNkj8zCkaRlTl
         wtXEHZmjSTJ+hj10StJF3bfsb/kHvXczAq47GUqRf7i46bZqBc94Ntn6Jvj3qNF52mb6
         CEosCeRu6RTqSJPmLwDo4Tuqoc1OtfrAejFKpLtbe8dO/vaN7hyVnQbsm31wLioAI4wY
         AqTBcw6gJj/PfZryhvWeTn3lZab1arzNd+7fVftQn4IweyMQ8gbyg0Wg5UYBy9QiLYoT
         3BzjZNWMAbKvTXYuu+0EBLQEYNyX+tJVOgnCRjFMOm0jGZ+VmrTtatGrxCgGSvGW5nmT
         /BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085442; x=1740690242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keV+C7HuG/BR9Xl+0GCyBf7ymrkmWeF1SazpD4+k360=;
        b=TmKEd4iaUVWQTun/C2ltm870rq3zklmLpmig4Co+D6wTepwmiUd70pxAZga1s0q7XB
         KxuItaElNX9MTwG2sSBSYTj2poD3JzoEvM/4aQey4QBkmSWkA50l3yE893ttjQPkZU7d
         E10B1ODATkJ+i5Qmf7wrigQp232AQB+PHpo2WaFqtcoTYOuQTWRtQAWhZk6DXDwwW/zg
         eOD19VsWg2UHi2upqLUCd7uX8WVprHrHQi7yrUyElXEFWoNO1lptrZihonWpJzxD7BRE
         Qhszrid24JadA7uSADG2RN2BOBZkCsDOofPLQI9ZVRBfJELlKG1vG0fxs/vgr+UWv2WT
         DtPw==
X-Forwarded-Encrypted: i=1; AJvYcCX42gUqMajKeqMIorzxzpmg+nFuUr0K5h4HdOkoHOFkj9Cy8yT/q9jOw/Im0LaEwQiSiIYMeSppB+ta54AWoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzhm1ZLW4GS75538WUYUkKWd2ixm0QAwVjsp9CJ5m/tHaOSl7I
	Ci57P/pd1u7D8+q07PbZp21v8WUZsO1fi7bwVZpCK2e/NhqV2/A=
X-Gm-Gg: ASbGncsdGSuTkGsDTOZXmYtRFgv/h2CymPsFmG8QrgwIjP5oBl+d0hCP2NPyZ/6iN6r
	2KJGNkhq0NCHjx+vk/4exw2qWfgqWNW8LqmVJByyotN0tiHTcU9TW7ADcGUz/jxyGRiIA6b13h0
	RTTwPpxpFx4CIZ0rA52DOi2DSLc5xPbI3O1UqZ8P33tGYd4svHnOYfDcEq6j/3vo0k3aEborBCa
	3f8FQNm9+US/+6wwlWIGg6wreSgQTwe6jwUZPSBkPzsP9xyaA6LxwOELOpYeuBrBFowvOXurN5U
	kR32qUsRFVzq91o=
X-Google-Smtp-Source: AGHT+IFWQl3OYv6bwFItuWow2gk/r95ziBtMPww6Leolb64qsq+wq8UcmTTlx891rb3hnwG5aPaoFg==
X-Received: by 2002:a17:902:ea06:b0:215:acb3:3786 with SMTP id d9443c01a7336-2219ff4eccbmr9785315ad.19.1740085442409;
        Thu, 20 Feb 2025 13:04:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d536439bsm125465845ad.81.2025.02.20.13.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:04:01 -0800 (PST)
Date: Thu, 20 Feb 2025 13:04:01 -0800
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
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 5/9] net: add devmem TCP TX documentation
Message-ID: <Z7eYwVrnTjgFV3XF@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-6-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> Add documentation outlining the usage and details of the devmem TCP TX
> API.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

With a few nits below:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

> 
> ---
> 
> v4:
> - Mention SO_BINDTODEVICE is recommended (me/Pavel).
> 
> v2:
> - Update documentation for iov_base is the dmabuf offset (Stan)
> 
> ---
>  Documentation/networking/devmem.rst | 150 +++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> index d95363645331..10928a5f912f 100644
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
> @@ -235,6 +235,148 @@ can be less than the tokens provided by the user in case of:
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
> +	setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> +
> +It is also recommended that the user binds the TX socket to the same interface
> +the dma-buf has been bound to via SO_BINDTODEVICE.
> +
> +	setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, strlen(ifname) + 1);
> +
> +
> +Sending data
> +--------------

               ^^ extra junk

> +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> +
> +The user should create a msghdr where,
> +
> +iov_base is set to the offset into the dmabuf to start sending from.
> +iov_len is set to the number of bytes to be sent from the dmabuf.

nit: maybe bullet point the above?

The user should create a msghdr with the following set of msg_iov:

* iov_base is set to the offset into the dmabuf to start sending from
* iov_len is set to the number of bytes to be sent from the dmabuf
