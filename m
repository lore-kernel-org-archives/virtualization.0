Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B133F2118
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068309; cv=none; b=Fljtb6uGTbUu1LkaUXmixubmtdmNILJh9Aar/n+T56rdmykhwGN8xfHhaoZM1qCWltLQUzaP0jnA5uoZihcItQy8qCvObJHoIPdAbwA0QjjAildU8p5gxcK7965wjTBh++D5XF266YKX095kxiZFnEujDl/HY/mbcL/7AFCfu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068309; c=relaxed/simple;
	bh=o1q520LUtIf3WEFA+mnt5VZVOCpKdiGNtHAvZKuDwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CjWZkcppabL4xZ2lr/q/9jSUg0KJ+8glwdfohSRS3lao+bFCkNFmrPjcwlp96ZjdQu2tGwM04PrRY8fOOnZhR3XpxMeg4fIJctCMZktiyatX3oWoZmSyETyRGFHUMcjKqxoD4/Naxqac8Umsn25QlB7H1sSLhOO2F2HCL8GmnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYVEgBqE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYVEgBqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PhUe/N+eFNvMvlBoMUh1oQQhfmsYB8gjnR/tug0hsFs=;
	b=fYVEgBqEe1qSgXWuALGrKjW3mmSCrUARkkCVUtGUU40ktLfKASxU3618FN5qF5AMh5satp
	iIZoxo2ZrIIwrz9Ycr3j26U0aKuIIHw4ErMbJJ1zcN9KyqprNE/PDnYY8bH/gL0vbo9Epr
	6wJjriPBK3oIY8Y/I+hpWt9hWZp6Zik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-4GmNysKRNCGb70kBqwAVzw-1; Fri, 29 May 2026 11:25:06 -0400
X-MC-Unique: 4GmNysKRNCGb70kBqwAVzw-1
X-Mimecast-MFC-AGG-ID: 4GmNysKRNCGb70kBqwAVzw_1780068305
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6ad76bfso45881f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068305; x=1780673105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhUe/N+eFNvMvlBoMUh1oQQhfmsYB8gjnR/tug0hsFs=;
        b=didbkLCm6+C2BnkZFSY7oiPvKt3a+JhC4r+I4jjJfRx3b5c84KTudclDXG4QciyesV
         4REZIXvOJbS71XOvYChbL+rmALKL0t1ZRWWaadEg/1N2DKlkksv89TNkTVcz/QUgrEUP
         pLP7q9hxv2HxWCd7C3h4fanZhP/1wwI6N75a2OsYGdX0qwGO9ylxoGzpm3mhC4DKXGJP
         H+0lF1bOd5svlsYUf9y01J5qU7mXVtSrICl/HOzyD32iCC+T+MxszcbHoXCEuqs6amVb
         fg1FKydwD9ZEJaRPGi5yrg1g+ZP4M7K2INSSvSS5BlrZdWmFI6eEzXvjZ9MpTecFHMAZ
         az+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+6RxHDdvA1paEJ1zjVTa8SqzVI1ABk7/lmzFhoDhfCOaG3Vm9ZnE6PcWnFM7+FKJOASfvBu7wTKlEb2MNTfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxccs9rTgNI/iH1RPL9SoFh7RfFRNzeuULunV56oTJnpiEHAq/z
	asxVe9CJz3uG8uyDkFZGi1taylDgZYngOYm9i25G+yQda3gCafobjDo3DdOc0FzyTwMOC36KvFm
	pD2VWllegyFwtJ63t+giJ5LmCLC9T1CIlMZNTqpxTLy6Z+cISUfP6u5AeNhhrB6/768Na
X-Gm-Gg: Acq92OFIUXOlzKt+fAYlin/fc0FlG0yVjg2yR/dXIdJrYo5DlW4NGEaxPg3nzQFeYIQ
	eb6H2HbgKJE7Rn+lf5J1rQOyI6XT8oWE095zQiMvF/NU+iZrfteVXs1SVEYDJtj8/wo5A1xjoRC
	Pbr2OVpP6wqm+/jhgfxN+dmHBdSsod+OVvAHsemz39IqgtJ45cQc1MGkJ4Cip9sO3PVtpfH5H5A
	QQva+0GxHOiSw3/05aLxpH/UK17m7O2vdQA6+pmcVogzaBvBIDnm5wSvGf0Xb/gO7g5ZGyDIQUy
	thaLcMLdDXhgmnZS+HYHY9t4sNVbdXHoAW37IpLf/8NW80w42S5nVL36RffXos8NkKUGaMmvwEZ
	AK3uzH0CaD0ZXS3NDVhcb5b5zLHo0AEo1MWfhSXfgJk7RYEq6rYj+1w==
X-Received: by 2002:adf:f690:0:b0:45e:73b4:85cc with SMTP id ffacd0b85a97d-45ef6b815f2mr388321f8f.35.1780068304562;
        Fri, 29 May 2026 08:25:04 -0700 (PDT)
X-Received: by 2002:adf:f690:0:b0:45e:73b4:85cc with SMTP id ffacd0b85a97d-45ef6b815f2mr388225f8f.35.1780068303965;
        Fri, 29 May 2026 08:25:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b47eesm4828235f8f.9.2026.05.29.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:25:03 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:59 -0400
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
Subject: [PATCH v9 31/37] virtio_balloon: skip zeroing for host-zeroed
 reported pages
Message-ID: <6bff99e8890ea91c93e3e8f0c27ddb3b5b2528eb.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: rZUhfdLkIFuGJSsdXDtonR3qmRL0BtgDotBVv185kZQ_1780068305
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

