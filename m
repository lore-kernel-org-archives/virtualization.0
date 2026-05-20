Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5703BED5C
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315704; cv=none; b=XytMPJW3WZGtSxYMdHFdePzV1sAAhsJg1+ZGcmQdHCO2WQkIKu9IRb2IGQRd7lJwDmagVK4wGUF79FIRhwsKEppOnt6pdg8nSypfWdOsF5EvVm8LdGn8yNbSzIr6nZrgftLDr7XYZg1PVm4RDGJKwGTLI8sVhzyZAVqJAnUkmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315704; c=relaxed/simple;
	bh=B4v7SD6SJ84KapLgBy+iXreANiiaF75HE81bu1RBt3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r/2wtpWB1VYYJvWfoW6sv7kohLYGQW7uk2jWX+GRoOuW5peR7UvAyuc+sVtLHejxnql6eYcGRerux16I4cUBIKxjEjdObYM568oOOjdA2+oCLwmkSgOjB6sg1JoCnFMTLdLR3eEhPg2iFp1M55Z4UJp3uDQrsJFSHL85Mod8edk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ay/iaZkH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ay/iaZkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
	b=ay/iaZkHfOAYwlSlXLbBF4/axJd0NLUBQSbgNENDC0yVyMG2BGWWukB95/c0EP9diLCv9E
	6RROMokQvP+Hplo/JqtAWqP824KLI892JU50kj6VI1BUzAxni+DVAhKoiTaSsGVZawbe3w
	wEIMwPF6caiGaatSRqhXILZ3LskVcVU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-7EU3S2igMPSMqdR9O8zg6A-1; Wed, 20 May 2026 18:21:40 -0400
X-MC-Unique: 7EU3S2igMPSMqdR9O8zg6A-1
X-Mimecast-MFC-AGG-ID: 7EU3S2igMPSMqdR9O8zg6A_1779315699
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso5149312f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315699; x=1779920499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
        b=gEHPw5TnmlXhd9Y5EQiKG2ouhZZ4d1aLpx9Db1B687rcdPkTxciG9bRxRIBjKKJnxU
         ILkBhUHhR/ESTDNIsloYFg0X2uBM6RsD19fQ+5tKTyOeqfolAehQaGIhN928ei/PlyKX
         C0r3/NCDaVZ1BdFX1CAQAsx8smwlGX7GJe3lCywcUOW+zv4zPqfvF4d10PBUKx1w2NVP
         rTSl/L1cIYuzk+jDEz9UURpHXX6maVxM7GcDXYmXMTevk8kXjokgjr1ydickAeIshM8c
         WAi72aqqnVoBsut/eG+9GvTmF7GGJUlEN8vO9vHPNmvXryouhB7QdRllguIwrXiB9+AA
         HMsw==
X-Forwarded-Encrypted: i=1; AFNElJ/7G5E+KD77kE1z8mTkD1LNXK+6LrXU1MaHZZs+d0waRyj/K6+fM703CXwSYKs06YrQJ6PVXiQaBlS3vALWXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztKtf/suCk0VLxOoQRNrwFUb3IhopxbdEVQZMBx8pkXoojdry3
	kRSBF9clb2KLNfu0DZuqSqxQgHWlpHQXyrLwmBAaNmjvE9a9mZkhPXP2DuejejDkh9eLR8HrN/L
	FEuPP9OdBkovAqxStbd5dsBwRfQ2aiLsY0EQA1e5Cwsdl+j1NEGjTmvwylrdwJI2rFAPX
X-Gm-Gg: Acq92OGgCZSJ9IaA5UO1eYy8UX9cqdgsH7gVeK6VRmM81ba8l+Ot9VLp+5JEzU7BCFS
	Qmv0uAQN0oeiYtsynuS+kFGiK3LfTehF6vtcgCzfDa3BaF6LDIP0/rYEtoQv/i8BGSR6DPGrZ+T
	7OYTighBhJz6KfeHhjkQm6IbxUffr66xNTueoahSgLhjoimfKFjGSRbrtfUEIyUQw39StO6jrxG
	5YpDaTFKI+QYu1yCf7GixmfJZxsU5noPrG0oMBJIb3bMocSHdiNblirvzcg5dm22O8Vse6hSbId
	Zxdn9LoIaiHEWL0H7/LKyRHmKSNGbpCmi2JuW9FWXdj3lG28PTafgjO9G6bv3+cPBaw0BLK2lWk
	KSqkitKC3Ls+H44CI5os3xuhyEBNbzAjgpOjQMp3iqOo=
X-Received: by 2002:a05:6000:186f:b0:45d:b14b:23fb with SMTP id ffacd0b85a97d-45ea38bae4dmr340591f8f.11.1779315699150;
        Wed, 20 May 2026 15:21:39 -0700 (PDT)
X-Received: by 2002:a05:6000:186f:b0:45d:b14b:23fb with SMTP id ffacd0b85a97d-45ea38bae4dmr340516f8f.11.1779315698648;
        Wed, 20 May 2026 15:21:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm55493374f8f.3.2026.05.20.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:38 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:33 -0400
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
Subject: [PATCH v8 13/37] mm: use __GFP_ZERO in vma_alloc_zeroed_movable_folio
Message-ID: <d8e0bc4a28e5916b47840b824991541b2a76e5d1.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: PfLwYoo-UV0sVop8Hjcz2Dd-8cmEBgypr7K7ff6dE0Y_1779315699
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

