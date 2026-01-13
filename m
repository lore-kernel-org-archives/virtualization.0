Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF322B8BD
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265557; cv=none; b=kjI6NyNaCOYrBQj9kIFOsmxvwVBskbzOpDyhA9jJCtQbdkVkf9SWQ6BNQIRq3fzUEs3QFgBjZ00abDDauMVE4jU7dFVy+YqgWeYsFt85LNPRvLupCrj77HuMlysKRnwdM6B5X/+8u11awSbXKY0I9gi2LrYkZyZ50SDJJvodHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265557; c=relaxed/simple;
	bh=8Vraf+SBhLrmdt2HV0wDbrQyiKEkmpXLCy5Y9glMNTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcLPJpkyezzfsvHr+CIDIO/mZ0R6/xo71pDi9T7jDY8BFpuq2VhMSD0XEaI0T8XP9SYXUXpn/ZujV+20f+FgGl+l2zm+aOpyQn0eFnp1FtnYlOVbJzSVE+He7hklNMogXxcH+F+MqXMk8mb/AW9R3s0TwQ4kKn52FhJc2A6HPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTwk6Iuh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTwk6Iuh"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79018a412edso72047737b3.0
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 16:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768265554; x=1768870354; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NF4AyKrauIjTRva3WFey87OryHOgZb6vovp7zFMW8c=;
        b=PTwk6IuhYYs0Mn9zRNMQO5j2RjsanAjLZQJMkIYLDF5GlKaHtVQerYxMnWRY11qAGc
         +Cyjr6RUk+tkhQZnH0EiKRn5hpCyzNJdflAQ3eSkc9li17R7mF7/pweq5IUT7803Rlg+
         Mn7wl+Gv6p8eWBAfgI0x+LOMli0azJMkdFhdKLTyt/3U1ndWBi7AIJkyURJ4NT3t9GnE
         xOzRHzmtx5TdPKfy0NENsAHlwCKZryBb7CdP05vCDbQNd2/QsLCw5q8XrVBS0JK/ngEO
         r6JCClbxvFdd499tt/kNOmRlwccgZpS/Hp/PV/BrxkAtkLef9jeBjk6UkacC6p5HNRjy
         j7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768265554; x=1768870354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NF4AyKrauIjTRva3WFey87OryHOgZb6vovp7zFMW8c=;
        b=I2YyYFQ/XhmlaZXwtPzHutdEKMeIISGcPFg60qpFtw2ahIvru5D3mClvyoK4xveJZa
         MVEAeGC5x2dCCHSqKyTyEeCwp5+D8uz/5fyQWrADrWkKKECUa4KqRB7q0txrgu1PlHBW
         lkwP+nlez8HSV76soOSnZUooQoKuBUnpOD0sBf0oMwndbqr6LDYZT3u0cmRE/F4OEBmY
         W6Rv1LYuEjLR2GhzhQw14zUh9ZXRRexQ9SFCNATU7VnxM5MfTHg4qXOYQU7JdsAbihxm
         JyYLuaiUcjjGSc5sDTUoYNZITFHLHM6PqofXqebLiDxf4GxSiK/ZqlHBtIV7G7uSop9H
         xfSg==
X-Forwarded-Encrypted: i=1; AJvYcCUYh6j2ScQegPYcHZ7HAbWAqmLG2UKCYN+DN8BjzKcmt95bOirDwA3cWJgzoqG1SiHNF/NGoKeF0VXypDrZYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNnvdJy4Lm4dhl9WvB1gat5MmHqkz0cbYY5ZfUQzbHJDdF6BYb
	/AxGWmQGUP2oNeWeBq0VKnwQXOdUML/zb+SOhS0LLqbiJCUzhRpdmE11
X-Gm-Gg: AY/fxX7pKTX76rFsxeu25d07ZiiZI6Lq5/nOg9Qsh+q5IWBC+D3HIS0SKtqxo5/VlWd
	jQLidbalg8ODoh/yj3cJbMFPaiBKDz+lxnxMyDAzEEWvVVh2g9Zz5d/Vpmz9B0YGmHSkb81dgPV
	ZijX8baLym5jkyQrHeTs+q4foyRowlmo5HYQr0WPjymufOL+bMcDouW38IM5BNOaJiuaszN8B25
	kU55yyugK4JzPp8iA42bB1DhltxXDK+96OJeqn4y2Kn9M8I17jvlVEymrBLpxEuDEMpQoh7YLKu
	o/maXCRP7zEYo+o9KxU5g5P09JI5b2k4bYKzApVlfExEbfRRtc3LmLR5NQ+KHFwNXI5Hr5jBVfV
	mDgXg2X5S5I3YyiCcL0EJx15VmZ2VGtyvMj6ZU7g/9rxvWEkadALfiuDWoNDlC2sixak1Jj2Duy
	o9BEngbaiMLdzxAryTGqPgC6zg0gNRgPSk/8w=
X-Google-Smtp-Source: AGHT+IEEozBmQjMmBVEF6xh5ga3T6IlFOqAC0ZcZVHFGL77MYegZXmo8YOv/wpih8sNdKD89yTfvfQ==
X-Received: by 2002:a05:690e:1449:b0:646:6f6f:65e with SMTP id 956f58d0204a3-64716b0011cmr15860280d50.24.1768265553980;
        Mon, 12 Jan 2026 16:52:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2623sm8674363d50.20.2026.01.12.16.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 16:52:33 -0800 (PST)
Date: Mon, 12 Jan 2026 16:52:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 02/13] vsock: add netns to vsock core
Message-ID: <aWWXTx6SSNiV3a+v@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
 <20260111013536-mutt-send-email-mst@kernel.org>
 <aWWFB2K5H5OXGWP8@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWWFB2K5H5OXGWP8@devvm11784.nha0.facebook.com>

On Mon, Jan 12, 2026 at 03:34:31PM -0800, Bobby Eshleman wrote:
> On Sun, Jan 11, 2026 at 01:43:37AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > Add netns logic to vsock core. Additionally, modify transport hook
> > > prototypes to be used by later transport-specific patches (e.g.,
> > > *_seqpacket_allow()).
> > > 
> > > Namespaces are supported primarily by changing socket lookup functions
> > > (e.g., vsock_find_connected_socket()) to take into account the socket
> > > namespace and the namespace mode before considering a candidate socket a
> > > "match".
> > > 
> > > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> > > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> > > for new namespaces.
> > > 
> > > Add netns functionality (initialization, passing to transports, procfs,
> > > etc...) to the af_vsock socket layer. Later patches that add netns
> > > support to transports depend on this patch.
> > > 
> > > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > > modified to take a vsk in order to perform logic on namespace modes. In
> > > future patches, the net will also be used for socket
> > > lookups in these functions.
> > > 
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > ...
> > 
> > 
> > >  static int __vsock_bind_connectible(struct vsock_sock *vsk,
> > >  				    struct sockaddr_vm *addr)
> > >  {
> > > +	struct net *net = sock_net(sk_vsock(vsk));
> > >  	static u32 port;
> > >  	struct sockaddr_vm new_addr;
> > >
> > 
> > 
> > Hmm this static port gives me pause. So some port number info leaks
> > between namespaces. I am not saying it's a big security issue
> > and yet ... people expect isolation.
> 
> Probably the easiest solution is making it per-ns, my quick rough draft
> looks like this:
> 
> diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
> index e2325e2d6ec5..b34d69a22fa8 100644
> --- a/include/net/netns/vsock.h
> +++ b/include/net/netns/vsock.h
> @@ -11,6 +11,10 @@ enum vsock_net_mode {
>  
>  struct netns_vsock {
>  	struct ctl_table_header *sysctl_hdr;
> +
> +	/* protected by the vsock_table_lock in af_vsock.c */
> +	u32 port;
> +
>  	enum vsock_net_mode mode;
>  	enum vsock_net_mode child_ns_mode;
>  };
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9d614e4a4fa5..cd2a47140134 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -748,11 +748,10 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>  				    struct sockaddr_vm *addr)
>  {
>  	struct net *net = sock_net(sk_vsock(vsk));
> -	static u32 port;
>  	struct sockaddr_vm new_addr;
>  
> -	if (!port)
> -		port = get_random_u32_above(LAST_RESERVED_PORT);
> +	if (!net->vsock.port)
> +		net->vsock.port = get_random_u32_above(LAST_RESERVED_PORT);
>  
>  	vsock_addr_init(&new_addr, addr->svm_cid, addr->svm_port);
>  
> @@ -761,11 +760,11 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>  		unsigned int i;
>  
>  		for (i = 0; i < MAX_PORT_RETRIES; i++) {
> -			if (port == VMADDR_PORT_ANY ||
> -			    port <= LAST_RESERVED_PORT)
> -				port = LAST_RESERVED_PORT + 1;
> +			if (net->vsock.port == VMADDR_PORT_ANY ||
> +			    net->vsock.port <= LAST_RESERVED_PORT)
> +				net->vsock.port = LAST_RESERVED_PORT + 1;
>  
> -			new_addr.svm_port = port++;
> +			new_addr.svm_port = net->vsock.port++;
>  
>  			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
>  				found = true;
> 
> 
> 

Another option being to follow inet's path and use
siphash_4u32() the way that secure_ipv4_port_ephemeral() does...
