Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6401B808
	for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FELBSo09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705357961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eP0VxXSEEil+R0UNdZpa6aVY75gYpHAxm/3u1ydWXpo=;
	b=FELBSo09L99R2t+b1/Yy+GN+JQLgwLiI77figvm8glkp+kmdVYHX45wYqEsvIbN3Jx2LHU
	DQqVjxcB2FzTTs7H5RDxOH9B4Ww/UBTNyxYIPuG/aplkObRwBcbPSR5GpW3QXANoOQTt/Y
	6odZf8Y3MyytZIZLUEKatSA2f8WfpY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-tQra235PM7GKpzQT2k-pNA-1; Mon, 15 Jan 2024 17:32:27 -0500
X-MC-Unique: tQra235PM7GKpzQT2k-pNA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e6d2dbd63so20745205e9.2
        for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 14:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705357946; x=1705962746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP0VxXSEEil+R0UNdZpa6aVY75gYpHAxm/3u1ydWXpo=;
        b=t+Y4dV4/YPSHdO48QeuZ1Zh3oJuyzB7+v1eNkdGtTwQWuc7rJc0Ke4GKka2eYIOrZ9
         GQ5hQfq4p5sWFpjwDzw8ATyJmTLh9WUActySxapcrJcgwagFizVrAmi1Z49VuoWzr2Q0
         biSVXw8xBS6HECDVIwUkP4EW5UXHmpTWTasTPTY40NO4IV6oG/fk8Zl0GkxvD7XF37Qd
         g/B2L7PTKXyh7Y2qp4s8HBVPdAaeoxv2LmMrwF1a9iVmdCXwtVbE+p8XHVbnk/8VC6YY
         JKMP/rSPr98FnrOIbjS+CEuYMY9Ra6CEdv9KHwzMqSW6ncxGMDsrbj8EIe8j03iqwv5N
         nh7g==
X-Gm-Message-State: AOJu0YzEE2944NZLWKZxwhAbLIKU336ZgHZGGBLasftWQziOOn2abkYD
	03g39gb+CfXCRRKAAIuT1RSxE2O0qtMkGUnlXNgg3oU2/ztdDowDQ/XLBVpkmJfCGYvTWSAOq3r
	+dGB/1eyFxYzCGfuewTYqPLtjGRt/8PABi/0=
X-Received: by 2002:a05:600c:4a9b:b0:40e:57f2:5948 with SMTP id b27-20020a05600c4a9b00b0040e57f25948mr2946994wmp.72.1705357946071;
        Mon, 15 Jan 2024 14:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkeJKqYDhM/whQk/nCZZw+VXl4wzetnaox4MjVkcLxDiSEjq0eYyRMgzXTkyhuF5WMBxlqJQ==
X-Received: by 2002:a05:600c:4a9b:b0:40e:57f2:5948 with SMTP id b27-20020a05600c4a9b00b0040e57f25948mr2946992wmp.72.1705357945790;
        Mon, 15 Jan 2024 14:32:25 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe948000000b00336710ddea0sm12980913wrn.59.2024.01.15.14.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 14:32:25 -0800 (PST)
Date: Mon, 15 Jan 2024 17:32:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
Message-ID: <20240115172837-mutt-send-email-mst@kernel.org>
References: <20240115194840.1183077-1-andrew@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240115194840.1183077-1-andrew@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
> 
> Qemu options:
>   -netdev tap,vhost=on,vnet_hdr=off,...
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  	hdr = buf;
>  	gso = &hdr->gso;
>  
> +	if (!sock_hlen)
> +		memset(buf, 0, pad);
> +
>  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>  	    vhost16_to_cpu(vq, gso->csum_start) +
>  	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >


Hmm need to analyse it to make sure there are no cases where we leak
some data to guest here in case where sock_hlen is set ...
> -- 
> 2.43.0

