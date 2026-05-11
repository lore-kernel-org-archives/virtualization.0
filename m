Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B093BE64B
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489593; cv=none; b=nd1UEStNNHCgk50u+MWvZ67wGVMY0iVTPpUXy3E8DNVnzskXNzKvHbMOk5xVt5ICSyBg68Kt5xNIfgSJZIuavF6OokKDm+y5/CxhUTXX6QmpIiXHKYl1xDgH8dz2FGBDQa3LtXjZjRcnHH1wKlLOI1LHR/0S1VHUTu0heYup16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489593; c=relaxed/simple;
	bh=69QG+5KxbknuqowgRzIPAH0Udu09EBE3lvMvWnTXBmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IcEQ0tQGz6w7q3uLqPdeCxbEpbkT5kDEgfYIiCFoJged7aEuPyNvt1TBCuTa8UBWqxGnixhXvfGIBgfsbgOIhc2z2i4nQQhTQYRZQ7imEKo9ugjIeYjE24COMxHZ6BtqGpDPX0Z05We7HUmnWcHGAiL4JIkw0289hFdVQ/HvbLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxHtUKMb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxHtUKMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dawd7eS61o9/4A+PK33L87yl5/YoiTuIytB/tOyfis=;
	b=OxHtUKMb1bLuvnMBwC28A7NaFJi8Yyke/Rrgl5eKratOv1HGt+8HAs/fsXw9JhFrZoDn7w
	ZsfCcaDZIJXVN+wP7NufPqo2G6wWFWI3VqBXfQZg8RqzuenVcrfKxtAx7R1SYNThQ9wXON
	ImN7/F1Hp9a3M/8ZN6WwuZQk10YbA+I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-klgSiPa3NferDV7azpla4w-1; Mon, 11 May 2026 04:53:10 -0400
X-MC-Unique: klgSiPa3NferDV7azpla4w-1
X-Mimecast-MFC-AGG-ID: klgSiPa3NferDV7azpla4w_1778489589
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a589c7879so38678015e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489589; x=1779094389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dawd7eS61o9/4A+PK33L87yl5/YoiTuIytB/tOyfis=;
        b=fytzrfFJRtSVhOm/6/MjvWHJjJg1w5IK+mNf5PRu4M6cyeNA6w8U3RtPVR12733qY6
         ew1zRKnkCwkPqkgqW9dXlsM+S1xIfi7G0KzEQhubSS6x9HDh45+DuLAUhnXVT9kth6CX
         9yI1kaHmtKzhXFI2PZlpU6JzeVfV/wNxjl4NlT8qBWpaB9bA7DK6O+Mh6x2VVz59+IKA
         5U660gajVcdxZcvkNcupwjRyQrElnLiP+RqFMmn9XHqnWqbbzDDka+fBW0mAAQ6HBqIs
         5h0rVSvLqfE9E9AaAPJcTxO1OsloBq8wZXAlavbeoUlrq3NCpIuHkScHwpMzSH1Fkh/6
         uJXg==
X-Forwarded-Encrypted: i=1; AFNElJ+McSaZGJkHF5OT2pttza/IucmqEZ2x1Wwq8VRr7ibPldIMBmEqYLb68kaPeei0BXaCndSEawT82AsLRxrJbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3iYuNUd7QdE7GmOrDrbHCmoSJshO4O/lyqntrF0v4j7IzsDru
	F6DW7x9CnmvOss9jGxyeqJp3GdTp0Gx6dCgcNofYK6OjddFWI4cLi1eMGE4FTdBvftvtDssYziG
	APQ4P8/cYlisL2tPzingAoyJLGxdB/GYdj0ulCJ+dRk8DVF8zOt2tAphrc/EMZDDBPT39
X-Gm-Gg: Acq92OHqpzuoAEbdlbKD0018jWZsii2F/RUcoeYTNWAbKSQ0BeYOoxzT+1CBT2rZ+Nh
	8Tkw9/b9HVG+A8aLZLjBVCIgxjsrnYFuFXlwqMhFMBIZkLIjuKOVfyH0rDoNSGnSi1Hp/4dgLBD
	AacO+W/168qxte6zx+tcHy2Hhq0l6DVVlVY1VskyY94cOA8fVCZz3EvaKE5H1xcjP1EAhY7jHNw
	FyctVVazvgg6oAIzw7op0+2HqbZ81uQ3YTbaEOvADg/5IPoIjVn31+OZEowhdcfa7wEhTmoOKFD
	3k/XyT+hAilnaKEkrP75RHvpHqjoEe85IDEUPaVoM0zxvkaxYJRNE+R5BsapKJsbFrepBoI4mR6
	URVNcdnJUq5MCKkL0mVn6SdnmWu50I525ccD+304U
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr274005295e9.14.1778489588744;
        Mon, 11 May 2026 01:53:08 -0700 (PDT)
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr274004795e9.14.1778489588154;
        Mon, 11 May 2026 01:53:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6aea4sm28136990f8f.10.2026.05.11.01.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:07 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:03 -0400
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
Subject: [PATCH v6 04/30] mm: add folio_zero_user stub for configs without
 THP/HUGETLBFS
Message-ID: <1aaf861301e26121bcbbf549060cb6b3b04e0c06.1778488966.git.mst@redhat.com>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8NRyQY7L5v3sLCkqfpEClHOFsReC2pOeIMAmfMYdMD0_1778489589
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

