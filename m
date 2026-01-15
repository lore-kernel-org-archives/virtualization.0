Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5435A958;
	Thu, 15 Jan 2026 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468948; cv=none; b=rzRYQiLO8NSoAfT3uI1XVVVSwPg365GbiGoB7Pm8mNVtN9f+CeDYahPQFrGEaT6/URG4HeYWR5OUKg3YTG352Y98/Jg/YrDuCRA/LA3x+acmAlExDHLtJcrrnQcGGVHzzJxRt9JXE16zWbVFvXm8UkSxerwvGlfwGGvXALwPKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468948; c=relaxed/simple;
	bh=xIjT/yGPbzWdy9CPPKodSOcwDaIkDPisOU81OKu1Nkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs/EWgu8vNp9IpvpYdgVNHCk5Hu58KFv3xOT9t9F3DA7Dy4r1XrUdq+rzYZtoXqbb1viD8pdyzfIJ3a86WIAmKe6kUJldyw83tplwb6LxwBAhihla04uMnux+oMLcxdCD4lXsw+VibAJpsITFl6Ba0OeT+yd/ror88Efqf129tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYTnHiFW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYTnHiFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE0C19421;
	Thu, 15 Jan 2026 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468948;
	bh=xIjT/yGPbzWdy9CPPKodSOcwDaIkDPisOU81OKu1Nkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYTnHiFW7YPOe2J6Fze71iGPPpPxEwmxWfzUTk14RKrKFn43bosoW++6osAwhU5wA
	 q1rDiNffO1rJz6FGY3F2Ky5wp0qW7xYClI601zpW0HycKpBc/SJkGGvDucxJk25GoG
	 wMpJF3z8qZQC1e6zOMpasbtacWBOTpKXfutSC2ewiyGEUStYFrt1GnXGT8w57OD0K1
	 wmPV95kTvJ3GGM4fs7FU7MYFZ5+73R5SCqaFY8Mkp6QpcLMpKFy2KrC5v3U4UJ8L8B
	 ScLVUp/VAdCHnagkQF7bLWsOzfl8QWFhD94a+zVmyPP33NRDslhtn6lO/g0hK+i2Up
	 VO8uFwXwKrqgA==
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
Subject: [PATCH v2 18/23] mm/vmscan: drop inclusion of balloon_compaction.h
Date: Thu, 15 Jan 2026 10:20:08 +0100
Message-ID: <20260115092015.3928975-19-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115092015.3928975-1-david@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
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

