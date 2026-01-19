Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274131D5174;
	Mon, 19 Jan 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863716; cv=none; b=TUIwcMGsCttbynka/LcStq73HINjqgRciKvEMnKOl+Ffrkm82m9gfuH70W/MnDcfbU7Q5KPS2TBe1gBuVpRgs4dFnszvqWdsJf1SQtvv2f/DNFuklrLLLsIIkcAeV9zrHd1c34ZRnTLWL2uXO5QOtpRqBOtwSpzWuC6rE1/z2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863716; c=relaxed/simple;
	bh=zu0MlNB3uojZ+XY2eNxlLUaMnPt4RrYT1MRY12QCzSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWkogP1FmLcAj2EljsXDTm3mHreV9c/fj0iSYYAHaYP1vYpWDHjE+8f1iT/nB87xZAjSPwb4O/RDW2TKANaHVYZJOhKaIZIVqkyUcFj+Q43BglfxTM+sUlCjYFLJfc3I+DvPpYowRfcys46I/ZFVKgRIIJj65fjHt4wFK9V3AJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it6JXTLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it6JXTLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A858AC19424;
	Mon, 19 Jan 2026 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863716;
	bh=zu0MlNB3uojZ+XY2eNxlLUaMnPt4RrYT1MRY12QCzSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=it6JXTLDKt1WuNFXQ9Ce1X7YpHetBL19JtOQyj2tZ93grW6ScBDmXXEOP5WPBzLwR
	 xQ4EvMwIVRU3DGciBAEfChSWKPMiG3WcY6iGQxfhEv6ldblsZoy3hkwEtm1zhAY//i
	 zzS5ZbisMo5WLMJuUzvfKOr0asy6qJZoYH9hIniyfin1T+JY18S+HTHiU1p51xcLPJ
	 HhvLlwhAEQ0vWvQMhMNmumzc8AyZhR+8sWHtcZ1t38HBXWFLct4D9EdXXm0KrLuR9J
	 w9qfUy0JmLPcO48+ptAY7t/Yvn8CpMKvaSayoObgChDoH6uXNGimWjcswTRPrSslUV
	 x58d/Nlt99UJQ==
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
Subject: [PATCH v3 02/24] vmw_balloon: remove vmballoon_compaction_init()
Date: Tue, 20 Jan 2026 00:01:10 +0100
Message-ID: <20260119230133.3551867-3-david@kernel.org>
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

Now that there is not a lot of logic left, let's just inline setting up
the migration function and drop all these excessive comments that are
not really required (or true) anymore.

To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
the compiler happy by only providing the function declaration.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 drivers/misc/vmw_balloon.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 2cc34c4968fac..07e60a4b846aa 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1833,27 +1833,10 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	up_read(&b->conf_sem);
 	return ret;
 }
-
-/**
- * vmballoon_compaction_init() - initialized compaction for the balloon.
- *
- * @b: pointer to the balloon.
- *
- * If during the initialization a failure occurred, this function does not
- * perform cleanup. The caller must call vmballoon_compaction_deinit() in this
- * case.
- *
- * Return: zero on success or error code on failure.
- */
-static __init void vmballoon_compaction_init(struct vmballoon *b)
-{
-	b->b_dev_info.migratepage = vmballoon_migratepage;
-}
-
 #else /* CONFIG_BALLOON_COMPACTION */
-static inline void vmballoon_compaction_init(struct vmballoon *b)
-{
-}
+int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
+			  struct page *newpage, struct page *page,
+			  enum migrate_mode mode);
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 static int __init vmballoon_init(void)
@@ -1873,12 +1856,9 @@ static int __init vmballoon_init(void)
 	if (error)
 		return error;
 
-	/*
-	 * Initialization of compaction must be done after the call to
-	 * balloon_devinfo_init() .
-	 */
 	balloon_devinfo_init(&balloon.b_dev_info);
-	vmballoon_compaction_init(&balloon);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		balloon.b_dev_info.migratepage = vmballoon_migratepage;
 
 	INIT_LIST_HEAD(&balloon.huge_pages);
 	spin_lock_init(&balloon.comm_lock);
-- 
2.52.0

