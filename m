Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28612741D3
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221355; cv=none; b=GOVrRVXeuYk4gEvjtuNK07AgVZzZ6ex3RIvPeKxNNq8dc0XPNlEFQgWSOb07gm8qecJzfD/WafRO2sErE7Wy73lF8pshKkdsYJMzJb5vmfFAklh55atHu3cPBFghdudQmKlE0K3uU41zvMDRDmGlomfGolrAcqtI8Cdb/H4VdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221355; c=relaxed/simple;
	bh=SBuojYrrqpBFDrlTNShywACmIJ60kDXWt/jACPJjCY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZSyX5OTnJedhglPjIdXTz/N36bojWTbGkSJ1q2Zk92Z9NIUQzA8XLZtNA3SE4C7wCEcQ2bdN/y6Ro8mBPNyb3CxVact7YQDmhW6Zp9nNeQ6Rf8MmfFlNgISgNH5IMRKFlT5r3Xai2Nj9YchSz2OVyiTClZIWPoQ8YrtDTKd/qXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pdm6cp5Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pdm6cp5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747221352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USAeB9Dgua5+aC4n7BcswguTapqG/rE90mePm5URn3E=;
	b=Pdm6cp5Qsp0IMm20sSf150IzIbzwmdqaZQmOXieGW8pMJ7uaDFDsFRgz8aM22plMNbgdfZ
	tQ36bwogwo9GkPmrbgEF63L7sSvZLts8CzqepgEhlBwquGNqdC/BRjerebCDSCvRfIDwND
	OluvmcGnrxTAvCSmQQumA6co7h3GGzo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-6CYH6bB2OMCM2MGQP0GzRA-1; Wed, 14 May 2025 07:15:51 -0400
X-MC-Unique: 6CYH6bB2OMCM2MGQP0GzRA-1
X-Mimecast-MFC-AGG-ID: 6CYH6bB2OMCM2MGQP0GzRA_1747221350
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a1fa8742a8so1938591f8f.3
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 04:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747221350; x=1747826150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USAeB9Dgua5+aC4n7BcswguTapqG/rE90mePm5URn3E=;
        b=C3UD8DJSeUjD6xcSFG5rMIPm0KZUZyeiWwplLDY5TkKvQR5QrZ7FC3+DjzEirxweRQ
         nUCFAYveCChMlirlbLV2kxGqHgipPfbtfuvKBoJ0Vgs770vlgxngt+S3L0MYJ2dFiw3M
         RnHCtf9vIFGKPKfIX9ITkj3C78UXF1tY3JTs4LykzRMk1lTO1YSa0LRzScR+0aGLvW4O
         Bc4/BzzxtiFt3rOipD6Jg9ubiCUyF5VddUcHr3pzF/Z5m+Bu9zYsKq0xkarJCBmbSFP3
         aesxUrdGX2gXcHOlAHXhw050qYcG2EQu9hmX6BjqQmoRlRI5e7FfM25Sn2uIllaP4D49
         LcEg==
X-Forwarded-Encrypted: i=1; AJvYcCVE89R8qW7ZI3qKQB3d10cPPuy5BIHeMQ9IFqV3OnWD6W7bjZAUYXrJt2Kb7+p54kzMW/eo19y44cpozL/mpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7fTNATXxsAVwUBs8+r0qQQqh1LBLjlHxDEqlHxw40VxLsO4fJ
	W27JOjt28CxbsTlpBpbDjRr1ixUWOXrjf9vXH25XZwJdBfVCFZnEAmh8Rl87aefXD5yrRlRrGCR
	v9Xji/fT1JO1VMO1DPm+h3qfoTzShMD838RboXil5dVTx/79NM94YW+nvew8l1jnhV5QU8WPXIh
	Y=
X-Gm-Gg: ASbGncsRCG0S9rmWeKPmvWXlfznO7F91DyxeDFV1szWgKAPpmS5QR6Z1snKKYfFhLk+
	Uj0wkOefg/8pXThBx5nRSbLpkb15RThEK/3bWlXmpbQT2jhOBUs8zv2FPfi/hfwDaOo6GoFHpQ9
	mXQgBe/DCIRF1DyTKFpHGz0iNO9Tal+kPpb7YdGD6g+W/rn68F7PGOtEnTAQvlKlNOyRLD2rEp0
	PMpKFl62vhsJZAYLfeLexzE4oho2cHtz5xwSae+5tCZIegYQM8LDkxiQ332NuHOC/+Cy29QgHXT
	lDpRgxZvZfzWYSWtfl7+S1Wy3pHmFc4Evuuxc0nC42QxiLOrglOjWnsXpKq13p2xnOGduSIg
X-Received: by 2002:a05:6000:2a6:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a34969ad59mr2825485f8f.1.1747221350282;
        Wed, 14 May 2025 04:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7IAF/NSDrxcSU/xvaJlGrQphfZd4k82Xl6a3TRsBzfALbvBwKjpxgERH4dcJ+8qF6KaRktA==
X-Received: by 2002:a05:6000:2a6:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a34969ad59mr2825466f8f.1.1747221349944;
        Wed, 14 May 2025 04:15:49 -0700 (PDT)
Received: from localhost (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f58f3369sm19586020f8f.57.2025.05.14.04.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 04:15:49 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v1 2/2] mm/memory_hotplug: remove -EBUSY handling from scan_movable_pages()
Date: Wed, 14 May 2025 13:15:44 +0200
Message-ID: <20250514111544.1012399-3-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514111544.1012399-1-david@redhat.com>
References: <20250514111544.1012399-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RADPtFpYRQdyuBiWRL3CeGj3DW86FRuIMq-9ur_qHbU_1747221350
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that we can reliably identify PageOffline() pages that allow for
memory offlining in has_unmovable_pages(), start_isolate_page_range()
will fail on PageOffline() pages that would prevent memory offlining, and
we no longer have to detect them in scan_movable_pages() anymore.

Note that the previous mechanism relied on MEM_GOING_OFFLINE, whereby we
were not able to distinguish the types of PageOffline() before
MEM_GOING_OFFLINE.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0cc5537f234bb..beace5b695aee 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1743,13 +1743,11 @@ bool mhp_range_allowed(u64 start, u64 size, bool need_mapping)
 /*
  * Scan pfn range [start,end) to find movable/migratable pages (LRU pages,
  * non-lru movable pages and hugepages). Will skip over most unmovable
- * pages (esp., pages that can be skipped when offlining), but bail out on
- * definitely unmovable pages.
+ * pages (esp., pages that can be skipped when offlining).
  *
  * Returns:
  *	0 in case a movable page is found and movable_pfn was updated.
  *	-ENOENT in case no movable page was found.
- *	-EBUSY in case a definitely unmovable page was found.
  */
 static int scan_movable_pages(unsigned long start, unsigned long end,
 			      unsigned long *movable_pfn)
@@ -1766,13 +1764,6 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (__PageMovable(page))
 			goto found;
 
-		/*
-		 * PageOffline() pages that are neither "movable" nor
-		 * "skippable" prevent memory offlining.
-		 */
-		if (PageOffline(page) && !PageOfflineSkippable(page))
-			return -EBUSY;
-
 		if (!PageHuge(page))
 			continue;
 		folio = page_folio(page);
@@ -2051,11 +2042,6 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			}
 		} while (!ret);
 
-		if (ret != -ENOENT) {
-			reason = "unmovable page";
-			goto failed_removal_isolated;
-		}
-
 		/*
 		 * Dissolve free hugetlb folios in the memory block before doing
 		 * offlining actually in order to make hugetlbfs's object
-- 
2.49.0

