Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5C4F887
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919985; cv=none; b=t+FrodUNrU1tPHW0MVEGAbRMvcVowgAGrLWWmmHhHUNFQd/8ffjRZgLnIiDnd2Y1YzjFeG7obWzUPu5t1Xvu+ZLZA67wdsg8bun4zniFNY4ZFlJz22RJrErtORhCeF27vkQ1XWqPF+WZoLKMuMpsNq8JNq+ZmIvabnoG/z9/o5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919985; c=relaxed/simple;
	bh=GhHUS0qNgMKXHhSXNAAzftwt3OGmUS1ag6QLR7q1+lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CCF6/PYvpE8F647eoH0F1ZqnIcbd+SCAVkaYGvHORXg7JKDfVkLSBhpYvv7gbWBFE/YUIcrF1gpHqche5lbM6DbcMa0a/gUAGjR4d97mxlkytbK6C6dM5wYCOT0jj5gHT0ZKvqCqXTc3TY1yxEwsBac1hDymUyvXfnXfsj3TG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fqk4M5Xe; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fqk4M5Xe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708919981; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UXXJovU2AesrIYqdlrvFTpqhm0SaeJKemqLy2O2LCkE=;
	b=fqk4M5Xe/o9QPDoSG5qKoiv1sJ8i8iEbEmK1pcSd3A+aCOmN6+ExfiQsjsf0aCaTlbgtnd3nBsq6MM3N27QvVM8/HhJS/XoyRQMzEpRM4i1sZyJBVMLf4CU6dBdJ8BSsA2rGeYm/fqjRncflODjFno3dcvwyhAG0SkWIm9mg5Fc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W1AMyXd_1708919967;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1AMyXd_1708919967)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 11:59:40 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: airlied@redhat.com
Cc: kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/qxl: remove redundant code
Date: Mon, 26 Feb 2024 11:59:26 +0800
Message-Id: <20240226035926.102859-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable num_relocs is not effectively used, so delete it. Having two
labels seems somewhat redundant; the 'out_free_release' can be removed,
leaving 'out_free_bos'.

drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: warning: variable 'num_relocs' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8316
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index dd0f834d881c..c1dd5709d37a 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -145,7 +145,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	struct qxl_release *release;
 	struct qxl_bo *cmd_bo;
 	void *fb_cmd;
-	int i, ret, num_relocs;
+	int i, ret;
 	int unwritten;
 
 	switch (cmd->type) {
@@ -196,11 +196,10 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	if (unwritten) {
 		DRM_ERROR("got unwritten %d\n", unwritten);
 		ret = -EFAULT;
-		goto out_free_release;
+		goto out_free_bos;
 	}
 
 	/* fill out reloc info structs */
-	num_relocs = 0;
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
 		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
@@ -230,7 +229,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
-		num_relocs++;
 
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
@@ -261,7 +259,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	ret = qxl_push_command_ring_release(qdev, release, cmd->type, true);
 
 out_free_bos:
-out_free_release:
 	if (ret)
 		qxl_release_free(qdev, release);
 out_free_reloc:
-- 
2.20.1.7.g153144c

