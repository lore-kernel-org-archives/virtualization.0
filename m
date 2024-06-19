Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7B5FBB1
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786100; cv=none; b=bjEogvptzNKeifAsStl0QqiMzdjqUKDSxlh86Q2geISLjEB7WoijlFuw+3D5WFSUb4XAuqUnsmCzL2NqrLTzouOS/+A0DLYLtIFtZy3WGIv6G77obr9rH7zlHKu5paW71aFUZgEj77DYZ/I49Uf1VAk4L1cVNMT0tOx3qvzIYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786100; c=relaxed/simple;
	bh=k77wwIYfk4GFZNw66tp4JkI39o9Zc0+HKnCadVtNoG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J6Vt5O3yQ8xWLkPStz0DN7CMrONQf0LIwVS0uA8QbEaR9gvbCO+xb5AEalAjzCOXuozi4TIRdC0A6Gy/w6yRVYroVH5yddJb8MsiRg/LkXPrTPdNvlfuRGUzxn4XC5/vwzjUCRd/GEfzCMa+Dkv6DhobApHM8zxJXx8iZ7jJ1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa/f/iHJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa/f/iHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718786097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QorzhMTdYqM8xg9nGlxbgOsetEP7RIhSroBgawoQok=;
	b=Fa/f/iHJ/jKiLFkKwA2QphJdam9yApWyziEoZyPMfmjZXmlgeEH3zq6LE7t8EV3IdQDz67
	nXxwFoK0E6GvZIq1E+EzvquL4AIteMH7qwAJs+iuET16dLJZC92nlvoFb/YBzAllciaf+v
	jJ9l9QK87gpngZZBRcaQ8H8uLegvUpI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-l7nmKMT3OMGWMduuyWBlQg-1; Wed, 19 Jun 2024 04:34:55 -0400
X-MC-Unique: l7nmKMT3OMGWMduuyWBlQg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ec308d6f53so21249921fa.0
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 01:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718786093; x=1719390893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QorzhMTdYqM8xg9nGlxbgOsetEP7RIhSroBgawoQok=;
        b=bDwj72jlUvx4/al96XaKWetR6Tr0qN0XkLjbRED5+LRizSeRXCrn7FI+aOTzkVJznC
         M3ajhmaz80+oDDhdH5wzkbK/Pr9YOCHy/xpGbFalZQrRLwCdRYn8Vs5WG7DcajjyXVKR
         az/w8ZUWs4P7te3BYu9Y5KXl+ttRLYaLH4Hi5br3lLWauhgD1/OKoI/6MrKLzd5TGaX8
         u3/FqInrSPmm+U/VNm8bOJB1w+UI2ec1BB6gBd7LTEjOaVRzGcMtY2JNkBTDcM1faabO
         P+DMYcTzuuZhs8DjPlHihfzg5ZOTeG2ZLzL5ZdF8eXlQbO4fd5nKpBFazxDnM+zGpv7O
         NrAw==
X-Forwarded-Encrypted: i=1; AJvYcCUD1MnXlicWxJqY867U8JXPlIjNne90CwpWyvwTnJMn01oL+s9GpPKkhDtEjTABygLkFaDIw36Tt+pmUOmEO77h3Ac5PrD1xNvhqyazfdY=
X-Gm-Message-State: AOJu0Yw0GeMz+CQsGRS7FyUXLjfQNOB9ueYqR41qxB4D0LDCeNyCAXlW
	pDOSLfTIyNziUAIFSlAFMtafSEdcv1fwU2Sh9Ab2XtR1YbWbFeGeDd33uyZE5Aav32vQWI6TIw4
	nSPFBY0O9Ox1M0F3bG3JMEQdMwL/RCyD/cX3uJqZVW9+uu3HZ6P4J5yud8Vq6jyCU+9dhWapT
X-Received: by 2002:a2e:2c13:0:b0:2ea:e204:afc2 with SMTP id 38308e7fff4ca-2ec3ceb71ffmr13854621fa.12.1718786092664;
        Wed, 19 Jun 2024 01:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6dGM5Ja1VGAOzdN1hQxZfOXjSTyTvg4DIiNH2Kw0m4EIQmBe70gslkXkc0676k76zPfXPTA==
X-Received: by 2002:a2e:2c13:0:b0:2ea:e204:afc2 with SMTP id 38308e7fff4ca-2ec3ceb71ffmr13854371fa.12.1718786092175;
        Wed, 19 Jun 2024 01:34:52 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm259166805e9.28.2024.06.19.01.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:34:51 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:34:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <20240619043442-mutt-send-email-mst@kernel.org>
References: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 10:55:29AM +0800, Li RongQing wrote:
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d1..b669e73 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	struct dim_sample cur_sample = {};
> +	unsigned int start;
>  
>  	if (!rq->packets_in_napi)
>  		return;
>  
> -	u64_stats_update_begin(&rq->stats.syncp);
> -	dim_update_sample(rq->calls,
> -			  u64_stats_read(&rq->stats.packets),
> -			  u64_stats_read(&rq->stats.bytes),
> -			  &cur_sample);
> -	u64_stats_update_end(&rq->stats.syncp);
> +	do {
> +		start = u64_stats_fetch_begin(&rq->stats.syncp);
> +		dim_update_sample(rq->calls,
> +				u64_stats_read(&rq->stats.packets),
> +				u64_stats_read(&rq->stats.bytes),
> +				&cur_sample);
> +	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
>  
>  	net_dim(&rq->dim, cur_sample);
>  	rq->packets_in_napi = 0;
> -- 
> 2.9.4

