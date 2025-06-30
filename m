Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52428B3ED
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288429; cv=none; b=WGixpX5ODQKgiDHISkgblqul/OFRkF2ol6ek2SpW0xkeTGnnfajc7e8T+zaZK/YXJ5uQtxa2yYiUaROtmokeEWBrkaMMSTfI/8YzWM6JG3X8p06mR6WMxo6+Ez7QefDYhcgy/RivA06j/1d4Up25KgO2TnIPn10LvOMMcifC8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288429; c=relaxed/simple;
	bh=g/Nn7yNLQF9bkumkJTFPBJ0/vMryjzBbswzQoi8SqSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Kl5ocM1BXe/7rkK6tMYR1r9mFCjuWtmqLcDXo/9Olej9e/fVEAe2+ktG1LmfvDg+crUfk+Z3/k4kLNhxMP/t4LQqccsPhyrdiCKdsuBDCzcNoaw33Bxe51GUr38X1A/CPPXf1SFYA+++w6o+eM0K5yQLfV1G7IWj0FwMre9LKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPpjbt54; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPpjbt54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UC4605AtCeOAEiQnGvC6ua/uaOm0pT0/PRnxSFzekI=;
	b=QPpjbt54Sq1nsyEnRcsLZBTYLnb2trhyEH+nxBRgNeo1rX6AoWvF6nB9mntbrMWZUjo6hU
	PH0Pi/WuL1ntwRrZXHdIy0nSxlbchGAc2iUt5wlimiD0b/vbCh9Xa0MonH+VkhQp0c3yLM
	bm5pN/zadGCMg7n27mu1VqLDrfeRakU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-NpWme9PzNM6q13Ko1EAewg-1; Mon, 30 Jun 2025 09:00:25 -0400
X-MC-Unique: NpWme9PzNM6q13Ko1EAewg-1
X-Mimecast-MFC-AGG-ID: NpWme9PzNM6q13Ko1EAewg_1751288424
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso953586f8f.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288424; x=1751893224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UC4605AtCeOAEiQnGvC6ua/uaOm0pT0/PRnxSFzekI=;
        b=ZUvXruSa+2RR2znMVAH9ntSle9otTT6uF9kCuctUKQgvvX1POpN5A62TgNdfAEwHz8
         ad1BOLOatXMTkdDmhuJ7v8FpNU3bG7ogd0b6V1P9hk5c3Mj3uaJBBuiVHhmyGNEPEnvq
         AJyKvpnEWsS67hF4RCX+UmAlDl3AzPerMPvAn/WQDEWg+E2cqG+7Dkhe5EIprhXEZXpO
         Fxdp/i8DNw5pt+z83QUmC4qaPmmbOnDeSh0AYS/fechQOlWhwsgrMOhsyraSMwKe9Yyv
         8PN3hVjNRnmWRtHvCyoBGaWrCGERHLJUlwHm0anMrQ3/zejliBIzKu0c16fD4wxwvZL1
         Hxag==
X-Forwarded-Encrypted: i=1; AJvYcCVbZ6l1DlczWKVQCxYr1sBfZs+aIVXR1YjdDFfgB7t3/jN4ljg7rI0b24IOSaoq1RtT/vq08TkynaKLKuF2Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCycgLiHuDykZnwkz9rCroWDuAIxGA0zTWnX4qhNMCgP6eFLp6
	gF6cNIL5IRbXlMnvZIKnsFCM1zKP9xdodvHDzAb9ZR9q/EO8mDFqY7LygWqr1JSoFbvs/Z+lfy9
	iHB4NGrIIHeWSzfoPiabwLdGR75YdUjr0LSXwcilJFrDHi+HPhWGnZA+PhT5yVUZ/mOUw
X-Gm-Gg: ASbGncsmuJFUErNlFZxSHahaH/z5PljopQmuSyCzM8oHdXxS6IBrYy0gjpwLuq6k6ao
	GVcePUIqw5MgxTZd4+GavJvb/vA2oDGLkbUrfwpKoCav7O0oCuR3BgySu+R/tQAY0b1CpznDZ6S
	6Lf69DNvPbMU6dzo2v0WfuiaUQiuBnWLdcjQAsLSpI37PSWDtZ8HgL8MdON99hEUcu/id+BJbln
	rZD73lGFto2Ul5vwBYJnK4gmQ7gdIfjKHrtbjpvnXp4JfxEkkwz+wM/WvAXs2EaKFmaiG6iXmmm
	X+xkjmn1mFVSWF0s6mNKUV0JOGYD2JqK0YzpW6XgLjVxBqa1id5h8z8cLH68jaC6Ld7vW+iBN3t
	nrWgXAv4=
X-Received: by 2002:a05:6000:1786:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a8f577fdf7mr11727551f8f.1.1751288423806;
        Mon, 30 Jun 2025 06:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLO9PGgybCCYgBv54Fac4lQzN8FKYTlkGjVWntSI86PNTFg8laDwfPxXxOTUUP76xSqnQLIw==
X-Received: by 2002:a05:6000:1786:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3a8f577fdf7mr11727461f8f.1.1751288423060;
        Mon, 30 Jun 2025 06:00:23 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e595c6sm10642847f8f.66.2025.06.30.06.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:22 -0700 (PDT)
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
Subject: [PATCH v1 03/29] mm/zsmalloc: drop PageIsolated() related VM_BUG_ONs
Date: Mon, 30 Jun 2025 14:59:44 +0200
Message-ID: <20250630130011.330477-4-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: iTB1DKVvzrr8eqmx1KHNUkZu5VdSaBajsHOzqCLpIBk_1751288424
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's drop these checks; these are conditions the core migration code
must make sure will hold either way, no need to double check.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zpdesc.h   | 5 -----
 mm/zsmalloc.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index d3df316e5bb7b..5cb7e3de43952 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -168,11 +168,6 @@ static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
 	__ClearPageZsmalloc(zpdesc_page(zpdesc));
 }
 
-static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
-{
-	return PageIsolated(zpdesc_page(zpdesc));
-}
-
 static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 {
 	return page_zone(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 999b513c7fdff..7f1431f2be98f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1719,8 +1719,6 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
-	VM_BUG_ON_PAGE(PageIsolated(page), page);
-
 	return true;
 }
 
@@ -1739,8 +1737,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
-	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
@@ -1811,7 +1807,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 }
 
 static const struct movable_operations zsmalloc_mops = {
-- 
2.49.0

