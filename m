Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5683D8104
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315798; cv=none; b=SDd/6/NXuSTXU87+o+VfqREZRdx/NT5n8Qd9nQTdPVmV0v3644PZBsNq/PGJlvNJ+Kkb9to0kvpr95iQuK/HHyjS/Tgkj0JrJHiyAc3pwtkbds/IjHj5llwtB3r95GyYXTdSeUo39rYc2PhxhujebYxotBq+SeHzEPCxMpklqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315798; c=relaxed/simple;
	bh=o1q520LUtIf3WEFA+mnt5VZVOCpKdiGNtHAvZKuDwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hIwD5yRXOSZwfP4SitFDXMGQdq0kHfKZBkc6KIH2UnHYOQ+fAy3Te8gG519LIaUraIzbe9tk5fuWdq6PLsi5bjvS+Phezr69MvxlsAZtyN2QFPDKcKp7McN6+MmB4VNj/aeK8NHAqv4FtEkBk+WyQtCrnZhejMwq8VBdGQdCE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gM8ly0/g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gM8ly0/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhUe/N+eFNvMvlBoMUh1oQQhfmsYB8gjnR/tug0hsFs=;
	b=gM8ly0/gT6k8YFQGXfmx/J4+shqp/WYOeko3CDS9oHOElS0Owrf9Pz5DAhDmTnEpkooT+B
	+vGpbpthEuQb3BxsQDW23Yosmt9jrzAPRomnJ/s1mCRZMXLhLS09sqAFOp9e7G/cie7Q2l
	6Z2kiXR2M6TJPKM+aky1ake+Eb1Bm+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-DTHAgaa8PqCS3kFU690o-g-1; Wed, 20 May 2026 18:23:14 -0400
X-MC-Unique: DTHAgaa8PqCS3kFU690o-g-1
X-Mimecast-MFC-AGG-ID: DTHAgaa8PqCS3kFU690o-g_1779315794
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso4212280f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315793; x=1779920593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhUe/N+eFNvMvlBoMUh1oQQhfmsYB8gjnR/tug0hsFs=;
        b=sTsammTgyYdcJsFzEaNwz66clQvJ2kBld24GM3PaZRf/Y+wilbZG+pFKTwouhTUeSe
         d+zKVrAzJl6qCbjlUvsL6ui2dK9x0gfCStbs8uUWjC7xzneDiHvXTVKXzyxEc041FM2f
         J7GBinIlc5r2JJBiRqOocVEqFk1hz78piSap+khciJHIdHkeiwnh9GwCOBeSt3jIb1ai
         uimuxVvET2urn0WD4PhcltEVDk5B2ooTqetF59U177pbpOAcrnRCU38PI3+nitNQfK6h
         eB94N+b/+tdxY16iYm2Ov1zpqTN8yM7nEX5OJ8hzFQ7fhEt6d0rlqgFdMEA/XyvwHKhM
         N3dw==
X-Forwarded-Encrypted: i=1; AFNElJ91kv+tlrAhuo27pUUynosphALuWxgprlPVfLBAPqIlV7NplCzCdVejDBV1wpm2ZZi/J6pzUNcZNPoVHxpMiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxglWhSez6qYCP+Rm6yeKR/Y4gNEiSjaiECpOsaYMl/irRR8jFN
	omDvuD711Uk+U46AtILPawHL+7BHzpGZRkaDmCuvUL/2Nm1sd+n52f714dk7is8EK3RlO2GNi81
	YEBUjjgO/br/L0mE6G4GkNffljrfariaieXVME2AU0AEj3FqC6SOCEQIhrUZRXK46d5/w
X-Gm-Gg: Acq92OHf/kWJckZEW6qV8t6VeJCz7IgVdjqVFq3B7wyRkV5DjHAuPCWxm+zN9hQpq6l
	vZQL72aRzJMJHtKu1UYpsOd9eDT+IFXGlWXEbzES7V+8Wa6g5fls6GELb6dMgbFhrl9iZ3rzV2X
	9yiEELarsk7PoGMzY12eLGnFPRJX3z6KzdPkw1zPiZD/2mzJ1R6BjmeiSwJVTZE7XxZAaxMv8Dc
	NczgKqqQpAfc8rUm75FBvdXr9k9CekcFhQkYJoiBxWXIx4gcARD6ZWxxup2ng3O9/MSfbv7DpdK
	ZJkgthDjAVp53pcSGkRRfYcMCd8IGA4jSze/97EeIfPwsH+mQEtWCvH8pKuyGbqpKQrc4HjBaKu
	QMpHYYuwoNj8JICZMw9DVnWdc0AnGkUwtUMxb8RNP0z8=
X-Received: by 2002:a05:600d:6446:20b0:48f:c649:e6fa with SMTP id 5b1f17b1804b1-49035f6841amr2479855e9.15.1779315793386;
        Wed, 20 May 2026 15:23:13 -0700 (PDT)
X-Received: by 2002:a05:600d:6446:20b0:48f:c649:e6fa with SMTP id 5b1f17b1804b1-49035f6841amr2479685e9.15.1779315792933;
        Wed, 20 May 2026 15:23:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm59877057f8f.29.2026.05.20.15.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:12 -0700 (PDT)
Date: Wed, 20 May 2026 18:23:08 -0400
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
Subject: [PATCH v8 31/37] virtio_balloon: skip zeroing for host-zeroed
 reported pages
Message-ID: <4753c094c752fc97c7d3372b5ca7db9414b42ca3.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: w3mAGPvA54im1YseuLe0Cik24IwbbURirQab5968Kkk_1779315794
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

