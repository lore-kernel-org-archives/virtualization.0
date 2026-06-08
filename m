Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D913AEB2D
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907957; cv=none; b=BcIhZiWESGFJyJ5NspWSVLolxMhezz0HCrMxbwA9jp351mniJ0pWgTj3bxeMJ2TChJF47KWI2geotQV+Pn+5fqqUOwUlqWTtgrkiCSqlaQmd3dZbxKi+UyzcTjjM12ZXe3hHz3kdqW+D3LfMsTKXok2tnDWMyL+ZAKI5RMj/dUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907957; c=relaxed/simple;
	bh=GCycL8yBIVDI7qw2NQ3Ow74lnO1SdliLzn2m5qQWypg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T3fEN0C5JA9tHdEUXz1MUeqCsou1qK8sJlOnIzMRE8Osll4141oFPuuEOWrBvl5coA2WTkkoDFeRn/1FopoZft0e8EEkOE58CRkvL1FQMEDDDETJ/Yz9+Ke0rfw8pcFXuUAIdv/TERf1WvxAL8WWHMIbCZsYsmdEx+NloaabMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oc+QV+qs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc+QV+qs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3+rjGl0pefUb9vVc/tCmuC8Z28GLOAKmmZQW2TUwDlo=;
	b=Oc+QV+qs9O3xfqQQflJcbNRabWfHjVlloaRFnzN3mCCW+M31WbwmvhXSWjtIknERJDhox4
	N9tcvjXj0Uxs9VwL+poSFf45qk4+TPpwfqRz5Bigcu0sunhE49j5ETt9qlO3FY9oAAdM2t
	UJdQK0lJXAGBYK5UAWRjwhVEcWa0pvo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-7uXpJwR1NEKlYd5VCN1MVw-1; Mon, 08 Jun 2026 04:39:12 -0400
X-MC-Unique: 7uXpJwR1NEKlYd5VCN1MVw-1
X-Mimecast-MFC-AGG-ID: 7uXpJwR1NEKlYd5VCN1MVw_1780907951
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-460153ce644so2916749f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907951; x=1781512751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+rjGl0pefUb9vVc/tCmuC8Z28GLOAKmmZQW2TUwDlo=;
        b=AV/I81HxtbN6AsEMWdHDFFflREUwJkPhk4Rlt78mWjSPl7ej3sfY4y8f7Jk4L/3UF/
         5hhbLyGamwrfF88Cc+qWorkRnyknux1anMybGlX1yjzyWiUf0xNnIz2uTLXsvahYyfm/
         wrx+2yv0XRZKmPHRJY1r8MO145/59lpI2SyiT4CusyKE540m2JqZmeKGpfUEyRfC6v6l
         gohGJVyQAf37gENdjY/ofGRUZ3wve1J7V4CUw4upTZlRPNiXSMkXynfGMzWaSM/I9McF
         yO1jtkFfKZlLWhV2zZlfDTi3hYkV4C1ltMOM30iEjxmCncxddgDoNWQUocxye+vkQiEP
         kS8w==
X-Forwarded-Encrypted: i=1; AFNElJ+B+9uzQCfUtL08G0cRvMU7SMpoJ62FJdYL3Y4zZNyW+mQWYA9ebuLdv8HJVr/sk15C3AiFs4LLh2PGYlW8Uw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw/VYszvHI+pU6ICJ7rLfTj+uPcO9VR9Pbb+L09UDMEOrvxKGE
	Ny+KbtybVlHlIDm8BKe5/gtSftTKWXaqBkikPNX9w8gz6bw5R907Jq961GQr/RGy+OwqEym+/Jy
	vnQ1J0lShNxuIZGUe8SKOsJee34kPliOu6bcMtxa/L/LY4ZJy2aFjvuiohmcYesLOZIAL
X-Gm-Gg: Acq92OH9wmIFImmvRnfjiP9IlVGyIVABDKruG7rspt+Xe32WawZvdzQNIFwYSxy6y2O
	OwWhASZ19yqnX0kVz5fI3vz5mPv7mpd+H40ozz7TpJUy5LD05jpNfdT3NMM23MJ5/UPCaind67U
	5yS9KbUiN5JKPl9QWmVV9v16O/SAe7C5B7MLUGWEAUi6IuQjx6f1QNgYPl1zVPEzA2fze3rsFPf
	oQydcE3f44tVKAKIxRg3HiAj3Hs+kPKIdrKyKEEyR0fH01FA2irhn1JuLL6OuyubTHg0xG6kV+P
	Pt3E0GF0Lj1ezwpxUtL+fksabpF1+4FTXQ6A77ZQeeBYIWgGZxrSK2LeETgKhbbf0FmGeqzowlA
	rTI8Gx6rRnJKGWWgEVz+WdGw=
X-Received: by 2002:a5d:4a85:0:b0:45f:f142:d55a with SMTP id ffacd0b85a97d-460302e5e92mr18158162f8f.14.1780907950676;
        Mon, 08 Jun 2026 01:39:10 -0700 (PDT)
X-Received: by 2002:a5d:4a85:0:b0:45f:f142:d55a with SMTP id ffacd0b85a97d-460302e5e92mr18158101f8f.14.1780907950019;
        Mon, 08 Jun 2026 01:39:10 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm48744304f8f.16.2026.06.08.01.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:39:09 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:39:02 -0400
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
Subject: [PATCH v10 25/37] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <13ed2aa6607d510bd8dc6d602e96626511ee4fee.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: aPQUzrz2YRLu2haNf2m8aubWXnjMnFtoZxeL2BelcGw_1780907951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing
at the callsite. post_alloc_hook uses the fault address passed
through vma_alloc_folio for cache-friendly zeroing.

Note: before this series, replacing clear_user_highpage() with
__GFP_ZERO was unsafe on cache-aliasing architectures because
__GFP_ZERO uses clear_page() without a dcache flush. With this
series, it is safe if the caller passes a valid user address
(not USER_ADDR_NONE) to vma_alloc_folio() etc., which delivers
it to post_alloc_hook() for the dcache flush via
folio_zero_user(). It is only unsafe if USER_ADDR_NONE is passed.

Note: with __GFP_ZERO, the folio is zeroed before
mem_cgroup_charge().  If the charge fails, the zeroing work is
wasted.  Previously zeroing was done after a successful charge.
This is inherent to moving zeroing into the allocator.
Charge failures are rare (only at cgroup limits).

Use folio_put_zeroed() on charge failure so the zeroed hint
propagates to the buddy allocator, avoiding redundant re-zeroing
on the next allocation attempt.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6c14b90f558e..6d6a3e1a02c1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5265,25 +5265,16 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		goto fallback;
 
 	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
+	gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	while (orders) {
 		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
-				folio_put(folio);
+				folio_put_zeroed(folio);
 				goto next;
 			}
 			folio_throttle_swaprate(folio, gfp);
-			/*
-			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used) or user folios require special
-			 * handling, folio_zero_user() is used to make sure
-			 * that the page corresponding to the faulting address
-			 * will be hot in the cache after zeroing.
-			 */
-			if (user_alloc_needs_zeroing())
-				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
 next:
-- 
MST

