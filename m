Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128813C8713
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619980; cv=none; b=PQkEaMQtO7MmazbcsgmRyvCOSqzofaQ2noevJbZ343ajory7rB0b1wHYpPKWPPRgEz4FnWpV5f1GqXFo1FdN2jGKik3i0lvwf/nyi56KbU9V3lq4ttgdHExIiHlBqKAcbD3zgpTsCrbGTL4BZ7QkKjqTZ42lbriLmmItzYCNhqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619980; c=relaxed/simple;
	bh=xVZpENOTPSkcCw9H72WToBvwV1ZsJAWZkigdtcUbLLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bN7hgCJ70Q5I316rtfvaufzsBgbZ0qfkRIfFJO8Mr/FAb1j/R98N5oEtB4kDSFawwPUxpSh3l1w4IDuSJEQRcPEFds55RUqaD/waqSsfqmiJUKc2UTSCdGYk6rEt1VK3EiMqqMerrl903ClszaVQWGgfEVqZSjbplSiW7br97vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTOisEHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTOisEHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
	b=OTOisEHBFR3GMrAk07lTMUOlFYl3GM62PNNaj0cDJ3rEtBpvACfh38V/idPg0Oxvn8ESGO
	X+ANdyNrfqiphv1E5RWSsdJM3JiOXayUOcytJbozy+MltmpdpgnYtZkeAkMbZRkeGQJ3Q9
	qpK+368nFn054SmStiihR9OJglu7LzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-1NoQ1cE7Pm2Xgl8R0myDRQ-1; Tue, 12 May 2026 17:06:13 -0400
X-MC-Unique: 1NoQ1cE7Pm2Xgl8R0myDRQ-1
X-Mimecast-MFC-AGG-ID: 1NoQ1cE7Pm2Xgl8R0myDRQ_1778619972
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a3aee3813so3117335f8f.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619972; x=1779224772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
        b=H4P8FCUC5SOGuC0V4YGsPsso/6q+OrBoVxf9OW3FC7ZOef4erO+3Rf6qOj4TMdFp3y
         x5JRpN3lkdga1Iqg+fdkxI2xhNMhvMqzi/ECZurhWVPn+qV6RRWxRg1FXxXQBp+X2STQ
         aRPoqzm/2RXOKxlXmKyeBUpVRdm3NmB/Dt5wDMCXdEt1Zw+qIb2hNsfs9IYF64vzB1Oi
         RSmMCfqqMzW7YuaXRoum/0ekindsVsYzKiJyTfO5XN4EpiNF7V+eN52Fd2JIEm+3KT4d
         aodDh6dwXJfBgGZifCrk+R4Ma79FFZdNiy6xybieeenbtH76q3ZhbBIZf4jfSnH+P2x5
         DsJA==
X-Forwarded-Encrypted: i=1; AFNElJ8YIQg07W3oZLv+ef4S5SlzQEM8Qxoeu0V3ovQ0a+xRI8/UofO0N+yEwXHcZ2Qu+R2+mAxBKfu+XAmJi+hvfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1+5iWLrMagb3BZ3hD/RZQZk9BUBZTRrlsoTsWehVU3AdMD4k+
	ImtObl0pXRS5rFDc+qEP25NphOQFKmnhnw5q+JxBYayE1xwVt1lGj9PnJrZukbFg2Dgzw08KptP
	fL5Jtg+OMkLeJkOXgPBcll0H9hJfst/UZcQEGsIzRHOugg14X9mOd++v+WNiX9g2C3ieR
X-Gm-Gg: Acq92OHvMc+eOxKpU88Bvy//XJcZPktV1OSZoyTPZl5mSKiHxWSMUG/W75/JSrm5UIW
	XB+ZLnSNfWGHm6wH1UeJq4doMwMLX0j2qN59kCK2GvqZNRvZ9LTXO3fS6DWY91bmw4/dHKfwlki
	ayarEdVla25r0kO0L1Ihl2+VXL2db56/HT8jCt56XfEOOHCsCHondfEfhQNKZAo4gsggmSFOncd
	LPDwyk2BldrpYWhEv7+QXJpabZR2lw2lwIuvoqLYA608A/7iLZYKRXV6wU4agGQ/eB1v+YS9afB
	LLSc4xC3vVrDTxSZrVtrgI+p01JhJ4q+sFViDtWldJbgOeXusuP8GuuUhPNOxun7DBCob68AmTj
	8tajOs/Ft6xVF37NCW9Z0qsBUUOXCc5mCR+Zt7+WS
X-Received: by 2002:a05:600c:3f1b:b0:48a:6fd4:d3d4 with SMTP id 5b1f17b1804b1-48fc9a50d32mr5862735e9.29.1778619971813;
        Tue, 12 May 2026 14:06:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3f1b:b0:48a:6fd4:d3d4 with SMTP id 5b1f17b1804b1-48fc9a50d32mr5862425e9.29.1778619971141;
        Tue, 12 May 2026 14:06:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c221sm36066581f8f.13.2026.05.12.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:10 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:04 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: [PATCH v7 11/31] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <7d637bcac4bb5705388136a75f0fdfe2881e5f20.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: eWK45Ggmw2tfufuDuEb3EL_eZJ6VpWni3MrY61R4LWk_1778619972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that the generic vma_alloc_zeroed_movable_folio() uses
__GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
x86 that did the same thing are redundant.  Remove them.

arm64 is not affected: it has a real function override that
handles MTE tag zeroing, not just __GFP_ZERO.

Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/alpha/include/asm/page.h   | 3 ---
 arch/m68k/include/asm/page_no.h | 3 ---
 arch/s390/include/asm/page.h    | 3 ---
 arch/x86/include/asm/page.h     | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 59d01f9b77f6..4327029cd660 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -12,9 +12,6 @@
 
 extern void clear_page(void *page);
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 extern void copy_page(void * _to, void * _from);
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index d2532bc407ef..f511b763a235 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -12,9 +12,6 @@ extern unsigned long memory_end;
 
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #define __pa(vaddr)		((unsigned long)(vaddr))
 #define __va(paddr)		((void *)((unsigned long)(paddr)))
 
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 56da819a79e6..e995d2a413f9 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -67,9 +67,6 @@ static inline void copy_page(void *to, void *from)
 
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #ifdef CONFIG_STRICT_MM_TYPECHECKS
 #define STRICT_MM_TYPECHECKS
 #endif
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 416dc88e35c1..92fa975b46f3 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -28,9 +28,6 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 	copy_page(to, from);
 }
 
-#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
-	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr)
-
 #ifndef __pa
 #define __pa(x)		__phys_addr((unsigned long)(x))
 #endif
-- 
MST

