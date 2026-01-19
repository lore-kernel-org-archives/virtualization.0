Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61176FC3;
	Mon, 19 Jan 2026 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863813; cv=none; b=dwzP5N6SL+rb4zneQOE1jM5Ss02HAfNvmoCs1dlETJGin4tVoMbDewW2NumVbkiDQaR9BlkROIbcsmT/chkEnfpz0oNrQpVOngmeifemXqDRjua8oyTsiQ6ME3vchYMm0ceAdWmTTZDT/IcvaKoxVLw/Y41sp4YE/QfYkY5m7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863813; c=relaxed/simple;
	bh=93bCC0t6vSff2vK8TVOF8nE3nZ/IKYJWWQ5I2pcLHSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxsQjN3bdI5ov6xzYAM64nT+iIrLyJsQhq6knKDEQ99n+4c7fAnyt+iTH5IglYl4z5Q0J7k8Dcmn+zskXv1M5K/SzR5Ak9/ot/DOxgBFTccODDuSigYVraZjMnDCW7BPU8ajGaQzJIVSarEh78AoNtqdSmo04ejrvNWzZbTosQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOFQQSl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOFQQSl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE3BC116C6;
	Mon, 19 Jan 2026 23:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863813;
	bh=93bCC0t6vSff2vK8TVOF8nE3nZ/IKYJWWQ5I2pcLHSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOFQQSl3AQjJzyLdOYrRwc0dbiFxoJf/oza6XFRsomdnnGo9O/OX5gzccdwhSVAzd
	 eUUGHNU9pBbhGaBYhz2UG4QleWsuFA3IfyZYp0y+Pogp9exSIRdeujhZTKkfU4uTQp
	 wXYzgkMwBOWrX0vUSyhU35NIc97JkVBhLG+862uizkAT4HLinjE2jSbCewl/b5RZAT
	 ZekWMFOYRgBb/iN0UioxgVJC8SV5NUVf7KktwPqhiTpLShfkv98cBCzBgcYFo3gFH1
	 5alKNgx5IzaY2+JIomSSnEU1ASOeg+eBrlVyrnfV0w/vnhLfhzhnh2LoTMpUr28Dcg
	 RqL1z5c7xZa0w==
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
Subject: [PATCH v3 16/24] mm/balloon_compaction: assert that the balloon_pages_lock is held
Date: Tue, 20 Jan 2026 00:01:24 +0100
Message-ID: <20260119230133.3551867-17-david@kernel.org>
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

Let's add some sanity checks for holding the balloon_pages_lock when
we're effectively inflating/deflating a page.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/balloon_compaction.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index e0a4b481c3eda..bb2e5ec2cab36 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -33,6 +33,7 @@ static struct balloon_dev_info *balloon_page_device(struct page *page)
 static void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	__SetPageOffline(page);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
 		SetPageMovableOps(page);
@@ -50,6 +51,7 @@ static void balloon_page_insert(struct balloon_dev_info *balloon,
  */
 static void balloon_page_finalize(struct page *page)
 {
+	lockdep_assert_held(&balloon_pages_lock);
 	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
 		set_page_private(page, 0);
 	/* PageOffline is sticky until the page is freed to the buddy. */
-- 
2.52.0

