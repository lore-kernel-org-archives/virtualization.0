Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F753C3BFF
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315788; cv=none; b=f3agq3v2P4VhRN0+kCzj3hE4JHOjJVFE+DfGJa485XUnwkHRwgYYaO/NjTSJWRQW3EXFgPaeetbKQ/rFfEXaIJPSvisvguHXI2qQeYTIIbasE0Ezz1yC1J32gHB/dSPnCU5d+J/Nz7bUrx1XP3eoilj3Q5hoYeMaPYYzq6TuHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315788; c=relaxed/simple;
	bh=flUZ+cOTUcPYfWzZ31XAct9k/k2k4jVzLXPQVMmAbwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eiGVoQqR9JXPSM0BqSmBNc2EHtA6pydTJJCFQMeWLsrPEz1PZODVIYDHlAM9PDgxha8y51kSy26U/+bBCBOhqHHYZ7Sy0Be6VFvSHn+hSiMvr6puIPYiLdb5Iz3LNAOajT8X8BojbbR6q/dAu5c0Md4hzrl+KhAxNbC3Kn/4OVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENk/1yk5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENk/1yk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUKKOK0OmR1aDSnh65Nr9KPiL6ZvxY2ICpkCGdvKy4Q=;
	b=ENk/1yk5P99njixRffDCjn0XdiR0CF43ilmvXY8mf/0eWMjPh4RHzdVnzvg56u58yTjxj9
	vCSyO9d+duqX1JVxHwgXI6m2OKZ2hWttmTp1gfnxXxvvOKkyvEDCN8YrHmyyqmT4p9HBYe
	HMd+ksE/4VLTRIQMBoqsO5Kbvaem+t0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-0fW6Gf5YMfWfNiluslqrZQ-1; Wed, 20 May 2026 18:23:04 -0400
X-MC-Unique: 0fW6Gf5YMfWfNiluslqrZQ-1
X-Mimecast-MFC-AGG-ID: 0fW6Gf5YMfWfNiluslqrZQ_1779315783
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd396daedso33655995e9.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315783; x=1779920583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUKKOK0OmR1aDSnh65Nr9KPiL6ZvxY2ICpkCGdvKy4Q=;
        b=nHjvOD59zg5+9SywGKPV4g01isZBxXVgNULdv6Uz5RwRH1tQk0J1mFYsLXORD1X4tJ
         JlCy+QGSbshpYnN1fxEBbknWVq42aDF/BB0gyWNxqIVH73dq+FBFvCrK35LtoA+wsWZv
         8eeBlogMAp/R27HCpS8A1zBKxs8G8AmhtVpHjTpiZ1DiR6OcOrmkVlf527dYz9ZUahow
         lxDTw9gtZ0PFApi3RMYL3j0/vLmpnMmhlMMVvCl1IiBjy68Mzy5gdduYy8bbzs13O90/
         haMv4mRnRBv1+j+7EYajmmw4lBcKkEQUL2u6gNOSWCUg5n7uu7tqCm9Va7mcxugqIOUM
         t94A==
X-Forwarded-Encrypted: i=1; AFNElJ89GSIjxuGzEU5baqS8egp6Jf4zJ6SyZY7qt3EohWktzDxiK8r2M+s7fr38M6RZlLiUQgr0V75sfM/+krj0ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqohmKkl35VMe/AeO/Ha6qD+Z5E4aB7reyK28r8RyN51Djl2wg
	r5zPVbYH0ZSqWXr1zSjiYWBmzEWmxiW3cPNcsg+rIxiUKGnMvHq9tiMdcZf3ajzmvyRsofdA7i7
	iFrSu64vZzVM9VurcUTFwRXG5LqGPyDwtzksS8EUVz4jZWcTjmnog/5WhvSVM2VhDxW+b
X-Gm-Gg: Acq92OExSD5aA9GF6k9ON2lzPQ2osm9M3YKhzIMkOGvLJNpPsZopZBRmKs7yQbBvvPY
	wxAkii041Zr2tmz5qUGvARqyHGcQ/zZzOZ9654pQ0AC5i/8PcC0f4ondKEekZaqBXxJg+UpO7Fe
	Eyv1Pnht6tlFHZrJQZUZXP7T3P2uiJm3+ae11O+BNVVnq2I0jwUgwnEJHQm5orbpPjXx/RdrUr4
	J5jIQKjyPTT5eU3LHHeB+1PuMfnot10SzMd+LnRTQNu5gmMdssaPgktIi3r5bDLaeSCnPEUz1n8
	rUz2J6/xzylHzkQ/WW6dNo+MYhOLuDEvwAmqejG897keuYJ8JrpMPWEIQpbXeGVnM3f8ZJYsIae
	HCZfopk0nFgrE0LW99OhI5UyndjZv7JFXlN4GBAvCUt8=
X-Received: by 2002:a05:600c:31a9:b0:48f:e6de:1cba with SMTP id 5b1f17b1804b1-49036089574mr1978975e9.17.1779315782962;
        Wed, 20 May 2026 15:23:02 -0700 (PDT)
X-Received: by 2002:a05:600c:31a9:b0:48f:e6de:1cba with SMTP id 5b1f17b1804b1-49036089574mr1978505e9.17.1779315782397;
        Wed, 20 May 2026 15:23:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3e9cbsm16828155e9.4.2026.05.20.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:01 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:57 -0400
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
Subject: [PATCH v8 29/37] mm: page_reporting: add flush parameter with page
 budget
Message-ID: <842171d4147bb97a96b87386772a4ee2f058fabe.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rQZ6lQgLKy7rID2nrHoV2YSoCFoql5sfFttgk26iJcM_1779315783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a write-only module parameter 'flush' that triggers immediate
page reporting.  The value specifies a page budget: at least
this many pages (at page_reporting_order) will be reported,
or all unreported pages if fewer remain.  The actual number
reported may exceed the budget since each reporting pass
processes a full cycle across all zones.

This is helpful when there is a lot of memory freed quickly,
and a single cycle may not process all free pages due to
internal budget limits.

  echo 512 > /sys/module/page_reporting/parameters/flush

Note: the set callback runs under kernel param_lock,
so writing this parameter blocks other built-in parameter
writes until the flush loop completes.  This is acceptable
for a privileged debug/test parameter.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_reporting.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 691a9e66aa5b..8b278a494ea5 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -358,6 +358,60 @@ static void page_reporting_process(struct work_struct *work)
 static DEFINE_MUTEX(page_reporting_mutex);
 DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
 
+static int page_reporting_flush_set(const char *val,
+				    const struct kernel_param *kp)
+{
+	struct page_reporting_dev_info *prdev;
+	unsigned int budget;
+	int err;
+
+	err = kstrtouint(val, 0, &budget);
+	if (err)
+		return err;
+	if (!budget)
+		return 0;
+
+	mutex_lock(&page_reporting_mutex);
+	prdev = rcu_dereference_protected(pr_dev_info,
+				lockdep_is_held(&page_reporting_mutex));
+	if (prdev) {
+		unsigned int reported;
+		bool interrupted = false;
+
+		for (reported = 0; reported < budget;
+		     reported += min(prdev->capacity, budget - reported)) {
+			/*
+			 * First flush completes any previously scheduled
+			 * reporting work.  Then request a new reporting
+			 * cycle and flush again to execute it.
+			 */
+			flush_delayed_work(&prdev->work);
+			__page_reporting_request(prdev);
+			flush_delayed_work(&prdev->work);
+			if (atomic_read(&prdev->state) == PAGE_REPORTING_IDLE)
+				break;
+			if (signal_pending(current)) {
+				interrupted = true;
+				break;
+			}
+		}
+		if (interrupted) {
+			mutex_unlock(&page_reporting_mutex);
+			return -EINTR;
+		}
+	}
+	mutex_unlock(&page_reporting_mutex);
+	return 0;
+}
+
+static const struct kernel_param_ops flush_ops = {
+	.set = page_reporting_flush_set,
+	.get = param_get_uint,
+};
+static unsigned int page_reporting_flush;
+module_param_cb(flush, &flush_ops, &page_reporting_flush, 0200);
+MODULE_PARM_DESC(flush, "Report at least N pages at page_reporting_order, or until all reported");
+
 int page_reporting_register(struct page_reporting_dev_info *prdev)
 {
 	int err = 0;
-- 
MST

