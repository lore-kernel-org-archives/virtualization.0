Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E044A13B5
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022829; cv=none; b=TSgFAXP1vgIuyDXg4O9JRDtO9pjN2o/Nh4wTvHVb+AFvgoYU1vLgXs3fXUl1KZpWDDjwFK6ZxYhw+7zYDu5gLZO3HHaREmY0pcOf80IdUhE/OuHFb0jCYs9R5EWXcp+YTfjXor+M3J/ujFFH3KFaILtJHmUD5V0XAX4Cf/lHBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022829; c=relaxed/simple;
	bh=NloWP0DgFYPxfd4/ZN34pw1e1BU92zhB3G4CbO7zbF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NO+WiMfEE30LkVRqXpD7M8BzXGPOPMZO9wjpl1OPPVddc4eAFOX9Bo1rtDp94VKDp5zq5M2MJ6OHeBFdzWsqvcFbcfyVdUCUVaKHLAqeYTEvAIqqPi+gU3/8Xysi836V2XpJayEwkcKkMOS6SG6Zy6RPLj+CKlu1bt6Lh51sNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFnF62th; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFnF62th"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781022827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q+EhFDHbTReAtsWK27ra3gAEOi8VOH3eapVDV1keuxA=;
	b=MFnF62thsGBU0ReftXrrP2B2FncRLFQzsptkvvA6f/eO7LufVt3RwyO39Vd0pb8N87z2DX
	VLH4UW36mZoXagu0sGtwBHaMSOc1TRdsZ2X1e/rm+Bn3a8dzaerFVtpc5uy2Bg48kQZtq7
	cqnmWpRM+nEyim7PAnP9Q9bp5giJ1r0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9d0663D5NUyk0h3e_KJRag-1; Tue, 09 Jun 2026 12:33:46 -0400
X-MC-Unique: 9d0663D5NUyk0h3e_KJRag-1
X-Mimecast-MFC-AGG-ID: 9d0663D5NUyk0h3e_KJRag_1781022825
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46010392f89so5265484f8f.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 09:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022825; x=1781627625;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+EhFDHbTReAtsWK27ra3gAEOi8VOH3eapVDV1keuxA=;
        b=iKrjsQjicLeQ+rb6gwys732WCBYopJ5A6Eibex0SfV9+S2Ae9LjRuGMLLmAZ8H0IzO
         kB1TYZ4iUDyigXcyl8sQWvdRiWfGtQQyuVX50tqJw+gAU8EzfEJEKSm650pmprWlzs4H
         T+eOWbNAsEtrEMNZQUIbCimTzd6t515exFAmJVCkW5cKW21kfdH2kQrsVVFbr+AKwEZR
         zfdnpJoDrBc4dX5dI+3fU8FHPS5TzcxDOwaMW6eypxOZtv3yYK0Yq4G59OT5nj4ptep4
         kKiCRpxhCw9muL/Lj0UNGbcTWLvKu9ANDP5CO4gkTQkexcEkFcVaxIGjZNvkludnHAzP
         0Iog==
X-Forwarded-Encrypted: i=1; AFNElJ8iYg8OPSUBN6IhHwv1K9qkaOGTLbTqkKnHwtBA7c83CdPNsA5qgujn+cDIGEX/VljukHgsWbErTR8zGkk8wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYmZFEgkF35pP/TbmvhDyV2U3tZ0yxefGekLSTKfKoY6UeC5CB
	yZil+a4LbWQsvXqf/gM1vhC2yaPQvkOZByYFsN5AyaZ8RGmd8s9xLZpOrVzhH1SkZtcfyoxFALA
	3pFcf0R1cCJO5+J67bw2eGuTSgE/SxaUCVm9SEBuUEuGhAZeEyf5AurmtS4o01JWvRIpF
X-Gm-Gg: Acq92OHos6rTxjA/0qdLescOKTdJcVh8v2FJmHObW9MhGFEpedg/AAcnCdHoQ+zOh6L
	1cDUB/3oZEdtSD1SL+R6UnHu7/1dE1plOnwoFc1EpKBf+TUvjIkYjlahe6L4lhExjArKPtjtDIf
	PBrUHCPg/XcPxz9RoWwyVeQu1F1V9d3awKlrNgTbDrUtO5aCnRKhgIo31T3dl8cp05UxgnoRfb8
	9U9bJJ1L9dT9y2T2W4QSB2Z6wO18tH8/FznOkzGfsOnCKMksIrUcWCyUVx8CdzLvVf5f3PMside
	S20AksjHKdJrKc2glLE7W987MJ9bQ++cjLwYQ97YMCsU/Wlmsnk97FzzVqQaElkQ8eolU3hC/R9
	kof/MrtIeCBnSXczN6NCy78dO73kb8rSbo0y38iq1MVHdpreZtTmPDw==
X-Received: by 2002:a05:6000:43c5:10b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-46030766a2dmr24707322f8f.35.1781022824674;
        Tue, 09 Jun 2026 09:33:44 -0700 (PDT)
X-Received: by 2002:a05:6000:43c5:10b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-46030766a2dmr24707250f8f.35.1781022824267;
        Tue, 09 Jun 2026 09:33:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm56543737f8f.30.2026.06.09.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:33:43 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:33:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH splitout] virtio_balloon: disable indirect descriptors
Message-ID: <7160278ae1fc4f06dec966867d307033989d029c.1781022765.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ur_2h9mmyOJanZhvTxU5ort0xldOycZJUFWaQHlWuuM_1781022825
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
PAGE_REPORTING_CAPACITY entries of varying orders).  As the result, at
least in theory, the kmalloc might trigger OOM when we have in fact a
ton of free memory.

Clear VIRTIO_RING_F_INDIRECT_DESC, to avoid using indirect descriptors.

Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 53b4a3984e7d..6698edb61474 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/virtio.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
 #include <linux/workqueue.h>
@@ -1175,6 +1176,11 @@ static int virtballoon_validate(struct virtio_device *vdev)
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

