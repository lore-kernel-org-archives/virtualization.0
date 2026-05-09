Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3EE1A9FA4
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288251; cv=none; b=k4LJaDJlrdwIQ/xEUs1Uyplt5a0EZOBmCtf5iw99OwRcq4vHQ7pSJ0FQo2YmaRPtK6ZulzV/75fm2U12uAJu27gex5mpv4xvAF6WA3hACtXIlYHFw2Q6tLRRxx/7rlwWSbNOyiIY7fUGZ5tFWzSMwRJ50hOGbn6s3FeNxKEHzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288251; c=relaxed/simple;
	bh=RjGqogvAnFsQoPtJmKgl6dhgR0FPOw7bDOMfQ+tsLhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKjCpDHRjcd30ILSGzyZ53curSkeaOfK2X5n6KL2U0Vj5da4GOkWP6EJ1XtVcs3GKS6Tg92wGmAAqexGFctNJo/seenohmewHoflyvdCEPjNcetkuxpnOeARnUVGB+3H+AT1mB0WqhKTQZ8o2S9RnIZ7X74zz1OnQSsiW1j3XnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LeJ2zIJY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LeJ2zIJY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778288247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pD+nxbDFKBRIVr6vnl3tCVeWtnpaIBk5Z2HqW3vTtaY=;
	b=LeJ2zIJYOzcHEaRxAw2nzgaqb+fd2XmIDoc0tiBe561WpKjciHaVjnk+8f9FzpLiuvHdoT
	U/I8mzU6c7wYdctZTeiZMsFHOv8lvP7gyV0RrUSBPP1R9Ji6cgZaX7nf1iUlUn7N0d1XaS
	SNdesm4yr8MbYbcBfWOZVogSsiBaE1o=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v3] proc/meminfo: expose per-node balloon pages in node meminfo
Date: Sat,  9 May 2026 08:56:31 +0800
Message-Id: <20260509005631.17183-1-hao.ge@linux.dev>
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v3:
    Rebase on top of 2232ba9c7931 ("mm: add gpu active/reclaim
    per-node stat counters (v2)), place Balloon between Unaccepted
    and GPUActive to match /proc/meminfo ordering.

v2: Move Balloon field after Unaccepted to match /proc/meminfo ordering
    (suggested by David Hildenbrand)
---
 drivers/base/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 126f66aa2c3e..f4d9a21cc24e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -523,6 +523,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_UNACCEPTED_MEMORY
 			     "Node %d Unaccepted:     %8lu kB\n"
 #endif
+			     "Node %d Balloon:        %8lu kB\n"
 			     "Node %d GPUActive:      %8lu kB\n"
 			     "Node %d GPUReclaim:     %8lu kB\n"
 			     ,
@@ -559,6 +560,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
 #endif
 			     ,
+			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES)),
 			     nid, K(node_page_state(pgdat, NR_GPU_ACTIVE)),
 			     nid, K(node_page_state(pgdat, NR_GPU_RECLAIM))
 			    );
-- 
2.25.1

