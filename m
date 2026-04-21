Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E938422F
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808913; cv=none; b=pL/IxV20MZdes7YS8F/PvzfUn8XC+O2M6c5jVmXtK/pi3nRG6hZ8v/KrInbfdyX7nfk+i2n4EYYSLbJ4siGVixMM4cPHf8E/LH4ucYHTskBub1PHRCEZc1k/d1DVfmMK3UypCuHx9aHiyBP99zN8NRxBvlXQYR4uh2JMcu9rlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808913; c=relaxed/simple;
	bh=xyYx6EKfSNYgy8umDBVjFDGC9ANxj/5Tbt7GkFR38jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VDbV4W1022aoyNnGD43BhD2oQROuPkb/qpcq5EgszEGOT2KcItoyPkRtb0sZLssKbjak1TS6uqsB+Y5msatoTQTBGEsdwn/Gbh+AFFFzHzfmgr5RjOy6IBGlnwjXBVbz7vSX7pvFlwKVFVy9ALE7iGHdVTD00SN3+nZ7PwbQC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Ku1jm7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3Ku1jm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JVwG8S2po1iduREwk8io7PMDE8wG9YqvUAWHOi+D4qs=;
	b=T3Ku1jm733ofpBp4NFCYlA7i+sj69T7vm948aMKzIgVWKE19VZbZLcPzkpCOq7ZEZTqkCk
	FmGRTwtbid+xyNunPg9WXAhw1JyaPBDcHFzsvFnXCyJd5Jn4WwbieAg3ykVahIYkKz+9gu
	nplNJoI+1mGjOv1V71IS639F8qvMlg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-TPwcXCnaP0a5qttDgwyIGw-1; Tue, 21 Apr 2026 18:01:48 -0400
X-MC-Unique: TPwcXCnaP0a5qttDgwyIGw-1
X-Mimecast-MFC-AGG-ID: TPwcXCnaP0a5qttDgwyIGw_1776808907
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4891f2eecb7so16045745e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808907; x=1777413707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVwG8S2po1iduREwk8io7PMDE8wG9YqvUAWHOi+D4qs=;
        b=ZK9yV/PUZsl9zbAPwW8echhbTEgWVg/Hacr2sm1a6LAIE8D7WDgJvRiuvRppTnFJAO
         ksmOgo5JInZlvdn3AH88mpSbWQXuPrFu/6xE62YeoGi9nXBD4Rhgf/dfoZ8KqRpw9B2K
         5wOGh72GpsDEEq6tuaNwg4hOHDBaBIEObRP3vQQiNPO5JrOqQ4OurZbk5Zly1xxnJ1rC
         XdKBBiz9UheZgs6X4zcUugbXHNzuivWkA9aRQYq0K35BEQk9zL571WetPVHdl2dF21XY
         XPNSooPofqYpGv7YvnIrj2uOFYYH+g+foDn+EUOC8A/++2lqGmBnyk/cAxY8RZ1Un0jz
         LGQg==
X-Forwarded-Encrypted: i=1; AFNElJ+JJzpa15fxiNikr1a/RlytlNNIZX7p6kDrnR2QWRGNE6CZnaUCOqmyT8ZxzJZV6nJGkWj5QWlM26A0GTM4bA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI3d8lzkkSdyB98h/5JPkE2p6VUbNmKBZpObHlAu0HBny3jfYU
	kakbT11O5O3TRxGRvN6vQ47frYL6cA6NeD5ZI8Q2yEY/4SFRuD8hxpG6/C1YNhp6VAXXATaHh3v
	ZsDJWGC/jaximj6KlHeedgVqQA8EDgmK0WQ+IhrbJTEGMOPYp0/W5WhZySVIYDuL1qEmrlMFZWv
	/C
X-Gm-Gg: AeBDiev8PdxS6H4+jBOETIY5aKywg1OmjwBI+IyBlyM4+1DBc6R/7/dr3vmjVs1wxcM
	yZIV+9ZfRG0jwyrIOEjbQMp7iJJQzICXciw58wSeYPzKoGr7rM4dKg7BTPhsp2ZhTG4mVVNWaSA
	29HOJ64dgqvqk+H8GTcB5sQjjyXcGzi6kDpbwEr913YcpdH1QLtdjOG24dAM0Ogu0OUdHral8us
	UUTZK9Wai5mS4IqCevczz+GBld80RyT4CFyrT3s1kY1rmPDwomDS+h1h/JEXc1YL1WFAEhEdIUh
	gXBEWBhj8N7suL060KD3QvaTh08tlmSD6lCNmszc7uZRP4XX7JCNRA8KRCekiTGDvuMN0pjN7Io
	GUtdWkY8dFLQHKrLcghxY6MXei3UR5o0tFQubR6BBRM975pY3m0OaQQ==
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr57315905e9.7.1776808906894;
        Tue, 21 Apr 2026 15:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr57315565e9.7.1776808906442;
        Tue, 21 Apr 2026 15:01:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8193sm361473545e9.1.2026.04.21.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:45 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: [PATCH RFC v3 10/19] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QprsyEKeFhEQK5T7LTPJoHfqyvHVzJWMRsZioX9avqI_1776808907
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that the generic vma_alloc_zeroed_movable_folio() uses
__GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
x86 that did the same thing are redundant.  Remove them.

arm64 is not affected: it has a real function override that
handles MTE tag zeroing, not just __GFP_ZERO.

Suggested-by: David Hildenbrand <david@kernel.org>
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
index f339258135f7..04020a19a5cf 100644
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

