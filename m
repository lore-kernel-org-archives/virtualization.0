Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1E3C342F
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490255; cv=none; b=lZan6WMc+bA8shFzu9E62PFoWgfxpcnHtT3BSj/bfxjTYvWoN5i+VnCmOJYiq/mLFUVIOrmSs+nS3UzA2Dk+SOVSPzkR99tECEp5fuMQ1aoqreWcjzcBb/PHJmiXyfPrZjZ2lIrBqV37ZMHv5hp0ZXZTQPSrMuBUo0FzyeNC6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490255; c=relaxed/simple;
	bh=kbeC8rzPmxUpVwR5cb8LtaGHCXNFNmNT7voh9QmR/3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eKTVy21GR6/W3tBmlHnn8uiFzHoF/958BWMjcwxRAgfEF2yPubHEB0MIVukUrK+IgT4ARXBVPAXWWATJcdlhm7nOjcVz0wvcdk+drVnuuaYob8VezIP4JWYGFUzF+dew6nVBvXwtI7cvqkGoeDhDWY7eVs5sRMvV+PHa6AW0sgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9m3VZxS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9m3VZxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R9MIHVZ1NMFTjGw8qWZvRYjcRPTh67thc0mkpGrxtNM=;
	b=U9m3VZxSm9r060Iui0c7dDzXepR5QtAaQhCVSeadjf8IdiAwXMT6U5S8w5Ww8totdx1RP/
	CwfmVcjmH35NB4oJHtVH/epudZAcH3ZB8ql9kW5V4wwrm8Tuver2EMtQ3rbLJT7EVnOtYk
	AzWsLU8nxZfaoJqkSHFQUAxlG8S+KZc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-78t_9dw8PTmq5GqHlDxXWQ-1; Mon, 11 May 2026 05:04:10 -0400
X-MC-Unique: 78t_9dw8PTmq5GqHlDxXWQ-1
X-Mimecast-MFC-AGG-ID: 78t_9dw8PTmq5GqHlDxXWQ_1778490249
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d144d3428so23318975e9.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490249; x=1779095049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9MIHVZ1NMFTjGw8qWZvRYjcRPTh67thc0mkpGrxtNM=;
        b=IGkLmx3d9+PjjjIjXW6MECB1kNb4kQtQfuOjbVKRURLTUoyelivfucPlq+6hXTh+Nm
         Fb+hX2cABGsTCV7TWpbTEi40jqdHcH1y2RZluBa5b4jya6vtdhaUGsHgaebKqRM3obVQ
         +LxIDNP6jKsOH1TThza39C37oaYhgMX3TL7VOrXsZw8Lu+7x72qB1iJLmQDnUi9cqxgB
         /YAXMQ52tBuZa8zgWrE+PVJmnZ3yJ/6pkkfvQiQ7L38bjLLJHy50RhM8eW+iQC+RVXdw
         kVytCg6kJT8PyXLsGHiVMmskO3Df7r82L4wyL9BjoqzzslyPjW3LeUN7onAu5qtPl+vB
         QwxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9yd/uN6kaiYOJnq6YCns/DOIi/Piuj2x0RFivKjmpxIhpta9/g4oOSvtZQ7HKY2HzxZlG5ucWY/94QPfr5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyPbqPeA9cxjgHW5CkqUbtG5HTbVclP7HF/QnsjY0FiMYrgqYW
	F98igqOpY5xHZvKuXVwMq3vrVs4YAq6aFcftZpnLUze2CMasnjiUwKc3kBMKzaMQEtj7SPa/If4
	ouf1ufYcmCTRLOGGiWgz6aXi06YKCgpClyW37J66p61SD4dkN5C1wj1MG+S2m8AvohLy0
X-Gm-Gg: Acq92OHlc3LZG9BxLSFw/ahFjTohe7+9dXyOtQmNWJ/QmXTFUyMsakmWwdwYNVH2Stg
	5yfvVnjXOaBZudmkatscEScOGnR/9SwGiFsEh9mWLsED5/ZSmc7t5RivZya8y3XQzqhQgnoh+8E
	Cxg/ae4oDGhfkQrekzJFtRtVzJTeomjcSWjrshqOfbpnqnHZf1SIYRxpmmSOrztDYcuRX/tW/3q
	Q9FiGUS//ymBrh1EH2CqvfgHdHS3X43D+pPWCgyH7UTFvUZqNvOpgocKqFtTZOIEImgPamMXjQr
	1THANsQdEYkNBOH6vx703bjWsceDWakte2I7a9VGYUbFtoF30It1v/xMmkOK5Ne/b2yACScgv9J
	CisX1nTd5ss4T97bTzTX/k8+sBiK/Fe+lMMe/UHdu
X-Received: by 2002:a05:600c:6299:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48e706edd0dmr143938745e9.28.1778490249127;
        Mon, 11 May 2026 02:04:09 -0700 (PDT)
X-Received: by 2002:a05:600c:6299:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48e706edd0dmr143938055e9.28.1778490248435;
        Mon, 11 May 2026 02:04:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e6d41sm220651835e9.7.2026.05.11.02.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:04:07 -0700 (PDT)
Date: Mon, 11 May 2026 05:04:03 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH resend v6 25/30] virtio_balloon: skip zeroing for host-zeroed
 reported pages
Message-ID: <4a0f26ece4b662e928606a638959389bcff66b53.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P33s24PIJLbG1X5wUubz-vZQCDqWEJ2G5cOM9ggdUOg_1778490249
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
index fdfd828657dd..e5d11782ce41 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -204,6 +204,8 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtqueue *vq = vb->reporting_vq;
 	unsigned int i, err;
 
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

