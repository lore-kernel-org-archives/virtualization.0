Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D92F49E3
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268435; cv=none; b=XprkyfTR3/6p7J/jAMReqOBkc+nAEo/JU7o3yA7lc+fZtIvCIqoN9A6J/CmcOAHTLzg/OtnyHfh4FTPBmXeFO6ZJQPxy7RQIhcjGy2o75J4JeviS5Z/RX1xNL1YMyaLugeew4UhfEdKYfJ1MQPbTdNG9TY2oBX/REnyUKvR4eNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268435; c=relaxed/simple;
	bh=LoSKhKhxUdNaBIY5unlgO/URzAbM3vnT3E6jz3vT77c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ahTQMch4AudQamhspLWBuUPU1jiVTUkKFyCDwlBb4dQIkxydh+RHku01y6OijHM/sjYzF+JeKoZnylShdBm54KmZA/NGBZbYbHjTBto/4DYAMpSIwGpFjFjQEMk+S487fvp/aB61vMCvP8SqavGB601mBu2rZz2r+SWH4ARI6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAoFe5SW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAoFe5SW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7FgUVlGmmQh/Fden7VOoWF093l0D6F2nUhdFZr7YaQ=;
	b=hAoFe5SWRuTwdmsgRTJ4buscK3J1gocVvf0qxLPtKqKgVaJdOKNCBWpDWrTOSI3bs/S2v+
	L31OMyEiw/9kx4cO469q+WBBaDy7GhiVU/zx8VWup7GtVNlBsEI4S2BY7P36vt4rxOOzBG
	baZc/mQxib3Zb65l0kg2W6hnQhK/GNQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-_Ctd-LmBMuyn7DjfplwKqQ-1; Wed, 18 Jun 2025 13:40:26 -0400
X-MC-Unique: _Ctd-LmBMuyn7DjfplwKqQ-1
X-Mimecast-MFC-AGG-ID: _Ctd-LmBMuyn7DjfplwKqQ_1750268425
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso3544946f8f.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268425; x=1750873225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7FgUVlGmmQh/Fden7VOoWF093l0D6F2nUhdFZr7YaQ=;
        b=QW6wvsfCiKeAKbx8wg25032w/bKo2cDWGspD0eSyZxrAayaOzUuQFjjfGYAOu1qWk9
         Os6/X/YXIxpDH2ZzkCXlDYNOq10Mp9JnsV23TzX51iPJu39HYQQgSUMclo4A4B4zoGZc
         Pmc9Rez1pc4OnMrVrLw9DZI/2kvsrRrYJSuZYtRrahCgkHxX4Q2BP7kIieGUUM72SfrB
         bIYtq3UgVhIKZ0ViHSJZmdkILGcXvoW1sTWfA+Cxq1Nj9s/4iyvHt0+IkFET/G0Mu075
         +2Po/Tun9Dejn13wNfyKCM5i7miouc8PcpsXnKwpHhr9hwZPubhLkIxmWIgUHyWX/zNW
         K8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUJgtTZpu4F7/0MR62jPUbRnRq+R8doXVeLZ4XyfWSYSrZURORumHg2te6VfcykdMneWmxrsZHebi5aCfnAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwStRLpXoO3qPy1yQLBqCxGvMCwCoTGwi1u2u2oM6j1wTT+Xdup
	RJEpusYmZbEn5jO6P5SQygNHjcmb2Onsu0JkJsRxOBnXwHeWvr1OyN07URZ/Rn78BdtfQUNii9i
	KzuHtESlhqxkUXoNJUr1KHqNFIfO/H3/+wirPIN7d168inVJtOVJX7r6lauhJSb+OA+xC
X-Gm-Gg: ASbGncsFvHCd8s+HtuwXBw2ndDE9GqWSjBjFj1GgiZ6JaOFFDa6vm1IutHWqHodWsyh
	VT/FqnikRxO1vbWVhgH3Gxo0BR1Z+zdjC1TBMlJUS41brSISB1hPseQORU8U8msBMhyjW0kDnAL
	ILzF1JM+EG/XruV0ShrfQ2w5I08D4DXU/bSW0F9yDjM3rcI+gTQYPD1jBE0StLRcIMZKCAvohhr
	hs+BiVPMDiXrY7y261yGzJjx70e16wc70ivEPdyfMRoWmmrd53nOrw4Zv4yrJF/Wyt0k7Sf5udu
	bQsST0vAL9WQmdLI3nU78TNRGEMQW4N1uM3H0GwgjpPN3iBONOkqDn3MUCS2uIWfyVikl3ejlEI
	knozaWA==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:ed2f:e80c with SMTP id ffacd0b85a97d-3a5723a3f92mr15706280f8f.31.1750268425297;
        Wed, 18 Jun 2025 10:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEayKPP2LeH5F/Ng3XTSzlfhGIAIvFkyNEolXxAmF4Ok7MzyUOG21uTMpu2qvZTdT619UlY2Q==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:ed2f:e80c with SMTP id ffacd0b85a97d-3a5723a3f92mr15706239f8f.31.1750268424824;
        Wed, 18 Jun 2025 10:40:24 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a547ecsm17734777f8f.17.2025.06.18.10.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:24 -0700 (PDT)
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
Subject: [PATCH RFC 03/29] mm/zsmalloc: drop PageIsolated() related VM_BUG_ONs
Date: Wed, 18 Jun 2025 19:39:46 +0200
Message-ID: <20250618174014.1168640-4-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Eg5t6B5ITmFsRDpLwwKOSOVMF32O-OqTfxqeq0a4Elw_1750268425
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's drop these checks; these are conditions the core migration code
must make sure will hold either way, no need to double check.

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

