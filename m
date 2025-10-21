Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70150283CB5
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080263; cv=none; b=sOrAJNp50/YueqBSLvSHRe0h/7Hqk9LHMthe9QbAQ2UFI6JSQC9eZE0Z4kFRcQFViEzlGqqxKHFKz5itFUZCmT+fUHERSQSi/e+G9jjSlQPi3ElQwIW07kgRwFY+fypFsfDsY4ZVjz3RFEiK5n1/Jusd0PI0Lu1/Rv+uVx/6/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080263; c=relaxed/simple;
	bh=PiEF4dZTXzB/bahHoYvpvUwN2xzfC3fULfkA9PjR6I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LCZtxVhtJawYaSSP8Ewu2FOjWiVsT/eXBqOt8hf5kEN0DGpdOykRsyOPfZmBCzLkth/m1gEEy3Ru8idQiE9Y5ifO1tCMdXdvlA5B6pFeYhAPhqSkZFzFHL3l2Qjq9OUyxI8sYIuO4/ULHBmBtml3JGoyYjgi8ES/NCWtXx+AzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QK78i5Ak; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QK78i5Ak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761080260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bAJqRa8uA5UrlbIgGaXWwm0Ps33WDl0PlkuKaJzgdU=;
	b=QK78i5AklffzO++S+TKJNDt+LWEv/KUTV9IimMRDndh1yWRCe1ddChiSa+WQ6EWYeNyvo8
	r8BOKr4dno9uM3XPqTpTZt/JYECfGc1dl/CbnZbLV6ZQr3ie4dC3ipgciYWW+Z8ssWRb18
	GDpMs3bdlmDLbecktVyRCTuya28om88=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-FcDXbsaKMtCD-elNXWnL3w-1; Tue, 21 Oct 2025 16:57:36 -0400
X-MC-Unique: FcDXbsaKMtCD-elNXWnL3w-1
X-Mimecast-MFC-AGG-ID: FcDXbsaKMtCD-elNXWnL3w_1761080256
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427015f63faso3077112f8f.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 13:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761080255; x=1761685055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bAJqRa8uA5UrlbIgGaXWwm0Ps33WDl0PlkuKaJzgdU=;
        b=ixqADlBduYV5ZKk5HYZRRszx+MGSXs1xCixuAVXIjZTTVPb80NDsff077+4RpGvy6c
         BjToPd8bHsTcSWzvRLVJcRBrAEKP9Fgf4kBW25bYPe2hnJRaEMBKxXNBwHqv+rtvBvPb
         gUqFd77S77PjP8bzuVm5O1HGBmrj2XmYKZ5xsNpnHCwG3KQeTmVvJSyqGLzyMeHg0JgT
         bTBbI3Zr7aUzO1exgyhLO/VIX8A9rAg+69sK4i+J7sWFCVfjZMUKR9rTjj0YVZmm7SuU
         1Znf7p1XjgXpJA6xKvOfN697yrlQXwFneY9UVW4wnrEJNCLk95hdt2xreTfaA3hNHtVo
         pxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLshYZ+ji6DmxdeBs/zel0bdv5tJarr4jT136ckwNCXGmsqjWTcCQGqzd5mHcucPJ9mi1ChpYs4e/CVPFYaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwclzJNV5SM2RBphvvFMWo3ufslfunFCVsDDSKxaMpcs3N7WI8o
	I12I3uhR0jlyol6fuGSacRh6y8AV2iHTpfMFhmeieSEYfIKw093dXrSjoGP1+Z1q1GhuIqtHRYt
	lVBLMJ7XHwdNGp1A0GqtDbGUXXPyA18uIazlAC02a3240zykvoHM0AuL2NUPBgY7X2V/4
X-Gm-Gg: ASbGncuWiLlkGNtwsEOAEXuL9MrH4YBgCEwfD67BlZzPPbinFqI5xTGGk/v9EsHo0au
	VIRAAf7bXV+I+flrUQaCj3eBkgd3+1LRxNs4XLfKQ18/GDoVYXHJTL2V6dPXrluH1hhckOKXbuc
	wv5EQX8hbEv46a9EsLwYltfkT+ipchjSnsbB4f3QGYY3791Ci8JOHlhQ+rvKTLXzv45TFDcut0B
	ncT/rZzIjb27B2OSWq2KTLY9U35gbPwooWUPC54Emuw8efbVlzZZVipiCUR0CtLNy+hX+AOP+j+
	sEgD3uFEUgfZugopNshfThVFECBTmJaedf0fPG/dIYVH9+ziqNp/zCoF9VQNPvj6zm4n
X-Received: by 2002:a05:600c:8b8c:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-471178a4af1mr109338145e9.13.1761080255564;
        Tue, 21 Oct 2025 13:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnSG23+FoLb+GmLuXvkTK9R1YegvexPcW+2uOk5jzx98hZ61iH9ju7jBpY4P6BKlTjZs87DA==
X-Received: by 2002:a05:600c:8b8c:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-471178a4af1mr109337965e9.13.1761080255096;
        Tue, 21 Oct 2025 13:57:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428e9b2sm9981535e9.5.2025.10.21.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:57:34 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:57:28 -0400
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
Subject: Re: [PATCH v1 06/23] vmw_balloon: stop using the balloon_dev_info
 lock
Message-ID: <20251021165626-mutt-send-email-mst@kernel.org>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251021125929.377194-7-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ru_bjos4mSKVaJuW3H92e4yP8HM88LAQzGqjLWcotnY_1761080256
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 02:59:11PM +0200, David Hildenbrand wrote:
> Let's not piggy-back on the existing lock and use a separate lock for the
> huge page list.

which is fine but it is worth documenting that we are also
no longer disabling interrupts while taking this lock.


> This is a preparation for changing the locking used to protect
> balloon_dev_info.
> 
> While at it, talk about "page migration" instead of "page compaction".
> We'll change that in core code soon as well.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/misc/vmw_balloon.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 52b8c0f1eead7..53e9335b6718c 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -354,10 +354,15 @@ struct vmballoon {
>  	/**
>  	 * @huge_pages - list of the inflated 2MB pages.
>  	 *
> -	 * Protected by @b_dev_info.pages_lock .
> +	 * Protected by @huge_pages_lock.
>  	 */
>  	struct list_head huge_pages;
>  
> +	/**
> +	 * @huge_pages_lock: lock for the list of inflated 2MB pages.
> +	 */
> +	spinlock_t huge_pages_lock;
> +
>  	/**
>  	 * @vmci_doorbell.
>  	 *
> @@ -987,7 +992,6 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  					unsigned int *n_pages,
>  					enum vmballoon_page_size_type page_size)
>  {
> -	unsigned long flags;
>  	struct page *page;
>  
>  	if (page_size == VMW_BALLOON_4K_PAGE) {
> @@ -995,9 +999,9 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  	} else {
>  		/*
>  		 * Keep the huge pages in a local list which is not available
> -		 * for the balloon compaction mechanism.
> +		 * for the balloon page migration.
>  		 */
> -		spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
> +		spin_lock(&b->huge_pages_lock);
>  
>  		list_for_each_entry(page, pages, lru) {
>  			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
> @@ -1006,7 +1010,7 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  		list_splice_init(pages, &b->huge_pages);
>  		__count_vm_events(BALLOON_INFLATE, *n_pages *
>  				  vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
> -		spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
> +		spin_unlock(&b->huge_pages_lock);
>  	}
>  
>  	*n_pages = 0;
> @@ -1033,7 +1037,6 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  {
>  	struct page *page, *tmp;
>  	unsigned int i = 0;
> -	unsigned long flags;
>  
>  	/* In the case of 4k pages, use the compaction infrastructure */
>  	if (page_size == VMW_BALLOON_4K_PAGE) {
> @@ -1043,7 +1046,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  	}
>  
>  	/* 2MB pages */
> -	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
> +	spin_lock(&b->huge_pages_lock);
>  	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
>  		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
>  
> @@ -1054,7 +1057,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  
>  	__count_vm_events(BALLOON_DEFLATE,
>  			  i * vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
> -	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
> +	spin_unlock(&b->huge_pages_lock);
>  	*n_pages = i;
>  }
>  
> @@ -1828,6 +1831,7 @@ static int __init vmballoon_init(void)
>  		balloon.b_dev_info.migratepage = vmballoon_migratepage;
>  
>  	INIT_LIST_HEAD(&balloon.huge_pages);
> +	spin_lock_init(&balloon.huge_pages_lock);
>  	spin_lock_init(&balloon.comm_lock);
>  	init_rwsem(&balloon.conf_sem);
>  	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
> -- 
> 2.51.0

