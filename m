Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC02165EA
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525869; cv=none; b=ZsYPbBJUiFQ8+NGEM5+OJiKuelCxlCLY7/luCToUfbDMhffoa3Od5Y/CRnYRwhPQ3X9AWw2OGmktbIIr3UYG5qqSCic4lbCLVJTCVv1J3Ss5lLtwktoF31CKjRHhRDzurKrJUXt8kOjw/vp2f9U+gpBsOY6H5YcU8CMhhZpXSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525869; c=relaxed/simple;
	bh=4ACT8X04sb6fAW3+47LxhHcq7/anCem7+kuAeIdPdiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ACEVyvo/aIYsgYrr9ckya+/BslUK8StWegje9Zjh9/anW+6nqKWnmpPgEXTXuASwzzPmwHk9BoAdOVGPDPLfieIYZW9AN4sMm+0mdkZCppghRnKiyGlQVj98t8RiLQg3QR5rSTWSZzX4EEv3pqUgJGrRPC1AI9W3VPE6wd6L2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMNXTcyT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMNXTcyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762525865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xL9UWKNVFseJyc8ZZEBbh4eUS+K/pGNVZX2OMNyP0Mg=;
	b=LMNXTcyT7dY+SPC6DxabADAf0rK9gMNjU32TSyK6Svjc0LDzw90jT+GlM5yie1Tbh2oMoS
	fxBbn1wruKqg4CB4egcx3gOpHdyavOvLN8sY9rOnNyK1PbXMJ5gh+bsokQLlgKcfTtCClh
	62lSInMKYu+UTFSXbveIwG19aZop3j8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-J2nbv-FwMNOsqwD0FZDi7Q-1; Fri, 07 Nov 2025 09:31:03 -0500
X-MC-Unique: J2nbv-FwMNOsqwD0FZDi7Q-1
X-Mimecast-MFC-AGG-ID: J2nbv-FwMNOsqwD0FZDi7Q_1762525862
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b72a11466c2so92878466b.1
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 06:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525862; x=1763130662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL9UWKNVFseJyc8ZZEBbh4eUS+K/pGNVZX2OMNyP0Mg=;
        b=jUilKN+FiQX8xlUwslabKHlYNvkDZDyMHMspeHDZccbbJNHkIY3cKGoHRoSJJLLNgW
         EyP0ce79FF/kxD28EObc1zZEEn76V/O73BEllKFznnGVNGmit+XK0n0eo3rf3+3PbiPP
         MZVb1qp1O/0iE0BGE1y0w1zVtXkbvoPjNpbcDsMp92FTm8pXwofGIACMjrZH3ccJhDSf
         tIhsce7N4dyi1Fi09lTT5Q+SFHF7vvLJsf/VK7BaDdn4pzKFxrCxajS6CMdUSPO6vigG
         cyY9h2kUQyr7VgMp3zUGA1HDDHJsyfRTn65/mdV9Dp64ZD9kfHUHi+tY0MtM8YriBw3i
         cc7w==
X-Forwarded-Encrypted: i=1; AJvYcCWRluzfoIsk81UAcWRjOXz+TH9w0CXGikYE7OR53v8o0M5Qg2okj/AiubgOeIaR2Cd/ZguGH8D5yE6DhIFJFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXf2Cox5yFsXG9NNgJAW4R6lF7ss6p5YPFEMTKeSxMMf/Gy/NM
	xamhEigQ4KDiiZig/Dbw9ft1a1usPF0QZnwT3MZt2+6FpZkkapzgW17U2PFak8HC3fp82MsimAo
	j5ffstiVwNbeLX4LUJdZ2rwfQh0XKtWBCaUfXjQtm0dGKb7zAj0+2DKFdEAXYzXsONw4I
X-Gm-Gg: ASbGncuuIHV8WHy2mrZYq4zBJfFTxNP1umZVf44NajwnSN1fpRP0BDWfo7zFEgByX2d
	XQ6PuWqrebBvG49jiondCenPE4VN3Uv75SsYEtAYkat39Oc0X1KhtUtN48QLPxCotUvNLVG2EJQ
	bsJUCc8yH17S41QKhjrpJyRXP7EkmnQ4UMtTGTbQoOaN8tlr8qVEuswrC71dv80fOvOIPvp9z/P
	hSpbYhg79Lk+HZTpy5JY4McFnJ7ZJzfrNW/p/giu/A/HJVj7ZUgjLVCP+LjPNxiNowu73JVBBkz
	Zgmaa27Decp7IzfmAPfoTKey4ZnC//hKdCOE5p3JNQIZqKxw7vjcnsoMMOb/UCNLdRIjXABDQ29
	n9KzyNFKLHi+VZbbyJffzMBTwXlfP5UbYJLQqC2LbGnHU2wW5DWI=
X-Received: by 2002:a17:907:9713:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b72c0db4a61mr338299866b.60.1762525862110;
        Fri, 07 Nov 2025 06:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVGP6jVhYiYdDeDEvDFwhwEthJq43aCkNDIhOMB5uynFpxGPUKrXfFtjd4lbRPq2WOuVI1vw==
X-Received: by 2002:a17:907:9713:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b72c0db4a61mr338295766b.60.1762525861624;
        Fri, 07 Nov 2025 06:31:01 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11295sm256401966b.67.2025.11.07.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:31:01 -0800 (PST)
Date: Fri, 7 Nov 2025 15:30:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <4d365ifyw5ncyboonznnnm6ua7psyt3ripzpvtyd35qa5zsgwv@f2kfgzgoc26c>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H_APKLZ5eICN2oj9jKcrD0hBen-fPL24CpKH8TRRiCo_1762525862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 06, 2025 at 06:52:15PM -0800, Bobby Eshleman wrote:
>On Thu, Nov 06, 2025 at 05:20:05PM +0100, Stefano Garzarella wrote:
>> On Thu, Oct 23, 2025 at 11:27:45AM -0700, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Enable network namespace support in the virtio-vsock common transport
>> > layer by declaring namespace pointers in the transmit and receive
>> > paths.
>> >
>> > The changes include:
>> > 1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
>> >   pointer for outgoing packets.
>> > 2. Store the namespace and namespace mode in the skb control buffer when
>> >   allocating packets (except for VIRTIO_VSOCK_OP_RST packets which do
>> >   not have an associated socket).
>> > 3. Retrieve namespace information from skbs on the receive path for
>> >   lookups using vsock_find_connected_socket_net() and
>> >   vsock_find_bound_socket_net().
>> >
>> > This allows users of virtio transport common code
>> > (vhost-vsock/virtio-vsock) to later enable namespace support.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v7:
>> > - add comment explaining the !vsk case in 
>> > virtio_transport_alloc_skb()
>> > ---
>> > include/linux/virtio_vsock.h            |  1 +
>> > net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
>> > 2 files changed, 20 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > index 29290395054c..f90646f82993 100644
>> > --- a/include/linux/virtio_vsock.h
>> > +++ b/include/linux/virtio_vsock.h
>> > @@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
>> > 	u32 remote_cid, remote_port;
>> > 	struct vsock_sock *vsk;
>> > 	struct msghdr *msg;
>> > +	struct net *net;
>> > 	u32 pkt_len;
>> > 	u16 type;
>> > 	u16 op;
>> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > index dcc8a1d5851e..b8e52c71920a 100644
>> > --- a/net/vmw_vsock/virtio_transport_common.c
>> > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>> > 					 info->flags,
>> > 					 zcopy);
>> >
>> > +	/*
>> > +	 * If there is no corresponding socket, then we don't have a
>> > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
>> > +	 */
>>
>> So, in virtio_transport_recv_pkt() should we check that `net` is not set?
>>
>> Should we set it to NULL here?
>>
>
>Sounds good to me.
>
>> > +	if (vsk) {
>> > +		virtio_vsock_skb_set_net(skb, info->net);
>>
>> Ditto here about the net refcnt, can the net disappear?
>> Should we use get_net() in some way, or the socket will prevent that?
>>
>
>As long as the socket has an outstanding skb it can't be destroyed and
>so will have a reference to the net, that is after skb_set_owner_w() and
>freeing... so I think this is okay.
>
>But, maybe we could simplify the implied relationship between skb, sk,
>and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
>ever referring to sock_net(skb->sk)? I remember originally having a
>reason for adding it to the cb, but my hunch is it that it was probably
>some confusion over the !vsk case.
>
>WDYT?

If vsk == NULL, I'm expecting that also skb->sk is not valid, right?

Indeed we call skb_set_owner_w() only if vsk != NULL in 
virtio_transport_alloc_skb().

Maybe we need to change virtio_transport_recv_pkt() where the `net` 
should be passed in some way by the caller, so maybe this is the reason 
why you needed it in the cb. But also in that case, I think we can get 
the `net` in some way and pass it to virtio_transport_recv_pkt() and 
avoid the change in the cb:
- vsock_lookpback.c in vsock_loopback_work() we can use vsock->net
- vhost/vsock.c in vhost_vsock_handle_tx_kick(), ditto we can use 
   vsock->net
- virtio_transport.c we can just pass always the dummy_net

Same fot the net_mode.

Maybe the real problem is in the send_pkt callbacks, where the skb is 
used to get the socket, but as you mention, I think in this path 
skb_set_owner_w() is already called, so we can get that info from there 
in some way.

Not sure, but yeah, if we can remove that, it will be much clear IMO.

Thanks,
Stefano

