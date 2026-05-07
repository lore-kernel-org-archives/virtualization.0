Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F543A9DB3
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192628; cv=none; b=pCMUMrvsrMoWJjFaQuFubq9Ij2Els6oDZTzMKR3PK4ENyxvsS0Dxw695qE7fjvH/c/IjecIahveiP6+bw1BWuVXwppxoZ5c4hhbbw43SoKUgzkNgRAkHzxoUi+d4nP4wkEgvkgHcuZTHCpOlmbwymmlpTCrjWFcK9bE3hva07T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192628; c=relaxed/simple;
	bh=qVMVxmVny/cl+4bAkcimdBPo6tV/J+GAvcnleNWWJIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nXZVrDuj/t4uZ6wgW/pcoWVOhHWfsOdLGy+i8uOlC/krgb/phqICPz5PyfzBI8uiClavTGQPV5T8qhTkT8Vxnj2qx3RW+Oew8HLxyqMXKU/aU1pRkolVDaPjtjSh/FcUeX+hcid+NOI1KsolfIXRFCmE2u8Rf5T0yvJwryFUM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuK/vEeV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuK/vEeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778192622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Si0dv8bSUlUiRXwl4HtcwIXYc0lxxBk3yMuAVuTy5o=;
	b=AuK/vEeVWiR4u9WComEffEQzf4LbzjQ8p+/QuRB1sfabuLk4W0mTPZouBlD7280k2LeESh
	cSNAeqkOprx1dvcVfhyr+pT2jd5bC/PPa7PhRk1+i9rLwfBNssGVbHsSmOu9BWt+56R/p3
	jklfrhjN07+B1ZdMb/aE9slqbS7aIP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-3wLZnuViMBKdxVp-b0bwZg-1; Thu, 07 May 2026 18:23:41 -0400
X-MC-Unique: 3wLZnuViMBKdxVp-b0bwZg-1
X-Mimecast-MFC-AGG-ID: 3wLZnuViMBKdxVp-b0bwZg_1778192620
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so922429f8f.1
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 15:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192620; x=1778797420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Si0dv8bSUlUiRXwl4HtcwIXYc0lxxBk3yMuAVuTy5o=;
        b=V+zwtuuf7Mkm9d6QYoEb/pRAmLmFsqyqV50XChbxLJxc0L85QSfKZgkayLxjyMSOLp
         eznu85T6pEbtVHBtPed/i2n6R0gtzDF4tCoGJwDZPLM7oWxOETzgu/CItwdUgvAjRC6G
         b2b8s7vThw7kqEuObdsxJlMXYQuJ0YyB7XoLwbwWt2QM+QRz5GlwTyaI47mkuoVoIL+x
         s3WDSG0If5u12B1kouvSaMVtn8kmqhuR7N+TTFJQsL4NlUJCZ9r/kZs7K1yo0Mt8kgaD
         bZZmg+JzYDKkS7cahoim6L0W4EK4YY8E+EkSyHLon0tyR0y0CxuTnj035eXUBY+XWK4V
         W6uA==
X-Forwarded-Encrypted: i=1; AFNElJ+3p7Wyh6QwLafaT1FgnYDzblThYf9yL+QJrCfvT4EWXBp8WS5KEIe/UUybuj7++rylabDMTKkLRS4n2I1DNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUbby1i2fT659jVvvsJf1AiO0iWpGwiYIunett5OGMmofz4nhx
	5N5aeeeCrC1KMqqUUJgXgoryvYabGm5kLiBq76D6DRcWPt+vZhC56XClPL8bz57X+pW6cGGMBE2
	wjgAcqYot3JPGuwv8rTMGrBVTr/+8AmATUbNBp+lgrfCGl/6OYQrsVIqbrbnlBevYq8iv
X-Gm-Gg: AeBDiesbS9AY40CyVYdS6WTcAGsvKbO19KcoKpKELiMWZqhU3Sgcu/PnstcH++5f9hT
	e90LHHyFglmwKI8rEVfb7aCx8yqc+LSRHi1TvQGgIs4GXoYTjnE6zQN+/xw6CLpFAfYoux8Wm9l
	/w81lIqBDOv4TaC9AFfOqMgscfJ9niV19WHYevh5bPsh37JwXdQ9lfkS1CAsBSIaFe6FnUGuG+3
	1RFdxevdikkOLgEgTZloS4zLBRDrcpEzN9dbjDQz0DsWZ3kepkXgkJCZCcVe08akTl/Smdg/HlM
	UYyPt180K4AqeFwZtWZb8gTEHck2EbcPBN7oreZ+xMcM0tq+bb3X7auRaF8Tt9nc/XIhFyAPUcA
	RqU2DHiZbO6wIMfQnn23FibiZhJIQrwLMvAwZiibk7CAWfNQKXGU=
X-Received: by 2002:a05:600c:4881:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48e51e0a697mr100906345e9.1.1778192620308;
        Thu, 07 May 2026 15:23:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4881:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48e51e0a697mr100906125e9.1.1778192619693;
        Thu, 07 May 2026 15:23:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e67455581sm2917475e9.4.2026.05.07.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:23:39 -0700 (PDT)
Date: Thu, 7 May 2026 18:23:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v5 25/28] virtio_balloon: implement
 VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE
Message-ID: <c8133a56ee8a4e02c1888bfbc9529cf21e21921b.1778192416.git.mst@redhat.com>
References: <cover.1778192416.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778192416.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RRv13K_2ZTDSiBkn98HQ-7AyS7xGd1nuqwrhG9VTYpY_1778192620
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

If inflate_vq has fewer than 2 descriptors, the feature is
cleared at probe time. If PAGE_POISON is negotiated with non-zero
poison_val, the feature is cleared in validate().

See the virtio spec change:
https://lore.kernel.org/all/9c69b992c3dd83dfef3db92cd86b2fd8a0730d48.1777731396.git.mst@redhat.com

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c     | 97 +++++++++++++++++++++++++----
 include/uapi/linux/virtio_balloon.h |  1 +
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e99ffbbdd2bd..708b0c344ae9 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -120,6 +120,9 @@ struct virtio_balloon {
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
 
+	/* Bitmap returned by host for DEVICE_INIT_ON_INFLATE */
+	DECLARE_BITMAP(inflate_bitmap, VIRTIO_BALLOON_ARRAY_PFNS_MAX);
+
 	/* State for keeping the wakeup_source active while adjusting the balloon */
 	spinlock_t wakeup_lock;
 	bool processing_wakeup_event;
@@ -180,20 +183,30 @@ static void balloon_ack(struct virtqueue *vq)
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
@@ -290,8 +303,37 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 
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
@@ -304,7 +346,12 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 
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
 
@@ -851,7 +898,25 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
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
@@ -956,6 +1021,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
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
@@ -1171,6 +1242,9 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON) &&
+	    !want_init_on_free())
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE);
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
@@ -1182,6 +1256,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ee35a372805d..d129736cc3a8 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE	6 /* Device initializes pages on inflate */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
MST

