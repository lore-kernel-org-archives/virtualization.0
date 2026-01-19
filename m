Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B821B142D;
	Mon, 19 Jan 2026 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863771; cv=none; b=KWFgJSfXexk426508muaEi/QnnuiPzpkZsq5JOnnrK53qUTH/xetB8WPkYoDnqiDbhlsLlr9Y5l8gsofZh3cgNARYpjf8mn7PzcwlFks5xKZwprBFa7YknQA8wzZknz7znrmEwUHk5CF84m9TYjBYr3FP2TFl/FThtx/kh4K3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863771; c=relaxed/simple;
	bh=L0GQNAdOR/JPbtfKkp93QvUS5ciLoWv5t16Us2SfM7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocy3pAjV4JHOXi8Ok+iGJzowI5kk7W2umzvXb/Vp4GE7NH8+kgWex/u2tND+hL/aiCF1u0+t5XaCvyFZLOKkb0eqeGut3VLTLzEQb/nDHOqjOmpnHgHiYiVuFDz3c7aeV7dXVWCcqsrLP+Ku5OfTV3VebYwNKKRxbmduX//+K0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvOvpttf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvOvpttf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84FCC116C6;
	Mon, 19 Jan 2026 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863771;
	bh=L0GQNAdOR/JPbtfKkp93QvUS5ciLoWv5t16Us2SfM7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvOvpttf1kAvLfqKLjmfytunK2LOvgBgWZQy98vpmZf7M69HJPyEbpN59hjBYAgAN
	 5IC6xIovQKda6++cNe2jxPvRgCcQJ+i8VziIHmD+7tQWhJ500BB/Szo1tx1O6Niu0y
	 Qi5Ch2QWUIG2rXheRPalPAahZeIRoYRBP8prE05DO0S7M7eTw7FTcTH84epyfKTlhG
	 dAy/nCWJ9Xevj+prD5Id4gP3Bda+nuYUvOyk7JlBtw/QY79TkePDV3UN9A2wMPFxQy
	 XKgu9yINJPlolyHER1O5vx7qk05ZEiAOV+fLo5L70CTssW7IxUYcfiSq9tAC06TS5H
	 00IZRTVLUlvPA==
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
Subject: [PATCH v3 10/24] mm/balloon_compaction: make balloon_mops static
Date: Tue, 20 Jan 2026 00:01:18 +0100
Message-ID: <20260119230133.3551867-11-david@kernel.org>
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

There is no need to expose this anymore, so let's just make it static.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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
index 75763c73dbd52..cf4d931763920 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -288,7 +288,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	return 0;
 }
 
-const struct movable_operations balloon_mops = {
+static const struct movable_operations balloon_mops = {
 	.migrate_page = balloon_page_migrate,
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
-- 
2.52.0

