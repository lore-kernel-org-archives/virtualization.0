Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842F3B52F8
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908037; cv=none; b=kfvWXxZpro9OL2PTcL718ZsVvYrOV85rmZeE1o5gWIHTRrdSMnWot5i5EXMSec48q9D/kMArAQMrxfiPAeycunoqX3SZhEcYhoDz2wD4Ip6e6okUpIhP3NiaJ5j8JtgODyghtU4Mf4uXtUY1psnC28sRsJWLY6bKezgwB31tpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908037; c=relaxed/simple;
	bh=o1q520LUtIf3WEFA+mnt5VZVOCpKdiGNtHAvZKuDwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rxQCOE83cvqovWDcZ1aKPVKAc/bVTzvUgTpk+dxqDOk+5aWTTmi4d2O0gicptMWftSEjLcjO6CeCdVxk/nteCcvlB/9hZ22SOItU2s7QpXaotfuxdikR5tTObMm0BQpvwAufTL8XCB/mgx7eHvs8rkio+YHubFXRgP6nKZ+XVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VklWNvhP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VklWNvhP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhUe/N+eFNvMvlBoMUh1oQQhfmsYB8gjnR/tug0hsFs=;
	b=VklWNvhPu9CSUjsnq+gXCU1G1Fhzvp4WVf3Bbk4kU8zRSSkGG2B9HLnrSeDcBtGpOjghBE
	ZUDFR4ZwT42OT53uz9/XRkX58p/JG7l06dBfexL1UMbNAKNLuhTyCGPVNWv72YaXhV4UAf
	AHRETOrIysMJ/xZ3h7/d8NilHWRBhqM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-ynbfh3C2MdSRkl6M-hvOzQ-1; Mon, 08 Jun 2026 04:40:32 -0400
X-MC-Unique: ynbfh3C2MdSRkl6M-hvOzQ-1
X-Mimecast-MFC-AGG-ID: ynbfh3C2MdSRkl6M-hvOzQ_1780908031
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b61243easo21776825e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908031; x=1781512831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhUe/N+eFNvMvlBoMUh1oQQhfmsYB8gjnR/tug0hsFs=;
        b=o23cojbGAWQ8OMocwx5HzN1FdyE3INBLb6yrQhan5EQc2W1mscrDl4O+vwy+ZpRUjF
         NxJrtysSpv5ViOsqPqrn4sBE0/HsnYla7gI3Opw2/fX6lNAvhHhy+98p/4jov2FVRnue
         5QHtRLoXhJmcXJSced6WG90JOyAUSKHy2UwOZCqXYF/F1NGpfX6Ih/3c5QwjmMAJty0M
         dtbEKeU5Lch3kJCmgV6fLCnmQ0XKe30SrRx2As9Cq3uEJoBmQkNdfQaZPt9L15NOzURT
         /YVOXRqV8+u2xyjLtIC4p+68nLNFYtAYDHFf+FVimJFekvU4NkfK6llt9zR9ff11MHw4
         N/kg==
X-Forwarded-Encrypted: i=1; AFNElJ+xLPmRJCWs/Q7Ca5P0iYnKr4eN/apPIHaeCwLFSRemWYEAdCIGe7b+m1ZPdCkST3pIbOhHtkcJj2m826KlvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwirL7NiBr1cT6jqF+6LPa5SLvO4+pJC8a1ppFVkIh6yVzJQsrg
	kmgIrU75VnZbCRE2FVrl7cmQc5AQxu19+fVW51qdwK6ErP9ncgAPh2Gs72BcA99xrd3PJHaIHK+
	w66iordYnSAGR+u55kdmrNpbK6LEQAcUIoka06ASHHqhtmSDSe+F3aOdh/gRV4vUBXcBy
X-Gm-Gg: Acq92OFZOHetZniGpH9jFY8l7iTLnvqgsENQifjLIvXkoyaf8HB4dB1FMiiH6ySRhV3
	qBl0WaBE7dRbl4WuxtTz3j1LXDPRvn5f90wcu6O3vm5rn5LQP7IcJ9660+iOmOPXVZtHZujJ1Kh
	Nb1X0fHSvI+Wv7sxhjfiYOQIZVhuQt/fcNzcDULyPSWmlBxUy4FPRc6nZ86Z2RRc+grY42NHBJh
	jqWe5Gv98nYuuaoWt1DZBNtn/LP6K3WE620w9H8IZwlwYgxkeKXTlnKZx/lrlqOc7bbdk3hvct8
	OXrXZLz/yy8RJ0u8QiloMqMeA9WXqeyWq3DZkIF/6PQqPmFVzOzxYjmI+DqyRGDjpGRi+ts0SOU
	pq448bnPVprU/Xtk2nXBEkBo=
X-Received: by 2002:a05:600c:620b:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490c25cf45bmr250655995e9.28.1780908030799;
        Mon, 08 Jun 2026 01:40:30 -0700 (PDT)
X-Received: by 2002:a05:600c:620b:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490c25cf45bmr250655175e9.28.1780908030307;
        Mon, 08 Jun 2026 01:40:30 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm53227082f8f.6.2026.06.08.01.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:40:29 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:40:21 -0400
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
Subject: [PATCH v10 34/37] virtio_balloon: skip zeroing for host-zeroed
 reported pages
Message-ID: <4276165a2f7a1f8314341f639f2d9663808d7bd8.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: tyF0Xwj9AJ3qWUSLVcqY0S4cWdpz34qWCcxqqZwttxQ_1780908031
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Implement VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED (per virtio spec
proposal): when negotiated, the device initializes reported pages
(zeros, or poison_val if PAGE_POISON).

Check per-page used length returned by the device to determine
which reported pages were zeroed. If used_len matches the page
size, the device successfully initialized the page (e.g. via
MADV_DONTNEED), and we set the corresponding zeroed_bitmap bit.

Gate host_zeroes_pages on the feature bit and page content:
when PAGE_POISON is negotiated with non-zero poison_val, the
device fills with poison not zeros, so pages are not zeroed.

Clear the feature in validate() if REPORTING is not present
or if PAGE_POISON is active with non-zero poison_val.

See the virtio spec change:
https://github.com/oasis-tcs/virtio-spec/issues/244

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c     | 22 ++++++++++++++++++++--
 include/uapi/linux/virtio_balloon.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fa1c7fa285f..e3afa6f32ba5 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -207,6 +207,8 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtqueue *vq = vb->reporting_vq;
 	unsigned int i, err = 0;
 
+	bitmap_zero(pr_dev_info->zeroed_bitmap, nents);
+
 	/* We should always be able to add these buffers to an empty queue. */
 	for (i = 0; i < nents; i++) {
 		struct scatterlist one;
@@ -226,10 +228,14 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 
 		/* When host has read buffer, this completes via balloon_ack */
 		for (i = 0; i < nents; i++) {
-			unsigned int unused;
+			struct scatterlist *entry;
+			unsigned int used_len;
 
 			wait_event(vb->acked,
-				   virtqueue_get_buf(vq, &unused));
+				   (entry = virtqueue_get_buf(vq, &used_len)));
+			if (used_len == entry->length)
+				set_bit(entry - sg,
+					pr_dev_info->zeroed_bitmap);
 		}
 	}
 
@@ -1051,6 +1057,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 #endif
 
 		vb->pr_dev_info.capacity = capacity;
+		vb->pr_dev_info.host_zeroes_pages =
+			virtio_has_feature(vdev,
+					   VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
@@ -1176,6 +1185,14 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
+
+	/* Device fills with poison_val, not zeros; disable zeroed hint */
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON) &&
+	    !want_init_on_free())
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
+
 	/*
 	 * Balloon submits 1-2 sg entries max per buffer, virtqueue
 	 * sizes are 128+.  Disable indirect descriptors to avoid
@@ -1194,6 +1211,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ee35a372805d..13074631f300 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED	6 /* Device initializes reported pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
MST

