Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400F3F54CB
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315813; cv=none; b=sObB/qfS5mcL0jIZjtg5yR1cYKqwVKTfiZmpqW5NEwBp5uxuSTOevSL5IWQMXcbcRBe/vXaM7yj//z2hQS2fsIvq6mfIRRgGgBkEsAdq++Sdrw7x0pxSkm4mxW3BhNam+8qD1aGf8VhG6a1daYKVR+FuHpD9pG6oss/GwYYK/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315813; c=relaxed/simple;
	bh=V5Y93H57q2xi9ZVdVLl8OLD+jeqpAWNwQzgfVZDhJj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pq7g3RV6IVL8Zt77y8NlbUsX34WpitMUv7L5UNLXHl64FrZoYKLZbqfxX4sIXywHbKx8NOzI2/LW+g3TYIt/FNS7ujWaWjz3Am4cW3AGF0DPOBvNHpsriZaMEaJkKCAz2IJZFePDj/h47Go6HJFw3M/KTp2eIkI3p48xMos0G1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLtuYJ0i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLtuYJ0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lR7ppjC8ZhT95gw1LzQhYf3JteDpTHqAJsB6tR6PXLg=;
	b=JLtuYJ0iJGgxFXQuw8KgfeAuZ3HA6opjUsP5ho2xCL74ShJjUAdYUNH6VIOlZexT6eRgqz
	0dYIvS26nV/MV5t25I7e0uUJqsfMHXHINqAZSnxZq8j6z7Y6iiOMIqly1Uh1Soh2oX9fZ1
	xPm/pe4ewK4dzJH2oP56vUWOElFcfcw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-PZ0VNU7bMN-aoL0x676_kA-1; Wed, 20 May 2026 18:23:29 -0400
X-MC-Unique: PZ0VNU7bMN-aoL0x676_kA-1
X-Mimecast-MFC-AGG-ID: PZ0VNU7bMN-aoL0x676_kA_1779315808
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-447f2ce5556so4363987f8f.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315808; x=1779920608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR7ppjC8ZhT95gw1LzQhYf3JteDpTHqAJsB6tR6PXLg=;
        b=O3YsjlT19uVzvOtQlh1JbBqGKOa5/MnXEZAYd9haLI2QuSrWuh6FrJQScfoG7Ne7mY
         f0ad/drdHqkwXo6gQa6RNgG7XoG7McenKPuRGtPN4yw7c1v1gHIpyF+Ri2O5z7C9mByh
         saqpwAaOqRkbMKecJUO3FSsxxTTHK9093UzaOO0wFcW7qNpvweFb83kXBejs0gXpblmf
         PRzkvYrN/FUbQLjPOW9Tnx4QYut9X2CWSxYztKPLGhgBy2N5u3JiBK1qnFAloZpWiRuT
         nFPY08LOm5NKY+V5u6ym7oxIDizEHCuUJ8jinRtRw36fvTDXvKmVX4MfKJmiPC4rtGb3
         l8rg==
X-Forwarded-Encrypted: i=1; AFNElJ/JeVH4/5cTrfimDJ3s/yHH/Trp55a0zaZFU5y+XPe3YKfzPRcu6NS4p8Iihx6xMSUNOjgWomic3kkjmJPz5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGB0xTgDOZzqQ+uJjnV4NremxX96imduXAcoFnNKKviPBOUrBJ
	UWpS8fYzDOHSi3s9x7QhFACZC92SmXYuMi9QmeVex1f2xhGfzuvLkoNjJQlxjETS4rIzR8m4czK
	omsw30nXH/5UqOeLQyKyKTsnPaHYpDHMjPVSiobM9U4idVo5R9/U4PhtlnzbQ9DMFV9M7bmOsxR
	Rg
X-Gm-Gg: Acq92OF/b+4tH0BR8fY+ZbzN55EF8r4jjjRvJiE9pl275jnJgiK4NIe4jHpcnYmZti3
	g9lJ9fPbUrkH9G2jeEG/hVmqpiSffS+nyRtjVky7pFECdSOw+ukp7B2/ZO8EE1Didu8S4vuj5Iy
	7G8L+ptm2yXbWy4AUOHTYoPFJZGQcUoBiIMgx9Qzotv0UgNnKQNrzXDLPD/jfmH7wO0sE4f5iha
	hGdkOJWduhnhk1GyA0QCo9LUB7WZ6Zid/yJTMjImX8fpT3I0WDy6bCzT2FjQapLuBRbim3l8SKd
	+HSro1Xeca20bxY1gFsKPw6Rajmz+HxYKlWheOcm+XNrHUX/uAJ++wJBYG7fpL0jv/TpkDcGvNA
	WnehQOhXYqGgq6K02JvY8eNO3f31aqkxm3Sj5ElVMu/0=
X-Received: by 2002:a05:6000:2883:b0:43d:67d1:2022 with SMTP id ffacd0b85a97d-45ea38be3aemr338302f8f.19.1779315808221;
        Wed, 20 May 2026 15:23:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2883:b0:43d:67d1:2022 with SMTP id ffacd0b85a97d-45ea38be3aemr338257f8f.19.1779315807764;
        Wed, 20 May 2026 15:23:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm56994075f8f.5.2026.05.20.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:27 -0700 (PDT)
Date: Wed, 20 May 2026 18:23:23 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v8 34/37] mm: page_alloc: skip kernel_init_pages for
 FPI_ZEROED when safe
Message-ID: <86f98d31a9b7989c699bad2e7f1fcc977a58d0a1.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ut565AYLw8JEkSps4mIUazzeXHFk84lDB0uvsfeBs28_1779315808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In __free_pages_prepare(), when FPI_ZEROED is set the page is already
known to be zero. We can skip kernel_init_pages() if page poisoning is
not enabled (because poison would overwrite the zeroes).

This avoids redundant zeroing work when freeing pages that are already
known to contain all zeros.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 399e2038dcd9..90a92be96ebf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1447,7 +1447,14 @@ __always_inline bool __free_pages_prepare(struct page *page,
 		if (kasan_has_integrated_init())
 			init = false;
 	}
-	if (init)
+	/*
+	 * Skip redundant zeroing when the page is already known-zero
+	 * (FPI_ZEROED) and page poisoning did not overwrite it.
+	 * When page_poisoning is enabled, kernel_poison_pages above
+	 * wrote PAGE_POISON (0xAA), so we must re-zero.
+	 */
+	if (init && !((fpi_flags & FPI_ZEROED) &&
+		      !page_poisoning_enabled_static()))
 		kernel_init_pages(page, 1 << order);
 
 	/*
-- 
MST

