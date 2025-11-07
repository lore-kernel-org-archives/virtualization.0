Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434592D7394
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530453; cv=none; b=iIR5ujuX+OosiKJtDysIZWhw4IRbgoVtxfhw9OJB3YDHVCKdssjIJX9XoUoR79xDG+9ZIpu6W7M77SxyHKR2lnV11ol+qxR8r0WncZJB9jfTgW1up8JVZ4Xb0Y1lKgggUBIYtPqzu85/wjc7fZ4HcL4EtbqtvWHQscSYHS7xakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530453; c=relaxed/simple;
	bh=AgQbQ+KSNY8EMVam7WimxKAMD+pVWQVs4PeEWZxxuTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaWrusBXONt0kAEyD5TUSqN4LaTcwTqXGZ27v8leXA06/v9CeQIkmPnFU54DdjJ8axaVXIgrbAP0Nd0izqZJOJq9lDsRhXTA9MD+8I5zWLRAhOA/TgdKRR2i2EigWdrp8FTY9cFkBzp7zQDsAWfwik5vwx3xO6T+NqcMC8NBl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgzvXBou; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgzvXBou"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63f9beb2730so800485d50.0
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 07:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762530449; x=1763135249; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNPUJeO0jfL+NoCnK5UCUnDeuVhOeT6TwUJCRr1zq70=;
        b=TgzvXBoufaLQMVqXrrNfeFz0dbm9yWT4b2slZAgp/pbKxEcL1A1dCkHYnFkT+cwnNW
         sfnEtRP7ksTDviziYnoj1FDW6l9s9dObCOINL/FJe5IwcS2zthbImOyQEeU6qWGWovOv
         2gGWwNfIOugMHPq8By6AB5uulVBkZp0ulP57ptvXk/sSzEfKtW8NKLYn2zFeIRuJ0LLr
         iQQcL2Cm6Lj36lY8lPYuJal47e0zABAYR+NwtCKbj3bbIsjxbZIbn9Ok3rKn72/gHgHZ
         C3u7h0H/sTvsEPhzkpYIUIVtcU+C/GpqpyQgePu3ogYnkqzEmbFvNlD06yfIL2si+jQg
         VwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530449; x=1763135249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNPUJeO0jfL+NoCnK5UCUnDeuVhOeT6TwUJCRr1zq70=;
        b=wVtz9v/o98RDjP+4ZxmSapQbmEML+gdKPA1bzOz7LElKMVI19SaPBsLJwb4n0Xo1Cc
         H2oW+FkssNWL1TZX1rlIkEhh+DiEUCDQ1s4EQdiTrN63YspGvG83dviGZi+PT+vOwpFP
         3HwjTwpaAm73kzN5X3HBtVtT1R6jtg0s5YN6H7xnVBILZJQ5U2jGzEs8FDH7kH0Kdmme
         d4iX8oGn88QVyAL0clPkYT3QLipYIJnd+pbF3ClQCPu5ZxzOLKB824hBtoUFFk4kgmFw
         /63HkKGpmGvsjdoKY7V9pL5RU4fq7c0j0Gu8IVEPKdrHAO2Mx3al+70NMvCHH6qmTIWC
         BG7g==
X-Forwarded-Encrypted: i=1; AJvYcCUbNOKq0THAjpx5mSgmJizAb1277W2pLK3KQXu7eHfzYrF8HeX3Jd+m+X3VxlUlx4tMdUBRz+QNBT09UKoh4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCuVB/qHbC/+NYI/0OV+kfz+tu66ebj2hsAOIt8s7NRYwfOieC
	th8IwtXE8xSgtCScxGu6GF/qlMOQMufPrnDnNXbrhC49P3OWICFFwyRK
X-Gm-Gg: ASbGncvdaWSiCINy4FHu962lnq4uzPsEmaZsor1hWZ3zXm2qKJfMkE7kpqd6aLAQUNj
	CCTxovR4cIl76Ct5uo1bfH1+hlCDPpQ4XZiMS4Hc3YsBwA7T9oVNpzVC/eXhVV+IQcU1DDt9WHN
	lpTMqanghzgP7QO9Y0kNVmV8a0lWOUo59dYxRhAJN9xzFV7SBcT8KB6/iiyGq+Gkp3Bv6wiOFoh
	zeWZmt2i3K7VdkjxWzibIxdPvt1KfaKCUizi6Q3tlgtbKN0w6TCX3hVByzZbdzm9aGwJOiJ9cMA
	/aiwNP23MBx2Dat4T0EN4PmV3AkSABN02q5xwT6ojBF05209watJsY8oCo4bEQhd78ik2nAolxN
	UMi8VhoPUSFtPWuxubKJESTs2XxUDnALXACg6nBd+mRsp464hC03HaUwwoRQ1AXAsnYdfl3eOew
	Fd6fIjTQXSwWqtZVWuluIjTgTCALmcbpVGhiU=
X-Google-Smtp-Source: AGHT+IFXvS+IpNFgsgMywAgZqoOQibHP63Xuf6dTUbNtxkKzSlUYwHyXzkOlrbPYGdpQ0cshEmiYAw==
X-Received: by 2002:a53:acd5:0:10b0:63f:a7dc:5661 with SMTP id 956f58d0204a3-640c4177959mr2767546d50.12.1762530449193;
        Fri, 07 Nov 2025 07:47:29 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5c91334sm1890653d50.1.2025.11.07.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:47:28 -0800 (PST)
Date: Fri, 7 Nov 2025 07:47:27 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <aQ4Uj6z129htVqLk@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
 <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
 <g34g7deirdtzowtpz5pngfpuzvr62u43psmgct34iliu4bhju4@rkrxdy7n2at3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g34g7deirdtzowtpz5pngfpuzvr62u43psmgct34iliu4bhju4@rkrxdy7n2at3>

On Fri, Nov 07, 2025 at 04:07:39PM +0100, Stefano Garzarella wrote:
> On Fri, Nov 07, 2025 at 06:33:33AM -0800, Bobby Eshleman wrote:
> > > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > index dcc8a1d5851e..b8e52c71920a 100644
> > > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > > > > 					 info->flags,
> > > > > 					 zcopy);
> > > > >
> > > > > +	/*
> > > > > +	 * If there is no corresponding socket, then we don't have a
> > > > > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
> > > > > +	 */
> > > >
> > > > So, in virtio_transport_recv_pkt() should we check that `net` is not set?
> > > >
> > > > Should we set it to NULL here?
> > > >
> > > 
> > > Sounds good to me.
> > > 
> > > > > +	if (vsk) {
> > > > > +		virtio_vsock_skb_set_net(skb, info->net);
> > > >
> > > > Ditto here about the net refcnt, can the net disappear?
> > > > Should we use get_net() in some way, or the socket will prevent that?
> > > >
> > > 
> > > As long as the socket has an outstanding skb it can't be destroyed and
> > > so will have a reference to the net, that is after skb_set_owner_w() and
> > > freeing... so I think this is okay.
> > > 
> > > But, maybe we could simplify the implied relationship between skb, sk,
> > > and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
> > > ever referring to sock_net(skb->sk)? I remember originally having a
> > > reason for adding it to the cb, but my hunch is it that it was probably
> > > some confusion over the !vsk case.
> > > 
> > > WDYT?
> > > 
> > 
> > ... now I remember the reason, because I didn't want two different
> > places for storing the net for RX and TX.
> 
> Yeah, but if we can reuse skb->sk for one path and pass it as parameter to
> the other path (see my prev email), why store it?
> 
> Or even in the TX maybe it can be passed to .send_pkt() in some way, e.g.
> storing it in struct virtio_vsock_sock instead that for each skb.
> 
> Stefano
> 

That's a good point, the rx path only needs to pass to recv_pkt(), it is
not needed after the socket lookup there.

With TX, it does look like we could get rid of it via the
virtio_vsock_sock.

Best,
Bobby
