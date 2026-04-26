Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335A1B983F
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240066; cv=none; b=Vey0HlKLkofQN7JOYfIEIK0vucHlD0j9De5FyNELmawdv0HyJHZCt29YphmlWx7ZpSmXP1udO0AVzv66AaEZiacAIqEH/UrBZzCFx5fSiRIhuv1G1rBobxxF9UypbcbkM26byh/E9/BL3+PrraV2UxF5vqyYsA3mssRIxjLNtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240066; c=relaxed/simple;
	bh=BxAAIgTOcFIabrBhXgct8q9SxWHk4OL7KtA+YehjDgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lHN95jnanVe0FoEMS6pKJWlyaf3KSM5N0iJKM4pf0K8/kd3qxkbda8qXsn90UrK01cr7aP99i9b6YoecFNaiO0ZEwmkhAMBXbHV/5l84WnKSosVPJdxjjcgACywSDbGvTeLynl9HI2EIn4YhQun7f11W4yhGQU1xdUQ1dw15irU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKnyQ1fP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKnyQ1fP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFat/tQU1LWbkfRr9XYlFioABzGDJGEMsD6O36sEfN8=;
	b=WKnyQ1fP78RaF56Nfo35c0fpwnwWzFzObKfrIqMfKFbPsLkLtLbDqlCcVsjQXBlLIC4ikU
	sK8DRvoWWNeMRszQdrTMDuZF9XU+fa4aiYhDERwwqnT6uWs3Va9XH5LIOvKmQXjfk+5yYX
	pmWbY0ybCQjaWJkodinBejuApKREtJ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-VffE4TNDMCindCuDxmS_Tg-1; Sun, 26 Apr 2026 17:47:41 -0400
X-MC-Unique: VffE4TNDMCindCuDxmS_Tg-1
X-Mimecast-MFC-AGG-ID: VffE4TNDMCindCuDxmS_Tg_1777240060
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-440d12a472eso6750329f8f.3
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240060; x=1777844860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFat/tQU1LWbkfRr9XYlFioABzGDJGEMsD6O36sEfN8=;
        b=aYyfIY2G/0Wz8woRByqvI9Xsm86R4dGzRYSHjOnJnSpj0MQNa3bMXkvCJFHlKzDJTU
         8htCe+x1cztvml3SEzgAJvfvknTmk6IjJwFnWkhNwxeyq0SeJ3icpjLiUqqrjyfMgfdg
         uey/DI70eW1H2zvLSVcTWoOAAJOz9HGl6k52Xhg0mUYzpbUeWtQHb58Jkni9NoYnqknE
         eC106pnRncLBDVvet3C3RKiStoAjhgNGASQVfDIeMu9Z1eq+ywNXddvfBIn4Tqmx3NvX
         IGLVIdbFSIk22ym9H4ew+36BMCTjDX627h68LgSWqlXF+rea6cN69/99YsY51QrZ6wvr
         UQNg==
X-Forwarded-Encrypted: i=1; AFNElJ96R9pe8D7ChdkMdxSAF7kHm2vqaqmT+9/foxCU3u8FNHSD8iWNCl93XKb2dc2w5ZRQxqaBmhXk8dJLQW+6hw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5OjTk3C6uhx4TrKJKviytSAvzET6vEZkrxt2vYhaynUIISLyh
	BkzJlMSTFvwr5VRjlr/Or4uLeQkl/VgeqtvAYqMXDK4wIOoGWlgarrDO6qWU6a/JWnAZc8PQMAj
	N07avsF2d4GMJu1EpfRoaO6xAElbyxJJIDj3zGDKxpZjzeOS/td71XnTe62phAy65Kd3e
X-Gm-Gg: AeBDievzCyNrRHG7V5PiZKwwWxlLjIz8g/i9kq8cOjOPf+CjD8sn3WUNbF7fbDI2nMi
	AxnomOjbmh5afKb5bU6jhAdzgB1zI8UdEe8TMQUFjIxslHOtRMQAEjZ6jUsr0Ctyeg5DJJI9BLv
	ezS1JS8JAb+dXRttOCrNaPqVwiot6PRJIxHAE/ihJ7e1SMTBpHOB1A/0PFQKFYwmQJrt/p1qDE6
	ZX15nTtlJG1Gdj2akxFd18GhIKpmX6bFukPpJoSB2I+jEE2pw703ds8L9Fy/w8GpayuOdWYP2VN
	HcrD/4boXxmc+v9bJaOq8o2R4eEF78DZVfJdEusc0NYnRuDWnKxmgrW3tmc0kTjwA+HMus2Xmf7
	1RmuM9tBLV/ECxZPj1GsVaUERPto2Q+tBgTnZYEydQYFBte0kktOO9d+5
X-Received: by 2002:a05:6000:2309:b0:43f:e211:6e6 with SMTP id ffacd0b85a97d-43fe3db9b6fmr62507615f8f.1.1777240060004;
        Sun, 26 Apr 2026 14:47:40 -0700 (PDT)
X-Received: by 2002:a05:6000:2309:b0:43f:e211:6e6 with SMTP id ffacd0b85a97d-43fe3db9b6fmr62507584f8f.1.1777240059595;
        Sun, 26 Apr 2026 14:47:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-444eebec868sm795291f8f.31.2026.04.26.14.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:39 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:36 -0400
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
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v4 02/22] mm: add vma_alloc_folio_user_addr
Message-ID: <0652fa7c0ed9be9794f44cc1f10ad19ed5f3990a.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: pLT-o8nzIh1fdGj2XGpe42oqg7zBMd-zO2j9VZIgHj0_1777240060
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add vma_alloc_folio_user_addr() which will be used in follow-up patches. It takes a separate user_addr
parameter for the cache-friendly zeroing hint, independent of the
addr used for NUMA policy lookup.

The NUMA interleave index is computed from
(addr - vma->vm_start) >> (PAGE_SHIFT + order), so addr must be
folio-aligned for correct NUMA placement.  But the zeroing hint
wants the exact fault address for cache locality.

vma_alloc_folio() becomes a thin wrapper that passes addr for both.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  4 ++++
 mm/page_alloc.c     | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 7ccbda35b9ad..7069b810f171 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -320,6 +320,9 @@ static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
 
 struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 		struct vm_area_struct *vma, unsigned long addr);
+struct folio *vma_alloc_folio_user_addr_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr,
+		unsigned long user_addr);
 #ifdef CONFIG_NUMA
 struct page *alloc_pages_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order);
@@ -345,6 +348,7 @@ static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int orde
 #define folio_alloc(...)			alloc_hooks(folio_alloc_noprof(__VA_ARGS__))
 #define folio_alloc_mpol(...)			alloc_hooks(folio_alloc_mpol_noprof(__VA_ARGS__))
 #define vma_alloc_folio(...)			alloc_hooks(vma_alloc_folio_noprof(__VA_ARGS__))
+#define vma_alloc_folio_user_addr(...)		alloc_hooks(vma_alloc_folio_user_addr_noprof(__VA_ARGS__))
 
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e6ec7310087..6d31a5c99e93 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5298,8 +5298,9 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
 EXPORT_SYMBOL(__folio_alloc_noprof);
 
 #ifdef CONFIG_NUMA
-struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
-		struct vm_area_struct *vma, unsigned long addr)
+struct folio *vma_alloc_folio_user_addr_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr,
+		unsigned long user_addr)
 {
 	struct mempolicy *pol;
 	pgoff_t ilx;
@@ -5314,8 +5315,9 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 	return folio;
 }
 #else
-struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
-		struct vm_area_struct *vma, unsigned long addr)
+struct folio *vma_alloc_folio_user_addr_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr,
+		unsigned long user_addr)
 {
 	if (vma->vm_flags & VM_DROPPABLE)
 		gfp |= __GFP_NOWARN;
@@ -5323,6 +5325,13 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 	return folio_alloc_noprof(gfp, order);
 }
 #endif
+EXPORT_SYMBOL(vma_alloc_folio_user_addr_noprof);
+
+struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	return vma_alloc_folio_user_addr_noprof(gfp, order, vma, addr, addr);
+}
 EXPORT_SYMBOL(vma_alloc_folio_noprof);
 
 /*
-- 
MST

