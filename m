Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0A2D7DE7
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089769; cv=none; b=rzkeRNAlAXcQPJ+ME/YOWsOgzyg4XoQh3bdJAJZm0BYmGuFMIKaIsaE11RVIWwbb5Dq4noofmTHkKjbg9+trerMy/v1nINIVh0TFJXWIPoCy++78JyLicjOa4d3F8y4dlPqhnie7M5agD4ofznaqeVkc5a8Pb/T6WvnvWp+zuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089769; c=relaxed/simple;
	bh=LXvIBwQKlwN2aW+nel9nihwfIG/BNCGtqaNljMXS3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mAfJFl4zbXcZOtI5E3ElkxDYNln0Q6X52hqO4IVbjRLjqbEsS/1MIPXcNMcFj5rd0gxC3YjBQ4uOc3LHWxuQnU258Evt4jE3PY+/RSC9JB5ZsDtTYKWRVB+2FZLus/efcuo3u+RWG/5VUhJb+RiISdmMADhQCKe/aFnd/r87Gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5mWhlFM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5mWhlFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbbLRn5SB4hmqpKO67RyzNkOjJr20Ge6MiEXlRieQIA=;
	b=b5mWhlFMcAhJf5HHdiDR2c+GwG4NDncHv3QaphrnnAmHJ2W0f8uaXjGq84AqZaug3wk0Kw
	+McRoAikSlwp2cbFKxwPy8UVkWluP6Td3pu3JOuGxnd0zf9qfMYGbY4n4P+6ID1Ycf9BDo
	VF2YjugYxCwMlyrmE/gx6RMdieuiTG8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-H_X11_ECOWqxGaXVfDXpsg-1; Tue, 30 Dec 2025 05:16:05 -0500
X-MC-Unique: H_X11_ECOWqxGaXVfDXpsg-1
X-Mimecast-MFC-AGG-ID: H_X11_ECOWqxGaXVfDXpsg_1767089764
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so8253101f8f.3
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089764; x=1767694564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbbLRn5SB4hmqpKO67RyzNkOjJr20Ge6MiEXlRieQIA=;
        b=MFb6ALU7cTO1kaeGFDN9EeqFvNHiEWPRaxNqKDuGwObAU4fdHb5onZ/EXCxRA3WaL+
         KWqGF/cLuhdUMt7QOUBosSebrv5pLQ0T/CHQo6jRH3PasNZe8DQmifAY7TpWf+qTlm1K
         sKgYXGYLF6EvwiGYB9AMCXNAjJP1haJk0EJ+VWeoIJD/UQMgjOrtLlzvK2r0zT+hsCdk
         379JSlxTenguvMHdp061wa4j74IeJnzZq/82X6YQq7ylTw1Q6lX/wdHbFT3byrSUrSiA
         bzcnXD496f3+3QacQDguhJp+/NQxTZ0l7Yw0cKWpf0bSHFmhSNyZ27Iqfn0umv8jBvQL
         E9vA==
X-Forwarded-Encrypted: i=1; AJvYcCXLHN5oYZLd0AcgzPdLHxazsKxvuLx8dqm+B+5M/9HU2fmDWHz8fsrtaSGrJq4n7ypBZZcmqEyr47nqShJYAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6IriHAE/KEesqyHHB8Tk0sxo8QJxLv0CPQ2AixM/l/in84iTe
	6NgVdSttgTKunWwHa/v/QFJ2cGf5/uQVnQpN5cc+brK8XwrMK1007am8ZVAgUhKvnBuE4Sp3U5H
	ZLQ6KXWKw6cELZ/tmhLM7G6QbCzioMHistub4KvpG/ofl1FHQ9KlDm37+ntlpDsgVW+Qu
X-Gm-Gg: AY/fxX7cNLoKFoHONzj4Y+i13mDFu08Ha8zs5AZBuNiHH4yNifZfBcCaGkk8IZ1mGuR
	WBLQizEXzOtTMz9HJ9cm7xwsBWxB/sNO1LP8vK81ak101PQ0+6R0f6lQbJDscP8OC4FN/O6OP4N
	ALDHtm/dIp0NJa3KT6EyNUUvvPFnnIYT60iYmUEtK9724rW0ZkTwuDyUlI4wiziI3X6g7zWSCiN
	OzzrP83fDGHzJwYs8150TiJAMARhHwGn+UtoSa/dBXcTAeQ1glaVpSrN38b0K0ZIDofEbJVU7Tz
	2MUIZDBDGpfsEIr+nyOb4WLycpR1wpmc913BnaLgcVs1YmWo8X3KAj2EKQgblJPnCQL+IWVMPoy
	BzT+40y1w52iUTfpDP2YyzOMUgPGhFOMYFg==
X-Received: by 2002:a05:6000:200e:b0:430:fcf5:4937 with SMTP id ffacd0b85a97d-4324e4c3e1emr38658328f8f.7.1767089764003;
        Tue, 30 Dec 2025 02:16:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK1atjAKrkdoWQy4jxFj2rw+qTn5U0Lh0sTEHql45jv1yC6jgv8gOxch8xQ2S/3gi1ay54uA==
X-Received: by 2002:a05:6000:200e:b0:430:fcf5:4937 with SMTP id ffacd0b85a97d-4324e4c3e1emr38658276f8f.7.1767089763428;
        Tue, 30 Dec 2025 02:16:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm66936468f8f.8.2025.12.30.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:03 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:00 -0500
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
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 05/13] dma-debug: track cache clean flag in entries
Message-ID: <c0df5d43759202733ccff045f834bd214977945f.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: roAR8HW49dcsnmykClq91oKJsvig-u14_WvwtnG_lDY_1767089764
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If a driver is bugy and has 2 overlapping mappings but only
sets cache clean flag on the 1st one of them, we warn.
But if it only does it for the 2nd one, we don't.

Fix by tracking cache clean flag in the entry.
Shrink map_err_type to u8 to avoid bloating up the struct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 kernel/dma/debug.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 7e66d863d573..9bd14fd4c51b 100644
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
+	u8		 map_err_type;
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
@@ -487,8 +492,14 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
 
 	spin_lock_irqsave(&radix_lock, flags);
 	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
-	if (rc == -EEXIST)
+	if (rc == -EEXIST) {
+		struct dma_debug_entry *existing;
+
 		active_cacheline_inc_overlap(cln);
+		existing = radix_tree_lookup(&dma_active_cacheline, cln);
+		if (existing)
+			*overlap_cache_clean = existing->is_cache_clean;
+	}
 	spin_unlock_irqrestore(&radix_lock, flags);
 
 	return rc;
@@ -583,20 +594,24 @@ DEFINE_SHOW_ATTRIBUTE(dump);
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

