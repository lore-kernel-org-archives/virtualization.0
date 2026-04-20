Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301B2EC54A
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689437; cv=none; b=kF/a7sua9iHEFJ2jbEllj6Jtgwe3Dms2Mz3TUp1kmIsVKjdXhR8yqKX7716nm4KC4h+JKv5ctK1d8t+2MT1p1MFCe1xmA+uUJeCOGJa7oshgPTmmajmrz7htGJ6xOstCqv05fDw8Lm2W7NCe2DBh4NV3QD7/gUn3eW08hUPxADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689437; c=relaxed/simple;
	bh=pSp+om6wJRkEyaJKuodIN3r3I4NOe1erDIwSwnd9xvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DuuQME1zWr/ZmvAbKRJ6go9crfQI/Hap7p3HXDbk8TgiNl9FZHBB8ZvcfoPqsm+FQpeEOuG0VUsWyfClqIQy75dl97nJdLpTSG8nBr3+ilzvF9DN3Mz5Bb+sVMOPB/B8gfmT5B/dfIpAWVjjDcBJwNEIAmK3WDWUdFe9O0RC03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVz319NX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVz319NX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lC9qQY7bzQ6V7tm8vX9AgtgL5Xqe3kB5rW8A2PJPlKk=;
	b=eVz319NXYDRBPFUlmkUYbRhsw4iE7gE31ojYvKNI18Q2ylWSUeNsyYXPadB7e9XAkgBrp3
	X8o2tEA9ZNSv0fxiWz9yBrr3Xw4RbdxP6GcNarwMfGmoooZA3L1pYIlPujhqoFEYAU57Rp
	d3qiTH97p1dFHW2Gl/aZQgEEF5eGXPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-deXoeNR3MkaxcwzNzOP3sQ-1; Mon, 20 Apr 2026 08:50:33 -0400
X-MC-Unique: deXoeNR3MkaxcwzNzOP3sQ-1
X-Mimecast-MFC-AGG-ID: deXoeNR3MkaxcwzNzOP3sQ_1776689431
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a529bc0so572116f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689431; x=1777294231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lC9qQY7bzQ6V7tm8vX9AgtgL5Xqe3kB5rW8A2PJPlKk=;
        b=e9sGO07IduZWZHFVicZJAEq0rvf+4hYCZzEBYO0qmFFvy9YsUUuMZR/ryqI7qYg20G
         LilDG8jFDnvBJ0FlupHX1ekLEhNpuqWA2sNkV40kHIIAfXjyG23lf8uCUxmn+YASgxIh
         2PFv+GLeun2FULRC7PzOcBJOn9CPWWuKkSshu+6TLPDY3b3h31o0A62O2CNTz7uEWE08
         NU5b/jQwUrUeob0wpyOAn/bv2GyFr8w5GNnF9ThtS1upkWaZy68Ke03vTIt60ii6oJ5h
         CRpbSJdJYTC/MwnPRF9bhfhEedX642S7Dd90ZcdnHi9kjSGjRIr4arhNu/JT0wRnNU0q
         itjg==
X-Forwarded-Encrypted: i=1; AFNElJ/89yQGQX+wRQ1La+PZstgav+C6DwqN3iGgMBJfBLtCGwPoqqU0kA5kfXqmgEq1/7zo3nbvy/lu87J9+Wd6Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoquMxZVcOqWHtIDA8WJih+nwXAQzBbHB/dg+jcP2cfDm+J3GZ
	bxIlrwx/ZN7tDIYVsBLoF/IrITPCUj9sylEfscFMtabwc+23HuL0UTQNe1XAwyj2/AprNTIIaBF
	yqshjgJLu3oG95VFYOTUmGmZN28pIZ/KRAIHRkar4+tJBuYEUwTai7asWfyvoF8Ibeebe
X-Gm-Gg: AeBDieuDoWTsT8QZoj/pKCiajFgtq4PiIwjeCA5omwxd0iMVGiTMWVyrF/TPd2crTXc
	pl3iu7Zkhh20kqqOH+LgSFVK3OhCYm1ZyLDEca8wimP6Vc4u+lN2dEgk0tOuti35bClPvpmvH+Y
	7Rj37WJz42N874mZOO5oENo+F5kvnFk9ciyh1msKtPQJ3re+mNfroTwIkxRiqyv02z+WqyNdD60
	WkGZIyLXLOtutb6fMFTJ5wYuaiDjeRKLtxGO5JlUVmC4SukZ7AAJxwsXHv05upYMPbiRM2dQ2p2
	Dka5ecl4eZAwJNKQAgIscmwyjmGau2Xm0dAoHbPS5Tqmp71Q+8wMlSEY8emWBDk67LthbbpIz7J
	Tlp8KCo7jBm4ySTmvoTga1I7EY90+WcEO2gPMzCqIb2RtLJxrE+ApIQ==
X-Received: by 2002:a05:6000:2c0b:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-43fe3dfbff5mr21175536f8f.31.1776689430924;
        Mon, 20 Apr 2026 05:50:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0b:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-43fe3dfbff5mr21175410f8f.31.1776689429964;
        Mon, 20 Apr 2026 05:50:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm29092510f8f.8.2026.04.20.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:29 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v2 03/18] mm: add PG_zeroed page flag for known-zero pages
Message-ID: <48c5f902f03a72e4337979f5193c64017675f72e.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ADzN2bSMpG3N2lOytlhca2OHoGPCRUBvMWj4yU6FksY_1776689431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add PG_zeroed (aliased to PG_private) to track pages whose contents
are known to be zero.  Exclude __PG_ZEROED from PAGE_FLAGS_CHECK_AT_PREP
so the allocator does not BUG when encountering zeroed pages on the
free list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/page-flags.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f7a0e4af0c73..f87ecb740e7f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -157,6 +157,9 @@ enum pageflags {
 	 */
 	PG_fscache = PG_private_2,	/* page backed by cache */
 
+	/* Page contents are known to be zero (host-zeroed or balloon) */
+	PG_zeroed = PG_private,
+
 	/* XEN */
 	/* Pinned in Xen as a read-only pagetable page. */
 	PG_pinned = PG_owner_priv_1,
@@ -687,6 +690,14 @@ FOLIO_FLAG_FALSE(idle)
  */
 __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 
+/*
+ * PageZeroed() tracks pages whose contents are known to be zero.
+ * Set on free-list pages by the balloon driver or page reporting.
+ * The allocator uses this to skip redundant zeroing.
+ */
+__PAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
+#define __PG_ZEROED (1UL << PG_zeroed)
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 PAGEFLAG(VmemmapSelfHosted, vmemmap_self_hosted, PF_ANY)
 #else
@@ -1209,7 +1220,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	((PAGEFLAGS_MASK & ~__PG_HWPOISON) | LRU_GEN_MASK | LRU_REFS_MASK)
+	((PAGEFLAGS_MASK & ~(__PG_HWPOISON | __PG_ZEROED)) | LRU_GEN_MASK | LRU_REFS_MASK)
 
 /*
  * Flags stored in the second page of a compound page.  They may overlap
-- 
MST

