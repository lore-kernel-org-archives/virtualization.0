Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550462868A9
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620076; cv=none; b=Lo7Fd55IhO1iK9L8F+TQuSrf+3eRh9WbgvrVvJnXHeczjb/lc6rlayecwGSyUWi6djY7BQuf7fUtslJC1MuB3Kb7cuoXaB+MDj6SNgEmNGSrLT1akbJeECOSbp6IWy7x7YLJWAeZvAdJteashpebpdiQlm5APyHF/MAZ+p3DJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620076; c=relaxed/simple;
	bh=gbHGWi857HvIZjWQ3R4rSMwRR/yXb/rr7xrLBv+uOjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p2ZNOgl7Qs5kbcNFaB+H3Foau8jZ3JW62Q2/ku1v8C+yIeKMtQMhRjTZrVUu/MrZbpjalW0Qy1uLK/8g0+1iyU2VvNfBhz7tL8ZMd1FzU37yQE/Rxsxehq52cL+3zjmtglwm5Yy4RHFz8s2KZthl9de9eMcYkAtjJEtRLZeyM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1LIfdjj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1LIfdjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M5u/iM8du1/MGgA4/nGZcoKT5QLcOlAuJz0gbPaxdLE=;
	b=B1LIfdjjh3Dejup3jXLerFwKvsWhrRg2tLHgVNTvYRAtW0FJ6TPWLPvBNuaS5VPByxOyyo
	IZE7fnkRaC1+C2XFtfSaWWDCA6q74dAgeZV8/QwoU/ks0QMq82ESCP56n79cK+0c1768OG
	sAueehFW70HHdSqx6gQ9ZnoA5PQEUfM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-Ta8-NJPtPeK1HIfLjvf_Tg-1; Tue, 12 May 2026 17:07:53 -0400
X-MC-Unique: Ta8-NJPtPeK1HIfLjvf_Tg-1
X-Mimecast-MFC-AGG-ID: Ta8-NJPtPeK1HIfLjvf_Tg_1778620072
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so65886585e9.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620072; x=1779224872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5u/iM8du1/MGgA4/nGZcoKT5QLcOlAuJz0gbPaxdLE=;
        b=qNlibH0Akzr3ZyGQsdboSSUW+RKGVILZ19Goo1h7GlxXWkbV6SkLG/4nBqxmJGzykz
         vJlVBVlLOzN+ebQna8zjArcIxmKUu/I4L+eYGECQsNGm6mtUEDglSc6JkeLExbCElL0R
         YDVrXj79LhLhpzVD91EprUcnL524oR9WfIJmOa0E5PNZgUslIjs9ZeVYEz0+PLW50MlI
         BWiEjN/r11C48QdiekhHhLsarZ+J7jRxZm+gsGTACgNW+7/GA/zlfwnPF0ZxCRxE4jTF
         usbeDlXK7ASBUzs5so5zmug5oj6rY+m5J4+LjTFzOTvZEnJ1Ry2ZgU4vkY4z1X+14e93
         lT+w==
X-Forwarded-Encrypted: i=1; AFNElJ9zW4nRoib1vu37DgEV/RF2tMFgGhuGgz9xqfim2BhGsPCQ5xPcmBEMBgiKiQia135uOHtP/WWkFd+VKD8j3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMfxSa2UGdE/ELRmVpqy4rSOh4n3DCXEx8pSszsZXXozxRguNE
	6pmXIZZtRyn1nSCh1VrGw8YEXByQM8OkNFIGYmbjOvS8s5EP2w+yyiaby/gHaMzWNVb87MTBMFa
	UtLmzmm2BZDmrsRHCJG5PaiwGZQ+3I8VYx4unZL9BJ1Uj+Ua9QQhCusRRv2bo6kVdUdkq
X-Gm-Gg: Acq92OFfItBq8kvMuRLJh72k1eUY3e3Q76B0k4x76KdaBK6g9E0O4ibe8akhWm8QWZR
	CVE/o9FfJElBuBZ43G7d8dtTq7lrhZy4uW+IBLfxsSOIdCQsvvxxEiGQxF6+zlPVYi4eaEN+0nE
	CJxxmeJqc2SQxpDgILga7n/iNwv/4doaIivThXbDuMmvdEtD4+GpkpauawkOKbdvGys/ivGkw9l
	aMR+peJgdEmZq7Ujs1KmlcCeAxKZJXNeK8z1vmJtJCOS3qkPDbObgrxgb+oCvnywqqwOwboJrzO
	0PcsuaqqWQSs17VjfPE3AfK8I7bjMm/kGT19w8PFlRRrmYFJo1Uey+fYS3qd9Ftl9VOD07Z0FpS
	iMk4ZMv5EzrVu53yfRqmXoqyIHT/9vseX7y9cZqpK
X-Received: by 2002:a05:600c:c08e:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48fc9a5350bmr4617615e9.27.1778620072004;
        Tue, 12 May 2026 14:07:52 -0700 (PDT)
X-Received: by 2002:a05:600c:c08e:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48fc9a5350bmr4617055e9.27.1778620071492;
        Tue, 12 May 2026 14:07:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bbebdsm38944373f8f.5.2026.05.12.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:51 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:46 -0400
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
Subject: [PATCH v7 30/31] virtio_balloon: implement
 VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE
Message-ID: <3b2729a80c19e634f9bc93ca2a8baed8cd760b45.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fqheeKgqqrmu1ppyY1VBZe4TeYIakmvAoI76AA0n_0k_1778620072
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When the device offers DEVICE_INIT_ON_INFLATE (bit 7), the device
initializes inflated pages and returns a per-page bitmap indicating
which pages were successfully initialized.

The driver appends a device-writable bitmap buffer to each inflate
descriptor chain via virtqueue_add_sgs. After the host acknowledges,
the driver checks bitmap bits (bounded by used_len) and marks pages
with SetPageZeroed.

tell_host() returns used_len from virtqueue_get_buf(). Bitmap reads
are bounded: fill_balloon() and virtballoon_migratepage() only trust
bits within the used_len range.

On deflate, release_pages_balloon checks PageZeroed per page and
uses put_page_zeroed for pages the host initialized, propagating
the zeroed hint to the buddy allocator.

If inflate_vq has fewer than 2 descriptors, probe fails with
-ENOSPC. If PAGE_POISON is negotiated with non-zero poison_val,
the feature is cleared in validate().

See the virtio spec change:
https://lore.kernel.org/all/9c69b992c3dd83dfef3db92cd86b2fd8a0730d48.1777731396.git.mst@redhat.com

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c     | 102 ++++++++++++++++++++++++----
 include/uapi/linux/virtio_balloon.h |   1 +
 2 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 02d21147d4c6..f3929a238c8b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -121,6 +121,9 @@ struct virtio_balloon {
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
 
+	/* Bitmap returned by host for DEVICE_INIT_ON_INFLATE */
+	DECLARE_BITMAP(inflate_bitmap, VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+
 	/* State for keeping the wakeup_source active while adjusting the balloon */
 	spinlock_t wakeup_lock;
 	bool processing_wakeup_event;
@@ -181,20 +184,30 @@ static void balloon_ack(struct virtqueue *vq)
 	wake_up(&vb->acked);
 }
 
-static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
+static unsigned int tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 {
-	struct scatterlist sg;
+	struct scatterlist sg_out, sg_in;
+	struct scatterlist *sgs[] = { &sg_out, &sg_in };
 	unsigned int len;
 
-	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
+	sg_init_one(&sg_out, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
 
-	/* We should always be able to add one buffer to an empty queue. */
-	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
+	if (vq == vb->inflate_vq &&
+	    virtio_has_feature(vb->vdev,
+			       VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE)) {
+		unsigned int bitmap_bytes;
+
+		bitmap_bytes = DIV_ROUND_UP(vb->num_pfns, 8);
+		bitmap_zero(vb->inflate_bitmap, vb->num_pfns);
+		sg_init_one(&sg_in, vb->inflate_bitmap, bitmap_bytes);
+		virtqueue_add_sgs(vq, sgs, 1, 1, vb, GFP_KERNEL);
+	} else {
+		virtqueue_add_outbuf(vq, &sg_out, 1, vb, GFP_KERNEL);
+	}
 	virtqueue_kick(vq);
 
-	/* When host has read buffer, this completes via balloon_ack */
 	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
-
+	return len;
 }
 
 static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
@@ -297,8 +310,37 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 
 	num_allocated_pages = vb->num_pfns;
 	/* Did we get any? */
-	if (vb->num_pfns != 0)
-		tell_host(vb, vb->inflate_vq);
+	if (vb->num_pfns != 0) {
+		unsigned int used_len = tell_host(vb, vb->inflate_vq);
+
+		if (virtio_has_feature(vb->vdev,
+				       VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE)) {
+			unsigned int i;
+			unsigned int valid_bits = used_len * 8;
+
+			for (i = 0; i < vb->num_pfns;
+			     i += VIRTIO_BALLOON_PAGES_PER_PAGE) {
+				unsigned int pfn, j;
+				bool zeroed = true;
+
+				if (i + VIRTIO_BALLOON_PAGES_PER_PAGE > valid_bits)
+					break;
+				for (j = 0; j < VIRTIO_BALLOON_PAGES_PER_PAGE; j++) {
+					if (!test_bit(i + j, vb->inflate_bitmap)) {
+						zeroed = false;
+						break;
+					}
+				}
+				if (zeroed) {
+					pfn = virtio32_to_cpu(vb->vdev,
+							      vb->pfns[i]);
+					__SetPageZeroed(pfn_to_page(pfn >>
+						(PAGE_SHIFT -
+						 VIRTIO_BALLOON_PFN_SHIFT)));
+				}
+			}
+		}
+	}
 	mutex_unlock(&vb->balloon_lock);
 
 	return num_allocated_pages;
@@ -311,7 +353,12 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 
 	list_for_each_entry_safe(page, next, pages, lru) {
 		list_del(&page->lru);
-		put_page(page); /* balloon reference */
+		if (PageZeroed(page)) {
+			__ClearPageZeroed(page);
+			put_page_zeroed(page);
+		} else {
+			put_page(page);
+		}
 	}
 }
 
@@ -858,7 +905,25 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	/* balloon's page migration 1st step  -- inflate "newpage" */
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, newpage);
-	tell_host(vb, vb->inflate_vq);
+	{
+		unsigned int used_len = tell_host(vb, vb->inflate_vq);
+
+		if (virtio_has_feature(vb->vdev,
+				       VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE) &&
+		    used_len >= DIV_ROUND_UP(VIRTIO_BALLOON_PAGES_PER_PAGE, 8)) {
+			unsigned int j;
+			bool zeroed = true;
+
+			for (j = 0; j < VIRTIO_BALLOON_PAGES_PER_PAGE; j++) {
+				if (!test_bit(j, vb->inflate_bitmap)) {
+					zeroed = false;
+					break;
+				}
+			}
+			if (zeroed)
+				__SetPageZeroed(newpage);
+		}
+	}
 
 	/* balloon's page migration 2nd step -- deflate "page" */
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
@@ -963,6 +1028,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_free_vb;
 
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE) &&
+	    virtqueue_get_vring_size(vb->inflate_vq) < 2) {
+		err = -ENOSPC;
+		goto out_del_vqs;
+	}
+
 	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		vb->vb_dev_info.adjust_managed_page_count = true;
 #ifdef CONFIG_BALLOON_MIGRATION
@@ -1188,11 +1259,15 @@ static int virtballoon_validate(struct virtio_device *vdev)
 
 	/* Device fills with poison_val, not zeros; disable zeroed hint */
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON) &&
-	    !want_init_on_free())
+	    !want_init_on_free()) {
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE);
+	}
 
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE);
+	}
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
@@ -1205,6 +1280,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
 	VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED,
+	VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 13074631f300..cbaf18e0b17c 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -38,6 +38,7 @@
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
 #define VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED	6 /* Device initializes reported pages */
+#define VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE	7 /* Device initializes pages on inflate */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
MST

