Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8837E91A
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806923; cv=none; b=SHxhj2MLdThTLw8CEdcQOkafDuCWOaNO5m+AngkZ4I5b/YsDsLng6+yjzfPvf7IBr9NX9ITv8qNdwxFd484lMoVSSv3dgiMl4jZYYBpSKy6oahT+VfmQSzS1HuOzGK+OYn20RcAZAK/m73R5YJqLST67UuFPWP0vPp7c+M934D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806923; c=relaxed/simple;
	bh=tCsSQl+WRq69JZRVPLbubBOBHgSgQIUjNop92vdLyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=h4oIkXx+lfJ9proLeqHUeebDXdHm84O8yWWvxLXLnqCOoHUoR3+yhMGnIdGGAEFmnNA8GgGOQoWrQaTbJhXGHaMPdfuGP2OcFWZxjnGLdDv3fqiaUzkWrz79L1cACLbKwXUpAZ9dl7kdsguELO+EUinIK9bFN+Ko2MGS5LcMlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOD49HRF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOD49HRF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK69Pd9CHZjKZhmlaft7kkJNdToX7IH/S9WvVIRScQg=;
	b=fOD49HRFKqBx+Jh+YkATToKV9bMInucg7AS0hzHpNKARRp1dprl6+iaqjuE27C/lFKIN6W
	dmqPhLKblNQy1oZ5uTWhnn1afLrnKSRxlIaV/6hNuVFw4Q3qkFR1TKK+XMEsQS1s8l22rO
	gWSSaO3J2B4md5pg/bQzbWez8iOVZjY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-oEWkCQ47NVGFhABqou6WsA-1; Thu, 21 Aug 2025 16:08:39 -0400
X-MC-Unique: oEWkCQ47NVGFhABqou6WsA-1
X-Mimecast-MFC-AGG-ID: oEWkCQ47NVGFhABqou6WsA_1755806918
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9e4f039ecso760159f8f.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806918; x=1756411718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK69Pd9CHZjKZhmlaft7kkJNdToX7IH/S9WvVIRScQg=;
        b=MrTbTMvUjnVqlfMYMXyIYZn2189gn/3qGmw8+sWTTZJJsIX9JCJQpRkH8qFI94API1
         barb1ukKEBTqHi8QUkVp5QPxoNH4/kRTkN2auQI0EvVjQNpJsr3tFJPnHKAzF2Iqa1VP
         vCuY9f/x6aF73jeuX5nYbheUesaa7MHG79aoDwXQSGLgopeux1aEpFwG3rOAfFDPuA2X
         LOePt1uN6gd8IdlIgi4eSdBREAwgSf1bQoqVT8ryeqo2xDsgTMWab3I54f8T1r3Zq1r8
         QmNG5ZVjEtG5g2RllztBq/ONZD4+ykAstU2APtIyCzm0oQ18pxpMr04jHjkIovOFsqSa
         Pt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVixriNfaRwcrSlqejmwZzSR2zowx6WIWboncSfcfQIOHgG1xJMS57psalWk9JsOiTDDCrY5B7MB8CTSbVIeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsD//vDW8X5FrlStfh+G7uSm+46Z7fR1PBsrQuQs/JQgMF8Bkd
	Y5Jh1bN0JioCbYxKFLhTyo0zyIV7ThiXkVSWMkykIEixMEjoaiDf56swPcMbSwLqK8n+tpYYNHm
	1b5Qy5xK+jfNE399l6/1hb8LuBc9eWdcofjppCCNyU7bgiJj+7KLV9T/Rcpim3Wtci4Xr
X-Gm-Gg: ASbGncud/vL/VacAmw8D36UsK+6CUcve+ODZv8Z87YmsZ3gy3uTchEUZFCYFuOLgeVf
	Bn+Z850atBYcu5Xtf17/h1qHQP0iXmRmC42XIAaryQgBOW4KWDatxZteLtuq2e/2BrqHTA2mylW
	VHxs4Ikc0PkQ9Lh991vbEtZlFnk/Ar32gc8WOrBiLsdaZYB/WbSbhXKoIOUoii7xb8OAt/v3IWn
	rYIkDqdY+IHj++GirWNS0/JYfhCWajxwEkjDvasA0LJ1ssRXBu6pMTflM8Z/vUHbMIvu5QOqVvU
	n2B7+xIuhNZwprIytI52Rtqds3gZp6jx5dRInISW88LXkqKoHDHqcTeFJteQojwp+7dbFoaRCRD
	tR4RoHcaFLhWHYnObdFcdGg==
X-Received: by 2002:a5d:64e9:0:b0:3b8:d7c7:62d7 with SMTP id ffacd0b85a97d-3c5daefc298mr218328f8f.16.1755806917863;
        Thu, 21 Aug 2025 13:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETBfJ8klmP3LMs+G3FmlUfLKA9Qlb/rzelQ5gyETYamNwKefh2PCq6Da3p1XS4Ia+K1NPGrw==
X-Received: by 2002:a5d:64e9:0:b0:3b8:d7c7:62d7 with SMTP id ffacd0b85a97d-3c5daefc298mr218279f8f.16.1755806917364;
        Thu, 21 Aug 2025 13:08:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c4ccbf04fasm3355197f8f.7.2025.08.21.13.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:36 -0700 (PDT)
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
Subject: [PATCH RFC 32/35] mm/gup: drop nth_page() usage in unpin_user_page_range_dirty_lock()
Date: Thu, 21 Aug 2025 22:06:58 +0200
Message-ID: <20250821200701.1329277-33-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Hq6Gry_G7ISiKUo_ORyCy4vz-GFPQiuXAGgn0qtB1Zg_1755806918
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

There is the concern that unpin_user_page_range_dirty_lock() might do
some weird merging of PFN ranges -- either now or in the future -- such
that PFN range is contiguous but the page range might not be.

Let's sanity-check for that and drop the nth_page() usage.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f017ff6d7d61a..0a669a766204b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -237,7 +237,7 @@ void folio_add_pin(struct folio *folio)
 static inline struct folio *gup_folio_range_next(struct page *start,
 		unsigned long npages, unsigned long i, unsigned int *ntails)
 {
-	struct page *next = nth_page(start, i);
+	struct page *next = start + i;
 	struct folio *folio = page_folio(next);
 	unsigned int nr = 1;
 
@@ -342,6 +342,9 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
  * "gup-pinned page range" refers to a range of pages that has had one of the
  * pin_user_pages() variants called on that page.
  *
+ * The page range must be truly contiguous: the page range corresponds
+ * to a contiguous PFN range and all pages can be iterated naturally.
+ *
  * For the page ranges defined by [page .. page+npages], make that range (or
  * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
  * page range was previously listed as clean.
@@ -359,6 +362,8 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 	struct folio *folio;
 	unsigned int nr;
 
+	VM_WARN_ON_ONCE(!page_range_contiguous(page, npages));
+
 	for (i = 0; i < npages; i += nr) {
 		folio = gup_folio_range_next(page, npages, i, &nr);
 		if (make_dirty && !folio_test_dirty(folio)) {
-- 
2.50.1

