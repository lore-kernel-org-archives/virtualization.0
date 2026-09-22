Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B93E6DFA
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080204; cv=none; b=EWYNixf1Al3hg7b/ZhoswlV4dQtRZdh7fZhNuVeNZsPLLWG/GDtsCi9dmMp0fQlVTOsfLrqSbKtRXqTmQYXAZiaEzQWbKtObm7Xr/APwypWTox62sfUCc8bkErGectS0XQOgRsKovq0XKdfkR97rQcpgp1eq1u9rzgiBSdXpRPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080204; c=relaxed/simple;
	bh=5Dk7dds7UmISQ/2v9i4UVig/uA0/ad+4B2F0rHm/DOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAjmUPArQXRsDWnrs5AjacIUOoYrhqWv5rfFZcbJ5RMG9PHXNGmr3+wSAqn1GcTH/oCtSG1SEEWEfMZnaVBh6KSD3KLoc8aeHe9AXaxqb4/Nzby8jExU2/3nWb5slB7ilXLzHr2XsBOgHnOG2U2AI4PRylCk5EV107yD6eqwYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=g5W/ZvS/; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="g5W/ZvS/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790080198; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oQB+xtAD5KZGAfEEgSaFnU89mf3ldcR0f6mL0uIVlAI=;
	b=g5W/ZvS/1grC1SCeP/flknu2aYqKlWHRIPcqz+VZfUwxmU5TQAz4ga1Yq0GTUntamr5Rdx/Z4YuwCGJ3cJaFRRsZkFfRf8rLh1GDA0q4PhP4vmfK01ZCDso5url4CgQg1Sl9zKSwMVMM7niZV6m49MIMvNgMsjak8jfzWrOTAwc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0922767|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00425737-0.000751315-0.994991;FP=7925488823215324254|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jK24y74_1790080197;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jK24y74_1790080197 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 20:29:58 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xie Yongji <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vringh: bound top-level re-entry into indirect tables
Date: Tue, 22 Sep 2026 20:29:54 +0800
Message-ID: <20260922122955.69433-2-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922122955.69433-1-fangxy@xiaopeng.com>
References: <20260922122955.69433-1-fangxy@xiaopeng.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __vringh_iov(), the F_INDIRECT branch descends into the indirect
table and continues before the descriptor accounting runs. A top-level
indirect descriptor is therefore never charged to count. If such a
descriptor sets NEXT to point back at itself, returning from the
indirect table resumes at the same top-level descriptor, which is again
not counted, so the walk never makes forward progress.

Because count stays flat and indirect_count is reset to 0 on every
return to the top-level table, neither bound in the loop check trips.
A guest can spin the vringh worker at 100% CPU inside __vringh_iov(),
an uninterruptible host DoS.

Move the descriptor accounting above the indirect switch so that a
top-level indirect descriptor is charged one top-level traversal step
before the walk descends into its table, bringing this re-entry under
the existing vrh->vring.num bound. Each top-level descriptor is still
charged at most one step and indirect_count still bounds a single
table, so legitimate chains (including the multiple-indirect case in
tools/virtio/vringh_test.c) stay within vring.num, while a cyclic
indirect descriptor is now rejected with -ELOOP.

Fixes: dbd29e075228 ("vringh: Fix loop descriptors check in the indirect cases")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/vhost/vringh.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f..f672e11 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -333,6 +333,17 @@ __vringh_iov(struct vringh *vrh, u16 i,
 		if (unlikely(err))
 			goto fail;
 
+		if (up_next == -1)
+			count++;
+		else
+			indirect_count++;
+
+		if (count > vrh->vring.num || indirect_count > desc_max) {
+			vringh_bad("Descriptor loop in %p", descs);
+			err = -ELOOP;
+			goto fail;
+		}
+
 		if (unlikely(desc.flags &
 			     cpu_to_vringh16(vrh, VRING_DESC_F_INDIRECT))) {
 			u64 a = vringh64_to_cpu(vrh, desc.addr);
@@ -358,17 +369,6 @@ __vringh_iov(struct vringh *vrh, u16 i,
 			continue;
 		}
 
-		if (up_next == -1)
-			count++;
-		else
-			indirect_count++;
-
-		if (count > vrh->vring.num || indirect_count > desc_max) {
-			vringh_bad("Descriptor loop in %p", descs);
-			err = -ELOOP;
-			goto fail;
-		}
-
 		if (desc.flags & cpu_to_vringh16(vrh, VRING_DESC_F_WRITE))
 			iov = wiov;
 		else {
-- 
2.50.1

