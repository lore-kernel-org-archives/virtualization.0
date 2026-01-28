Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE4275AE3
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589970; cv=none; b=SXZBbvlFHQFA3cjxCD8oN+KI272bj8fYB2H5BLuPGw5sYzZTzRQjQNsIpJeNutjr5SZDXDjw66B/113KeMkjHgJnwxbB62JIMzUU0jtIyccyjyyZkzbSLJhBWXpsMaxBwaPf6bjzX491nsmppafCGEnaEqP+znATEueE6Bgnh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589970; c=relaxed/simple;
	bh=NYPgB44pc7Pok9nzrR7OebNtleH8cRs70K3euGX68L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIl0x0y2lgh7nDKw2kEhlr8bX5O6eiQpJxYEzT2q4VOjS0ELxNEwdGrY+aaRee4yavOQPZTJHzf6evpLB3atNY/zrEWhtyTRQ/zxP4OxWezGn4O+OF+X4GhSqZiX3ddSj5J5zY+dmGecHubL3Tj0vDdmt7nY2fYFvFUKwkZrtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WEgeJEjl; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WEgeJEjl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769589967; x=1801125967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NYPgB44pc7Pok9nzrR7OebNtleH8cRs70K3euGX68L8=;
  b=WEgeJEjlt2prXv9BEbvnP30lWJFzmysWUyInsrSz1DaDu93DumCFl4st
   vsbnNb1KQSwYVax50pcNehT1WB8I06JLMp9cPJlyo0rKIgVaeuXuspDe6
   E0TDw16JQ2M01TbbNAlFLYkN/AERgwr3OqrTgGJqrkU/u3+b/9ye0ynSF
   EvGY6jP3GLqUfyTPG8BnxJSRiqZ8I+ys6CdafmcCGTpXne9xXIz8Rvl4d
   TVMC7pClEMV85nOrtHJP71qtKkpY8H8et0y5VUx8cHxjQFQpCOAK59HeZ
   DpXY9yzbrjgctiDmGO4w7i5sI5dyCOuGyncx7paP9k9IkVP3G4OD8k/Az
   g==;
X-CSE-ConnectionGUID: twZVEUXlT2+KyALROizWng==
X-CSE-MsgGUID: VCkoNO7mThKBBOjcRnKvJA==
X-IronPort-AV: E=Sophos;i="6.21,258,1763395200"; 
   d="scan'208";a="138838728"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2026 16:46:06 +0800
IronPort-SDR: 6979ccd0_vB5eXa/8UbVjPfw6c/oW5F0/CSSTcRZCePiJKAVZFbsaXh2
 iiAn2ZvX7Qhk48+PbfCXw9GEMVmIH1AhI4lZqeQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2026 00:46:08 -0800
WDCIronportException: Internal
Received: from c02cd2rwlvdl.ad.shared (HELO neo.fritz.box) ([10.224.28.86])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jan 2026 00:46:06 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] virtio: fix compilation error in __vringh_notify_enable
Date: Wed, 28 Jan 2026 09:45:59 +0100
Message-ID: <20260128084559.256235-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d43eaf1d749b ("virtio: silence KCSAN warning in
virtqueue_kick_prepare") introduced a compile error in
__vringh_notify_enable() because __vringh_notify_enable dereferences the
return of the vring_avail_event() macro making it incompatible with the
data_race() annotation added in d43eaf1d749b.

Remove the data_race() annotation in vring_avail_event() and move it
into it's callers instead.

Fixes: d43eaf1d749b ("virtio: silence KCSAN warning in virtqueue_kick_prepare")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601280148.8Z2rFqjo-lkp@intel.com/
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Michael: I wasn't sure if you want a patch on top (what I did) or a new
version of the broken patch to replace it. Just drop me a note if I
should take the other way.


 drivers/vhost/vringh.c           | 4 ++--
 drivers/virtio/virtio_ring.c     | 2 +-
 include/uapi/linux/virtio_ring.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 925858cc6096..47d3a8bb9c52 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -556,10 +556,10 @@ static inline bool __vringh_notify_enable(struct vringh *vrh,
 			return true;
 		}
 	} else {
-		if (putu16(vrh, &vring_avail_event(&vrh->vring),
+		if (putu16(vrh, data_race(&vring_avail_event(&vrh->vring)),
 			   vrh->last_avail_idx) != 0) {
 			vringh_bad("Updating avail event index %p",
-				   &vring_avail_event(&vrh->vring));
+				   data_race(&vring_avail_event(&vrh->vring)));
 			return true;
 		}
 	}
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1db27ee2d89f..95744d03b284 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -737,7 +737,7 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 
 	if (vq->event) {
 		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
-					vring_avail_event(&vq->split.vring)),
+					data_race(vring_avail_event(&vq->split.vring))),
 					      new, old);
 	} else {
 		needs_kick = !(vq->split.vring.used->flags &
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 32568cfa1c63..f8c20d3de8da 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -194,7 +194,7 @@ struct vring {
 /* We publish the used event index at the end of the available ring, and vice
  * versa. They are at the end for backwards compatibility. */
 #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
-#define vring_avail_event(vr) (data_race(*(__virtio16 *)&(vr)->used->ring[(vr)->num]))
+#define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
 
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
-- 
2.52.0

