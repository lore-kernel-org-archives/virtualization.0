Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD134DCF2
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806862; cv=none; b=DXOQLW0GdivKwJNBbeIgTs/ABo5wSF+3oYysj+Zue/3YrkQ3mJFNfzaa4zfTsdSQMXs+bid/VlunpQtDYh5a05Uv8Tbl3gJTM0E4sHvGGkW3x36VEY/fkWzlKpR/Le7NgOWe+OSI/6bYnzVD0B0YONU5s30r8uTYPlKx9g+nhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806862; c=relaxed/simple;
	bh=I7luCT+CObepmsBOKpah/UXsbrY2375DH2pptgGLgo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ILVkrH+L9/x0d5T2WjdCPb7Wwnzd5XMUFpgMj/Cd9gsOUUG+mafwJ5O1Fth2uLK10ACWElxkTintz60RhmoTAoshdTWry65nyYxFxzunzjv9HbidIHVObSyjblSASS+P4NZRweE4qkAS2QG2be3JtlTi+kYoqdynpG8wwkQn+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJZSkesp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJZSkesp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
	b=EJZSkespebd3Ng1wWtOdkfdSPye9EEPGo4H0PF1vXJgEZMMVVFNBXjTOTAbgdUiwftjCUq
	xAAH8gxRKorQ7EjhOnuNR+pLJhcYUD6NsjoUfiJ8NXSOlMQSutdzZnpGBtOA6fgIVEyh2j
	KNJVtNdI/x1+v2guO1xaeqFJsSUE9UE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-VRO7Q0dAOniOeu3EtqkBUA-1; Thu, 21 Aug 2025 16:07:36 -0400
X-MC-Unique: VRO7Q0dAOniOeu3EtqkBUA-1
X-Mimecast-MFC-AGG-ID: VRO7Q0dAOniOeu3EtqkBUA_1755806855
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9e418a883so795579f8f.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806855; x=1756411655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXj+9vT03G0X8fnCGUCy6hSTWwnZnWm2sdD6cJzGZDI=;
        b=WOU0R7Xw/iNLRJJgWy8DTfvnQXc6ohOYKA2Uey1IVxPTU6S6DS+Y0bMg77zKzcTNct
         e1WUir5hFiGr6MnMq5Jwl5/Z5F90XX2eMkUh3rSD0T9DDHaL19BYdI80N3iZd1hMcgOV
         C/zZ8K998hC5emv7xjK0OYXIO0QlQim/veZaw6JbThVA6cqKxcSp7UszvIemsvhucaeq
         tdIhkfDoIICahmTuRVCjIPD9iHSbgaUCpv9q5TnqgFDyZAi99h+b3wRLsUZMHW/GX0dw
         otlXHFfn+BOUwhtvFJL8Ni+hKIWjknsoqlClEvCmOGGMU7U17djEbfEnhLptZ/eO2g/X
         tE7A==
X-Forwarded-Encrypted: i=1; AJvYcCWufWWDe4vn6iGAJ88ABsAUasf/W+ikS7pQUHBN+7OeIEyTmi9xLUMJim8DwNcg8jJIOrIJ2WwzUvF6/RK5iA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxI0PQTlEudil0dqTNVeRuXMA0GAiDCQImlOwVd5fuw688CMuJW
	4iiuBHOxXsxJ8H7Hgo8jJDpOylZQfoRVbCn6mwRXqBjA6v0NhbwOIlaGpAo2RcWjwniKfzhtfJ/
	Fmlh1JkswP3zPAgeuTazDkJdADbamYWbb3EuZ706wsNhQhE12nNFCi2Pi0qzjutSPrSyF
X-Gm-Gg: ASbGncuhA9eSx5qZC3rmLpKmaHJN3FqJrPNVIJ5kOmcDeLvhNAimUpxWfOkyfkK3x/K
	QvPKJY04eGhXhTt7+gregXUmvwnPcoZummxJQGZB9SX8+zuSfUy7Uq9see7Qd8BLYff9F+BS2z1
	6GVYP/N19+xogNwkalCSEp+NyFAG42RvDiiTo/jAQ/C0RFlW+MzbLUpg5cwfCrZmZ4+aHPMJ3RN
	29r4tw9ODPEow7lAUNCu8xLqdQOtqt7L4LR2e1Sm6/as2FZ7GlhbIO/22/TmJ3rAW7EvGSp5KS/
	TzXo9vcd+Zx6qTDeCZyMyzV4+xYJnE3qhAh7+uZSDnaFxL2vXLqe4jU+7p7tduxsN1QyZYa8tdj
	DIHoHDB7RfsjFMuaMdZVf8w==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169067f8f.47.1755806855264;
        Thu, 21 Aug 2025 13:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbzCbSL6MUAhNqtGz96KSex+k6XoYEx77XRmSFhqyAAErvnD4a434thNrJcfmyX2YJjFDsxQ==
X-Received: by 2002:a05:6000:2303:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3c5ddd7f36emr169035f8f.47.1755806854709;
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077788b39sm12802789f8f.47.2025.08.21.13.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:34 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 10/35] mm/hugetlb: cleanup hugetlb_folio_init_tail_vmemmap()
Date: Thu, 21 Aug 2025 22:06:36 +0200
Message-ID: <20250821200701.1329277-11-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IPuh84AozdrXoVRaLowBYHhzxamk7DEKh7WZ-HlbwEw_1755806855
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

All pages were already initialized and set to PageReserved() with a
refcount of 1 by MM init code.

In fact, by using __init_single_page(), we will be setting the refcount to
1 just to freeze it again immediately afterwards.

So drop the __init_single_page() and use __ClearPageReserved() instead.
Adjust the comments to highlight that we are dealing with an open-coded
prep_compound_page() variant.

Further, as we can now safely iterate over all pages in a folio, let's
avoid the page-pfn dance and just iterate the pages directly.

Note that the current code was likely problematic, but we never ran into
it: prep_compound_tail() would have been called with an offset that might
exceed a memory section, and prep_compound_tail() would have simply
added that offset to the page pointer -- which would not have done the
right thing on sparsemem without vmemmap.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d12a9d5146af4..ae82a845b14ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3235,17 +3235,14 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 					unsigned long start_page_number,
 					unsigned long end_page_number)
 {
-	enum zone_type zone = zone_idx(folio_zone(folio));
-	int nid = folio_nid(folio);
-	unsigned long head_pfn = folio_pfn(folio);
-	unsigned long pfn, end_pfn = head_pfn + end_page_number;
+	struct page *head_page = folio_page(folio, 0);
+	struct page *page = folio_page(folio, start_page_number);
+	unsigned long i;
 	int ret;
 
-	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
-		struct page *page = pfn_to_page(pfn);
-
-		__init_single_page(page, pfn, zone, nid);
-		prep_compound_tail((struct page *)folio, pfn - head_pfn);
+	for (i = start_page_number; i < end_page_number; i++, page++) {
+		__ClearPageReserved(page);
+		prep_compound_tail(head_page, i);
 		ret = page_ref_freeze(page, 1);
 		VM_BUG_ON(!ret);
 	}
@@ -3257,12 +3254,14 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 {
 	int ret;
 
-	/* Prepare folio head */
+	/*
+	 * This is an open-coded prep_compound_page() whereby we avoid
+	 * walking pages twice by preparing+freezing them in the same go.
+	 */
 	__folio_clear_reserved(folio);
 	__folio_set_head(folio);
 	ret = folio_ref_freeze(folio, 1);
 	VM_BUG_ON(!ret);
-	/* Initialize the necessary tail struct pages */
 	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
-- 
2.50.1

