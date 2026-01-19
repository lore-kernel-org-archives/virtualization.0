Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADA21CC64;
	Mon, 19 Jan 2026 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863820; cv=none; b=JFHv76R5iWV3PBszBtSgyIsneMt/sVuaHt8yiezvwAI5GbtVl1Kv7FUOALkZf7WEg5kB8QCRFmt/5WvTzK4o0he/Fg+zWw6HFMz6iDY9r3OZibF91RpDvRoulfN5Rcnv0LJSH5aAZqfINhQDpLOXhS6VdKMykROl7DltYhPYhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863820; c=relaxed/simple;
	bh=U0Kl+wiD7v3bKS5MxUETuhXKt1l6XvM+u7VYx7CD0wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POfQ7JncuH//O+pe6JcKOtJDNQkczWu0yQW7w6JdzbEqj2mcyZ6n1XW/t+QvGipXBfWDHb+erMgHbywIfKvKBNa26/eTcdwge1ZUgZhEzl6IqDQ3fqvmYwe6R2z/zipFRPziLM2XzvRK/uM8i504sCrWBFZVTwcjyKcgADxJcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbR4/Q8M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbR4/Q8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09188C116C6;
	Mon, 19 Jan 2026 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863820;
	bh=U0Kl+wiD7v3bKS5MxUETuhXKt1l6XvM+u7VYx7CD0wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbR4/Q8MGKn20B7dYkI0WERNBQpNiLPadHF0o6WRRYBGXVaXdkKG1IUYpLM7yKpns
	 JP+Gs7INtEgWBX37ODz55WyATkn4jClfJ8stBh4Y9ShJGBnGTn/nPjL327uPgsExHP
	 GqyvyFar2f8t7jcmtiuIMMHpf5k6jdG/rZ3vJ8DjwlquaT+nBx0+kbrD86o6MaPmFp
	 dWU+tCcNAmu5BrfUdCmxyNRWZ1A7xCj9lZTV1WQwMDApWozkQVGBw8pvMAlsNeTFep
	 GLoKngx/33AtVqUW/1pR9pcY5a8xX5eB9BiZPrjq1Vlic4cr+9WEjxqRCD+y8uMdVO
	 149k+T2c2kT9Q==
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
Subject: [PATCH v3 17/24] mm/balloon_compaction: mark remaining functions for having proper kerneldoc
Date: Tue, 20 Jan 2026 00:01:25 +0100
Message-ID: <20260119230133.3551867-18-david@kernel.org>
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

Looks like all we are missing for proper kerneldoc is another "*".

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/balloon_compaction.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index bb2e5ec2cab36..bed30c6c1a487 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -22,7 +22,7 @@ static struct balloon_dev_info *balloon_page_device(struct page *page)
 	return (struct balloon_dev_info *)page_private(page);
 }
 
-/*
+/**
  * balloon_page_insert - insert a page into the balloon's page list and make
  *			 the page->private assignment accordingly.
  * @balloon : pointer to balloon device
@@ -42,7 +42,7 @@ static void balloon_page_insert(struct balloon_dev_info *balloon,
 	list_add(&page->lru, &balloon->pages);
 }
 
-/*
+/**
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
  * @page: page to be released to the page allocator
@@ -140,7 +140,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
-/*
+/**
  * balloon_page_alloc - allocates a new page for insertion into the balloon
  *			page list.
  *
@@ -163,7 +163,7 @@ struct page *balloon_page_alloc(void)
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
-/*
+/**
  * balloon_page_enqueue - inserts a new page into the balloon page list.
  *
  * @b_dev_info: balloon device descriptor where we will insert a new page
@@ -186,7 +186,7 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
-/*
+/**
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
  * @b_dev_info: balloon device descriptor where we will grab a page from.
-- 
2.52.0

