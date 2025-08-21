Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB436C08C
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806894; cv=none; b=MpybWnij5abkhCJMZ2OeRLYwkExzBsHUkGpxj695T+irFqQbZCMECaTTxeT/1v5e+cLQLIgxPoZvDlQlxshgvfmDx+QPz155/sbVxa5b0j8vgYXkO6m9atqjhYSM0cjAQBoqSdfNqh0J/HdUh8DQyr6EqnQp7PsNZR9jPVwYaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806894; c=relaxed/simple;
	bh=35i5s1BcLEONuxohRPeqiFHOreLIpfTF289+ZIXZu/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GAklfgK2z1z+IrEBrJcSWWK02/gi/YGiSz6YV2mBd0LxESFMeH1Z1e5B4ZEhf3nTXAM2n6VJj7aPmIHxm0eEout2edvK+G/texOmPxHY5G3h4MfuazsYt2b8Qa84BVcW7I1TJgqmoS/5swGDAAUdm3KKu2TwKG2xSF3NmFGEoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAuI4ObQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAuI4ObQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pq6EMCEhMXNA7HGNe/O1qYHWHhWZrBzRdRZ7YmKumJw=;
	b=LAuI4ObQ8SK/1nK29SQ4IEJeO17n4p53HUvNerNItBLRh4TlQsyAA9PyGpyeoH4NcTxHAC
	K9wlfm/6fKZWSTr5BDOHiWmzKPrxGtCJGsVIzgrSK99KJpkRgbq1zSw17F/AJhaUnXB3gq
	wsmylcATFHCNgNF9PJ5A09LoNOxU+2g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-JQDfDmHFPb-bY1fPNuDX2w-1; Thu, 21 Aug 2025 16:08:10 -0400
X-MC-Unique: JQDfDmHFPb-bY1fPNuDX2w-1
X-Mimecast-MFC-AGG-ID: JQDfDmHFPb-bY1fPNuDX2w_1755806889
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc5c2820so445385f8f.1
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806889; x=1756411689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq6EMCEhMXNA7HGNe/O1qYHWHhWZrBzRdRZ7YmKumJw=;
        b=EYMm8PCIRCDVEShvA7rdiKMbDvpWWcLXPXgMCIn20VxzGcLY309eG5L4NpFbghG8xD
         NHLMDHQWuUt2kjzLotecQ1JcRlLrPQTXGxYIZ7Pry2+O74KAk4Z7deMmx0qDvLK0sqI0
         lyWDfHMTRg5JpZtuc1KdrlDCh6yHC9Je58LxQrUUiebRJqfAbY/wt0fvblx+jL4R6wUk
         DzMWWekBNCcnUpWVlqPgKVOirQsRWCorG74gnPCqJrRaifq/XL57GrVeLyiTbu9zZrSc
         2YrLgWlqSzzokFr2RnA0Dre69Q9QepGEwytpaXrV9HsyP64oYypdgw8iqdV0aCD5PNMD
         6CPg==
X-Forwarded-Encrypted: i=1; AJvYcCXTYb7NLHoNZ5UAxfXXADnP7me/jMUXPwYMmLW8WXsrQqR4lOND6jJ5EFIZxHSX3I5PmZLwXR1+/kfM5MtHQA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/19xDcDTMrW6gM/zNNbvxfbPJqYHCBejxZ5VqwpCP1Lq17eE4
	4ktNys+Edz9XBFVtTxyks6QPRJTbHf73vDrj4hh4KRS6R8GcOPnjfcILTa1V5iryj0fF09nbtwo
	lceSzV84GmNMdE7hAJwgfXTH1ktbQ5PT23g59WVXct/fsDe1p9fQt/DQWC/2zhK3AlOQU
X-Gm-Gg: ASbGncsxFOCQqANUcXvxld57FOFmmlz9Q0Mh42Ore0fk1gvfKKpVjNmMbfPCrH6UNfp
	9R1jtIDvRp83fXxlHraDjF1xcPWiNcmXUsgGSQFCE/WYkuA21j7j3lIzzDK+cqfThz3CnSnpFiM
	poIE2s66Mdu44ImTW3hjlAmpLKn5qeukXVbnykwg/wcydliwtxI3Jwevd4NSo0URTJqT6HxHnys
	SP10blTQWnefzoIuqCV19kc8r9icZ/pOn5IE5p1so4mDrkrVpBzaw284DmODHg1OvK3u9BRbyzu
	hJb62d7m1WD4XC/RuRLe27aDEYRL/eY47uZMqzid3ouSF9Fwn52I49KEQOr+NG4UplkjnCu3Ney
	K5mte/4tDH2n0T0CMEatBlw==
X-Received: by 2002:a05:6000:40c9:b0:3b7:911c:83f with SMTP id ffacd0b85a97d-3c5da83bf5bmr151966f8f.9.1755806888904;
        Thu, 21 Aug 2025 13:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeHEkncn914iQLB6IDJFbFllUgyuseH1VcCPvg+Bdgchh7CcvmYDhAXktPsYS0hqHcr6hQuQ==
X-Received: by 2002:a05:6000:40c9:b0:3b7:911c:83f with SMTP id ffacd0b85a97d-3c5da83bf5bmr151916f8f.9.1755806888456;
        Thu, 21 Aug 2025 13:08:08 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e2790a8sm21120815e9.1.2025.08.21.13.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:07 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
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
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 22/35] dma-remap: drop nth_page() in dma_common_contiguous_remap()
Date: Thu, 21 Aug 2025 22:06:48 +0200
Message-ID: <20250821200701.1329277-23-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 8wsM678w7H-HRsuHEpNvFWJL3N4oFPPxaXizlj3FHz0_1755806889
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

dma_common_contiguous_remap() is used to remap an "allocated contiguous
region". Within a single allocation, there is no need to use nth_page()
anymore.

Neither the buddy, nor hugetlb, nor CMA will hand out problematic page
ranges.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/dma/remap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 9e2afad1c6152..b7c1c0c92d0c8 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -49,7 +49,7 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	if (!pages)
 		return NULL;
 	for (i = 0; i < count; i++)
-		pages[i] = nth_page(page, i);
+		pages[i] = page++;
 	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
 	kvfree(pages);
 
-- 
2.50.1

