Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A2305047
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721713; cv=none; b=hDEnaxlqTtYpuMa6MOd9HkCbsjodE0ES/8WGnSHk5jN4tUlGNhR4zHjCheQkUlUl6eI/PZbOfd8UQw9DbvLDS6LeN7nAqJk/cL1iOKXgEsHNsyi+Job6Wmm2dJAWyiTeucblfmURRwhcFsaVfk0GLh8ZuAlqJ8Ddy+78Xx+TQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721713; c=relaxed/simple;
	bh=F5jjXvOUykyUu9zaFjniBFZS1TJ9Ywm2mqV/IlHg49A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVuWWlxuOWyQkWRCJmtutKHHoWJALbi7AX2/kiJc+ZIpqziOgeVDQu3sljeFdHgDPV4iL/9V09pksK7B63gRj2ce7ow+fuYExGTUDL6/Q2IiduCJoNhlo0bcVvehx5Nwp8N8Sk0btyWjBkwbAuwefpf8NDlz0kVKypxewTrYI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7yRKB4N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7yRKB4N"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad8076b01so32013425ad.2
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 18:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785721711; x=1786326511; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HsrDyLiG2SqFngrsM9H92PhXRSraWTBf1HxDTa+ur0=;
        b=V7yRKB4NGC3v4NKbuGTOF0nliJezML/HITNI2qLaYBbypERxSx9v05ET5ULEz/1qyL
         M3vYSsWNBWyFLIL9DeoPw87FFI6jgp8sD/mrHwhPluqctqYdnbii7t76xFszwp+0XLy+
         nSkCLIJ1ll8BhSEPwzEfL0EbPY0fTV31w2m9IkO5arL/2U1oeMaKLdY4DZhmpBWBDnhX
         in/aMNv08nzj1/8ohtqyqReM+C4bH8MHtR4kC03OhBTXzA6E48Rm6k67tkAWA5D5VCWD
         aoVxJMrAJ+fuITQcUbK7rBNVt9EifAF6toFIOBXoho9eEVZJscv0kTEi4J2YWpKsVIhC
         Tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785721711; x=1786326511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HsrDyLiG2SqFngrsM9H92PhXRSraWTBf1HxDTa+ur0=;
        b=nMDJq2dX6B5LyGdGVOtKu4pZ2iZZsMseEP8SBe6h6kRIim9WNgbBvLpd/S0rmApPyY
         VN8coCRUtYCzmakttgDtHJJVtWZQA05V84cXqV/BZsMnoNSbYNp9NKDKBTvl2xp7Pxli
         Ht4eaX29XQPXbYXYBcsqqkVmFNd7LKsQeiD8LT3gqUr8hk0g4noPMTeQyxDDgqOfRTUy
         rW6dONBWKYhiGC9QWAuoap818aeSnEr8NPUgET0si9RvsVHsbJKAJaSshrMWUDXB14p0
         oAgtHGJSqcnf/MH0y1Q7vQvtR0la1fGFuuigBMy37xwCaXM7ATiEpbUQl62xxLW7kzCJ
         ynIg==
X-Forwarded-Encrypted: i=1; AHgh+RqbRtVPCvMVTkoKFvd3bKWEvrS+BgsoPeM30PZmOonMp6T4ipj6l8/pv7Ms7ot9GyMsWD7GBeSRqPKZG8XfwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr+UTe9fmv6wmVUuIYLWeLAKq59iqzdX2uFzwFb+ekfCwtphJD
	wbKmkCy1fDEiY0MF5TDIC/wgy7JoVv3t+80Hb9kLjqJioMwd+R2F+1QL
X-Gm-Gg: AR+sD131C82Wqqlc3z4eF7+ha53nuMyoYxVxXZWHa/FfR2VeCT1XQSc7vywxa8ma/Bm
	4u3D9hFDc1I760jhEGdTsfYTtUOYuKc+j8b79Ue7OY68RciTuFzESRrlGJMTj7bcsGzMEEXdWEO
	vNpq7ZjRSgfAZ8V29wx9efgNFqV/mHOUyPFdEArG6wORzAH+3T68HLpxt4mLUIWAlxbja0gzbjo
	KP/5PChXHTUXnT0hIElKGwUsuc6mTHlfjuCe+JzMwDeJ1LLzuO8MqRx9ZWGXAWB2jwQ2C8z7M+v
	cknRu2Eu0YioXVuTkjp5IFAieGnoxnjkp0dh2DrXW0JDJOzkAo2ydbAsEK8SThiOE8Kn9/Au5mm
	RGCbQp10m3/+5SOXyWD3ufyiyNfFS/wYmn+8hEAWvf+CvqClLhj7Z+CRPgQ1KbBJxl59yxSYmv3
	Jil+El49jNtkhtCDuIbHcgP6GD6l700fuQHOp9H2sGwTUZRTHN8XG67EBztej06iRdR7e9Kc/2r
	HRbAElSVPGm1pDC3CVS6urphBLbkDCXX1h0Fbh8rggmwpQHqA==
X-Received: by 2002:a17:903:1a4d:b0:2cc:df15:91de with SMTP id d9443c01a7336-2d0524a2b59mr81446775ad.42.1785721710586;
        Sun, 02 Aug 2026 18:48:30 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb491sm30422855ad.42.2026.08.02.18.48.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 18:48:30 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: reset the vring metadata cache on vring reconfiguration
Date: Mon,  3 Aug 2026 09:45:14 +0800
Message-ID: <20260803014823.68623-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

vq->meta_iotlb[] caches the vhost_iotlb_map that backs each vring
metadata region, and iotlb_access_ok() returns early on a cache hit,
taking the hit as proof that the region has already been validated:

	if (vhost_vq_meta_fetch(vq, addr, len, type))
		return true;

The cache is reset on VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE, on
device IOTLB (re)initialisation and on vq reset, but not when
VHOST_SET_VRING_ADDR replaces vq->desc, vq->avail and vq->used, nor when
VHOST_SET_VRING_NUM changes the region sizes.

With a device IOTLB attached both ioctls are accepted while the vq is
live, and neither validates the addresses at ioctl time: vq_access_ok()
and vq_log_used_access_ok() return true early because the addresses are
GIOVAs, deferring validation to prefetch time.  Once the cache has been
populated that deferred validation no longer runs -- vq_meta_prefetch()
hits the stale entry and returns true -- and vhost_vq_meta_fetch() keeps
translating through the old mapping as

	map->addr + addr - map->start

for an address the mapping no longer covers.  vhost_copy_to_user() and
vhost_copy_from_user() consume the result with __copy_to_user() and
__copy_from_user(), which do not check it either, so a subsequent used
ring update or descriptor fetch accesses memory outside the region the
IOTLB actually maps.

Reset the metadata cache whenever the vring is reconfigured, so the new
addresses are pushed back through iotlb_access_ok()'s slow path.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 drivers/vhost/vhost.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..77c96993100b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
 		BUG();
 	}
 
+	/*
+	 * The metadata cache holds the IOTLB mapping that backed the previous
+	 * desc/avail/used addresses and vring size, both of which are being
+	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
+	 * region was validated, so the stale entries have to go.
+	 */
+	__vhost_vq_meta_reset(vq);
+
 	mutex_unlock(&vq->mutex);
 
 	return r;
-- 
2.55.0

