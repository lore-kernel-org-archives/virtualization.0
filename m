Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64242A1BB
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416358; cv=none; b=qUB+nUhC9Vi4vydX009C2Kpdm9aKceXdlZ1Fb33uFV/yY53AzXJIxn/gbZLa846WPOjVgW6NA3fS/GQnSsVordGcJeZ9Gb179dg4yMBcuXgMfcR3TnWCDIod/4rKJ+1OGcR/ZfETHevM+bDiQDCfbaOPJ4amApeWo8qg1wCZXxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416358; c=relaxed/simple;
	bh=mM8kGZlDl8TmBQeU28EZPe8oMDuyPKjLgxjL7cZnPOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TkTRRpdPUn5iWrDwhA8PDTyh2qQWZmW/a69H8xcLND/W+g9x7MkhMZfih/IyjLOq89dpGKMx0syg/af2ZpKVqy6xjw7QUQGN/mfjxLft8AMaxB50dBqPE7Kyq0WTlPQSz8B0cbenYQDsZnVL/XdWzQzMVG+0miOCCUZac2SLxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDJqlr2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDJqlr2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RX7fwG5JMx7yJ1qmHsffkQfYEsGcSd79VTgyvVoGa6g=;
	b=CDJqlr2u0cnNw9Lau96Gb30Ve4t6m4xI5R04j+/VUpxZ5UwEoA31WDYVI8K8x3zWW/IQce
	BI1oOLr97ippB3agqvGPV5WepAzp1f7yeEmwRGe6fT0sOxkjZbrUvh+JI0X6AvTlHFgF6f
	i17PrPb6Mm6cB6Su3zCNgW5TCGaB20s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-fx-_m5FqOriGu13YNJmX7Q-1; Mon, 29 Apr 2024 14:45:54 -0400
X-MC-Unique: fx-_m5FqOriGu13YNJmX7Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417bf71efb4so25677435e9.0
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 11:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416353; x=1715021153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX7fwG5JMx7yJ1qmHsffkQfYEsGcSd79VTgyvVoGa6g=;
        b=KHNyav9S27cF8CDWBbGjcS4ypb+4L96rMeuqLb9k5Cwr22bz0FN6a1ExmImYg0HemG
         Y6E069efZvjzrzulRk/Q+NrbjRsgEkc0XjR4ipZRkkDxQQLXfltgnmRiCOZoZ6aOkgHa
         yXc4PjMAN1seBKg/MXdtpZQ1RPZaul9rsUV3etg/zmYyoLoGbz716oLdV78agwTX9Kdw
         F2EK2xGx4LuEx0CgglddVkRj2Y1RUnQSuMvfmFw3AFkoUe2wbeYXmiNoVbSvRSf0n1Ks
         yhl4NOuMNk2Nn8tdUT7X3mkjVcnPduJ6++bk4kMvbYQ9GLq6RRYO6d9mbInuyBwur66O
         vfsQ==
X-Gm-Message-State: AOJu0Yy6D8omYwkkdyusFLpc/H3/hOhSmVsf/pAfFFUxwdZdSFcbqm3I
	1a9GSgyibUjCGwUjCuiXRw0l/M29tGA/rvkCZxJatMq7uJIN+7VD/qWlAczDsyYpamNZhcZHTkH
	SYYTRptl+RJvPTlsLlKccx1FqlDdeF8288ZTyyshm9GEsVTbpFdoV/4YXYxQyXGx3
X-Received: by 2002:a05:600c:5103:b0:419:c9e1:70b8 with SMTP id o3-20020a05600c510300b00419c9e170b8mr453034wms.13.1714416352741;
        Mon, 29 Apr 2024 11:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9FVC/AcEk5XqomYInW9MvPVrZtDb+VuMkz75ffufEDns29bRVmX3KqOYvbkJBMce36oXIOw==
X-Received: by 2002:a05:600c:5103:b0:419:c9e1:70b8 with SMTP id o3-20020a05600c510300b00419c9e170b8mr453011wms.13.1714416352141;
        Mon, 29 Apr 2024 11:45:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00343d1d09550sm30195687wrp.60.2024.04.29.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:45:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:45:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 2/4] vhost: Drop variable last_avail_idx in
 vhost_get_vq_desc()
Message-ID: <20240429144522-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-3-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240429101400.617007-3-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 08:13:58PM +1000, Gavin Shan wrote:
> The local variable @last_avail_idx is equivalent to vq->last_avail_idx.
> So the code can be simplified a bit by dropping the local variable
> @last_avail_idx.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 7aa623117aab..b278c0333a66 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2524,7 +2524,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  {
>  	struct vring_desc desc;
>  	unsigned int i, head, found = 0;
> -	u16 last_avail_idx = vq->last_avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
>  
> @@ -2539,10 +2538,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  
>  	/* Grab the next descriptor number they're advertising, and increment
>  	 * the index we've seen. */
> -	if (unlikely(vhost_get_avail_head(vq, &ring_head, last_avail_idx))) {
> +	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
>  		vq_err(vq, "Failed to read head: idx %d address %p\n",
> -		       last_avail_idx,
> -		       &vq->avail->ring[last_avail_idx % vq->num]);
> +		       vq->last_avail_idx,
> +		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
>  		return -EFAULT;
>  	}

I don't see the big advantage and the line is long now.

>  
> -- 
> 2.44.0

