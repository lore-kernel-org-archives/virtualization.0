Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B02F8EB5
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105460; cv=none; b=P2dNb8nIhY6xB7irWWD0A3Uw09jXO8locWjKVX0/NsiTswfnDCw0vIGRVsKByvh2sBmtXu2hjKlXJ4MQuot/GWoVeEE6f5wXtYpXDBIuG3dvcq5ZCaIPy5YQ22ddOQfpfPGIESJIBFXG7A8/h1zY1uWV1QEwfopactUWMsy6R6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105460; c=relaxed/simple;
	bh=JXTWQZddhfkRGGTiT/jcYmEp+t3IrIMEE00uaSqjvLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwFYQ0VUxo7HCO7SyIets/ucmwlqzP5WRhkMH1aI5y9KXo8/3lZOZj0jXtQ83PQWXIUMR15y0O7MZui8S5SpFDcslpFjg1VWWeZh6xxvTaNSyCOaGsK68NxcVLzkJxEf/1Q5yVUlAcqOUWjkKRan99TxfiQiPBvenT5bguyxo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nisP7ODH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nisP7ODH"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ce9de10985so81001986d6.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781105458; x=1781710258; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bboFVFfkG0GIFTD2ahnJgVC8EVO2PxrJueSwSbO4OM=;
        b=nisP7ODHd/ilf+5qlyV4oSNripgs/97LKUX6WfcfJdLtxFmnUmEdjxqo5hkaul3pGO
         imq3zpFhECEMf7590qtlp+FYJa6dKPm5GbDzj9oxxez7MTC0Tkq3YViY0S4NLR1Rj/y4
         d/E6iI0+bPMt3loXURyGSYSiivZhxbadWhi6oyBBy+oWUb+jxVWL+TDukzXlXz/h/1PZ
         wy/KHCImcW/ZywYpUFbaWyJ8aA09iv2Xg+g/+pFuRG4L0ZFZ04lemkzIITH9Z9Cs41NU
         lScPDAANpAqvUPKg61f1WTU6Mac6gNqxtLyeLWf004er01tKRXh0xh6gjXfZ/IiKWNic
         MPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105458; x=1781710258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bboFVFfkG0GIFTD2ahnJgVC8EVO2PxrJueSwSbO4OM=;
        b=e3Tyo8CUP9WIMhfX+720siCQCdRsGPH9f/N2nn1wc5HZlAM3fUTy7/3Xj0iNX4MabN
         /dFK3Bh5IGJabpyb3P9drv8LGuvbs11uaegAmuMZz6UUYEhscRIZr45f6Tn4mNCBA4m7
         N93Q6T/0lYCFLQAppI6bfHgLNnqcFDY40epuQbsWoGT9JjPvdEDT9ozT77oXoRfSwHJP
         Eo5LDpdbzmk6qF+Ol5tHPkNPO5pc5Sh2i+2zOeP3ic81BYurTSX9CKnQ8/5q6zvJgLuE
         lkUBBzbtFZvDqzADTw1HLIgbL4v942A6Uk/DvqIkk/t/wnJTjjJopXjZ1cCSR7eZT8b0
         dWGA==
X-Forwarded-Encrypted: i=1; AFNElJ/JIX7IOrPcZTEbV15HZIAFae+6R6dphcP2qUt4KgUo+4Kii5i7MjA+p4d1tbnGEXcVrCmqlmu0aPwqvcAmbg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4VO6SGjcnhxLAeJIRHKzb+xk80bXfvtzvtnI/1s92LTeSY+TF
	3jhxbaMQEOjGnxGlU0S112/1iNKF2xmhHTFgFlOKZOFh8tIG3B1aU8tGHk37T9adWXQ=
X-Gm-Gg: Acq92OHhTwrpUmlR3+Q9e+ukGnwuv4qCUKx4L1UC7wFWGl31CKWRic6dRv771pNhcOM
	hdmI0XkUR6MEKMZ3YIBTVHYezYgL5RNLewXNeD+QnptqmOpQ+kyRdlVgHTeI493jP00dE7pgXLu
	e30dVY3CvUqHQhBaVdI0vCBTqsobjHZmi9QTvzfhdSvMAtND1xTxUAgsnfc3CoGHyRgFq3Zhc0k
	QzPiNaCTwVrqwcqL8mWSis0K5pytKBpQ4TtM/WGD9rEYx2ptSFSH3CHVVJgBANg6eaHHUt5q9wj
	lZbP41YzpE0SGq3psM2t8ZLVzXS93iVzp7jqBLaKU8MWdN1cZvh9o+tT8pwxGL1GzE5xjcy1DCB
	T2MxXRXs7LpYYeqi5DryFIvSLVJi4verTFUwnqt8VPuw1uQGGxKjwRr4O+jIjsSV/2Qigz9h2yH
	EEP+yL9a9xkv7OG0PFiJGvSk7LymODEYrm22UO8YiWvI71maJ2jOpxd8HcV9t8Q6SdnnFwaDzg3
	Q19d/oIy5Lom8Nbaw==
X-Received: by 2002:ad4:5d61:0:b0:8ce:afa5:7603 with SMTP id 6a1803df08f44-8cee8bcbffdmr300230056d6.14.1781105455435;
        Wed, 10 Jun 2026 08:30:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053210sm233198056d6.26.2026.06.10.08.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:30:54 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:30:52 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v2] mm: page_reporting: allow driver to set batch capacity
Message-ID: <aimDLHoETsdWppAi@gourry-fedora-PF4VCD3F>
References: <cb43adc61d2ed3069b2fe428f3e051dbdc4cc28d.1781097156.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb43adc61d2ed3069b2fe428f3e051dbdc4cc28d.1781097156.git.mst@redhat.com>

On Wed, Jun 10, 2026 at 09:17:08AM -0400, Michael S. Tsirkin wrote:
> At the moment, if a virtio balloon device has a page reporting vq but
> its size is < PAGE_REPORTING_CAPACITY (32), the balloon driver fails
> probe.
> 
> But, there's no way for host to know this value, so it can easily
> create a smaller vq and suddenly adding the reporting capability
> to the device makes all of the driver fail. Not pretty.
> 
> Add a capacity field to page_reporting_dev_info so drivers can
> control the maximum number of pages per report batch.
> 
> In virtio-balloon, set the capacity to the reporting virtqueue size,
> letting page_reporting adapt to whatever the device provides.
> 
> Capacity need not be a power of two.  Code previously called out
> division by PAGE_REPORTING_CAPACITY as cheap since it was a power
> of 2, but no performance difference was observed with non-power-of-2
> values.
> 
> If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> page_reporting_register(), before the reporting work is scheduled,
> so we never get division by 0.
> 
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6

lgtm asside from David's comment request

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
> Changes v1->v2:
> - Document capacity=0 as default in commit log
> - Document that capacity need not be a power of two
> - Drop unnecessary comment about integer division cost
> - Update comment on capacity field: "0 (default) means PAGE_REPORTING_CAPACITY"
> 
>  drivers/virtio/virtio_balloon.c |  5 +----
>  include/linux/page_reporting.h  |  3 +++
>  mm/page_reporting.c             | 24 ++++++++++++------------
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f6c2dff33f8a..6a1a610c2cb1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1017,10 +1017,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		unsigned int capacity;
>  
>  		capacity = virtqueue_get_vring_size(vb->reporting_vq);
> -		if (capacity < PAGE_REPORTING_CAPACITY) {
> -			err = -ENOSPC;
> -			goto out_unregister_oom;
> -		}
>  
>  		vb->pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
>  
> @@ -1041,6 +1037,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		vb->pr_dev_info.order = 5;
>  #endif
>  
> +		vb->pr_dev_info.capacity = capacity;
>  		err = page_reporting_register(&vb->pr_dev_info);
>  		if (err)
>  			goto out_unregister_oom;
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 9d4ca5c218a0..048578118a4b 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -22,6 +22,9 @@ struct page_reporting_dev_info {
>  
>  	/* Minimal order of page reporting */
>  	unsigned int order;
> +
> +	/* Max pages per report batch; 0 (default) means PAGE_REPORTING_CAPACITY */
> +	unsigned int capacity;
>  };
>  
>  /* Tear-down and bring-up for page reporting devices */
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 7418f2e500bb..942e84b6908a 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -173,11 +173,8 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>  	 * any pages that may have already been present from the previous
>  	 * list processed. This should result in us reporting all pages on
>  	 * an idle system in about 30 seconds.
> -	 *
> -	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
> -	 * should always be a power of 2.
>  	 */
> -	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
> +	budget = DIV_ROUND_UP(area->nr_free, prdev->capacity * 16);
>  
>  	/* loop through free list adding unreported pages to sg list */
>  	list_for_each_entry_safe(page, next, list, lru) {
> @@ -222,10 +219,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>  		spin_unlock_irq(&zone->lock);
>  
>  		/* begin processing pages in local list */
> -		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
> +		err = prdev->report(prdev, sgl, prdev->capacity);
>  
>  		/* reset offset since the full list was reported */
> -		*offset = PAGE_REPORTING_CAPACITY;
> +		*offset = prdev->capacity;
>  
>  		/* update budget to reflect call to report function */
>  		budget--;
> @@ -234,7 +231,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>  		spin_lock_irq(&zone->lock);
>  
>  		/* flush reported pages from the sg list */
> -		page_reporting_drain(prdev, sgl, PAGE_REPORTING_CAPACITY, !err);
> +		page_reporting_drain(prdev, sgl, prdev->capacity, !err);
>  
>  		/*
>  		 * Reset next to first entry, the old next isn't valid
> @@ -260,13 +257,13 @@ static int
>  page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>  			    struct scatterlist *sgl, struct zone *zone)
>  {
> -	unsigned int order, mt, leftover, offset = PAGE_REPORTING_CAPACITY;
> +	unsigned int order, mt, leftover, offset = prdev->capacity;
>  	unsigned long watermark;
>  	int err = 0;
>  
>  	/* Generate minimum watermark to be able to guarantee progress */
>  	watermark = low_wmark_pages(zone) +
> -		    (PAGE_REPORTING_CAPACITY << page_reporting_order);
> +		    (prdev->capacity << page_reporting_order);
>  
>  	/*
>  	 * Cancel request if insufficient free memory or if we failed
> @@ -290,7 +287,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>  	}
>  
>  	/* report the leftover pages before going idle */
> -	leftover = PAGE_REPORTING_CAPACITY - offset;
> +	leftover = prdev->capacity - offset;
>  	if (leftover) {
>  		sgl = &sgl[offset];
>  		err = prdev->report(prdev, sgl, leftover);
> @@ -322,11 +319,11 @@ static void page_reporting_process(struct work_struct *work)
>  	atomic_set(&prdev->state, state);
>  
>  	/* allocate scatterlist to store pages being reported on */
> -	sgl = kmalloc_objs(*sgl, PAGE_REPORTING_CAPACITY);
> +	sgl = kmalloc_objs(*sgl, prdev->capacity);
>  	if (!sgl)
>  		goto err_out;
>  
> -	sg_init_table(sgl, PAGE_REPORTING_CAPACITY);
> +	sg_init_table(sgl, prdev->capacity);
>  
>  	for_each_zone(zone) {
>  		err = page_reporting_process_zone(prdev, sgl, zone);
> @@ -377,6 +374,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>  			page_reporting_order = pageblock_order;
>  	}
>  
> +	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
> +		prdev->capacity = PAGE_REPORTING_CAPACITY;
> +
>  	/* initialize state and work structures */
>  	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
>  	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);
> -- 
> MST
> 
