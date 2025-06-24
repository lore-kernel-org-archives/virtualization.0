Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0811283FC2
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760283; cv=none; b=Bj7ShY4W844VtPW3EbOeqAv40lAWG4bl/IZkSoEaz5Huj4YSYH9SvakJ7u+SR2webHUn58F9RY2phxkI0Ulw+aFAzsGPHA/OdGbHeZlU4RTJ2poBoJPwAeJGoJ2NSdIBNu/jI0uGctsAwM0f50aibXlTD19kpipmQvaZ92SusXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760283; c=relaxed/simple;
	bh=yxsot7li7aWDbMpJ2M7l364+PdHRsIkunx/znJIFHqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJe3mWUEduL3CCrt1kVnqcOc/8NvszDZV9Y8Qt7xrv0ONjNfA2JshV84TALsc6rdkTsziD6Bs4iuI1oj2aHOgPGk4+bTcEq+asfiY6eVw3HK1FzjnNk+DoxHeezPqU9+0tg+ACaYIy7tkNJIFhqvD8r8b1+6gjmcXNCYZ7TWYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6uI/wFX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6uI/wFX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750760280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ln5HyZtk161hcYqwhzfMAZcN7gULO9uaQ38rDIrK1c=;
	b=L6uI/wFXj9kVuW5l9K1VJl94gNiWib0pOaGuuSx/Z2N6DVwQhg3kQoWKQ3pkNnxN3p1/hm
	oPWoDVEoTejaI3C6OXi5lU+LVyv/1OtUHThTInmHK+DJXu0PoYVrjVPKqdakwpo17Mdx67
	cRqvu1gSRckwwXxeu0BPOoxhuDoEucs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-9vLuifrtNaqe3U9H5fjSoQ-1; Tue, 24 Jun 2025 06:17:57 -0400
X-MC-Unique: 9vLuifrtNaqe3U9H5fjSoQ-1
X-Mimecast-MFC-AGG-ID: 9vLuifrtNaqe3U9H5fjSoQ_1750760276
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a578958000so1888290f8f.3
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 03:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760276; x=1751365076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ln5HyZtk161hcYqwhzfMAZcN7gULO9uaQ38rDIrK1c=;
        b=i+Rn/Xi35wvt2yMx1oX/5xrulUQd883mEzrm+vZY2HyVaJC+uz9zs/raAZY5RbF6xC
         UMMlKBXI0hhmX3XTQH90IBrdsUh71kwsDEuKCw7j97JoUPmuZSPUiW9gmKmR4Dtwo8XZ
         CSDE133f5+4ATBSOUr968PSFeW9XtJxLGjY70zWqGAy5oHwMuCGk10BaSn5XrYa/w2dv
         YSh5DxshhyvHcb+SYR4RjB3P5gWMdH2hVtnq074UC3HCxekBo/KnJhnRwQJ2QMsb5Tnz
         ygbg1+us3Q28p2xBpy9CN8MM5TfApQDj+3mGFBWkEEI6AaQXlsDrlwLFnI3VHiA0hzWi
         +2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUFkGdACTeODPIwrAAbfqv8nxHMFfJSySpTwwdkycVs86QY0c9pwp27IJIPiEpl0spyxmaEUtFmkbsnh9FMbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzW8KX7zMxNQiVWIASfSb36NTnN+7IsFLxm8MoxbHqgMXuGR4dh
	Jy0KL9RkEk+d3O2zzOVpuVI7TQoUnCmdsPVTgxHgXF59MSIty/nXx4m3STMofiJRZsKXOYbdIGZ
	VQDG8+PJDqB5fMFp5bQbx0x9ani6D+5woQBPIwMat3667gGBcj/fSe94PZHTAHvq5hqCl
X-Gm-Gg: ASbGncut15L1ZdbrBUTvLO+uNEnjt1XNQBL+n21QVDSo5pddAs3MbKXlZq8/zJI2JxY
	K9SQ+NZkzMU2DMHRj6ibEsW9O3DhquinX5JK7yn2qTGDRf3iX2TFHewMRTfI8aWAP29o2LXv4tG
	VfEg/ibOMpV/+TTWBRm6FxcO+0Hn8VlhHRSxxzjMlfkUutqiwlHs+nJjcWudikb2o6mwzcw/TF5
	1C7Q8RFRjETDfLtuzAGwW+t6hp+s7fxiZ16R5Vkb89abgF6vEePVIHGFchzGqBUtTb+mupAeE9x
	JTLuoxHkor2DN5aMXDIvmwaBN0wUBA==
X-Received: by 2002:a05:6000:2008:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a6d129da9fmr11398663f8f.19.1750760275754;
        Tue, 24 Jun 2025 03:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC4ngUxIcnD6ERbm/m/k7RkxkipdZ9Ie1YqBmuu6Vuw2RA4r/70TZrgIw6mV8PBPv7d8OamQ==
X-Received: by 2002:a05:6000:2008:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a6d129da9fmr11398635f8f.19.1750760275245;
        Tue, 24 Jun 2025 03:17:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97adf3sm169365045e9.8.2025.06.24.03.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:17:54 -0700 (PDT)
Message-ID: <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Date: Tue, 24 Jun 2025 12:17:53 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-3-minhquangbui99@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621144952.32469-3-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rxxo5R-h5c7NqR8hhlqr9WO61M2CRRFSsU1yXg-sQDQ_1750760276
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 4:49 PM, Bui Quang Minh wrote:
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1eb237cd5d0b..4e942ea1bfa3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>  		return NULL;
>  	}
>  
> -	xsk_buff_set_size(xdp, len);
> +	if (first_buf) {
> +		xsk_buff_set_size(xdp, len);
> +	} else {
> +		/* This is the same as xsk_buff_set_size but with the adjusted
> +		 * xdp->data.
> +		 */
> +		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> +		xdp->data -= vi->hdr_len;
> +		xdp->data_meta = xdp->data;
> +		xdp->data_end = xdp->data + len;
> +		xdp->flags = 0;
> +	}
> +
>  	xsk_buff_dma_sync_for_cpu(xdp);
>  
>  	return xdp;
> @@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>  			goto err;
>  		}
>  
> -		memcpy(buf, xdp->data - vi->hdr_len, len);
> +		memcpy(buf, xdp->data, len);
>  
>  		xsk_buff_free(xdp);
>  

I'm unsure if this change is in the right direction because it almost
open-code the existing xsk_buff_set_size() helper - any changes there
should be reflected here, too.

Also AFAICS xdp->data will now carry a different value, and I guess such
change is user-visible from the attached xdp program. The commit message
should at least mentions such fact.

Thanks,

Paolo

