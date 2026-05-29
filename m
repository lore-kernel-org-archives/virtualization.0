Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605D400E16
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068199; cv=none; b=nVGoB4KeCf5FPai3YRbp4/Ob9UOJiouBPImPqWYkmGvaQxKOkroxNnv7vsG+FymNFyJS7ItJjc0jIuMpaKfkL2tuIDSIvfCfB7lmJ279CygvDJvlZO8AUEWvq0mV4I12K6mszZ7CX28WEHjXTSeLKrDILOysSFMEZMJhV2osK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068199; c=relaxed/simple;
	bh=B4v7SD6SJ84KapLgBy+iXreANiiaF75HE81bu1RBt3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l4cMW2eF8U6dsk/aJVK+DUED4mcHZSwrcWtYF7suvKEB3cNiocRDuruAwJ8bwFaRJR8kbvVZpcsaxCrj1+BJ9z177pDJLHpn5voTKiPLoZIC1en6r31+6QNogwOitzDi4xuq2xdCguUmtvAma0BxMim+qeuzCV0duuJKqz4uM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fA2LvXpw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fA2LvXpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
	b=fA2LvXpwNXBY9i9VNqYVWuJhT7D9enoC3vYuFl/VvLDycSDbMNsJz6RlRkn9X9atVLAjx8
	89Ozct1anZ2ft4lm9mPwnlUNHnpRVjaZiesAIHVbMDhREStbfYnI1eunHOW6YjX5QZ6z/8
	bHks+boGjgySlMylxlZHTezrJ3twDx0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-1oRt9BMwP567KZbAyf2F4w-1; Fri, 29 May 2026 11:23:15 -0400
X-MC-Unique: 1oRt9BMwP567KZbAyf2F4w-1
X-Mimecast-MFC-AGG-ID: 1oRt9BMwP567KZbAyf2F4w_1780068194
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490479c2911so83513175e9.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068194; x=1780672994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
        b=EQuv6EwnJtR5PszxbNMgCk+JHmVrCfCB/Chvjid5ri9ur4rdKG914kIMTSxicfwIaJ
         VwukzWTPTGioa9Ew7rm1U4ouf9CAK9KETHSpcSzdXdfh5DaSumdvxwoCU4EsHjrYiuq7
         YgsD68bWifEqe0X/GjdNdNs0cR+YTtQTvRSvJoTBMzMH8iBHDKv7KwEM0EvzkNbMAqfc
         RtV7iSnC2UzMjCnRqVFl2QAHU8Y5nT4RRu8YVskDgBLsIiifAU9fGxwfm46qBWnegqiL
         eF11QlTjzNOZxV//+0m+PP+upip/fMLyhvaMndbzzDKoa6yGeGr4W2cIFslX1JQsjyrr
         /yBA==
X-Forwarded-Encrypted: i=1; AFNElJ9cgWIa2889A+CK4IeghkPBpLFgJNN5Nktefep0Mpee4ICD8jOcc+vNZ1rfFAbajKqMJMTYh6R4nDM4jeRJbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtCbRahFtYi2iPcQB3nkL7z337qLcawS3zoyOUsrhU/DEL/6o+
	CRhwpjXwzBWuGcLgq5sPekumCzup5gS9Z1PbSj1zvO/JC6A5+/O0rukXaXqJ086A3G50Ks6OLF5
	TJTEFwgwsp3OqX+APQjhT3iz6QmU7CB7sUSRSSwqDF/oilWN9ILU4B4u5CEv5gSV7bAh7
X-Gm-Gg: Acq92OFbtPBK7F5wchl0kaMyVmoSy/YbF+JBy524inmiTZZetcTWnkQqtOlF4luKroK
	/UYhzIH+ySCgphaXCMoTcto3b/x3KYZEUiFnpAMjZr71W35AsF/3e09XqUIdDkzssv+9tF3/Bet
	cCVJmp9m9gyYaQ22iMjI8HpQxgTS6QVwkvIgSE7Dk7wSVXEYbTsAD44Buoo+GOAywUz/LLCpd4w
	keiHNRVJSybGD3ttgt+WfYYP0EyyRje5raSi7kL00VgQDAoYnUPGbDvKFgWTP2dhQPKZqQULV4C
	ISDgI1wruGzZNCPbwENJoCSy6zpW0I0IXUuUwNowJ7qX2wbOQJtfSzhFkjcM/+DAqM/fz1/X5ld
	icffWKsIS4TrxdtBdDwkuP8xXEjj1cpYZeBBA3HRHsdsY/IB6ohwssQ==
X-Received: by 2002:a05:600c:3587:b0:490:958f:2a5e with SMTP id 5b1f17b1804b1-490a291d967mr2191485e9.13.1780068193992;
        Fri, 29 May 2026 08:23:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3587:b0:490:958f:2a5e with SMTP id 5b1f17b1804b1-490a291d967mr2190915e9.13.1780068193465;
        Fri, 29 May 2026 08:23:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35601d7sm5881021f8f.28.2026.05.29.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:13 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:08 -0400
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
Subject: [PATCH v9 13/37] mm: use __GFP_ZERO in vma_alloc_zeroed_movable_folio
Message-ID: <caa240ff3163c6ad118156a38aef54f48af0f942.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ph1N73op5D1fu33Gfre-u7pohlZ15AAcFEywyqhXls_1780068194
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

