Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4D3C3BE2
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908021; cv=none; b=ohNlx89CiXwIyotB0kAqq+Abu2vayvme4rljoASq1Wf5zsNfDOZBKqB0JJw9l/loyqIhpVePRvczw1tVErmse1TCXEtg1+W28Op5eXk+jjQKLZ5h0YxDtpd77GCE7m4s0EV9wVbMKq/JOwk4nVbgMzkFHl339aJF6ncDZSLcWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908021; c=relaxed/simple;
	bh=CCqjoUNUurzYE4twri0CPtkeKv57rqlJVdiWTN8T65w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VM00dTaqsGvTQFXlRbk41xTd2LLdO2Uw1t9KFPF8TQWaWEiBCcaGwLjZPLh68cJVAwYCKcnFdmNwTGPLqT74F/y5DHTKAc5hBF5UducaPdFXtDezMUdzs1cTh3JbEaVEz5LHC/IgUr7R4IAo5RQxZ0IfJqJo7BAjLYtot39P0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QldVZBaJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QldVZBaJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnDpUYDWGGzhd8LJgVzrd2lW64WfRqjlcwd6dZFOBgQ=;
	b=QldVZBaJW9qH4fGs0kK3Tcp55BLX60b95nXpBgalgOQ9bhz5iCgUch1VtndDkYI+Ux/hus
	BeHDi90FySybEOMHocIAMjai/5tKnInCE/E96t5VvznhNTkKPLjKmy7zKqL/kmn4td7hFV
	TLMGB64IaTRh/bTc8XnYY4oqA7Mw7Zg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Yq8sDQrTPeKybAPGT7Wcug-1; Mon, 08 Jun 2026 04:40:15 -0400
X-MC-Unique: Yq8sDQrTPeKybAPGT7Wcug-1
X-Mimecast-MFC-AGG-ID: Yq8sDQrTPeKybAPGT7Wcug_1780908015
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso1946527f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908014; x=1781512814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnDpUYDWGGzhd8LJgVzrd2lW64WfRqjlcwd6dZFOBgQ=;
        b=YnlHc7oQlrdPOkRIHy9q0afXE4d6S97BQXvBbfA7bMHx5BdYPZvh8vNlHUrQCVd91d
         UT2Hm1o2u/Ct1wMAf65gBnyuumeXaOFL1j7V6dzc2YSvNsk+mWsUwcDwUvXaM57H04F4
         hQzTn/+DN6GZp4WeL7K5PZXCgQkQ7Y9iqN/eEG2mTquQB68F+Pp9yL/ehHLqRvvF2mqI
         rz2bKkmHvv9+JWK8IuvcES6pHrxpGk/9tXazXzBzx9QGKb/6vJuO5ptaBQ9d3bxgYhS1
         sZW1gUInPGF/vcrx1R6bX6Eqmzlv14Hz7K4kfq59iP9rqKCPhaEI/f+e4eRHspvnPnVj
         sWqA==
X-Forwarded-Encrypted: i=1; AFNElJ8HdywUPHiIQEg8VFwicxEd/9aqHfY/NILSWSn18C7ftbeGNpqU0U6qEvx3K34mWm4OF+smtJOgEo6ZSQ7yWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo8nmEVnxOemGhxnFgwUGEEI6OjZeG1BNuTBz0rdJDf70pRzGh
	oYEerZfSAvtCuH1/Y7Fpbe4c9+RXv9xxU1dilu70d0vQIoQw0Fr+UIttnDU/G3JpkpgZToUDJUo
	CAM2USk2sHyVEjac1IeeptXCVGJUO5dAcGxqefkvkNn0if0j6t2GzZCMH6dV/2qXq+9xG
X-Gm-Gg: Acq92OGUW1I310R4hazayOuIySuLvv+7Fml39apqJxSiXnT9rmutmTvZEf7GuMyTWMR
	IAiVPvfHeePTWk/uCLd6qfHJ8pBZuP6w+tEY7vdt020BEO3m+E0ZzCmwin/F+oQc/Q7sUwi6AGU
	8TdIRGdW+lJR1DY5/qZU/qfNV9h4YZYR/goP6133a4Q8iiiQmg/7oVDNS7uUQER1SBhxYSHGwfm
	gbC4pDMhIfzvQmYlLwd379UjK7Tz+tJtgd5sOG4wHf1Bi9mETqrmy6FaeBivll3bcVqBQmqSe1D
	Iv9UwrOHEKDH7nokzDLprt5sN8JTSY6r3KvL8BPgJw6Nwf5mHZFSTgEHBdJQvqNsu0qaMe1SHQ7
	9LZ8SKVwnaa1ZxnZbRjLIy7Y=
X-Received: by 2002:adf:f2cf:0:b0:460:e00:1213 with SMTP id ffacd0b85a97d-46030502efamr17987049f8f.23.1780908014362;
        Mon, 08 Jun 2026 01:40:14 -0700 (PDT)
X-Received: by 2002:adf:f2cf:0:b0:460:e00:1213 with SMTP id ffacd0b85a97d-46030502efamr17987021f8f.23.1780908013858;
        Mon, 08 Jun 2026 01:40:13 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm49706045f8f.21.2026.06.08.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:40:13 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:40:05 -0400
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
Subject: [PATCH v10 32/37] virtio_balloon: disable indirect descriptors
Message-ID: <3c48b12a88c03c9cf9ac2c7abaffbb8aedd470d9.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9yyzk9v4m-dsJRlkZag1o5U4aJ80ZHDCaL7YOk5sgvY_1780908015
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A follow-up patch (DEVICE_INIT_ON_INFLATE) adds an inbuf
(bitmap) alongside the outbuf (pfns), making total_sg=2.
With INDIRECT_DESC negotiated, virtqueue_use_indirect()
triggers for total_sg > 1.  Balloon never needs more than
2 entries and virtqueue sizes are 128+, so indirect
descriptors are unnecessary.

Disabling them avoids a GFP_KERNEL allocation inside
virtqueue_add_sgs when VIRTIO_RING_F_INDIRECT_DESC is negotiated.
This allocation could trigger OOM reclaim while balloon_lock is
held, leading to a deadlock: OOM notifier -> leak_balloon ->
balloon_lock.

With single-buffer submissions (previous patch) and no indirect
descriptors, virtqueue_add never allocates memory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 53b4a3984e7d..1fa1c7fa285f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/virtio.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
 #include <linux/workqueue.h>
@@ -1175,6 +1176,13 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	/*
+	 * Balloon submits 1-2 sg entries max per buffer, virtqueue
+	 * sizes are 128+.  Disable indirect descriptors to avoid
+	 * GFP_KERNEL allocation in virtqueue_add under balloon_lock,
+	 * which could deadlock via OOM -> oom_notify -> leak_balloon.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_RING_F_INDIRECT_DESC);
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
-- 
MST

