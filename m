Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B128C866
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288472; cv=none; b=hYJhrrkyaZPpeEfu2YhRdzMuhdg3Ixd0zcIs6DLAzQOdF+Sct1pLjkaIj7PxkqQpwSdjE9/b2THTPxfEE2R+Oh1YPkbe87TNLHBHZr7psosGwPqRNvhZnlKQ3mYf/UyIy76u8L07rXz+qIxLIuHDahm3c3FhBA1rka/PN8VbvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288472; c=relaxed/simple;
	bh=iVcKD9ZKy+q0IZPfhKWFJvDMMmEVnhfUGzTuz3ApUIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OG9ZFr34RVNzX+CNl9ubmLW865neJ3BUDdXnSATY8c4RsdyGBCtqvQiXslFUhS5GIFMBYWpTT9M95L0H7dje42o5SDiGGVgWss7Q1pLwAktnipFHNoqasriSeOvrv1EGFunkq5BKU77XEW/9eNtipuUGkPdwrBw2AFsaBLutZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OM/Hud0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OM/Hud0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIzDkBhnyPsIOakhHuAsjx3fJM8m9J+HURfbhEZ1A0M=;
	b=OM/Hud0wQfe3gt9QN10EdFKo9IwEyU8g90GpkLnFjNcfpcF8obudit5+pxeGMYvzVdqItP
	UI2W435Gzs1Y6XOJ4nwYpiipFxPrfUknk0sfUpmA2Ei3CFzCboU/bG/fuvdfsHD9hoGA7x
	0OnL+0NKGg2R03rpAYVTQewWJgY8fyU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-zQkDmT0BPHCULwXqNE3HHA-1; Mon, 30 Jun 2025 09:01:05 -0400
X-MC-Unique: zQkDmT0BPHCULwXqNE3HHA-1
X-Mimecast-MFC-AGG-ID: zQkDmT0BPHCULwXqNE3HHA_1751288464
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso23507325e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288464; x=1751893264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIzDkBhnyPsIOakhHuAsjx3fJM8m9J+HURfbhEZ1A0M=;
        b=uU/6EcyTjSPIjYK9OorYtLESvjQ9vMnc6JuWkBP1Qb3nNY20rlDG9PdA4JO0kZ4MuS
         oTzgCxbC8dj3oipRuC2tiDMZsgNtmpcwZzuRSWnlv6sbqbX6EtmAsoaPZjVfCnYq0uno
         W9JSyzTqEjjeLycOoDSd2OtDQX+HYjJy6OtrRZSRC1t3B8UCILDX8eQ4t/9O2QuIYKFC
         MqizCt230mdaEdlZVDucmBCA6fCsIuyE8kIs5vGt+eCZgOeoKAsoKeJfFc1QhsMdYJJ8
         84Z7jvCP5RZLn/alfhRt75IIeYBq0vG6mtFIep/xD22fzLCZO1oxfqrE8KE3r0Mvv91x
         OKQw==
X-Forwarded-Encrypted: i=1; AJvYcCUkRxnCM/CngOwwqIwZSR/55rYtL7M9EDjxvgkTkxH5FztM/k4GNDvBnoeVzk3wc/0KmLfbHpM+n7qVMfpW2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBDQA39ljb/tl6mUWX7SAzoCSZF9gEe/LgAxIE/je0NxluV6h7
	mfRegjY6LAIrf8HGhX0GFRKJ7XRyPxDfR1/FZKtI7FgEI2mRMJdP4bAi9U+Jwhw+BnrmjuRs/CI
	W8XUCfUOnLuVawHlzJRjDvKG/waGP32P1PoOvkMwC0w/7bgdB65Injq9pNqp/vNgyp5iD
X-Gm-Gg: ASbGnctbTNnYKJe4TrvI87rhRWjraeAbQ4/Vv/tO/GAmg+KF0buEEF7MbVU6XeFfQSW
	TUjkQOkhPs9xgnw7oR892GI2POehTwgUaGb7COTWC8eVFGt0Hzok+vMCU4uhB04HfX9Vbg7Eeu3
	jPQCTH0eEtiv6/JdDr2cSfKlmqW0uMCkvGdOoM3dqrzNxtbM3NAVXL6m+sVrOjyNxu/F/AOOjK/
	swxUxI2s7dBAsn9wUZNg6b3LVaydyagRl9kzFMViDELPlrItJAsKRGzQrs6lcNAiM9iF/0h52Yr
	p1vKebAhWAThc4/6ljPkgA3Xp/z3CeD+9c+vA82chLH+qzX4vWTpEcvQowIhItApE97r90SEDbV
	9OiXSgcA=
X-Received: by 2002:a05:600c:1994:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4538f309394mr135240785e9.14.1751288463687;
        Mon, 30 Jun 2025 06:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7zExQWNaFUjIE00JTRK6K+i5BO8qjO8BpI1TRkHw1kVlVhDi4cL0K0LNLq7UFrw8vD2WvGA==
X-Received: by 2002:a05:600c:1994:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4538f309394mr135239205e9.14.1751288462959;
        Mon, 30 Jun 2025 06:01:02 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad247sm170241515e9.26.2025.06.30.06.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:02 -0700 (PDT)
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
Subject: [PATCH v1 17/29] mm/page_isolation: drop __folio_test_movable() check for large folios
Date: Mon, 30 Jun 2025 14:59:58 +0200
Message-ID: <20250630130011.330477-18-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zR91lh2o-3Rk5y_uq-zbTrUvq7hqSDpNOOFEIZByRXs_1751288464
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, we only support migration of individual movable_ops pages, so
we can not run into that.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b97b965b3ed01..f72b6cd38b958 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -92,7 +92,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 				h = size_to_hstate(folio_size(folio));
 				if (h && !hugepage_migration_supported(h))
 					return page;
-			} else if (!folio_test_lru(folio) && !__folio_test_movable(folio)) {
+			} else if (!folio_test_lru(folio)) {
 				return page;
 			}
 
-- 
2.49.0

