Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313543B19C6
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907856; cv=none; b=oTQGrbkIUKaqpCEh2RquB7yqa/9qS4rqMbV6detp79rY2rV1gJ0ujOqcwQ0cmzHDXIJgAAcC3kM9wobo2FETZLGTkhPcwJQZFI9AyuEmPkogFj0xaIJ72kSNSqu6E4SKVXVe5g/gqUloiIWP9qiviyZjcpVOPABMTKH6so2FUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907856; c=relaxed/simple;
	bh=OHWxGJkJbozNCm8KAs+71lxyLWxsCrak///2e95AF4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lQVFgmMQ5rojyNMUo2xErecy/cSs/viykaAXpGgJuz0d9sJOqeHuD9d1eIEPEmihggX8Vx+rx/ang8ex8WeDrKyy/vKgpuWEPDVhK5YEKA34OTeET/a6DtrTY0coKFOv2iXdQtk2magkBoKJ3WNZjb6cxjgADQwCKLmrzffs8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/eOA3mZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/eOA3mZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tltobG27QNK6CnGoNCrb5i/6pgzOGIIyEcQIJDK7QRA=;
	b=A/eOA3mZupXIehi0aYYlFcpAkC5n9qjuR6rJC6Pz30wuHGW/Y+HI56zYBBLlGCV5zqpnIb
	tKLUQ3nA/hO0/YqP6kZi/cvAP/HKTLPQWiDicqyvkDgU/mzU94717IKyQNvkPgq/8SeriN
	6qknD+3q5FzO6h95jzhaGrtk3LLjZFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-DXt18XymNFucpawVrAEK_A-1; Mon, 08 Jun 2026 04:37:27 -0400
X-MC-Unique: DXt18XymNFucpawVrAEK_A-1
X-Mimecast-MFC-AGG-ID: DXt18XymNFucpawVrAEK_A_1780907846
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso29989455e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907846; x=1781512646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tltobG27QNK6CnGoNCrb5i/6pgzOGIIyEcQIJDK7QRA=;
        b=L+XjAoV/Ty1eneXb3669uFGzIzL2g0otjy+eJlSXC+RXRUXyUPuWxOygwPoKE6FL35
         WTch3Do1TdOAK9a9EORo+uquPu7o3pb4Al8CNkdWQYpGVQ4Cp2SRUEMOHBuwoGBo8azA
         oyE9LE7h+6yDIV4QXmV6oKhhyT7WpJyG8aHzq9xPlIfpM4D88c+5V68LhZ7XK7NU3Pc0
         Fo4P6pFBagYmTmtpuhvi0yRLE5Fy+f8E/bnb2iF6NSDCZGSkpJTuFTOnKrDvfjRQ/ygv
         LQD7MAYO88wGHt761aKjQoQBH5R08nNR0FRHdb7ih3E2Yulat1va2V58RId+WIO6VvXb
         yrxg==
X-Forwarded-Encrypted: i=1; AFNElJ/mXDnbNPXztQw0s/XBeuSjsIkKsLiYpiFnmzCSM3nMqR1w50vafdu33OO4W4RTKBONZQWkqCvz6ONKfvhBsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYT3HaJK0ZEoOexTCorXZrvWKACmoj9t1AcQ6iXIh1zWOl0MCR
	K9MMwhoEz5cgTkE1jVW15pPxYSCLpQg1uvyH3etMaM9YnAls0HLuUtqf8ACswNiRwjTIZEiN/Xv
	NTu+D+8Y6lwGIqM/RXb0L2Nrx1XzAq4emUbiReVTY8DbD2ciRzw7NLExCuMtdg0KmvfIu
X-Gm-Gg: Acq92OFwUWgksxWWs2R6NOSxtSZNaV4Pvz63kpdqb2yTBHNe4rndmU0IJs9XH2RJnxv
	fSaUe0fHuLyise3SSAD+kjVfgsBH6qcFSFQbLvBNndbQMAd9TuDEug9YgrhJpGJlFMEFNlaGaHH
	V/CcrWC9NXR2qnNqGl0ORxZGTITLDPfoNSVw8eEvdmDnPQkD08MmcSDkunUAAS1jc+WrBmS7Ob2
	sl7o2/nc6ghjR6Gg2VamwK4kNIAdOOEv1lB5wmLZZEc8XHBCkhg4ZyOrllUbwyBk22kExUkPeov
	XTisQre440DsCWRlkTnQohavNlwwEWTHZrRC62SLgclR+saZrz8pAmKXHUsD8QKJAI/Pw5lct/F
	rHlJwlKVpiVuFFqxEFtBaNqM=
X-Received: by 2002:a05:600c:4fc6:b0:48f:f7cc:f6f5 with SMTP id 5b1f17b1804b1-490c2614167mr244773045e9.31.1780907845598;
        Mon, 08 Jun 2026 01:37:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:48f:f7cc:f6f5 with SMTP id 5b1f17b1804b1-490c2614167mr244772255e9.31.1780907845077;
        Mon, 08 Jun 2026 01:37:25 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e5a00sm375786835e9.15.2026.06.08.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:37:24 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:37:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
	Gregory Price <gourry@gourry.net>,
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
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v10 14/37] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <c374d7a35a35eb4bd5ed85f87ff6885fae605fa9.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7qltARRcnzs96_GME559_jX9UwLnzqoZdkTLywqPXjA_1780907846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that the generic vma_alloc_zeroed_movable_folio() uses
__GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
x86 that did the same thing are redundant.  Remove them.

arm64 is not affected: it has a real function override that
handles MTE tag zeroing, not just __GFP_ZERO.

Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 arch/alpha/include/asm/page.h   | 3 ---
 arch/m68k/include/asm/page_no.h | 3 ---
 arch/s390/include/asm/page.h    | 3 ---
 arch/x86/include/asm/page.h     | 3 ---
 include/linux/highmem.h         | 8 +++++---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 59d01f9b77f6..4327029cd660 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -12,9 +12,6 @@
 
 extern void clear_page(void *page);
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 extern void copy_page(void * _to, void * _from);
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index d2532bc407ef..f511b763a235 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -12,9 +12,6 @@ extern unsigned long memory_end;
 
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #define __pa(vaddr)		((unsigned long)(vaddr))
 #define __va(paddr)		((void *)((unsigned long)(paddr)))
 
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 56da819a79e6..e995d2a413f9 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -67,9 +67,6 @@ static inline void copy_page(void *to, void *from)
 
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #ifdef CONFIG_STRICT_MM_TYPECHECKS
 #define STRICT_MM_TYPECHECKS
 #endif
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 416dc88e35c1..92fa975b46f3 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -28,9 +28,6 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 	copy_page(to, from);
 }
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #ifndef __pa
 #define __pa(x)		__phys_addr((unsigned long)(x))
 #endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 8b0afaabbc6e..642718a50c27 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -303,7 +303,6 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
 #endif
 }
 
-#ifndef vma_alloc_zeroed_movable_folio
 /**
  * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.
  * @vma: The VMA the page is to be allocated for.
@@ -317,12 +316,15 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
  * we are out of memory.
  */
 static inline
-struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
+struct folio *vma_alloc_zeroed_movable_folio_noprof(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
+	return vma_alloc_folio_noprof(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
 			      0, vma, vaddr);
 }
+#ifndef vma_alloc_zeroed_movable_folio
+#define vma_alloc_zeroed_movable_folio(...) \
+	alloc_hooks(vma_alloc_zeroed_movable_folio_noprof(__VA_ARGS__))
 #endif
 
 static inline void clear_highpage(struct page *page)
-- 
MST

