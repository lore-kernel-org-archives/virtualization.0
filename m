Received: from mail-qv2-f37.google.com (mail-qv2-f37.google.com [74.125.230.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E454DAE6
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111551; cv=none; b=B5k9rXTdQ1YlZ9+UKTKHEdqnrj9SNRzoVlqY+j+SEvMVkb3iaRqQy0Be9CKeBHxIc+qQLCStkN3Cl4BIEwjGtttcyoqocnOOK2/7Wrjf1J/EjBF5PlACIaJN+Bu7EvAg23HJTRU92IAU1ehry8waJld71+aucfr9fAjrwJUQMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111551; c=relaxed/simple;
	bh=2+E9WLAhddquoAhrHExJTH/ipVluXO40UC60vRyiwHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZulGpG2bEd3iHbOWPL/e/cq8LfqjNXrD2c56IBa22oDvJ5O4mh4VX5Wh8vDxsQ8L+/sTibTGaUmC9HudWWQvJrcaH26JCnNasSkZHnqnmVw6Hi1yrwXYwMkPauWRYhFJwQkNT7IuRfCT1MdwcAowjBERGXOokRVml0sU8g+1tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRSBWJjx; arc=none smtp.client-ip=74.125.230.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRSBWJjx"
Received: by mail-qv2-f37.google.com with SMTP id 6a1803df08f44-91235f46716so2574676d6.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111534; x=1790716334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCOJ4IYbfFaRdEJKYXl8sjbEptgWjDvoJQmY8J0q84k=;
        b=mRSBWJjxYKPuCvsPuo1gH4r6IWwvgLKCrWZf1DtRARXY1lJl39KHXe8o0XP42KWWH1
         nh9qFPkrjfwvz4bWIC2Hy3NeTCEO9uU1Ox2ljeern2DObuB4wDALXzGsl0VWq26oAqWB
         FQvsqE415DUKMFOt+g8UoqeJkELijtq36QU7xLnyQI6zuPdibvLH6fzqhg8mhJNa7mbg
         2uTl6Q6mk4Ra3IBBBhyDWgy9FNVEh60D56719zrutqMa5ItV3u+tv7DfzsW7CZdNji1v
         XffRPBwcka1l5Owk4DcI82xT14vX341wSEQNRSrjKC4YTK5TQtxW8+9/PhFdCeA0+ucr
         xBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111534; x=1790716334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCOJ4IYbfFaRdEJKYXl8sjbEptgWjDvoJQmY8J0q84k=;
        b=yCbPKmG6fU6I+T8Y3a+1y/kGRl2cRmUQSmLrkm4w9dxa3fCXqMMeR+Pw/aDWt7h7Ry
         0C+SYUym5iPFxJXDC+mNbITyf2FGzohuZtyT9ojHc+gKxaipCFfsQB3LefCosUiU4TJs
         wTwErFiHw4kNtl93XrE04a7BZWjxxKbd/g0BOpVEk9ta0db1glsJN5wWQISBQIAH+2in
         oZ1/aai56QaoBn5g/wcruQPEt4QGHfsRkGoitmvq63bsh9DpNncA02CPKoryEXcbl0tm
         RBUDA4sLlcJffpejLPNUHyn97ImAfErM//vWF26hQgn0wXcqOP/4lgOPDhU0xslNMzEi
         g+zw==
X-Forwarded-Encrypted: i=1; AKwUvBw9M2Aa+GyQrXhhPUHpMj8zqNTG4GvNo9KbM0l9itxOoHPJmjT3uVKWT2Yk/KIKKz1dfwFfrOGIbgl6X0SODA==@lists.linux.dev
X-Gm-Message-State: AFuF++mNJpDHM/gWnvSvAG5kSA2Hw0LUDqEe+kNkT2Cd6SlA/c/+igos
	/tq31JuGomevWkcl3gweevQnrj5p1xsycb2wWPz8BJCIxqCCLJ/M7uE4
X-Gm-Gg: AYBFou0vNkdoD5wDpdvtQuINaj8sVzI92HQtnLcJPycwRsA4dz4LYbnzxFZHvbc9/9p
	iXTIh+iDBm7NDpavG0I1G6t2MIAkkxZJoz9y2Qj1XLvkpN1/iz2P7Fq5hTShKwEEWGB/WOYwN/x
	WTto27+EoC1M3DsLtzVJaSyoP+9Ze38keCRPG+AKQdbuMU0KlxpswXWsmP2ZBQ7V3gd/9laTSrS
	dCVTjdRtBW3CMassSNRYCga07X82ZBXEK3TrtP8lj86qfPdTrAYj096YyTKu5UIFXSndC1NjDz5
	2EYkYT177q+5SbDNJZ/sCWgQhxQuqaM6Ok1iXJHpgBsasX/MHcG6a8M9it9sIVLE/Jo4NqSYvqa
	0LRSGwTa421ONawHwqouH5UlOPM5wo6MK4m5F39pu2XA119PQ3pPq+oM/8kShXz5zgvAZ3hotYL
	hq0C4Q/4HSPRrY9LD5Vky/cRONstao8xceMGU0c4gjDASOTIMLY0MRwtrfSOzIqBkmRmWOn4dmo
	VH9oqqKDDm3nmMME4ukjA==
X-Received: by 2002:a05:6214:4a88:b0:912:533a:4a43 with SMTP id 6a1803df08f44-9140c3f990dmr12597706d6.32.1790111533845;
        Tue, 22 Sep 2026 14:12:13 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4640c9sm6319316d6.40.2026.09.22.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:12:13 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] virtio_blk: Reset device on probe error paths after DRIVER_OK
Date: Tue, 22 Sep 2026 17:11:41 -0400
Message-ID: <20260922211207.523999-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtblk_probe() marks the device ready before revalidating zones and
adding the disk, and either of those can fail.  The out_cleanup_disk path
they take goes on to delete the virtqueues, but nothing tells the device
to stop first, so it is still live when the rings are freed.

Reset the device at out_cleanup_disk, which is only reachable after
virtio_device_ready().  virtblk_remove() and virtblk_freeze_priv() both
reset before deleting the virtqueues for the same reason.

Fixes: dbb301f91fc8 ("virtio_blk: add error handling support for add_disk()")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9dc..ed97dafebe164 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1547,6 +1547,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return 0;
 
 out_cleanup_disk:
+	virtio_reset_device(vdev);
 	put_disk(vblk->disk);
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
-- 
2.43.0

