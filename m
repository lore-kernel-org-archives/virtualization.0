Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BF182D0
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658083; cv=none; b=auro8HWV19G3ifLoxJuy1c6MwAmuBVrDP3OSiESEho9Y+C0cHXpKSB+xmP5uaQahfMwFIm8r+Ke5wBW/9VLWN4si7msWPuhq/mgxoLRRebGLhqe6IT1ULuxlqmQkaY88CI2YME9RLxiQH1Vo7Vl6shRu4kBumT7pSaFbtxzMLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658083; c=relaxed/simple;
	bh=1QFgAt6v5G8ZF6zVoJAv0kj7kMi7gvlUjuhjHhXigUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hhTeXWIiPzhtPEV8dEbFRANRjoOed5dJkaW74uAgPUzTIEsMqKhfTlRrVXToHVMw1ON2qeNqMYoysURnyOrYYHTNvXuCEZuRB7iOcZFifv47XFyQvpSZqICCQXpGlcf/6jQCI4QmTqTxqKyKpM4aH5adjh6JzI/Xvq54qHTYMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGRhmHK/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGRhmHK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773658081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfYGvWXFyEp3tl8sYK4EkCi7nOSDVzMxt5VwgIY+JXA=;
	b=UGRhmHK/IuvGb2g2bMUsy9/e7eiL50CLcPxClCLx2AyyTgXnk0A0mvjMpV6qH/n0S3/DXk
	ogn0N7SzQrV2SKVBs3GBU3NB1Fi5OM/K90Y8VqPu5AhofMYRyZQCrZjHuSVdAszFS9wz5Q
	gPAEuuTOhrPtzI3qI9JvPRUOBY0P5gI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-FsBRbLR8NBWdxL6eS04isA-1; Mon, 16 Mar 2026 06:47:59 -0400
X-MC-Unique: FsBRbLR8NBWdxL6eS04isA-1
X-Mimecast-MFC-AGG-ID: FsBRbLR8NBWdxL6eS04isA_1773658078
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e6012bso47104405e9.1
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 03:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658078; x=1774262878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfYGvWXFyEp3tl8sYK4EkCi7nOSDVzMxt5VwgIY+JXA=;
        b=M+D+vxxdnH52ekG3bZvPKt5TwdZVY5gMHsuJ9GJ6TMuYJs77duQefCAE2peI36FcIi
         PDbdwu0XoLmTB5oSIIuLbVl7I0cNGmyltHRVTZ1L8lA2a4I3SYKucfoUUa04JBLDkqIO
         /3Owg0sWD0cF84mzTjpXPPsJTRvfb2fttP3M7H+S3eE209IZGRyu9Qe4eo2hSaogFn4w
         gOcD7D3YaMHQyitjmHo83sEP5DAebInBgB5tolYT1DlM9V9LVnjrq47xdj6qtpS0ie4C
         afFyjnsl3WEk09Q4Ig5mNWBfNfERsVtHC4WGne2mDQjesy8E6WUK1caBRkZKirgjvW21
         /H8w==
X-Forwarded-Encrypted: i=1; AJvYcCUFT79PZBy9v7A644MuqrYwO1SaEiJnZMeY5e22YEwyAlqK2xoMSxVk+RxQJWjpk6EprQN5lR8yp+N8btUd/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl9aPC+l4WoOZ0KHLMj5pPRL1Gm3MCYuIZ2V7zeivV8YKV607l
	4Z/CTNb8+NiSvNLZNEv1UNmzCj7BLXx9ZgBuyl4Xj4QZbpPgpZYl0UE4OEFPUQQGEquHR3ti4hH
	r5wrKlJBzegQabR8vyE/9EIObHL0TlOsYLl9XdW5QHJBevHD+pU1ujq2XbEH2+uWPei/h
X-Gm-Gg: ATEYQzz/dxgsXFovHO2je779VzDn/E1sa8dQufrX7XPjBjQ8nqTQtLSzga1m8Z0aBV/
	HOtlXxWSA7SvS2oqXEGPK0Rqe4gjwyGHq/QG8IxmkhdVd3CXkZ0RQdgqqMQ7UIoln4NbsERN7Jp
	sVDBYFmWBDD1dHZV0IPnzx5cnXBabPDDyWIRTbt7XZ7siBsD57R6Y5JQmpYA6JVdgW1Kit7EI+z
	vWr2ILiyDDjBeQpgpOB3OCvdrQJewN6uT8FZak+EXLxeivrOL7dKPisVUdRfg1Q/scj8LGXqoPd
	IB8c83HQZHzPEDP23M/rVnoM5psNO8rN2U4d9xxxIdaVcC6QJnXbMkSCyhyDCD3PKCBBr1ClBBw
	qvxhaG6XGrHS0+cqybQOSvs74jg57PLqnLlvIme1vkhKvEQ==
X-Received: by 2002:a05:600c:4f8f:b0:485:4371:539a with SMTP id 5b1f17b1804b1-4855670f7admr178896805e9.31.1773658078266;
        Mon, 16 Mar 2026 03:47:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4f8f:b0:485:4371:539a with SMTP id 5b1f17b1804b1-4855670f7admr178896555e9.31.1773658077775;
        Mon, 16 Mar 2026 03:47:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm383282095e9.13.2026.03.16.03.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:47:57 -0700 (PDT)
Date: Mon, 16 Mar 2026 06:47:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhud <zhud@hygon.cn>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"willemb@google.com" <willemb@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Jing Li <lijing@hygon.cn>, Zhiwei Ying <yingzhiwei@hygon.cn>
Subject: Re: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260316063139-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <607818aba89a44d88afa213f39611451@hygon.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AufqG_RU2BSyWk3GtQ4VA_f9-bXI9K6AQ9AayfOoGyI_1773658078
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > Thanks! Yes something to improve:
> > 
> > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > > indicates the device supports dynamic control of guest offloads, it
> > > does not necessarily mean the device supports specific hardware GRO features.
> > >
> > > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
> > > TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
> > > device effectively lacks the hardware capability to perform GRO.
> > 
> > So what is the user-visible problem this is trying to address?
> 
> A key concern is that once a user enables NETIF_F_GRO_HW via ethtool, 
> they might manually disable software GRO (ethtool -K eth0 gro off) assuming the 
> hardware is now handling the aggregation.

Thanks!
Sorry could you be even more specific please?
Is this a theoretical concern or did some users encounter this?
Note that NETIF_F_GRO_HW is best effort anyway: e.g.
it can apply only to TCPv6 and v4 will still need software.

> Secondly, while we haven't encountered a specific hardware failure yet, 
> enabling a hardware offload feature that the DPU does not physically support 
> introduces the risk of undefined hardware behavior

This would be a major concern but I don't get it - how would one trigger this?
It seems that guest_offloads_capable only includes offloads actually
supported.

> > >
> > > So, making NETIF_F_GRO_HW conditional on these feature bits ensures
> > > the stack does not enable an unsupported hardware offload configuration.
> > 
> > I guess the assumption is that without this, something enables such a config? Which
> > stack is this and what happens then?
> > 
> 
> Sorry for the confusion, let me clarify the intent.
> The 'stack' here refers to the ethtool interface and the netset (ioctl/netlink) path. 


A bit more detail about the specific set of commands that leads to
confusion in the commit log would be helpful.
Thanks!

> > 
> > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > 
> > judging by this, has something to do with LRO?
> > 
> > > ---
> > > /* v2 */
> > >   -make the modified logic clearer
> > > ---
> > >  drivers/net/virtio_net.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > 72d6a9c6a5a2..b233c99925e9 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > >  		dev->features |= NETIF_F_GRO_HW;
> > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > -		dev->hw_features |= NETIF_F_GRO_HW;
> > >
> > >  	dev->vlan_features = dev->features;
> > >  	dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> > NETDEV_XDP_ACT_REDIRECT |
> > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  	}
> > >  	vi->guest_offloads_capable = vi->guest_offloads;
> > >
> > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> > > +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> > > +		dev->hw_features |= NETIF_F_GRO_HW;
> > > +
> > >  	rtnl_unlock();
> > >
> > >  	err = virtnet_cpu_notif_add(vi);
> > > --
> > > 2.34.1
> > >
> > 
> 

