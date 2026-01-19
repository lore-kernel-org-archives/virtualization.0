Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70929BDAD;
	Mon, 19 Jan 2026 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863848; cv=none; b=VGTbXVKOEB5O+qQcaEMIXsoANbaOXWeadGcDy+4wSeZ0o4swbSjGbxIWHqDJtT3mqQrRUs/23i4bQqeTkXocVQmU6fdAoLIYjKosTdAa6FXKZg3WEdORL6VM+1kX3ZOucnpddfdDcPeGr98xAmFYgE3dvFE5Oj/D6XyZSmbDUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863848; c=relaxed/simple;
	bh=8BBEwEPOV2feM9asWnviMEeN61fjbzDKcbDTnI9BSWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5Qp+/TBS4VhfE4iyzwLWNwwrwUfz33ZHjNq/nhSLXUI9Nabz2H/YdFjf8jv+ViJHY7I6QRPlbB6flSqz07z3pmJFWUqCyP4kQ0HMy1cjd/QpUEIuI5XR+7XIinAni8UdG5WBMOGhTsLP7B7HUHSSvxmICPLma1kuq/zej+A+pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggts6Muq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggts6Muq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F420BC19423;
	Mon, 19 Jan 2026 23:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863848;
	bh=8BBEwEPOV2feM9asWnviMEeN61fjbzDKcbDTnI9BSWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggts6MuqPRmp6JPKI/imH0YjdupgG5Kahp6IN70J2t4YhljglpCtvsW2PUxClQiDt
	 Wj6Hp7ccAdgQvsCFQZvMpmP7bB96YInjP5Q/zNtIg9AqiTpTECEQpc9kKMrGX4pN0t
	 g3dDc1LkJMKSq4460pcW4IT+gsEI4J+CDyG2zu6z2gQPaSl6aVVYh302a8Gs1s7yrw
	 nvBRzFeoUppU9xGXtblIuqvYXVTFyJq2E16Y+kqYPerTaWPq+GM6IU11YHnz8WpJbA
	 Q1HICF/dmj34sRYrmkAOizVVXHXgufQSJQBq7HwJwOBBpkZ0vSBys3vymkNvqTa/0+
	 pMNsBWcnlnQXw==
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
Subject: [PATCH v3 21/24] mm/kconfig: make BALLOON_COMPACTION depend on MIGRATION
Date: Tue, 20 Jan 2026 00:01:29 +0100
Message-ID: <20260119230133.3551867-22-david@kernel.org>
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

Migration support for balloon memory depends on MIGRATION not
COMPACTION. Compaction is simply another user of page migration.

The last dependency on compaction.c was effectively removed with
commit 3d388584d599 ("mm: convert "movable" flag in page->mapping to a
page flag"). Ever since, everything for handling movable_ops page
migration resides in core migration code.

So let's change the dependency and adjust the description +
help text.

We'll rename BALLOON_COMPACTION separately next.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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

