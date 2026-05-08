Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C37155C82
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205267; cv=none; b=aZMScX6QL65N9+dKvUZ3Ppgn0LYPH0nVxZgFUL2c5n7AGPLW+xrOkz9oOFL10n/Olodu/sQ2CmJmAtJKDxEISXOj8mjdcL/FooCr5YmgNKgtyHz2yl8oNllXESYeWGf6slPr808feh56jzWzSy5Xh0r9kWQ1f/DlnLXNjdjgJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205267; c=relaxed/simple;
	bh=/YZbwZpWJU1waamggRUeumztcFHazNDc3x7M/Ltw75A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pf4KJklc1h98zfjezRlSwsgmEZd60YF1XSPBVU9GL6X8ojzDoRmH9Ai9CnLa1CDPGSqGDK4RZzGi+sUY2zRjU5MlQ09nLSPkCPPdxcnL4UNq8OPq1Md9ymTaiNgqP/e/kPaTEfK7hfB8lBrK4pBMzVYc2HY5c8cr5mEE2yaWYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gB5wWFR8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gB5wWFR8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778205262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nseJDaSxTNqf6W2FqkALGVnCq/m8td61Q2PPLEqM7Zc=;
	b=gB5wWFR8d2fS6CPEk685eZA7JwGi9erehPEoqkVzp0el5erKaewWqfl6AD8KiWU9D8HS//
	pukirYz/z+LC5LSbu6Ep31VUgJUuhISwzvJa5QpVySDArvRBeN9E9c7J0Ddgl5bj/kn0uB
	XuvRSPHbWISeDrHw4Xsmv1wjCeMyZmA=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH] mm/balloon: expose per-node balloon pages in node meminfo
Date: Fri,  8 May 2026 09:53:16 +0800
Message-Id: <20260508015316.25722-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 835de37603ef ("meminfo: add a per node counter for balloon
drivers") added NR_BALLOON_PAGES and exposed it in /proc/meminfo.
However, the per-node view at /sys/devices/system/node/nodeX/meminfo
was not updated, even though the counter is already tracked per-node.

Add it to node_read_meminfo() so users can see balloon usage per
NUMA node without having to parse the raw vmstat file.

Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 drivers/base/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index d7647d077b66..53f4e51d6d82 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -513,6 +513,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d Slab:           %8lu kB\n"
 			     "Node %d SReclaimable:   %8lu kB\n"
 			     "Node %d SUnreclaim:     %8lu kB\n"
+			     "Node %d Balloon:        %8lu kB\n"
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     "Node %d AnonHugePages:  %8lu kB\n"
 			     "Node %d ShmemHugePages: %8lu kB\n"
@@ -543,7 +544,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 				    node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE)),
 			     nid, K(sreclaimable + sunreclaimable),
 			     nid, K(sreclaimable),
-			     nid, K(sunreclaimable)
+			     nid, K(sunreclaimable),
+			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
-- 
2.25.1

