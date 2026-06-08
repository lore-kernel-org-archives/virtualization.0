Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590683B14B3
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907718; cv=none; b=BFchu+RCO1JJ+9qkBXQTQZo0Bi820iQXtBGycTep80Hf0r+xOhIqtKxxdt6d6R2+VBd7AYa1BP/n9wrdtWexYUg+72wgirxODKDjOBgGxiFDicZJL+gxdUw7Np38Hhr3/NXQ1t+0A5u3Gj8utxLZK0r8FpNQ8JD+Hx7lR4H5jXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907718; c=relaxed/simple;
	bh=Sfj5gt6MvIEmG0HbHoKsMbRpZjmrEHXu8jQM2CsCIY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K87Plsxai7qWXWc8dbauWp5x35/Zc4jj9g6uS+QrZF3dkvQrPqtmI/IbRVqRA7vCX8cGUdb1miSRIdqaCAvU/UUgpmpw1rH3ZisvK4c9dwAbNZEir12u80VxpezWSLpbmFYtcFL3QlKeJg9SsHOvmzloztQV3zkHqbuXaU4FTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uc4HBsTl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc4HBsTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrvJesBjI5N3mqdjRc1dMOyxu185onYyp291JtEzMjE=;
	b=Uc4HBsTlvezk+b0JgtlKd+6I4/ISGhgE5FsIz1uNNKFj2ZtAaqobnXe9KV5DT81awxqAiB
	3UKKlEUK2WAZISORRCCgTAszE1Wt4TgiSWTFaN2ZaCRiQSv1dtj0x98SF33XVcJoSTZkfs
	k9XGisyq4eRYRvMDBrEr6YI/mE/RVeU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-_GDV-XbmMByNlb5MffM5GQ-1; Mon, 08 Jun 2026 04:35:06 -0400
X-MC-Unique: _GDV-XbmMByNlb5MffM5GQ-1
X-Mimecast-MFC-AGG-ID: _GDV-XbmMByNlb5MffM5GQ_1780907706
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so36084115e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907705; x=1781512505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrvJesBjI5N3mqdjRc1dMOyxu185onYyp291JtEzMjE=;
        b=opAoaiAnzdY6OMbUCWK7XmYjKCNPMFWPqtf89Y7wrcDJL/OBX7jp4LhdplN38jHEAZ
         Q6wgFDy8IP7XLpU4QxCZVQNNlZWyqkN/tDzouNx6FdabCBrHFYtn/4TRWBJOxFuRCQLB
         q/gqyh0dat/YgZV9eZVZ87qXQrJ/3jCRE4T1Pt+25I9spMUafwNPEhOtDhm9tJGK/kQW
         Tfl+NVw6sPa0sGjPXMq6+pNloSBliJSe6dE6KDzjnTZPOEu/u5C+/zv7O2H999lYBfcW
         i9/cKR6wkaq31nTitqz7IEuASizeAzQ6Igf3z1SNK0H57loPb+cqoNmJr4k8mjQynuGp
         0yFw==
X-Forwarded-Encrypted: i=1; AFNElJ84ShdcDz1w6b9+qPDN71/VumeXz64gX1cHjMZ3iSm2IbTt45cDSUCX0F0i2J8UCHmjGiJEhcc4PkyPJif3mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1b1D+93obWRLtsglUhmCNJ3qs8SOS9Kh86FvtTbGbkV/GgU6U
	yIe453VqMY6A6l26LKwfe8X5hXdcOf4WXq5DkomUqKCGHvmLdycoa8HSGwz5K+H57fesVu+dD06
	tht4f9fOIZA2i6SBOwEFOsvG3EG0eqon/KUJB2hbzyZVYahFs35hkex5JbagnmBm1fFoB
X-Gm-Gg: Acq92OFnXOwFxbbucik0/Nbc1Tl1AfJa8c1w6WhMk2ajSBHZApPmY5qAXVnPKq3tKDa
	3wYR2S3TSL86+R9YJ8hoF2ZGLQKqGUX7Xpa/LOxUJg/D/mIY0z6bR51RIjD8mAzBn/dBe8Mw0l/
	dnJYlFEVx/C7CQSAP+thzWpZheskS0mj1nVa9ub60y1mVoUj5tUXkiffLa/lOrArstMPfHFOQiW
	vj11365jg9DDoek10O5Yea+meKUwa+UM2tk8LT4RpvTa3aG+FU/jsFUFBUDn+kECQywmChLLFi8
	aYZ/+vtv9ryJjwPHasXcl5qmXlfGnnmi0A0K0/9Yc23hnh3Nid1OKNQA74Qbxz5+7nf8uKfQBAm
	j6O5iPzTjB4h5kHLKRTxXVrA=
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr252123475e9.11.1780907705496;
        Mon, 08 Jun 2026 01:35:05 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr252122505e9.11.1780907704887;
        Mon, 08 Jun 2026 01:35:04 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm433938045e9.1.2026.06.08.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:35:04 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:34:57 -0400
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
Subject: [PATCH v10 05/37] mm: hugetlb: remove dead alloc_hugetlb_folio stub
Message-ID: <a9b5764c69269e5c0518e496b057a75354373b43.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NY4fMP2azVlu3Bhpgad3nNlSYfPQprQ80hed1HLg3xw_1780907706
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove the !CONFIG_HUGETLB_PAGE stub for alloc_hugetlb_folio().

The stub is dead code: all callers are in mm/hugetlb.c
(CONFIG_HUGETLB_PAGE) or fs/hugetlbfs/inode.c (CONFIG_HUGETLBFS),
and CONFIG_HUGETLB_PAGE is def_bool HUGETLBFS with nothing
selecting it independently.

The stub is also broken: it returns NULL, but all callers check
IS_ERR(folio), so a NULL return would not be caught and would
crash on the subsequent folio dereference.

Remove it now since follow-up patches change the signature of
alloc_hugetlb_folio and would otherwise need to update the
broken stub too.

Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/hugetlb.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5957bc25efa8..1f7ae6609e51 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1123,13 +1123,6 @@ static inline void wait_for_freed_hugetlb_folios(void)
 {
 }
 
-static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-					   unsigned long addr,
-					   bool cow_from_owner)
-{
-	return NULL;
-}
-
 static inline struct folio *
 alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 			    nodemask_t *nmask, gfp_t gfp_mask)
-- 
MST

