Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F122224FA
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864731; cv=none; b=a+riYBovF/2+ddKwcC/Cxgpc/bMMOoONigreouxaPWm9gN4nNv0c+tXsVW0zJ8s5GWYyPUjALbtiRr1FDGUXwtmJC//qO/TLKucZeWUPU3GWmbrNFgv5Z2H3FKRMHgUL0882uDfcd8io6xGbAlNQ0WIbKfSgvexe59o2VEsBdS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864731; c=relaxed/simple;
	bh=FNPAmZC9QW0FcXQDJ4HDqkQLOrQ452JWlOTpJCafqw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibLg595G0onxUnpQZ+jxEty9BITPCW1CZZcJmfd7MarW58YwROeoLDLbIV5c7iBdf0r7wK5uGXwTyHLhanGqOvYKVJuuD2DOngpROfRWxV0Q0LsPNZBrVDlbWwhkGyewxHbCMZ5U2NuQ1alyNokGZEaFrgKnuBODCTyo75pbdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0tH/4Z0; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0tH/4Z0"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4414d76270cso25709fac.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864729; x=1783469529; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3CY3QZ2wnue9rhqKHqLfVQqYV670BNtYmleR0mKcr4=;
        b=d0tH/4Z0N3muO/lVb/PeeuT4GVxGdUsyw79s4J302/nUoYsFviJQQxdd1+S7ffn54K
         tQBscSJXVIaMkuBH1LuAmS+0lIQFxuV1ikhs3cl6RkL4vn31jdqGJSxrnfAJ0SxrEvpZ
         NuO4vG/A0LlLESBblRcKv3IWHeP+o2c/qAsDDOyM5mAnMOVlCwaTY4aVsG/w8UCtw3p/
         nsS4DV5q3iTo3ESspbKBTnUiqT6xwBw3n7hLhfQSj3m9pop8IkctcoBl2ciJmDvfLA3d
         LwDDThjlcX/UiqJjGrfZMnldGYUKl0uUVBWs/tlAGrlMTC5UVam5I00V/chIcxFqTprc
         Z/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864729; x=1783469529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y3CY3QZ2wnue9rhqKHqLfVQqYV670BNtYmleR0mKcr4=;
        b=LbFX1beAr/xbLDnCRNx42a7UJgdqH1jszYhL57t6P+qhVqvlv47z7ssm/FqJvJYQJ9
         jkkEOkjQEoPOp7goEawUX/xM7V11wvmq6S+OK8uxQDodzm0M8USwi5dOvMrtw9bWDV1x
         B32IcR72057SdpWWoY59q3Mt+v6GJsMMsbgrnv6BDtx/ilmonfY02oK/n+WQxwfVCZ/U
         ixrNSEFQ/gi/UzMCynfr+G6EiDxQvaseKwyLLFUOWfhZIDPNb2RG94eViZqY8VEis+xQ
         s3JSvk6ShezcDOyrho5IOEDpE8hJTus5xXZU23NfdmbKHrn0PhuOHRvg8Vi+PG7h/NXY
         cg3g==
X-Forwarded-Encrypted: i=1; AHgh+RrS8Vm/eFlANw2bDx+Fq7Pqm6+qdpxd7HkrZzJEUx3jk4GkFL9wUesKZLZZQCYTlLh7xG2vKLvQJc2fNM+7XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeRdQBjaSlwibo2Zc1tZh57jjvGUGA0A/L+Y055WzlODIwhv2P
	I7g8oo5y724vwd6jikwAxbXtECKD6NTB1xEcruCe4pmvJcchKLAh257v
X-Gm-Gg: AfdE7cn1jBO372IW/Dh2o3ZIO/bI2neGHmRvt7N8JPF3zAwU5DqJjwSgqqPQ7YnoO8i
	3U90dIP7L8/OmtRFE1u/4udzsiRxY7as2nP5BOsBXmAPke2WXbgulrpo4OM7pOMAYrfV/3oLAsj
	Y+V65C5PmUbvv0ErRWFmSqt96cX/ljZJMlpEpZRDRItJQHu1FuHKUavAO4rwdQKewhXvP8VwH+y
	7TZ6UVS3Huegw1BMmoEKnImi/O0vxz/NYrLiRcHPcceJXe7YAq0A7TzvotI2xQqb0El8CFabNxc
	3/VT/HNoFziLJbSO0Yefn3i6BP5ds+1BWWbBxt8ZHK4s3JnL4Kxny9NRqSzUb3j2N77E17Whho/
	iytcKXH7gL7r7sDvGNq6armao1B75f5dfITbVRZXnTvfmSDsp4cq+z1CUWPUoTPVipCi5r6cnnC
	8v94ivOQ3o2Lj2AaH8383MGBap7zC5h0boyxOGPQ24nmjx+Ty3yxqYYSDf1r/l6PxR
X-Received: by 2002:a05:6871:7297:b0:448:ca59:a162 with SMTP id 586e51a60fabf-448dc9b8df0mr4555071fac.34.1782864729159;
        Tue, 30 Jun 2026 17:12:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c685ae7a3sm272526fac.16.2026.06.30.17.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:12:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev (open list:FUSE FILESYSTEM [CORE]),
	linux-kernel@vger.kernel.org (open list),
	virtualization@lists.linux.dev (open list:VIRTIO FILE SYSTEM)
Subject: [PATCH v2 14/18] fuse: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:29 -0700
Message-ID: <20260701000949.1666714-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert fuse iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dax.c       | 10 ++++++++--
 fs/fuse/file.c      |  8 +++++++-
 fs/fuse/virtio_fs.c |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8b53625ac7ab..e8d8c9f5d728 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -653,9 +653,15 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static int fuse_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, fuse_iomap_begin,
+			     fuse_iomap_end);
+}
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin = fuse_iomap_begin,
-	.iomap_end = fuse_iomap_end,
+	.iomap_next = fuse_iomap_next,
 };
 
 static void fuse_wait_dax_page(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..5c0d400629cc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -890,8 +890,14 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int fuse_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, fuse_iomap_begin, NULL);
+}
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
+	.iomap_next	= fuse_iomap_next,
 };
 
 struct fuse_fill_read_data {
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index df25d4faca41..84e699f88574 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1024,7 +1024,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
 }
 
 /* Map a window offset to a page frame number.  The window offset will have
- * been produced by .iomap_begin(), which maps a file offset to a window
+ * been produced by .iomap_next(), which maps a file offset to a window
  * offset.
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
-- 
2.52.0

