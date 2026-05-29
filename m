Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1E42E000
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068299; cv=none; b=pP+WF258ys6qn1Ci7K2+gG+ejk840N3IrtCtvXFEnimlMvdYYHbcuNxdo+I2XYo+JOwxt7BwNKCQyTQU/PTnmZ2aC3bDaEC/B0xvlzxizTRAMZhgX1+uSUiDI5XsAZt8FO7rjxjfWfgUfAfZgHe0endfEikB+lB6vyMYUqGuo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068299; c=relaxed/simple;
	bh=6BBhnidGx3LLixACksZDtaGP5p7mfI6f8MPPVr2Gwnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HKCUcexTBoCkWmygjbzq74Q0DAZZxKUUCNh0oz7B+OwM/Rin+kYD+jxPT50BjZMAXgukQJ9Uqc2RhLaVOa9Cl02L9uGMsKMAyYcDxF0iYtghfDuUVlLK80MsQan6QMVGr1/JRvwI5vCQpHDz2lqseyJ9oDihKuHKCLQSked0ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eja1pvMt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eja1pvMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+sAoCfzYzafV/AuzgTCD2HmceB0XqeceJe9byk3cHc=;
	b=Eja1pvMtErU1Q9wFY9H7hca69JtRdcByouMS2dIuolvWWXUVdsAWfQCH82AO/ArHaT3TrP
	IUfApfFmwyZPj3OHr1IwmzX3nUFswou9fxOm2BKDMscpa9GdAU2Q+XTDoMNWkajc9TWdHg
	AOgtgdfbaI25wJSBjWye/lrLgeiwBPY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-67g6134qNV-CUOJZVOTenA-1; Fri, 29 May 2026 11:24:55 -0400
X-MC-Unique: 67g6134qNV-CUOJZVOTenA-1
X-Mimecast-MFC-AGG-ID: 67g6134qNV-CUOJZVOTenA_1780068294
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490261c79fcso55625475e9.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068294; x=1780673094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+sAoCfzYzafV/AuzgTCD2HmceB0XqeceJe9byk3cHc=;
        b=pXv9jg/QHvNye9ctq1nleFbsyX6DI6zRzjnjAFlwFAOdcuwyRD3ZV9VrxvgKkL0l1h
         DPDU/GRCqmCJRP2oAY8QVAKINCB+bwtueyxDO+d0bodQTVVPfK76BY7ogsj0vZbJArdr
         Wrqfo0S7WwW1w7HW7gblx6jutXIGV7LX/BSkc6aq/KxqiF0cYg0kecMgiWMNP2s7rU3U
         8eB1AuMOZJh4aAkj9G36tlLJu4p48HHFPyOJY0R4GbePLq+v7nVxGDstdteCMULCzgY/
         Xav0VC2fBw+73+RCVHmbnycOXEmtPuW03wIb43YCXZYPbdhYOPPalGnZK9kBN2jk9bMR
         xzvA==
X-Forwarded-Encrypted: i=1; AFNElJ9+iPwAJj50cVnQ/zyQDD/PcwdtQmafwmmnx8eAJufX6t5TmQLotS1l8dfeS4e/5TbgLIDlhZpQzs2nPQoyAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7ZiobZ/p4fsG5F1RkvQbLhKm48p94FzI2Acj6PJcJt5jWsOdR
	EgQvoOTsNcjw693e+89ZF17cinNpCGWHdcrEG8kjO+aXNhvhJ2hLOF1U85lW4s7dAEcy8t4QTWA
	/1AGSWZVpN4XsabVtlIPbF4V62xZf3zCL0GkD+EUz4HgKylT4IpN5BmjUUlCmJXmfQD2F
X-Gm-Gg: Acq92OGJt/2crL2BYeJEG+pgJfZMSLTkvOwEo3LXYZkeyJCutFWHWl9lJHmZw7NMPbV
	weCnQGOnzQsXpUedoeWkBAkJ6JiDSKqmLQLGvpB1S4cQCW59ZNqSu0IXETq0MjIBIRbNdpP9YDZ
	1nqk4g9N9mmV8oqAMNNPVAE81ihL8wacoqd1d+BFJpH3FEsEAyszmZNRhb3/WlEQQghzBK5i2A6
	XzPXE0LuooPu9Oto1hRMEf1qAwikGrBZKfmaN+AyEO+dxkjhiz/0Dz0aZzzJxP8++RZ/7ET0rTz
	7aRwgkq16bebevMmytpAQGlSalOkPRVAnzxf4KhrQHe4uvtDReIXWr4DfxCN8JY1Ms1E94Tuf2X
	hmfaevfyqvbgpt64N9nIvk4rVWIkbE2rEmrmXXnYx7/IO4t9UNi9kng==
X-Received: by 2002:a05:600c:1c1b:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-4909c639d91mr48523525e9.15.1780068294302;
        Fri, 29 May 2026 08:24:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1b:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-4909c639d91mr48522645e9.15.1780068293714;
        Fri, 29 May 2026 08:24:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6575csm82033265e9.4.2026.05.29.08.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:53 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:48 -0400
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
Subject: [PATCH v9 29/37] mm: page_reporting: add flush parameter with page
 budget
Message-ID: <b40a2db51c2ac3a69219c467389165a0a53d9ac4.1780067978.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uR2BMik1lB5G8FXJ7akq4eWAOZui26dtgy3C0Cz2940_1780068294
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
index f68c79e57427..3f584f538c68 100644
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

