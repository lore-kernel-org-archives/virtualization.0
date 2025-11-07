Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2D32ABD0
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528071; cv=none; b=NS4Hnh6zTp6mamYGA38FjWwXv2SOHWWubiQdR8V4XT07R/UNI4EJ70C4AsPGHJBV6L2JSi8jwpF6+dh8J2G5gi0xc2UiJuqoXXQrDI/CIYM8KZ78B0zrhKtspkQFXyvQCYM4/duTOz5+Zm4kPiDXL4naat4cw6HZQq8WoUpLI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528071; c=relaxed/simple;
	bh=E0TnocTKBNnVc3GrPJJgfMEfKP9Lw1C6272/2uJxvxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YKbg62w/hBV6WPZTDXz/BNyUfGEs/J5k8eIrZ6vj3rz15hLFM7gJ3S1l8Q6L+ZrIU/5K6O7zhucea5zehrURX0c0tc5QQjx3xhaEnNnDDvy4oe4LywO3McQdjlDPxTybHeh++Oux82BiUo6QsZXtl4wE4UNLzWk5LIMQHajLqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWiScVkr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWiScVkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762528069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNbanbYsfxulMVcZrRqggEQbgzsiO6gl6XfzX4tJ3v4=;
	b=OWiScVkr484QZM8FbmJWR0QO8YvYp602Vc3rrZjffet8LdpVLwkPSnqsAJmvuvfIrlAAcJ
	nsYgtthI5m/Rgm1ebUSEaBBLcYMne9h4lWuzk7IWAlUxPYv6bbEp/QxrioWYelNt0o7rVN
	yMG0gVZCkHv352qH/xiLH7cNig2NE0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-3gkTddUCMOyt_SMQhgcxhA-1; Fri, 07 Nov 2025 10:07:46 -0500
X-MC-Unique: 3gkTddUCMOyt_SMQhgcxhA-1
X-Mimecast-MFC-AGG-ID: 3gkTddUCMOyt_SMQhgcxhA_1762528065
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47106a388cfso5299925e9.0
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 07:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762528065; x=1763132865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNbanbYsfxulMVcZrRqggEQbgzsiO6gl6XfzX4tJ3v4=;
        b=mVF52UyjYxCTSGo5NnUMqekLxmqIeh6G+nA4sPUAr+oqDHIa7SHpgg6XKxP6tOCxyy
         HJIoMMk4fygWow7hjE54f29beXSPFiXwi+s7c8JGaAbeLc/xbjhUHAt/OPHYBYp3ARo3
         JYQElGKNii63kyNZLbpOoYN1ZkShE5Z+yhi44Ns2yhQ49awWwGPnT+hVtyoMBXlRfyIU
         es6OK9gdGLaMFKb12Fgz6gnLRtIL69+kF+CO23CHJnYwXXY4RnKZ+OKq3lG/DGGdgiFC
         9oiMr247Ed+IvQPVzA+pXd8bqpjL/Hj5I6kQl6ZYODPJaDlZJi76vr5lOXPKXXyymboz
         GlXA==
X-Forwarded-Encrypted: i=1; AJvYcCWliSYlBm6I0mnh/SZorMyybisLSiPtRST5ZSR24FUOeR2EIo/oJGa3gH43l9lNrvqXZWYxwX1+3bqTfwP2KA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAS8MPcAMhWe2XtD5Zwe51eGf47WJlv0CyzkMlnRRl9L3pVlkT
	i3ORlTWf7VYO74jgQAvp5Rgafl3cmMwpNRCEXBzTzdvH9S9Z0lDEYwQcEySycYvVNdJ2S/Z0r64
	E/wnlwL2HVOsjprlc1pGXOQBwb52XOguBxvMD/P9SJVQfT6SuttMGL7/Xoq81EVITadKe
X-Gm-Gg: ASbGncuIQttWyMZY+4L47X4bJVX/9omVhD/vfTJqzgDGCl4LbklRtY/F2BeoUOG14pJ
	jySjNhm4I7rViTg4bj35QRQIrLu45QeJXhTHFZJU7vFdjTLFA/z090iQHTGcfAEgOnBvJxAoU7q
	TA8JUS4QRR4iHq750A2+tT1q/qwMPZBbZXF+r/Oqr91gKO965ea7TGCiafUq8F2K2RGNH6i3lwu
	Q4+C9eWO2oOeFh1FdTSw1lWSVPDL6jk11ea3U7o5Ae1j1a8pa7NBc/vg8s8wbLYYZzSEq8GVDbu
	EQcRL0F5nuC6uJRbPMHOZlZpZxt3ImRnuv9UHDdEl6/vGN6zULnLqSpsSUpcfWASBiS6J6pzdPV
	rBblZVePCcmbai2GrOQq+3C4Hmpo5jA8M2iZzxxCgYlDjS9jzQ/Y=
X-Received: by 2002:a05:600c:1d07:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4776bc903e6mr26789215e9.9.1762528064550;
        Fri, 07 Nov 2025 07:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQNTjpNs4/UNPykir5Jo9cymIZysqFSvPmuq5540gA8Si7EGD1eA8R02jdPEwY06PLdnTMig==
X-Received: by 2002:a05:600c:1d07:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4776bc903e6mr26788905e9.9.1762528063975;
        Fri, 07 Nov 2025 07:07:43 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm69515455e9.14.2025.11.07.07.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:07:43 -0800 (PST)
Date: Fri, 7 Nov 2025 16:07:39 +0100
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
Message-ID: <g34g7deirdtzowtpz5pngfpuzvr62u43psmgct34iliu4bhju4@rkrxdy7n2at3>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
 <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2Ctfq5MsF4yUN8JjScfcPGVGgrdTh080oz8dZhrbbdw_1762528065
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 07, 2025 at 06:33:33AM -0800, Bobby Eshleman wrote:
>> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > index dcc8a1d5851e..b8e52c71920a 100644
>> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>> > > 					 info->flags,
>> > > 					 zcopy);
>> > >
>> > > +	/*
>> > > +	 * If there is no corresponding socket, then we don't have a
>> > > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
>> > > +	 */
>> >
>> > So, in virtio_transport_recv_pkt() should we check that `net` is not set?
>> >
>> > Should we set it to NULL here?
>> >
>>
>> Sounds good to me.
>>
>> > > +	if (vsk) {
>> > > +		virtio_vsock_skb_set_net(skb, info->net);
>> >
>> > Ditto here about the net refcnt, can the net disappear?
>> > Should we use get_net() in some way, or the socket will prevent that?
>> >
>>
>> As long as the socket has an outstanding skb it can't be destroyed and
>> so will have a reference to the net, that is after skb_set_owner_w() and
>> freeing... so I think this is okay.
>>
>> But, maybe we could simplify the implied relationship between skb, sk,
>> and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
>> ever referring to sock_net(skb->sk)? I remember originally having a
>> reason for adding it to the cb, but my hunch is it that it was probably
>> some confusion over the !vsk case.
>>
>> WDYT?
>>
>
>... now I remember the reason, because I didn't want two different
>places for storing the net for RX and TX.

Yeah, but if we can reuse skb->sk for one path and pass it as parameter 
to the other path (see my prev email), why store it?

Or even in the TX maybe it can be passed to .send_pkt() in some way, 
e.g.  storing it in struct virtio_vsock_sock instead that for each skb.

Stefano

