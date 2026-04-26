Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484830AD00
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240115; cv=none; b=XDOINZHDQXNM97UU7HmYREZLmb9EG9zoihfbps/SmkyvQ7LMShiNgVNsr6ZnLKWE5rni8jHqwTWfCNjP3sfPwhRfB4xEjtvJ75S8ntAToQ0y6UNaY1UAvMTZGeKUsCkuQUmViitVJ/pSRGl5ZOH9IyN8LL8gyTkP7jQ9Mbkzq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240115; c=relaxed/simple;
	bh=qQW9TjyXt/G4RVZeOZhv7EWw5q3drusbpwikbnE9UQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GDVaNhN5fif5UUFyfpOW5C9N1LqS8wmCgi4xWcHMDCdXRc8fQunpwe7Zn2B04eemY9XjUSOKBfk2786pV7X3udGfI4JX71T/z30nxbshvFO/GLijc8Lrh/w5r2MJSKE66wb3iVwjIvtWOpcwm70HzHZhMf/o7QoBj1HH5fEAHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCdWsxYR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCdWsxYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdZwqDH0Vgol6kXYX8uKZUPg/RwJvIkyVtJHSwLpmoU=;
	b=DCdWsxYR1qoWTm+xLybCzZEQaT7ENvceNU24zKbpHs7ogwH3hygfvT4zHQQjvmF6aEibPW
	+GJVenaidQq685ywlrt1FaALW5Ke8xLta2+lfhVoX1+xCuyKyJWRYSMndvXm66Qcbde4pl
	Q9BFRSmeCmO6NcHj1LQ5rTN3gfu59eQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-_FtZwXTNPmGnfSslg-9K1A-1; Sun, 26 Apr 2026 17:48:32 -0400
X-MC-Unique: _FtZwXTNPmGnfSslg-9K1A-1
X-Mimecast-MFC-AGG-ID: _FtZwXTNPmGnfSslg-9K1A_1777240111
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a548b585cso40731775e9.2
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240111; x=1777844911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdZwqDH0Vgol6kXYX8uKZUPg/RwJvIkyVtJHSwLpmoU=;
        b=SXVgRPE5J8PDQMbKA2h5T+U+TOyfh86igenXQF6iE9CDwDQgT4rsft1CbvWPEoLVsw
         jvyeYUoDF4FKSNXCBij7wmzN6J8zMWV/fR2rxjYo5SQpldgXMVieMlT6+hsb4bnquHVW
         FdQe+FfH0bApJq8QJA2GqnzBTRM+ozpwwYIufKg8sOUyqvXe59TlDuR9mAq8moFC2JTh
         ATYAZtSsFPvOyaphu4q0wUxivqfJWjm8A4JDx1D/FSI+V9GbjwcjN60oWP0LPSKp48CG
         fmEbdZhjLd8HfIvc/g++WQw2OyI4qlXAlUXP7oFS7eAtbaatf64cEc3xWSi/lZDuCiI8
         y+qg==
X-Forwarded-Encrypted: i=1; AFNElJ8/GWmUXmSFZfVLSdY/efzEvYOdoyW8qatqZ1TMLkpbySW54WDvMry8wBLMe/+UcD6K5IRB32ujgIhZE2805A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywke0+6JUrZ35TSo8f8t0ttUvpmqT0gBwk5EkbPbTY0Le+eUoV0
	ihlO5j+LxADbFGmeohrY19UzszbboVGKcVvX1Ty1I7aih+33luXux3ONsLc99SjE/3aewpNcUnK
	sM3iTwOYQ+VH2yFCnILvj8aLhtRsSizeJxf08mUnGOV62iNpkb4XE+1EBsr/+TQfqGceq
X-Gm-Gg: AeBDievnU8T8v9Cl8NbtSbPKUIyW+Ud/wEf0BEbPc2j4RNvs+LhdUFQxfGDnP4rc4GC
	E/3kEgCzOfX2SVVs+OH4ZPjWVrRzmade0dZ4of79Gwej5tDHebSONZJJHLPe5ALzKUHzly3TDzN
	bzYwdpC1xnswxCP1oeF6WIsVepQLi3r/quf7HVoWwvbgXq1iFS/ya0Xmuh1BpFfzdjRqYc705Yw
	YiVT3TSPNEHCfOWyDdN7gY1ev/Ni4DioQpgn0qbLP+fYWR5tErxqVBvwkAHfomkp4pGs+fhbgKz
	ZCsTlKHYgWwLsZQRToL8N9iZxT9kb9O2ZfYR7qca3GhVSIb87hUpnu4U5lV6RQZddGIhiE97Cv8
	WBV4F9q++KPgla2j0TVX2J3ccmJfAwBoqnXQ0fAps6XOmXFy56me773rk
X-Received: by 2002:a05:600c:37c6:b0:48a:65a5:750f with SMTP id 5b1f17b1804b1-48a65a57563mr161705115e9.21.1777240110859;
        Sun, 26 Apr 2026 14:48:30 -0700 (PDT)
X-Received: by 2002:a05:600c:37c6:b0:48a:65a5:750f with SMTP id 5b1f17b1804b1-48a65a57563mr161704745e9.21.1777240110388;
        Sun, 26 Apr 2026 14:48:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489207ebd3asm254796095e9.6.2026.04.26.14.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:29 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v4 18/22] virtio_balloon: a hack to enable host-zeroed
 page optimization
Message-ID: <c5af438231b47bcbf8d1be43775535f1efb4ae27.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nILIPwQypF7-YbR1u2oLPzkVcUdjKmOn8cyRoUH7t8Y_1777240111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a module parameter host_zeroes_pages to opt in to the zeroed
page optimization.  A proper virtio feature flag is needed before
this can be merged.

  insmod virtio_balloon.ko host_zeroes_pages=1

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d1fbc8fe8470..8c15530b51b3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,11 @@
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
 
+static bool host_zeroes_pages;
+module_param(host_zeroes_pages, bool, 0444);
+MODULE_PARM_DESC(host_zeroes_pages,
+		 "Host zeroes reported pages, skip guest re-zeroing");
+
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
  * multiple balloon pages.  All memory counters in this driver are in balloon
@@ -204,6 +209,8 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtqueue *vq = vb->reporting_vq;
 	unsigned int unused, err;
 
+	bitmap_zero(pr_dev_info->zeroed_bitmap, nents);
+
 	/* We should always be able to add these buffers to an empty queue. */
 	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
 
@@ -220,6 +227,9 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	/* When host has read buffer, this completes via balloon_ack */
 	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
 
+	if (host_zeroes_pages)
+		bitmap_fill(pr_dev_info->zeroed_bitmap, nents);
+
 	return 0;
 }
 
@@ -1039,6 +1049,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		vb->pr_dev_info.order = 5;
 #endif
 
+		/* TODO: needs a virtio feature flag */
+		vb->pr_dev_info.host_zeroes_pages = host_zeroes_pages;
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
-- 
MST

