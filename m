Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1327F4C7
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079966; cv=none; b=bfT9rng5lfXCadHBdFqFYqj0xYEtTd6SmYg239GeXLgBoxYDyHbLaN7uh17UtkiHXlAKG0hhit5mqQDUwOkctFUKPV/hWhLpJIy9WE1LtvQSPv5Xszs6rOHjNFzh4g2NPph5lnBBwamVevHyYDAYeN5baLMzllTO2hRsnVsENVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079966; c=relaxed/simple;
	bh=zEARkqomtgeMl53hWrQxX1yqshfIy6HEB2OtbNbSCsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RMMJlJ84p+K6zKry3/SPFeATt5GH56dxMasyMwAsr+W7LWM2xDyBwUyl3zkZOK0xOBk3CgLoKwzJAyDQ7UvVFuJrwD9YVQXVHdh93Colf7W/gF91VlWuMf9Kndkb38msVmnXJI/cmFJ8o7UuufJu98vWIWAn8dvXn+bOqTbd2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbOumFyp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbOumFyp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70t8xOtesG4UTGBU4t4Siqy1bvWmQnoR0HwnhGPw72o=;
	b=fbOumFyplyNGsYR67Z1hfdM9MU0Ejd2PVCmfd056C+OzGYF2tY6xpasG5aqKuCw+FJ0NXY
	oDysBiJ0xh+Dsp5+sAsRzhMO+K3jwmSA4VSkJTioh8kT2eOxfWAPxr++FjVCJ3WgyuPjWS
	C64pMuyu1XKpNSfxQQOZ9FK3yCwT5jo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-HbuOgglTPT2Qiv1PdsNClw-1; Tue, 21 Oct 2025 16:52:41 -0400
X-MC-Unique: HbuOgglTPT2Qiv1PdsNClw-1
X-Mimecast-MFC-AGG-ID: HbuOgglTPT2Qiv1PdsNClw_1761079960
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47114d373d5so56931745e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079960; x=1761684760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70t8xOtesG4UTGBU4t4Siqy1bvWmQnoR0HwnhGPw72o=;
        b=E15VGwVp+v2X18mMhiqhujQoS3UjM4gdZcQLG23ut1lDYYs/jqwKxq+hn2R427dnOy
         dw5lgbqXHAr0fSuy7N3EVt02INAz+Cn9yusGHMEEd4e4GKnCvMzlQYQga6KbdV+NQ5n+
         d6YarR+Nbgm+WAwko7PBUCNix0lFhLfm4i+txEe8LJdW44R+lV6VFo82flM4Wzbyp6DH
         OJSkh+Bd90iHXXLwaBJ8pj1x3m2cyJEg4QzLJUqbvLdFQCaGX+qdOyiowsxQsd+p+QmZ
         TopBVXt7RSh3yUi8uZY60CQUxq/Fdaqjdjv7GayMkQpI1SIyIFKow3POpKEXTQMv2gJP
         MI3A==
X-Forwarded-Encrypted: i=1; AJvYcCWVve8owdml2nZBo+j2uP871tORMd65J+VSMPmJXPLqYcweGsMZr/ggxuEqzqD63s1qbPUo3o+9JJ4UEPL1Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbrpTjTSSgeQhVnmkAooiyrpiOwSrtQ+EN13iAFgs04Z/UQsYU
	WEcj1gjBLxlPYZcW8UsVLr8i/yg/ATv0/IXJDr4UtqS9og8tRhaUsPMgCxgVFavxuDtrfXMU2sP
	qX+GrPO31qmiY1PamoR67pKbegXToFBTdWg8HOZZ8ql2GyAuDIFnKY+GaW+VV5rYjHqpX
X-Gm-Gg: ASbGncvUIck7ylfyEKsyqupyHDtFgKIIFujfM9zk7219GZiEP8m0NX+laF5oanfMh/u
	vG+F73v7zmkYDhpqigyOvhiScIMd0ry7zJenTIGjnVaVx76a8c5x412Ox02sme4FN0Pem+weWqL
	Og5e94PSRO2PHvEav+oQrdSFnDuFx4PpO51nb/InEps32EKtHTVK7A3xEdp35fX3VLa+isUVrwC
	ZKzraxAfkiddtMBqzf5QJy8cYLeUQCqeAMzNFjffnMdBnhCOijrBEXhReYRHQUy/SHqEgGIuren
	4HP7Zufq5OI95+EXH4IiRZ3W/m7VnNGngYN+nWir2TZA099Q1ZQqLseX4kkSk92HnNK5
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-471179123admr133168865e9.21.1761079960031;
        Tue, 21 Oct 2025 13:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzW0J+zMAHmrBKy98NPR2F9AVZqblG/q03JHaUVQ2fhOgcretSouuM7HYbCnzUNTNzgIF2SQ==
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-471179123admr133168635e9.21.1761079959412;
        Tue, 21 Oct 2025 13:52:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm22293933f8f.51.2025.10.21.13.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:52:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:52:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 07/23] mm/balloon_compaction: use a device-independent
 balloon (list) lock
Message-ID: <20251021165040-mutt-send-email-mst@kernel.org>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-8-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251021125929.377194-8-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mupWUSKvtpUK0xa-UdS7WVrMNCwjDdbmF1iB4UQEI3E_1761079960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 02:59:12PM +0200, David Hildenbrand wrote:
> In order to remove the dependency on the page lock for balloon
> pages, we need a lock that is independent of the page.
> 
> It's crucial that we can handle the scenario where balloon deflation
> (clearing page->private) can race with page isolation (using
> page->private to obtain the balloon_dev_info where the lock currently
> resides).
> 
> The current lock in balloon_dev_info is therefore not suitable.
> 
> Fortunately, we never really have more than a single balloon device
> per VM, so we can just keep it simple and use a static lock to protect
> all balloon devices.
> 
> Based on this change we will remove the dependency on the page lock
> next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/balloon_compaction.h |  6 ++---
>  mm/balloon_compaction.c            | 36 +++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 3109d3c43d306..e2d9eb40e1fbb 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -21,10 +21,10 @@
>   *   i. Setting the PG_movable_ops flag and page->private with the following
>   *	lock order
>   *	    +-page_lock(page);
> - *	      +--spin_lock_irq(&b_dev_info->pages_lock);
> + *	      +--spin_lock_irq(&balloon_pages_lock);
>   *
>   *  ii. isolation or dequeueing procedure must remove the page from balloon
> - *      device page list under b_dev_info->pages_lock.
> + *      device page list under &balloon_pages_lock

Using &balloon_pages_lock with an & is kinda weird here.


>   *
>   * The functions provided by this interface are placed to help on coping with
>   * the aforementioned balloon page corner case, as well as to ensure the simple
> @@ -52,7 +52,6 @@
>   */
>  struct balloon_dev_info {
>  	unsigned long isolated_pages;	/* # of isolated pages for migration */
> -	spinlock_t pages_lock;		/* Protection to pages list */
>  	struct list_head pages;		/* Pages enqueued & handled to Host */
>  	int (*migratepage)(struct balloon_dev_info *, struct page *newpage,
>  			struct page *page, enum migrate_mode mode);
> @@ -71,7 +70,6 @@ extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>  {
>  	balloon->isolated_pages = 0;
> -	spin_lock_init(&balloon->pages_lock);
>  	INIT_LIST_HEAD(&balloon->pages);
>  	balloon->migratepage = NULL;
>  	balloon->adjust_managed_page_count = false;
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index fd9ec47cf4670..97e838795354d 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -11,6 +11,12 @@
>  #include <linux/export.h>
>  #include <linux/balloon_compaction.h>
>  
> +/*
> + * Lock protecting the balloon_dev_info of all devices. We don't really
> + * expect more than one device.
> + */
> +static DEFINE_SPINLOCK(balloon_pages_lock);
> +
>  static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
>  				     struct page *page)
>  {
> @@ -47,13 +53,13 @@ size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
>  	unsigned long flags;
>  	size_t n_pages = 0;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_for_each_entry_safe(page, tmp, pages, lru) {
>  		list_del(&page->lru);
>  		balloon_page_enqueue_one(b_dev_info, page);
>  		n_pages++;
>  	}
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  	return n_pages;
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
> @@ -83,7 +89,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  	unsigned long flags;
>  	size_t n_pages = 0;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
>  		if (n_pages == n_req_pages)
>  			break;
> @@ -106,7 +112,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  		dec_node_page_state(page, NR_BALLOON_PAGES);
>  		n_pages++;
>  	}
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  
>  	return n_pages;
>  }
> @@ -149,9 +155,9 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	balloon_page_enqueue_one(b_dev_info, page);
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  
> @@ -191,11 +197,11 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
>  		 * BUG() here, otherwise the balloon driver may get stuck in
>  		 * an infinite loop while attempting to release all its pages.
>  		 */
> -		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +		spin_lock_irqsave(&balloon_pages_lock, flags);
>  		if (unlikely(list_empty(&b_dev_info->pages) &&
>  			     !b_dev_info->isolated_pages))
>  			BUG();
> -		spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +		spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  		return NULL;
>  	}
>  	return list_first_entry(&pages, struct page, lru);
> @@ -213,10 +219,10 @@ static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
>  	if (!b_dev_info)
>  		return false;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_del(&page->lru);
>  	b_dev_info->isolated_pages++;
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  
>  	return true;
>  }
> @@ -230,10 +236,10 @@ static void balloon_page_putback(struct page *page)
>  	if (WARN_ON_ONCE(!b_dev_info))
>  		return;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_add(&page->lru, &b_dev_info->pages);
>  	b_dev_info->isolated_pages--;
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  }
>  
>  static int balloon_page_migrate(struct page *newpage, struct page *page,
> @@ -253,7 +259,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>  	rc = b_dev_info->migratepage(b_dev_info, newpage, page, mode);
>  	switch (rc) {
>  	case 0:
> -		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +		spin_lock_irqsave(&balloon_pages_lock, flags);
>  
>  		/* Insert the new page into the balloon list. */
>  		get_page(newpage);
> @@ -272,7 +278,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>  		}
>  		break;
>  	case -ENOENT:
> -		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +		spin_lock_irqsave(&balloon_pages_lock, flags);
>  
>  		/* Old page was deflated but new page not inflated. */
>  		__count_vm_event(BALLOON_DEFLATE);
> @@ -285,7 +291,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>  	}
>  
>  	b_dev_info->isolated_pages--;
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  
>  	/* Free the now-deflated page we isolated in balloon_page_isolate(). */
>  	balloon_page_finalize(page);
> -- 
> 2.51.0

