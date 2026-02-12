Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194B223DFF
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770871893; cv=none; b=QZSW9DYu5cUn0bqP56HafPB3hsLuQvqRCi93r634ePoZm7t9TTgs+fRYiPueqaqneq4YczI+yR9MvRuiLzfoa/+UqnoffYw1GsgfWrKmXDlb1iW1SI24wkuU8QtvbDenvw3VKTgekoFvyVuq1IZbmrNe53W28mBlo0KuqH1jxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770871893; c=relaxed/simple;
	bh=3KDDnkAfe9/mVhflKpeuOU6R545jzogvk/ExLONqcck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI0FpULF2KzSZS/sqQT70siJUBmjh4YEdhcndutRdS+Jn/quSNNWcQrSg5+oqOLMnVt3QXHpwjXQzEj0C9AdGp6fW3uB22hJXL060hCupLdPBU6Lt0tql69hnaHMgToKE4RZhH2l8HY5MwvAPxRj3y79Xdilp8g4MvfT1alro+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP9YHLSq; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP9YHLSq"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso4466391eec.1
        for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 20:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770871891; x=1771476691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3624LeowZDDBkH5ZBXE4RT1ghzAQISXfFg8F+edSqSU=;
        b=VP9YHLSqzxnLdQ03h3HT7HbJekA2bOGBW2+wNjkVCeJ7OPHiIA0xEN4xPA2qoBJQRM
         uaepghA663oCgo+8HCQ/PsPKnGn0ffqb54vqzgtaZdjMPclZvZBA3R1ceuADRMTcGb13
         9kFjqAq2/QI8rgcbaAhIqE3DJ+3y3+USHFb5f/tqFBmbDOO0He6ub+QfXvITiRjXZ+Yu
         g2vyIMYRIGqiv/ES8hw5d/pzCWoIavdMUsJHT+pB49pxUR7skzM/Gj/cjBksj9gL21xC
         QbwKInF+4gsZxi0NXs53YexcAr0gI01hoBOhMVxIBihVyrzYn5hIKLGrIkZtBEQBQ554
         sSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770871891; x=1771476691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3624LeowZDDBkH5ZBXE4RT1ghzAQISXfFg8F+edSqSU=;
        b=UNLDPtnIm/lG7bUq4auHlw/BEccvo5XoqGq67hTgQkviiytYslpdTUA1Rb1+2zec2F
         TRIiwc3sv2MIVRGWnjhRPrQ7hg4duNDH0Q0VI9cm1+10xWMrAZ6yz4rZq53R5JjQ3A85
         HRBP6dxpzMRqjq0R4Mu7X2vItk5VjLF8IUHZWHx1h/7d/1OLaa5ih3BjRaxiKAqh8H+d
         nwhDrZu4z6VHSvHGpGuGoDUV3FvfQAoZc/pDOEK9o7CjPDPvyvuI484/c5eGkSBa6Oev
         rtdfJcKl1XbmbWjrwEV1bMRVtGsCqTUhV04UZjbu6MoB5Z31kKXPcZy4TaYRjUYTU/qI
         EATA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFme7btKiQ+7a2+yMWyrWAJ+lxc4EIBM0NHS9Ota6o80quTLP/Nl3ucHtmTb2TJtakK43+e0ZbuOPcjV+Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxezPMo2l9sKUlaOtL+E7fnROdPi8fFj0d2d1MxHtNFJKqF2jDt
	Mlon2uOuu3pMmMFFRBJTt16PzEmIlBIv4IGVw0xzXmRkJvwvgtLFXdBJ
X-Gm-Gg: AZuq6aJjsf3dzrNKIDeb46kel06yfh09vqsQtPYPXyHips0yDe0UnR2xV2oNqD9ZPEC
	pOXmAyhVSjjg1QV0ufOVPlYAQ2lvej+SlKqLHGOjieguuadnOZRiRE6ZJ/tSoRXyGWNDLRn8nrD
	qVvhnfFJChErMhtiHvU3WZd1kmK9Sl3rhZiQi9Ny2gAjeo4uF3y3UH8aaDmmaKkz0SzQbIN46c3
	IjiJgNjOIYAmKumcRfpILcegfyikm7rIr6ToYkK74tIwOvlAgF4GBMppg+uELFx29IA8GJlf2QW
	wz+slad23JZnEtvD8icYuUDL8dX9coUn46VivqaL1Ynv5Bzl+cso1Cs9THDeFNErFJgyvWi2fET
	90AzxbffWupeiA2/CpKP4B9LBaxpDYeiaciw+eV2cyYiycu/3MsVVb3HMyYw9KnKKIANXW90p8O
	Wu69izxCWPJfrGTb+9kwkM7L09klUlKOnlWrM1fp8j4siO+qk3xw==
X-Received: by 2002:a05:7301:2f91:b0:2ba:871f:796d with SMTP id 5a478bee46e88-2baa8091399mr577872eec.30.1770871891051;
        Wed, 11 Feb 2026 20:51:31 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9daa6151sm2878699eec.0.2026.02.11.20.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 20:51:30 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: linux-mm@kvack.org
Cc: apopple@nvidia.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	david@kernel.org,
	eperezma@redhat.com,
	gourry@gourry.net,
	jasowang@redhat.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mst@redhat.com,
	mhocko@suse.com,
	rppt@kernel.org,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	surenb@google.com,
	virtualization@lists.linux.dev,
	vbabka@suse.cz,
	weixugc@google.com,
	xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com,
	yuanchu@google.com,
	ziy@nvidia.com,
	kernel-team@meta.com
Subject: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Date: Wed, 11 Feb 2026 20:51:08 -0800
Message-ID: <20260212045109.255391-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212045109.255391-1-inwardvessel@gmail.com>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It would be useful to see a breakdown of allocations to understand which
NUMA policies are driving them. For example, when investigating memory
pressure, having policy-specific counts could show that allocations were
bound to the affected node (via MPOL_BIND).

Add per-policy page allocation counters as new node stat items. These
counters can provide correlation between a mempolicy and pressure on a
given node.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  9 +++++++++
 mm/mempolicy.c         | 30 ++++++++++++++++++++++++++++--
 mm/vmstat.c            |  9 +++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fc5d6c88d2f0..762609d5f0af 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -255,6 +255,15 @@ enum node_stat_item {
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
 	PGDEMOTE_PROACTIVE,
+#ifdef CONFIG_NUMA
+	PGALLOC_MPOL_DEFAULT,
+	PGALLOC_MPOL_PREFERRED,
+	PGALLOC_MPOL_BIND,
+	PGALLOC_MPOL_INTERLEAVE,
+	PGALLOC_MPOL_LOCAL,
+	PGALLOC_MPOL_PREFERRED_MANY,
+	PGALLOC_MPOL_WEIGHTED_INTERLEAVE,
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 68a98ba57882..3c64784af761 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -217,6 +217,21 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 		new_iw[nid] /= iw_gcd;
 }
 
+#define CHECK_MPOL_NODE_STAT_OFFSET(mpol) \
+	BUILD_BUG_ON(PGALLOC_##mpol - mpol != PGALLOC_MPOL_DEFAULT)
+
+static enum node_stat_item mpol_node_stat(unsigned short mode)
+{
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_PREFERRED);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_BIND);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_INTERLEAVE);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_LOCAL);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_PREFERRED_MANY);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_WEIGHTED_INTERLEAVE);
+
+	return PGALLOC_MPOL_DEFAULT + mode;
+}
+
 int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 {
 	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
@@ -2446,8 +2461,14 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 
 	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
-	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
+	if (pol->mode == MPOL_PREFERRED_MANY) {
+		page = alloc_pages_preferred_many(gfp, order, nid, nodemask);
+		if (page)
+			__mod_node_page_state(page_pgdat(page),
+					mpol_node_stat(MPOL_PREFERRED_MANY), 1 << order);
+
+		return page;
+	}
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
@@ -2472,6 +2493,9 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 			page = __alloc_frozen_pages_noprof(
 				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
 				nid, NULL);
+			if (page)
+				__mod_node_page_state(page_pgdat(page),
+						mpol_node_stat(pol->mode), 1 << order);
 			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
 				return page;
 			/*
@@ -2484,6 +2508,8 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 	}
 
 	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);
+	if (page)
+		__mod_node_page_state(page_pgdat(page), mpol_node_stat(pol->mode), 1 << order);
 
 	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
 		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 65de88cdf40e..74e0ddde1e93 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1291,6 +1291,15 @@ const char * const vmstat_text[] = {
 	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
 	[I(PGDEMOTE_KHUGEPAGED)]		= "pgdemote_khugepaged",
 	[I(PGDEMOTE_PROACTIVE)]			= "pgdemote_proactive",
+#ifdef CONFIG_NUMA
+	[I(PGALLOC_MPOL_DEFAULT)]		= "pgalloc_mpol_default",
+	[I(PGALLOC_MPOL_PREFERRED)]		= "pgalloc_mpol_preferred",
+	[I(PGALLOC_MPOL_BIND)]			= "pgalloc_mpol_bind",
+	[I(PGALLOC_MPOL_INTERLEAVE)]		= "pgalloc_mpol_interleave",
+	[I(PGALLOC_MPOL_LOCAL)]			= "pgalloc_mpol_local",
+	[I(PGALLOC_MPOL_PREFERRED_MANY)]	= "pgalloc_mpol_preferred_many",
+	[I(PGALLOC_MPOL_WEIGHTED_INTERLEAVE)]	= "pgalloc_mpol_weighted_interleave",
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
-- 
2.47.3

