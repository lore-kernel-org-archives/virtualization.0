Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757610;
	b=KiZ4Qmk5jrzsCRJn2O63PuvDWanBszia8Y/oYqHntAF/xb31T957lCx3YnBJLKICoeBt
	 U7aWwPVP+C1KMD5dun1Gx/GEvVR/RzArt7vhFsn6QhjrzBAZ6yuE/I2mn//E7Yb+YWCTo
	 jkFT8JbXIFc37ubE4bVRVzGHmVPf2jy01J8PXH0LrWerKgZ0+/WPYhbyEbtWOUCa7ypjh
	 ZtSmkhGsqROIO97/ADIrME+mgB2V0LLzcalkI7diOiFOvxf8RrwE4mpAgjisenJd9lIKD
	 DWdbcDGkDf1Pt+L98n0Hl53WR2UNm2DqeFIlLMMkFFf3knOMdcmdA8Vsbmg3Lxk9x2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757610;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=143hszKlCW7sBtVDn/0pbEhYSX5YyeOz7B9GvGu+YfE=;
	b=y0C2HpNUAzkxPO3hBFizk/iE9PsPwGLPmJ/MZJH+IkLd3urcUsomySJgH6ZYSTmrFiPU
	 OIHJ13fHt7koShVibku5zi4j88QomJEiVx3yg7IzUzKQEbZbxyhxqGNA5wjiYYblUCtze
	 HLfq/P4S4vF3hT6RqdeiwLaHTa/RJHpMrFNMQg8PhNnq1dfYZYZs4jmZ66pWZluSA/IMo
	 hqATzLVRgiQ0BnaWHYoVMXAQXpb7IVjkmrX+HcJZwFiKI3SoGzPCKUE29QTLe5jBG5rRA
	 eergy2gAzpOKPbLsUCkjOg+RcxUigzC3GnvHXStXdV+l++/5uCMrjkWrKRMNds5OY8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn+8XzFH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32EC606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A32EC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn+8XzFH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792757608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=143hszKlCW7sBtVDn/0pbEhYSX5YyeOz7B9GvGu+YfE=;
	b=Jn+8XzFHfBr3lC1v5DLvBNlSKy0/PeStp2HZBEfolnzfY7oRkWKbshH3JFb1qnyiMtCgbD
	YU+K8t4hCzBQxYfaQ6Qq3yO26GxAjzNivSI3QDhTdYXkZqyxL1EnanNs1Y7GAkQOwmcv33
	AwXj6onqyLwGrv1tBYW67BAlAAmaggE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-IsIO7ZZBPkCryVyCS4gzLQ-1; Fri, 23 Oct 2026 08:13:27 -0400
X-MC-Unique: IsIO7ZZBPkCryVyCS4gzLQ-1
X-Mimecast-MFC-AGG-ID: IsIO7ZZBPkCryVyCS4gzLQ_1792757606
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a21053899aso5039065e9.3
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 05:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757606; x=1793362406;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=143hszKlCW7sBtVDn/0pbEhYSX5YyeOz7B9GvGu+YfE=;
        b=sLOheHBq2yCkQ3e/xdcSftE/1LuUoZTE19cR+/xjALubaK/KzpFuevgYq/1SgUMxrf
         IUKwesSWYFydxlimoPsUo9Kln6rFmxIZOQz5F9mjA6bsefLFVuIAGlzqaPw3EQp5iPhF
         E74pSrWAivz3AsY23eSzq04ahknSHoZm9u+TFwODTHcWeLGk+LnTrPdgaxmaz+EcHdi5
         P+xZj8d6CfdkYZqIj5Xit6EdZivEejaONffeNgi1cje5zkxqgl77D6PFVLs4q1T4C8nq
         W+qOQ4diWcslzdxwTK/ABBkHwlYRU6M/9uODOA4u4rCFZy2cNtV1gf8sHUO0QFxXR0n+
         eI2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxJAQqDYqSWuVLsXTEgAjpM6Li+XOWT66S8Gnpxx+TntTfYkm6e1gyOb6K7mEdEGGmtZJpAjGl2rfn6WZiC3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJs9LPEVmwBMoNY2TE9lSMgT+zlRFxaCT4GTSmdcpl0dkV1kYZq
	R0wwU00jM8m12JXsfwBh8pYh6jjFGaMxspDUoa8MCD53WLG1D/yPFmym1dkMnRqZwnYDB2+NPZw
	MRUkkPGHOmHOBxBc8cWq/5gfCXBPEDovUGTa7pKOZqodg4b8dVrO36u1Ut9y6OiKsZSwE
X-Gm-Gg: AYBFou21UdrNkITe8C6/f3n7lHR2htBTHOdho0KFIZres6dG7v7KB7d7q25OQBcH09/
	8hysBEYbaJmadJs5p2iP0kNWUtc2oyWZTUJI/mIzOX0frIzPUgdKT4aFfUGegHOhAxU06E25vlx
	MQmiR/Lt8xcbg8swaBs+/gj+VtPDD1j7qOodJSpdDoHytx/hn5SwOYd8qN+e7lAvkHYJmIsfjoG
	4K/HFwKe+igOP0145xW52JVe17t0umLwVV/uRuNqk6xdAFIm7pNp7MqhBOw6s/rpfuER2iD8nYu
	4qhaLDwK2m8aL5gAiYYMAVssVuxbPJU8IkCaFnvkMY7L/XTHQZXvEuCDXad44Qb0aqp/xCY=
X-Received: by 2002:a05:600c:1c04:b0:4a2:a9:ed56 with SMTP id 5b1f17b1804b1-4a211edfd39mr44050795e9.8.1792757605808;
        Fri, 23 Oct 2026 05:13:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1c04:b0:4a2:a9:ed56 with SMTP id 5b1f17b1804b1-4a211edfd39mr44050245e9.8.1792757605196;
        Fri, 23 Oct 2026 05:13:25 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2958bf25dsm1862675e9.2.2026.10.23.05.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:13:24 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:13:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Message-ID: <20261023080824-mutt-send-email-mst@kernel.org>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9oB59DCe8rlLFk_LSjX_SP72htH-MbAasEt-6SmnBs8_1792757606
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 23, 2026 at 07:37:20PM +0800, Guikun Yang wrote:
> When VHOST_NET_F_VIRTIO_NET_HDR is negotiated, handle_rx() builds the
> virtio-net header itself and writes it into the guest buffer.  Since
> commit bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
> vhost_net_set_features() raises vhost_hlen to
> sizeof(struct virtio_net_hdr_v1_hash_tunnel) as soon as one of the UDP
> tunnel GSO features is enabled, but handle_rx() still copies only
> sizeof(struct virtio_net_hdr) (10 bytes) and then writes num_buffers at
> offset 10.
> 
> The remaining 12 bytes of the 24 byte header (hash_value_lo,
> hash_value_hi, hash_report, padding, outer_th_offset and
> inner_nh_offset) are therefore never initialized, and the guest sees
> whatever its RX buffer contained before in fields whose layout the
> negotiated feature set defines.
> 
> Reproduced on 7.3.0-rc7 with a userspace vhost-net "guest" that fills its
> RX buffer with 0xaa and negotiates VHOST_NET_F_VIRTIO_NET_HDR,
> VIRTIO_F_VERSION_1 and VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: offsets 0..9
> hold the vnet header, num_buffers is at 10..11, the payload correctly
> starts at offset 24, and offsets 12..23 still contain 0xaa.  Without the
> tunnel features the payload starts at offset 12 and nothing is left
> uninitialized.
> 
> Copy the whole vhost_hlen out of a zero initialized header of the
> largest layout, and rewind the iterator so that num_buffers keeps its
> position right after the legacy header.
> 
> Fixes: bbca931fce26 ("vhost/net: enable gso over UDP tunnel support.")
> Signed-off-by: Guikun Yang <yangguikun19@qq.com>


Which backend did you use? Sounds like you did not set
TUN_VNET_TNL_SIZE or did not set TUNSETOFFLOAD?
That's the issue then.


> ---
>  drivers/vhost/net.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1161,9 +1161,15 @@ static void handle_rx(struct vhost_net *net)
>  		.msg_controllen = 0,
>  		.msg_flags = MSG_DONTWAIT,
>  	};
> -	struct virtio_net_hdr hdr = {
> -		.flags = 0,
> -		.gso_type = VIRTIO_NET_HDR_GSO_NONE
> +	/*
> +	 * The negotiated header is struct virtio_net_hdr when only the legacy
> +	 * layout is used, but struct virtio_net_hdr_v1_hash_tunnel (or the
> +	 * v1/v1_hash layouts) when the corresponding features are enabled:
> +	 * size it for the largest layout and let vhost_hlen select how much
> +	 * of it is sent.
> +	 */
> +	struct virtio_net_hdr_v1_hash_tunnel hdr = {
> +		.hash_hdr.hdr.gso_type = VIRTIO_NET_HDR_GSO_NONE,
>  	};
>  	size_t total_len = 0;
>  	int err, mergeable;
> @@ -1260,17 +1266,26 @@ static void handle_rx(struct vhost_net *net)
>  		}
>  		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
>  		if (unlikely(vhost_hlen)) {
> -			if (copy_to_iter(&hdr, sizeof(hdr),
> -					 &fixup) != sizeof(hdr)) {
> +			/*
> +			 * vhost_hlen is never larger than the header above.
> +			 * Copy all of it: the fields vhost does not provide
> +			 * (hash and UDP tunnel information) have to be zeroed
> +			 * instead of being left with the previous content of
> +			 * the guest buffer.
> +			 */
> +			if (copy_to_iter(&hdr, vhost_hlen, &fixup) != vhost_hlen) {
>  				vq_err(vq, "Unable to write vnet_hdr "
>  				       "at addr %p\n", vq->iov->iov_base);
>  				goto out;
>  			}
> +			/* num_buffers follows the legacy header */
> +			iov_iter_revert(&fixup,
> +					vhost_hlen - sizeof(struct virtio_net_hdr));
>  		} else {
>  			/* Header came from socket; we'll need to patch
>  			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
>  			 */
> -			iov_iter_advance(&fixup, sizeof(hdr));
> +			iov_iter_advance(&fixup, sizeof(struct virtio_net_hdr));
>  		}
>  		/* TODO: Should check and handle checksum. */
>  
> --
> 2.39.5

