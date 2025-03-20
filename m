Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443921CA12
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461092; cv=none; b=TOK3GSyiHueKSbvKliHpuQ1+koPVoTRDqGC8TweU0gi0qhWM/ctE1Ff68f1AoqpgzsHiXvpU0C1k+jI3XRCbbff97TnWrNy7lgFLILwpG7aT0yxudE69O0ifc+l8llczz3I41gUhxqSA/aZ6YANnVbbRHLBvjycFBKos9+uBxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461092; c=relaxed/simple;
	bh=DM/ccL3ibK097z90TQvPWmYrGyoMDZe8c1dLJKbrEyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lWauQJrqn7FwpVlywxJkmlECLkQ/gmEczSslXNjiyGLyH3kcog4A5afgad4frzkQY54Nj2q81XqY/xYAwInAVrQOIppZEmXkWEYQPKVHq0ow/aGmWyTBMtVwCXJasEiqX44uO/z3EpEezil6+spSiZHYjCZ1pfftfAUIKL3TKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG7LSZmd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG7LSZmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742461089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bd61lUn+sRLHMmwZN8hWDOwnbFohDDuP+YHOHn1Rqxs=;
	b=OG7LSZmdDvsct3cYFH6OhlmEQZVBgW3pM7nOlm6WMgmRfOmQ6RGeuFcWHdZM/BBC9kx4yN
	oViRupgW13xFSPOcm74a2/ymmS/Vv0GXNEgW8HYKTxQW3XHvQrXOrYU4qm8UF7nVhjv5f/
	fb3reTSXTD3y0YDGnnGHHKEh/WhrRt8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-7oPAHtFMNMCyUgoPdEVXdQ-1; Thu, 20 Mar 2025 04:58:07 -0400
X-MC-Unique: 7oPAHtFMNMCyUgoPdEVXdQ-1
X-Mimecast-MFC-AGG-ID: 7oPAHtFMNMCyUgoPdEVXdQ_1742461086
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5be5ec846so520874a12.2
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 01:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461085; x=1743065885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd61lUn+sRLHMmwZN8hWDOwnbFohDDuP+YHOHn1Rqxs=;
        b=dblQwpuajfxkDg/gzo8ieq+Ffn0tPblZRU25eAD2oW7ZbvbnhRs9RizdwJHiOQVQyP
         FWVTVptWYRLHInW4EObzt7EOPJkqo1Gij6chz0FCv1SVU+fR/OK8SpsHoHAjqfBRU0U/
         QDpTOPiounpePPDJs7RqIWpTvxaflvPCHY21X/bJ8aYfvrSfmKx51UyIP0hWNUX+BlhO
         /rIcNBcq3oZt6hY3Cyh40ZPNqtKrz1cN4o/re1XIpaJ8lhZXmmOoLrWCvGRyUPdAF8qm
         olw9bSK5faeroQaNL3tisK30YJDjHFiEy21XrhniQvJr7imbyvHvs6s8ysRljtHre6Pc
         6MTg==
X-Forwarded-Encrypted: i=1; AJvYcCWFaJaRs8vEnKUYbdGdFxJOYBP6HMYK+1dtvETNhMH5ntAxFAfw/OavfswgRynHnsSFWooLe9DTkYP0IwZNNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBGfsxTIZDlJoufXhKrhsC7ClRFwCusFYF75Ye7bG5cWgHre3r
	QmYUQMyhxobxmbAQw3FHYZThEyvcT5sBElXs9Z8YERfB2ZkF2W4WQY2G+X66uhOVjLERq6uEpzs
	g+YZcD7LrEwxaUaYtsYUTtD+imdqTflb1PG0WwcI3zCO0/Th4IOjlmrhkqp7kJyp/
X-Gm-Gg: ASbGncudG7ZsJIPWPUTiAlcm2dhAyZ9yXFTqYtdOUD/kxQqzv6KAHiK+OkByc6DAtPo
	QDLenTBMiRM5g2XA9EqWMurkNVQQtUcPIGldrkoZwoyNKvg59ZLtMPxiGA1utHqfyqC5GdiB4Dd
	WoYSPMek0IbvynuCkNe5h3kHhxFxyyCMAXkEUCWCAXeOo2J61xDggIC9gNp/uMVr4C3Yz3brRkf
	iEhW0XJE7uV/zWZnB1VjvAG2lCgMc4GVN77taN6/QbKucXdKTLxx7Ydwipzdzi1KlkMVL0ZrpfG
	7DPFojO4uAhISYp5muwdxUJzyfC/IWamEu63l42n70sZe4/FIZN7bHCIs4b63x1h
X-Received: by 2002:a17:907:d1a:b0:ac3:9587:f2a1 with SMTP id a640c23a62f3a-ac3cdfbaad6mr295753466b.20.1742461085293;
        Thu, 20 Mar 2025 01:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq0juNbqCxFJGV1XJKgWfbIVjl7qoYd4fj9juFeRDlZBNQGi5NZBdC6rDGZqTEbwHSGFJEAQ==
X-Received: by 2002:a17:907:d1a:b0:ac3:9587:f2a1 with SMTP id a640c23a62f3a-ac3cdfbaad6mr295748566b.20.1742461084564;
        Thu, 20 Mar 2025 01:58:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3daddfe94sm66361766b.73.2025.03.20.01.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:58:03 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:57:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vsock: add network namespace support
Message-ID: <sarbzv7tqaljonkuerlmirulq25ouk6mwyfbr4oaqfzfry2kcm@efbhpxgpxikk>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-1-84bffa1aa97a@gmail.com>
 <sqvqvlovlxpfo2tlkazugkocwmlhc7iay2kvq7b75bgwk7vhfw@tvgfe5fj3mw6>
 <Z9sUVs1Tq3SN83MQ@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z9sUVs1Tq3SN83MQ@devvm6277.cco0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JxvqPOb8P6mJ-cnBK4_uTc_O5_UR5ES21gciH4cJ-sA_1742461086
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 19, 2025 at 12:00:38PM -0700, Bobby Eshleman wrote:
>On Wed, Mar 19, 2025 at 02:02:32PM +0100, Stefano Garzarella wrote:
>> On Wed, Mar 12, 2025 at 01:59:35PM -0700, Bobby Eshleman wrote:
>> > From: Stefano Garzarella <sgarzare@redhat.com>
>> >
>> > This patch adds a check of the "net" assigned to a socket during
>> > the vsock_find_bound_socket() and vsock_find_connected_socket()
>> > to support network namespace, allowing to share the same address
>> > (cid, port) across different network namespaces.
>> >
>> > This patch preserves old behavior, and does not yet bring up namespace
>> > support fully.
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> I'd describe here a bit the new behaviour related to `fallback` that you
>> developed.
>>
>> Or we can split this patch in two patches, one with my changes without
>> fallback, and another with fallback as you as author.
>>
>> WDYT?
>>
>
>I like the idea of splitting it, that way any unforeseen issues in the
>new logic can be isolated to the one patch.
>
>>
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>> > ---
>> > v1 -> v2:
>> > * remove 'netns' module param
>> > * remove vsock_net_eq()
>> > * use vsock_global_net() for "global" namespace
>> > * use fallback logic in socket lookup functions, giving precedence to
>> >  non-global vsock namespaces
>> >
>> > RFC -> v1
>> > * added 'netns' module param
>> > * added 'vsock_net_eq()' to check the "net" assigned to a socket
>> >  only when 'netns' support is enabled
>> > ---
>> > include/net/af_vsock.h                  |  7 +++--
>> > net/vmw_vsock/af_vsock.c                | 55 ++++++++++++++++++++++++---------
>> > net/vmw_vsock/hyperv_transport.c        |  2 +-
>> > net/vmw_vsock/virtio_transport_common.c |  5 +--
>> > net/vmw_vsock/vmci_transport.c          |  4 +--
>> > 5 files changed, 51 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > index 9e85424c834353d016a527070dd62e15ff3bfce1..41afbc18648c953da27a93571d408de968aa7668 100644
>> > --- a/include/net/af_vsock.h
>> > +++ b/include/net/af_vsock.h
>> > @@ -213,9 +213,10 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
>> > void vsock_insert_connected(struct vsock_sock *vsk);
>> > void vsock_remove_bound(struct vsock_sock *vsk);
>> > void vsock_remove_connected(struct vsock_sock *vsk);
>> > -struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
>> > +struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net);
>> > struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>> > -					 struct sockaddr_vm *dst);
>> > +					 struct sockaddr_vm *dst,
>> > +					 struct net *net);
>> > void vsock_remove_sock(struct vsock_sock *vsk);
>> > void vsock_for_each_connected_socket(struct vsock_transport *transport,
>> > 				     void (*fn)(struct sock *sk));
>> > @@ -255,4 +256,6 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
>> > {
>> > 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
>> > }
>> > +
>> > +struct net *vsock_global_net(void);
>>
>> If it just returns null, maybe we can make it inline here.
>>
>
>Roger that.
>
>> > #endif /* __AF_VSOCK_H__ */
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index 7e3db87ae4333cf63327ec105ca99253569bb9fe..d206489bf0a81cf989387c7c8063be91a7c21a7d 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -235,37 +235,60 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
>> > 	sock_put(&vsk->sk);
>> > }
>> >
>> > -static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > +struct net *vsock_global_net(void)
>> > {
>> > +	return NULL;
>> > +}
>> > +EXPORT_SYMBOL_GPL(vsock_global_net);
>> > +
>> > +static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr,
>> > +					      struct net *net)
>> > +{
>>
>> Please add a comment here to describe what fallback is used for.
>> And I would suggest also something on top of this file to explain a bit
>> how netns are handled in AF_VSOCK.
>>
>
>sgtm!
>
>> > +	struct sock *fallback = NULL;
>> > 	struct vsock_sock *vsk;
>> >
>> > 	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>> > -		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>> > -			return sk_vsock(vsk);
>> > +		if (vsock_addr_equals_addr(addr, &vsk->local_addr)) {
>> > +			if (net_eq(net, sock_net(sk_vsock(vsk))))
>> > +				return sk_vsock(vsk);
>> >
>> > +			if (net_eq(net, vsock_global_net()))
>> > +				fallback = sk_vsock(vsk);
>> > +		}
>> > 		if (addr->svm_port == vsk->local_addr.svm_port &&
>> > 		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
>> > -		     addr->svm_cid == VMADDR_CID_ANY))
>> > -			return sk_vsock(vsk);
>> > +		     addr->svm_cid == VMADDR_CID_ANY)) {
>> > +			if (net_eq(net, sock_net(sk_vsock(vsk))))
>> > +				return sk_vsock(vsk);
>> > +
>> > +			if (net_eq(net, vsock_global_net()))
>> > +				fallback = sk_vsock(vsk);
>> > +		}
>> > 	}
>> >
>> > -	return NULL;
>> > +	return fallback;
>> > }
>> >
>> > static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>> > -						  struct sockaddr_vm *dst)
>> > +						  struct sockaddr_vm *dst,
>> > +						  struct net *net)
>> > {
>> > +	struct sock *fallback = NULL;
>> > 	struct vsock_sock *vsk;
>> >
>> > 	list_for_each_entry(vsk, vsock_connected_sockets(src, dst),
>> > 			    connected_table) {
>> > 		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
>> > 		    dst->svm_port == vsk->local_addr.svm_port) {
>> > -			return sk_vsock(vsk);
>> > +			if (net_eq(net, sock_net(sk_vsock(vsk))))
>> > +				return sk_vsock(vsk);
>> > +
>> > +			if (net_eq(net, vsock_global_net()))
>> > +				fallback = sk_vsock(vsk);
>>
>> This pattern seems to be repeated 3 times, can we make a function/macro?
>>
>
>yep, no problem!
>
>> > 		}
>> > 	}
>> >
>> > -	return NULL;
>> > +	return fallback;
>> > }
>> >
>> > static void vsock_insert_unbound(struct vsock_sock *vsk)
>> > @@ -304,12 +327,12 @@ void vsock_remove_connected(struct vsock_sock *vsk)
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_remove_connected);
>> >
>> > -struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > +struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net)
>> > {
>> > 	struct sock *sk;
>> >
>> > 	spin_lock_bh(&vsock_table_lock);
>> > -	sk = __vsock_find_bound_socket(addr);
>> > +	sk = __vsock_find_bound_socket(addr, net);
>> > 	if (sk)
>> > 		sock_hold(sk);
>> >
>> > @@ -320,12 +343,13 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
>> >
>> > struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>> > -					 struct sockaddr_vm *dst)
>> > +					 struct sockaddr_vm *dst,
>> > +					 struct net *net)
>> > {
>> > 	struct sock *sk;
>> >
>> > 	spin_lock_bh(&vsock_table_lock);
>> > -	sk = __vsock_find_connected_socket(src, dst);
>> > +	sk = __vsock_find_connected_socket(src, dst, net);
>> > 	if (sk)
>> > 		sock_hold(sk);
>> >
>> > @@ -644,6 +668,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> > {
>> > 	static u32 port;
>> > 	struct sockaddr_vm new_addr;
>> > +	struct net *net = sock_net(sk_vsock(vsk));
>> >
>> > 	if (!port)
>> > 		port = get_random_u32_above(LAST_RESERVED_PORT);
>> > @@ -660,7 +685,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> >
>> > 			new_addr.svm_port = port++;
>> >
>> > -			if (!__vsock_find_bound_socket(&new_addr)) {
>> > +			if (!__vsock_find_bound_socket(&new_addr, net)) {
>> > 				found = true;
>> > 				break;
>> > 			}
>> > @@ -677,7 +702,7 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> > 			return -EACCES;
>> > 		}
>> >
>> > -		if (__vsock_find_bound_socket(&new_addr))
>> > +		if (__vsock_find_bound_socket(&new_addr, net))
>> > 			return -EADDRINUSE;
>> > 	}
>> >
>> > diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>> > index 31342ab502b4fc35feb812d2c94e0e35ded73771..253609898d24f8a484fcfc3296011c6f501a72a8 100644
>> > --- a/net/vmw_vsock/hyperv_transport.c
>> > +++ b/net/vmw_vsock/hyperv_transport.c
>> > @@ -313,7 +313,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>> > 		return;
>> >
>> > 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
>> > -	sk = vsock_find_bound_socket(&addr);
>> > +	sk = vsock_find_bound_socket(&addr, NULL);
>> > 	if (!sk)
>> > 		return;
>> >
>> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > index 7f7de6d8809655fe522749fbbc9025df71f071bd..256d2a4fe482b3cb938a681b6924be69b2065616 100644
>> > --- a/net/vmw_vsock/virtio_transport_common.c
>> > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > @@ -1590,6 +1590,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> > 			       struct sk_buff *skb)
>> > {
>> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> > +	struct net *net = vsock_global_net();
>>
>> Why using vsock_global_net() in virtio and directly NULL in the others
>> transports?
>>
>
>This was an oversight on my part, I found an unnamed NULL harder to
>reason about, switched to the func, but forgot to switch over the other
>transports.
>
>BTW, I was unsure about just making NULL a macro (e.g.,
>VIRTIO_VSOCK_GLOBAL_NET?) instead of a function. I just used a function
>because A) I noticed in the prior rev that the default net was a
>function instead of some macro to &init_net, and B) the function seemed
>a little more flexible for future changes. What are your thoughts here?

Inline function in the header should be fine IMHO.

Thanks,
Stefano

>
>
>Thanks for the review!
>
>Best,
>Bobby
>

