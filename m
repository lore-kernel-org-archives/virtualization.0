Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2742E014
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068297; cv=none; b=CJEaB611m/JVHzYcYI8Ulhn1iXHjwDhdwq0Kwuy+m41kGRcTAcPn7O3KfNG/kyRX37UaHZgcCVekRzqRF2wrWd1NpOPIF0JXfcnQSYAuWGf5RKemmPKSzntVqrgnxfHxSEZHJ/uSUueyHmwSLhrG3ncg+pR4hUtR95Y04gPR6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068297; c=relaxed/simple;
	bh=CCqjoUNUurzYE4twri0CPtkeKv57rqlJVdiWTN8T65w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UafSML2r8r5LzfyBEWUjFLG5ua/GGO2FKFXV3/1aicySdiCpsNbSwPgWK1acJiFc9YuSIzS6ZSu5MkuCwgcnPO0hUYGMgYChC9W+p0EvFqrFtWDEP6Hul2hDXfhTRq3FOwgOYth7Yj34J1JgPRLo9OYN37FH1dJ0kcCtzvupFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhWprZFj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhWprZFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnDpUYDWGGzhd8LJgVzrd2lW64WfRqjlcwd6dZFOBgQ=;
	b=BhWprZFjOgbZzBTqCSjNWkV8GlvINYxmnaXYx/ETpALhCeHN7KuoFaTGvl19QmYGkkbBvP
	c79bE66DtEi6TlTd7sRdFG4nBjVvrZJpXZ8vQ6Le4SLUoq9ZT2XwyBaOFM9cyPtbfPl7Aw
	Qw/ypSsdgU8aNigcSOlAd19rz7Xz/7U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-DaWT94upOQq3u-W3IYePhQ-1; Fri, 29 May 2026 11:24:50 -0400
X-MC-Unique: DaWT94upOQq3u-W3IYePhQ-1
X-Mimecast-MFC-AGG-ID: DaWT94upOQq3u-W3IYePhQ_1780068289
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef63d1214so173674f8f.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068289; x=1780673089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnDpUYDWGGzhd8LJgVzrd2lW64WfRqjlcwd6dZFOBgQ=;
        b=pcJ3HIoG4kBkk+OPzgF8368NNWwZkgbr4X7TZpCuGPqAm3F47UV1vSJhGhrmenf090
         NAuIN0JCfIvetKU6h/5EyPNMC5HgMgrO+XuMOspSkVZGCA30EUQXBqbgRzliEH3LSbYI
         C6VCo7+jjVFryFf6ut0cAx6uYpc08+wD+UVEOhksOpwZACH2WTQ1YxaXpSndgHS1QZXM
         mSVOs7BFnfA0++DzbvHzg53DcASKwKXkMMmjYlW1FlkpERpON51n+wXgRch4OCkNiyRt
         ekQl0lo52JjXxtrU9xSg5TKiTW1m/tJKHHLD5C+HGeskHsLM1GEQ/H1VG6BB+FQKRlw0
         IOsg==
X-Forwarded-Encrypted: i=1; AFNElJ/SxyvZAzLDqC+99vHvww7lXLLWZxMiUypYjxHEYiNF3fwGATptMsj+GqM2t2FPLw8JCvsJra/yWjkyQ1WBpw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6W4d4L98WxFroeMd/pwynMi2rVE1Q0P4oauqAC5d9tI2HLy82
	27zF4Alp+OqWutN1BLYC4CFC1J/uEGhGTvGrRPX0d8Ay1ExIhEC8kkf/84ZxyQ9tiYX4UL44oU8
	/0Qpylgn4aHCdCnR+6Y4bXoaEjU0pcDEf656ZX0NzfUwtVn29H+yMRZFLRViNVE9hSO09
X-Gm-Gg: Acq92OHvkr8d/Vcnu4ReyagsqlyzOHZE9I8vDOpZZlbjBocBIw4a7/pVpHo6YlRNqrE
	DoF0HrmA0bjs4RbIXF9e3m7exyJUuz3HasPXLOsIMJALsphtQNHfGteFW53a7mtrc3kbx6MlufQ
	DGpIrvH83F4cuo4yGyNarceDY8toWI49PGqCQVZoOWs9LKbGOmcvFsu9KrTQxrRo0bzYHPV6eTq
	yJckapWpa/pzON+5dBexlHQJNP/ZDOqiW+T8PCYgbD5O/SU8J7SdgHMWdkA+/hFLsrTPiQuLVkk
	CVFVH18dmeEp6k2+xVTI5me18IZSo7tYRFZOEyj/pMZJXV7BiCTqk8H+2Mb1KUi1Fxg9JNfZemI
	0h2F8EwiJvvXsUBV1KFHMjHpyfCX04m80V1qDLK2XMZH7Ab/GdDLeQw==
X-Received: by 2002:a05:6000:549:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-45ef6b816bemr370767f8f.33.1780068289179;
        Fri, 29 May 2026 08:24:49 -0700 (PDT)
X-Received: by 2002:a05:6000:549:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-45ef6b816bemr370703f8f.33.1780068288597;
        Fri, 29 May 2026 08:24:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm3964455f8f.19.2026.05.29.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:48 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:43 -0400
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
Subject: [PATCH v9 28/37] virtio_balloon: disable indirect descriptors
Message-ID: <ad0815b54ab89dae959fd8fe48ecbac429f8378a.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: F58A4y5m-duMw2nIa5x4MI6G9mWfW9bRiioxOm1Tg0E_1780068289
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

