Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EF3BE644
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490221; cv=none; b=JhTq0xPhzQIWOQ7jUeR9PqBjnXKiloDh3WN75ZJP/UbzS3TO6ld77RgeqYgo3huNDLrp5OHJngrAAIjjEJHRMOBSuRM2ett3P4W1CbQfq3PparDD6qHb3wUapmMAqmkoIupADr8t1FRgo2g4aZ+hrHUTulV+CYzZDDuoTEJTLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490221; c=relaxed/simple;
	bh=S3lspdseAiA9VDFP1z5oU53ONzTmuB9EAtNlvAmS1xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZB40dAPigifDMnf+xwfny9m+wUHKuRSS/lRvSIxQ+f2/VzcnjxxC6vM5+o2tj8k8DtRc54o5gKYY2QT6LWmWzUk/tuXmLYJNKiOA0ay0woTqhKH0i86swMizak9qTEYz1z5Iqj4L5klgU55DZiNbxLKYsHtl57mFp8xTpwL7trk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L//YqEVs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L//YqEVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrvzrHYJp3qtzaZog5kuCX8qehdfFd6F9etMXff3gHQ=;
	b=L//YqEVsExN0njxRNIjq+sXrrFhZQj2Duxe/pAGvbk1FalXCH9xuq6rp99Qe0isRCaF4/G
	cTcZNiWetiHfqZPBgbVIPcxnReWn3yKY9wNpY8cf8uzLpz18g6tuWFduDan6xJD/i8xGPh
	HNQJTMd5PdRuEHREwbj9S4uIJf0E6+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-6nbwMvHlMViNzb2myRQPSg-1; Mon, 11 May 2026 05:03:37 -0400
X-MC-Unique: 6nbwMvHlMViNzb2myRQPSg-1
X-Mimecast-MFC-AGG-ID: 6nbwMvHlMViNzb2myRQPSg_1778490216
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44bf1ac8893so3518919f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490216; x=1779095016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrvzrHYJp3qtzaZog5kuCX8qehdfFd6F9etMXff3gHQ=;
        b=FsLZ7RS0ZigNrk9jqfCyVYo/QyQ+ZY1LOBG9zWZyXxS3o5nAkQixRfxZQ/NtVt3I9V
         2cyudCnYsM6fgOCT+ykuz0mBibQ9X9re+j62W4gsF+YV5vpy9/XUMShOoIBY23eRJOM4
         4IYMWHCsWJS2bU+iLlOm9BD26Zlyq6fzz+PawdM+jAvQf8Ambjta8g76Fn4KToFuk9sM
         JYOHu+ys7DxGKWBGg6JB7hGRppIRuoaTm8b2/LyidBrktzjEPg/i5eHoD+LQg0SiP9Im
         LfZXZ1Oc5fWndUkkooi2qE+WPvl7HUUGHPP4TUAEDPbrgLCQWJUEoYLcUn7CdUipLgTj
         tYeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qsb/jE1lrfHi+Up4mi2u+58mNX8AJo5jSUx5H9PwCxCPFYQhNGb1L5SVex84XtC+NWf+mUB69oivopxfdxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSSk2+vfAKRMdNkS8Z6xGeMHJ/rZonVxD/VG90DaD0CX5HChJA
	Sfod1w8GyYgfu4n9L7L//f+FthlAxhzzrE92KpEcLmNTu5+2To829cztv+HAiX1stnZen4cFg7N
	KvdqAwQ6VY7+jfjulgv2zhfWdE5YbfJmk24RRgV4tOKQNMg3DnZwsZwd2V1S3u4O5FeyW
X-Gm-Gg: Acq92OGRx2XhqLOEhF03FwtrG1+KGDK0KplsTP1AG/yHqUmzhJiWnqZwS+/clLxM8ZE
	asfLNhp069pRZgwqkGKosgHARdCHKAPr7mAtHRduupklM2gwK6NG6+qsMmNYpLaSjhYvcnLSjyS
	gqIBiaD6G/ZI2u1ezWuUN71I0hgloTIuUiBGz9/3kmDQ2gnrouQv2Yo07WEOu8Gim7CMxsCVJ4f
	h3WWL3uM4B+i4+sbTDtbQbrqOdjxTsgoxoZWi9CaX9jh+E6fXVcGoT7sElLu9gOye5j3GYodUUj
	csy7cN9L70ep8uKkq9+iWZJ8HQbFfhIWgHVXEiqX0ckBzYxkbcpeOHgvR5oLeMQ9r3/gfP4m2MI
	3HHXG/G9X7XiZ8KsDwsWbTaVQmzljfOuqt1peTEoR
X-Received: by 2002:a05:600c:4ba6:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-48e51f4bab4mr214595535e9.25.1778490216128;
        Mon, 11 May 2026 02:03:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4ba6:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-48e51f4bab4mr214595015e9.25.1778490215419;
        Mon, 11 May 2026 02:03:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm23711514f8f.14.2026.05.11.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:35 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH resend v6 19/30] mm: page_reporting: add per-page zeroed
 bitmap for host feedback
Message-ID: <bdd094ecd33f2afd6103f53e1d9cfb1cba0f1496.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z3iuLy5SGg-aSCSUYdFhuvMAX7YY-exAv1JMYRt8hg8_1778490216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The host may skip zeroing some reported pages (e.g., due to alignment
constraints or bounce buffer fallback in QEMU).  Currently, when
host_zeroes_pages is set, all reported pages are unconditionally
marked PG_zeroed - even ones the host did not actually zero.

Add a zeroed_bitmap to page_reporting_dev_info that the report()
callback can use to indicate which pages were actually zeroed.
The driver's report() callback is responsible for managing the
bitmap: zeroing it before sending pages to the host, then setting
bits for pages the host actually zeroed.

page_reporting_drain() checks the bitmap per-page in addition to the
global host_zeroes_pages flag.

No driver sets host_zeroes_pages yet, so the static key is
off and the bitmap is never read.  Behavior is unchanged.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/page_reporting.h | 7 +++++++
 mm/page_reporting.c            | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index c331c6b36687..e2e6a487ddab 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -17,6 +17,13 @@ struct page_reporting_dev_info {
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
index 37e4fce9eb38..6c957a9daeef 100644
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

