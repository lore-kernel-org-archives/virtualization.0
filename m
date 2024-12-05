Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583E2F56
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394851; cv=none; b=ExmDeASq2UluTp5UAyQygSxj85i0CrsDWzTe76DcCF5pHrB7bX3i+KOe4fFwCGTexiwLsjwQmILYIKI/kVtcFmXr2oUXJL5CEjLoRJ7wMvSOk7zQMVdUFoGc65bnucEcygOmA2QkEHgIwiy0WJ/GFCKLMEsKchAhsg/OwsBiGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394851; c=relaxed/simple;
	bh=4iSivaet3eWbcYQfu+va8eySU1IR4UGuLLebIGaqXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B7/QlTXwXVQhqBQRsbh4eRy6BqMfiM/UAB7IJRVCS1WvuK+Lukm12k4I/sydAtuZjy562TO2OMqz5Q2aZxC3GZad2u1XujiE84E15To6qgy2QaFJuJrkPHC0eFahH+LAjdG2xQ+eu5bf04xUdpS+09EGGp5q3h4b0nfqz/+ymPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLVFVg+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLVFVg+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733394848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
	b=hLVFVg+BOVMljeoA00eQgysoxre3Uowf1+7ZiHJOcRKgFmpxqO+bf+ccNyvVA5MUKZTbK2
	UEHdDE4K1sY/c6fnqA1HYY39mVmwuTf+d1wuXVGtj4Yv2EuU9l9RjweThJr93Z3Y/af2UP
	kHhgc/kZvaAIUIP1tIu3Ebzh+W+Tp4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Kg5ptFDGPyeVfU_KCokixg-1; Thu, 05 Dec 2024 05:34:06 -0500
X-MC-Unique: Kg5ptFDGPyeVfU_KCokixg-1
X-Mimecast-MFC-AGG-ID: Kg5ptFDGPyeVfU_KCokixg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e49efd59so309343f8f.0
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 02:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394846; x=1733999646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDeeDy80KRfvjt8kuE4hEk8FzYVKJ9eiZDXqXeHcTmI=;
        b=XF78wTpdUDpLLNxtigMiIw2n5KoOteUvTG1R07VzJyncMTZX7doh0q3mu/usCSjKpD
         D7jxh3dNHMH6iGOibKJYxiP8KuMUbqaOn3vf6kM/4InsuhoiuW3TSA345bzQz7zS3DSB
         CLgalcQ5whUD9Y8XjqvPbA60/FjC/lqr1Oyxk6ORQEaTlInKP9oBgG1TNm0e31yaeZc7
         vzWVxmfmqcx1kFPyxj2whgwvHsaBphqBqHhRt+BJxYYEHhrMe0I1Kz4BKBBKHz+qmhnj
         3Kc4l8ozf5Qc0jkRn5q4OROfyOIjv5tw4CEzN2qnhpExho84ha078JIZ9PyWYQZIKMHn
         ebaA==
X-Gm-Message-State: AOJu0YwAbpQV0z8F+LkC/jBI/wKJ8vb9uINxNWBCePXbEOpzTRTKSyUd
	AIYu0MmZIRFCh0RK5Pj1Vlf51x5Y4ioh3fwDr1em0r7D+JtMBEmbudRXVRfdflJ1TBoQ9jQWcrj
	cPSjip0L8zjLVJ1BQPym/Uzl4VjktAEK7WNRKZF9q2qvol6i291I6snm1EWnf8u6+
X-Gm-Gg: ASbGncswWCatUVu8+dmJIpQ9vx7XlTJE1FC8CFThXG/EkLp5wVYKg1ygzFguDvEVWTc
	fIK9KnHbAue7UJMACxD+6iIZYBM26lRXkZWVB4h5Oo2vTiKAvp2UasRFrTaDWTskUk505uclP22
	KoefU49iU9g2sm9mT0oRkxOKKbz1SSv1K8hBPtBzpXcHpDnaNiRmoU05JuSnFN5hESOMLjNtczC
	kz0JLDXVWbAaBmHvAg68+KlVEoLvVyJywY7x4A=
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027392f8f.23.1733394845858;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJNPFWgvbSY2I3/I8jqi8rh7xZnIPunyw/bGll0UrDgSSCV6D1wzgUrHuDPt3xOF7WivnpAg==
X-Received: by 2002:a05:6000:1a88:b0:385:e30a:3945 with SMTP id ffacd0b85a97d-385fd3e9cafmr8027369f8f.23.1733394845539;
        Thu, 05 Dec 2024 02:34:05 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909952sm1556182f8f.69.2024.12.05.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:34:04 -0800 (PST)
Date: Thu, 5 Dec 2024 05:34:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
Message-ID: <20241205053355-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-3-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qs6JFcnrO357YPc2uy3RdwJs3v2AUZZt42_z4Ro0REs_1733394846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2024 at 02:07:19PM +0900, Koichiro Den wrote:
> While not harmful, using vq2rxq where it's always sq appears odd.
> Replace it with the more appropriate vq2txq for clarity and correctness.
> 
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 48ce8b3881b6..1b7a85e75e14 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
>  	struct send_queue *sq;
> -	int i = vq2rxq(vq);
> +	int i = vq2txq(vq);
>  
>  	sq = &vi->sq[i];
>  
> -- 
> 2.43.0

