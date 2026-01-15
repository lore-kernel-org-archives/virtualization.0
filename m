Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50E32E744;
	Thu, 15 Jan 2026 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468941; cv=none; b=ZEYR5GyP59UPGt2BE/CPV621/MQIgZY4ZNwy5Be5CwfslwDIXUqdJC4Q8PAP1AckEc2hjwgCb+u/4oDZGmhoQSWs0feAgYEpjBJxYSXWeKlKgxGDGhpg3fAhVTvdSW8LgJcVCThdFp9VQm9iYHqunyKLpMpOLE+wvuKT1/k0wOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468941; c=relaxed/simple;
	bh=Oj+us+E2nZAjD82c0L65S4QjEivMkfGsOYR3vhKdMVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHe/73W8hPAnMPxH5BSVISYikcaZ30cis0DWbCWIlS2N3RM168mfmQPuiNZz/tIOtwyRz7dGYuUhSIEe0yWFm5giUJagUP3rfC1PgVNoeY+AEg03IHG6ubyuvXFtKPdGk2ppovURpkCDXaWVsoFWDnPtr37LfhZO4+r6i0T4u1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGUQs23U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGUQs23U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC667C116D0;
	Thu, 15 Jan 2026 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468941;
	bh=Oj+us+E2nZAjD82c0L65S4QjEivMkfGsOYR3vhKdMVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGUQs23UuL0MUIaVZt7HjPch43nLsyQr8N/KNriEAjCx1ksgLfhW3wh48gTZaa+qY
	 96tnj/UUzP0PIXCipF3pzqx5dBpKsv8RRkmQpvassgvOnDD1yC83WGpuc9Tn802iSC
	 a9cN1fN0mpI9pDPh/+61Faxwx0B8M6IYupNqigL7L/7o/aZQnf8fmy2eka+e+iRqad
	 d2DobqERbxqyaFK6XuxZf8/k65wudAWKWSX8Qqu6w1yrr1CNUzKqkUMrU0y1SwVQSg
	 XF7DROKXMmmj9QotQznh5z9X3AmNma7WE8e2XDgJ4amiXBfaEc6aoY4Q3j2AMyI5mw
	 rQEuDPtwxRwvQ==
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
Subject: [PATCH v2 17/23] mm/balloon_compaction: remove "extern" from functions
Date: Thu, 15 Jan 2026 10:20:07 +0100
Message-ID: <20260115092015.3928975-18-david@kernel.org>
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

Adding "extern" to functions is frowned-upon. Let's just get rid of it
for all functions here.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/balloon_compaction.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index eec8994056a44..7757e0e314fdb 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -59,14 +59,14 @@ struct balloon_dev_info {
 	bool adjust_managed_page_count;
 };
 
-extern struct page *balloon_page_alloc(void);
-extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
-				 struct page *page);
-extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
-extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
-				      struct list_head *pages);
-extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
-				     struct list_head *pages, size_t n_req_pages);
+struct page *balloon_page_alloc(void);
+void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+		struct page *page);
+struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
+size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
+		struct list_head *pages);
+size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
+		struct list_head *pages, size_t n_req_pages);
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
-- 
2.52.0

