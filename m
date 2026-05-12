Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49F3CDBC6
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620072; cv=none; b=OD03h7Et3SOeIbSvUato4fOEMed9aevqLrn6EI4WA/vh/IH/ce6I3jkz+jV/A2it+pT1gAaLImWU0MVnvVNYsKCLEenDYfgRafWKRQ6gR6gpHJBQg9WTyCdrAeZYliEh3mNrAz53hNbS7jhjz9dB4u+0h01WM+vgLtGoVXYmo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620072; c=relaxed/simple;
	bh=FzG8+92oH2mwvb1TgGky3Bd7ojioTSewgWR4luIpYTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XlwvjTKVM7gUd//qAAI3cNACbGTz5SUHwnU2960oTS4hnVBoOvzoXMzdV8qdSHeXomoZsqb8wBEAxQW+5l5lq4kvsDmIDdYBFqvRjXLKzCqnmNKElAS8bozpxc1kn0g/JPOJcPE2dCUzyzmhPc/suM/DtysGrtbQoVn5WYHmSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNp+Nj5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNp+Nj5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBKqj2O9gjX/tz0GTabH1SzaDOD5jZb/zvIFduhmeuI=;
	b=jNp+Nj5DqYNVE0KyOUMbUdK8ujDlW6phBa8jHGJFHZYbHQDRbA3dKHoeWQurnILetOwMLc
	VQJrbPHMn8c/MKw/iwu2qGwAVK1isVpSzM0lwIViIgYdvc7+8GKEFXBdKzFDtzH9qPlWul
	gc0CAhGfZ1AVvqtREA3tD/Y+pno6RNM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-NlB3OBAIMxCxpSXHlpeu0A-1; Tue, 12 May 2026 17:07:48 -0400
X-MC-Unique: NlB3OBAIMxCxpSXHlpeu0A-1
X-Mimecast-MFC-AGG-ID: NlB3OBAIMxCxpSXHlpeu0A_1778620067
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fb4ffebe7so2909555e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620067; x=1779224867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBKqj2O9gjX/tz0GTabH1SzaDOD5jZb/zvIFduhmeuI=;
        b=f7Zmos2SWLtF8To/fEDmuopakmLD2Q19CR+M2o9VtAMeE7Lxe30Y+jhskztODW+8Wd
         BfyLxyMmqFL+6I2/rarrffYFfp2VaeH0C9q7T5BuGi8pnKzY6mPM423jiIka5tQbPN0I
         yq+P2CMHjMEc7pOIbY8vzWuYIO0dk2G5D/0Iy6GiaCQsibKXFf5YIR3tHIzc5/O3qFjl
         gqsF70+/POhYKy42pmQL8mDHVxk1/qtI+AtSuDm/MHhpCWjVjgdnjE6p5lrd3YSp5LFG
         /vQ9FuGJ12UfMIpXsw6VYx+Y+jFz2wkTUQEuYowAGLHpeFen7zxI2otrZbMzBbxF5uRk
         Lx9w==
X-Forwarded-Encrypted: i=1; AFNElJ8FBzTdFXkbPkPrRpGXsmqsJ/Dlxsy8zgjpPC3+ajNDvatx+zNa1JnwyNI7RL301bonNlTyMBv9Fuys3XG0aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUuRaznhOiyhiUr9jLesu3eN6PpwKVjS0RJWizcxuIjjzynhci
	n5YyLkR/L1E5PDIRStx54S/wfNLYCs2UrqRkh9DVPniNPnakfc44UifrNKnGi6Lk0ZFnGEZRouv
	9sYSmdSsS1YcexpZEpIYQS5gKI9wZ+bEjI5/l55Pza1pfsb75qfAg0zDV4IjWP0lh7Drg
X-Gm-Gg: Acq92OG1jOyU93P8KXrFjVBYui++2hEh0sbzGHoAh1qAkzomDMe/7zAUuj4nH0bHfkA
	D3GkdD1bzTUn5KppgXRaUMQbF2BdptXYY9n2RyvM11MpZfW9aeeqEu9N8F/Zt+pRsqXm0k7IBp4
	d5occ7ZxwWxiB801DrrQJgQeMZHFbvHlToP+hnPQV8Yfxj78VC4kRwi8TH3sweTqT4eg1C0NLhe
	NXq5PnhRK3T5Diyn5DPYdX3bn35zi4iGIM6heMywa8ZsEJPAeZXAElZN/IoS63qbnjxW0PSFijI
	f2v3llaENP30C47sbxHo0jz7U+Tb6ThiHtcMePxrS0lPEcQz2MECjtWsThUjueBuE381D9P2T6F
	b4dvZpXqmWME3d4gRnOdydWnMnrWhwIRW2wz1McKB
X-Received: by 2002:a05:600c:19ce:b0:48e:7f1c:8778 with SMTP id 5b1f17b1804b1-48fc9a34577mr5609695e9.17.1778620067111;
        Tue, 12 May 2026 14:07:47 -0700 (PDT)
X-Received: by 2002:a05:600c:19ce:b0:48e:7f1c:8778 with SMTP id 5b1f17b1804b1-48fc9a34577mr5609425e9.17.1778620066569;
        Tue, 12 May 2026 14:07:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f63beb7sm30481905e9.35.2026.05.12.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:46 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:41 -0400
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
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>
Subject: [PATCH v7 29/31] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <f719e415bc71546c89933dad1c1dff20c8be3019.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RtbAVxKmjD_sKsK1yDmZvcIXmf7I4Jvo7VoikxvAkQc_1778620067
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add put_page_zeroed() / folio_put_zeroed() for callers that hold
a reference to a page known to be zeroed.

If this drops the last reference, the page goes through
__folio_put_zeroed() which calls free_frozen_pages_zeroed() so
the zeroed hint is preserved.  If someone else still holds a
reference, the hint is simply lost - this is best-effort.

This is useful for balloon drivers during deflation: the host
has already zeroed the pages, and the balloon is typically the
sole owner.  But if the page happens to be shared, silently
dropping the hint is safe and avoids the need for callers to
check the refcount.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/mm.h | 12 ++++++++++++
 mm/swap.c          | 18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3b1ca90fd435..4c51b7bd7576 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1913,6 +1913,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_zeroed(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
@@ -2090,6 +2091,17 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+static inline void folio_put_zeroed(struct folio *folio)
+{
+	if (folio_put_testzero(folio))
+		__folio_put_zeroed(folio);
+}
+
+static inline void put_page_zeroed(struct page *page)
+{
+	folio_put_zeroed(page_folio(page));
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/swap.c b/mm/swap.c
index 5cc44f0de987..8d57223dfe34 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,7 +94,7 @@ static void page_cache_release(struct folio *folio)
 		lruvec_unlock_irqrestore(lruvec, flags);
 }
 
-void __folio_put(struct folio *folio)
+static void ___folio_put(struct folio *folio, bool zeroed)
 {
 	if (unlikely(folio_is_zone_device(folio))) {
 		free_zone_device_folio(folio);
@@ -109,10 +109,24 @@ void __folio_put(struct folio *folio)
 	page_cache_release(folio);
 	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
-	free_frozen_pages(&folio->page, folio_order(folio));
+	if (zeroed)
+		free_frozen_pages_zeroed(&folio->page, folio_order(folio));
+	else
+		free_frozen_pages(&folio->page, folio_order(folio));
+}
+
+void __folio_put(struct folio *folio)
+{
+	___folio_put(folio, false);
 }
 EXPORT_SYMBOL(__folio_put);
 
+void __folio_put_zeroed(struct folio *folio)
+{
+	___folio_put(folio, true);
+}
+EXPORT_SYMBOL(__folio_put_zeroed);
+
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
 static void lru_add(struct lruvec *lruvec, struct folio *folio)
-- 
MST

