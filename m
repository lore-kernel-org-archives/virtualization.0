Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EF17085C
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964344; cv=none; b=jC8ytXdI9mkge04G524Qc0ay+N9X2E5QzehP7xg9BO97KriIhFNDcu0oxn/mX0NC3T2D1v1x1q4Opnd1NHGOIMINQSydUk6uDMZ3q+d5iZaVCAJIDD3mSyOa3xCKtuGNJKpfo0gmPwEuxc7I0t1ITX/d6pUogkGzz6kORwAUUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964344; c=relaxed/simple;
	bh=z3gAn55zApKOXhbJtNNNEovU9DexZI97dZRk4B3iGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gz1+rOnk67cDnP7jHz5tF7yBRLKK9INdN8Edf1G6nl3IrApAkf3FRjzE1YpJyMrYIO7KmrCc748F49gGwpeojsPORRi6Dcmlq46QouYr0oGByC+iuRh5ucCONMm/l1PeGWkFPAqzy5JACWB7NUqY7uVb9c+OwQJ3mKEPy+MpCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TczNLnvp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TczNLnvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnCJbcIUTM3zZqZ+aUiydsQ8j5UTgLqfcktZXJnD8lk=;
	b=TczNLnvpXezsldWdjM3SNMHwVv5roK9GGL6etmf0LV5gQI2zWJDVPxxtEqvPsgRTQZw0sn
	dsOhJPBx3qT7iduHVaGaO0pkRN6iidPuTbz2qruOcF26YIh9hTPF49OyzAkLBx0/Cd81f/
	rMO9mJa66wx13dKllJzfGbt65Z7ii5M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Xn6LWphTPoqfj2o70n3NGg-1; Fri, 21 Jun 2024 06:05:39 -0400
X-MC-Unique: Xn6LWphTPoqfj2o70n3NGg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6f2af30793so84799366b.2
        for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 03:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718964337; x=1719569137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnCJbcIUTM3zZqZ+aUiydsQ8j5UTgLqfcktZXJnD8lk=;
        b=PWj/9oUExguDhyIAy/+UjhHQt+RgCtKHZyJcLTyesCqi/oLL+2BLqh48p0/RCzBNpe
         Z3NLqh7UrmFtmTuYDPXQKZiYrx5jJGlVzzRu7WC2zcFfNE/f3scMrKJCP0FXdbAb2Yop
         GC00+6sbNNy8wuZ1Yvi93HIWDP7ejlcQrg7tpU3qsZ46SS+NTiKUD2FMYck3lmzXUjG4
         LWgsGcZ44JaiUff/VDgPBlk/yaPmgGS4gddT0ZMlry/L4uy5NKMXlGqrYh5zycAE1V0L
         DSt+exUNL0q4P8xeMPJsvO4yOXlYaNVly169BF12YQzNoXF9Yi42prfz6b1zfvLRL+no
         tnAA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+LihhKta8SHkfhjXsVngretvhnQOHB1GPvtubbz13v3jbIlNFA7Tbq+921Bb29CCUI2whYgr+6Wqsz26gUkGcl9yoSq09CkE/ZQ4+hw=
X-Gm-Message-State: AOJu0YxmdeASnu8gTGmfn5t1mCRUdCv/fIvoc7BxGutQXcZkLVDDAAtE
	xHTLXUSS/5wIeMR36bUFEq1sEjb3DPaTg+vpxmTE9u9VSPzTnUgTlh4QovlsMLwsYEJu/sTVUj0
	+2nVtA4qmnoNEigLoJNGulHXJtqdG8WKGujVBlkQkSBqayoQ0p35jx95HTLtX4rNHgFHaNA0H
X-Received: by 2002:a17:906:a18e:b0:a6f:10aa:9c3f with SMTP id a640c23a62f3a-a6fab775251mr461428766b.54.1718964337316;
        Fri, 21 Jun 2024 03:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO5cXegLSptfUIvR3OJv9OpZDUQt7koZiNJsSmTOWfGjLZTf2IAb1PS5HCTKZXvuzaxXTsrQ==
X-Received: by 2002:a17:906:a18e:b0:a6f:10aa:9c3f with SMTP id a640c23a62f3a-a6fab775251mr461426666b.54.1718964336665;
        Fri, 21 Jun 2024 03:05:36 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549212sm66653166b.139.2024.06.21.03.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 03:05:36 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:05:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH][net-next,v2] virtio_net: Remove
 u64_stats_update_begin()/end() for stats fetch
Message-ID: <20240621060504-mutt-send-email-mst@kernel.org>
References: <20240621094552.53469-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240621094552.53469-1-lirongqing@baidu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2024 at 05:45:52PM +0800, Li RongQing wrote:
> This place is fetching the stats, u64_stats_update_begin()/end()
> should not be used, and the fetcher of stats is in the same context
> as the updater of the stats, so don't need any protection
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>


I like the added comment, makes things clearer.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d1..6604339 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2336,12 +2336,12 @@ static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue
>  	if (!rq->packets_in_napi)
>  		return;
>  
> -	u64_stats_update_begin(&rq->stats.syncp);
> +	/* Don't need protection when fetching stats, since fetcher and
> +	 * updater of the stats are in same context */
>  	dim_update_sample(rq->calls,
>  			  u64_stats_read(&rq->stats.packets),
>  			  u64_stats_read(&rq->stats.bytes),
>  			  &cur_sample);
> -	u64_stats_update_end(&rq->stats.syncp);
>  
>  	net_dim(&rq->dim, cur_sample);
>  	rq->packets_in_napi = 0;
> -- 
> 2.9.4

