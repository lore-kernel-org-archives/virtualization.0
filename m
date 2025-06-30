Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1435125B2
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288423; cv=none; b=DrbflNdjUXr7olk2bcTsYda6ceI4EZb3nTDPDZOfeZD8vD8I+/EDjpZXwFlhFjpApW1FFpPLyEOglcFZ+RCRYGZTOT7OBsEm4fMyG1Kgzk/v6ayCliO6Luv1clOloj00zbR3EMA/ib+zvscbd9dmhGo+xmqORnRH70Syhs9WFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288423; c=relaxed/simple;
	bh=eDj8cHxhN1KzXcdGn1TZtgX9KNukCFTUSaK0zNVfr+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n94SWTmgxfPR5ZKjcdfDOaUxLtlKe8IGDhiy2kSSi44+oynPpVUz4mO5MhikFERfXifYhVCHQc6qG0ggfp2WLmUVTK8X+1u4DAysqmJUMpqRnfpZtQxOJ9+Vw/4mW0trI9/TE+V0IGnLecJS1ZyJHy4GXmkQtdv69VvfiicBKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZibEWH1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZibEWH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfJnfBkXpkPuvL/9X/X6rRos3axIFOlRbKihQ7zrqmc=;
	b=RZibEWH1BWSjLAU0YJD8o9WncRjjo9PQAfZ7r+WbZDr2agQso/7sYTNoiZGTSKHyOGo0Hz
	Kt3h6ZZe0FgF0CPxN67U9fy3ipOLUvmvuyMeK7mw/ghwzkK7z1C5/AX5SvMVm8fk53MwA9
	tR8B/z8jU9FLQJO9BMbH1r1yRkuQKLs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-9deIgHGkOGaY3bHz778nDQ-1; Mon, 30 Jun 2025 09:00:17 -0400
X-MC-Unique: 9deIgHGkOGaY3bHz778nDQ-1
X-Mimecast-MFC-AGG-ID: 9deIgHGkOGaY3bHz778nDQ_1751288415
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso12659125e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288415; x=1751893215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfJnfBkXpkPuvL/9X/X6rRos3axIFOlRbKihQ7zrqmc=;
        b=FUzMged6sB764o/XaobA+woU4r6Ec56THFE4V/8Afp12qpB2VYGAkgB6m1PQXIforo
         KcxXD9uzqmLXeqZxJ496pyTEOq44BNW4aLsnGpI8xFEcLS4M6nsKTZT9tfOKMTRR6Djo
         jJz14n+Cu/0z3W3oSjP3qlG3Gwcb0/+Ff0XcTK+FoyKwzvcNWI1roI7Fyv7XbFYNYp5h
         e/RkUZnKyFX/Szf3/pEDCcSqMfrzvAfoyzvznZo5jqeoJEVaUISZOjdoekpUlHEWsGfS
         z/m+laHG5o5r2VGEMHGBpYKbLqZrjkOSWyCfrP4n05pmnONGMf4VKUO+sZT4Lc0Di/Md
         kJFg==
X-Forwarded-Encrypted: i=1; AJvYcCWz1k/GaOwjFx14NuBGsqU5j4yC/ClvaeyvZevsmdV3UthiS6N/Jjb4pZ5UhuYCoD+x7qtnyTJ3ZmFgVZIROw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLsghogHDhCDXc4xJdEMkdOLJeTvTEKGvyRj7R+rPCeWkstLPd
	MTWIWvNMajfLE+Iz/Eqzt4+sOiCjQBf78X7pHVJJZFpdijah+keh9k4y4ryU9rBwct/10q62Grp
	tFrbEC0kvQ3jlZY3CkOYbUXKWMYKj+3ReRDjPHDc+M8t3iXqVbeONYJqiZyzxFAKaHs+z
X-Gm-Gg: ASbGncv7bigifhqmBazmz0YlcdNw3q6tg8YZr6QMz9CGuHz/TXwJHdUXkA2fivMXWNT
	3BTNIBdHFifzp5S8SIiA2FOoNrB3rFiSFq4GFvZDSkVOchS2hpJmLio05liLVbo9T+qkVaXsmb1
	zxCq1QL9aZGdT31iJPf5lvJkCI3hRi0TZknVUnLPJrDhAPA+jb/fQ3ncnDLhpx7q1N/XX2ifmXB
	zkep7MW3EXPpvGx4VAvcIyZgAX0ceRFfSwkpqKQEGTXnMhpwzaB0q/axDS9XCtrjbG4ZFf5KCqw
	kCaovxzs4GBH1ImW/x/c0bGzVaXPYE734yAEaW6PTrsWCmCD4411c28x7ZhYwhzHGxeCYFvwlsI
	qA9/Rwn8=
X-Received: by 2002:a05:600c:3f0e:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-4538ee6fc79mr120597265e9.23.1751288414955;
        Mon, 30 Jun 2025 06:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Y6zMVNRx8SyemplqzZ+r/tVyw00Oe4g4/JGEqtvy2G6LpOQKRmzj2nzxeHUR41ZrxoqB6w==
X-Received: by 2002:a05:600c:3f0e:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-4538ee6fc79mr120596525e9.23.1751288414400;
        Mon, 30 Jun 2025 06:00:14 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e59659sm10376300f8f.77.2025.06.30.06.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 00/29] mm/migration: rework movable_ops page migration (part 1)
Date: Mon, 30 Jun 2025 14:59:41 +0200
Message-ID: <20250630130011.330477-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HPwpgWoL8-U0pYygCE-zwiF3s6_nN0eQ5cOUJNeNF_0_1751288415
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on mm/mm-new.

In the future, as we decouple "struct page" from "struct folio", pages
that support "non-lru page migration" -- movable_ops page migration
such as memory balloons and zsmalloc -- will no longer be folios. They
will not have ->mapping, ->lru, and likely no refcount and no
page lock. But they will have a type and flags :)

This is the first part (other parts not written yet) of decoupling
movable_ops page migration from folio migration.

In this series, we get rid of the ->mapping usage, and start cleaning up
the code + separating it from folio migration.

Migration core will have to be further reworked to not treat movable_ops
pages like folios. This is the first step into that direction.

Heavily tested with virtio-balloon and lightly tested with zsmalloc
on x86-64. Cross-compile-tested.

RFC -> v1:
* Some smaller fixups + comment changes + subject/description updates
* Added ACKs/RBs (hope I didn't miss any)
* "mm/migrate: move movable_ops page handling out of move_to_new_folio()"
 -> Fix goto out; vs goto out_unlock_both;
* "mm: remove __folio_test_movable()"
 -> Fix page_has_movable_ops() checking wrong page

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>


David Hildenbrand (29):
  mm/balloon_compaction: we cannot have isolated pages in the balloon
    list
  mm/balloon_compaction: convert balloon_page_delete() to
    balloon_page_finalize()
  mm/zsmalloc: drop PageIsolated() related VM_BUG_ONs
  mm/page_alloc: let page freeing clear any set page type
  mm/balloon_compaction: make PageOffline sticky until the page is freed
  mm/zsmalloc: make PageZsmalloc() sticky until the page is freed
  mm/migrate: rename isolate_movable_page() to
    isolate_movable_ops_page()
  mm/migrate: rename putback_movable_folio() to
    putback_movable_ops_page()
  mm/migrate: factor out movable_ops page handling into
    migrate_movable_ops_page()
  mm/migrate: remove folio_test_movable() and folio_movable_ops()
  mm/migrate: move movable_ops page handling out of move_to_new_folio()
  mm/zsmalloc: stop using __ClearPageMovable()
  mm/balloon_compaction: stop using __ClearPageMovable()
  mm/migrate: remove __ClearPageMovable()
  mm/migration: remove PageMovable()
  mm: rename __PageMovable() to page_has_movable_ops()
  mm/page_isolation: drop __folio_test_movable() check for large folios
  mm: remove __folio_test_movable()
  mm: stop storing migration_ops in page->mapping
  mm: convert "movable" flag in page->mapping to a page flag
  mm: rename PG_isolated to PG_movable_ops_isolated
  mm/page-flags: rename PAGE_MAPPING_MOVABLE to PAGE_MAPPING_ANON_KSM
  mm/page-alloc: remove PageMappingFlags()
  mm/page-flags: remove folio_mapping_flags()
  mm: simplify folio_expected_ref_count()
  mm: rename PAGE_MAPPING_* to FOLIO_MAPPING_*
  docs/mm: convert from "Non-LRU page migration" to "movable_ops page
    migration"
  mm/balloon_compaction: "movable_ops" doc updates
  mm/balloon_compaction: provide single balloon_page_insert() and
    balloon_mapping_gfp_mask()

 Documentation/mm/page_migration.rst  |  39 ++--
 arch/powerpc/platforms/pseries/cmm.c |   2 +-
 drivers/misc/vmw_balloon.c           |   3 +-
 drivers/virtio/virtio_balloon.c      |   4 +-
 fs/proc/page.c                       |   4 +-
 include/linux/balloon_compaction.h   |  90 ++++-----
 include/linux/fs.h                   |   2 +-
 include/linux/migrate.h              |  46 +----
 include/linux/mm.h                   |   4 +-
 include/linux/mm_types.h             |   1 -
 include/linux/page-flags.h           | 104 ++++++----
 include/linux/pagemap.h              |   2 +-
 include/linux/zsmalloc.h             |   2 +
 mm/balloon_compaction.c              |  21 ++-
 mm/compaction.c                      |  44 +----
 mm/gup.c                             |   4 +-
 mm/internal.h                        |   2 +-
 mm/ksm.c                             |   4 +-
 mm/memory-failure.c                  |   4 +-
 mm/memory_hotplug.c                  |   8 +-
 mm/migrate.c                         | 271 ++++++++++++++++-----------
 mm/page_alloc.c                      |  12 +-
 mm/page_isolation.c                  |  12 +-
 mm/rmap.c                            |  16 +-
 mm/util.c                            |   6 +-
 mm/vmscan.c                          |   6 +-
 mm/zpdesc.h                          |  15 +-
 mm/zsmalloc.c                        |  29 ++-
 28 files changed, 365 insertions(+), 392 deletions(-)


base-commit: 2e462e10265dcdce546cab85a902b716e2b26d9f
-- 
2.49.0

