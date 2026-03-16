Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F428BAB9
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667815; cv=none; b=RUnWgPEAhXTib77EnEzcD6cWucm3Qm6LXKVts9D6zLYJkKLTlt7XFMCx04x2jdDivpeGzLEAhBNsINwYg3YMlHRqL6hlSzGN9R8rEy9d7clbuQ7vls2YN9F065r3aZkS1gdubtVK/dEriHQ5ft0f2VFRUGUJD+DrWrI8SzXCQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667815; c=relaxed/simple;
	bh=QDNHRZmE38+feZWtHpvQ6ICZ4f0tHwvcrBjAtOmklMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u3c3AXef93Tw/sDXpx55GUSXojfqzVn/nOcIcFXQgTkm3LwBBc/SE0TGKXDzTjk4iouzOqYJ8/MJVFIdF19F0hEUJjYVlyObW4qferjl/g8WIwi8A/cx1MVgS9VfVecdSxWEUYqOg4ZLTVsJ53Cpoc+HalyEA/hO704sjrjF3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvBh2GbR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvBh2GbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773667812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+w+/Jh+WDYnnRceoUho544RVsc8WCcn6+lrKA2JyEu0=;
	b=bvBh2GbRwQUTNRgFgGWZBasNPpZ9dzITD+BHv/TneVT7/dNCsrooE8z1Q7R+N3BJoymxkr
	KKxw27LytWsMlJ0qcUTuqumprBrGqvcTZ3mwmR9elQrctvpZtDC+2eWZCgqAT8CfkRsJpL
	RZUfjzK3lXPGyVgASW45SVM6IrqGS3E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-RcSoPObmMOy1XgNBPCPUvA-1; Mon, 16 Mar 2026 09:30:11 -0400
X-MC-Unique: RcSoPObmMOy1XgNBPCPUvA-1
X-Mimecast-MFC-AGG-ID: RcSoPObmMOy1XgNBPCPUvA_1773667810
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5a14d9e07d7so3997887e87.0
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 06:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667810; x=1774272610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w+/Jh+WDYnnRceoUho544RVsc8WCcn6+lrKA2JyEu0=;
        b=sH9VPeMi3NHZQ0tPNMXbcKkjxHCtJ78yiHsiYV3m2EXTP7uFj9s3i/tRC16/jpaiPw
         CpIiAWom5vFNDb3yR+fH0Qlp8QAJEwgIMXAwjiiYASQAOYCu25lMW/peVxOcN0dL0KIG
         +gzg8OYz8Ul1e5gJaRkjZu3Yi2NoIdQTrDU6GOmPrGVjdUlhd6zyXNkUEvs4sR7YbQsP
         au3jW56GULsXRahrgT2Qara6nZMb6ttm5BE4ENsF7l0YEPVhvQbDH6mNOEyxPyzgxnTi
         usPgPWf+beyuLeYcIZnK1/AMnThlkgugHApfSyXS9dz0nbEwUrLTLU1Xlk/Hs7RUjiCg
         s5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU060KWu+BpkdMAX09mKCtBLdlGeoukmZoGUDxy4CoMj1Pl8YPCo8eRHhxzMzDQnBsDk6wL+Q37izKLqVVcHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1UZFOZSntG5upyigyykyBAEcAVfpBu3I4lOEs8q10xUIO7GZJ
	aZAIU89Yn5PvgV0lNIl2KotzieYC0s28ZCBnZf0qy55kvgIlDw5TcCmuAonvisapwDKOvrYcoZv
	CC0UoZn5QCtfix45MH/kKC5WtyKqFMVgTZ540bcN/G0uklhUBga5h8kLghLyGFWMSYUvE
X-Gm-Gg: ATEYQzwU89UpJkm9+Hp8NO6E8U2b9gGsKOpNjXMgdYpR+eyEIxDRx2n/itX8owMx067
	HGfW9WEc4D8xwouI7jluf6D0/WuqKGMCPqV3t675MYCwm/fmpuzpNvSPH0l+V7FK6sL9Dwz5Wx2
	KevqQtuASVm6BKAWrNUrKiM4G8Erp0K+sXd/FdUO2xX/N3zZmZDz2AoZtAM74Lf24UM7RxL22UQ
	K7fPRE8KanQ6Uu1tE6OE3dJzZ61o9Veb/kJpbTrY2K+V8l0T9RlC1aaVvs2b4Eyd/em9bYhc7f7
	c2qRJd31oR5dI6wSywYhXd4T7bjtDGbKhKCFGhJB4VbaHcG34v2U0kMbxiK300abFfkJWl9caeA
	tA//c1TJYwNyPqQmRPmk6JoHTx42kZQNwWS7h7SjQm6LjeQ==
X-Received: by 2002:a05:6512:1148:b0:5a1:4440:2c48 with SMTP id 2adb3069b0e04-5a162af145dmr4701581e87.12.1773667809856;
        Mon, 16 Mar 2026 06:30:09 -0700 (PDT)
X-Received: by 2002:a05:6512:1148:b0:5a1:4440:2c48 with SMTP id 2adb3069b0e04-5a162af145dmr4701557e87.12.1773667809250;
        Mon, 16 Mar 2026 06:30:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156162b82sm3488441e87.56.2026.03.16.06.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:30:08 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:30:04 -0400
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
Message-ID: <20260316092707-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
 <20260316063139-mutt-send-email-mst@kernel.org>
 <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5jaKEchFZJJSSJSbe4WFFjb0fT1_Rda9MoaMdagqRJQ_1773667810
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2026 at 12:57:00PM +0000, Zhud wrote:
> > On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > > > Thanks! Yes something to improve:
> > > >
> > > > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > > > > indicates the device supports dynamic control of guest offloads,
> > > > > it does not necessarily mean the device supports specific hardware GRO
> > features.
> > > > >
> > > > > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such
> > > > > as TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable,
> > > > > the device effectively lacks the hardware capability to perform GRO.
> > > >
> > > > So what is the user-visible problem this is trying to address?
> > >
> > > A key concern is that once a user enables NETIF_F_GRO_HW via ethtool,
> > > they might manually disable software GRO (ethtool -K eth0 gro off)
> > > assuming the hardware is now handling the aggregation.
> > 
> > Thanks!
> > Sorry could you be even more specific please?
> > Is this a theoretical concern or did some users encounter this?
> > Note that NETIF_F_GRO_HW is best effort anyway: e.g.
> > it can apply only to TCPv6 and v4 will still need software.
> 
> This might not be the best example, but I want to draw an analogy to show how
> this hardware offload capability can be misleading. For instance, if I enable GRO_HW
> expecting to see lower CPU usage when receiving packets, but it doesn't happen, that
> would be very confusing.

It still can happen if hardware does not offload the specific traffic,
yes?

> > > Secondly, while we haven't encountered a specific hardware failure
> > > yet, enabling a hardware offload feature that the DPU does not
> > > physically support introduces the risk of undefined hardware behavior
> > 
> > This would be a major concern but I don't get it - how would one trigger this?
> > It seems that guest_offloads_capable only includes offloads actually supported.
> 
> You're absolutely right. Upon rechecking the code, virtnet_set_features already ensures 
> that only bits within vi->guest_offloads_capable are sent to the device.
> Thank you for pointing that out.
> 
> > > > >
> > > > > So, making NETIF_F_GRO_HW conditional on these feature bits
> > > > > ensures the stack does not enable an unsupported hardware offload
> > configuration.
> > > >
> > > > I guess the assumption is that without this, something enables such
> > > > a config? Which stack is this and what happens then?
> > > >
> > >
> > > Sorry for the confusion, let me clarify the intent.
> > > The 'stack' here refers to the ethtool interface and the netset (ioctl/netlink) path.
> > 
> > 
> > A bit more detail about the specific set of commands that leads to confusion in the
> > commit log would be helpful.
> 
> > Thanks!
> > 
> > > >
> > > > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > > >
> > > > judging by this, has something to do with LRO?
> > > >
> > > > > ---
> > > > > /* v2 */
> > > > >   -make the modified logic clearer
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index
> > > > > 72d6a9c6a5a2..b233c99925e9 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > >  		dev->features |= NETIF_F_GRO_HW;
> > > > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > > > -		dev->hw_features |= NETIF_F_GRO_HW;
> > > > >
> > > > >  	dev->vlan_features = dev->features;
> > > > >  	dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> > > > NETDEV_XDP_ACT_REDIRECT |
> > > > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >  	}
> > > > >  	vi->guest_offloads_capable = vi->guest_offloads;
> > > > >
> > > > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> > > > > +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> > > > > +		dev->hw_features |= NETIF_F_GRO_HW;
> > > > > +
> > > > >  	rtnl_unlock();
> > > > >
> > > > >  	err = virtnet_cpu_notif_add(vi);
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > >
> > 
> 

