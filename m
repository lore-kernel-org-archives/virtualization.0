Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A453C3C1A
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315778; cv=none; b=uGddKlwgl8b4Gu3rBgfCPYUp8FKgTtDayRQbnK+M0Z7ws1VLW7QsLvheXhSpCYBFWEtpbrIXUliXlTAFzc3+pHZug3/cIDBLqvYhrb++XhIXYVldO8WeGZlXwE30x5giGJBQvJD9cofNhFGoUxKP786hAaFLoS8EUfnNj9TCK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315778; c=relaxed/simple;
	bh=NEUFfCyJTTjkAORA91qK34iLisrtuxPbcfRlH9SPC6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ow/7VzdZqegLnfYs1PUBJUPwWnr/oR8dXFCallN18O5FTZo6MIrfWnobwP0gHki7X6LWD/D3iUTn7alnCbHfpmJXyIqyVgKJrbwKZWEDZXVofaJ9Rfu2XeLbyAXYwwTqOiy+VABGkKDSj2PiMmlMH7t/0O3pGb2EUvjWLHfx6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwDsOqjq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwDsOqjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrGGx5WHa8djlqQq7KjWOiK6GbnTz3UET362lIFlLIk=;
	b=gwDsOqjqIGEEJQ2Xi23iyHhieyB3AFu6z9xJ0b7GBPn2yAfos+SqqpjWhs2rp1rTOpcOuX
	aiNEMrczOLSHz/RwOQeWTO8sme+r/oqw6VPTUMNcCNhw1IfHhHDbDgHITIxKsWYcoup1Xj
	NZWcK10MXVbpOrnnpwfNrj8Ck9OfWTA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-oDbXvVsjNgiPddTCm39Ktw-1; Wed, 20 May 2026 18:22:54 -0400
X-MC-Unique: oDbXvVsjNgiPddTCm39Ktw-1
X-Mimecast-MFC-AGG-ID: oDbXvVsjNgiPddTCm39Ktw_1779315773
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so22074945e9.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315773; x=1779920573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrGGx5WHa8djlqQq7KjWOiK6GbnTz3UET362lIFlLIk=;
        b=YBiBYS6p36gg58XGDa9jv7kHb514oNEhwJA3Cifl+KFGqX22qX+LZQCxIfISPvPOPv
         x/c9Ou83GC6drWU32pi8iXngWJXLrr+AY+fOTeko9uo788FSrNZr7QWs19I3i8odNSxF
         SJ+GnbR4A2LzxJ9JPKbgNv8wIr4mvnzOqnoeg6LNHK6DgD73oKmuQWfMEvXTz7pGbYAK
         Wo/YhCokDltW+uAtxkQ+cQ8XGFUhwbuueLA+KRN1qrtasAZqdm9SqUjyG3+glwaSUy6w
         X8VIZKttqlCkOm94rVmD48C3b93uIY0bdwVBLsOxlhCxaSNWctbNE1KKxkSaBtVQKbIT
         j58g==
X-Forwarded-Encrypted: i=1; AFNElJ+RJZjWmgyhJh64kpo7Zrc8B1PV6LugykFPGEpwpJxn/bxXjSPNCJ+pSQke4a3l4ErxiiifgfugNMus6CgSlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnLNhKHVrZfSHXr1CnEItKb0hrNuNWvTSVH2WYjZ1gjTC42uck
	3ZRjRlkv50P0LDZ8KC9Fi/T9k1rSsNwLqVQ/+RapG8UwE/LiPTFNT6cpeCxcGlwwqsOQ5cqJVnQ
	tcqC8ts62RNPT+W/wmPIUp9zLUHTK8+7jGmfllSx9eSAIiQWZkgLIF1ttRfpB4LAco9Ef
X-Gm-Gg: Acq92OFQQdQTIJAGI0PjK7qvw2lOjJ0SLBpOeGbtOGMHnDMMUlubcfLnxDnF0jTs8WD
	PluE4JDdsAnKv2BqzltcYzcaednLQaY6nZUB8lH+GiExa+Hy/EjvvB+U8qx/eF/PxAwnYHcQbmd
	IqaJuyeOKgctNTxipwEaXRE4s34KaIM6tPLKwhr9sQ6TwbWNSci8eYCDKQowperwGxwJaLVkYI3
	eLpz07624agkQg+C7BmM4j8a/B0IUYf8APtEvPxcajqz4iDxE/SKMmW8g7Hl6fdEAjAbG/2Av73
	LkzuT083ctFji3FmxLZlgs/T0ai/3vdl9Ot2wqEZKVqatz8ti0x1u9kocS8PJGEZTkENatpQEp3
	DKrr8mYbJ9tDRvpk9+C6Mr4noB/oeYe3wkNcvwODqMGE=
X-Received: by 2002:a05:600c:840f:b0:48f:d1c0:721e with SMTP id 5b1f17b1804b1-490360539b9mr3370515e9.12.1779315772883;
        Wed, 20 May 2026 15:22:52 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:48f:d1c0:721e with SMTP id 5b1f17b1804b1-490360539b9mr3370055e9.12.1779315772346;
        Wed, 20 May 2026 15:22:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d525ddsm23122965e9.6.2026.05.20.15.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:51 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:47 -0400
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
Subject: [PATCH v8 27/37] virtio_balloon: submit reported pages as individual
 buffers
Message-ID: <0050d961a817b109ac032d121f095fb1fcc1fc5a.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4NBbjtAKeooOWULAb-8CW3OlKTFYX1IKMezzPk0BzFA_1779315773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Submit each reported page as a separate virtqueue buffer instead
of one buffer with an sg list of all pages. This avoids indirect
descriptor allocation (kmalloc in the reporting path) and gives
per-page used length feedback from the device.

On error, the already-queued pages are kicked and drained
before the error is returned. The caller (page_reporting_drain)
then marks the batch as unreported, which is conservative
but correct.

Note: if the virtqueue is broken, wait_event on
virtqueue_get_buf hangs.  This is a pre-existing issue:
the old single-buffer code had the same hang.  EVENT_IDX
is not a concern: callbacks were never disabled, so the
virtqueue manages used_event automatically.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 40 +++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6a1a610c2cb1..53b4a3984e7d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -187,7 +187,9 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 
 	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
 
-	/* We should always be able to add one buffer to an empty queue. */
+	/* We made sure the vq is large enough so we should always
+	 * be able to add one buffer to an empty queue.
+	 */
 	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
 	virtqueue_kick(vq);
 
@@ -202,25 +204,35 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
 	struct virtqueue *vq = vb->reporting_vq;
-	unsigned int unused, err;
+	unsigned int i, err = 0;
 
 	/* We should always be able to add these buffers to an empty queue. */
-	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
+	for (i = 0; i < nents; i++) {
+		struct scatterlist one;
 
-	/*
-	 * In the extremely unlikely case that something has occurred and we
-	 * are able to trigger an error we will simply display a warning
-	 * and exit without actually processing the pages.
-	 */
-	if (WARN_ON_ONCE(err))
-		return err;
+		sg_init_table(&one, 1);
+		sg_set_page(&one, sg_page(&sg[i]), sg[i].length,
+			    sg[i].offset);
+		err = virtqueue_add_inbuf(vq, &one, 1, &sg[i], GFP_NOWAIT);
+		if (WARN_ON_ONCE(err)) {
+			nents = i;
+			break;
+		}
+	}
 
-	virtqueue_kick(vq);
+	if (nents) {
+		virtqueue_kick(vq);
 
-	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+		/* When host has read buffer, this completes via balloon_ack */
+		for (i = 0; i < nents; i++) {
+			unsigned int unused;
 
-	return 0;
+			wait_event(vb->acked,
+				   virtqueue_get_buf(vq, &unused));
+		}
+	}
+
+	return err;
 }
 
 static void set_page_pfns(struct virtio_balloon *vb,
-- 
MST

