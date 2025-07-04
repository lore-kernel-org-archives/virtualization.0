Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716162F7D0A
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624776; cv=none; b=MHCZwihx7duoEbAw6UuNhgukXkmAyZit0E7eva9p9JClG2WQizhIFiG1+uEdSGpM6dYybYQd/xERrJanzwmFz4W7uQIEHJVgCDfzgFlVPq3q06Lt+s3j/VuS5yUj568tWuH+mqGaDj5WIDOj56VNlYKGpjHcpvjopSfxs2u3rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624776; c=relaxed/simple;
	bh=9ampJPvcNYsRFz7oDnoiAgEw+Je4opPgPkQZSBZIrqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=V2WuFRubyb1pNB67m7GKd2bwGeUHEiy3ITvoghVI/nhKhehdDJ29NAILSQcMoLODNWqBX73FCETB7H+Wog911u9U5d6HH5bp78fEyj3ajW0KcyeJU7azcNc8xOzcC3Oxm4xOS032x1gniPMzjtHTCf7/J7i7bBhci5iEm3EqHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5zpj+K5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5zpj+K5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0v9UDDMP4rF7Dl8ADVUR+GZMZCj14eHRzzjvBkF5+v8=;
	b=d5zpj+K56ScBjHhhTQrMl25uWqP8E+Hw+n8QcKEOZ6huQkcnpm21Uw+QC6m+ds56eMMJjv
	/txTi3mR9JjnqFFBAtuOHyMKPmrkb5a9BX7XEYmI3wcAqkNKVoDzy1A7hgcNNyfvY8KzNP
	gPbFS3hnCmEcEB8hyCBx1WX7+xlLwGw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-Rz86oN_xMVixm2XENERp6w-1; Fri, 04 Jul 2025 06:26:10 -0400
X-MC-Unique: Rz86oN_xMVixm2XENERp6w-1
X-Mimecast-MFC-AGG-ID: Rz86oN_xMVixm2XENERp6w_1751624769
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so467604f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624769; x=1752229569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v9UDDMP4rF7Dl8ADVUR+GZMZCj14eHRzzjvBkF5+v8=;
        b=A103YrVbzWrPXnONLxeB3uKXcKnWiM6OjL6B5KsEEklnGXL7EncA+1B4AS89L0dxRB
         6S6sbmvNFx0onoJyh8c4Vg+lEdusjIQ9cgAkBTshjm9nM2cEAITGLvfWflaOWWih8EKF
         RuKPgC83kmc5oeKZCSo4eHhhqzWWLL1CBA6mtoyt5gkCpXfZP/tnFxKgA87PpchVh1Lx
         JkkneRufPRngqIjN2w9JfBjj2Hv3AKU4quQ2sHXYEyRcIjn1016cpCZzmFaH/EUAqXBH
         2hGYtf/DJ5f3SFDop+h5QW0iUlQ3Jt9TIlEr5F2KbSmOZ8Q+yeT+achpynXWohAoVbuU
         Egkg==
X-Forwarded-Encrypted: i=1; AJvYcCX0d2cbrn2s09TG3ChMo7sYa7WQ9RWZMD0ZuxKNmfssJjdjPh5SPiXny+5/CIN6r91F8Uv2TSNpnIDLtMuFUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt0ewohKLjr4dFLuRL5GDevzxwvL7s34BNZdJX50Ht7PvCwj7q
	Xx7HjKEVU9e1uj9iFLHONRX4OjABMp85mEU7g0pxwTfeQL/2HJcISkp4ifdaLqJyGk/rXth7zXY
	cc1oifCnHIX5s/1Iqvp7nW2wVKal0CH0e9RVpmiQ0fIJgX6bCWPPIFTD+pKwZQsueUFBg
X-Gm-Gg: ASbGncskvexckE1tcUusS/c2JBoheHEzcGt+aEsLdcOlkGPpfwQN2MGUfC4LKkGbnBG
	wkGHXdwFteByZnwDmFf1cg4HoTPR0yAOqvaVKVYKTo1cMWaTUiywhUYhbvvbII+WEZL4wyercHl
	OFGqfnW5aKIPsdn+al0KE0soUKtcnGZJ70hAdR61vTEgD7ul6+Wet+fQAZxMD/OeZV43TSEXQON
	H8fytihQTGuyM7iov2foIFfU72RVmVPvOlJBdLWTG6sgD8oosy0PdOTGrKBnl6V4pGA/RCBdts6
	ezJCsonmWDbvOhFLY30u+Zmls7kG3AEVsDQZCDb41K68aR/5HHLCc7Pa9nClnek3Lt+D0/xLkZH
	b9QzmMg==
X-Received: by 2002:a05:6000:1a88:b0:3b4:58ff:ed1 with SMTP id ffacd0b85a97d-3b4966267b8mr1677206f8f.52.1751624769091;
        Fri, 04 Jul 2025 03:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOt865rvlOHIOEECbMk+LvbVs6qEWcN/5MI9jLz/1+4Qw68QFcrUmFxGowYoL4Q/9NBp5iRA==
X-Received: by 2002:a05:6000:1a88:b0:3b4:58ff:ed1 with SMTP id ffacd0b85a97d-3b4966267b8mr1677111f8f.52.1751624768501;
        Fri, 04 Jul 2025 03:26:08 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285c90esm2150789f8f.91.2025.07.04.03.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:07 -0700 (PDT)
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
Subject: [PATCH v2 14/29] mm/migrate: remove __ClearPageMovable()
Date: Fri,  4 Jul 2025 12:25:08 +0200
Message-ID: <20250704102524.326966-15-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JbuuVvYNi6Uit0yOjOcbDd2zZDhxcnLEgDKFfd0qrBk_1751624769
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Unused, let's remove it.

The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
still mention it, but that whole docs is destined to get outdated and
updated by somebody that actually speaks that language.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  8 ++------
 mm/compaction.c         | 11 -----------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c99a00d4ca27d..6eeda8eb1e0d8 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -35,8 +35,8 @@ struct migration_target_control;
  * @src page.  The driver should copy the contents of the
  * @src page to the @dst page and set up the fields of @dst page.
  * Both pages are locked.
- * If page migration is successful, the driver should call
- * __ClearPageMovable(@src) and return MIGRATEPAGE_SUCCESS.
+ * If page migration is successful, the driver should
+ * return MIGRATEPAGE_SUCCESS.
  * If the driver cannot migrate the page at the moment, it can return
  * -EAGAIN.  The VM interprets this as a temporary migration failure and
  * will retry it later.  Any other error value is a permanent migration
@@ -106,16 +106,12 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #ifdef CONFIG_COMPACTION
 bool PageMovable(struct page *page);
 void __SetPageMovable(struct page *page, const struct movable_operations *ops);
-void __ClearPageMovable(struct page *page);
 #else
 static inline bool PageMovable(struct page *page) { return false; }
 static inline void __SetPageMovable(struct page *page,
 		const struct movable_operations *ops)
 {
 }
-static inline void __ClearPageMovable(struct page *page)
-{
-}
 #endif
 
 static inline
diff --git a/mm/compaction.c b/mm/compaction.c
index 17455c5a4be05..889ec696ba96a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -137,17 +137,6 @@ void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
-void __ClearPageMovable(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
-	/*
-	 * This page still has the type of a movable page, but it's
-	 * actually not movable any more.
-	 */
-	page->mapping = (void *)PAGE_MAPPING_MOVABLE;
-}
-EXPORT_SYMBOL(__ClearPageMovable);
-
 /* Do not skip compaction more than 64 times */
 #define COMPACT_MAX_DEFER_SHIFT 6
 
-- 
2.49.0

