Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8B3A0B1F
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689456; cv=none; b=XUWqfOEbRSaqWCwz/8hr1KBItcFzLW8mxN1I+7vF1lD6F8SJdBcZmTQP14JlnHCcjz9L5NFLKPC2Mfdr1GEzu7hwg2XU1maMFreSMhQPzyy+KIMnsqoMzHZwhXFuoCfLSWohDrjKZGR0IqS+UlF3thkE8Le2gGS78OT2oMLrfPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689456; c=relaxed/simple;
	bh=bRdsihvY4zjKId/liig+sN09ZPno0nPTrQN6V1MCrqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jDVMosrDAqk383AfM7QXVMXATD8nwLvFsz18OjQ3j5tiu3wrDXmjAxRcTrv6VFgPr8BmSFCrxCVmD4JDFnTNKhAhaM0PMkhG0Yc2HpYk9GMnejne0tVEzaPqzgmY8ST+1tHjzyS5p1m9lTL6Mg0bsnkjTmmePO4WWYOKADR4CkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj/469f/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj/469f/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mEMCfIlCf4bqiMJiTJpP/SQ3egOk7/aPzZBRg9jsyO0=;
	b=Oj/469f/YOrWRQaFxxtRODheMB9uo805ZGKPB6nkatcRWDdiSPR6c6mRnFFZGGdsvL5Qiq
	jINrHqzXIDQWVSOv+M97zLWPgTdM5bwwyYb5CIPaYb6z9SN2QkD44AbVqOFbOUKB++fQSU
	zZTP9RudkybQtMRVyjryXt38N3rJm1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-tTRa5xTXNR-Quwtq1XCUDA-1; Mon, 20 Apr 2026 08:50:51 -0400
X-MC-Unique: tTRa5xTXNR-Quwtq1XCUDA-1
X-Mimecast-MFC-AGG-ID: tTRa5xTXNR-Quwtq1XCUDA_1776689450
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so22395045e9.3
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689450; x=1777294250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEMCfIlCf4bqiMJiTJpP/SQ3egOk7/aPzZBRg9jsyO0=;
        b=S8OpvRv5wgRZux069o6vI7R51Ut4CJrKhU3T9SBLzxXTv3/yW7sgZ5fDkQuABtgpZu
         mDk/g5vmi17RpEydLuxI/fXiuqb9HVoD+jrW7Mj54pOtjYVF466RTBl82TvoBUmlf0rU
         sS5P+4IN+42bggn6nbw/q4WPAxbMVXDwy2PgFAfglVDuPh66gKPKZHBgaLWJITTzdyJU
         n9nFt71wG5j6aU/g985M9ADoqzt1IqwcluS2VDsBO2XS7dYbsvzKvK2pYudgAo7PxyQl
         lZLzX8PqiNLiuhDGewpYgG2TsDxpXcMSJsYFFS2QrdQQF/cApWBG9DTRrUej9vJgpppg
         BSxw==
X-Forwarded-Encrypted: i=1; AFNElJ90CMrcSRcL7T/5falTqX3Egb1j1l9ttbKICIvnFXoO6jp8npI25WI7FsprpLh/9mFYiESc7mfBMANhcaE+nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0HywpIyx1SX+OTaoRahyGASB3fENtZb77mCoymSdWrTRJgINl
	pxaoqUJY9LWAqj8Lo1x4KinefR+uw7rAxfcz+Dji509dnDGrFUZpr5eEhHBQwdlqwOpFElK8Jo2
	j/mhuV7QYu5MNgZUmxtXPzs0HPWjK0GuANt01vozQbbYgN76QGx4XijMQges1Nqn4fdps
X-Gm-Gg: AeBDietS1gZtqUtesqttZu6G7jL0Cc8/I7xVL6jf754Cb/zJNmrrpUlpgSajB4g7i9Y
	+9GYZgEi4vswajMA9IaYjj7qFumPBIqoYH7xPjHn2pQIPamU0JuFVOHvJiqkGvHg+DttMsCys53
	Mn4Ll/MbOlarXorDUjodNM2gPx5oXyzoiQQq9mRUzJ5vcZ748/iNZXv7LNfK/ZrVe/OTjDRnGE1
	liQleyqXBoi6gcrWQ7ZRrb4BdkNd4OP3PFMyvQvSmwJTjbAi+1Wubvxw6IDZ61jiEnij0wNEDpS
	f3yfdY0UaWW+urUAo8FFtkBiI0hp4d0ZUIfZy8dtPkwzLJLh5SEZ/ipZZbVQUZgGMW3HifuDrub
	I9wJd8iMKpB7y93Quh70M5/uVzizYgNnp3TvbYPbWtD9LrCO1JJkawQ==
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr56432365e9.5.1776689449850;
        Mon, 20 Apr 2026 05:50:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr56432035e9.5.1776689449374;
        Mon, 20 Apr 2026 05:50:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm149479715e9.1.2026.04.20.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:48 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v2 10/18] mm: page_reporting: support host-zeroed
 reported pages
Message-ID: <cbce38891501864ae079ab66456e3f0d073613de.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bfzUIT4-zEOnzFaH9HqYT5UK8bbsBvt3tXeShbjseOA_1776689450
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
drivers to declare that their host zeros reported pages on reclaim.
A static key gates the fast path.

Set PG_zeroed alongside PageReported in page_reporting_drain() when
host_zeroes_pages is enabled, so reported pages are marked as
known-zero at reporting time.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/page_reporting.h |  3 +++
 mm/page_reporting.c            | 13 ++++++++++++-
 mm/page_reporting.h            | 11 +++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3a7c..10faadfeb4fb 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -13,6 +13,9 @@ struct page_reporting_dev_info {
 	int (*report)(struct page_reporting_dev_info *prdev,
 		      struct scatterlist *sg, unsigned int nents);
 
+	/* If true, host zeros reported pages on reclaim */
+	bool host_zeroes_pages;
+
 	/* work struct for processing reports */
 	struct delayed_work work;
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index f0042d5743af..5e1e1a924b0c 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -50,6 +50,8 @@ EXPORT_SYMBOL_GPL(page_reporting_order);
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
+DEFINE_STATIC_KEY_FALSE(page_reporting_host_zeroes);
+
 enum {
 	PAGE_REPORTING_IDLE = 0,
 	PAGE_REPORTING_REQUESTED,
@@ -129,8 +131,11 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		 * report on the new larger page when we make our way
 		 * up to that higher order.
 		 */
-		if (PageBuddy(page) && buddy_order(page) == order)
+		if (PageBuddy(page) && buddy_order(page) == order) {
 			__SetPageReported(page);
+			if (page_reporting_host_zeroes_pages())
+				__SetPageZeroed(page);
+		}
 	} while ((sg = sg_next(sg)));
 
 	/* reinitialize scatterlist now that it is empty */
@@ -386,6 +391,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	/* Assign device to allow notifications */
 	rcu_assign_pointer(pr_dev_info, prdev);
 
+	if (prdev->host_zeroes_pages)
+		static_branch_enable(&page_reporting_host_zeroes);
+
 	/* enable page reporting notification */
 	if (!static_key_enabled(&page_reporting_enabled)) {
 		static_branch_enable(&page_reporting_enabled);
@@ -410,6 +418,9 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
 
 		/* Flush any existing work, and lock it out */
 		cancel_delayed_work_sync(&prdev->work);
+
+		if (prdev->host_zeroes_pages)
+			static_branch_disable(&page_reporting_host_zeroes);
 	}
 
 	mutex_unlock(&page_reporting_mutex);
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index c51dbc228b94..a53ab22f4c49 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -12,9 +12,15 @@
 
 #ifdef CONFIG_PAGE_REPORTING
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
+DECLARE_STATIC_KEY_FALSE(page_reporting_host_zeroes);
 extern unsigned int page_reporting_order;
 void __page_reporting_notify(void);
 
+static inline bool page_reporting_host_zeroes_pages(void)
+{
+	return static_branch_unlikely(&page_reporting_host_zeroes);
+}
+
 static inline bool page_reported(struct page *page)
 {
 	return static_branch_unlikely(&page_reporting_enabled) &&
@@ -46,6 +52,11 @@ static inline void page_reporting_notify_free(unsigned int order)
 #else /* CONFIG_PAGE_REPORTING */
 #define page_reported(_page)	false
 
+static inline bool page_reporting_host_zeroes_pages(void)
+{
+	return false;
+}
+
 static inline void page_reporting_notify_free(unsigned int order)
 {
 }
-- 
MST

