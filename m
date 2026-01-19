Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEB1DC9B3;
	Mon, 19 Jan 2026 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863835; cv=none; b=GAwyJ+jGWcu7qJzPsDpOrGarOjsJlObVbA9ajCjaCe32hIrrl9s3KVr+MzdvlmixouATuqsNRRAQdRNzacv1giRo4YtF9yNKD9GJEMtTfpYpTYzfDnnSreMo7xYsGfnjlYicDbI2pHSaGPW/RMj/z5JYhKv3ecUYpaFo4IFDsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863835; c=relaxed/simple;
	bh=kH1VyttzME5xFeeFdR/qAHeXrLO5pFzDG/LyJb7V0HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFTloM1Ag1xf8wE6M/8nLH+y3QKbEmNfCiXgygyCqNuPnla0mLLQMPAO3KwFUDsOYeJ45Hi+5//WV94pqpAiy7krkI8i0odn9OQGRFHUoNz/nav8s9paMiuW9lokRMO+TxToBerwPf45bDkSyw245WsyH5FCkZFyaOTUrfYSq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIW4fuGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIW4fuGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09B1C19423;
	Mon, 19 Jan 2026 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863834;
	bh=kH1VyttzME5xFeeFdR/qAHeXrLO5pFzDG/LyJb7V0HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIW4fuGu6Fvm5fTOSiPeFfrt4FFXeyafRlE/6kmfcrtG7aEdsGaWbIX8IeNn0sRPI
	 D1gHKWfPif0n1VW7nAJDk74228u1Cqx673N4Z9fsSSg05aYrMD2ZIUbz9hY/4oO7bM
	 VL4FmwdTOM8cvcKd/7ean9yDQe6QSyh5qIrWAMD4tSL/fBAfsAXe2BxwiO8AyPSWlw
	 Sd014FoSAVVq/hPIOFEXgyp+hyyWVjl/iMDU9M1xyvBBnP83HdnmLnVyHuaoHkldUy
	 jj+CCjjMAKeHDv2/xjWGDVT/h7E+d6KiWNokqEor3Ae83lM+IA1yIRczDY3yZDzAwQ
	 eP3Gi+2s8wxjg==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 19/24] mm/vmscan: drop inclusion of balloon_compaction.h
Date: Tue, 20 Jan 2026 00:01:27 +0100
Message-ID: <20260119230133.3551867-20-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119230133.3551867-1-david@kernel.org>
References: <20260119230133.3551867-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
feature"), the include was required because of isolated_balloon_page().

It's no longer required, so let's remove it.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a0e3f51de749e..cd9f9a779e89b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -63,7 +63,6 @@
 #include <asm/div64.h>
 
 #include <linux/swapops.h>
-#include <linux/balloon_compaction.h>
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
-- 
2.52.0

