Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92CE2F60B2
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240113; cv=none; b=L4igGpcXuURN+c52yoB76rcf/QFZGqF2gpyRMb5ZA9wX7HE2xpqdPb3ozwLr6XJ73UOpksRVZOeLQVPaqerfgyGPj/8Rk079T6eXK1tp2NMx/vUhDPJTrRshHDbg3pVlA8n+1Kpw1lRfSytycZhtqSTwD9sS5G4xZubZTPvLFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240113; c=relaxed/simple;
	bh=/H/b9HRDS/FqkVfSUr24VvwENCpz3EuK5eZWes4C9AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nq1DnID9/88MygkmnsSf7S6/xNow8YFy70oucLU+qUsVMb7/6k6DRo7AwmTMAAVj1l/rUkN4zFnu3tdC0X9PckMZtmUMu2RoKddqqPJdnNrTRvCcemuoRsI2FLCLqxpBPOV0HyLaBCxv5NE7xDnIVX3kZlPK7wa5D1U2JOcbI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwcsLbti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwcsLbti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYAXl7F7h4aq1MzyiFunWzYtUjLEe/+xUEddBLdqVEQ=;
	b=SwcsLbtitcVK8jbszpUgM3IryzkOa1gNUYYMushC/1zT9kgtGN6nN6cGsqnJLeC7HS74zb
	6A2OavUx2pj2sP964qLQZitSLAeAgnJSuysnXscGMyTXI0NYgGRPc+xsv905j/N+UP+xzL
	+R9v0tPcdF5zB0dcEgpw8c7nRUodC28=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-_om1YJFSPpi0TVQg-7XZeA-1; Sun, 26 Apr 2026 17:48:29 -0400
X-MC-Unique: _om1YJFSPpi0TVQg-7XZeA-1
X-Mimecast-MFC-AGG-ID: _om1YJFSPpi0TVQg-7XZeA_1777240108
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7757463eso6128934f8f.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240108; x=1777844908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYAXl7F7h4aq1MzyiFunWzYtUjLEe/+xUEddBLdqVEQ=;
        b=ssf6kphGbvAMGqgKQTlO15VDqK9ut+/SBRaAIgya4k1ND41Iik6BFiLeqEcgbO0cFh
         tRDSWG0lSy6MbvK9vm+KGOqWDrXMkJ36uuNM1NylxP0ibJb5w6Zien3CkKeAA54JTYV8
         uQeBLjDXsDGhB+fuMzRktNHJBFanF5cpO5pcDB0s88r9qfwPempsSkmm/o8ol3gcjaZk
         2oF59SUT9oilMejnSB/OGrE9SQX4K3RS0mwJ3qHYSclpoLc8W6MwwPPNuSXpwb1bcdZl
         Ypr7pr51joMzwq8AxKlI3FTsJM0zisz6v2DZyZu7+/kasAZ60dUaNzjcLhTqoVVJm6La
         3qQw==
X-Forwarded-Encrypted: i=1; AFNElJ8YHdWmgd97AyGfxEdKvP5INGDrLmdxzvcdKNcQPwkj3IC4WqAI7kMI03epVkB7Wvnpdl3fmHjLKdo7eP67tw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8vDdXJgerna+AINdpxVZmF4OZXu+imVebTLdByh1rz7S4EliZ
	8U9ZT4bN/l9h94wBEs62HNpTmwNyVnvRkYMvQh09K2yEKVSortCsMrlpmtnxpMQKPs+B6ZRirW+
	vAvotWtZ52XBed625ml1DITR4CkPrBOot8CZxO0T2avBplSUr68GOUo2UqMWFnE/kGQyQ
X-Gm-Gg: AeBDiesnBjVwXx8jAfv5mdz6ejeDuE4s/pSTcQa1ii6fH3Bs5Gx3aWYY1+1g6dZ1KLr
	skSEJ0BulrijbsY3puVLXIxoJbR/xdMUOwSwvg5KwpUmLRabj9u8OZcsVrb8Ceoj1/2rEsc83cn
	vCxl/oy5q/iC8mjbqlAcr3G7AwBb8U0vcSJO/5IIkVe/dOk1MQ9Gg1PdaeLk+a5poeqgXpw/VmW
	WE023OIorCjxJHT6LPLHMpskQ0rRl768AchhPqx5XJwP7IjTUbNKFnV2HDvybrK7U+Vy48wpPEx
	xGnWvVEZLkTRFO5WGjZdWjdccFpOT4RDXKn28lD3+836sgU7zKpxvnxWoTO7XalxpyRlX0xaNwq
	5AP2+aoZgYjDWk/U3K18bPXKe+Yecus7PpLtjX5j3xmQcYaKwIbXfhZds
X-Received: by 2002:a05:6000:290c:b0:43d:772d:2b61 with SMTP id ffacd0b85a97d-43fe4073831mr59751621f8f.15.1777240108068;
        Sun, 26 Apr 2026 14:48:28 -0700 (PDT)
X-Received: by 2002:a05:6000:290c:b0:43d:772d:2b61 with SMTP id ffacd0b85a97d-43fe4073831mr59751578f8f.15.1777240107558;
        Sun, 26 Apr 2026 14:48:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm79138134f8f.17.2026.04.26.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:27 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v4 17/22] mm: page_reporting: add per-page zeroed bitmap
 for host feedback
Message-ID: <aa79ecfd8ef49fc9d47eacc6a17d27cd8c6f8975.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8MpEpZxR5yWc6dSNQ-ZapBpOFfMnYnO0chU4ycw61Wk_1777240108
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The host may skip zeroing some reported pages (e.g., due to alignment
constraints or bounce buffer fallback in QEMU).  Currently, when
host_zeroes_pages is set, all reported pages are unconditionally
marked PG_zeroed -- even ones the host did not actually zero.

Add a zeroed_bitmap to page_reporting_dev_info that the report()
callback can use to indicate which pages were actually zeroed.
Before calling report(), the framework initializes the bitmap:
all bits set if host_zeroes_pages (optimistic default), all clear
otherwise.  The driver's report() can then clear bits for pages
that were not zeroed.

page_reporting_drain() checks the bitmap per-page instead of the
global host_zeroes_pages flag.

No driver uses per-page feedback yet; the bitmap is pre-filled
based on host_zeroes_pages, so behavior is unchanged.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/page_reporting.h | 7 +++++++
 mm/page_reporting.c            | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index 10faadfeb4fb..5b63de21949c 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -16,6 +16,13 @@ struct page_reporting_dev_info {
 	/* If true, host zeros reported pages on reclaim */
 	bool host_zeroes_pages;
 
+	/*
+	 * Per-page zeroed status, indexed by scatterlist position.
+	 * The driver's report() callback must clear the bitmap,
+	 * then set bits for pages that were actually zeroed.
+	 */
+	DECLARE_BITMAP(zeroed_bitmap, PAGE_REPORTING_CAPACITY);
+
 	/* work struct for processing reports */
 	struct delayed_work work;
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 6177d2413743..61f7f08d02d4 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -108,6 +108,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		     struct scatterlist *sgl, unsigned int nents, bool reported)
 {
 	struct scatterlist *sg = sgl;
+	unsigned int i = 0;
 
 	/*
 	 * Drain the now reported pages back into their respective
@@ -122,7 +123,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 
 		/* If the pages were not reported due to error skip flagging */
 		if (!reported)
-			continue;
+			goto next;
 
 		/*
 		 * If page was not commingled with another page we can
@@ -133,9 +134,12 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		 */
 		if (PageBuddy(page) && buddy_order(page) == order) {
 			__SetPageReported(page);
-			if (page_reporting_host_zeroes_pages())
+			if (page_reporting_host_zeroes_pages() &&
+			    test_bit(i, prdev->zeroed_bitmap))
 				__SetPageZeroed(page);
 		}
+next:
+		i++;
 	} while ((sg = sg_next(sg)));
 
 	/* reinitialize scatterlist now that it is empty */
-- 
MST

