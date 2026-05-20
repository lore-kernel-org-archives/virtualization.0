Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6591A3C5DA6
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315803; cv=none; b=bXaasLxMgljb1dH6nrhlHfZp7+tuTd6AaaJfhwfFj8rC2CzOebyXP5aGZeYtnUw9hjo6TF7ZKStzvJM0zSIic0ggcKDtWmgX4UhX/AbFxOuF7V/KQpyDTfxWNJ46rtxxB+ObFhhN/2/seA581vFB0kh8rnyW+o/JCWLnhGCijyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315803; c=relaxed/simple;
	bh=KQP828o7Oia72X2oJuTNYtM9uBAruxIc45lg9ub3w4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QUnE9K6ar9kaYHhXCjVJWopf5oASYSSikHrzf1NZAgwU1RInKEPzxbYIdtkEbpStlhiXY4vqUkFJ3rXtXxyVBXkLXv/T5IwjHKKl0MdSA8v7q13sGS6kkZseHoWfVTEPCcHRSV9RAZyOvbNLtVdJ6GuCQtpqcrIGEU9KprL+1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LB8j++J8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LB8j++J8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kNatCmWHyttmbkexMBnMmdZ3Q708953lxRldkYnzX4=;
	b=LB8j++J8kRN7/TDR9UqB7BQ6Rq/+PwznDCN/Mix4r7my3jTxqeyCOFMF3zELmM+iR4ONj0
	37xLJzKahMwF/SWkvtQ01q2iKZt/hVEjuG/19ALeckQmEB86ptNnPQ81VkAqVcdvl8Eurz
	gpqTNLDEURiEbySk3xjw9wQ3bR0+aec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-0VHwOt5dMwawEuTIiW93og-1; Wed, 20 May 2026 18:23:19 -0400
X-MC-Unique: 0VHwOt5dMwawEuTIiW93og-1
X-Mimecast-MFC-AGG-ID: 0VHwOt5dMwawEuTIiW93og_1779315799
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fda34ed0aso21220485e9.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315799; x=1779920599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kNatCmWHyttmbkexMBnMmdZ3Q708953lxRldkYnzX4=;
        b=lRA2NnBKmuZUZ8/PoQyBnSOJsghVl6t0zt1fdxs179F5rWswbHQ4IjLIzwbhiNwZYl
         4CiI+I3skjBgV0Mxh2OCNasbwLZSf7EhNxydf7pxC4/foK16ZLh6PA58ZWz68PQZWRgx
         8v8P8Sdh2AfHeOco7M+YToSldZ4DbgC0EFxNUdczgKsl8NixmcVkUemgDWRtRhDXOy2F
         268UtSKogtqxsJbP4oufmtNeJA+pTnhjvCVjvUmm/vtIZaHmE0jXsl5+2Hb4x9Vq848N
         D5O+kTTEJA5ErggemKehZrADeJEZagpZt2xTTJqsZ39tMjzGW21qH5QepXQCNFcUeU9b
         PJ9A==
X-Forwarded-Encrypted: i=1; AFNElJ94/M/ekLIR0GnEGQpbpGlJFsOn1w56E1C90DSz2Nv03m+aEo7kMMBgYUz646w8+SNHwlYlAGgLf+omYjodOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcj2L5vrVVTYHlhZoeHV2hofewU7/dq7U5hkNsvKnaTwnANCzm
	6QtIRRWqKnIbAsWOjY6eTW+FyRevKufmOkKMw7NGnv9qx7+PLIPKmqbM9ZSDMHNVKT/IT+8u6Z1
	guYmJW4CYJ/WcBM7/fqZb4GMKBmXZUD5Au4uye4UTSdFnyeSvfgRPJ62sXzNumI+2hkgZ
X-Gm-Gg: Acq92OE9RgBMYD9wpI+GvJqkVtlle0dOx9TXuCOv0U4tqSCs5eF/RK/IbKpBtYzSfCJ
	FoYV1OrpqkysoL1FTryIuAKF0cXj9uQb8P3iH1cWPcZhruJp50keMwii7HCwoBhrIFKO4MWqcbY
	m/4wcylcc2VrNRyN7+Amk2UoMik6ZQL7ourRoJmBwjiOyFuA8V/+5o3Pq8PsqM+KlQsFD3HxQLJ
	q49OiGgfDTBO5BDObct58dT9hSEsYxHt6tG/cVUF1sZ0c6+8nSTUXMCxOd5V2e4WBgFAVxMfL35
	BOlkk61OliW1iHEf/ngYu2hFh1YYU9veBV/zVeg/ltKe7ad+C3Wn/QLY3nkfRVv0M8EuOWXWSwe
	G58LMrmUBalDxOjb4Z1895H371KlwFBClVTZyxcgqH2R7+I1G0PuApQ==
X-Received: by 2002:a05:600c:6211:b0:48f:d1b8:9aa4 with SMTP id 5b1f17b1804b1-4903604cac9mr2998375e9.7.1779315798498;
        Wed, 20 May 2026 15:23:18 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:48f:d1b8:9aa4 with SMTP id 5b1f17b1804b1-4903604cac9mr2997825e9.7.1779315797919;
        Wed, 20 May 2026 15:23:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3f0d1sm23277085e9.5.2026.05.20.15.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:17 -0700 (PDT)
Date: Wed, 20 May 2026 18:23:13 -0400
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
Subject: [PATCH v8 32/37] virtio_balloon: disable reporting zeroed
 optimization for confidential guests
Message-ID: <d6bc8e877e96b88a1418a89d1b04405ff3704ec0.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: BTCcdVoc-3szWOJuAwa8OyAfZbqOIzGt5LLAAEGC6_8_1779315799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In confidential computing environments (TDX, SEV-SNP), the host
is untrusted and may lie about zeroing reported pages. Clear
DEVICE_INIT_REPORTED in validate() so the guest does not skip
re-zeroing based on hints from an untrusted device.

Note: currently REPORTING remains enabled and
VIRTIO_F_ACCESS_PLATFORM is cleared in CC environments.
This is known to leak free page physical addresses to the
host.  Whether that, or ballooning in general, is a security
concern in CC is up to the user.  This patch only disables
our new zeroed-page hints where the host is untrusted.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e3afa6f32ba5..bf1172ad5419 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/cc_platform.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -1193,6 +1194,8 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	    !want_init_on_free())
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 	/*
 	 * Balloon submits 1-2 sg entries max per buffer, virtqueue
 	 * sizes are 128+.  Disable indirect descriptors to avoid
-- 
MST

