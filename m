Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093822;
	b=fO4ljJgj0c14MDdaAPhgJ+EGfse1wseRiuc/pZXcJAcWQKlSPaO5XwkNmTd3VlMV/Xx/
	 wgYBsNGXLUwvYk7gAXpXJhF0QqQmNb3igBaouquXmnPbJiGvOyDw90Hh2ayXzmqKY+Qxs
	 tesHN6N6Xfd/QzeIRtBVzE+KdPH7H9MS0jkUdgcNTtoHAUX0wuFaJMZL9vuzjnbQiPj81
	 9HXBbTokOhipSCPbr0sKiPOvBOlh+NnQGSOM/XB5ZOozqGaOGxV+nvoDM44IYYP82Mzvx
	 S/xwN+MP13mfOEaDaYgAHGg0qD+ZgNwmugzwB+U/kZmsgbJP0ICpfs88o39WanrmO+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093822;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=yZ6xG709ht579SVeXaHvhn7gbaGSx41yuwP8KO/9DQI=;
	b=EnwmCAsR91BaTuBEIS9wj262sHLXDw036fnjz1avw83NmKBn58a1Pfni0oYk1Qg8DwkP
	 ClA5b0SEYuxQ0noGJwB1eKMiG+ten5BVIS/RMj25xJGNbnphdCekWkBHWNq4EyXj8+pNE
	 PzKJjOLRvOVSVRXM+if2+pV0TfPSTAuhVN6dZ9SucpCBAOaAf10Lvm2gUJWnwNNj7+dLw
	 IwhL1adpYTU/a6mAKqeSlcMn3pGxnas2ZNZQm3TXwj/OUDG0lWge1tVnjkHGEvKaue4y3
	 EozRBUkbHyjzBIMEzyxPHkDPeFdplN6gySf/TjhvY4L3HfViUTVoipeJjujrdVmoKUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HIxsGLTp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77166606A31B
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 09:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77166606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HIxsGLTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793093820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yZ6xG709ht579SVeXaHvhn7gbaGSx41yuwP8KO/9DQI=;
	b=HIxsGLTpyjQPUPCm5dkHYO67YmKeYD2RFc/wND8N4lACDtkddc0Ma+J9hMRu2MVkysFg36
	/RvyRCYW/Dkw9UHIwDs6qsvmdl5OaKJTi+6byyfUhjPFyeYkQdwGFasb1exfXplzc1RAr3
	qjPTLnZuAl0GOpDoPoeUAsof1idzveU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-kobijklZP0u747CeaR3cDQ-1; Tue, 27 Oct 2026 05:36:58 -0400
X-MC-Unique: kobijklZP0u747CeaR3cDQ-1
X-Mimecast-MFC-AGG-ID: kobijklZP0u747CeaR3cDQ_1793093818
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1ad3cb66so2286682f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793093818; x=1793698618;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZ6xG709ht579SVeXaHvhn7gbaGSx41yuwP8KO/9DQI=;
        b=NS4q9zZvlHIAGdoCR5jshXgj0FiR5CPnrAaq8g3SIBcueci5WyQ8X8DB5SyORm1SOm
         DhANSkPAKZF7A6MgiE4vTZy2M8ptbvA4PqvlFXMiFb07NWzzFisS5uWf93e1VFwUEK5d
         ugtiFIn7hxQq8Xm8a8gUmaJ0X8r21MR4doUNGhChMx3LMNsl95toLhtwUPfw7LV3hyrV
         bmHKwLVYrwJbY0dAA5qYyAP+CJVIH2UUtJb2ysNGG2bsXBtyRA+8cU9n3lW/Rmt6Ttzr
         CXKSgUryV0X99mBn2oqky85CugI00ItJ/T2W2GH4V66zPm5FXWgL4JmQFOFLD+D5tEti
         WEQA==
X-Forwarded-Encrypted: i=1; AKwUvBxbnVjF9AnY4B2r6EoleWJW/7SPI8CiQeQlNarbT3NtALVA/B24CyWasJg7QYJVYLrp8MT/7bDeCgJklF26FA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLGOVC1u7iGvrEUXsptUTSMfQENy0Uvb+yYCF/ipXoq0bmCfYFV
	6yHgv7KudLcBi3VchkhqoKoq05ScU4c06g8aYpHZx4Wbot9uabKhnthYP2R9rQ+0lkhrkwFA6sM
	qO1HqIWNrDF1xoIUqQgnl4PWw1hYM6ype5McLnyM3gklWCXuO8cjoFLQu1Ag9gdg5D4v6
X-Gm-Gg: AYBFou3X5ghdrwVerMoJttqtAzdfYVoTXyQfwcMnZcDCvMlBrTownI7g/qKONprqOby
	iGoR9R2dDRruobXplDjI6yXgOydkD3hkU+FxSDudat1VSn0pqKidW84NZ1ltEdGsdbjqT22fh1/
	JUVD8MiBhjup3OBLAj4V33exdREdjacpidrYTmpLIFQncgNkjknxtUTMOrv3AJKmBYJ0imMAqvz
	oe4Ys9DOycbtkdOc5PQNkZ+KboBbncJZ4vB42yefCVQAI92D0n6Q7MAB9oRnhzpBUJniU0VCZDp
	zmQdP6jhf2JbT3kqpqymr3dmchkFL/FIkH0QZ/gApPvD9am2icnmMASVzC2F6ppWoFE=
X-Received: by 2002:a05:600c:4f89:b0:4a2:150f:160f with SMTP id 5b1f17b1804b1-4a35aca4e43mr174240495e9.25.1793093817483;
        Tue, 27 Oct 2026 02:36:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4f89:b0:4a2:150f:160f with SMTP id 5b1f17b1804b1-4a35aca4e43mr174239545e9.25.1793093816842;
        Tue, 27 Oct 2026 02:36:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbb725sm253517165e9.0.2026.10.27.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:36:55 -0700 (PDT)
Date: Tue, 27 Oct 2026 05:36:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	virtualization@lists.linux.dev, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidharth Telang <sidtelang@google.com>,
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Jacky Li <jackyli@google.com>,
	Steve Rutherford <srutherford@google.com>,
	David Skidmore <davidskidmore@google.com>
Subject: Re: [PATCH 10/13] virtio_balloon: add higher-order page inflation
Message-ID: <20261027051822-mutt-send-email-mst@kernel.org>
References: <20261027025616.1632690-1-kevinloughlin@google.com>
 <20261027025616.1632690-11-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027025616.1632690-11-kevinloughlin@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cIebTVEPsmiXSNH3PgXr3fzMiW4AZMOQn_-CQrYMvNY_1793093818
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 02:56:13AM +0000, Kevin Loughlin wrote:
> In confidential computing guests requiring page state transitions,
> unaccepted memory tracking operates at the EFI unaccepted memory unit
> granularity (typically 2MB / order 9 on x86). Inflating the balloon
> with 4KB pages would prevent unaccepting the backing 2MB unit.
> 
> Inflate balloon pages at unaccepted_memory_order() when
> virtballoon_cc_needs_state_transition() is true, while retaining
> order-0 allocations for non-CoCo guests and CoCo guests that do not
> use unaccepted memory transitions. When a higher-order balloon page
> spans more 4KB balloon PFNs than VIRTIO_BALLOON_ARRAY_PFNS_MAX (256),
> transmit its PFNs to the host in VIRTIO_BALLOON_ARRAY_PFNS_MAX chunks.
> 
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>

BTW I'd say *everyone* prefers large pages. The fact that balloon
currently breaks them up isn't nice to anyone. The only setup
where they might be helpful is severe fragmentation, but even then,
it is not clear we aren't contributing to the problem
by making the fragmentation worse.


> ---
>  drivers/virtio/virtio_balloon.c | 87 ++++++++++++++++++++++++++-------
>  include/linux/balloon.h         |  1 +
>  mm/balloon.c                    | 67 +++++++++++++++++++------
>  3 files changed, 121 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 11f74848fdc4..d162c162b496 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -182,6 +182,13 @@ static void balloon_ack(struct virtqueue *vq)
>  	wake_up(&vb->acked);
>  }
>  
> +static inline bool virtballoon_cc_needs_state_transition(void)
> +{
> +	return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> +	       cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +	       has_unaccepted_memory();
> +}
> +
>  static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>  {
>  	struct scatterlist sg;
> @@ -243,24 +250,49 @@ static void set_page_pfns(struct virtio_balloon *vb,
>  					  page_to_balloon_pfn(page) + i);
>  }
>  
> +static void queue_page_pfns(struct virtio_balloon *vb, struct virtqueue *vq,
> +			    struct page *page, unsigned int order)
> +{
> +	unsigned int nr_pages = 1 << order;
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		set_page_pfns(vb, vb->pfns + vb->num_pfns, page + i);
> +		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		if (vb->num_pfns == ARRAY_SIZE(vb->pfns)) {
> +			tell_host(vb, vq);
> +			vb->num_pfns = 0;
> +		}
> +	}
> +}
> +
> +static inline unsigned int virtballoon_preferred_order(void)
> +{
> +	if (virtballoon_cc_needs_state_transition())
> +		return unaccepted_memory_order();
> +	return 0;
> +}
> +
>  static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>  {
> -	unsigned int num_allocated_pages;
> +	unsigned int order = virtballoon_preferred_order();
> +	unsigned int page_pfns = (1 << order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
> +	unsigned int num_allocated_pages = 0;
>  	struct page *page, *next;
>  	unsigned int num_pfns;
>  	LIST_HEAD(pages);
>  
> -	/* We can only do one array worth at a time. */
> -	num = min(num, ARRAY_SIZE(vb->pfns));
> +	/* We can only do one array or preferred-order page worth at a time. */
> +	num = min(num, max_t(size_t, ARRAY_SIZE(vb->pfns), page_pfns));
>  
>  	for (num_pfns = 0; num_pfns < num;
> -	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		page = balloon_page_alloc();
> +	     num_pfns += page_pfns) {
> +		page = balloon_pages_alloc(order);
>  
>  		if (!page) {
>  			dev_info_ratelimited(&vb->vdev->dev,
>  					     "Out of puff! Can't get %u pages\n",
> -					     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +					     page_pfns);
>  			/* Sleep for at least 1/5 of a second before retry. */
>  			msleep(200);
>  			break;
> @@ -274,15 +306,17 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>  	vb->num_pfns = 0;
>  
>  	list_for_each_entry_safe(page, next, &pages, lru) {
> +		unsigned int page_order = compound_order(page);
> +		unsigned int pfns = (1 << page_order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
> +
>  		list_del(&page->lru);
>  		balloon_page_enqueue(&vb->vb_dev_info, page);
>  
> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> -		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> -		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		vb->num_pages += pfns;
> +		num_allocated_pages += pfns;
> +		queue_page_pfns(vb, vb->inflate_vq, page, page_order);
>  	}
>  
> -	num_allocated_pages = vb->num_pfns;
>  	/* Did we get any? */
>  	if (vb->num_pfns != 0)
>  		tell_host(vb, vb->inflate_vq);
> @@ -304,28 +338,42 @@ static void release_pages_balloon(struct virtio_balloon *vb,
>  
>  static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
>  {
> -	unsigned int num_freed_pages;
> +	unsigned int order = virtballoon_preferred_order();
> +	unsigned int page_pfns = (1 << order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
> +	unsigned int num_freed_pages = 0;
>  	struct page *page;
>  	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
>  	LIST_HEAD(pages);
>  
> -	/* We can only do one array worth at a time. */
> -	num = min(num, ARRAY_SIZE(vb->pfns));
> +	/* We can only do one array or preferred-order page worth at a time. */
> +	num = min(num, max_t(size_t, ARRAY_SIZE(vb->pfns), page_pfns));
>  
>  	mutex_lock(&vb->balloon_lock);
>  	/* We can't release more pages than taken */
>  	num = min(num, (size_t)vb->num_pages);
> -	for (vb->num_pfns = 0; vb->num_pfns < num;
> -	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> +	vb->num_pfns = 0;
> +	while (num_freed_pages < num) {
> +		unsigned int dequeued_order;
> +		unsigned int dequeued_pfns;
> +
>  		page = balloon_page_dequeue(vb_dev_info);
>  		if (!page)
>  			break;
> -		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> +		dequeued_order = compound_order(page);
> +		dequeued_pfns = (1 << dequeued_order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
> +
> +		if (num_freed_pages + dequeued_pfns > num &&
> +		    num_freed_pages > 0) {
> +			balloon_page_enqueue(vb_dev_info, page);
> +			break;
> +		}
> +
> +		queue_page_pfns(vb, vb->deflate_vq, page, dequeued_order);
>  		list_add(&page->lru, &pages);
> -		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		vb->num_pages -= dequeued_pfns;
> +		num_freed_pages += dequeued_pfns;
>  	}
>  
> -	num_freed_pages = vb->num_pfns;
>  	/*
>  	 * Note that if
>  	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
> @@ -474,7 +522,8 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>  	 * Aligned up to guest page size to avoid inflating and deflating
>  	 * balloon endlessly.
>  	 */
> -	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
> +	target = ALIGN((s64)num_pages,
> +		       VIRTIO_BALLOON_PAGES_PER_PAGE << virtballoon_preferred_order());
>  	return target - vb->num_pages;
>  }
>  
> diff --git a/include/linux/balloon.h b/include/linux/balloon.h
> index ca5b15150f42..bc46e36b997f 100644
> --- a/include/linux/balloon.h
> +++ b/include/linux/balloon.h
> @@ -58,6 +58,7 @@ struct balloon_dev_info {
>  	bool adjust_managed_page_count;
>  };
>  
> +struct page *balloon_pages_alloc(unsigned int order);
>  struct page *balloon_page_alloc(void);
>  void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  		struct page *page);
> diff --git a/mm/balloon.c b/mm/balloon.c
> index 96a8f1e20bc6..e9941d08d8e9 100644
> --- a/mm/balloon.c
> +++ b/mm/balloon.c
> @@ -27,9 +27,12 @@ static DEFINE_SPINLOCK(balloon_pages_lock);
>  static void balloon_page_insert(struct balloon_dev_info *balloon,
>  				       struct page *page)
>  {
> +	unsigned int i, nr_pages = 1U << compound_order(page);
> +
>  	lockdep_assert_held(&balloon_pages_lock);
> -	__SetPageOffline(page);
> -	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION)) {
> +	for (i = 0; i < nr_pages; i++)
> +		__SetPageOffline(page + i);
> +	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION) && !PageCompound(page)) {
>  		SetPageMovableOps(page);
>  		set_page_private(page, (unsigned long)balloon);
>  	}
> @@ -45,20 +48,31 @@ static void balloon_page_insert(struct balloon_dev_info *balloon,
>   */
>  static void balloon_page_finalize(struct page *page)
>  {
> +	unsigned int i, nr_pages = 1U << compound_order(page);
> +
>  	lockdep_assert_held(&balloon_pages_lock);
> -	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
> +	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION) && !PageCompound(page))
>  		set_page_private(page, 0);
> -	/* PageOffline is sticky until the page is freed to the buddy. */
> +	/*
> +	 * PageOffline is sticky on the head page until freed to the buddy,
> +	 * which resets the head page's page_type in __free_pages_prepare().
> +	 * Clear PageOffline on tail pages here as __free_pages_prepare()
> +	 * expects tail pages to have a default page_type.
> +	 */
> +	for (i = 1; i < nr_pages; i++)
> +		__ClearPageOffline(page + i);
>  }
>  
>  static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
>  				     struct page *page)
>  {
> +	unsigned int order = compound_order(page);
> +
>  	balloon_page_insert(b_dev_info, page);
>  	if (b_dev_info->adjust_managed_page_count)
> -		adjust_managed_page_count(page, -1);
> -	__count_vm_event(BALLOON_INFLATE);
> -	inc_node_page_state(page, NR_BALLOON_PAGES);
> +		adjust_managed_page_count(page, -(1L << order));
> +	__count_vm_events(BALLOON_INFLATE, 1UL << order);
> +	mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES, 1L << order);
>  }
>  
>  /**
> @@ -117,15 +131,18 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  
>  	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> +		unsigned int order = compound_order(page);
> +
>  		if (n_pages == n_req_pages)
>  			break;
>  		list_del(&page->lru);
>  		if (b_dev_info->adjust_managed_page_count)
> -			adjust_managed_page_count(page, 1);
> +			adjust_managed_page_count(page, 1L << order);
>  		balloon_page_finalize(page);
> -		__count_vm_event(BALLOON_DEFLATE);
> +		__count_vm_events(BALLOON_DEFLATE, 1UL << order);
>  		list_add(&page->lru, pages);
> -		dec_node_page_state(page, NR_BALLOON_PAGES);
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +				    -(1L << order));
>  		n_pages++;
>  	}
>  	spin_unlock_irqrestore(&balloon_pages_lock, flags);
> @@ -135,8 +152,9 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>  
>  /**
> - * balloon_page_alloc - allocates a new page for insertion into the balloon
> - *			page list.
> + * balloon_pages_alloc - allocates a new page of given order for insertion
> + *			 into the balloon page list.
> + * @order: allocation order
>   *
>   * Driver must call this function to properly allocate a new balloon page.
>   * Driver must call balloon_page_enqueue before definitively removing the page
> @@ -144,16 +162,35 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>   *
>   * Return: struct page for the allocated page or NULL on allocation failure.
>   */
> -struct page *balloon_page_alloc(void)
> +struct page *balloon_pages_alloc(unsigned int order)
>  {
>  	gfp_t gfp_flags = __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>  
> -	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
> +	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION) && !order)
>  		gfp_flags |= GFP_HIGHUSER_MOVABLE;
>  	else
>  		gfp_flags |= GFP_HIGHUSER;
>  
> -	return alloc_page(gfp_flags);
> +	if (order > 0)
> +		gfp_flags |= __GFP_COMP;
> +
> +	return alloc_pages(gfp_flags, order);
> +}
> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> +
> +/**
> + * balloon_page_alloc - allocates a new page for insertion into the balloon
> + *			page list.
> + *
> + * Driver must call this function to properly allocate a new balloon page.
> + * Driver must call balloon_page_enqueue before definitively removing the page
> + * from the guest system.
> + *
> + * Return: struct page for the allocated page or NULL on allocation failure.
> + */
> +struct page *balloon_page_alloc(void)
> +{
> +	return balloon_pages_alloc(0);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_alloc);
>  
> -- 
> 2.56.0.307.g5fe7bd680c-goog

