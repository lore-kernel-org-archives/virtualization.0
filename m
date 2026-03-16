Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC352F88
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652551; cv=none; b=umNzDqGgWJNwo5dinM1wrqLVSWUmg66bkszSoh3d7t5mwFJrVkLZ2vrcKDie1kqow1GOdOzuZDVT0wDtFsgiI9d1R6GNyGTik/T/7zpbNIQGJ/CLsRBzs3ntvuFzxpj9bEVMnKewsW2WKc+kPP/s8ZFvVSrb7e1UWivmBBJCSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652551; c=relaxed/simple;
	bh=O2SS18rlSUcdzi98lp2IyIdV6D0lACHf6IBFjWpTWwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RJlEooLpw6LyGabE26oCfNhnJGlJpbXKSuwxPlejCA8MOQQe9+q1MeVFBhunAXbPFgVcNhRgOOT4bHP/KCY9M1ABgsBYgFK+ED+LwiTZZSL+gk0ZCUvP9w9ObDKz5iCEKMCzpJLuaxTmLHqgEy5ko00AgE8jZ1LsMtz114Rc2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eo/OUQKE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo/OUQKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773652548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ep6TcvjqLGgLknc4tGkbaa/0WsAO+G7kPe/z8Cm1bsI=;
	b=Eo/OUQKEES2U3e1PzaZkVSs5eTKXpPQQn+eVmS8dwCdtBXUVa009JLcIM2ixOnRUjIQEyk
	ETWhSDsHS8otE3pqyd3DSKjR7nL1mWJpjCYX5GX7n9/y14KkVwAKZgOu4GkbQvuc7ZpTFw
	1WBGsBDawe1tVo1ceVNepSGs12yGg1o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-QiEzQ4ftOXS_yGK4_DnxjQ-1; Mon, 16 Mar 2026 05:15:47 -0400
X-MC-Unique: QiEzQ4ftOXS_yGK4_DnxjQ-1
X-Mimecast-MFC-AGG-ID: QiEzQ4ftOXS_yGK4_DnxjQ_1773652546
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439b3011be7so2924700f8f.1
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 02:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652546; x=1774257346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep6TcvjqLGgLknc4tGkbaa/0WsAO+G7kPe/z8Cm1bsI=;
        b=s0Ul5178EtpVi8jqqZx0k9sHzEfpPQPDG2d67rzrEEtv0lj7NYCh172ejdJefdjpOv
         tp5VvPnuSDffVte8LK6Ca0SC+uhFqDV1agRica7jumg9N8yHgl3b3tqlj8plkpYWwd6w
         WK9bWAurp5LGDeBiO/CwUPKF31xbKln7Kbgr7Z3IfpQluofBwHjN+umtAS0vyqD6O054
         GkRQPSCPu8DHxIMS1nH5M7Gzkq9XM0scQEwzloZJ12Ye6uHqVMNNupDe96PYp24sONxM
         pPDRLAxlQIg3IfdSlxaL2Uw5KzX7Dc7iV8vn5GPZm5ibR4Vfc8UlLynRFSkww5wCP1MO
         QeQA==
X-Forwarded-Encrypted: i=1; AJvYcCWVpgaSNoyIb5uF3zb1W8AfuGSOq+L7KLuC/fls/AB5Di1F7RR8QungEPKw+CwwqKFuP9iVUNOzu+91/oWqXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5ZZflvTl88fr2T9IRqfj3OMfGaQka/Ho0/HsO6gLAMlbRR7nA
	7t/ZDcTjwAyxnu/D7Zlu6lF+OhrNGZ+zKAkb+BLXOqISRZ4fMrWefsBfyPPHmDlrLGgRPrYAQlD
	4wmnvZNLe66ix3gSByvG/RAj21Jye5VEXjf3e0wYqtq0P1LBAN8dqDD4GFF2IIJR9Y+jm
X-Gm-Gg: ATEYQzzevZOWZ0dERCDebACYK4DX0TjesmpbaQRZvSIQd/M/8mZJBlrpMMaUE8PGXaz
	DVy+exy7AluX7nJu2Psg7+U76b2YxCZP6s0/TNN0my0GIbAkrdfiaGwShcxfpQGMLqxsWOudrUj
	1byqMagXAWnM8yQ+bj1P1XyLWK52WLZGTgy6KSJg/Vz3dggfiTx+nzqPGXv3YoowPD22ogNmbQp
	08tQ09BbMi+FckZNkJUwPxxsxkfaVc+rQpC1iKOUREJVjBVhmUrl4838n2hf+rKrGOzR2nZal64
	tAb70hgoxIFYgOZP/B8Mljf7CECxKj+ekExaCy4n0HOdqqHttY+v69KxW1kkfhFECNuE6txNHMH
	oe9xISCu+ABBJ1oXRkG1W/d+pmfSwo+Bcyik0p81xaVquow==
X-Received: by 2002:adf:f349:0:b0:43b:3b80:6781 with SMTP id ffacd0b85a97d-43b3b8068cfmr9071733f8f.49.1773652545932;
        Mon, 16 Mar 2026 02:15:45 -0700 (PDT)
X-Received: by 2002:adf:f349:0:b0:43b:3b80:6781 with SMTP id ffacd0b85a97d-43b3b8068cfmr9071675f8f.49.1773652545370;
        Mon, 16 Mar 2026 02:15:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe228986sm37539616f8f.35.2026.03.16.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:15:44 -0700 (PDT)
Date: Mon, 16 Mar 2026 05:15:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Di Zhu <zhud@hygon.cn>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	lijing@hygon.cn, yingzhiwei@hygon.cn
Subject: Re: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260316051327-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260316072152.910857-1-zhud@hygon.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ls88dsUlV0OyKA8fBS_DgieSSQJvfo0wLY6vPcK9wWY_1773652546
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks! Yes something to improve:

On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which indicates
> the device supports dynamic control of guest offloads, it does not
> necessarily mean the device supports specific hardware GRO features.
> 
> If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
> TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
> device effectively lacks the hardware capability to perform GRO.

So what is the user-visible problem this is trying to address?

> 
> So, making NETIF_F_GRO_HW conditional on these feature bits ensures the
> stack does not enable an unsupported hardware offload configuration.

I guess the assumption is that without this, something
enables such a config? Which stack is this and what happens then?



> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> Signed-off-by: Di Zhu <zhud@hygon.cn>

judging by this, has something to do with LRO?

> ---
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
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> -- 
> 2.34.1
> 

