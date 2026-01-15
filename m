Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79F2D6E70;
	Thu, 15 Jan 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468846; cv=none; b=GJtMBOnorzyxhL5ByBz8l/WoD3K07wjnI/pg7zIU0AnfRSb3bte67ut/NqbutGmpsj+ip/cMfohrucdPa6NIWYvdA6jp0eg0pgVSUoYhkQcWwuATFYhq39yhCAM5hUzxTXWR0bDNKybVoY9svLW9DVrLXGH5wUVfe4Hl1eG/lKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468846; c=relaxed/simple;
	bh=9n8n+0cAzQ7vmJcEe9QB+II3uYJrH/Btd/75YDVJ8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uq2I29takOgA3wmeKAWPexlAmcAHaPF+NMx6UmOh3LaIYkFHo35EtYmMWll5H3sE4Mz5OpmOI0q6tvILbr0xpoG3Vo+26YftYTVuhctaAR1TS+j9fzVCq15s1wrWkfbjUnJF4Nao3eeG7FrABxLC/cI2LNaALPGZYsJpGPOggXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/0/kout; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/0/kout"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5EFC19421;
	Thu, 15 Jan 2026 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468845;
	bh=9n8n+0cAzQ7vmJcEe9QB+II3uYJrH/Btd/75YDVJ8Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/0/koutXAAcP4I/4wro7W2QSvhddotARmsvMnQOx/nzQIh10ziCaQHXsjHoEOaqy
	 9bStFDwBLQn+lyP7xAZl3tkeGlvdb/CfyfjgsPqyrFtIrPmMOjYEHCV/23vKdM3v2d
	 KF9izQF9jAfa8ikcz+ZVZRrh9C7c/EFrXqAd6cLHHb5isfFKFyvkvam/DWsGPYByUh
	 d0nFia07jUa+e8BhXn+l+bfo0gQ+g7UMpuOJuMajOPz0SU7EAuzCbp9zimxyEJBCZM
	 ozDNgFuo4hwg9rU0B01n59OPHAlC1mgdXGgF//ZcI32EaaNtkCdbeEaFLywkokzOQ1
	 oC1dqiHkWvLzg==
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
Subject: [PATCH v2 03/23] powerpc/pseries/cmm: remove cmm_balloon_compaction_init()
Date: Thu, 15 Jan 2026 10:19:53 +0100
Message-ID: <20260115092015.3928975-4-david@kernel.org>
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

Now that there is not a lot of logic left, let's just inline setting up
the migration function.

To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
the compiler happy by only providing the function declaration.

Now that the function is gone, drop the "out_balloon_compaction" label.
Note that before commit 68f2736a8583 ("mm: Convert all PageMovable users
to movable_operations") we actually had to undo something, now not anymore.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 arch/powerpc/platforms/pseries/cmm.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 4cbbe2ee58aba..9a6efbc80d2ad 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -548,15 +548,9 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	return 0;
 }
-
-static void cmm_balloon_compaction_init(void)
-{
-	b_dev_info.migratepage = cmm_migratepage;
-}
 #else /* CONFIG_BALLOON_COMPACTION */
-static void cmm_balloon_compaction_init(void)
-{
-}
+int cmm_migratepage(struct balloon_dev_info *b_dev_info, struct page *newpage,
+		    struct page *page, enum migrate_mode mode);
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 /**
@@ -573,11 +567,12 @@ static int cmm_init(void)
 		return -EOPNOTSUPP;
 
 	balloon_devinfo_init(&b_dev_info);
-	cmm_balloon_compaction_init();
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		b_dev_info.migratepage = cmm_migratepage;
 
 	rc = register_oom_notifier(&cmm_oom_nb);
 	if (rc < 0)
-		goto out_balloon_compaction;
+		return rc;
 
 	if ((rc = register_reboot_notifier(&cmm_reboot_nb)))
 		goto out_oom_notifier;
@@ -606,7 +601,6 @@ static int cmm_init(void)
 	unregister_reboot_notifier(&cmm_reboot_nb);
 out_oom_notifier:
 	unregister_oom_notifier(&cmm_oom_nb);
-out_balloon_compaction:
 	return rc;
 }
 
-- 
2.52.0

