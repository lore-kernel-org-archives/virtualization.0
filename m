Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9742D94A9;
	Mon, 19 Jan 2026 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865230; cv=none; b=FHDJy50Gd8E86+WT5NpOHRkE03t6q7eNrfXBmaBaeX0RQFqXDlma4K5aLBDdxs+Cmu1kJltnO1j2bwdDmc+N1hHlOvlwY0+S3J34MEeOlfDmQM+6ej0sXED3LyNKyaHZV0pJJvjioB5v4e87tPcKkaR3pmCq8my3GBWaTCuhENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865230; c=relaxed/simple;
	bh=qA/8S2QM28lHfe8iWXS+dSTad4XAM1EUKu8s/MTOUFo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K8ZWCUwQ9p6y92+f4enF5Y/ZaJ6vhLyR97oZ+QxRRRLRJ4cg9TMBVRl9cQl6Yy+7r+eUYLbVStm7piA7LcZbbg1xoqA4sAxJlVkmVwvafPsynt6pQ7sB+R+2q/2WlzUTzYok2Lz8uY8Lo+grfVZYRs9Ktm/M0iVWngvBbtf3hss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xrBGHQue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xrBGHQue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261DFC116C6;
	Mon, 19 Jan 2026 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768865230;
	bh=qA/8S2QM28lHfe8iWXS+dSTad4XAM1EUKu8s/MTOUFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xrBGHQueZoDFvdTmOQPzEhyTnBkDlHnjYIq2aJDzDK8Pwpb4kNvE6OulLNIT2p6DQ
	 efJvqzcCQRWhmE4Pi9gqIp5GZ8/xrPAz4jvQUkI4vNLAmrXXEROBM1Ju2tCcPEk+CD
	 wf3hkXxUOTH0q5QPOaNvHpPmaNgx4zQZpaLafCIo=
Date: Mon, 19 Jan 2026 15:27:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jerrin Shaji George
 <jerrin.shaji-george@broadcom.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Zi Yan
 <ziy@nvidia.com>
Subject: Re: [PATCH v3 00/24] mm: balloon infrastructure cleanups
Message-Id: <20260119152708.0737b211a2167054cf6eb18c@linux-foundation.org>
In-Reply-To: <20260119230133.3551867-1-david@kernel.org>
References: <20260119230133.3551867-1-david@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 00:01:08 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> I started with wanting to remove the dependency of the balloon
> infrastructure on the page lock, but ended up performing various other
> cleanups, some of which I had on my todo list for years.
> 
> This series heavily cleans up and simplifies our balloon infrastructure,
> including our balloon page migration functionality.

Updated, thanks.

fwiw, below is how v3 altered mm.git:

--- a/include/linux/balloon.h~b
+++ a/include/linux/balloon.h
@@ -22,9 +22,9 @@
  *
  * As the page isolation scanning step a compaction thread does is a lockless
  * procedure (from a page standpoint), it might bring some racy situations while
- * performing balloon page compaction. In order to sort out these racy scenarios
- * and safely perform balloon's page compaction and migration we must, always,
- * ensure following these simple rules:
+ * performing balloon page migration. In order to sort out these racy scenarios
+ * and safely perform balloon's page migration we must, always, ensure following
+ * these simple rules:
  *
  *   i. Inflation/deflation must set/clear page->private under the
  *      balloon_pages_lock
@@ -47,8 +47,8 @@
  * Balloon device information descriptor.
  * This struct is used to allow the common balloon page migration interface
  * procedures to find the proper balloon device holding memory pages they'll
- * have to cope for page compaction / migration, as well as it serves the
- * balloon driver as a page book-keeper for its registered balloon devices.
+ * have to cope for page migration, as well as it serves the balloon driver as
+ * a page book-keeper for its registered balloon devices.
  */
 struct balloon_dev_info {
 	unsigned long isolated_pages;	/* # of isolated pages for migration */
--- a/mm/balloon.c~b
+++ a/mm/balloon.c
@@ -16,7 +16,7 @@
  */
 static DEFINE_SPINLOCK(balloon_pages_lock);
 
-static inline struct balloon_dev_info *balloon_page_device(struct page *page)
+static struct balloon_dev_info *balloon_page_device(struct page *page)
 {
 	return (struct balloon_dev_info *)page_private(page);
 }
@@ -29,7 +29,7 @@ static inline struct balloon_dev_info *b
  *
  * Caller must ensure the balloon_pages_lock is held.
  */
-static inline void balloon_page_insert(struct balloon_dev_info *balloon,
+static void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	lockdep_assert_held(&balloon_pages_lock);
@@ -48,7 +48,7 @@ static inline void balloon_page_insert(s
  *
  * Caller must ensure the balloon_pages_lock is held.
  */
-static inline void balloon_page_finalize(struct page *page)
+static void balloon_page_finalize(struct page *page)
 {
 	lockdep_assert_held(&balloon_pages_lock);
 	if (IS_ENABLED(CONFIG_BALLOON_MIGRATION))
@@ -262,7 +262,11 @@ static void balloon_page_putback(struct
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
 
@@ -279,18 +283,22 @@ static int balloon_page_migrate(struct p
 	unsigned long flags;
 	int rc;
 
-	/* Isolated balloon pages cannot get deflated. */
+	/*
+	 * When we isolated the page, the page was still inflated in a balloon
+	 * device. As isolated balloon pages cannot get deflated, we still have
+	 * a balloon device here.
+	 */
 	if (WARN_ON_ONCE(!b_dev_info))
 		return -EAGAIN;
 
 	rc = b_dev_info->migratepage(b_dev_info, newpage, page, mode);
-	switch (rc) {
-	case 0:
-		spin_lock_irqsave(&balloon_pages_lock, flags);
+	if (rc < 0 && rc != -ENOENT)
+		return rc;
 
+	spin_lock_irqsave(&balloon_pages_lock, flags);
+	if (!rc) {
 		/* Insert the new page into the balloon list. */
 		get_page(newpage);
-
 		balloon_page_insert(b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
 
@@ -303,18 +311,12 @@ static int balloon_page_migrate(struct p
 			adjust_managed_page_count(page, 1);
 			adjust_managed_page_count(newpage, -1);
 		}
-		break;
-	case -ENOENT:
-		spin_lock_irqsave(&balloon_pages_lock, flags);
-
+	} else {
 		/* Old page was deflated but new page not inflated. */
 		__count_vm_event(BALLOON_DEFLATE);
 
 		if (b_dev_info->adjust_managed_page_count)
 			adjust_managed_page_count(page, 1);
-		break;
-	default:
-		return rc;
 	}
 
 	b_dev_info->isolated_pages--;
_

