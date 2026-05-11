Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C043BF665
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490132; cv=none; b=V3dANPVz1t9Q0J6lVpMbfFqnlcq4KfqG3Nd/hzCJoKtuAUwQmIUg77Omb3HB4zfEYwxPkHzXmZe5QFzSRkvxtJI8eyTaybr5nYTSOQiGO+kxYBmuEdzIl+f9fDGRirlKg0lx6+wPB6h6IU9G6V/fah+MEhgErEw/S5sUSL7YCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490132; c=relaxed/simple;
	bh=69QG+5KxbknuqowgRzIPAH0Udu09EBE3lvMvWnTXBmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZUC0zMYbs/07ZI8hcCzDv/WfxKXkEuoBsAcLYQmdD/O6e+wVrtDvbFCDQaZuo5VuFFY8GLlIEpvKJMQ2tfull6tUjZTDhkVM+LntvQji0awwNYD/Ck7wJP8lvYp9a3QGHQWKDZIaGtKQD5qyO1fzrD5vWxgVtmwBR5A8HaG9VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FS0sYXDO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS0sYXDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dawd7eS61o9/4A+PK33L87yl5/YoiTuIytB/tOyfis=;
	b=FS0sYXDOpBrUtYkLpXPqO3JLdmHQzMt0EUinUmDvb1lTxOSBOH0CRVsSCs/9r/oxgUqruH
	6mVhJUyyuEW4CbwUFPVmipviQoNA6Bpv5ODLRej8LQAmQUJqYuLR6DWkQmQr3VFlZCC0ff
	jbsN1plWJv0wwr7Y/r71G3M5QjNiD0I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-mrcO-n7pMEWwJHf1PImz-g-1; Mon, 11 May 2026 05:02:08 -0400
X-MC-Unique: mrcO-n7pMEWwJHf1PImz-g-1
X-Mimecast-MFC-AGG-ID: mrcO-n7pMEWwJHf1PImz-g_1778490128
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43fe791a398so3725731f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490128; x=1779094928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dawd7eS61o9/4A+PK33L87yl5/YoiTuIytB/tOyfis=;
        b=p5XaFLlOklBqMzL24T8c/4UqG5TyyOvkYOW8nNv/pn1h/XMRGWjBSZrVJbgs2Ns4F0
         W8XvI1wHmh4EHCBiFrVTzB4JZ9tLKiLSDQk1WWZisHnvropbHhnLs/kJTOVwNPeORwiH
         3mx4bivLOlwxVn2Pbg6OBKxrUD6a8eOiFoH9DuDvpP8okEZeTynjEtvmp8lpISZ6qVgv
         tquCm5KZWkVeF/J59TSZae+lWQP2DL41VLmYrNYGf4Fsunx1iOAiWnpmdkenwTCCxqm/
         dSEk9WUi6PzIZFZ/QeH3LkfTPibl8kg9rw/m15oI7OBuXaxUHa1y3qvP6BWmlcQIAvx5
         BC4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/swu7sNKiRpnWdlWi8X47np/x4lPB1q0wxm5vEmis4qsBevuKBBhUZ4Bbtyrv4PR+tGeOcdPlqodDaUrLaOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzul4F3gHjP4E/JBMUnGCINiccShJjO08t0Stf5gTK+XXtl7oMT
	YLYR77ENig7mnXzH3DIUX4gohLWevQ2zVVDIJ/9iFVfLrDHG+PQ2QYJcCYueXtFBPjo7IbqocGR
	qm8jNMH3c6QvH8frvya/eRnyA+NFH5cm0XMF/D1M+EnWmj/Z0zVcoWs78K9JNlBSDvzR0
X-Gm-Gg: Acq92OEc1IsrGcrldTMQ1Wo6AwlbyVbddCdOs+aGuNNcYVkXyYT5wiPfeyEyDGxgN6M
	lnzkF5GFAGnaUYDqy7ep6qlkmrxUtA59+md39asVNwNIhNjOSKHY0YEw00TmI897nvLOoQWhPaa
	+t0hLtCFhfYG3A7SGGpgEx+6QTwPFeQ+9D6CDjCoirhstlaGdJczPOBfGSrVGwx/Bm+XShXkRGb
	2Fa1Miyu91RlOUXLqocwLb4m/k5B5+lVI0LaDaKdyuDIFCyYhMw2f8TfRueTUCOCj9DJGJlZ2ye
	A46R9BSeqFaLXhOObBgsHuRsEg4swBXEWGUVyRsRNGvSJJ0b5m+uQZslMAR2ymd75zOUEw/sF6r
	yJJyZzJldOBK10Lla8GWO01pOEEmXn9e3sk37VGVQ
X-Received: by 2002:a05:600c:4f51:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48e51f3054cmr404020905e9.18.1778490127414;
        Mon, 11 May 2026 02:02:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f51:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48e51f3054cmr404019825e9.18.1778490126688;
        Mon, 11 May 2026 02:02:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1742asm59834415e9.31.2026.05.11.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:06 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:01 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	"Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH resend v6 04/30] mm: add folio_zero_user stub for configs
 without THP/HUGETLBFS
Message-ID: <1aaf861301e26121bcbbf549060cb6b3b04e0c06.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZQSLI2PONAQhjoxZfH7QkYQ79lUfwuH_X7dsoNkkkmQ_1778490128
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

