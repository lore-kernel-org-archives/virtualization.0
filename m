Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978D3C4576
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490158; cv=none; b=SQeeey2Pb1SJvKX5X/lAc5KZK/37aaxT2scpqJANBgurprxrQtxXg7PgVZeE1jy+WFPG095CYAhVqx0vU+hnQMEML2Pu0sTPqow4caWuNkpOKDvM3DhtRhEumQah1xaQUF7zy6BKfsNoDV1g9fEzkmQjxt+/QuXdKQQQZNT47dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490158; c=relaxed/simple;
	bh=xVZpENOTPSkcCw9H72WToBvwV1ZsJAWZkigdtcUbLLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FgB/VAF/lOMwu7FfLUDYmAQRVoKkKAW/WpX/zqG6lq61gg3LbB4Jg9WE13yr1IsAB9N0j4/Zjm9i0Vd3E2Gfm4Nkv3IzCbMYxsWDFqIYKtY4bvL0Dq/8ZJwfa3heNdrw9JL3PpBl+HiSOGEUKdF1H/KRRV3BsWeeFc0T7EkcZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhUUdbXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhUUdbXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
	b=LhUUdbXU5rLV8LcGjKMJ7r6KcdK7v0VpU8kl2gujOLfEBw1QcpFZdU6JKHVXp4MytvGz30
	+y5eg9IbWLKL9LXyBi6mjJwCJ6W1WtJLqPjv/iGnJ12xGqKZgn2ppJxahTHKMc6w/iweU7
	iGCkJvSUZhFRT6AySbmuZVbnoaDdzwE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Q3hOoEZDO_mcYStcRTEZTQ-1; Mon, 11 May 2026 05:02:34 -0400
X-MC-Unique: Q3hOoEZDO_mcYStcRTEZTQ-1
X-Mimecast-MFC-AGG-ID: Q3hOoEZDO_mcYStcRTEZTQ_1778490154
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso34020855e9.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490153; x=1779094953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4kzhpMcne9QL/iUfytpcOnuwyhDfw3DKjMmXnNjefM=;
        b=GnGDNfDGPYBaQgHrMzXz1CoRk7jkqujM9o2PLeV63iWNl6sM/me58S0817Bxnx+7fJ
         I9jzmv43FsodTn9IhPIV/VaVaAZWFfpNsX4EcaTaat2jBHpm3cyE5SfzhOBcbY4ssKFe
         iBKmwUb8WfgoUmnVrOXU2HtEtec7bz7AJzT1qxQg5D1vIc3Kt28VqFFGcbjnVvgoJiMc
         Yn3B4e3Hm7JYRpJQxmA7ZVXPhFi524u9DejnE74idZX9GOjQE2TZ4wv+N6CSz7owbOKc
         K4i+tTEjqAWeyydQRXpUQHlTM0GxhPX28XyHbcoRwL954OZ20quWQBaL3p0Kg1ERrpna
         58IQ==
X-Forwarded-Encrypted: i=1; AFNElJ+B9WSlufAaOUgKG4S84R9tz5caVp9U/HM4r9Ty74G4LMfl4LNMJyOHRVLSYv/hQLnDU8PUkEPUECKC69vgRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoxpzCnH26TwqMRHySpMoR+tpHTMhAWFDZtFqdCMMwBZHFwi+g
	XT5LUuCMdlpKwck/q7e8b3nmWmgaxnpc7WGYZajPYN9kHYHgizdveOmgKC2UyiF+9n+n/eKCMGm
	TuQ4P1uUbhP55jJDGC87H3nHYmVAHuscog5liwzh8++Ahw+Dkv9jK7OVc1SdT8K17tC9v
X-Gm-Gg: Acq92OF6DT4FtDxEKjOTQfN9T1jYhSq1sjo5/FWbKqO6k7EXKpWWmjAmLqzbU66sNRn
	sOtdZMqKX53fqVrab8wn3p+I1jdvOIwmTzKG+k3IT29+KTU5Yu3Z2w5sG2V4AB8irn3mEUc7dsd
	ff57HWgJT/hR/VBhh/GjMPZs9fUJcX+CleY2LScylaLIuLphoTobQ0XLYIkmyPKhP6IWGUtmlE9
	3+6t9jHk/wuaOi2X/WwnWz0tktD2Otc+zB8fjiburBNWHtQq8IltPGicXwPjw5S21RC7GBrslh+
	XfdPDyLUYBxiM7owj9G83BSGCy0KY44VbOH61PMPbMM8N8dFo0nRQ+x75GqzutApLxJ3bU/j0UI
	1dokOSVaKhOXbPbynGpCsIy+7UFXgsKXabajmBF8q
X-Received: by 2002:a05:600c:1d18:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-48e51f46e46mr365112645e9.20.1778490153248;
        Mon, 11 May 2026 02:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1d18:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-48e51f46e46mr365111235e9.20.1778490152468;
        Mon, 11 May 2026 02:02:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7040a9a9sm297049045e9.9.2026.05.11.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:32 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:25 -0400
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
Subject: [PATCH resend v6 08/30] mm: remove arch
 vma_alloc_zeroed_movable_folio overrides
Message-ID: <24a1b25f4f1cf31fc5bc053e475958ed5e1bf8bd.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HISom9gTYFUPG2NvxSgf39dt9Hy5eyeWW8X_VNut5AI_1778490154
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

