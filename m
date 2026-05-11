Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410FD3C9EF3
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489697; cv=none; b=SkhUeFsrHgOJcP9WvqIH4xd/RqPr2tV/GP0Xfwz9u7DxnHjaUQkMU0y+/ifXDWD89X3MUFIvmdTJAmn9YU3yE7clwiaGo1nyK5gE5PI4cEPOIOdHFRX4oRsjYUnv1WLVcXZEgfK7Fxk7NauE0qqlO7WvQBReX+xFvJQzjxl3dQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489697; c=relaxed/simple;
	bh=xVZpENOTPSkcCw9H72WToBvwV1ZsJAWZkigdtcUbLLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GRiKjS9gLbB2jc/cf/kBldvrjvHb/wM4AxKm/3iUogv6991e6RiAMnY+OCI7WS6n6mDp8Bgyo1ziV98oHMWCrKrSmcZgqmg+VheuTMUVfB+6TMt/dMe+oeKwMy5HyrmtNk7K9+JJ2Ac0RJhTML+2bKrTJbvVxuU7LjwJZBxQFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2es8Z0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2es8Z0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
	b=M2es8Z0fR81f9xl6NPaBs2Q70yl5V0+AF0gQpDBziSXf/vpy62fI5iYDsS+HhoU4WbNLjS
	PSKeMrVsXPIzLdeJ9vsVhbqk9clXKgDeYhOmslwysHM+qm/iDyjEMtq3OEs7GF2mQuhHEf
	OPUD0Jl2QnwSnWEsoh1fAY56L/XYjR4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-xRCHakqWO4KfhI6WkTSNqg-1; Mon, 11 May 2026 04:54:53 -0400
X-MC-Unique: xRCHakqWO4KfhI6WkTSNqg-1
X-Mimecast-MFC-AGG-ID: xRCHakqWO4KfhI6WkTSNqg_1778489692
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso28715395e9.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489692; x=1779094492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
        b=hO39zcVl36vfqBUV/FXmyKA45Sjqp+TwICUe6RXK9RS4784cTM4tWlTuC1haaOjXPl
         Mf6rNJlfhELjxrHuXuORXMn3T/V/l0oPLwtHa8clDJdd7lUVZclwJSsCRtZFy9rdkd1C
         Q1QzyJw9HR7PaAq1Ol9Q6P1OHfRivoyvLsNzNwW5AiKBF+ulFK8Ys/BAYRE4V0uaypzH
         RJRSn+mLCvqSsi7/VJlZXFZcBEyLvheOcFAyj3OOAB1JBxdDchpxYy4UTA6U4MyaAGOZ
         VqI+WaBPBTdvs8DZnYrIxu3P5cANL8fa49Mkt7KGLDhsynMw35qj4slhJTfuFgbLZHkc
         xJGw==
X-Forwarded-Encrypted: i=1; AFNElJ87MHzCO0Wv/0zgJZlEaz/TTssVJN+4Iho3o/CMw67efP/xW4jfWyf630inIWitk4MMC4pwNk0WnrRVfDzVXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt9gQFHZDYGIAB+1DiAtFBNUXWHjPOfo2sWLQD0eVy8W0WD1jk
	+jqL3n0uFGmKKgka7lXDmKlJQvrWmo2pKtaTz+VczS3V0I5+QO8l7fBpqLSWFIsvCVGcN7i+l80
	cBsr84s/BT+d3tinJdBUaml5m0gCM0yaz6asiEfIYx2U0k/9Gi7Rhap4O0IfAUp6MRRKQ
X-Gm-Gg: Acq92OFziGIaooDDgrbSZTSCPz5nVzuSF17dG/9EqDjFkW6jyoY2C2FuSR4s3MZefhe
	BOK23K6tHUB6hGPiOVfzMWjAvUsbGyHq8Ge0sDC6Ie/51QwRr5ZHtw8TRUd1Bfo3hO2ehoQvyOt
	y69Q/uvAFlBy7gGl1+THkQOldo0YEAe1LF+eQBQ15ESFpQsDQZ0VsOz54RHJf7nuYgPYRUp+09D
	oatitMi2dlhPYDNVCPLNbcoV/2zRZ2VAdJ3iEtIxaweHIOJ87Wj6mD7PhxbmegPpg3fI0wUPPun
	CidjfdPJ7B738lfPDy+mkHP5cl7noNf9d4JFU2r39gVeZlTvnvEocoyNiBFwvoPih3VHCDiTyuj
	wqaN8WCot3myGvtrpKhUAkw0x8/38Pb7O0864UDsS
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48e635a1ba0mr253243555e9.0.1778489692261;
        Mon, 11 May 2026 01:54:52 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48e635a1ba0mr253242975e9.0.1778489691662;
        Mon, 11 May 2026 01:54:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454919c13c9sm23822939f8f.27.2026.05.11.01.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:51 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:44 -0400
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
Subject: [PATCH v6 15/30] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <64e3432a5982607dc886f5943f556f54c0612e3e.1778487000.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OWZo3CoyGqotRYhhP7_057LT-RccsNU5MYNr5R2qivQ_1778489692
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

