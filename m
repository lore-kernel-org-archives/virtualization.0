Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AB303816
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268490; cv=none; b=RASNjggj/SFqSzgOvWDm2McfSvjnDbovavj8jXKSZk6HplG8hgikLnrdjstbXydeqNQcx4GyWR4b1tHVeWqv68M6uXzJtxnVa4VKmQzOI7VKohwreMnEsZ2SW56VrCM2cFTRAl+cVYHo7sjHQOjPtgwJgLvJLU96O5dfbDQWQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268490; c=relaxed/simple;
	bh=klS5wctUdaGGEO0GDFp0U+oLqOtRx0jqeVG9P2Se0qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LMFdVl/upRO4NCzU0fK2djXDMSuo086OEXiXulk+vh8HyinpG+XuW+CJ1SDYeLFttEeStQLQ8xt3HRDUZ6Y/cwVJUk9xZTw5Km73zfb7rJYjSkO/agvtXOdy0vbQRmJCD5C+UPGBlM9+FrqXJmQ9//X8wyELW1Zco76Br2HtQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOMFxKIf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOMFxKIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnwUSh7o+5ZmaRZCKb6UInkhBSWZlCwshIxY9Qz5Cgk=;
	b=BOMFxKIfJofafnqba9URtCEvIlSfl8dOfQx8EbQLIIv72LK9jo6w4Iu6xVAweFRdxG3OgU
	iCmp3tGg9Fi57A9FCzeEV9+JB+4nrO/W0dy95PA3zsgwzZsOccVNHlKxj9ttOajgfEZ8n3
	Gfe18fvPwYn1zic1IAtrlKncFdK2hCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-TJCFAd-dPUSSNHwY-X-grw-1; Wed, 18 Jun 2025 13:41:26 -0400
X-MC-Unique: TJCFAd-dPUSSNHwY-X-grw-1
X-Mimecast-MFC-AGG-ID: TJCFAd-dPUSSNHwY-X-grw_1750268485
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45311704d1fso40533245e9.1
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268485; x=1750873285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnwUSh7o+5ZmaRZCKb6UInkhBSWZlCwshIxY9Qz5Cgk=;
        b=nBAhqXqvdftQWoIAjTza5FEVdY1rSLRRk1NYx5y+0t8BZV4e8cFW5Tl9bS4BT6Evd9
         fl/3IFGlns2zbI++LOce4NLIOtnHHKVQYJP0MEdmtoWoCnX+/fGBI8i9D7GrRvt5i0cJ
         77y1g5guFHyrdTTd5sloekm9/zhJtxYH5ggA4bdmKKQ+kIzFtlbXOCc/XZPCiPcmL4Dw
         wU8HP5kpF47dxF8B7JMTmahZFX5FDS0sgJwDDgSjK2ie1RMlOvA1hlo/wDAxH4BThT9T
         i/koVrjuGGqWYztK/NhkEIkfgzFCY4+3DiYEDLFvFcpOBk7nY8Wll4XCGFpMyUuZ84kM
         dVog==
X-Forwarded-Encrypted: i=1; AJvYcCXj6hKwr1qzAp8ZU/KzLvj16utUBxSR8P2brYyE5uvkabJecbgh29nGKPkUatEh/ccvGjY2RYlv74PDrWUbmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/MdKdd4DkRQqPFIfJ+Pgn0F2PzX3NQFNxXanFVqQN/MG1KNaI
	p8C9qtqIvEmITFR335lBzK/Et5G+zyngRi7cjKyFqjkJ+/kB+kW8ygSw3xAMN4rcMvSFyDPKr6M
	o5R+WaP6R+4/AzQfdQ46xj/GZ/vDd7bqKX0VcqeysOK7zMlPdJWuvaH4YwsB4yh5zXZo4
X-Gm-Gg: ASbGncsdOtK91KXz22PMwWCP4rvKsIi839VkpkIzytY5W/mXIXB4aG7zVgu8Y9gaV1Q
	fBI/sQnsBPKH4BeD1eSlnJNpcwxODI04Cl2aMl5gs/+QLzdMLlu4n5h+S5eOqAkZX1BuD2XKW1t
	w7Z4ymQLc1Xld0WdtxgjmHDfOl/R6qywjF9I5Gso8vF09P1hziojG4DxlYcv+M0Tty3EIWIw1kY
	0klV77qEaE6XgiIu0nRsEGOL9nJ6X4tkMg/m26o6WtbwKsNVTOsnO1sNpaHu2gW/GGNGafUvzx6
	sCrPbHQXNskbvzbf+D+AU4O1SOuU3/2MCcAbB2gjCAJWdZK7VqHMfMRoSUfHUUZ55j9cvja+Ibt
	FKrk7Yw==
X-Received: by 2002:a05:600d:1:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-4535a04bc8amr21842995e9.26.1750268485372;
        Wed, 18 Jun 2025 10:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv5K+zuY4+JCApu2tViRQi8tnrUP4BMaDADA459jpWP1i37cwdJ2pp4j+WJZa019DgSPcT4A==
X-Received: by 2002:a05:600d:1:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-4535a04bc8amr21842675e9.26.1750268484986;
        Wed, 18 Jun 2025 10:41:24 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535ebced8asm3463925e9.40.2025.06.18.10.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:24 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH RFC 25/29] mm: simplify folio_expected_ref_count()
Date: Wed, 18 Jun 2025 19:40:08 +0200
Message-ID: <20250618174014.1168640-26-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fKfrrfz_JG70vlREElrvT3lhEOCINnBrV_zgZLcDqgk_1750268485
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that PAGE_MAPPING_MOVABLE is gone, we can simplify and rely on the
folio_test_anon() test only.

... but staring at the users, this function should never even have been
called on movable_ops pages. E.g.,
* __buffer_migrate_folio() does not make sense for them
* folio_migrate_mapping() does not make sense for them
* migrate_huge_page_move_mapping() does not make sense for them
* __migrate_folio() does not make sense for them
* ... and khugepaged should never stumble over them

Let's simply refuse typed pages (which includes slab) except hugetlb,
and WARN.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98a606908307b..61da588dda892 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2167,13 +2167,13 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	const int order = folio_order(folio);
 	int ref_count = 0;
 
-	if (WARN_ON_ONCE(folio_test_slab(folio)))
+	if (WARN_ON_ONCE(page_has_type(&folio->page) && !folio_test_hugetlb(folio)))
 		return 0;
 
 	if (folio_test_anon(folio)) {
 		/* One reference per page from the swapcache. */
 		ref_count += folio_test_swapcache(folio) << order;
-	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+	} else {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
 		/* One reference from PG_private. */
-- 
2.49.0

