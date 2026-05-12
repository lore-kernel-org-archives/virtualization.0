Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCE3C8199
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620058; cv=none; b=QMu3T+54QM4R03au0zZfaamEg7hPqTxTgdwkyzn2z9Ie7UbngwwMRDCsQEXD5a0KSzGEODKYw7Z9UfZnQ0Klh1IcoyyDYMNvIEtbLlfuuz63x25avl7N3EDhD26QjvJtmkL1ZljREkZyc5AERpL+MXKke6/LtkIIGewutkmj64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620058; c=relaxed/simple;
	bh=rB0kVuhS6FNGgugvmVFgpcyoiK50boSLb3yg8KWs/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R3cqYsXznMLK/tBAQDHl1mIauNPVX9TzTZzbXFo49M2dxLQh+elsnUVUXe5vK4Ep0Ken9R0l8m5McE7o6qH6vMBHY0eWFsFN+DkNR0v2jayMA+rq4iHTWYp792z2Y/EQ+hwe7O80KphZ9zi+i81h+t3LR4lQ/zvWykEbYekp3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPKMHFzR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPKMHFzR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FdwmuXhJZ1tztt+MOga5Lk/KutygLpMr1MIyeSBc//s=;
	b=DPKMHFzRlkSzy3z6gjcDQ4+FN9tmSgPeZ+JTPZx/cHrGt+oChcP3qcFZgWubidvs+zBcks
	OeaVIKhcv04EeplQFg/CdIrGr76Xy3xGLiWk2zWcZHPY6DD1RPUBYBSlBmilX23tC3AQXx
	8JOYNqlDgv+NNz4vBy38CN/Mo9vPxXM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Si2etqyKMR2O5Ks5gc-BZw-1; Tue, 12 May 2026 17:07:34 -0400
X-MC-Unique: Si2etqyKMR2O5Ks5gc-BZw-1
X-Mimecast-MFC-AGG-ID: Si2etqyKMR2O5Ks5gc-BZw_1778620053
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso5499690f8f.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620051; x=1779224851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdwmuXhJZ1tztt+MOga5Lk/KutygLpMr1MIyeSBc//s=;
        b=bBIlEkt+rzl7ug5WhJE1vCzKuOaUA8ClJHr6xfNlm6ARfZ6hJ8+FaVW5lNKI1d4QPt
         SjAvNd+cszrBg1c/eyLvbWJkGhLALTh6r4oAraC2THvkGJZd9YJDUTJzk+Xmsy+Ca7oA
         FZdpoYckrG01GWb6d8dO2M5fC4usPVTK+nphUR8xAhbW4VQBu8pxvisKoZxRGKLEn0dq
         zVo3NCCIpipMehe7pEXqKjRFsBZQcUWXjg1VRGcfFGfIQoa57w4qhQRi3UrZbgl7W7Os
         tCUfVAP0/tl9HDbsPBDRdfV9IxfgOyWLuJsm14UL6ZvoYKB4+QGuNraFZE+XnBo6P0GN
         /zzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9r+OJrlvYtXUKmcN0E9VVVaFkNtTfdsZhbFonwUskjPKFg0oUxgQdyK4Sog6d1nn4Sjx1BNPxlSHOec6pBMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoNDMI0IRSGoLZfbTkKPUl+8j7nPpX5hBU4gDvvrgUoKxeIARW
	EIqLkRh/TLlKZjPOektpqn+a96uArzL3LKOI8lB6/xSppZSoy0HAzHH3kA+aarpd8vSnLJUNo+e
	deWQQ+0Lqcd19VByv+vWlcragsH5FBVDBBt9kPprryyV1G2xAQWSmEvAK3+Ev97k6pv3P
X-Gm-Gg: Acq92OEsBIfdczbD3hkM8xV9+qF4gBXAvJ9ZrTXK2K40IZOqEtqQGccs+Au6Cg1QoYy
	KHIn8kra66lXJh6c5zQxxRqKg5FVEiG4k9yjcSv3bB79YcKR/1BSAur0Dg5WiECNlK7dO3gRmS7
	+/RKhBIaUzNBeicMpeZOn0nL5KXvY69MUE0LxqQ+rshajWGVsEdJXTzH/2sNlhGgZYwehwxVcRN
	rP0HgeTBGTQknZRpi1pFqj5yElfLFxm35v/t3MKcmY09tBh707jUhcctSQd2EOD6hqsV3sLdOtS
	A9WPFfsMXBFj/65nifcT3bS3F+xuwd7yUzVYxOqTMhwEgynLgKATBnkyQIh1PWf6uzQGaWO1CaP
	40W0qV36UFxwI+LNML5gHT1zJW5AuX+8Aof/XV8ui
X-Received: by 2002:a05:600c:3111:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48fc9a0b778mr6278965e9.8.1778620051233;
        Tue, 12 May 2026 14:07:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3111:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48fc9a0b778mr6278315e9.8.1778620050644;
        Tue, 12 May 2026 14:07:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm35649963f8f.26.2026.05.12.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:30 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:25 -0400
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
Subject: [PATCH v7 26/31] virtio_balloon: skip zeroing for host-zeroed
 reported pages
Message-ID: <73b896d7fc1b4bb6127f234f5e1964d2764cbf9a.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: M8vLFg_bpgippnbTN1Umiv4IZras6uh-3yQ6ArDo9fM_1778620053
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
index fc43d0d7bbbc..6586699396b7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -204,6 +204,8 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtqueue *vq = vb->reporting_vq;
 	unsigned int i, err = 0;
 
+	bitmap_zero(pr_dev_info->zeroed_bitmap, nents);
+
 	/* We should always be able to add these buffers to an empty queue. */
 	for (i = 0; i < nents; i++) {
 		struct scatterlist one;
@@ -223,10 +225,14 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 
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
 
@@ -1048,6 +1054,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 #endif
 
 		vb->pr_dev_info.capacity = capacity;
+		vb->pr_dev_info.host_zeroes_pages =
+			virtio_has_feature(vdev,
+					   VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
@@ -1173,6 +1182,14 @@ static int virtballoon_validate(struct virtio_device *vdev)
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
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
@@ -1184,6 +1201,7 @@ static unsigned int features[] = {
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

