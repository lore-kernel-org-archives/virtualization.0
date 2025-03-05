Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818524F594
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188406; cv=none; b=r8six0Ck1W0zm6x6+r3wYGeC3AYn1AYjE1xrbjKAqaUpMxROXDwI6XhSmTCzZoWk186mvz2ZVK+5WDmpU8ZX21md5hBTQCZVfFt8Q50KG5udSFPq+4x3O4QhRkM2xkjQicJbrhPbkz/iPNbz6HngAur0x+npdU0euO4PyxB+gNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188406; c=relaxed/simple;
	bh=rFm7PHeSc25dzGeWR07reNqJ158j+USs1E2yMw/XqQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oXKkW/v2eByBahI9xzkaQTIEninP5o0ZZHzqW9cMPjPJIfkLl5/qfCs6WhFIFXgUEl0c1gEe+qTnf9jO9rHZ565D8LM0e4D13wwiQZGPXQTAP+OU3JATczFFKCNyXSdvpBsXA5ragjWWeoLstPlVpGWe8y6XVIQoyrVz2836Z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/vhgZfN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/vhgZfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741188403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mzd4XGn+uFEzS0vbdAuX3w3DrwjWbNhsj0Skkz0C+/o=;
	b=Q/vhgZfNvzA030aN8X4yZkYvHRqOGYgGdiCv8q2SfKt2532LFNtZVmZAzohuazgBOVINxC
	VgJvYwVRWy+A2WccXxN25hHrajWrupUIH1sAnaHRprOa3wWMA4HPkpT1/NOKwv8xfuhdvM
	BLZJwL43OA5n8ggyiD3gWPYUZmuU+BI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-MvjMmvCGOFejE7M-pw2GPA-1; Wed, 05 Mar 2025 10:26:42 -0500
X-MC-Unique: MvjMmvCGOFejE7M-pw2GPA-1
X-Mimecast-MFC-AGG-ID: MvjMmvCGOFejE7M-pw2GPA_1741188402
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22349ce68a9so69554295ad.0
        for <virtualization@lists.linux.dev>; Wed, 05 Mar 2025 07:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188401; x=1741793201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzd4XGn+uFEzS0vbdAuX3w3DrwjWbNhsj0Skkz0C+/o=;
        b=qVlGDC6p9eTz64QvO8JkR4vHUOCD4h2CMejrkxW1kEz1DT4MqJK5wEes3MUeEvJk8Y
         aU0z5fLMSATQVlOPDLz0D3uPtPL/yiGvl4QOwNYXX1ODuLbCY4qRRRZk2M6hSMvITrfV
         bTmx/u4z11bLLOA4vcqdAquLmae3G5l2iJtk8Mlul+NDzi5y+WUV5Vy3DlEABZlAPxdg
         GFw/UZhcuSzDxUi3FCSWNeWdoOQfutxPCi3t+EhNdXC2JmbEs+UhP+VYPe0fvYGdEtO5
         fdLQcRqnmFVGWSQYzNHhOuemC1lZRTsjl5fhr2CNcgBoiq2ZE4rrKngH1nmlUXt9ixfF
         XuVg==
X-Forwarded-Encrypted: i=1; AJvYcCXSBNYtIhkQZEbsWk8qqLHmRqy/g/aytmlrFbN7MtpfvCEkT8AKs4LKHrPi1RDIR3B3kk5DNpGXGD/0UnW2JA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhM3xzWwjNBAYYbcAR3HQf0GqPd18lxwMPE+wxly9vsllAqpO3
	DRdjYUCkkBk/k422hXhEkAvSmnYNKUZGG97y5w+KBV1zoLtqNBgcnKVFr0b8d6YoDOdbht6/Qld
	fILgmAkZT2OZjlpjHMlVz0oukrErlu++YnLyaG6lnlaD1id2Sg3iDPdBGb/PLpEtqRnCEcUwXMP
	Q=
X-Gm-Gg: ASbGncsPQdYtaSWIa1qlVwWZy2kN7oTZj6Gb6cNdX79xUmArqVCcRpsxh8WojX5NaIr
	2QGQjGPo8AB77raW0HmgO0AQhWrWdG/o4YNd2l+w3ov4mbu/KQ7AE73d0/lmYHzAzM/tHJqwrjk
	cTlhvHj+b1dxnpPC8L7IvXwZpCeYLWTr8Kvy5EkgK6vrAsyiadbze4YQQbkVolL0+AKApK49Uiu
	kW5Rb+9dZKlGvJwXIAVuKun3vjeUcyVh4zjhng7Q9BUxt5B7kwND9CKH+Gl0Uu/8CY/b3FusK0l
	2wTOQUcXqPsGOmGu
X-Received: by 2002:a17:902:d4c5:b0:220:ea90:1925 with SMTP id d9443c01a7336-223f1d20313mr60493095ad.35.1741188401107;
        Wed, 05 Mar 2025 07:26:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECC+BX4uW9YAdKPYnu6dCDuOObXXtjhxLSSHWa2EsQXKtadkIakYvJhvOdDY/oZGXAYMQVLw==
X-Received: by 2002:a17:902:d4c5:b0:220:ea90:1925 with SMTP id d9443c01a7336-223f1d20313mr60492655ad.35.1741188400762;
        Wed, 05 Mar 2025 07:26:40 -0800 (PST)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364b4eff66sm6983292b3a.83.2025.03.05.07.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:26:40 -0800 (PST)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	dmitry.osipenko@collabora.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
Date: Thu,  6 Mar 2025 00:25:53 +0900
Message-ID: <20250305152555.318159-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305152555.318159-1-ryasuoka@redhat.com>
References: <20250305152555.318159-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OpPLCWke5nv4jg6StLWZ5PTRM4irjjOBCrqBQ58SSMg_1741188402
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Some drivers can use vmap in drm_panic, however, vmap is sleepable and
takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
requests pages with GFP_ATOMIC and maps KVA without locks and sleep.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 include/linux/vmalloc.h |   2 +
 mm/internal.h           |   5 ++
 mm/vmalloc.c            | 105 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e3..c7a2a9a1976d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -190,6 +190,8 @@ void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
+extern void *atomic_vmap(struct page **pages, unsigned int count,
+			 unsigned long flags, pgprot_t prot);
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
 void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11..134b332bf5b9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1278,6 +1278,11 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_folio(struct folio *folio);
 
+struct vm_struct *atomic_get_vm_area_node(unsigned long size, unsigned long align,
+					  unsigned long shift, unsigned long flags,
+					  unsigned long start, unsigned long end, int node,
+					  gfp_t gfp_mask, const void *caller);
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
 				     unsigned long flags, unsigned long start,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a6e7acebe9ad..f5c93779c60a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1945,6 +1945,57 @@ static inline void setup_vmalloc_vm(struct vm_struct *vm,
 	va->vm = vm;
 }
 
+static struct vmap_area *atomic_alloc_vmap_area(unsigned long size,
+						unsigned long align,
+						unsigned long vstart, unsigned long vend,
+						int node, gfp_t gfp_mask,
+						unsigned long va_flags, struct vm_struct *vm)
+{
+	struct vmap_node *vn;
+	struct vmap_area *va;
+	unsigned long addr;
+
+	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
+		return ERR_PTR(-EINVAL);
+
+	if (unlikely(!vmap_initialized))
+		return ERR_PTR(-EBUSY);
+
+	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
+	if (unlikely(!va))
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Only scan the relevant parts containing pointers to other objects
+	 * to avoid false negatives.
+	 */
+	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
+
+	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
+				 size, align, vstart, vend);
+
+	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
+
+	va->va_start = addr;
+	va->va_end = addr + size;
+	va->vm = NULL;
+	va->flags = va_flags;
+
+	vm->addr = (void *)va->va_start;
+	vm->size = va_size(va);
+	va->vm = vm;
+
+	vn = addr_to_node(va->va_start);
+
+	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
+
+	BUG_ON(!IS_ALIGNED(va->va_start, align));
+	BUG_ON(va->va_start < vstart);
+	BUG_ON(va->va_end > vend);
+
+	return va;
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend. If vm is passed in, the two will also be bound.
@@ -3106,6 +3157,33 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 	vm->flags &= ~VM_UNINITIALIZED;
 }
 
+struct vm_struct *atomic_get_vm_area_node(unsigned long size, unsigned long align,
+					  unsigned long shift, unsigned long flags,
+					  unsigned long start, unsigned long end, int node,
+					  gfp_t gfp_mask, const void *caller)
+{
+	struct vmap_area *va;
+	struct vm_struct *area;
+
+	size = ALIGN(size, 1ul << shift);
+	if (unlikely(!size))
+		return NULL;
+
+	area = kzalloc_node(sizeof(*area), gfp_mask, node);
+	if (unlikely(!area))
+		return NULL;
+
+	size += PAGE_SIZE;
+	area->flags = flags;
+	area->caller = caller;
+
+	va = atomic_alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
+	if (IS_ERR(va))
+		return NULL;
+
+	return area;
+}
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 		unsigned long align, unsigned long shift, unsigned long flags,
 		unsigned long start, unsigned long end, int node,
@@ -3418,6 +3496,33 @@ void vunmap(const void *addr)
 }
 EXPORT_SYMBOL(vunmap);
 
+void *atomic_vmap(struct page **pages, unsigned int count,
+		  unsigned long flags, pgprot_t prot)
+{
+	struct vm_struct *area;
+	unsigned long addr;
+	unsigned long size;		/* In bytes */
+
+	if (count > totalram_pages())
+		return NULL;
+
+	size = (unsigned long)count << PAGE_SHIFT;
+	area = atomic_get_vm_area_node(size, 1, PAGE_SHIFT, flags,
+				       VMALLOC_START, VMALLOC_END,
+				       NUMA_NO_NODE, GFP_ATOMIC,
+				       __builtin_return_address(0));
+	if (!area)
+		return NULL;
+
+	addr = (unsigned long)area->addr;
+	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
+			     pages, PAGE_SHIFT) < 0) {
+		return NULL;
+	}
+
+	return area->addr;
+}
+
 /**
  * vmap - map an array of pages into virtually contiguous space
  * @pages: array of page pointers
-- 
2.48.1

