Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C3274652
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619941; cv=none; b=oF49IR9vs+hvcfbG4k9HN4Jm54lKrt7A+7pUxWZhxAXhSvvU4ctKHOB9ul9NQ3kZaO6hQiiQgVwn75QxjsPO6LItDwWD4ndo/kizWHA1fpBgNtxOuxz6f8zlVZIq0SEr5hwYEBhDBpK5NwrD3sKGQuTSD/2tNMIXqpF2ENGs9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619941; c=relaxed/simple;
	bh=dbqodEtBSdW6l7fSNG3X+ow9g33S1jhVrQg2Ca7vU3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AnKqRci8bgzbh2bCETPjSZ/YH8a3/0E5pKKfL4V+5IYKj/rL5n570FEostli7yjeFc4HDCB1kETAzj/AAZxZVtLoP7q+xrtX98x/nNgtgBVA1rWNfra3A8JAFxKeTGy3dWqOComKwhM4Tip7u6Fxfi3bxLQ8DMt+8QRP9MH0F00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BM5RCl7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BM5RCl7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73ni6E1OiylZPcnUbU0EX/Y/PdtoGvrjv7tOovuvhS8=;
	b=BM5RCl7m3gpNZoDhC2mlAqqWa8FzLsLsOFJugBc+3DVECwncmbPd8/PwrQO9u3IwpswD6Q
	noZ7EQJ2dEjeoQbr9g314GziCCT6HJvC4tgaTm+OcVyEVSaBeazyjCK2UOA2Q9P2pwB2rF
	Zv/EP01yYbX/T/gwnMgsEfZbZXSWkZA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-zzcEaa9VM7-NUdNqJlaZtw-1; Tue, 12 May 2026 17:05:33 -0400
X-MC-Unique: zzcEaa9VM7-NUdNqJlaZtw-1
X-Mimecast-MFC-AGG-ID: zzcEaa9VM7-NUdNqJlaZtw_1778619932
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ff19e54beso4179557f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619932; x=1779224732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73ni6E1OiylZPcnUbU0EX/Y/PdtoGvrjv7tOovuvhS8=;
        b=cbTvy6C2r9z+pna8iricKqe9TBlk8UI3oyeb40zA9vtPkV3gF0gznD5/h6jVQwTsv/
         aaVp8yOp2+bB8gVjhfbeeGKT3DovOlWR7QZniDwhu5kIOLkA+T31IbhjhykUlvNimN9i
         zsK/JL60F6F58gy5cL4ZUNPHQBm1kETPV/NukQHEw664yfgrq56yY118tiPRElBUbCTL
         lOMgfDmgo5/jMfTRH1BE7kxdsHeonA/kKS71u7BJeGv5ourEBfWi6YP+I/4Vd5K+IrvE
         QGLrFw6X0dsDkJXwIa3GGc+ybqbEKLpUsWvl909wArwq/QHOpXvH1+3/RCOBdE68HcOj
         48DQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ex07PyDYaImjBVFBcwae/gqLLOGr4+TmZDhTl8JgkqpEvvVznZyAQEBgn7OKfZneq7+Grm1kry97+MV0CTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhcWl4FL3a+s/3hQOmGHqLi1XLWoJ5UZ8g155nVx+HyHHiKx44
	LHv68s4aZ0jK0rQBKbTirHDbtd7Z+m96oaE7F1XA3K+iS72DeFP61AVpfuoaP1V277UaIs70Fe/
	iB41U3CkJtncqqYK0od9bFD1cllKgUCQfTCKtEqSh9IRNjm72uDyhAmt77ixevyTYlOwM
X-Gm-Gg: Acq92OGnJsYwTdNR7B8cBTeNfXc9MvqmF0OpUOgf4+nelFKhhjhxc2gj0aDgnida4B4
	MsP3VER3fBTOYAb8v/I7Tk2bg2Fh4U3nJPXhBAviczsfixc1AFNPZZoYGSHO3EBBfT3kivZvww1
	17ex/kWNDHU7U+eKPrYhPC4oFJ6lRSiCYmVkxE3XpK+K3HzrueD74GpMkcr0NVAUx0X9RsVKwtX
	mgTRpqfGkQlo9iaox4v9kJUSegsy6AFMsYzHC4A7O8n6J3jxLfGWyHlyL7En5/tG48xXQTEexyW
	+jwLPItqDan3hQU2EorRbMtY8F9zyGvo+lidzXPrtguw66ihJTg55qQ33FGALrFHO78tOj9Z9xO
	ps3OG+OtGLJJ0WwFUpAPt+xxMcE+3h0KgeAYy413R
X-Received: by 2002:a5d:64c6:0:b0:448:659b:abec with SMTP id ffacd0b85a97d-45c580ce38cmr505592f8f.8.1778619931858;
        Tue, 12 May 2026 14:05:31 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:448:659b:abec with SMTP id ffacd0b85a97d-45c580ce38cmr505522f8f.8.1778619931288;
        Tue, 12 May 2026 14:05:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm34124809f8f.9.2026.05.12.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:30 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:26 -0400
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
Subject: [PATCH v7 04/31] mm: hugetlb: remove dead alloc_hugetlb_folio stub
Message-ID: <0143c5e2086fccb05703500c9269a899d4784768.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fmKbPqO54AAdWqjYdt4I-F2MoT44KXuI-1S-NmffVDA_1778619932
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

