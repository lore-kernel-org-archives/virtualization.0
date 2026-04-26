Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FB21B9F6
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240062; cv=none; b=kR81Kxp0K0N9kl2KTFs3bXCaCaK9r7R0OzLel/m0KCa2//Z3p9CE70vtrVxo2EVMK7p4jqBXRr94f0jGYdHiWZze4yyyufqJmu3SSDi8EuWdwupVPEpSq8QDGE55qO3JLKQz8Z+hROGpY/igGK38dhFIHv2WCw/2HjjLF5wDfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240062; c=relaxed/simple;
	bh=3yv7g0qz2r8KeF7Q/4i8eq2vYhnDxLUrftD/JPsDNIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qrNE2BrF4Tfu6lQ6inJ+/wHodcrLBw6ktvTAK1J78fTzENKJWqNR6y7DWPsAdS5GKYYsDWTp1MiuGJs31kwJMhuI15cjLp747ZmlLe3cDovw8uIoSRk62DT1KrDMYoUDHQWuhTAMcC9+qaacBiCCuUAx7harw7OG/dc2GaJ7ocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXYaGlOg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXYaGlOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXr1u1aEvptlqN9vuxArrnVOz3uXJxzDs4ChyPf8Auw=;
	b=RXYaGlOgPfzRmZgzkBBEu2j+sDfnlHYDCmE9j6mhMAwgkGfChrn7rgZ6HAdg74ehBxaFFZ
	roOyL2rFodsCOdRW5To8N/2v5BePHvhthwadSNco9+/uxwphQQSZRPZBGUEuCzc1N+SKp2
	+JMdkPheRRbkgiCYF2CZwUb7wk5EGok=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-ovqvh8E9P5GykFyrRRc3qw-1; Sun, 26 Apr 2026 17:47:38 -0400
X-MC-Unique: ovqvh8E9P5GykFyrRRc3qw-1
X-Mimecast-MFC-AGG-ID: ovqvh8E9P5GykFyrRRc3qw_1777240057
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so6059468f8f.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240057; x=1777844857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXr1u1aEvptlqN9vuxArrnVOz3uXJxzDs4ChyPf8Auw=;
        b=LhJx9xma5g3FXdxDivmXOTP3Agiyy+hh8dzUBek4zvKwKUya0yu3Fr3zhNSeJBYtk+
         9l+5Ekakk6FOcw78LnFk02ip9EtmOus5CbceSEG6uxOgaobjndvfswLo+L7wivyypObI
         EpGcM2lac3asEnAU7chAQFOyxYVU8ZPkzhSk3eV/v0x1zUWjG3+E8t6F+hFwE0/wc7qZ
         7NkKDazOCnyEwJ5IWtXCZyqUNqSoCjt1m6rjnslpbSFIaQVyD8c1vNkl0ZclKYuG0VHB
         VvJlw6TSek36CY4odQSY7LgE/6L5xNOkkIBD0+0RgpUKEg6eG1tR4+TPRxgfIGHB4wUZ
         ezMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+z9Ra7vl/0y7Ns2iVoQYAbFZXnYAaKFzqYP5+80IPmntMkwQR//rQFXxfJR5VeidqnVYKq2HkbiNZVUKegZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4RZaSgNoX3pUKNewXqBCAYPiuuFsxeeTcpG947gOJ1P1+qHzK
	3qduya136gPhTGm7LpusitFYNKuwYueYN2Xuo7kwTNEXTHjw5n7IMrjRBkW4T4UIqnn3nhC/Mbf
	+t3GHu36Awu1LaJM72+3ZQodhikkW/yTk16JhzzSDZNJ/psSVTjtf17a4T8dWS0agSEo1
X-Gm-Gg: AeBDieucsW4vonLKdSjlFt0J0tY4mD0oP6mxSEIqgcM//y1DzvCecWDN+kf+hqTz5sI
	RDHBExm0QgFoPJS8pYKH5szz2HN8OooO9MqNl482kKikLxAPpkoROdmw5kcGE9YWGKPR1wLxOBP
	HCCuGZCO4dlO9pUP2MRj7BLE1J9jXbce7Jb7YuUaa6O3Name528ACBQsr+MTI44vn/QpDABMgaY
	wqscqkhm4srPu7xLtEe/b3D1dGmL4+Wr9wBpV14s/+YyFCfJTpnn74g8I8r0mdXpq5fBaQ9XkeM
	bBziNs+HYsChS1737vjjVZEdvJv0FAZHjVXfMWOVUZuoKZGd3IlsOQ5H2K4caXNuNcGLwfWuuUi
	+V+RQwuvyg7YF5tLIcmGRX/vjE0wEgY7w0q0ytRo+paH/t7yBPOOxXORo
X-Received: by 2002:a05:6000:4709:b0:441:2397:f40f with SMTP id ffacd0b85a97d-4412397f431mr33246991f8f.4.1777240057115;
        Sun, 26 Apr 2026 14:47:37 -0700 (PDT)
X-Received: by 2002:a05:6000:4709:b0:441:2397:f40f with SMTP id ffacd0b85a97d-4412397f431mr33246952f8f.4.1777240056601;
        Sun, 26 Apr 2026 14:47:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm73823721f8f.33.2026.04.26.14.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:36 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC v4 01/22] mm: move vma_alloc_folio to page_alloc.c
Message-ID: <a51fc0bcb09e50dcc467d0d336f324922742a0b0.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cB67T4Ofcz-F-nKW09eqpCRLd0wCahz1YQB21LWmurg_1777240057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move vma_alloc_folio_noprof() from an inline in gfp.h (for !NUMA)
and mempolicy.c (for NUMA) to page_alloc.c.  The declaration is
moved outside the #ifdef CONFIG_NUMA block so both configs use
the same real function.

On NUMA, it calls the mempolicy allocation path as before.
On !NUMA, it calls folio_alloc_noprof() directly.

This prepares for a subsequent patch that will thread user_addr
through the allocator: having vma_alloc_folio in page_alloc.c
means user_addr can be passed to the internal allocation path
without changing public API signatures or duplicating plumbing
in both gfp.h and mempolicy.c.

No functional change.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  9 ++-------
 mm/mempolicy.c      | 17 -----------------
 mm/page_alloc.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 51ef13ed756e..7ccbda35b9ad 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -318,13 +318,13 @@ static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
 
 #define  alloc_pages_node(...)			alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))
 
+struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr);
 #ifdef CONFIG_NUMA
 struct page *alloc_pages_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 		struct mempolicy *mpol, pgoff_t ilx, int nid);
-struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr);
 #else
 static inline struct page *alloc_pages_noprof(gfp_t gfp_mask, unsigned int order)
 {
@@ -339,11 +339,6 @@ static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int orde
 {
 	return folio_alloc_noprof(gfp, order);
 }
-static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
-		struct vm_area_struct *vma, unsigned long addr)
-{
-	return folio_alloc_noprof(gfp, order);
-}
 #endif
 
 #define alloc_pages(...)			alloc_hooks(alloc_pages_noprof(__VA_ARGS__))
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0e5175f1c767..f0f85c89da82 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2524,23 +2524,6 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
  *
  * Return: The folio on success or NULL if allocation fails.
  */
-struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr)
-{
-	struct mempolicy *pol;
-	pgoff_t ilx;
-	struct folio *folio;
-
-	if (vma->vm_flags & VM_DROPPABLE)
-		gfp |= __GFP_NOWARN;
-
-	pol = get_vma_policy(vma, addr, order, &ilx);
-	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
-	mpol_cond_put(pol);
-	return folio;
-}
-EXPORT_SYMBOL(vma_alloc_folio_noprof);
-
 struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
 {
 	struct mempolicy *pol = &default_policy;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4b6f1a554e..0e6ec7310087 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5297,6 +5297,34 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
 }
 EXPORT_SYMBOL(__folio_alloc_noprof);
 
+#ifdef CONFIG_NUMA
+struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol;
+	pgoff_t ilx;
+	struct folio *folio;
+
+	if (vma->vm_flags & VM_DROPPABLE)
+		gfp |= __GFP_NOWARN;
+
+	pol = get_vma_policy(vma, addr, order, &ilx);
+	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
+	mpol_cond_put(pol);
+	return folio;
+}
+#else
+struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	if (vma->vm_flags & VM_DROPPABLE)
+		gfp |= __GFP_NOWARN;
+
+	return folio_alloc_noprof(gfp, order);
+}
+#endif
+EXPORT_SYMBOL(vma_alloc_folio_noprof);
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
-- 
MST

