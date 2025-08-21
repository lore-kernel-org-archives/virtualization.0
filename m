Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941936CC83
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806895; cv=none; b=LG8ThaUeTVlWZhk8f1iEhivOo6zJAkgfwZZqRvUiBhaF+qGuOzqcZJN8j6ZR82O5lMmsgn6RzO++vDGMZz9FskhkA4kzWSO/YJVE8sxqRXXLJozywGumoJ3YJ5lya16KoHDJKMO0SWnrQ+rniJn531a6eInwdWKiwVFc3JGyg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806895; c=relaxed/simple;
	bh=E88hXeAEs+yXdxHqIfTWo/GvQIeDr+kkFObDidynu1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=L6ya0psEIwnLwDGE+AgSqxiLy33bWmVbjpT0ihc0nNYf3yOzryf4v0XtjypPEDezRFQ+JlRomFGd7AvdrGTDVPgp7TEvRAD1GXleqH0pbuNFbIX0EesiVqmj+4OfegjzyfXdqOMbcfy++VQQpdF8D+IoX+N+4F+ob33RNtJ4+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZZrBTX7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZZrBTX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
	b=AZZrBTX74LUfQNgI6VN5FH0upXd947jF3khJRR+aGiI8rVhx9pbbhKsyFDZrB2pXiEx2va
	FwSH3bE598vZqJHV485tWX8waoIV50nk9P0BOsTs5VvwzBNq2ZClfdH7fdW+6PH1OZ3CiK
	MoWubimhWuXYvDvYh560zqDhl4mkAc8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-rpyz_5TrOlmfrsaHPTS3Bw-1; Thu, 21 Aug 2025 16:08:01 -0400
X-MC-Unique: rpyz_5TrOlmfrsaHPTS3Bw-1
X-Mimecast-MFC-AGG-ID: rpyz_5TrOlmfrsaHPTS3Bw_1755806880
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so14273785e9.0
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806880; x=1756411680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
        b=QMFeEP07ruSsNkYdzhaoAfAS3hgLU9Uvm2IIUBNBXZiMXl3YwZlg0kvvGaOe5YBw0V
         g0Dwm04eeERNthGqrpb4YjhSWjf7N3KRkYw1zWquJscRHv6etQZNvsA+aHD+26g3Wffg
         UJ6HQUfxgkKjb9hfguJ851+/70Em3ZT52PzlCtSckoJMkGSbsZQ1tefFbVQfwvzEDjmL
         6kOVSbzhiNpuyWcvd1VVbIdULHblt8D4lkNP3QXZoAgQ+ELwRSQ+MWm8gfmU4bSspJVF
         VXXzqbWqpd8EH8cUFq8oO8jaNBc6xJ8K5h3+0EX+WCWKA8PjYhd5blvJl5aPxLEeK/uO
         Qn5w==
X-Forwarded-Encrypted: i=1; AJvYcCXZzPKebQCk28Mu+UPegprwtZeAAHjWFvjt5M6AFz2jIb9gMmWrx2hpO6xWXiuxzZXTZS5VX9NftwjrJjIU4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzscswmbU1N86ZAF19c/ByhUWqVKs5duzdnfsZAyKJZsez9sbIp
	80kd5DTY5ePvtcxwJhl8ONDtWuG6Rhei0Hlr1VMrFIiyHkjSdZqZgonS32TerEryvXy95ws1pxH
	1caPVoaQPZn38n2qV8ujTVaj7eZph4OGYMkvnsj17ttlszh/a4fHG1mzTG2Wu1isbeCzp
X-Gm-Gg: ASbGnctCVeDOSlj80uSYZw+jVRsFEodfmCD8I+d3CJ4VCGdgrUBg5+cxipY2S3HUoMW
	JNNdcEPu9+RzqOMJNH0p8dIiTuhMM+Y/i4Kxeg48lGouUWhQa0MBBxpl9wrPY+ocUF8OPlNaVaM
	j6EoMaAKl/KiF86oWh/7dGlYmy8XVqzott9s5N/dW5hB2C+vyxdwQG/Mzvt/z5D2j9nfSaLmXJY
	MGaqk4+5yeR5LRVHEMDdDc1jcdQyeS6jwB4T6A+uy8xy18+Bqha3/6BzpE4TqEys5nXZtnDI6Uk
	b8Jf39QNRxOFpKEzfxBWUOXez6KI/Nu4E9wA/YKJMsycZxp1Q2tnQaWRx+TgFseFZpIJN1FqhiK
	SPtqyg6d5TnqD4wi8h//yUw==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328695e9.11.1755806880047;
        Thu, 21 Aug 2025 13:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ciI0WdoI3CxhUtu7m/cESVsdReJmvmXFWCMaWsO+hhXySreox2GeOL2sJ8kVyLPwCYhbEA==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328365e9.11.1755806879543;
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07778939bsm12219075f8f.46.2025.08.21.13.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH RFC 19/35] io_uring/zcrx: remove nth_page() usage within folio
Date: Thu, 21 Aug 2025 22:06:45 +0200
Message-ID: <20250821200701.1329277-20-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: eSniEjnMVM_WwFwVqCfNQvb_jWs_LR-nKsPIYf6lGaw_1755806880
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Within a folio/compound page, nth_page() is no longer required.
Given that we call folio_test_partial_kmap()+kmap_local_page(), the code
would already be problematic if the src_pages would span multiple folios.

So let's just assume that all src pages belong to a single
folio/compound page and can be iterated ordinarily.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f29b2a4867516..107b2a1b31c1c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -966,7 +966,7 @@ static ssize_t io_copy_page(struct page *dst_page, struct page *src_page,
 		size_t n = len;
 
 		if (folio_test_partial_kmap(page_folio(src_page))) {
-			src_page = nth_page(src_page, src_offset / PAGE_SIZE);
+			src_page += src_offset / PAGE_SIZE;
 			src_offset = offset_in_page(src_offset);
 			n = min(PAGE_SIZE - src_offset, PAGE_SIZE - dst_offset);
 			n = min(n, len);
-- 
2.50.1

