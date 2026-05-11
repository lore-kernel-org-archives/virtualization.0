Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9A3BF680
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489609; cv=none; b=MeKaHmEALbaoZOMLkQSUtEEEX3vbRMqtlBilaKv3OXMxno/j7JUvL3yuUjyta98OKDlxf1edCcmenDTK/aYej3sQLtJsnnlE195krhVsECtyhdzGxrZlsn01I/kJigU0h+1kEvsKt6GOkU/LzfpbEeV3q/wKiKN8e5f58D91BT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489609; c=relaxed/simple;
	bh=B4v7SD6SJ84KapLgBy+iXreANiiaF75HE81bu1RBt3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NsPIhS9WMG58c/NQcf3pwcLzcaP9qFGF0rhoi5SGqj8Ad6Mx3xU0lv0a+mbX47SL0kQ8wZSTkmBLGP3lA8z3dr0/H/Rx1qPZ9YDw8I6YBFhyPCLTVPsT4MMwZJjhj9Aa3PhOfaBQY0+0CkJKUJdY7PQJDyy5oVlbnIIyDE5sHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rfxv7xcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfxv7xcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
	b=Rfxv7xcjCS6XIiynohFflQRyjn2Y28lXJNp1YKRt18vWybmV5jveeLHQYYHsbIIKqP2dQY
	p2IFRXwsB1DJ27emowztMWLZFT5ffljHKPGs+Wn4Ja2pkU4FZwtyOW1emzb6du14XsyrOv
	013zzAMcxeBJLj4XmVx5Gy2SKQXvN08=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-RIJ2RhqJNG2MO1o1thaMRg-1; Mon, 11 May 2026 04:53:25 -0400
X-MC-Unique: RIJ2RhqJNG2MO1o1thaMRg-1
X-Mimecast-MFC-AGG-ID: RIJ2RhqJNG2MO1o1thaMRg_1778489604
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44ffa15dc73so3678791f8f.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489604; x=1779094404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
        b=mQul1qWWbDEVbP/1rXYVusRf+vUAQexjK0yDx34lup8+PFdq6dTdxVRX7nRbj/sbJJ
         rociAwp0v+p7Y7L8xT1FheLnADRnQ8nVRmmKs8v068KBzEHUUFSeWi0hAOKKgpcT5OKF
         2ku+YWZA+GyZfsjhWt6geiycbkaYyjvqmTHcE5b0rw2x98oR8iqZ1DVTcphYn71LVMpH
         8d5unNpS5DLrenRqsEONPYJt4xfpTHBhzFI6khs9yQWiSpOt2fP38xD7Y/okvKRhFKNJ
         BoH3a0X0Mih/RDJ9sHgjxac525SXcONgibpvHrcnRF1f6FaDITxY2ttYLNSqWVh4sxdX
         kI/A==
X-Forwarded-Encrypted: i=1; AFNElJ+VCW5GTJtdq3vP9U7X+ZYyL+xEYNJAGCA0MD+IremjHGuY+RZUagy2dwcYoVIHlXbV/lwwS/LTEOcSYqwK3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKtgtQzsT6a9lq0pIuN55BktfhyN0tNSQMXmbEe720Omq6nRHh
	lTRJWgmsYcQUWU+AI4+IkX+8PfHKk/slr64/eEezY4gaiLFIqqh+aC4EQZca8xHmgzkP9SWZWMK
	24myDOGGckTdNPIO+ZB+nh17CYLRKj/HEyw+RwviIX7dJxy7UZmKE8vs5S4irGxvcLFo6
X-Gm-Gg: Acq92OFj6fNaOF5bpDb6WScuQSY8mzCJ+iMInqw2L/2Cm+4VUN7dYKQA7kU4D8NswEO
	afxeYy6jbMqgkoYex9FtnfCT1DFgkjFvnzPEl8BE9vbGc/eZ4EdPVdpncRT7AozVkOWe8D7IWz6
	zU+iYShDHJN/OXj2i/rUUGsoIm49lZDKlUvybo4eWrHuf2TsIkE8MKLD5LgIfBoOAjQPNQ1jQTK
	PtVEl3aekP1ncEyxT8vjCrn6Zv9k50nP+Znl/+byS1tgnzUS9tkQaFd1IUmn25gVyWbXmfqWaE9
	HddLXviwVYs8ClvB4+0C1ebRshRjEzTcu6C/wRIfrrcD+qdsAFfdwceW7TKnpSAkBySQwBLwMgE
	2bLX/hpHCQTduNoNDAum3AXZqUM8kt9fP2ewrAXLk
X-Received: by 2002:a05:6000:24ca:b0:441:1e41:19c with SMTP id ffacd0b85a97d-4515ce1c372mr35489652f8f.20.1778489604245;
        Mon, 11 May 2026 01:53:24 -0700 (PDT)
X-Received: by 2002:a05:6000:24ca:b0:441:1e41:19c with SMTP id ffacd0b85a97d-4515ce1c372mr35489577f8f.20.1778489603627;
        Mon, 11 May 2026 01:53:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm23522307f8f.34.2026.05.11.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:23 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:18 -0400
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
Subject: [PATCH v6 07/30] mm: use __GFP_ZERO in vma_alloc_zeroed_movable_folio
Message-ID: <c9448249c53681297f44d18c3396a3329b50d7eb.1778488966.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -wG0n_8rc6YHR6B33WCF4jbzt30r_KQi3H9uQ-2UTJ0_1778489604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that post_alloc_hook() handles cache-friendly user page
zeroing via folio_zero_user(), convert vma_alloc_zeroed_movable_folio()
to pass __GFP_ZERO instead of zeroing at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/highmem.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..ffa683f64f1d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -320,13 +320,8 @@ static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	struct folio *folio;
-
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
-	if (folio && user_alloc_needs_zeroing())
-		clear_user_highpage(&folio->page, vaddr);
-
-	return folio;
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
+			      0, vma, vaddr);
 }
 #endif
 
-- 
MST

