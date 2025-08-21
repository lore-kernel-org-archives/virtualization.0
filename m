Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0835CEC0
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806878; cv=none; b=ZO8/ESnRDtaarcoI2Fkk4/Pb3oZIpRvVHjY4K2pmgkYeL/wJ1N/qwed0AO1uBZnHFQD7CUBPGHC2k+1XcZlr0Ur+ZykD7R2CFzQMNVb1XnxNtnLFrh0+YGQHr///nUxRZWikLBJDt/ReChgcNN8k1Jc1nhluOPg29WEQaaM2jHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806878; c=relaxed/simple;
	bh=DqyVXDGsUgZb9r/3HwvxxZbRj3b/8OImyDb3ud4Q1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=t4jUBufHx7sfWpEZmTv/GAPjNZGG1QxrkXBagl2HSUyf4YShxl8sDPKJR9WUCtxkTod3SQR8QdIgYaf5l0/X0nc/MWGlJrwfpw/lDZsT+j0bUOfcNu3W1ltt/uh9cBkoWCCavBWVQzf1Mh6ZPA17XrSqnRwQ40S9zzwRMLHLtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw13t9nD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw13t9nD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
	b=gw13t9nDpGG3U2GGHMcx/2sRRR9KRkg1799gYSbpZQy4XI+pCFyIp7adDzu0khQO8BlEpD
	lsze6by2yDpulNWR+PJFam3a3xB1nScMtY6y+/YUHGdU/1aG7lVsqZTdUdI9gZXt0cQ3+e
	lab+ur2ji94m2LOBF2zm59gUmk9HE54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-9rmbY0zQNHmino1plX6Pkg-1; Thu, 21 Aug 2025 16:07:52 -0400
X-MC-Unique: 9rmbY0zQNHmino1plX6Pkg-1
X-Mimecast-MFC-AGG-ID: 9rmbY0zQNHmino1plX6Pkg_1755806872
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso10738645e9.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806872; x=1756411672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
        b=PoiUfbAtPckxPAmKGM7t64wiz/r9+JDh4+eo6YOjkiaey2MMBC201TJ4hLiVPGxRCV
         IHENor7Mb9/KmjeHF8nlpEBAbBrOB1SdUGOelf/Xa7fay270d/toeVm/KiDlT7TwNvpa
         iSjNVoCy7oAuWLthzT7O9sikTHDGQVDHkKj6QpOWyeoN3pF930l5xdeJUvBbbY6lSDgq
         bOw1WMbsq2nVuHuhRozR8UNMldRhJgkjUuMe9ALQM5qYwH2sgFlvBc2VfeBkydWbEgbZ
         z0KuxD33FW1oGo1AfroNczbRjhX83NUeX1reWNiQqlFmhgCgbRmID66mHQD9OJevIURC
         iRIA==
X-Forwarded-Encrypted: i=1; AJvYcCXtcTt8NmbAWys8Tx2iLwLh8bKabGcsgo3ddEIuf3QVJmwbCg1unDiq/GtbJ3V9x/oGyKmU60/OkzqXoP396A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYzYKua0b/HOG8rL6Wo1NZP4XyXsXXnUpwIel4MjIdCat/y4ZB
	5/I2nQvEe8Lov9cXMqdWNQU8R2/6NpUZAyFS4O7soK2htVKDzej7okXSe/1rihCT7V7lZ+luWGP
	yPiHpbNuIKzIBf8LrkowMX3tq4n9sanFCiNbsLjfOouLPwfhNxalaw4XboUVC0U/thJ/Y
X-Gm-Gg: ASbGncuZPm9+H0r4lAIErEYxDSQ5ZwEYrsDeo0Zg4q+8mIeDlwBYA6bcaisaXQzpzBT
	gWye2OQR53HqXzwkiLKsgzEDx7A+Xjev6x8xmEhc7E3GbCQ2UyNro5FrhbCpHFo3gI5hV3GOxca
	d6I1Ygl8N9Qahnv5bU20No75B44gOAzdcaQTIxz/tpw4CLxDrSWR++LLWU1XfRbC957uCY7tetC
	YGzfzkUne+QxWW180+SlqJpkiHjUJ60t9hZL9FIhi+XnnuBgl89bYwX8uL/fJyj2MQXlePymsff
	bKjTxILQOeOpRzKP5sZHcwFasQZr00lv7ig/d6f+lKu5ss1KEbv9vPlsDGvksTdYMFhjGBGAEh+
	C554uMpAZRFTdd3C6Tt4PfA==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2278795e9.10.1755806871567;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQe1GSIQC6LfutgynQLrqB1o4Jo0GTrBjlhxRWjM7nqTD8l8oEo1HOcPxtIuVQVn3tsHm8QA==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2278575e9.10.1755806871147;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e1d77e0sm22159155e9.0.2025.08.21.13.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:50 -0700 (PDT)
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
Subject: [PATCH RFC 16/35] mm/pagewalk: drop nth_page() usage within folio in folio_walk_start()
Date: Thu, 21 Aug 2025 22:06:42 +0200
Message-ID: <20250821200701.1329277-17-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 53uKmj0E3wRW4jNmgQbyZn_fOfxbIufmRRGDdWzo5xA_1755806872
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer required to use nth_page() within a folio, so let's just
drop the nth_page() in folio_walk_start().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c6753d370ff4e..9e4225e5fcf5c 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -1004,7 +1004,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 found:
 	if (expose_page)
 		/* Note: Offset from the mapped page, not the folio start. */
-		fw->page = nth_page(page, (addr & (entry_size - 1)) >> PAGE_SHIFT);
+		fw->page = page + ((addr & (entry_size - 1)) >> PAGE_SHIFT);
 	else
 		fw->page = NULL;
 	fw->ptl = ptl;
-- 
2.50.1

