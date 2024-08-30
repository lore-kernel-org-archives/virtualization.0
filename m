Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5421B5304
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049777; cv=none; b=V75VxsmvfPlBdZGsP9mk9dgg5/Gg3Rl8OsfnkF3CJEe+gOveC6AZs8cmNiSLmEdr/p/TkPX9MX1/weZ5zRw4m2CTipy9yq3Klx/eR99ctIL/oCRrRC2zmUI0OT+c+3wv1aZ18KNR9SoT8gt+Znn/+j+bYM6uKP+kFEuT3y8J6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049777; c=relaxed/simple;
	bh=KEf4h+v3LEtN7b9V67fqymnhvMKtLQpXQtXdYB5wGlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp6AWA05zHwQ+Lf5YQj7cI80LBA79gyK//RK3LlLU3o+IRs0mggzbXa6SxS7of17u0w6jSbxhUIQYOJ/36ksVNrVKUENdzdo3ln3rwi3GSlvh3O2eMOv8fBXeF6CZ/PqSbkZ/MFSwzU0pCfZl58NJghUpQHjvJkhflKpqRPhIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzIDqqSR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzIDqqSR"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so1954406b3a.3
        for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049775; x=1725654575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCn45A0xkxYmnXC9jhkef4/QM2hxjGm0wlBoU+2BCnU=;
        b=JzIDqqSRNTd5afPCQCKN0KiC7FD0yDsa4899VH9joEz0uyRlcLT4scmP/M5t0I7Dx5
         MQqT//B1rt7nhVvDYhp8nuEDTsvIOPZvuyiBIWwz5DF1zuSBTbO/NHo0PnLyoaplp4Yp
         j/qphkpH10FZTSywYrN10bfgqzPlLTZsevX3wXjCfY9I4iYI8XLr0W+9v3qSKeC41MZr
         t3OGK/ZA8gJIudzPor3QEd87iffV22pPGmnJ9oTWygN8h3cCtwvjNxKJj+CPKQhjIbAR
         +sEhYe9YvV+vuBIyExVj8LCEDDYRDDofzOLj5wV2WfrHVuJ7w8qfrzleMEBVlaFu+B5R
         f/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049775; x=1725654575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCn45A0xkxYmnXC9jhkef4/QM2hxjGm0wlBoU+2BCnU=;
        b=Ixx+IBfnJ4EVNz+o43ho+iO2YNd0TMgGFnuVCSEnoow6B9xq8pnQnpiyQN/iw2qs1a
         6rXwIsqEZyOmSiAbXWD6QpIXlSpIDbFnyqPDYGw3g1c3zsuETIm0MTporpXdAoWyY6eR
         lMsqlbix8a5HOKWufRebaPn6jTfhMIBtWR1v5dy5tzuLku0zjZFML4bGz1CJV9LBvaJB
         46HjKERqNdeEQdkldGEelAoMFy5fRfJjYEercDDgCilcUFN07W0VpkTSN2tqNxuDh7YU
         Fkd/TtVoetaOA5ZuESEdIyMX6W/vAJiPLp+n2OvI3gWa2VeHWhKyudM7I7EoJMTwdq6s
         w0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWNZTp5rRG/bFdqyEVqVVYFoAloTtCTX+Kzmu2Ynxn7yKlHQ2kM8prsF+6+c1C5vI6v2cnipfOVq43RxGjutQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsYPfV54jJZHsAyjnYmhJi70L3nvP0tIGvSErkMT2LULU1GqXm
	5g0p8rmtCR4OJOiPZnrww6wOzynN3x4BX5qTRE6VEENS0zqW6Kbk
X-Google-Smtp-Source: AGHT+IG8y6GX/E7RigCSHufkr+GwgOj7KdtzlyA39qYM7vxl8g1/NMkb5KBYNwmdjJECo9kKMTCYSA==
X-Received: by 2002:a05:6a00:124a:b0:705:9992:e7f2 with SMTP id d2e1a72fcca58-7173c1f7300mr1000751b3a.12.1725049775341;
        Fri, 30 Aug 2024 13:29:35 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d74eesm3257035b3a.147.2024.08.30.13.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:29:34 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: david@redhat.com,
	42.hyeyoo@gmail.com,
	cl@linux.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	laoar.shao@gmail.com
Subject: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a more appropriate location and manner
Date: Sat, 31 Aug 2024 08:28:23 +1200
Message-Id: <20240830202823.21478-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830202823.21478-1-21cnbao@gmail.com>
References: <20240830202823.21478-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Three points for this change:

1. We should consolidate all warnings in one place. Currently, the
   order > 1 warning is in the hotpath, while others are in less
   likely scenarios. Moving all warnings to the slowpath will reduce
   the overhead for order > 1 and increase the visibility of other
   warnings.

2. We currently have two warnings for order: one for order > 1 in
   the hotpath and another for order > costly_order in the laziest
   path. I suggest standardizing on order > 1 since it’s been in
   use for a long time.

3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
   is meant to suppress allocation failure reports, but here we're
   dealing with bug detection, not allocation failures. So replace
   WARN_ON_ONCE_GFP by WARN_ON_ONCE.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_alloc.c | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c81ee5662cc7..e790b4227322 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 {
 	struct page *page;
 
-	/*
-	 * We most definitely don't want callers attempting to
-	 * allocate greater than order-1 page units with __GFP_NOFAIL.
-	 */
-	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
 				       migratetype, alloc_flags);
@@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
 	bool can_compact = gfp_compaction_allowed(gfp_mask);
+	bool nofail = gfp_mask & __GFP_NOFAIL;
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
@@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
 
+	if (unlikely(nofail)) {
+		/*
+		 * We most definitely don't want callers attempting to
+		 * allocate greater than order-1 page units with __GFP_NOFAIL.
+		 */
+		WARN_ON_ONCE(order > 1);
+		/*
+		 * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
+		 * otherwise, we may result in lockup.
+		 */
+		WARN_ON_ONCE(!can_direct_reclaim);
+		/*
+		 * PF_MEMALLOC request from this context is rather bizarre
+		 * because we cannot reclaim anything and only can loop waiting
+		 * for somebody to do a work for us.
+		 */
+		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
+	}
+
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
@@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
 	 * we always retry
 	 */
-	if (gfp_mask & __GFP_NOFAIL) {
+	if (unlikely(nofail)) {
 		/*
-		 * All existing users of the __GFP_NOFAIL are blockable, so warn
-		 * of any new users that actually require GFP_NOWAIT
+		 * Lacking direct_reclaim we can't do anything to reclaim memory,
+		 * we disregard these unreasonable nofail requests and still
+		 * return NULL
 		 */
-		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
+		if (!can_direct_reclaim)
 			goto fail;
 
-		/*
-		 * PF_MEMALLOC request from this context is rather bizarre
-		 * because we cannot reclaim anything and only can loop waiting
-		 * for somebody to do a work for us
-		 */
-		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
-
-		/*
-		 * non failing costly orders are a hard requirement which we
-		 * are not prepared for much so let's warn about these users
-		 * so that we can identify them and convert them to something
-		 * else.
-		 */
-		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
-
 		/*
 		 * Help non-failing allocations by giving some access to memory
 		 * reserves normally used for high priority non-blocking
-- 
2.34.1

