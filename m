Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7D2ED872
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672426; cv=none; b=ccgz2jru1oHfuI3jla/rFjhpn/jLzU/O2VnEzJ8EX8Orkhi+8SbtjdoAQC3/Mc+vFh3XQ868berHMOKQe9FTujodIsqToEFDIe3m7cJ/0KBwGDkTDMps0ivUq8zOMbM6q51tBq1tPlK4BpL7C/BO0cv2Ufva+RdXvX77R0hZ4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672426; c=relaxed/simple;
	bh=ZZfSolL28liTEnsaqqekR1GwI4GeyNvw1ffBWs0x/Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IynspMxS6Xle+QktSsl6m7+qDnZHoUjO/jKUfxCIbZzEN6S2P6F4pvMaK4y1+SjDPVPYDM/Cx55/JzwP+a6qJEHTTl1lXT4c2Hr9b68a3pET2as0n2YxepVgSbYNPl3ReemczbCHRKccWETh4s+HtfnFnDU/BBsftKYBRbGHlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaiEYL2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaiEYL2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773672422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKhHuHBXRJ+I0jn8wxM059uZWEF8kMlWUss6Y6JwesI=;
	b=BaiEYL2cpZ3K1N9k/nVH2bcS0Qvebuok/TPP3dYoFsAJkJ/g55FGA3PVAymjc3X+Vv8P4o
	cD+gwHBbE57Mb00sEIZU1HQWIt/ky3A6RrknM7B9D03j3yQ+IV9XaiDO/xvqaO8i25hDqn
	FECcRzPy1Gb9KxFnhVNUELLze3TStQM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-pra_uzeNNZaZ44_Y6q5WAg-1; Mon, 16 Mar 2026 10:47:01 -0400
X-MC-Unique: pra_uzeNNZaZ44_Y6q5WAg-1
X-Mimecast-MFC-AGG-ID: pra_uzeNNZaZ44_Y6q5WAg_1773672420
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b41d45be4so965382f8f.0
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 07:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773672420; x=1774277220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKhHuHBXRJ+I0jn8wxM059uZWEF8kMlWUss6Y6JwesI=;
        b=pf4aW/tH126xAvCLyim7AI/69Pyq8grQnV/sy0A5ozsraBxGbshH9koq25GJxhKZy/
         OZJ1h2WVgVFiP1Mk3nDw5+M7AzKFJjtWRcEuexrbJquqm9kyKc8z+lDTDdnB6MAhsO4u
         gj9iJ+CxIOQq4AUWBD3eA58e0Z/3XYSyEjcd7m6M/DzQ0JTCbYktzeWl1pXE6b2EqgR4
         1RMmbEdIaUE2gAX8wEKMVHvC439NxoNw1rEhSbP15B0D+MM8Zm+CEbqbPl2cgW8F0gY+
         Ae0S6Wc0jtkPNU5ljrMalRld0tH6OfBCQ8curHzKq4WbUR9ctpBmFKR5pqNzwC4V9vTs
         2imQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlpQG4eBu7xeAU+KYbGxygvivMzAMkEoCzIl1v3U3sqVwE2t9CYZVf7YhEdbonyIRw+R82TyG9KhaWlXtXcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJwrEvY5LqnWhtA2P4chHnFkllu5vbvPQMMzkSfhsu+Qxw4Jp6
	M7kQbIxvw0nR5/RDFGLugwSHYDx9H8GpQWekPCAsUiU5C6LcA8PVI1lyblMOgn2zLEHZuL6GBSD
	fioykOUyLZL4KvwhkJTsZBMGfG37EuGCb5vdcP3bOz2eAVFCNF2kAcXf0nSyWLZYj4g3U
X-Gm-Gg: ATEYQzwbn5yi1AVRtFwftoCoH+yQ262Kc6HFUkn9xcqkXyC4ROE3wQtQxNl7n8AcNU5
	pJTWelgreG5RG2m26nTTfLqS4+plUHBGA4QMFg9IpWYR2ADjLBSuAXjwpX8wOCIVUMVcuK2E75a
	FqlpSlH2GcUPGvK1lBw7WGrGwVAiyQzEZWWUtlNzFFT2fZcQiDkj0B1hKHWKdu/A4DZ3mkVGqAj
	uuR+fhVzvCzJ4dQxQz73Ugq7CqdAV1Fxf0imADwaGvbQbUbBV1Aplwleov28PkBHVJKnbQQ0jt1
	VJxnCD5X+/geMp7rWLE178R8LeMZFT+/m/sqoQfRV650rk0nuzt3cmGfQUwkbp5g5iahSAarc69
	tlswR/SxsGGMIAq2LUvOGpf94Ci39k1z1OOOgxP9Wd2ejAA==
X-Received: by 2002:a05:6000:420c:b0:439:9812:35ea with SMTP id ffacd0b85a97d-439fdf347efmr31647535f8f.3.1773672420161;
        Mon, 16 Mar 2026 07:47:00 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:439:9812:35ea with SMTP id ffacd0b85a97d-439fdf347efmr31647475f8f.3.1773672419567;
        Mon, 16 Mar 2026 07:46:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b41dd93c0sm10828039f8f.10.2026.03.16.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:46:58 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:46:55 -0400
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
Message-ID: <20260316095919-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
 <20260316063139-mutt-send-email-mst@kernel.org>
 <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
 <20260316092707-mutt-send-email-mst@kernel.org>
 <4e3ce2d6120545719a286d3daafbef38@hygon.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4e3ce2d6120545719a286d3daafbef38@hygon.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: If4D507s1Sc2PQ8tW3qaqW8o4fsLPN557QvNKT6rpkY_1773672420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 01:57:22PM +0000, Zhud wrote:
>  > On Mon, Mar 16, 2026 at 12:57:00PM +0000, Zhud wrote:
> > > > On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > > > > > Thanks! Yes something to improve:
> > > > > >
> > > > > > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > > > > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > > > > > > indicates the device supports dynamic control of guest
> > > > > > > offloads, it does not necessarily mean the device supports
> > > > > > > specific hardware GRO
> > > > features.
> > > > > > >
> > > > > > > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK
> > > > > > > (such as TSO4, TSO6, or UFO) are present in
> > > > > > > vi->guest_offloads_capable, the device effectively lacks the hardware
> > capability to perform GRO.
> > > > > >
> > > > > > So what is the user-visible problem this is trying to address?
> > > > >
> > > > > A key concern is that once a user enables NETIF_F_GRO_HW via
> > > > > ethtool, they might manually disable software GRO (ethtool -K eth0
> > > > > gro off) assuming the hardware is now handling the aggregation.
> > > >
> > > > Thanks!
> > > > Sorry could you be even more specific please?
> > > > Is this a theoretical concern or did some users encounter this?
> > > > Note that NETIF_F_GRO_HW is best effort anyway: e.g.
> > > > it can apply only to TCPv6 and v4 will still need software.
> > >
> > > This might not be the best example, but I want to draw an analogy to
> > > show how this hardware offload capability can be misleading. For
> > > instance, if I enable GRO_HW expecting to see lower CPU usage when
> > > receiving packets, but it doesn't happen, that would be very confusing.
> > 
> > It still can happen if hardware does not offload the specific traffic, yes?
> 
> Yes, of course, but there's still a difference between "best-effort" and "no-effort." Right?

I am not saying this does not improve the user experience.
But let us set the expectations correctly.

What this does (I think):

	When a virtio device does not have either GUEST_TSO6 or
	GUEST_TSO4 offloads, this means it can't really do
	hardware GRO.

	however, the driver will set NETIF_F_GRO_HW whenever
	the device allows control over offload support - even
	if the offloads that can be controlled have nothing
	to do with GRO.

	As a result, in such a setup, rx-gro-hw reported for the device
	is too optimistic.  Improve the situation by masking off
	NETIF_F_GRO_HW.


	Out of abundance of caution, this does not change the
	current behaviour for hardware with just v6 or just v4 GRO:
	current interfaces do not allow
	distinguishing between v6/v4 GRO, so we can't expose
	them to userspace precisely.

Also:
> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")

are you sure it's right?


> > 
> > > > > Secondly, while we haven't encountered a specific hardware failure
> > > > > yet, enabling a hardware offload feature that the DPU does not
> > > > > physically support introduces the risk of undefined hardware
> > > > > behavior
> > > >
> > > > This would be a major concern but I don't get it - how would one trigger this?
> > > > It seems that guest_offloads_capable only includes offloads actually supported.
> > >
> > > You're absolutely right. Upon rechecking the code,
> > > virtnet_set_features already ensures that only bits within
> > vi->guest_offloads_capable are sent to the device.
> > > Thank you for pointing that out.
> > >
> > > > > > >
> > > > > > > So, making NETIF_F_GRO_HW conditional on these feature bits
> > > > > > > ensures the stack does not enable an unsupported hardware
> > > > > > > offload
> > > > configuration.
> > > > > >
> > > > > > I guess the assumption is that without this, something enables
> > > > > > such a config? Which stack is this and what happens then?
> > > > > >
> > > > >
> > > > > Sorry for the confusion, let me clarify the intent.
> > > > > The 'stack' here refers to the ethtool interface and the netset (ioctl/netlink)
> > path.
> > > >
> > > >
> > > > A bit more detail about the specific set of commands that leads to
> > > > confusion in the commit log would be helpful.
> > >
> > > > Thanks!
> > > >
> > > > > >
> > > > > > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > > > > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > > > > >
> > > > > > judging by this, has something to do with LRO?
> > > > > >
> > > > > > > ---
> > > > > > > /* v2 */
> > > > > > >   -make the modified logic clearer
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 6 ++++--
> > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > > b/drivers/net/virtio_net.c index
> > > > > > > 72d6a9c6a5a2..b233c99925e9 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > > > > > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > > > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > > > >  		dev->features |= NETIF_F_GRO_HW;
> > > > > > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > > > > > -		dev->hw_features |= NETIF_F_GRO_HW;
> > > > > > >
> > > > > > >  	dev->vlan_features = dev->features;
> > > > > > >  	dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> > > > > > NETDEV_XDP_ACT_REDIRECT |
> > > > > > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > > > > > >  	}
> > > > > > >  	vi->guest_offloads_capable = vi->guest_offloads;
> > > > > > >
> > > > > > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
> > &&
> > > > > > > +	    (vi->guest_offloads_capable &
> > GUEST_OFFLOAD_GRO_HW_MASK))
> > > > > > > +		dev->hw_features |= NETIF_F_GRO_HW;
> > > > > > > +
> > > > > > >  	rtnl_unlock();
> > > > > > >
> > > > > > >  	err = virtnet_cpu_notif_add(vi);
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > 
> 

