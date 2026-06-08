Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DE3C1F36
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908013; cv=none; b=nGCZdXGFfT2LxzWN9Khzpu067I4qMwBedbg1HlUHeXvqt67e481XbmtoDI0mRVm6Rk9pu5UFaHmPkcGJPnCbYQxZ13G9oaQIw37qUgmQuHGz2COvFDdtB/WKmqUqf0GVGrnXOjVvUx4jzEawN8vGEgaE20B90HGvM2Irkh9CMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908013; c=relaxed/simple;
	bh=JiJWE7l+ip28dmS9nLt+boIUyEWSXna1gjhWeHw0vBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EbNem+G9FHSLwp8vHGtPLpEKqCfvNFxSjH3vvqb9swi1kIIrB+AZ+y84EFASX0CGvSx1V/gOPagKeI+rXRNdWVkEAocpX1/6nhBsoRD46JvJjwL6+9VCFWuqQpNlmYfJaSnuDa6SJwTZIO6DD4LZFRoqyba+rZ37RJa3acZt958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbPV/6rx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbPV/6rx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJIh5LHG5pOtGoQVym0SRNgbl1Zw+eEBG1qiVMPIhiA=;
	b=dbPV/6rx6WkVavWpkrd/LKEVv6vuusdbyu1yhkb5aZEwvEDWCW7zolSs9mh78Pk9C8t3eA
	Rl9HW7t1L5y6Vx7C53OZ1Gk6TlWOSeabTbRzgn73gGX4er34SXJoeUCzi0lU6UVC57H56e
	D+GWKLGJxfoDnRSbuxT+cr5v/j95AGg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-ciI_a6maOTuML6zlLRzxgA-1; Mon, 08 Jun 2026 04:40:07 -0400
X-MC-Unique: ciI_a6maOTuML6zlLRzxgA-1
X-Mimecast-MFC-AGG-ID: ciI_a6maOTuML6zlLRzxgA_1780908006
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6ad76bfso1302012f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908006; x=1781512806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJIh5LHG5pOtGoQVym0SRNgbl1Zw+eEBG1qiVMPIhiA=;
        b=OGUrCTjed2k4yipsKbDlJ0y20omSn5og0dOT23rsbLUDvqUhPYy62hPar6affPnHjZ
         P8yyMwRVrBSTg+PhaebwhExnPLadwrbeltwvRerAGqBqJvb7L7o+3zkhhi/txw9H/DGn
         UeSVPNjoLQi5JRcnfCbgzvFXJkdLUiMgBMu3mbRu/4dJsgahwGix45Ld6Wn3JH41IMZ9
         GC749GZJkdn8OePi/BULjVU4l2x/wdmHziFr2DLdYx1PMzwWHawSroEkYCFQZ4PQi5CT
         xCdwbxFtAWjCFTSOi8G0tz0EjMvjHN/4aIYIUnnc4hJCbSs9utdzZOdURZtYv9QosR3y
         Wz/g==
X-Forwarded-Encrypted: i=1; AFNElJ9R8QCGrXxJVFMNptDM7AdjN3aXqmCm+Zbyuyc2wQE0k9OzVpsiztX8jRd8+1htekOTEWmtt5XZHfOx52gsjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOawXs+rvOjEBcjC0PM24n0GnmUyDT/aso2RoJcO6rmKyTdVA5
	Z0Zi6DT9yjyrtdK8EKFdyg1ANXukIwP/WHInFYyXIT6pfTu75YFRMRGkYCSWs/D5m8kGzv7rM5x
	Yw+/hjG0YhE1VLhl/RPdEHJuCPbPRbwCERxfl23L1l+M+Wbdt0Q9gZSbJ338KyC12nz/g
X-Gm-Gg: Acq92OFMkbawmUTDY/J4xnKNteLEfSjoZeldL5wdOg+aY3NyNuyZJ4F++fWVwsNFUfb
	/CPvQnXenGz7rOTy0qrMlmmx0mHDvZzwgfjuMh6QcGKQNSd51Rdx0z4T0kdJ7wr7IkX7ffsH1ai
	N7LYrwE/vnhmHADMj1sgmJcD5dCzDxJzbdwv1ylnZv0QG3P/j29j64eopTPI0/I2i5stlsIc2QQ
	mJ+xVphiqKHBU99K4Yt9JIZ5ztFI6Wv9Mfp3MYPYET4PFPPOhaRb1Q3ARWK0lTjjJnAomYzNaLL
	u0c1vCPpve8sTG9QqBNnExlixeSJHmqRNGFmIt3cm4NkoWdqsxcuFXzkBdkjYKuZXUiKARuv62P
	xcOua+FU5B+DdX8Kg6Lmsgww=
X-Received: by 2002:a5d:64e6:0:b0:460:3233:6700 with SMTP id ffacd0b85a97d-460323367c8mr22945778f8f.43.1780908006095;
        Mon, 08 Jun 2026 01:40:06 -0700 (PDT)
X-Received: by 2002:a5d:64e6:0:b0:460:3233:6700 with SMTP id ffacd0b85a97d-460323367c8mr22945715f8f.43.1780908005559;
        Mon, 08 Jun 2026 01:40:05 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm38411715f8f.31.2026.06.08.01.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:40:04 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:39:57 -0400
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
Subject: [PATCH v10 31/37] virtio_balloon: submit reported pages as
 individual buffers
Message-ID: <b541ff170218bd5d45b551b5132e7cf2c490d761.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: c4EFQfMx7822AneyNt_rS45pDvBUmv-s2gYUOrdm6zI_1780908006
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

