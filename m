Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C421771B;
	Thu, 15 Jan 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468888; cv=none; b=eRKj1CciGBQCE6CXrlsGsdKjBoWFl7Z8I+N8EI0+GNxNSlbiajzwcj6cq9ZQxIIUyhLzxBVnTEA+CHLojnZHTm09MM1EbEWgU3JHHWvj/pMxBQKwF5E6Qx+5uWfFiRNRhMH/yamjnWjre8jtO+qW44BL2XVB/SVDrt2ujbWr4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468888; c=relaxed/simple;
	bh=41/pQYkps40P9BcPiu0aWSmWbv563rsgLU3lmcgFkvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQuX2CbyGHjRu4bGqQlA98XEZn9VBp6vAeGuZDqrfJK+kV42kqbnGiCli+/+vf2qZQo3eoiWw5EgkXSNutHYiLtjQIMOLzk8wNv5qFfjRHOzQBJjsR9X/w5bmSnTziZ5pJUjAzRdYnCc1ye1VtXXOF8JpVoeEBeJbBnDkaUILjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNcPPF+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNcPPF+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27829C116D0;
	Thu, 15 Jan 2026 09:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468886;
	bh=41/pQYkps40P9BcPiu0aWSmWbv563rsgLU3lmcgFkvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNcPPF+w00AAr53scL8jR18Q7fOodmmK2UlCZZsCOPQEG5dye1hFhrFWKaWMBcJsq
	 HcvZireBCalmRO4S4nV/b3swFSKslwc+AyIpYszWZNzpBRDkKLrIM7Qe2hzywmeN9O
	 Sswm7p6jhDQufIH2rpGOhnmmofd9rfW1tFqNoe9bTTmC+sA18UEjJXkGartnfR4SZU
	 slgCMrFZ6F6p3/cLrbx6GaFoyd8wTmKak9rlPOTC5e8cYpYOALbBCDc2HP+SehECP7
	 EhSNzizFDkYAsy4RMNk/vLZyhmWm1w38i52nIJqG3Dm1ajv8iW2pK80Bt91m1Dc8It
	 l+bdhGCDichyw==
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
Subject: [PATCH v2 09/23] mm/balloon_compaction: make balloon_mops static
Date: Thu, 15 Jan 2026 10:19:59 +0100
Message-ID: <20260115092015.3928975-10-david@kernel.org>
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

There is no need to expose this anymore, so let's just make it static.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/balloon_compaction.h | 1 -
 mm/balloon_compaction.c            | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index ad594af6ed100..7db66c2c86cdc 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -78,7 +78,6 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 }
 
 #ifdef CONFIG_BALLOON_COMPACTION
-extern const struct movable_operations balloon_mops;
 /*
  * balloon_page_device - get the b_dev_info descriptor for the balloon device
  *			 that enqueues the given page.
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 28ef0cb6b3bbc..c44e0b62203cc 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -286,7 +286,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	return 0;
 }
 
-const struct movable_operations balloon_mops = {
+static const struct movable_operations balloon_mops = {
 	.migrate_page = balloon_page_migrate,
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
-- 
2.52.0

