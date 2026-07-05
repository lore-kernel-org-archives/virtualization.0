Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A9246BD5
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783232665; cv=none; b=toSNr5Ftg/36uh5Z9MlaNYJxh1o2gfBD094v3OB1GH0Jj3TsPwm451dyCOKwcdoz5WSKGkTp+fUH1QSdgEefOrBdUL5Oh0LwFtB8tgQHCbFAab0uUF8TWF/YFqUW4+5FO2gPtDEormrw5ZcuZkzBUxgadQcm8bVS0tGZeqpmyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783232665; c=relaxed/simple;
	bh=+9TAWvzTWO9WfLyoBHbX3BhLS7xPUomJ2jlxAuDHGcw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sXtmCi12nImGv4Zu8IuBBTSBFMfXdcKqGCwXBwXlP5dFQZ31mCPikurtMmR4DJN4Lfsr8lBM/LD4WC0ziVjPxcuwhH0XGT/0E0H66AgAAevj6XS5lwfl3bOqFFuPkdy5e7824rwj+amMDElnlXcNv7/wDlVwK6X9J0vT/fwcMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNcyaoYw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNcyaoYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783232662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5WqTwcoPJ/WtCkm4g0TXXc5S2VvR0zVaXDnmLSXwkNM=;
	b=iNcyaoYwK5g6ij2ZF31D8locIvqtklEt3RvTERMnrSaU96abeS5w93khmKkSEg8ytpbeyt
	sDyh5LQ5uObO4wWJCAZej3ULAnaFpUGv0cHAw5XUM9DIjNbHYPvUpq5Sm6T5ABjgrTmUHf
	6hkeNPh8dJV00XLuvEJlQVDQR7eERU0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522--UtqBlu2NwizeUjbpqvoqA-1; Sun, 05 Jul 2026 02:24:20 -0400
X-MC-Unique: -UtqBlu2NwizeUjbpqvoqA-1
X-Mimecast-MFC-AGG-ID: -UtqBlu2NwizeUjbpqvoqA_1783232659
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso1152828f8f.2
        for <virtualization@lists.linux.dev>; Sat, 04 Jul 2026 23:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783232659; x=1783837459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WqTwcoPJ/WtCkm4g0TXXc5S2VvR0zVaXDnmLSXwkNM=;
        b=VjsjjAslKCLb8E9UAMM9syjxflrE3PmsHUogdJimcv7jsAMc5O9X8aZj/N0hZ/W5PZ
         TOZB2T6nlY9fePRJXDBVfcaQ5/NfS16bhsMAd9G3uiwNyArpcb+wgea+luR41IrrS7D+
         1FWlGFr7fhzoAoW9LiVTPHbd4RsT++qWbuFJYzF+68RDWISsQMZxSr/AzoXIKqYyW8L0
         /D1DlwZijrUmOGslw472gPBq9oRMUZs/R6/SoaKwNzggDebQjJ9ysXiEHq2oOGHZc30l
         zf55XfueRaAcnNOOP67V9sVGn1QEA//sQck0YEie04Oh/v44SP/u/csS64UAexc2xfXK
         0T2g==
X-Forwarded-Encrypted: i=1; AHgh+Rpa3I3YXAo5Z3fD+f8NKS4BuMMsZqyEPbkGUTkJKPsVDRLDWtdPXcC2GWHfFSazGBhGrzzFV2IXWky28ouPEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzV93l2yTZBdaRn8932J/oZswyfkhuJXltXm6/OAWRBCsj/z2R
	Ek0ZMmUfebTyw02dedhxONEZsqlIHvLyIWAH3RG+ByrqFBr5Ebp/wRq6ElRpU8z6m1x03PZSuxV
	EViHeHIyMETnxtwEF+Bj1NFQ3UCjsLr84mPVRKFtu15joY1zQqR0ODK3kupHcANl7H3jR
X-Gm-Gg: AfdE7cldN018qyDb/S9Z/5+EwPXoq7Aq1ByBX4xtMLVLCKG9cItfMxEf6xutX6iGFI+
	Cfxz7Xs3wgZHPHjPLd0HsK7BFtlJ41X32Q+9mS1yz/Q2zhlb8fdmbnyBH75YrYNdwhuFOk1rOVI
	Wnp/7ped27UgLeUhsUd+QShK856Io7ugMr+wb/HaX9tjurxtl5njkGMWje7OK3y5IPIDPzP0Bc0
	afFUkIw2kguCnC407idE+TRE2BQNVlVVzMPmNMPPM4Xh6TZFOc/D5Y6S7qfGx/H75SIsOWEKRIo
	0t+thn8YBvYrPtMKVUe9ZVD3Ij3tL2RDi0k9X9irc/ormkMDScKA9r3ro0+qECPN6YaPyXeS2mj
	8ubvc8oMxY9BQ/5e1R+GwQzafVv8FLRdM
X-Received: by 2002:a05:6000:718:b0:473:a74d:34d7 with SMTP id ffacd0b85a97d-47aaa60de9emr5468863f8f.2.1783232659037;
        Sat, 04 Jul 2026 23:24:19 -0700 (PDT)
X-Received: by 2002:a05:6000:718:b0:473:a74d:34d7 with SMTP id ffacd0b85a97d-47aaa60de9emr5468837f8f.2.1783232658499;
        Sat, 04 Jul 2026 23:24:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960b06sm12725497f8f.28.2026.07.04.23.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 23:24:18 -0700 (PDT)
Date: Sun, 5 Jul 2026 02:24:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2] virtio_balloon: disable indirect descriptors
Message-ID: <73fac8a629fd9aca7bb3265ac243a769c28af25d.1783232420.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pTis_zxMos-lhCMfLJWEELVtPK66g5Ok8COThmUVDmw_1783232659
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The page reporting callback submits an sg list to the reporting
virtqueue.  With VIRTIO_RING_F_INDIRECT_DESC negotiated and
total_sg > 1 (which it typically is), virtqueue_add reports it to the
host by allocating an indirect descriptor via kmalloc(GFP_KERNEL).

This is not pretty: the reporting worker isolates potentially hundreds
of MB of free pages from the buddy allocator (reported pages are at
least pageblock_order, and the sg can contain up to
PAGE_REPORTING_CAPACITY entries of varying orders).  As the result,
very theoretically, the kmalloc might trigger OOM when we have in fact a
ton of free memory.

Clear VIRTIO_RING_F_INDIRECT_DESC, to avoid using indirect descriptors.

Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Assisted-by: Claude:claude-opus-4-6
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


I assume I'm the one merging this?

Changes in v2:
 - Qualified OOM scenario as "very theoretically" (David Hildenbrand)

 drivers/virtio/virtio_balloon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 581ac799d974..69160da9cd5d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/virtio.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
 #include <linux/workqueue.h>
@@ -1165,6 +1166,11 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	/*
+	 * Disable indirect descriptors to avoid memory allocation in
+	 * virtqueue_add during page reporting.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_RING_F_INDIRECT_DESC);
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
-- 
MST

