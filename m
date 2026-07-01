Received: from outbound.baidu.com (mx20.baidu.com [111.202.115.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E6C4E40C5C5
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905793; cv=none; b=Mp/Wmc6iygLP2tJVEhyGhUp3VckRYzFEgIw7FYZ0QlodgXUX/zr8wjntJxyUaUBShQhHwUzH1zJohqrZCbxNKRuo7MNaYHHMr+K2Io8sj8lwdGVv57ttLNCxT5lnDGhg9VrKjVJ1cRIuWPGcecIMFY7dE0PjHWXRjKHxMxRFocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905793; c=relaxed/simple;
	bh=QO8EeXB8Bj2OQ22Uo9hZGE5QSPRthJKedX3IT3AgBiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BuRDav5gzkd1/OzYt8APGukw5k4R8Ja9pX2z3plTEIqdGkKZ0adsvZLMuLBKsiX1GNIufDJ5caypoTqLyIFmQ/Bn001HYXqyAOTdmxKMUsD6bUHZA7TPf3omGnPafSIqUv8BCxN+XEMbQzho7X/1Nz92XAFcn56PTVAP7w1sPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=XqvaW6gy; arc=none smtp.client-ip=111.202.115.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="XqvaW6gy"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Kees Cook <kees@kernel.org>, Rosen Penev
	<rosenp@gmail.com>, Parav Pandit <parav@mellanox.com>, Eli Cohen
	<eli@mellanox.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] vdpa/mlx5: fix wrong list iterated in add_direct_chain error path
Date: Wed, 1 Jul 2026 19:36:08 +0800
Message-ID: <20260701113608.1972-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1782905776;
	bh=CoYJpEbZ56thAfO6zV4Sc6UIMmxA3NKqalo3aQx64Y4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=XqvaW6gyjrSIpqgcc+RLILYm7TxUKVIBBwWdgClPZGt4w3iH35quhLxLbmUHlQdNy
	 R+hgL8IF3l+fjzdFIHvclEL3UpMyphaYzaRh4Qtn4gsgesHPZ7RwVqxRYT6vwz4FMr
	 pTBRfUIqq/PNM5o8BOqB9aKWLn+Q9rggz/GvMutZg9wN1mgGBMk3Zz5/1jqAsEWuHN
	 xanCnOg15Ouf9k63kKULxqvlyNCT1/P8fzhe60Xbz/IvUeaGMj6tBXcCHcf8CpRslT
	 1r7NGn77t0JNcgcvlDP8ooIk8mJnj+AxIUJjt/2S95TLhZThao8l5Vg594Xdre1YVQ
	 4j28hRA7IsyRA==

From: Li RongQing <lirongqing@baidu.com>

In add_direct_chain(), newly allocated direct MR entries are added to
the local list 'tmp', which is spliced into mr->head only on success.
On the error path, the cleanup loop was incorrectly iterating over
mr->head instead of tmp.

Fix by iterating over 'tmp' in the err_alloc cleanup path.

Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/vdpa/mlx5/core/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 6d02ccf..1a224f0 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -480,7 +480,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 
 err_alloc:
-	list_for_each_entry_safe(dmr, n, &mr->head, list) {
+	list_for_each_entry_safe(dmr, n, &tmp, list) {
 		list_del_init(&dmr->list);
 		unmap_direct_mr(mvdev, dmr);
 		kfree(dmr);
-- 
2.9.4

