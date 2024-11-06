Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76EA1DAC95
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886136; cv=none; b=YIQ+T7WjBDGwf47pNXzE8+yG98nSq/4q5aQHLfMILQTxk4AEiLm29tLry+NWh6CjuuE+dbXFkquAqP7cRgzMvH7G/HU0jfGsnn0Gz1NG0mOXOsNzqdLsmwsH9SgfN13E+BTPckO2YPpCTaaMmJJowXzXAia+8bkYNtYdpD4FtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886136; c=relaxed/simple;
	bh=eJnazqtfisg5f/3fPRDD9Fy2ZdH6bfCsFKpXlRHSPn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uoB3ONVR+f9xJ4qreVMOI06QsJdFy883XDOmOjozJh1Y6DilxRV5g9y/QPQvbsj12LLiRkY+ItRk2n9pbcaMDAjLdNJ2wI0vTtLxc6S4IT3rTKxx7vgRxhWm0JPFnvdkH5K9aKoJGJeHI94Urot6Xr3N8Ab3r+sB8QHl4/H/xnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3EdJX3V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3EdJX3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730886133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTb9RMAx8DKPix4c+Y4T2Jp1EEKIyizogKHRWnrW5Hk=;
	b=I3EdJX3VRKbqsOGFILTKQ/hy/HpkLXOgQvlk3LQWMrBgXwyV8nn1j7VjuUsSm4+I70kn7k
	9wByKYDdf1M4ib6gp5E5E7DXER0lnq1XAXwqEIyEXxu+4cZzrfA5jkRv3K1d1ZYo0ez7vB
	Wycl6nILvXxs1QndZksGKbEwuudpp30=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-HVNFap1gMzyuzrVBXP_f-w-1; Wed, 06 Nov 2024 04:42:10 -0500
X-MC-Unique: HVNFap1gMzyuzrVBXP_f-w-1
X-Mimecast-MFC-AGG-ID: HVNFap1gMzyuzrVBXP_f-w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-381e8cf69a6so334711f8f.1
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 01:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886130; x=1731490930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTb9RMAx8DKPix4c+Y4T2Jp1EEKIyizogKHRWnrW5Hk=;
        b=QCXYR9htk7RM99vcfG2HCU9wOwGRlW/JPKAfUm436j2QOudVXf8Mhypk8hxG8cbxFR
         WQK8fd5ZBo3x66qveHDdGfugKCS+Cp/v4ZRhzT5RE0vMCJjOGvNXVqtd5i0RdobgFlNa
         3hGgcvMSQtEv1gADRJxpjidwkqRZ3UrPasLemylVGxE5uU4AAcb0MEWacbEWVWd0G6U0
         A+/FRQZYT1e3rtFKCasXE7vnqM86vpyJ+1d1lSw5qZhuKT5nGVS0+NzXyKBHon/M4h8e
         ndQd1lUm14BjA2Ij+kt9tnqgWNdItyS8je07MGNBxv6uy9M//oLooDpsaBSVkuBRDkkg
         dfdg==
X-Forwarded-Encrypted: i=1; AJvYcCX1uHWEE/1hADkrb8bB9LFs4sYeX61NwFUzZ7Y+f4+FL5StNwpEWTnWFViJAA+O3xFxnmxFw+7zGGEDGj7GhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG0l/HH1J6ifANNzjWj34qyD4x6l4RqbZ/UOHMRnP8RR1BaXqd
	6zPnUaJcbOys54zz8QfZ4YwEYqHZudPiXihRfl4tkTCClyL+yx76Bgg/WlD33J1rsO71TLQ/iSs
	M7HRWOexi/8+43cVC5a85FtwGbWp/RIRu7pINNqiHqaaZCbViZO1x5dVBcLC7rOAX
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr16648315f8f.42.1730886129717;
        Wed, 06 Nov 2024 01:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhiTlCs5X+WxmoKrn9dj4wmjNiR44pmWH55V8O3pKkQuJK0IIZ3ybymz5MvkgSK1/I1NWjag==
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381c7aa4a56mr16648281f8f.42.1730886129342;
        Wed, 06 Nov 2024 01:42:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a7a6sm18566549f8f.92.2024.11.06.01.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:42:08 -0800 (PST)
Date: Wed, 6 Nov 2024 04:42:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <20241106044145-mutt-send-email-mst@kernel.org>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wJFTWkKLeY-9IgzEncjJ0VlFVM4KSl34mLwfi86UJrA_1730886130
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 04:36:04AM -0500, Hyunwoo Kim wrote:
> When hvs is released, there is a possibility that vsk->trans may not
> be initialized to NULL, which could lead to a dangling pointer.
> This issue is resolved by initializing vsk->trans to NULL.
> 
> Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> v1 -> v2: Add fixes and cc tags
> ---
>  net/vmw_vsock/hyperv_transport.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index e2157e387217..56c232cf5b0f 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
>  		vmbus_hvsock_device_unregister(chan);
>  
>  	kfree(hvs);
> +	vsk->trans = NULL;
>  }
>  
>  static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
> -- 
> 2.34.1

