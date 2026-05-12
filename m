Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4243C8713
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620024; cv=none; b=km1qm0enkAFfciYZUkEpdepu1T4hyQqBH/8bxOIPHZvS8pOTa8/E412LHKCer4jJBtRABZMC5DyrYs3ztcHw0VKwhDquQGV95nsr8WPqeygoxwQMTDpDIeudYjUQI8aDLoKbVAvAQbS1NWUK2uU2Cq5SNQuROr2IgLuJPNLzetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620024; c=relaxed/simple;
	bh=S3lspdseAiA9VDFP1z5oU53ONzTmuB9EAtNlvAmS1xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q4JoCXjULyi3DFAw5FHoZKbwFihUUFqeML6cnvn5+DoiJMytfYpDlQncF35VAWf9lhWAa0O1ZkjAWU4xs3w8YdhBeS2e6svwY3woOZ64aEF6oREWRqphlUtH6z72cXWNFSOrWupXgf0QLJ9MmpJyMLkxZMkOAYfxK8sAsN8synY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtYtIIDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtYtIIDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrvzrHYJp3qtzaZog5kuCX8qehdfFd6F9etMXff3gHQ=;
	b=LtYtIIDib7iHZUhkzRwiep8gStQBfSm5oC5DU1iL0XgfEFe5B5VIZbVREkpTElgDG0QJNn
	Qpbu+vNfXfoTC9VOfWkdldgilViM9uSVJ116bKewh2+x6ggC+ibWRrUI95Wa/PKNpQEglK
	vy2/o9dHfbMlUBHOihuw6kCnRGTXZlA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-zNSLE2rmPlmAPq0RJuNtDw-1; Tue, 12 May 2026 17:07:00 -0400
X-MC-Unique: zNSLE2rmPlmAPq0RJuNtDw-1
X-Mimecast-MFC-AGG-ID: zNSLE2rmPlmAPq0RJuNtDw_1778620020
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-441243ba35fso4760051f8f.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620019; x=1779224819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrvzrHYJp3qtzaZog5kuCX8qehdfFd6F9etMXff3gHQ=;
        b=cVpPeHvCsy1124Cc0tzMT7UrEMgZRnRYPmT+4PHStm501lEK0cKCKMq8CnwOmGj55v
         1X35k/r+hri/gRIoYL6qQ5Fyk2xvZgofm+3R8mhr0GXhl/lgcCAAMcdOmAYpFfGcSf90
         VhNfqL/I8aTCevnKbwXZZwGRQbzN6zWbBeBKlKvvnfxl03fjfE6+OaYEtKdh/9TBqc7s
         nbfTfSr6QLIaKeYdnHFcun8+WF7MLPFmlStY75D/sAprIhKAPhoWLY1UAL4JqGEZrW+G
         R/XydE8jcvgBo+zKzwVXhqSJiqZjbuAQJ4PdWRdWV0h+YmW6IiTS61y3zmqIoLt6rJ6K
         TcEw==
X-Forwarded-Encrypted: i=1; AFNElJ/vJKwhgSXc0Bp4Rm4ZBcp6ZsEPBikgbI6m70uA0sDXXW+qtEpxzCIbeNeKcWkorniCIuPfbQxU8Uuewx4AYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg10k6ZfmLBe97EbjfMiinPK3q18v8e44CGo40g2kWyOJLFUYt
	WJtm4FgrALpMseifdBXHgHgyi1B6VoZyaqvBbpRJRE7mCMmEWbSVBuIKBMjIvyK4dgZXIP24Eca
	CThOrMQQpXazojZu3yhNVdZVZ+VAvNVRtrb2k9TstAK9+t2DsvEOSIcgvwr8ny6kznB8e
X-Gm-Gg: Acq92OEEZaLeuVcXCmMZUPjnfM1QaE7xGOObbAvA8/o4XJvSWGUQwvsuKkqgRf9Pg71
	41Ivy92aWintocPCwpH5ShbpUTNlhkAZ3u1RBQ4mQScHLX+BmgAu4da5EJB7AgnfX53kTvpPUIW
	8ND2loZ3LdpJusrB45gPR8zKzLYPHjFMYWQyLNTlE8rHX8MYkbeJ7jtE2oRKWYV7dwYeOBepbKa
	4qzla6r9+/aWcWA88dH2B13aXQRRdYg+Ljn43s5xzXMgBf5eWzyxZR4reLaN14IwK8qBJJN/bmP
	YgzHPtkHRE1ltN8o8lzFXyXRPe+dd/3ZplCYLsK2i+bnkl0uNE/lxaRyobQ24IXpbNx/R+U7g3Z
	wbDx+Fx5vWyGYiYFqJZaoqy4yb4InEEUgTK+wejkp
X-Received: by 2002:a05:6000:2081:b0:454:86d:b4d2 with SMTP id ffacd0b85a97d-45c57536c87mr530471f8f.8.1778620019393;
        Tue, 12 May 2026 14:06:59 -0700 (PDT)
X-Received: by 2002:a05:6000:2081:b0:454:86d:b4d2 with SMTP id ffacd0b85a97d-45c57536c87mr530415f8f.8.1778620018807;
        Tue, 12 May 2026 14:06:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm36702334f8f.25.2026.05.12.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:58 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:53 -0400
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
	"Liam R. Howlett" <liam@infradead.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 20/31] mm: page_reporting: add per-page zeroed bitmap for
 host feedback
Message-ID: <929bcbf8d4bdd51c038ec302e2db26d82d942ba9.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4JBZHigfxo2nVlPWvsvDD3yp6mQg45GoSbC2P38LbF8_1778620020
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

