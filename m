Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB03B774F
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908070; cv=none; b=I03NhdMKWWHI8qoLlVzIYB9POrSfAacvXppn8WEwRZeXo6/Bo/W1Ro5Ty2RtfjrHVVcnKs/v5TjvVQq5miuD3V36vG0JP8HHfPmHegjMjB/NgFlT7DtgNhTVY4ZdFtZj3k75+aMGefCZYOuBHBYGlSOSecev8TUCmLC3eiF7rsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908070; c=relaxed/simple;
	bh=d4eezH+pcRDMoTex5H3SWhKAQD5cm7eZ/LyLch14vB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ss3NG0f62BWq19sByx7O4VEfXrWQLP4Os5eiKbH8htiEqRBurcsFraonEaSPeX5wcxLovYiUdMActBLNMkuQzcYzC3s/8hMDZ6VbQVy1vcSxdgjRWffxDu++USv4xogzhzwNo+hpQr934CkXPZt4IpyTsLRDufLXYwvD71p0rJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5OuZfzj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5OuZfzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AnVGJ057Et7SfWebx9lNogVowiJVkQh33o78IbbqYo=;
	b=V5OuZfzjbW/ZICMhlzbc3wndvkyQ+yqRxNhvd5mndqFBICB5BzoHCE66GeLPDJ99Ad88KR
	iCG73x7JmNzlhQIuSgaP0wR72xpej5XWppHPCX9fmmfz2g6u70QTS+MQoIGmbC+jfzAvjM
	sM9wYbm+shf2xHqWUSoV3yLBQAD1kDY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-H4C8H79DPtmX7jcNc-txng-1; Mon, 08 Jun 2026 04:41:04 -0400
X-MC-Unique: H4C8H79DPtmX7jcNc-txng-1
X-Mimecast-MFC-AGG-ID: H4C8H79DPtmX7jcNc-txng_1780908063
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef66cc579so1708212f8f.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908063; x=1781512863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AnVGJ057Et7SfWebx9lNogVowiJVkQh33o78IbbqYo=;
        b=S3ufDtpfcohdb99XipPYecG5Tyttrv7SCekH5hResWUR5MshpGauswxIONvdKeWLvy
         aJLSOD9wX+DNBgFazI2cdXkbGjjB14puQnI+OnCm6VDl9WA6TjKsnnrpGkyLOtKNvOn6
         Xxy09aPgPjiQllzs9/4sFPrs7XLX35Qlt5OfuBDldZQqruwn2wJE4102MxJC4IrZMt0i
         LAOKVVvwJyY+qhlSj0+y7hHITEwmxjqPLHQy+eg1ZNqr+1ZkKBFPY8dADr65hB61rUJQ
         OTvghF9JSk6AZUTl8QvEQJzeyD6zoPfig0Od5XbQhNbZrGHo9FkINqroW7q60taGK5+e
         N97g==
X-Forwarded-Encrypted: i=1; AFNElJ95FZ1UqCj/PMQnTvIaw4rG+KL7CEBfNVwdG4K6Op+Wh5rslsUt3Sq4a8wkMksm6kuNGKKzJghx4srsfcTWZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQmrxFGdA9jCBriDulRq1BajpzoxycystB7Z8Pf2MjyTeC04Pv
	BJXs9vGB0ABUHrc764TMa5Jkt2KBy4qAc4v87WVvk9xwL1jCgGthxYfVERgpFfuhBL81QJOIxnm
	tXVf0Ru2ITbBPXrTC3TlzlZ0PruLDcuxR6AtOlL/kOc55T+BtEtB7foLS74429lACdcKn
X-Gm-Gg: Acq92OF5G1vPkBTWC1sD1XSYDxFfN9XuohFoyXw0ggWufde3hG5HxuBSNuU8HWDApYm
	dDPFAES4IErdP1KSBtmLSF//IQyeCXb3GYAKWdXV9mjMRfgS62f0h2L20ICK4pe/2yrg3tpo9lC
	7nXGEj3S/mFrM7tIJ8c0SFl6j9B1TX6lh24Epg79JW5Effm7lNI9BssCjmGQBMRO0TpLp2lSy3P
	1kTVD0FfE5R1u3WvGXimGAkYO9NyYxp/v2xRHjVpgIPnbqeZhT8gN88fZNxwpBbuoj8DjqFYQ0x
	q/n/TUF79jnXx0eh2gY00SqY1CzYGkqSTSgOy3iCkERL7FAlXMRrAZYuCmv0UV9dyn36H3tmuzV
	8BB5PQWl6h5f1EKup5XO151I=
X-Received: by 2002:a05:6000:240f:b0:456:b23d:e57 with SMTP id ffacd0b85a97d-46030182732mr23389952f8f.0.1780908062703;
        Mon, 08 Jun 2026 01:41:02 -0700 (PDT)
X-Received: by 2002:a05:6000:240f:b0:456:b23d:e57 with SMTP id ffacd0b85a97d-46030182732mr23389854f8f.0.1780908062126;
        Mon, 08 Jun 2026 01:41:02 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm38418630f8f.31.2026.06.08.01.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:41:01 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:40:54 -0400
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
Subject: [PATCH v10 37/37] virtio_balloon: implement
 VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE
Message-ID: <fd320179bc4e66ac2574336b0a76f5a920675b7f.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: qw1UQtpmGuatvx86IFimXj4pVv2qm0tFrMCLqyvgCIQ_1780908063
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
 drivers/virtio/virtio_balloon.c     | 107 ++++++++++++++++++++++++----
 include/linux/page-flags.h          |   1 +
 include/uapi/linux/virtio_balloon.h |   1 +
 3 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index bf1172ad5419..0cd4fd06ca2d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
 #include <linux/cc_platform.h>
+#include <asm-generic/bitops/le.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -122,6 +123,13 @@ struct virtio_balloon {
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
 
+	/* No DMA alignment needed: ACCESS_PLATFORM is cleared,
+	 * so virtio bypasses the DMA API.  If this ever changes,
+	 * add ____dma_from_device_aligned here.
+	 */
+	/* Bitmap returned by host for DEVICE_INIT_ON_INFLATE */
+	DECLARE_BITMAP(inflate_bitmap, VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+
 	/* State for keeping the wakeup_source active while adjusting the balloon */
 	spinlock_t wakeup_lock;
 	bool processing_wakeup_event;
@@ -182,22 +190,33 @@ static void balloon_ack(struct virtqueue *vq)
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
 
 	/* We made sure the vq is large enough so we should always
 	 * be able to add one buffer to an empty queue.
 	 */
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
@@ -300,8 +319,37 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 
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
+					if (!test_bit_le(i + j, vb->inflate_bitmap)) {
+						zeroed = false;
+						break;
+					}
+				}
+				if (zeroed) {
+					pfn = virtio32_to_cpu(vb->vdev,
+							      vb->pfns[i]);
+					SetPageZeroed(pfn_to_page(pfn >>
+						(PAGE_SHIFT -
+						 VIRTIO_BALLOON_PFN_SHIFT)));
+				}
+			}
+		}
+	}
 	mutex_unlock(&vb->balloon_lock);
 
 	return num_allocated_pages;
@@ -314,7 +362,12 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 
 	list_for_each_entry_safe(page, next, pages, lru) {
 		list_del(&page->lru);
-		put_page(page); /* balloon reference */
+		if (PageZeroed(page)) {
+			ClearPageZeroed(page);
+			put_page_zeroed(page);
+		} else {
+			put_page(page);
+		}
 	}
 }
 
@@ -861,8 +914,27 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	/* balloon's page migration 1st step  -- inflate "newpage" */
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, newpage);
-	tell_host(vb, vb->inflate_vq);
+	{
+		unsigned int used_len = tell_host(vb, vb->inflate_vq);
 
+		if (virtio_has_feature(vb->vdev,
+				       VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE) &&
+		    used_len >= DIV_ROUND_UP(VIRTIO_BALLOON_PAGES_PER_PAGE, 8)) {
+			unsigned int j;
+			bool zeroed = true;
+
+			for (j = 0; j < VIRTIO_BALLOON_PAGES_PER_PAGE; j++) {
+				if (!test_bit_le(j, vb->inflate_bitmap)) {
+					zeroed = false;
+					break;
+				}
+			}
+			if (zeroed)
+				SetPageZeroed(newpage);
+		}
+	}
+
+	ClearPageZeroed(page);
 	/* balloon's page migration 2nd step -- deflate "page" */
 	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
 	set_page_pfns(vb, vb->pfns, page);
@@ -966,6 +1038,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
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
@@ -1191,11 +1269,15 @@ static int virtballoon_validate(struct virtio_device *vdev)
 
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
 	/*
 	 * Balloon submits 1-2 sg entries max per buffer, virtqueue
 	 * sizes are 128+.  Disable indirect descriptors to avoid
@@ -1215,6 +1297,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
 	VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED,
+	VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9365d59ac1d6..caecf0fbf0e2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -680,6 +680,7 @@ FOLIO_FLAG_FALSE(idle)
  * uses this to skip redundant zeroing in post_alloc_hook().
  */
 __PAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
+SETPAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
 CLEARPAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
 #define __PG_ZEROED (1UL << PG_zeroed)
 
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

