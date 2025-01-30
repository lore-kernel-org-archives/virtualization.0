Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA61F12F5
	for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738277953; cv=none; b=bBL/BU7nmYbgezFgv9CFzFeMrBG2AmBLcnRLLJ6wP7gEyCP/NdDuAxJdAUSqmWcJlhqHbraJEscl34KSVyBT/CLK/BkmcPB672zLJxj4AXz7KHxNPXIyEw4ZJ/zDeUE/28ZgtulLabnEArW00g/arntU2xCUzdM1oCt99JUl11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738277953; c=relaxed/simple;
	bh=jlGPx+Vuc42F4f5ClkPPNCa6niD0NXNghbQUyEZgP+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0KRJg2q4I+b82AjnJToZYsApmHJ/OsqQtSgGfIS6HpohixnRKFMuZOQxeZz7BQFL5xSQxSqSbd5TtBfPupRJ7CTbZRnnmsQ2WZ2SSc0lfyoOkiBibXhYgWKSZ3JNJDE38FyouRrUhxjGASgKLqf8ICXh24NM5kW1R/ZPl47atM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKRha7fE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKRha7fE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so1897329a91.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738277951; x=1738882751; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGwxI5UuKBfMTrMct5qfq/USLHQLhnSYLl8x3SVYSYc=;
        b=QKRha7fE7dd3EQlfiwPVzFe20S5jYp8LKG9poG9nMg+85T128ymoRS14jjFF/LaFsB
         Z4BrP584ZSi354o1T96u5vXRAWNbSHBXSf24cbRQNxQCBuXlJ3r3d4SaP5emcelOOC2W
         ZPH7Fkrrn0PM4Uvw1U5ymLlU00oN5n+KVmC2r9Jk0VCwjfF0NwW4qU5REzHt4ZMB1mID
         HSQjUYfo9aKwiW4Nf/1uXOz15AJ+zRbkscspwYoQb+r93UrWuwVI3gDx3Fz6HlpXys7d
         3mWo1ZiTQm8dmH/f+Ja547gAG3/5TJZeQFHQzSVKItVCy0D9gUhUv3HQWw0ZLYcM/kou
         m+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738277951; x=1738882751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGwxI5UuKBfMTrMct5qfq/USLHQLhnSYLl8x3SVYSYc=;
        b=Xc6codLrDCsVRmC04gm8t3LeMGNfIOt4934vwBeQ2RLHOUtwYrSwfDU4k739W1f+vE
         TSht1bu7kbLamZ5TqVRzUbO9xjaetfeoXFwL0pIu165pG41DN9qXCinh2TTdhD2HGq8t
         EGQ82UhqFT42ypcJxlTHsQskgguKWadHJiHXaURFl0z7hOFtQcN6ceeGMdKrataVFmcn
         tXSBLglLDlebwT1sG58ou/Rfyn9yU7Dr52ze6NlDgyemIFyWyQdhqozS8AkWYJrgbPJQ
         6YcLIoz9ka4kaXwMxL8vy/1pblLloQ8M0sv5+pbX6hLSK/0jz/GgE8PuDOCtlhIybEU0
         5Wmw==
X-Forwarded-Encrypted: i=1; AJvYcCXbJO2Q4z9++kx2B2BNps+Hw/bBwtBm2iQBAdWyKG9f5yCAImW2VMe7Fl4BQPtwEz52KmtsWRqRgxpvF4IYog==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNKMkgKQ1xVM/kUkG7rxNT9ca5Pl4KeoY6BU0VAQA5rDjTnEVn
	AtMPQqiIhcYffuxoPYSAVGPgJtEZ/YcD+meg3ZIwv7yRI+1ge2I=
X-Gm-Gg: ASbGnctMTWko53J8YiYR3yBrkVtmn5ZrjOvxo5T2IAn91kpRSXNY55gtQYAjjaJ8KzB
	p+kUOTmTXPR13QhFLxQULiTgdHhxaGbPa1lVz/Lko/a/m6tICaCt+PCwJ+jCNqZCTJHfwt6Q8At
	agdV7GVy9sWFI/xS5ySRdUt7efpv13ZicIEzzmevjwYqz51KgYpnjCHA6oaD+TqjBPRmNfigGRA
	uXWyv9Ki3G+iIiiQn291AD9Kn20BeeAuXgPEJEfH4Mydw4aIGqrGouDRTTyOAACfL/wVpVMWvhB
	+IxXH7TsXSV4euk=
X-Google-Smtp-Source: AGHT+IF40W/xjpetzz3O9nqgU8Q7OQmYP686oXKV+QTGph5aLVCIwEKwn9kMrNIRQxcVURPqLHdJaw==
X-Received: by 2002:a17:90b:5408:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2f83abbea88mr12329378a91.5.1738277951291;
        Thu, 30 Jan 2025 14:59:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f83bc98ae9sm4936182a91.10.2025.01.30.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 14:59:10 -0800 (PST)
Date: Thu, 30 Jan 2025 14:59:10 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next v2 1/6] net: add devmem TCP TX documentation
Message-ID: <Z5wEPlsRoU6Kx9S-@mini-arch>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130211539.428952-2-almasrymina@google.com>

On 01/30, Mina Almasry wrote:
> Add documentation outlining the usage and details of the devmem TCP TX
> API.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v2:
> - Update documentation for iov_base is the dmabuf offset (Stan)
> ---
>  Documentation/networking/devmem.rst | 144 +++++++++++++++++++++++++++-
>  1 file changed, 140 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> index d95363645331..8166fe09da13 100644
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
> @@ -235,6 +235,142 @@ can be less than the tokens provided by the user in case of:
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
> +The user should create a msghdr where,
> +
> +iov_base is set to the offset into the dmabuf to start sending from.
> +iov_len is set to the number of bytes to be sent from the dmabuf.
> +
> +The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabuf_id.
> +
> +The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
> +from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_id::
> +
> +       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> +       struct dmabuf_tx_cmsg ddmabuf;
> +       struct msghdr msg = {};
> +       struct cmsghdr *cmsg;
> +       struct iovec iov[2];
> +
> +       iov[0].iov_base = (void*)100;
> +       iov[0].iov_len = 1024;
> +       iov[1].iov_base = (void*)2000;
> +       iov[1].iov_len = 2048;
> +
> +       msg.msg_iov = iov;
> +       msg.msg_iovlen = 2;
> +
> +       msg.msg_control = ctrl_data;
> +       msg.msg_controllen = sizeof(ctrl_data);
> +
> +       cmsg = CMSG_FIRSTHDR(&msg);
> +       cmsg->cmsg_level = SOL_SOCKET;
> +       cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
> +       cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
> +
> +       ddmabuf.dmabuf_id = tx_dmabuf_id;
> +
> +       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;

[..]

> +       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);

Not super important, but any reason not to use MSG_SOCK_DEVMEM as a
flag? We already use it for recvmsg, seems logical to mirror the same
flag on the transmit side?
