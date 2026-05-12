Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF953C9889
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619957; cv=none; b=dIXUvqIoZrpVnnlBkutkCWVsjfQ8K29PKA0XgGzjHcCKKek4uBJ5vOJheopipnlBLsPddH4wEIGDB1kkkbVVcgjm9fs6d7snVXo88siAeIrVM9haYNEy+N3Mfl6xRzWYW5ESGMG88rP8ovH2Ui24CrNuRoQfbVCwcvT92izF8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619957; c=relaxed/simple;
	bh=69QG+5KxbknuqowgRzIPAH0Udu09EBE3lvMvWnTXBmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uDjouxs4QHSS0vqLvMoO7fwBjgZ+3H6lVlulo1i3+pLzfVHEBn+4VbC3rFfdQig14z6gahFKyLJgTVfOV3r//ISg+P10JIyTf+ZaaovYIk3//5vHIj1iUDgSDIkE7qB0BAQijFIXp+pZLtVpme0CaY6Qo2zgaZ+7eWLCfMe8iII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1RNgWGU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1RNgWGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dawd7eS61o9/4A+PK33L87yl5/YoiTuIytB/tOyfis=;
	b=P1RNgWGUwmNaMtpCA/FT+FYDY8iXtBMGzCdbQVuYEb7xNopccnkF2ZNEUfX9+jgN7mwmJZ
	4zqN/bJRbIV4108qsfFf7nojhv8whMxVvCF7bb75I9GhaweamVS7m0+LwgxmHQlCDXO10Y
	7JJ0b5Tgcrr7xrQ5qkiLjyvTL1O59To=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-co9SnuD4MgaHMGLw9W0Csw-1; Tue, 12 May 2026 17:05:50 -0400
X-MC-Unique: co9SnuD4MgaHMGLw9W0Csw-1
X-Mimecast-MFC-AGG-ID: co9SnuD4MgaHMGLw9W0Csw_1778619950
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c0120047so34768115e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619949; x=1779224749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dawd7eS61o9/4A+PK33L87yl5/YoiTuIytB/tOyfis=;
        b=bDBSqlmhbgztQPmE6feQIlFg1SH4ZjA/tCR6IoPcxhulYEtgu/uYjJxO/A0iKszgZE
         KPIl2Q67jsjrwuu+OtiyCN046JyxKxcJ9NLXRg+QzHTlrlHYQWJ2WyCeoBUDiXGJFp12
         S3jNVYgXixu2Ao9mA53bamACGa8MBe+nyIp9vBktHm+KQJphRAhPMxxD+tAgfjXq4eTV
         r12rKjDVqwc7bjkxWJkHhCQAVxeFN7JEaXtX5pO6IKEka/9KOgzV6isB/qMYoYhjXr2V
         HJ7eMHovahPM+A3SYDLtVHwZMOyfaRcz6nSgMbfNdKa+uPfvIR+okPXHTQQCbtIh380W
         soDw==
X-Forwarded-Encrypted: i=1; AFNElJ/8hSDbwBZ0sPoSYjNeMXpe0oSt0hQ6LtGlCmcmbi3u9eecmE9lC98HP/OHmtnNEsGablvXviOc71KEbI7q1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIlS+3WdpGpYnP5J843Rl4WHxBpX1XSUwpUMJGX0vQMVaciHPE
	UBPpR8E+sWE61KGg8XKRaBzS01PVkdE5u9uYlo7Tq6+fM/YtBfIG9GAxOOW5DsfNxWYbCU7WYtj
	HO/eum343MeTrokmSwqJIhG68LelY/DWWm1AfAGzCW8y1HF0V0HQqjQteKKH9dstzsszd
X-Gm-Gg: Acq92OGLFVequ1X60bthEsL7MhDDoM1x8xC66zehZ6pKHKtSc+6II842lacwmYWlYOC
	0IedLU0NT64YH9RDYqe+07x5LNeWoV7keTI/ipp4EmDEf9Pu8iVJgWxM431hpesbXBwCxAW9Zg2
	xc79pbsXMPNzNiMibRfKCmvXcLcrQbdBlLgEMZrEncxZ69hegqGZWT+MbPsCUmsDCQilHgKIQV4
	eFzWB6Xf9WRM1ED18WKbYiIKFL58ujxGhznMzI9ml9rlXZrcP3FiCfB7VZ+Dyn+pFKQgJw/hxQf
	snYAfngcSvIo/s882algX3eVg8M4V9CmYI7T80HGOZUsxM47JUzMnKVNyaTjHeCZ5YSF4uiD3kO
	KyQwjrkdt1jPUM5/DvpdO8Gry6psL20l71GjsIvig
X-Received: by 2002:a05:600c:859c:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48fc9a09e36mr4382005e9.8.1778619949413;
        Tue, 12 May 2026 14:05:49 -0700 (PDT)
X-Received: by 2002:a05:600c:859c:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48fc9a09e36mr4381535e9.8.1778619948841;
        Tue, 12 May 2026 14:05:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f4247fasm36415055e9.9.2026.05.12.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:47 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:42 -0400
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
Subject: [PATCH v7 07/31] mm: add folio_zero_user stub for configs without
 THP/HUGETLBFS
Message-ID: <08b9139bf2329eb7fbc2b2af02d9537219282cec.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 17TV9o2yWZQ64LgZSclwkgIeCXXgqmVy68bjTNerbbE_1778619950
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

folio_zero_user() is defined in mm/memory.c under
CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS.  A subsequent patch
will call it from post_alloc_hook() for all user page zeroing, so
configs without THP or HUGETLBFS will need a stub.

Add a macro in the #else branch that falls back to
clear_user_highpages(), which handles cache aliasing correctly on
VIPT architectures and is always available via highmem.h.

Without THP/HUGETLBFS, only order-0 user pages are allocated, so
the locality optimization in the real folio_zero_user() (zero near
the faulting address last) is not needed.
This also matches what vma_alloc_zeroed_movable_folio currently does.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af23453e9dbd..3b1ca90fd435 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5070,6 +5070,9 @@ long copy_folio_from_user(struct folio *dst_folio,
 			   const void __user *usr_src,
 			   bool allow_pagefault);
 
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE && !CONFIG_HUGETLBFS */
+#define folio_zero_user(folio, addr_hint) \
+	clear_user_highpages(&(folio)->page, (addr_hint), folio_nr_pages(folio))
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #if MAX_NUMNODES > 1
-- 
MST

