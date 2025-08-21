Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE738101A
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806932; cv=none; b=pvFhWFQPpAZ0QOYP282/O5DwaKKE9ylNPtEtWASjC95RCk1UsE6GJyN1Gm9fnYEH0dC7kxqGazRfw5FueBq2yx8YH1eKhRTSHFh7YPuJZ2mNI1A+XWhrBP00k7rbczClzSEovv7YbgKrWdtoDLwZrTppBQCBeBDGlmOLQ+vRf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806932; c=relaxed/simple;
	bh=vBZZGz0SB0V7Hvywd1N29mvuGT2dBN/lU5Bb9Xz8Q6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tJe1LBvrxUMqUn9164DL1NhA2VEbJLAmzX/8CBTwehVstxaniZ5YczCUGxkmqsnBWCwcqckRZGRC90mpmVTpZa0O4VIfLTH9Y3d8DRDuuxqU/+0le3CAHAwTjyc+VKkgvbWiVK6g8X1Lg6iEEzRgn4C1GCcBtlZDddR2G0i2+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpG3JzYu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpG3JzYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
	b=TpG3JzYuAjBYMJ5+ct28GBi15cEo7gGwWnlGBUSoHf3pG4Kl2S4KRJgSEKo7sB+UcxuGuj
	Qf3EBrrb5TcpdOL55+/EAMVqxCq8I5kMagJv7IMXY7aSU0x/Nwls6eJJo7gcwomOIxLPwb
	0vu0As35iMV73ivyE8lGftaRSpLo0Yk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601--eS9IaTGOKi3qrXgvgZ3Qg-1; Thu, 21 Aug 2025 16:08:47 -0400
X-MC-Unique: -eS9IaTGOKi3qrXgvgZ3Qg-1
X-Mimecast-MFC-AGG-ID: -eS9IaTGOKi3qrXgvgZ3Qg_1755806926
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0bd6a9so6980105e9.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806926; x=1756411726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
        b=RY5Og7oNah2vMpn2Xs8ZQ/YzS2M+A3hQdT9pw4Y7/buLOv3scGpWemSibSSCaogGM8
         pJbcvHPtYzhiaQshUNoNrjYgL1BJPXmUlaF91iTnQpIqmQj3Er/5ykQT0A74A09shgFY
         bMyQ/Iv8WDLfNTcoANfafGaPaRxEIgxBb9ejqp4OkcUQfl1dRlIBvCQLYTPqjlTJZij7
         lQCDmlHQ9eSkzL4vFMcQSyOoO2+9YvtoV8CXIHaTrb+vd4U9Az30z9g33/ZM5P+9q191
         4hvq2dm5jpoSRix3lF9NtDKwUwokWNv1yljAg2Mk1u83BcqqJJ1iFqHBynCGPrm4QvH6
         KaVA==
X-Forwarded-Encrypted: i=1; AJvYcCVwX4zZdKoR+uFCICR1MqqRIwc1JBkCOa3NlU5YlbggcOEaQ8KtE7ZUQ5qN8wa5kUWBw7qE1mWqjpMRZVQGPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwROpE4d/z8SxbUQwznT+YyyY/dZXFoTSGwAQwbLDj19S58DtmZ
	zPyIJDq3avxFT82xWO/uTlVK7OSEQpkxUU7SvVfDvFtz5JOgXmjTm38bV4MIn8VQ8AqTqHu+/FY
	DIgA5AIPeGScejzDPOCQVV3dNnGnmR1yeHjN8YVhN4cQwKBHad73PdFI1SWXtqbgx3gE0
X-Gm-Gg: ASbGncuIl4moD1/fdJkvX0g7uNhpimjrxw7jgdHHdV9/nuwBo2N2omd6V3uPYuMxvrO
	prjkOfrA/naHKvf7dEJ9u0lTclsrGi8HXktN+pg+d7Weh/FGoTvY0ZMmyxxTX7t9aCp8G4cViII
	EnR7JIBSRhbxB2Z1v5sxKawGA5qgCWABTtjTs1nHyGgYc7WaQpXYcsnuCL7stzpgnhSopdMsHNl
	pLk8PK2M9v1Wi0AFmoSchDgd3RQTrxsYqmywoKN49Dup+xt7ggJpLn0YhaDaF0bUWXNaHC54u4e
	ICuMCg8fNSp/RB9z50vmkTXvpBBBsP4ApOgj72gS+Yo0yktBsPgGkQGdFIT5kdwqUBEDoDGdUQk
	ha4G8wbz4cITVOxtojmp2Ew==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774605e9.16.1755806925550;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDDv+I9AWZPVyKVFD2prHDmQqsK3mzEWwP5yNf0oRJXtHjmqgi3hMC3hwAmszm5rTAtK85Rg==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774035e9.16.1755806925116;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e0a479sm8895255e9.21.2025.08.21.13.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:44 -0700 (PDT)
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
Subject: [PATCH RFC 35/35] mm: remove nth_page()
Date: Thu, 21 Aug 2025 22:07:01 +0200
Message-ID: <20250821200701.1329277-36-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: khq0-FKrsaZaQSwW-LYNUyaMaOJ0p5Bnc_UDy9tVzWA_1755806926
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that all users are gone, let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h                   | 2 --
 tools/testing/scatterlist/linux/mm.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f59ad1f9fc792..3ded0db8322f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -210,9 +210,7 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 bool page_range_contiguous(const struct page *page, unsigned long nr_pages);
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #else
-#define nth_page(page,n) ((page) + (n))
 static inline bool page_range_contiguous(const struct page *page,
 		unsigned long nr_pages)
 {
diff --git a/tools/testing/scatterlist/linux/mm.h b/tools/testing/scatterlist/linux/mm.h
index 5bd9e6e806254..121ae78d6e885 100644
--- a/tools/testing/scatterlist/linux/mm.h
+++ b/tools/testing/scatterlist/linux/mm.h
@@ -51,7 +51,6 @@ static inline unsigned long page_to_phys(struct page *page)
 
 #define page_to_pfn(page) ((unsigned long)(page) / PAGE_SIZE)
 #define pfn_to_page(pfn) (void *)((pfn) * PAGE_SIZE)
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 #define __min(t1, t2, min1, min2, x, y) ({              \
 	t1 min1 = (x);                                  \
-- 
2.50.1

