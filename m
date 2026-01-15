Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27348194C96;
	Thu, 15 Jan 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468962; cv=none; b=S6o2LDvhxxFrJDgCRArHVHqak71zIOescqVjFMulj1hw/tn/9mAEe5KgMk1TsTcroTYleTUhzLLOHmMr3HnXYLpALRlAuFtBBYCJBRky1xsyldUReMTCniFVfXV09wgecblBN83VaehYWiVZ8KVOZxof62w6LNUKiFA977+o56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468962; c=relaxed/simple;
	bh=nMSbJ130FsUcdSsvFUeUBR1YMlPlSjm9XeIRM/kAkzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNbqjVPVap29dGngtLr0ZqArl67Osai61UDdWPe5S7ExHOvG10M0Xxxecqh0bJY9EJEx/d9szuAAl7AXdNEVzxsPbtFbJ5baQFchFf/dCaufuWkYsF2u8UWHXceY6gZeydyXZ8EelZbWsVGuOLQIfsHv9aPXA4S+nj+2FUAhjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8jYzSQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8jYzSQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948EDC116D0;
	Thu, 15 Jan 2026 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468961;
	bh=nMSbJ130FsUcdSsvFUeUBR1YMlPlSjm9XeIRM/kAkzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8jYzSQQhivp9+oi3e+25bY5iCyiGPyPZY4Q5d6BT6vIFTT2h6LTECelzgIQUwBam
	 xm93YDpR/+tfwHTtSoZFn4io0EPnm7MXDaUCFJBiGSmOzZEsonSTnTAxHsKjgTmePs
	 H1WVZ6Ru1nLs8fYp2MEhnZtBPHrn7pIJQJ4NUvjSZQzddO+dTHGoMvFy05u0Yzgkpg
	 9S7YHWca/kqlFCmPhigeFIAT6icw+tMlOJZGExUL4+q8ikAyOvua74wdBt7xThNHPm
	 pwqoKl6EwJ/Zyx8ks0VFdx3aSfDNXWYRAOTML42Re/Qkt3iA/jsQXyOkuLXfvG+dA4
	 H6XnATH7JX0Lg==
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
Subject: [PATCH v2 20/23] mm/kconfig: make BALLOON_COMPACTION depend on MIGRATION
Date: Thu, 15 Jan 2026 10:20:10 +0100
Message-ID: <20260115092015.3928975-21-david@kernel.org>
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

Migration support for balloon memory depends on MIGRATION not
COMPACTION. Compaction is simply another user of page migration.

The last dependency on compaction.c was effectively removed with
commit 3d388584d599 ("mm: convert "movable" flag in page->mapping to a
page flag"). Ever since, everything for handling movable_ops page
migration resides in core migration code.

So let's change the dependency and adjust the description +
help text.

We'll rename BALLOON_COMPACTION separately next.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/Kconfig | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 24a3ff149a1b0..0d13c1b36e1c1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -599,17 +599,14 @@ config MEMORY_BALLOON
 #
 # support for memory balloon compaction
 config BALLOON_COMPACTION
-	bool "Allow for balloon memory compaction/migration"
+	bool "Allow for balloon memory migration"
 	default y
-	depends on COMPACTION && MEMORY_BALLOON
-	help
-	  Memory fragmentation introduced by ballooning might reduce
-	  significantly the number of 2MB contiguous memory blocks that can be
-	  used within a guest, thus imposing performance penalties associated
-	  with the reduced number of transparent huge pages that could be used
-	  by the guest workload. Allowing the compaction & migration for memory
-	  pages enlisted as being part of memory balloon devices avoids the
-	  scenario aforementioned and helps improving memory defragmentation.
+	depends on MIGRATION && MEMORY_BALLOON
+	help
+	  Allow for migration of pages inflated in a memory balloon such that
+	  they can be allocated from memory areas only available for movable
+	  allocations (e.g., ZONE_MOVABLE, CMA) and such that they can be
+	  migrated for memory defragmentation purposes by memory compaction.
 
 #
 # support for memory compaction
-- 
2.52.0

