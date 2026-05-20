Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6E3C3C1A
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315782; cv=none; b=eT6yn4880bJe6f/DtUSqFjafAfa4x9+IQ8GkH12Yb3bRck7yBM64UfGrAqepuyEPhwQxdJsMfNg+Df4CqPjNoRdQBuj280vqOxYVRmr+p6RvdzHRd1pHDmwqNKa21yZvkXO+YfE8KA21FzYuvtIy2xu+S7IbestGQdItalqTtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315782; c=relaxed/simple;
	bh=b3DH92jukQeNkUO526fVTXypKGZyggM7uuOadXDZMdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tFzdB6cAI32oRDXaoGEJRJ//EUpnBpovcrELCexJmkrAfwCxVmoUetO0Il5CmnoucHAch/XZLuDuG4DNTaoP3j+F/vnhd7ghN4S8x2/Cn+A6PhfvQM+g3avt88jdVfMQ2zuWpb9Mk441WCY/6TQPIDKKHZ6RGHmGLmKCg2If9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2/5yx4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2/5yx4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmUnWEHUs3R8Yu/59LXfqjcAZ9F41NBb5tClVv8g9W0=;
	b=a2/5yx4zv9yQKy0uxf7IbsUHCCUgVapn4KMQo/9eRbD5iMD2vVZ+3G/C44AZPk3HTcRURk
	kIfvTby3PAqWIJU+D4bWe0GsTyo7B5R5CnZwRU5RhZT2mD5tAuGNrllzD1NvkB2cKALdxA
	gSBgAQU5Z661tg6MtST6U6XTtyWbkng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-g82dgkYVPjm4NKVACtbSTQ-1; Wed, 20 May 2026 18:22:59 -0400
X-MC-Unique: g82dgkYVPjm4NKVACtbSTQ-1
X-Mimecast-MFC-AGG-ID: g82dgkYVPjm4NKVACtbSTQ_1779315778
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso4212185f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315778; x=1779920578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmUnWEHUs3R8Yu/59LXfqjcAZ9F41NBb5tClVv8g9W0=;
        b=THDSXM5r5BQ4hfnfz6fD+vP6O/MPG11KKP2a5j2SA7cKYNL1rcgK7J0aMFSK8G721O
         5c2Gtal/z+kFOgjLITDAvLbaj8qWxK7wBW11DkYGL+XS9ctgLJ9SiJltE60mAiGvT/p3
         lg9wtAf5ArzYnd3mTkkXjS6XWQYeS1AeNMrvNSFCIngzIoen6OmBoJ1c5C2aW/TCohCf
         jI8gwtE7UA3a6FvAw1za/9UI15oF5U98HPgZ7lW1aEmvEXvLHYtViI/swXjbNFR4Fkt0
         ReTfwtZhV/A6RrMq22eY2mf2UB5dZ0svH6qqqYcN1c6m4sBRxCGBDXZb9pOp7BhgaabG
         v7dA==
X-Forwarded-Encrypted: i=1; AFNElJ/k3a0VGGaZr/5Z1O3ElkZxt6tZEvQnsqhYZ1Vo++VvNhuYcJM0qn1eQaWN20Os1wmtA6oMjGt3pmBD7Deveg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNtxu64NZPX1enp9tfL9XVNnE3Gc0C1UMCJaXYuaIY+WrhntxN
	kserZZ0Ls4ZLF8zhylDMPUigIC+v2O5/a3uJasLBolDcMUyHBMuMlE8MsQECdHpq8g65U3W1GPf
	11jh1IXWBNQoUmPShcHOU6xH1eV+vaSP+GoN8kDXMHXkKXsNVhZawQcbeA6c7mguLyLBo
X-Gm-Gg: Acq92OGG1d72ZaMJn5aTf0RN69EZvKHtnCawH1TTQcq1ZXiQgfJWUfONrCeld4FgC3e
	1Lbnc3VS68jxxv0T2CBDXLDgRL65f8CsyPKx+TpsaTVFDy3tAyEEFIJ4lGXFfkyAC8ayoJkiRgk
	60bURKLvnf5Js7OzcWyA+rCbwsh6ceiFb6dlh8koD2Rkr0ytMOkMQQYIniUYLP+HbaiOmWUfX/8
	RI3gLaeQchqpF7+FvtlL12NDxMDHlMu903PN/jvVhSGRoW8j9GU9k1M5HHqkm0pDPObwiYA66CV
	7HQDdlzf/5D32veb+sw/hq+7mOJbARCYLRo5D10PkKoHnJt0tG5fvWgKOndX9xn+8HTTguJLKIm
	rZjp/s+TQ0iEK/wdODogDJVM6vqIsD4VDLJ86WNJCrvc=
X-Received: by 2002:a05:600d:8496:20b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490360dc195mr1175225e9.15.1779315777784;
        Wed, 20 May 2026 15:22:57 -0700 (PDT)
X-Received: by 2002:a05:600d:8496:20b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490360dc195mr1174845e9.15.1779315777370;
        Wed, 20 May 2026 15:22:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3514esm23238795e9.3.2026.05.20.15.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:56 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:52 -0400
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
Subject: [PATCH v8 28/37] virtio_balloon: disable indirect descriptors
Message-ID: <83beaef00179365fc6418a5d0aa4fa649d926834.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: zsHd2IzOFVO7DeLYPT75p8QjfNl8N_wGMNKbwYaQNdo_1779315778
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Balloon submits at most 1-2 scatter-gather entries per buffer and
virtqueue sizes are 128+, so indirect descriptors are unnecessary.

Disabling them avoids a GFP_KERNEL allocation inside
virtqueue_add_sgs when VIRTIO_RING_F_INDIRECT_DESC is negotiated.
This allocation could trigger OOM reclaim while balloon_lock is
held, leading to a deadlock: OOM notifier -> leak_balloon ->
balloon_lock.

With single-buffer submissions (previous patch) and no indirect
descriptors, virtqueue_add never allocates memory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 53b4a3984e7d..1fa1c7fa285f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/virtio.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
 #include <linux/workqueue.h>
@@ -1175,6 +1176,13 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	/*
+	 * Balloon submits 1-2 sg entries max per buffer, virtqueue
+	 * sizes are 128+.  Disable indirect descriptors to avoid
+	 * GFP_KERNEL allocation in virtqueue_add under balloon_lock,
+	 * which could deadlock via OOM -> oom_notify -> leak_balloon.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_RING_F_INDIRECT_DESC);
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
-- 
MST

