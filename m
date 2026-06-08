Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18423B3C03
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907899; cv=none; b=KlYkkClmSsbJAvo0WORDOSl1OKFd/cRle2ffHZgBG2I2Uzms86VlkAxKZdQnKp3gw7fVapaQjJtRnsO7U0l6u9Qe1VgxJ5p3qAGmkdA7hemaz6xZQKrPl7qo46xtLkyODCAd5u0vhCd88PcQEDFujMpN1ydsSVtltppm53raBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907899; c=relaxed/simple;
	bh=8+ZahGpeDELrqcGB1YJH6oTjGbft7NUn5eY1+HiJ8Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ne4nHnrydKp6I7agbY1UyxITJawSdWF5XMtLIaSCDn1YKUIHuU/4gV7dXnVLADe7y00OkSFwYHD9x0dNqFd6OulX9lC6lmzEfrm9XTccSIodrVcXtZtAKsRlPyX3GJTIWi2gLM960WAAuDzt7szHlFM2UuYzB5WWQaF8IE8UeEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dnz5v1hZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dnz5v1hZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8mD++2dfZtiFiQOTpn1O7CzJ+9UexLHDFBwODnyZcw=;
	b=Dnz5v1hZ5VYZpnXj4aLHWgMEN+YJ9+OVaXgnHrJ7AfwYZS9GRzu4w1fk1FaovBGdDaSHIK
	JCknB7HVmfNbYWKkP8h7qHWTXZhUe6VLfNJoAsceiHY6+YamG15QdXF/lJXtyPqYOOU3cz
	hG0eFsLF44wofiYC/V+CRJ60zKP55CI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-7N-QRI9CM2-KaKz65E-pPQ-1; Mon, 08 Jun 2026 04:38:10 -0400
X-MC-Unique: 7N-QRI9CM2-KaKz65E-pPQ-1
X-Mimecast-MFC-AGG-ID: 7N-QRI9CM2-KaKz65E-pPQ_1780907889
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a060eb84so26821925e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907889; x=1781512689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8mD++2dfZtiFiQOTpn1O7CzJ+9UexLHDFBwODnyZcw=;
        b=kNL9AvrkRMtHKQiVkxjbGjzArW1FO98zi6D6vzea3QO0WOSxT80w2tUXIEEpJXvEPo
         drIpGdP5YMFiMCAkwBoHe2M55OGt5qtAvJlCS6IDMUnT1tLg5ndpqOyWQBGp+KVluZDR
         lVHQBH4QpFCgFhWOYy2E4qzwOS9XmFrZywZVOnHLDWNEjAhbVEJPSTtQ8vXhkQ3nvOtp
         50isBwa9HRgCvCy4esC7kB4S/7ujoGwqXmrGiFMZY7Uc53pBKXJPORo+n+uIaNNfTQFb
         ZvezWIuRbUaXVuDhNajl8SV9UxwLje4qPT5x5QWiWlbfXa4iyQ+faOlqEjI2jeYjZVi9
         NGHg==
X-Forwarded-Encrypted: i=1; AFNElJ+frL8c8vE84dfuU9zk02hXnLyoCKcGIOc+hdSBvcfDRPfxCECuJRAIXDhATji/EOWVGKQCuErDQfpD8STJrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo+TboQYBgie2Gfiz1lNkDLyR9r0pVmEI34lOlxYZKLbnj7Enn
	LLd9V3mgx/pENp2maHrj2LEAqLY1ajISFj5xpbT7t1dsBBZ4oNC84Hp8P5rusXVjU0K9Dxczgfl
	v78Wn3cz6ZPVxRpOe5IKBfEI7z/z1p4D1HthydvleQHpjZSzCAs5NticmNakdaG7FGboj
X-Gm-Gg: Acq92OGtY4eD4mSUYFq5HpqfXG6T/EUyZ+lgpWeFYbQH22+Z7qZ1x0v4jxXDJcvSW32
	jQptM2mJVRCXEc7K2z+rpWovU7rUj15XJCw+AL93zLOYpi8vcojSOW1FLf7xcklQi0qqmPjI70L
	oqQeoQDysXSSM+100DbVcBuEDHyKDmifp4QrShTjzVzY1WpNJqcqwRAEkyNefJztmARf/xuEz1p
	gNhS2545u4cu499T+8mPT7MkU59+KQ6D+qeNK2/ZWfA/dBDN+Bki/BHhR7NFlh3cPL1fKnXB0a3
	iaUsS0R+gg/gY7i0Kt9zZFxoVILJX/wCFXcbpJsyoo/RKoChRQ6E8VEdybu+Qr/sxSdWTBiGpZ/
	hXrpS8aSDlMb6T9KXyf82vl4=
X-Received: by 2002:a05:600c:c491:b0:490:bb44:3f8b with SMTP id 5b1f17b1804b1-490c2605385mr243137325e9.17.1780907889147;
        Mon, 08 Jun 2026 01:38:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c491:b0:490:bb44:3f8b with SMTP id 5b1f17b1804b1-490c2605385mr243136515e9.17.1780907888480;
        Mon, 08 Jun 2026 01:38:08 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc4082c3sm362037795e9.13.2026.06.08.01.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:38:07 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:38:00 -0400
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
Subject: [PATCH v10 18/37] mm: page_alloc: use aliasing checks instead of
 user_alloc_needs_zeroing
Message-ID: <d9b5fc983725665749024312f9ff5ede4f05e405.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: EWuhlFbpqDc11uBW2ghWZ8PjvfDPMztJ7vhZwW8OluA_1780907889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace user_alloc_needs_zeroing() with the direct aliasing checks
(cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()) in the
post_alloc_hook aliasing guard.

user_alloc_needs_zeroing() includes a !init_on_alloc term that
means "allocator didn't zero this page."  But in this guard's
context (!zeroed && !init && __GFP_ZERO), we already know the page
is zero; init incorporates init_on_alloc via want_init_on_alloc().
The only question left is whether the cache architecture needs
the data re-zeroed through a congruent mapping, which is purely
cpu_dcache_is_aliasing() || cpu_icache_is_aliasing().

On non-aliasing architectures with init_on_free=true and
init_on_alloc=false, this avoids a redundant re-zero of an
already-zero page.

Note on PowerPC: PowerPC overrides clear_user_page to call
flush_dcache_page after clear_page, but on freshly allocated
pages PG_dcache_clean is already clear (cleared by
__free_pages_prepare), so flush_dcache_page is a no-op.
Skipping this here thus has no effect.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 45e824b1ec75..edfc83571985 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1880,7 +1880,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 */
 	if (!zeroed && !init && (gfp_flags & __GFP_ZERO) &&
 	    user_addr != USER_ADDR_NONE &&
-	    user_alloc_needs_zeroing())
+	    (cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()))
 		init = true;
 	/*
 	 * If memory is still not initialized, initialize it now.
-- 
MST

