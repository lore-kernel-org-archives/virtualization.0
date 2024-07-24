Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F373AC0F
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721824023; cv=none; b=PehiXGNJCln8RHZ84O7jhAm8Mze99PtbBqMfMdRBOLfXM7DHyX7qNEx6pE6tAOuNI/fvoJw7scTLhbXiHS6apXiO76URuxYrnvg4qZv+4sFdKZuMcy3/pzyRC8T5LxKqroiULF1Y9if4ToHLztYh81rKUEErHCOpDbbFkWkt1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721824023; c=relaxed/simple;
	bh=Y4wU2S1ZsGCeT+rz7ToDIHkxEjhqp6ZBvkjCxtbX6nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5P7nwFHCh00FgNSrbd+ueYRn4UZE0XtKGt4rKAdQWfBB0XxzPm/8PQEYevtTkqLyNwLN/2MY0HoZG+FrNmYyRFFe61TrkBoIfizyvh1lR9f8BjRY4nj3FdGm/srkwYMveopoX1iGFRgCNMEcOdUQ3fpsoqS0aC9AcBmGatHzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=garw9dFy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="garw9dFy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so5642021a12.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721824020; x=1722428820; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YnOWQnJCnDZ9R7kbtMaSLi40u0ypeXbpg9JSRISHqBU=;
        b=garw9dFy6XDK4RQtYHG47Pj9RkGPK3JOxkN0cqPshUxkq0Sovjig0GiGATBJ/pxbea
         1eVqmyvr3qoObTdK0Yl6riAucYOCI8ruS6k2pwEJ1cvO05qnZsiPtRRqgE33uTG3Jicy
         YefwnjhkgOfaFR1/pQ3lRxMYRoIiiiUCtR9SZGMiyW2k6yLglE+aXL3Aelx1YtKua33q
         EUl1F9vj3B4T4s/wq8t+iLmPmstmoCUbxyC2DlxOk/ApXXs0fx05GPedElwY/MnQNBuK
         YP7gpJp1ppr1wjqCci26u8JCINIxkge/8uh5gXEMJFk6fTCM6nxbYM850uwLru8FHA/x
         A1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721824020; x=1722428820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnOWQnJCnDZ9R7kbtMaSLi40u0ypeXbpg9JSRISHqBU=;
        b=KG72RbdYN3rJLFDpVg3tu/dwKa68YZakKZVHUTawsvoYCMMCWGxhYw8uP86n972Hy5
         IgVQ17Wc8IMAOa+IK+b2L72t6gv7RfHrUQGswYBT9nWgt/h6G7mR9LCWx5VV68NGw+wK
         yt0JDbbISPb0AVJXZTlvYXv7VwU5mq4mL4x97CfHcfrMkhXuy55bgzW1cqApHmgCjIn8
         UzDrT15IfMolU1YLEfEnnre2nt/FBeo+lgOJ85cgnhJnCJJEv54ByE2M1k61A1B769i4
         gaGN78byNsOkwlQzuQd1A4eFEHC0RJOCu76J8wPfF/5H1J94SmV37Qhb87uRLZVbHmZY
         Xvuw==
X-Forwarded-Encrypted: i=1; AJvYcCXxfzADw+9VnNn0/HDq/EtWCh+vHhxpqiFkTqTl6+YLj+o/y3p3lYpdAR1x12b6dBz8E1LngQDRyd1uAzssMRyhb9n7fFLPVJ42AMWdeLE=
X-Gm-Message-State: AOJu0YwAorpCvFDfTpmq/pXo071SkwB7y568cevDuy1moe+g/CxE+9mH
	POu1OrV5DixUziHIEiceZzC6SkaOu5cuEYfvBoFVTtKJO+wnpWmzy6evGvhO2ss=
X-Google-Smtp-Source: AGHT+IErzvWGrjhK+SdJWKIvPxdK2ns3jSTNcJAH7iuZnmq1XwyAmLDTO3x1ofIFEWqqgXTjATC41g==
X-Received: by 2002:a05:6402:3482:b0:5a1:faf:e5ac with SMTP id 4fb4d7f45d1cf-5a3f089da81mr10768384a12.26.1721824019749;
        Wed, 24 Jul 2024 05:26:59 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c3f0673sm8803391a12.61.2024.07.24.05.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:26:59 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:26:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH RFC 1/5] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
Message-ID: <ZqDzErEQbC49F4j9@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724085544.299090-2-21cnbao@gmail.com>

On Wed 24-07-24 20:55:40, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
> 
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>                                                 struct alloc_context *ac)
> {
>         ...
>         /*
>          * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
>          * we always retry
>          */
>         if (gfp_mask & __GFP_NOFAIL) {
>                 /*
>                  * All existing users of the __GFP_NOFAIL are blockable, so warn
>                  * of any new users that actually require GFP_NOWAIT
>                  */
>                 if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                         goto fail;
>                 ...
>         }
>         ...
> fail:
>         warn_alloc(gfp_mask, ac->nodemask,
>                         "page allocation failure: order:%u", order);
> got_pg:
>         return page;
> }
> 
> Let's move the memory allocation out of the atomic context and use
> the normal sleepable context to get pages.
> 
> [RFC]: This has only been compile-tested; I'd prefer if the VDPA maintainers
> handles it.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 791d38d6284c..eff700e5f7a2 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
>  {
>  	struct vduse_bounce_map *map;
>  	unsigned long i, count;
> +	struct page **pages = NULL;
>  
>  	write_lock(&domain->bounce_lock);
>  	if (!domain->user_bounce_pages)
>  		goto out;
> -
>  	count = domain->bounce_size >> PAGE_SHIFT;
> +	write_unlock(&domain->bounce_lock);
> +
> +	pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);
> +	for (i = 0; i < count; i++)
> +		pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);

AFAICS vduse_domain_release calls this function with
spin_lock(&domain->iotlb_lock) so dropping &domain->bounce_lock is not
sufficient.

-- 
Michal Hocko
SUSE Labs
