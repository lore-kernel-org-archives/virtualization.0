Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BCF3E92B4
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068159; cv=none; b=CxJXAASS0brmPjfnRoLPvN8Tb/LWSgVxtfjsDEv8uH5PU3Lv1nsTBbO3+mwIRobgT3QWQ0HoYUd8/Vsp8Hl3sC6wmOMnET+C0xElXC03ElI24lfNV3JEZP5vdPf3nu1Vgc3oWfpQMxqkbAFDGzlpK5qGgX3Y1gebMOXAN7eb6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068159; c=relaxed/simple;
	bh=zfTSssqCCnno4sdUyiW/sc4lt3FSQTZh1jfv0HEfTik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DRD/pez52RKfU+uYOkCwEIXTyb1yu0aYHoMa3bGBov0yH0wNw0+hbI1XQDnoJpTlyrqzxw19NWqVYNElCWgyhADWDdF26azYRrSKAnPmV26tbn7s9DEaVuJGlE8D+QrhkrjoArJSNVSUhtBYjSOcYPEU64xh0FB8TjV4ftDZcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPsGkl+G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPsGkl+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3RnCcviTYcs0bJrQCPa7/Ta1tOKxh1kkpoqwRDnBft0=;
	b=BPsGkl+GyXee2U4MnWhMLuRMY9N6zyYc2I9z9vCW1OJu6HByIOfsc9OFqDjAkR8gYRm1D1
	uozV71XvNqnwFGVqRDSgV/hwcden+0i8MOcnfBBkqvkXIay3RwJaYHpL5zpf3qxN+veqWF
	MqiABdic1wjpftBcwCJkpH+Oen7cXIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-5wNpWkusO46oyBYeSGjg8A-1; Fri, 29 May 2026 11:22:33 -0400
X-MC-Unique: 5wNpWkusO46oyBYeSGjg8A-1
X-Mimecast-MFC-AGG-ID: 5wNpWkusO46oyBYeSGjg8A_1780068152
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49081106196so27065255e9.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068152; x=1780672952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RnCcviTYcs0bJrQCPa7/Ta1tOKxh1kkpoqwRDnBft0=;
        b=JUffKyIDU4zEbegUKzT5/p4uW4QQurx00NHYr1NrplHHF4Q3NqJaN1cRGY7JPt+aJh
         Xh2Gdv6YOeJzhrfkEMegq4etcS8NR9yX+NuW70BeUMV/TkwpI/O2QToFQ7atpwVjO1Mp
         l0VT0sW64DXQT8dgtOhi5tgRmjB1Oo79UzXZrv/7nqkt/GqgNaL9dr2wKz6aofUkXkSZ
         z0AJKckWYAPjfzdbeu10b26CRTmZm7fdpySO0v4XVQp0SvkyJOhvoWUugtGscAUbuL87
         ga7RqrhbyXCzjlWdJrjovqzL6fQHrbSHJjoui7gAXtsaLYeQglMODDVkumTyiqKM0Gqa
         QdAA==
X-Forwarded-Encrypted: i=1; AFNElJ+69wd/p9JJrBDjGdnbF0hBT0vEhyNLWrpyAaSnY9XyAjLsflEQ3t43/c537EADZOxRbnYGsJDAs6YaWqZ6CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YziwjSFwdhIWwPfFp+8xKcJOAEoE5WI9/c0gU2wz4OPIqZiDWIy
	WM0DHGEUtVaff6dWOtGHMun88GELNZn6hLfZ62t28cAeDENYvBM+O0jzDTfxwzrOoUAV1GGU4bZ
	fmYxrVsAS5ULbVAyFIvSLNBXb6Lyx8+iGiK376NwpdkQJWr6dlnt+5EzyYcPrpyfG6MC5
X-Gm-Gg: Acq92OH2Ku0AitznHRZuhIYUv6NkvJleoK9CXBMayo4HEnaSEtHuhPyiFfgck4RUi6u
	k99HIWazY3v+r5jITEOmnlqEEbjCesyeC+wEZdlPNH3QEan9xo42sIPBUtMSj3z3nN33GtCMEf8
	bXAEXGJV2UoWDMvlpbPSd6PctOw+DFHPcvW6L/3YJ9rxiTB02uTrlcPx4STuACSRzBvZJ3HYYxm
	Tz1JlMl0u/bOcxWJX3kQVKPrhGYoQvgJnBYBycDsN+/f1D4JvIkxJKktHh1/0/2qvSn5kSm5Yfi
	Vk6bl4NUyVW9fF0UTTikfd/IB8xBdIbAHL8BWhnSMAoJD6qpPgZ03TjertbNwjSyJ5+AIiY5Y53
	o3+7l8FZlW8aX0lT/jcc8uloYUo25a9ZR3whI0qtzQDAMJ0bjpPQeKA==
X-Received: by 2002:a05:600c:34cf:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490a2900e81mr2227855e9.7.1780068151779;
        Fri, 29 May 2026 08:22:31 -0700 (PDT)
X-Received: by 2002:a05:600c:34cf:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-490a2900e81mr2226845e9.7.1780068151254;
        Fri, 29 May 2026 08:22:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6eb3adsm46766005e9.11.2026.05.29.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:30 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:26 -0400
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
Subject: [PATCH v9 05/37] mm: hugetlb: remove dead alloc_hugetlb_folio stub
Message-ID: <8e2d9431b0e324100d550c765024c883560a4367.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: P0_-r_eLtvjDtalTXm0LYvUdXlPD1hFtO0oqJYb3TKw_1780068152
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/hugetlb.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 93418625d3c5..f016bc2e8936 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1129,13 +1129,6 @@ static inline void wait_for_freed_hugetlb_folios(void)
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

