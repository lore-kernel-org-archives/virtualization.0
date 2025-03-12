Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAE1CA9C
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762556; cv=none; b=N+Pvm5V7DznlS84c/PciClXfiZNVUCIXn44JPsigX3dyQGiwEHH6UezjGL0CErkjIb0MrMubKEeFu9f/3sOmW6tq6lZnTvtDYZ1lneDDkNKgipYIVH2W2jeUv9uqvMS8/+1IvBrRjxcplYUgzl3pqYQOmIIe6licfzNjz/1NrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762556; c=relaxed/simple;
	bh=mmZWO8rrKBhcxVobJcb1/dMSVYN+sIlK9Rb8Ecs/XBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aCvlqTLR9WKyqNtQhRo9W5vg6wBwLXpXTki6UKgKqDMNqJtA19W9d9nsqVLmRo9eJWKyz/w0UVZwSDpQnOiKwv/r6c+BqzbkT4tRCn7a1Eptg8oIxbK5NZVzph76vC1CQ9u6LS/7GD2wLg4jO1K+gcpW6eBE/weGDO1P8dk/5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP8LTRJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP8LTRJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
	b=UP8LTRJ8v85e7Eaju3OAjVCAXXvvjOp5V9F1TrGi8KdtSmprRB5Q7oGYfj+rhzyNjRNxOj
	pnKqPW2g5jGrI+2c16L8usdF6rJpKWBi4RZ+PVgIMrx7p9mUMdEYWvo9I8derGCH++Wgh6
	665Z6ZySXN8wWXpRFYFsmy/k4JBoBIg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-CyHwhbopMqu1OGmR08v8PA-1; Wed, 12 Mar 2025 02:55:52 -0400
X-MC-Unique: CyHwhbopMqu1OGmR08v8PA-1
X-Mimecast-MFC-AGG-ID: CyHwhbopMqu1OGmR08v8PA_1741762551
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912d5f6689so4013447f8f.1
        for <virtualization@lists.linux.dev>; Tue, 11 Mar 2025 23:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762551; x=1742367351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
        b=qhRUb71fk7q41KhJ7IRT5OMbLMZZk5VasAL7EiNZRX8MehOMUlJ5QuX9aWXl7zOj2h
         iJwX2djLornw/ccUjgfHPen/LE5QeO/9BaYLAzJKYij+GnTWB79i/hBC4Rg5yWz0JW/h
         1TCAMGwg4lnM1po50DLj+93rcYVYSxbMb8PfXDxAWycelSpDRcQ1WejfIF9xS17oxc8t
         J8R/YRVY98dzy7XBTQpIhkMRglPxfrLcLqltjd5Gjf1H8elczNP8omaDziVJIN4OSIPO
         ta6eAO6emyHRr75cB+hOggNm24xoZLnKxMCJAE7ybXsqfehoWS6aXiEn9oF1B0rak/OW
         0d/w==
X-Forwarded-Encrypted: i=1; AJvYcCWTy83dN8fDgyWqyldIuEtw1XQKa3UThRcO/7FzO7d7vZBOo1Y6E5NqFJBRrpw1EPyh0aZtAIIdsSTfXi5q0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiPvWPAwukovuDHfwsx1Pgvb/EgBxhQWujUx3N7mbinaHxygcP
	bfNaPNEFzeDJrUl0t4aSKlFW/Gslo39FdSO+3tBvYDjmsfiTxTfNFpAAmA9MkCcMtM5jmcSuof3
	dkM8e6LydpBnIVvOqRkxNbxNZ6Clmqeqpm8Pqdbs0FrWF9jEWVlcoBUQ5ixN6Yzz+
X-Gm-Gg: ASbGncujzLzfrI4tFrhxyVZUXds82HwO1wHYlr6RJlrfbXNrcTrXswShaNZh7nWfdbG
	2hbOOX8euTbW1OoHViCal7wU7GRpVHiWxC4wgBVGUVsE1KW1O7buPRbZ0vXg55sVBu9dO/vc7jL
	nmGw294DMKM6+0yJU5mU9+Uv9c1hAmLezSaFtWU+swlk104lu5Mg/tDtDixbCFIHQdWwElNC/p2
	iVpIJdxzqBYnPojZZQ/puWTIS0Z9AwoLzP3zV4VyN9EtM5wfXSnm8CV8ziHMYHAb4c1k/1udcXe
	eCb7/kajRw==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005789f8f.5.1741762551530;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDerobH2f/muGrjnyAjilHqba0+0kowFg3s8AIPcyJb001SG0K4ObuoiA+X/VxHvC5d0rDfQ==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005774f8f.5.1741762551189;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-394a8a5a304sm565705f8f.40.2025.03.11.23.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:55:50 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 2/5] virtio_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312025331-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-3-npache@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250312000700.184573-3-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SJMYBjED9-2iX7LfWQvlyAx8XuHyXjz_jFWu13BcwE4_1741762551
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2025 at 06:06:57PM -0600, Nico Pache wrote:
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the virtio balloon.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 89da052f4f68..406414dbb477 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -274,6 +274,8 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			VIRTIO_BALLOON_PAGES_PER_PAGE);
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  			adjust_managed_page_count(page, -1);


This means the counter is in virtio balloon page units, which
runs counter to the declared goal of making the interface
hypervisor-agnostic.


> @@ -324,6 +326,8 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		list_add(&page->lru, &pages);
>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			-VIRTIO_BALLOON_PAGES_PER_PAGE);


Same.

Thanks,

>  	}
>  
>  	num_freed_pages = vb->num_pfns;
> -- 
> 2.48.1

