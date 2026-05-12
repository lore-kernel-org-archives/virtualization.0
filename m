Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2D3C0A18
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620047; cv=none; b=OXWOOqerq60Nr1CZWOG2SMGPVKZhdZ0GHCgsHc3P4yIaZHXskUxfid3gpTkgvviNU+oK/QJJ+PkdPt+Oj8SzmFUvRgXt4y0/seXsb1wsF/UnqIhve+Pkh1pC78GReY3W0slXL5VrcyA/ghseDZUiLbATWk5uEanau7kPApY8Vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620047; c=relaxed/simple;
	bh=gA+GhqYvwNlglcAAc+7safd3uN5pLfpD+OD4nI/Ceeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u/7M2Kg30Yy4x+r6Cc61kQDScMQdKi1eSNdCMaRkxABYJtt0tOsH4+s5P4XcppmXNNBGHbURJrq3/ERnnN4VQ1ERtrVAgsqpxvA+agbNLk9K23vZj+5LxOQcHPcsnofcagEBfgBSadhPmSyO5KtqfiyKbE50Y6q8Qz/fTrbzQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/XcsfQn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/XcsfQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RuTcBXOBEgIcnIT/SeHSDJKAZ2vX9yg2mawsRplntmg=;
	b=d/XcsfQn0hWhqNo2+FbUMhHplDQwwyJQ/GvoyYLzrvSOq+xVEZfAZ0bmVDxJc6NcpTJFiQ
	OfoTO87lZ+cUsBJo69kbwjOrfvN86Zp62hi4YOM5bEpyF3dS4m+KTB6AB/QzPe1YXEG42U
	1bSiFaXilb1Wa2IcOCO3nGurcuRwJrQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-rXF-Vz9NNsiC-jlPxbPdOg-1; Tue, 12 May 2026 17:07:22 -0400
X-MC-Unique: rXF-Vz9NNsiC-jlPxbPdOg-1
X-Mimecast-MFC-AGG-ID: rXF-Vz9NNsiC-jlPxbPdOg_1778620041
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso35896185e9.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620041; x=1779224841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuTcBXOBEgIcnIT/SeHSDJKAZ2vX9yg2mawsRplntmg=;
        b=q5SJCrdouAp6Gt93gXyFN3RRNzMxDrjjm/EAC0ZkqLqfcIegE+5Bi1/2KsJGjC+/sJ
         lfesFbp1RXmshbP3Zb2G7PnO+01YTrqYxPlbOZuQmKTfMJHjV7r0BjyuTxTzSce9GkH4
         YIVHGQeqpEJPk1muqQlHxAfo+tqKhnvDwThKiwwB+WEtBAuK/FAdtfsxdzwqC/G42wFj
         8LWB+03/QAVXRuvbD1RpB7wqQXIeMjDJlRjOjzc7wwyvX89HVym3UUNIjYbtZ9hG1hyX
         b7xSEBE4nZ138rYThATQUfG9KPJaK4jKcmjcdaVtUyzh6YVXwWxHFW8GZBbPcu8W4e4g
         zVYw==
X-Forwarded-Encrypted: i=1; AFNElJ+Q51curRN/SVTvyLpLKZEApzoExMPgKQ4S/8HAVyytQZlkGT88Jo8+z18ZtPDbkZFbMAmDPsBB3a2eYBUVzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzvb45V6Se+YeLl3r0jLVwk8dyqRRGVOY567eSqInuwhKNX/Ltz
	P4q5J++/M9s63j2iLRMa7L7XdWB+2v9Yzl42B45x7a2LMGiAmtRQnmIjC/yMfX2LiesU0lAN1xl
	EsAkDWWUFZZKMX0vmtsZzQEJy0u53qofEzL6uIkD+/jp/X9dN9L588wUBkZKTRyWVd9M9
X-Gm-Gg: Acq92OHq642jGC0Q7YTrHgGrc1k7t/J0HjnFkqm6NibSe6cB/BgTYXezOHghT0rhyfm
	cyCY9hY+9eT9ubhu+84zmR5uQhQGCx6pd5xwwgLImeyg5esXiPT11JXrzDFdz7MmC+DYzaEOy3x
	WXDH6edBYaOrhAykCjnq4Nx1C673RKX6CUVgJxAp0jgzIx+kP9WkQoXKky2bVG+uSQcuNJXBh6N
	5FjF9AnYJvCpcbGdpIkMM7HQfLsKqLTOBmUl6d8Pa+Q5DH6QyrRHhGb5uJymQXSWNRUyZNzhoSv
	Z5fK61MOoU9bAUGe3dpE1juSSHVP5i9I+A4fOoCF3sKwFNVkOuDIdAsT5RWX9eZ36fgyWjYBlfa
	MIvckjtTtf0ngb0LAiEAgb9ZtFplH5yQaINJqAPm1
X-Received: by 2002:a05:600c:a011:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48fc9a0e65emr6519475e9.7.1778620040984;
        Tue, 12 May 2026 14:07:20 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48fc9a0e65emr6518995e9.7.1778620040393;
        Tue, 12 May 2026 14:07:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6be40sm36486377f8f.12.2026.05.12.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:19 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:15 -0400
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
Subject: [PATCH v7 24/31] mm: page_reporting: add flush parameter with page
 budget
Message-ID: <7970645404129ef31ca7035c7d6b5ff960bf14bb.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: LpDE3rdOIjafYJbj2YBMzU2W8vq_StwJIzlUPzgDcDA_1778620041
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_reporting.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 6c957a9daeef..f4a0e27ac7fb 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -358,6 +358,48 @@ static void page_reporting_process(struct work_struct *work)
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
+
+		for (reported = 0; reported < budget;
+		     reported += prdev->capacity) {
+			flush_delayed_work(&prdev->work);
+			__page_reporting_request(prdev);
+			flush_delayed_work(&prdev->work);
+			if (atomic_read(&prdev->state) == PAGE_REPORTING_IDLE)
+				break;
+			if (signal_pending(current))
+				break;
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

