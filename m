Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4C1B142D;
	Mon, 19 Jan 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863730; cv=none; b=iaRAsfhpjk2csggvuBK7RxqjSpAHDKnOVuxRSp3XzecQ3JWEnFidO2lQpN3UFamCXXn3iKVjY2rvLgI+usIah6cWYy6r0A8cC5oo+JOD8HPkoAX+ezY3bfyIZHACTEotxByzvv3VGoAnJynvd1ufF1R59MjRRzMXYoM+8wMl+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863730; c=relaxed/simple;
	bh=9pFWzYgZbt+YY9kTe1GTcdn6HTneXxM/S/odovyu19w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOn1F6sOGOPGfke3AdD6nUOQwsUJfRbhtjhOkMEAeCA087qOWetgjEPlFLJ4zNxPSv6hW68/jwzUWPwUVr0tY6vaCGxPSgRYbQDPEhvIyzTLiv/ZW9itXmFwEO2ApJk0eznIMW8NPAqfXvoXlxxOLGS3F5cB0zvTl7o8vjoVYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLe0Khr6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLe0Khr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCECC19424;
	Mon, 19 Jan 2026 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768863729;
	bh=9pFWzYgZbt+YY9kTe1GTcdn6HTneXxM/S/odovyu19w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLe0Khr6DuCvasNoS6kxGtkTGY8Zw9brt5gCInhq8gLS+Ma4hsIx1369nWwQX1Tvf
	 IB2XumFvNDI5jcl58bu1+Pu0ZrCudk7hz7m2H9Ax2cKzotO5pTZnVWOjCHvr53Owh9
	 wWCd3vv1ICESWBRIUrkH/QL8obmlOab1LlCb5uNL/xCEid0Q/hukDlzNIqcI0jUX7I
	 MXYVPdAj/l45N6hoQMjhpukfeniE2KS3T4aRad/4Kfdv+ujJfbonv7OhpZdUpJlZdD
	 v88zh6Y7ixYKz5JxWdDwhau0K/zyUQfHaZMYxvUzxiNBuApA2jLrvXlMoViRemVpHh
	 F+IVwVmTXgxow==
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
Subject: [PATCH v3 04/24] mm/balloon_compaction: improve comments for WARN_ON_ONCE(!b_dev_info)
Date: Tue, 20 Jan 2026 00:01:12 +0100
Message-ID: <20260119230133.3551867-5-david@kernel.org>
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

Let's clarify a bit by extending the comments.

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/balloon_compaction.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 03c5dbabb1565..85eea88cea083 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -222,7 +222,11 @@ static void balloon_page_putback(struct page *page)
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
 
-	/* Isolated balloon pages cannot get deflated. */
+	/*
+	 * When we isolated the page, the page was still inflated in a balloon
+	 * device. As isolated balloon pages cannot get deflated, we still have
+	 * a balloon device here.
+	 */
 	if (WARN_ON_ONCE(!b_dev_info))
 		return;
 
@@ -241,7 +245,11 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
-	/* Isolated balloon pages cannot get deflated. */
+	/*
+	 * When we isolated the page, the page was still inflated in a balloon
+	 * device. As isolated balloon pages cannot get deflated, we still have
+	 * a balloon device here.
+	 */
 	if (WARN_ON_ONCE(!balloon))
 		return -EAGAIN;
 
-- 
2.52.0

