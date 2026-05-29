Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5599429838
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068290; cv=none; b=BbqAKM1Uxa/qCZ7ag6qAbguBwMpiAfD2YWSKk4ZLfQ7F45hWmNbqkS9IHzA+FG48ArKIIvOIKZPELSTf26roAy4cZ4vUNWmFzh/LPLP+1Wl8vmtJIL9o4qrGvALjF5kKg/SvVuXlVatsKZcWDgX7IuuSuGW9Pm4cdUCMXR71aAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068290; c=relaxed/simple;
	bh=NEUFfCyJTTjkAORA91qK34iLisrtuxPbcfRlH9SPC6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cInZIz+pRKOunD7vqEG2Y0hQvF9fK8BJkzm1jylZc6LW/KO0jTJ2zR33Ly2/FXF45iZaqQ/Z60Xxn+GS+1y+3WvxJCT/9VJMjRTEGU9M7Hf/01D1MkcSpfMepMqddWuXIPfMTodBvhwTll8GvX4UBNR5Zik0BD+uho91X0Eied4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4E8Gsme; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4E8Gsme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrGGx5WHa8djlqQq7KjWOiK6GbnTz3UET362lIFlLIk=;
	b=P4E8GsmeJzdmTb2YOC9GDTsZCODtsRdmldnc99wmmjsytY4Eub+gU9iMTs9KKdgbbX4ajE
	9dJicXUKzDmqkSVlR+PrFRiX0PUuOUHbLtQgNIGAH1ISKaEPVs6fwKEDHiikZvVTE5nwk/
	9wNx2bXgpp7PkgR+i69Lg4AaELAW7O4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-lJtHN7MiNvefGGHiOBNjFg-1; Fri, 29 May 2026 11:24:45 -0400
X-MC-Unique: lJtHN7MiNvefGGHiOBNjFg-1
X-Mimecast-MFC-AGG-ID: lJtHN7MiNvefGGHiOBNjFg_1780068284
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef5ba50aeso268574f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068284; x=1780673084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrGGx5WHa8djlqQq7KjWOiK6GbnTz3UET362lIFlLIk=;
        b=NCsL5GhmwbkBJ5D+V4bbyK54f+ILEsnE7VZSAGAm8ppN1WPF9Q1Md3Cml+bU9zPXas
         myhP9bvdRdLXiecq+kcEzGHdz/n+3HJdaJuA26xgt8S+w38GRP5SYZjFVAIRJuGQI06f
         TEXBpQslBkblOOZvuluiSnnHeHKTkBZ/ICF1bx1eTnszhtPMbEd1RJICZJN+dEG+ZH0B
         glEJJvSz0coZ3rgk/d2NkdznneZnWkCX0gBxBJNqRZoGncuvYgl0S55TVLG6c2tLTbYH
         x63KFWyEn00VJ4wVW7Buvup/R/HCgn61Pbw/dqwzXi7yVP6Ix35XeIab0RNbrduLuiKN
         tp6g==
X-Forwarded-Encrypted: i=1; AFNElJ99Ormm1au7+/PwVt+4Tmjpwc8L4i91LKe2QOuNUg1wftS4E0rPz28QarD29f4WrD7JUXeFxb5azMWywCktiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYGCJqmdE//ZyYW62F5nt7dm9Ro0jQHJqGoKp1PlvvYmfaQusg
	IwkCUJY9UAWl+9/MncnChrIaZAzWQ7LhdSU0e1zJ/wopAjJ1Wx+17XlH1uhnk9qwJuJa44XrAqA
	ho6mqKKXn/o6yOR+JiVhIvq6jCirqj3RStTInpHD9PCYahsMgUf7yZEvz3SwlOYwQvxVK
X-Gm-Gg: Acq92OEH6tC8/yCbdrJySe7uyp87b8kxZvlXM36YF+/+d5HIrKsQSwi4z7hc5cBLQNf
	Y+4EacDa2PFLhqC2NIhyfWKvggvFYCHZl033EG3X1kaaF/+4mIOaMtwRO9Q+uBJ/xcrbTb0WKwI
	wsIEb6ZHmg74RekD66XpTdjEH/ewE/hJgqV/f6OJEoXhpUycmdW6GCVAQC7clXIjjCp2cv3w0Ny
	+zKUG87V8UXF8tZKdnUFFD91ImXsZOpciN7tTuKCdG1/A3VPMna/7x9fw0up66x5f9CnBfGxEnG
	56c3oqD+T0xwSGmLpGmRu7FbGGSwu7hmQ8WhKHCC1ANv9dvPwR4LJUCO7rYQTq+3Rf4I36bJi/R
	EkMR+ASWdZ+gUPHwBL9xLcaWshHbqeNuqTrTL1ELT922zRZSdip+iDA==
X-Received: by 2002:a05:600c:630f:b0:490:845d:652d with SMTP id 5b1f17b1804b1-490a2948eedmr1399985e9.15.1780068284121;
        Fri, 29 May 2026 08:24:44 -0700 (PDT)
X-Received: by 2002:a05:600c:630f:b0:490:845d:652d with SMTP id 5b1f17b1804b1-490a2948eedmr1399385e9.15.1780068283514;
        Fri, 29 May 2026 08:24:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm58813385e9.15.2026.05.29.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:43 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:38 -0400
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
Subject: [PATCH v9 27/37] virtio_balloon: submit reported pages as individual
 buffers
Message-ID: <a7fd4308b5a4afcd67e30bcf64ae1d7069220815.1780067978.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: f6Fw7_5vNcU42zqBuWEdTB87r-e0qmzlKBJ0p4rAZKA_1780068284
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

