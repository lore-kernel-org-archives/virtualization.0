Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B330648C
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233756; cv=none; b=hAZdNWZM97A8vA/8UOg8Zt9sTxyS63LhQ61r6QbabAQ4ioSVBfJEwIHg6XX1F20FZHNyfja6zgE4yy/KjBEm+O1ZY6yI1/BxF86NVD+oytlpT/K4BSQ/uVKe/gBwNm+a7nZbvtGBNrnYck7fQDyB4ReKZH+J21yom+8PxNQehYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233756; c=relaxed/simple;
	bh=Gu9snaUFg5pUfKE0Mby48zcGZeI/KAashFElf+cKxMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q1ST6HSviiuC10I/X6NaDelyCFnEf68aHtu+7K3Cl8ZBPqSR+0wfzXDioyQfk6A0ozFvzLvrRRJ2RK+rTbmnNFYKFXCL4L5XFZGu3ADurH43c3p5K0uj8aOoW7i/5Idii0jLJD6Hayi9hW6PbI7ajEGRd3bvJ26jx9odI8em96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v2] mm/balloon: expose per-node balloon pages in node meminfo
Date: Fri,  8 May 2026 17:47:36 +0800
Message-Id: <20260508094736.142467-1-hao.ge@linux.dev>
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
v2: Move Balloon field after Unaccepted to match /proc/meminfo ordering
    (suggested by David Hildenbrand)
---
 drivers/base/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index d7647d077b66..85c20aa3c7f2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -523,6 +523,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_UNACCEPTED_MEMORY
 			     "Node %d Unaccepted:     %8lu kB\n"
 #endif
+			     "Node %d Balloon:        %8lu kB\n"
 			     ,
 			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
 			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
@@ -556,6 +557,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     ,
 			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
 #endif
+			     ,
+			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
 	return len;
-- 
2.25.1

