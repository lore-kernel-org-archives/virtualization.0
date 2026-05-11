Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402573C060E
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489616; cv=none; b=ABQwd7N76BrSIs4jskeN5MWzzuDplNaar+ZoeNWOjvgpXy7tod55BHdwPWSA89Iaj8+/aCxRqtYCFF1juOKT6P5axjAzr6RaXAufXlvxtodFYXO+MC4ZDJ3aThn4dmtFDwLfr+yO4MEr3a2zp7cNiozTPR+ak7gnNKg/Zaod1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489616; c=relaxed/simple;
	bh=MamMMWXXtV18pX2Nm4tlwaTMDaamkDfpCh9w7kBXTEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CUqH9AmklJaXX8DhuqNkmOzxnqazM+22ty/AhBsyD7Alwd0ylFpLQKdnCed4VuwKgT/p2+fqBSHldpOoUM2usjfU0Wb8dWA1eZjPukQs1tj9Rh22g6psGmxGDsEujgIJmh0h044afa163A3yY8X+il4TmG7G/iElRP5JaWfUGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP7zIgjs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP7zIgjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PyhJPD76XSlXOLIxrgX26vlRXB2m99TPkgzm+4tnrhY=;
	b=UP7zIgjsDYuqfZffq+BqUZ8G5KPYSa8esW5yi5WUmtE06mILBCKyxKWpVdPehcimA5GXo7
	m8WQxuZuRkfKQruTPhHokLyooPGBGTmT8sP1RbqUz44kBBKi2+MbSgIyGHpnDfl9Ch6+Vn
	BajS44Agx3s7uhGqH07ZsKs9cqOof5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Sc2rQONFNgOpO4VAWYRZ8A-1; Mon, 11 May 2026 04:53:32 -0400
X-MC-Unique: Sc2rQONFNgOpO4VAWYRZ8A-1
X-Mimecast-MFC-AGG-ID: Sc2rQONFNgOpO4VAWYRZ8A_1778489612
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso2523030f8f.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489610; x=1779094410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyhJPD76XSlXOLIxrgX26vlRXB2m99TPkgzm+4tnrhY=;
        b=E8UYID0g0liB8T5dC/TUH/ftBrM4RthK33aPsoikBwwn44cwASmC4QbsCJLdkfxbs2
         n7A3OjB62k0V9KM/X5fI+tkxqzmRHzlnvGMU5IamAIaj8zrzip2Y5cSwCSNYOwTeyFXN
         XH6wHJIblQsNERGkP4NOKkXYGWEvN72QSajVs0l2Mmyb5YU/ZK5o7fcDrO+akykf9MrL
         dMpWiOnIguks0nxGmWr7htisGoGJ+3xK7pWuUCGp7q8Xg+ZdpB1YNcpBVC3oAI7Hk+xx
         Z3cGTZlVQj5uAO8sqAGzi+YEcxJwQnrjxRhutbatiBNhBzidCAmVvenCh9q2GDUNw8hG
         vobw==
X-Forwarded-Encrypted: i=1; AFNElJ+c0+hc0GTDkYwRfvW81L3QzOuSIUedahjQu8+c/DgsROXb3RmRuKbNcPlBvrvjVhxRmbauiIq24JMTNwpmVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL36YtQcFZAO96h3VaBlu6uQFieWQ8xDaY/OyfV7fxOHQTy1Sr
	+AkrGtpD2iKr0sEhaOCO7tjpLChJAiCcrIX164uKBHIpt2hrAc/g0UcxGNM0IyhsGDldgWtqz4l
	d1bKvazb848p6tpUbzJSIeImsBsrAXh/YzNr/RMsYGODO4RZpVyiggIG9VCUxpvoMAR5z
X-Gm-Gg: Acq92OGzKOK+ZVHnN0Cr2aLLk2GWN0Yi/hI4776lx8N92breN2QF4xybzWEJCUE6nyH
	xf5lKfxn5ZetD3jS5MCuR95m+iTUlSL/MNIPNT1KipX3G55DJ92vYpyS/HTtpnTQUiaCnfuaJ7J
	Qjq0ahYb//dYc69xdLEnuaEiFTdMX+hutML5Ccz7sEG4P4Af+jY6rS+KOSZxVuCEC4ehI0gizpW
	cqfG30LGipWoSDELZSmlfJ6xd7XL1C6nZD7FrdHtgBnCgsxSwG4ntWCL3BTxHlW9rVLr/whqyic
	iHg8kBgqNXjpRz6LWoQYT6FSby2BNXS1IgDEPuo/zftMUJXjPK/HMxYN4fQiFJ1qKb6GnIyG5O1
	ukIahjo7MRLYWs40MyGQDtlLZ3iczbeC9HtwYJ2UfBVY1Gz4bSHQ=
X-Received: by 2002:a05:6000:24c9:b0:43f:dc54:9493 with SMTP id ffacd0b85a97d-4515c575364mr37802026f8f.21.1778489609609;
        Mon, 11 May 2026 01:53:29 -0700 (PDT)
X-Received: by 2002:a05:6000:24c9:b0:43f:dc54:9493 with SMTP id ffacd0b85a97d-4515c575364mr37801957f8f.21.1778489608944;
        Mon, 11 May 2026 01:53:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm24453888f8f.33.2026.05.11.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:28 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:23 -0400
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
Subject: [PATCH v6 08/30] mm: alloc_anon_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <a48bd110f808ef8df6cef819b11580bc10ff38d3.1778487000.git.mst@redhat.com>
References: <cover.1778487000.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778487000.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kTuyy8BEnTt7tm2zlC_j4N8aFziHtILJgdGHhizmixY_1778489612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
vma_alloc_folio_noprof now aligns internally for NUMA interleave,
and post_alloc_hook will use the raw address for cache-friendly
zeroing via folio_zero_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..0824441a6ba1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5252,8 +5252,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
-- 
MST

