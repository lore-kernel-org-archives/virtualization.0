Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E23313295
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601400; cv=none; b=HvRZFHJbijGUd1O6gelkbnPPgowV+oydSpSP0fMM1NubVlNnKCX1Htq934AWmVpLA6agjAxwlM17STR5e9b/zuKS2VtA7tCjmI6gDLUSDcEPZhl3Pa2MXp/XmYbvhw6j7toJOdYxHkzlR3qKEQKXSLaDnC1pnootufuhgRHHZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601400; c=relaxed/simple;
	bh=9iEzgPHvQMQc1JPQHZR4+0WH0pS0RVDvpJpTVteo84E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y8Mprqq8kUB4AfNv+0o6j9H4WXvlg34bJ6cQ7mwJ02W2HhUMJA3y8RMBzWM0e6ag3ZKf9B/A/xJcqjWK4R50tQpAtFLVPXhpQflXTS691iI2AKR9j5ZAUmbeEFoVfAOyELVAaQXXsuHOfeTCEx4RieszFqW+up6HO3VCa98dUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkJ9m35O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkJ9m35O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ceg01Cw9H4aJK1m/G33nz2CzBje4q7tNz5vOwZlPzjQ=;
	b=OkJ9m35OxyogYFe81sl3PtZ+rAxvLVS8Bj/sQwvCGn1yKxcIpEh2GHLFKUq0oda106zQ3i
	NevIe6tIPBMmAU8VArmEXiy9noLdP1uSsCsNQdRXs6CbbLoyPNgod4l2VSh/nC1YWwXqOW
	fySZXCEgl/RuGchr/o0Z5Xov5dGCa5E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-ge-bGG21OXuIhyXwUs2tyQ-1; Mon, 05 Jan 2026 03:23:15 -0500
X-MC-Unique: ge-bGG21OXuIhyXwUs2tyQ-1
X-Mimecast-MFC-AGG-ID: ge-bGG21OXuIhyXwUs2tyQ_1767601394
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d17fff653so51068435e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601394; x=1768206194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ceg01Cw9H4aJK1m/G33nz2CzBje4q7tNz5vOwZlPzjQ=;
        b=UQbxsN4RVftITHf3g9L1bwMtHHZVg1ZMqIvwKUdfyYWWNukj36TT9NlXWW1Y3tzv+t
         OA+fV7q8WqYzg8koQwT2hUWIaQYS2+xxDiLntxrUrYlTjsJw0uR4aVLqWRR20TnyGp0p
         8MT1Miod8CpIv7Y3ujSDincq+XxbaO7DCgzmWQmgGzvltLGIa+6YijxXozAKlpyFS4CV
         xlMxVssWjGcZyOCWJDrHreGjcMS1ladWwuFRfg+clkT/ZXOoOnV48q1KQleASkN08EJl
         ULIs+Yo+H9jdqWavnOVyu820vTw29nkTdKUwi4bxj4U9vQwscLe55C4Qt/+3aeIAG8F8
         pZHA==
X-Forwarded-Encrypted: i=1; AJvYcCVf819GPB/n2ubnk6LksRIlns9yzPtE5Y8ku4w3nsbVTi26PSAmZQxvGD77wvficD+TwYlmAE1r8a8fAIc3Ig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK96SNVFShbtho6/NiWjNdXCS8v9eQbsJhahZlCN9fyabHPl+I
	7T16ZSRdoKJMKJqvNvolPfbOys4aQaG/vlxnfMShy1msK9Vi3+dGOYEa5JsEHo0mbFmii1X1CQH
	wbQ13N0zmNGz6b6ZWzYFuz/MmcCFhGk5OijjBLwOTEj3K7oI5U2hAEFA1qasy69m5ZuRM
X-Gm-Gg: AY/fxX6u2KZz4sDsByogix9egFKPG7/VgFp66jvrigxFOtXgtxvtFltCVdzbZWe/ePX
	CP4PQUx54+Xh1+kjzcuzT2qaaBzc9bAXMgwmHVSFq2vYlrdXCWxUo7AZtI2YBXoAPdJk0t1jFJ7
	xWgbqwojuGSpv/uy0AYG76L1xMvB7zrLzkcKDzTHBawp4jiPMysz2Wh2ByL1eSZN34uCP+Yj+kt
	unOScEsmU6rB19L3R7l2LyB1+HHsMkk7aYdQmon3l0AIze7V3DbcRchTPLbHrd/6T8qNmYBwJR9
	hlZ9dS9/0JspAVf4qmiUiYz6xq1NKdNFNam8dCPdPcJz78apg6WeJpnXBR7DRf5NGJf+2+IexN1
	dv10uwD7gsB4t1VcQOwnxQiiVltSLqeO/DA==
X-Received: by 2002:a05:600c:8710:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47d19592102mr548338295e9.25.1767601394176;
        Mon, 05 Jan 2026 00:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQnvRLWDf0aCqCDaI87q/fN7cE8aCZoYxHw4jznq03tUl25BjWNTLdD3S8QBVZUoY2t9i3vg==
X-Received: by 2002:a05:600c:8710:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47d19592102mr548337795e9.25.1767601393663;
        Mon, 05 Jan 2026 00:23:13 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed34sm142315025e9.2.2026.01.05.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:13 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 05/15] dma-debug: track cache clean flag in entries
Message-ID: <0ffb3513d18614539c108b4548cdfbc64274a7d1.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XFZWSdsDiCiakimQvUb2lwK2XBMYnqbR2TVFLcA6yW4_1767601394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If a driver is buggy and has 2 overlapping mappings but only
sets cache clean flag on the 1st one of them, we warn.
But if it only does it for the 2nd one, we don't.

Fix by tracking cache clean flag in the entry.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 kernel/dma/debug.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 7e66d863d573..43d6a996d7a7 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -63,6 +63,7 @@ enum map_err_types {
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
  * @paddr: physical start address of the mapping
  * @map_err_type: track whether dma_mapping_error() was checked
+ * @is_cache_clean: driver promises not to write to buffer while mapped
  * @stack_len: number of backtrace entries in @stack_entries
  * @stack_entries: stack of backtrace history
  */
@@ -76,7 +77,8 @@ struct dma_debug_entry {
 	int		 sg_call_ents;
 	int		 sg_mapped_ents;
 	phys_addr_t	 paddr;
-	enum map_err_types  map_err_type;
+	enum map_err_types map_err_type;
+	bool		 is_cache_clean;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
 	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
@@ -472,12 +474,15 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
 	return active_cacheline_set_overlap(cln, --overlap);
 }
 
-static int active_cacheline_insert(struct dma_debug_entry *entry)
+static int active_cacheline_insert(struct dma_debug_entry *entry,
+				   bool *overlap_cache_clean)
 {
 	phys_addr_t cln = to_cacheline_number(entry);
 	unsigned long flags;
 	int rc;
 
+	*overlap_cache_clean = false;
+
 	/* If the device is not writing memory then we don't have any
 	 * concerns about the cpu consuming stale data.  This mitigates
 	 * legitimate usages of overlapping mappings.
@@ -487,8 +492,16 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
 
 	spin_lock_irqsave(&radix_lock, flags);
 	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
-	if (rc == -EEXIST)
+	if (rc == -EEXIST) {
+		struct dma_debug_entry *existing;
+
 		active_cacheline_inc_overlap(cln);
+		existing = radix_tree_lookup(&dma_active_cacheline, cln);
+		/* A lookup failure here after we got -EEXIST is unexpected. */
+		WARN_ON(!existing);
+		if (existing)
+			*overlap_cache_clean = existing->is_cache_clean;
+	}
 	spin_unlock_irqrestore(&radix_lock, flags);
 
 	return rc;
@@ -583,20 +596,24 @@ DEFINE_SHOW_ATTRIBUTE(dump);
  */
 static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 {
+	bool overlap_cache_clean;
 	struct hash_bucket *bucket;
 	unsigned long flags;
 	int rc;
 
+	entry->is_cache_clean = !!(attrs & DMA_ATTR_CPU_CACHE_CLEAN);
+
 	bucket = get_hash_bucket(entry, &flags);
 	hash_bucket_add(bucket, entry);
 	put_hash_bucket(bucket, flags);
 
-	rc = active_cacheline_insert(entry);
+	rc = active_cacheline_insert(entry, &overlap_cache_clean);
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST &&
-		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
+		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(entry->is_cache_clean && overlap_cache_clean) &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
-- 
MST

