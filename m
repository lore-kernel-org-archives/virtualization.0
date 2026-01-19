Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F172C08AB;
	Mon, 19 Jan 2026 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863827; cv=none; b=jioO3fussbTx82dJbgU2o6ald81VNxVYfEnVxiJmhmAkOKheXgSqhGQLSRsNln3/Gcxpcqh+S6i60k3yY70DJiOkJ2QSKJM+ZRPDzys+001Kr4jK2InobZ7oAPlMNN1noq51WK7kIb4hzOmJT0urB7igSWD1+wiMf1HDYlprnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863827; c=relaxed/simple;
	bh=KZzIizZvvXk5/lfOietMXSEPEGZqiuCDOnY5HWS5lB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVmVuWUDX7uraKUu7CpKuvKgVQCkIfodt1LrI/eBpn8mMMqLxS/wVDw/DuI5W9FnIw2thFcn002XFs/Lkd5PQVw47qC+yocstXFdfDR/ugngJbbUiDIRP83wgHBy/95dlxbgt7xLLjnIJ9/Aaz1cfoVnV27fNgV6lQ/P40/GYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8J/4Vdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8J/4Vdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19448C2BC87;
	Mon, 19 Jan 2026 23:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863827;
	bh=KZzIizZvvXk5/lfOietMXSEPEGZqiuCDOnY5HWS5lB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8J/4Vdc+eCRJIAoxZbYJ40lQpJ5YxM1F/DqyvPfB4iJiREt/aP0cufXXYmkJTiIM
	 rh0LWKL3Nl0Ig6I/DaxSbZKowewwb6MLwBm7BJJM7POJE6T/6Wb4590Bv4XgR6miZz
	 uCagcFY0+R+8aQpuwm359CC04g5+OYUbM8mPxOLnyFL2g2jXX5Z2xE7rr+QfftChow
	 4Kfzlq3Guc+H5BI7frRkqQcFPbG757vyABP3hefzynK6Qxh39ZXxZ09NfWxMCn0UVR
	 1BRBgGimswwiqjm1cQ0jMqScckqGXfw5zyMHy1U0YopOuZK/DGiBJhdz2D+GLvFryi
	 ae0irgoEhRC6g==
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
Subject: [PATCH v3 18/24] mm/balloon_compaction: remove "extern" from functions
Date: Tue, 20 Jan 2026 00:01:26 +0100
Message-ID: <20260119230133.3551867-19-david@kernel.org>
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

Adding "extern" to functions is frowned-upon. Let's just get rid of it
for all functions here.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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

