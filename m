Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F03C1978
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619966; cv=none; b=kVoEKJCadN7HjY4TaYJoeOdiaVST5bqDyNYzhFWmfTgJsCOUNBxSnAfmR1mNVEAX4ff8tSpQgKCaD/eVnC9mH5r4Rn61zAOH+Hoirywa6c9KEyNxC1QFndGODkguP6tN962c0wMkDU7MGC+542oi/YJ6Nw7o2/nK/DuQTNOKt0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619966; c=relaxed/simple;
	bh=26OEPP7shIS2Aqo5H6bSRXYq6BtKNsY+s1121au6t2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tO1yEYUsQTcravhf5cXvDeICceyUJxLtwD/jmR8nEpJiHSSAVq9asFGl9QK3rbMKRM8iaPR3ol/39ALam0fkGIvPoNGS4Jg0VVdla3LOvG9f6BpaKUnr0MDAjZGcGsOm64MY5N/GdSUdmnaT5XesxeVXzNhp00XD2osDknJcV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iawc+57+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iawc+57+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHWjppoupYJq6gg1bmhomqZmsJDzmE/Zol9ZNgufzks=;
	b=Iawc+57+DYEdCXz1h5Pev4LpAkqTMCF/ceSrx3dK8a0+eGbT3UIqvzrRMrBrtksMdYVvi3
	6C/HkcFCmOOhmHkFN3X0eAnGK9T53YYi0wTK4/EzMF/XZkiarm9eG1XDm3Zd2HxvfXPyIC
	vrEZ27Kg7QpofgodxNRloG3uyHiRfxE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-MhMc2cENMEOn3tg8oI-j8A-1; Tue, 12 May 2026 17:06:01 -0400
X-MC-Unique: MhMc2cENMEOn3tg8oI-j8A-1
X-Mimecast-MFC-AGG-ID: MhMc2cENMEOn3tg8oI-j8A_1778619960
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fb4ffebe7so2905305e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619960; x=1779224760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHWjppoupYJq6gg1bmhomqZmsJDzmE/Zol9ZNgufzks=;
        b=oRbXhuwQF+I8CObwo9y4AmiDj2qrf79PBAFy8R/Rf2FrwnIbRGaZyo63dpyFGpdti+
         fFOK+ee7qh//k1Q0p1vLlIRl3eYWqy88CEFVhucivZmXlEKOWocuML6sjVLdeD0M8Dd5
         APsZVkhPnZBRQ9CwV6Y1v/odiDRgPKckaGIVh/8jqYTx7yDnKNxaHPFocl3Gjjr9lLQC
         iGZEywWtr+qnJaJ3A1i5lEIDKi6Xs6efQqG+2AXzmiCrzA5VgpcYj/cdtXKNuWURQ5EQ
         oh7UZIFOYl/7MwQbxurUkZk5yHHRCzkIbrbXJonfJ0TSWgmoHFeyBsgatgZea9TizqnV
         sWYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qohF2iQuK/Pl/8M2S60iBfh5if8hFUNylYJOxGiLonBjmiakohffQ+xdvBEi8k4s9Uoqt6kd/FnlV8oGr2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc3mq/qOkLUiLLem+dXPTTzy/JtNyo09M7qjKt3kKn/OPXwM0e
	G9kMTF+MSm1SF11H4DDvqkDTz9N0o0EZ10RRXWlWiVPrmNIJjtNA4jOj7qOjPItBmPIrN8y4URv
	s3rcYw3/s6AXC0n6PZQmEOEGglVrO2zrQs9rfpRXvRlNjqh/hgFFm1awP/qy/2WOEkNcD
X-Gm-Gg: Acq92OHhG0nJNHyI8P6hZnpezNRSPdXSEKSNZWIrnr8AESO0wP76txVz6Vzz9tzPekX
	Z8WU2aHh/dLJP6m7WKNuRvt5pW3RXnmflITmO4sVb+ugWZYC6sSuKIJNbR4OOP2U6eGwPH+mrml
	VwGsgIob0klf+Srz+2ZpFPgpWF0lU80ZcAndlgYsTdijuT185J6VG5EFCT2Gqq8iNfOG2809x7E
	v58qqQG+8+cdOdYMtJhySrhlOE5V5MKXNJas/9Y/cpRj3G6D0v2UlMWZmReDbdkVlfmjLRszdM7
	VfKU/R64ZZRwPDwXgmKVUVUSS3ElwR/wfcbNkmPCRjpoLV0RhfCwurblHydUb3K6YMdH4IoE7Ch
	gI8yMkOOdfd8oI/n22M+HZhoE35NJHK1uFqMfk2TB
X-Received: by 2002:a05:600c:19ce:b0:48e:7f1c:8778 with SMTP id 5b1f17b1804b1-48fc9a34577mr5572005e9.17.1778619959996;
        Tue, 12 May 2026 14:05:59 -0700 (PDT)
X-Received: by 2002:a05:600c:19ce:b0:48e:7f1c:8778 with SMTP id 5b1f17b1804b1-48fc9a34577mr5571635e9.17.1778619959429;
        Tue, 12 May 2026 14:05:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fcdf63f05sm95345e9.1.2026.05.12.14.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:59 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:54 -0400
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
Subject: [PATCH v7 09/31] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <45d1ea85b574399459a64fdba28fcf04abfa3e7e.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: CuzQoDsNt8EdbZgbTbVXTzTw7RHXr9csi6jMqtI1Aik_1778619960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When post_alloc_hook() needs to zero a page for an explicit
__GFP_ZERO allocation for a user page (user_addr is set), use folio_zero_user()
instead of kernel_init_pages().  This zeros near the faulting
address last, keeping those cachelines hot for the impending
user access.

folio_zero_user() is only used for explicit __GFP_ZERO, not for
init_on_alloc.  On architectures with virtually-indexed caches
(e.g., ARM), clear_user_highpage() performs per-line cache
operations; using it for init_on_alloc would add overhead that
kernel_init_pages() avoids (the page fault path flushes the
cache at PTE installation time regardless).

No functional change yet: current callers do not pass __GFP_ZERO
for user pages (they zero at the callsite instead).  Subsequent
patches will convert them.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index db387dd6b813..76f39dd026ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1861,9 +1861,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, initialize it now. */
-	if (init)
-		kernel_init_pages(page, 1 << order);
+	/*
+	 * If memory is still not initialized, initialize it now.
+	 * When __GFP_ZERO was explicitly requested and user_addr is set,
+	 * use folio_zero_user() which zeros near the faulting address
+	 * last, keeping those cachelines hot.  For init_on_alloc, use
+	 * kernel_init_pages() to avoid unnecessary cache flush overhead
+	 * on architectures with virtually-indexed caches.
+	 */
+	if (init) {
+		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE)
+			folio_zero_user(page_folio(page), user_addr);
+		else
+			kernel_init_pages(page, 1 << order);
+	}
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
MST

