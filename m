Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE63BA24C
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749071; cv=none; b=oBMQ9rw1fsVvJNF+6MWFOMVUpz2K3BI1JEs9VRL6QH8ljkainNJTYL9Tv+ZiwVul1llPoSOsRaGfluVmhVal9lMC+lMcIaD5PbxcDgJi44fc7EBtaa3CLIl6cozoYzlxJq0qJvuO9u+j3mIwdlVq4n8Sr8anF7E+NIfFZJdESYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749071; c=relaxed/simple;
	bh=gXf7h6m3QFucjAyYb0Chs97a79d9hUiTRP/yW6fiHjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g/mS6OZ3jYNm77+aw3f1ba6CtZnOo67iQVQXa6llILVHsQW6jHNguVYEjwuQ5G2VQ9NVh44C8byGZ/gYzBUZkm04qHQOpBM4IAdSZBR2sGmMKwQzXCjN5Kiuao30cG7uHr0vjyZFDnu/1idZLrik3n0XmRgozPx1AhlvGV8Ou9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCOnod31; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCOnod31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773749066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OUPcuOst/Vgj50RX9iunVkzL2by2SSGoTL5fXS6O4A=;
	b=RCOnod31wRvMCYtb/6XGae1kyrW52PkWE/2FQHIr7OrpZ+RpHHZ7Kdmi03jE/oqQIx81kr
	h9XsCu6C/3uYcubV2Dgvx23C0xZreRolOjKM/CWaQ3EYIFdxwBvM4cN1xZpzCEvhHAaLtv
	qms2INdZ5VVdBLeLsgj5LT7ZTkSS6Vo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-FE-H5PdvOVeFAx8bGzdYjw-1; Tue, 17 Mar 2026 08:04:25 -0400
X-MC-Unique: FE-H5PdvOVeFAx8bGzdYjw-1
X-Mimecast-MFC-AGG-ID: FE-H5PdvOVeFAx8bGzdYjw_1773749064
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48539bda3dcso61055865e9.2
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 05:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773749064; x=1774353864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OUPcuOst/Vgj50RX9iunVkzL2by2SSGoTL5fXS6O4A=;
        b=YQGyVkQlt07FuSaC1gqyReEe1DwaKKqsRVdJa6MnIXiAmnF3nMJqMO6TE3D5n9qGdz
         Y3CcRyW2bH2xFJ7D7KYdHrmjsFOk95N+T5NEfzyhZfttJwqzNXpRitQe9zasHnFrDYCB
         3VvxBpbKKZCd97+NJbIqIC1leze8768VdlAK2FcShgpItZVWcLqGX0OZN4cSPPSCXz+O
         KDaLAypHEecFbTgM2/B8/pIQ0Hs5y55VD9lsYLSWwicJ5NvUivAkLj1RFArzV00QKk0q
         xYJfTQb4H+1gkql4a0xwyfbXAkXWvr+DYiGy+1t7IrGlrKa+Y20IekpIFDOFqTeqDENO
         UhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUief2hgSeYzzpAyrthvZZ/RjIfnEhqXO1zN5IZCoo82Wg6CMxqjp+Rnt8wgSf9HYlcn8SgNLeAkQkvabeTeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy8inaqSUUDb4uAOGSaTz0HR3qegUI60l+u27Kvt53x4F61I8j
	sgZTifNUj1lxl29t/hmtkxZT3jOH6+E7/sx9RZNUqbHJwm54MysUhOan98lDi+rAS2D7Kj09J4t
	veLXcIbnF4HTSQi7xygB0pYF9FgzAXBFd8kC9faxeuvz0ZZJkD8okPNQl+nqbhTPrMMGI
X-Gm-Gg: ATEYQzzcA7GjBsUhNxgXeBhkrp+3b2qA897oaCb4bhrgEdbeWiWoe/gOhYWW+EJFsuF
	8IO8eXYcedMtQWuPAxHWHor63KGl7HxsUXzQX4nlsYKvqkluj1RR2r6nuM0nSE2YjRbLrlc/iRY
	mZtbfXfvm/pRwAB6ZGePFnD4HTHNpLTVOtzWXpdty1devdtoTJPracS5loh9pDtiT8uwhcRkJrP
	n35AkfLff56u1pnhIR3c4kyLq5vt+12AhwNc8yObma2uSrLhoeEQa6l1dm9WPSlYcOE5GqUby2O
	69gEiW+bFNvI9SCryJhyfclfUJLwb1STNqTPqJwhDK8gNkAsarJtQTc3VzQwTRa00h295r3Wxix
	yIcQiA6Bo0YFO/im0dSjA7KpSA/ax6xIjtHtDbmhWAEJl1A==
X-Received: by 2002:a05:600c:1d0e:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4855671fac1mr306212725e9.25.1773749063431;
        Tue, 17 Mar 2026 05:04:23 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0e:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4855671fac1mr306211665e9.25.1773749062823;
        Tue, 17 Mar 2026 05:04:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm118112975e9.20.2026.03.17.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 05:04:22 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:04:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Di Zhu <zhud@hygon.cn>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	lijing@hygon.cn, yingzhiwei@hygon.cn,
	Philo Lu <lulie@linux.alibaba.com>, Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260317074739-mutt-send-email-mst@kernel.org>
References: <20260317113433.927022-1-zhud@hygon.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260317113433.927022-1-zhud@hygon.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lKy3bm5fyvIV_AWQzFV68Gcxk8w6NgqiZy45b31Jd3g_1773749064
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2026 at 07:34:33PM +0800, Di Zhu wrote:
> Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> allows control over offload support, but the offloads that can be
> controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> nor GUEST_TSO6 is supported).
> 
> In such a setup, reporting NETIF_F_GRO_HW as available for the device
> is too optimistic and misleading to the user.
> 
> Improve the situation by masking off NETIF_F_GRO_HW unless the device
> possesses actual GRO-related offload capabilities. Out of an abundance
> of caution, this does not change the current behaviour for hardware with
> just v6 or just v4 GRO: current interfaces do not allow distinguishing
> between v6/v4 GRO, so we can't expose them to userspace precisely.
> 
> Fixes: dbcf24d15388 ("virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO")
> Signed-off-by: Di Zhu <zhud@hygon.cn>
> ---
> /* v3 */
>   -Update Fixes tag to dbcf24d15388
>   -Refine commit message using Maintainer's "too optimistic" 
>     phrasing to clarify the risk of misleading configurations.
> 
> /* v2 */
>   -make the modified logic clearer
> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..b233c99925e9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
>  		dev->features |= NETIF_F_GRO_HW;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> -		dev->hw_features |= NETIF_F_GRO_HW;
>  
>  	dev->vlan_features = dev->features;
>  	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> +		dev->hw_features |= NETIF_F_GRO_HW;
> +

Hmm wait a second. Isn't this late? netdev registered, even link is
up already.

Documentation/networking/netdev-features.rst says:

 1. netdev->hw_features set contains features whose state may possibly
    be changed (enabled or disabled) for a particular device by user's
    request.  This set should be initialized in ndo_init callback and not
    changed later.



I'd say let's move it up?





Having said that, we already have a bug:

  dev->hw_features &= ~NETIF_F_RXHASH;                                                                                                   
is after register, too.

This is because we take pains to recover from these commands failing.
Except, we completely ignore that in virtnet_set_rxfh ...


Cc relevant contributors to maybe take a look at fixing all that.



>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> -- 
> 2.34.1
> 

