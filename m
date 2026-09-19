Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3E3AD52D
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807203; cv=none; b=MyTiPd81am/YL0JvjwRP1Kyjx9CckgREj8TIqdIdaCHyQsLLccCnZIWMmSsK0kf6flqXjMrpDXLAU544df1GLRoNmE/+L51lLGqBCqIuArxsuc0VwKIc6YY8pPdpdaKUwCJIbiWFCfTGro58cU+DI3C26jclrtwUOdd3gTu9pU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807203; c=relaxed/simple;
	bh=zE6k5Ig59a6BiWfQcHQLflmwTOVEnPsyzyhXJKlVBpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oBKVEH7vichI+HHVRP6MCRetCKPlXE/1CRxD+GMzW/EGYlzV2WIQaL0u99M3v+9HfH3tBMGKHG/RIoktJhtziTWy1TPlXWqOVkD5AjIofQreXMXN6rM2pgDejZ6/gfZpn0E8sFW+OLqS/kKUJqOE3/6/gFxbfBPfpd5revdvMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ3yruZe; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ3yruZe"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so1670052a12.3
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807200; x=1790412000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjxeXk0B5Zhbon0UoJLU1d05zMabiWk2BOUao5Ox3BI=;
        b=eQ3yruZeiwCepTms7y0l8jJZKgRwsNh/j7sDC9dt93P8fk4hhzRERYevigUl14IkrI
         G8XFiuijkhn3fSPBohL4y+/GiNfC5mRDLUTYnhh229gZQd1Vup77/9tkPXKVRyFGG0IM
         of667Z4sjHpBF8YmuJ3iC4nmbrXP66hYUmgvWIOQZXb/1UhwfaK5XEMhZDO9yJTPsmbk
         wKdYVlNj1dH1LfVzpcew2EoiCXDF2IkjJVVhp1rLy228dfrQGN7fPq1MGdJpT59ZOHgu
         EGYiTbINDvjA/9nZMl3Nf1oHf9bAU72eC6pjXvPHX4/QsNud/MM+bnVW/Drs/Ndtz/g1
         bEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807200; x=1790412000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjxeXk0B5Zhbon0UoJLU1d05zMabiWk2BOUao5Ox3BI=;
        b=tYMX+v5jMSdURTSFzlZHvWBBj1OrGdkfu5sz1j6fQ5MmobuU8NHIC7AqtDhJQyLe75
         USC+DuNhcgMyBPwGhN/ALuMaxAKSf5BBNi1UetEerYnH7RwzspfNCUk9Vn5WPs4Eh6yt
         zdMI92t6cg/5Sjn2bvlPcQKWcWxbSLTSSM7zGHEgjeKlYLHN0nKFT6aUDUKi7I432h0S
         5G+ZcW++LUhyBfHxOVu6kXtQ9wfZGqlobyZhIEaUEpDpZggqdzEIg3ruoedeJU0b1nXq
         ggrIbaHITN8KRDQ3aH5dIIPT9P45btw77bcxQzPXCGszgrKATBbFOsBgHL4YZIyR4s8Q
         8ojg==
X-Gm-Message-State: AFuF++mj2+WiNussyYlJVUJdsOspvPVxgffyLQhm3oaQ/1FJso/A1MiL
	SQXH9eXc3fJmqwJH7lGXYk3oLK7M8d1hOIVfw/6gtqaEDydp1zxQCPZj
X-Gm-Gg: AYBFou0gIPyDHPq0w+Dzpk8/TVfH1KkDVSDiAcCLpVxeZHTxYHQoE1qZI+u8HdKJueG
	esYpq2wvD1+GMm6wDFG84WoYZ3MFLsu6ILb9jUyuEVih7C2IDDWdXJMB1U/KZpLywY2OIAWjh4N
	CIdy/cyMFHYVNAeC2plsXzNA+6Udrr11FCMmqSdb8c6WwJCble6XAwZwafdHAxQd7KEDGlxBnA5
	acLllz50HQBmP22SanMDqDi3n+5FyUYntEGsSFXi0Zv7XHxyfJwxVzmwAwwWOnIQaV7CSdZhX93
	w6Yigp9wrbnKmFVRhN0a0G0ujCpyQoqAxw79YG2t9WutYm/aGIPQ6GmI/iWJeo2PFi+VZNriXFC
	lzNoj52Z+1Ma3sCoO5npGs4/8ifXePEhWdI7z7Unfr8TQJwFUwbg3brO3G8da5iuP2yCMlj3WDv
	CyqEt/jujmPXih+6OtgnkP+uifFugMc4hYwIteuBTJViYqvvt0B6u1TqOUwNeDlRxS7X7SxqKN3
	d2LHqIV
X-Received: by 2002:a17:90b:558b:b0:39e:6c69:9b93 with SMTP id 98e67ed59e1d1-39e6c69b270mr3178636a91.56.1789807199634;
        Sat, 19 Sep 2026 01:39:59 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55bfec0sm6425596c88.7.2026.09.19.01.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:39:59 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] vduse: avoid infinite loop when no affinity CPU is online
Date: Sat, 19 Sep 2026 16:39:33 +0800
Message-Id: <20260919083933.104437-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If all CPUs in vq->irq_affinity are offline, cpumask_next() walks to the
end of the mask, and the loop then resets the cursor to IRQ_UNBOUND and
restarts the scan. When VDUSE_VQ_INJECT_IRQ is issued, the intersection of
vq->irq_affinity and cpu_online_mask is empty, so the caller busy-loops in
kernel context on its current CPU (e.g. CPU2).

Replace the while loop in vduse_vq_update_effective_cpu() with
cpumask_next_and_wrap() to find the intersection of vq->irq_affinity and
cpu_online_mask in a single wrapped scan. If the intersection is empty, set
curr_cpu to IRQ_UNBOUND and let the existing unbound workqueue handle
injection, avoiding repeated rescans when all CPUs in the affinity are
offline. Use cpus_read_lock()/cpus_read_unlock() to keep the selected CPU
online.

Fixes: 28f6288eb63d ("vduse: Support set_vq_affinity callback")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 49a231b..f953353 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/cpu.h>
 #include <linux/eventfd.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
@@ -1430,14 +1431,10 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
 {
 	int curr_cpu = vq->irq_effective_cpu;
 
-	while (true) {
-		curr_cpu = cpumask_next(curr_cpu, &vq->irq_affinity);
-		if (cpu_online(curr_cpu))
-			break;
-
-		if (curr_cpu >= nr_cpu_ids)
-			curr_cpu = IRQ_UNBOUND;
-	}
+	curr_cpu = cpumask_next_and_wrap(curr_cpu, &vq->irq_affinity,
+					 cpu_online_mask);
+	if (curr_cpu >= nr_cpu_ids)
+		curr_cpu = IRQ_UNBOUND;
 
 	vq->irq_effective_cpu = curr_cpu;
 }
@@ -1672,10 +1669,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		index = array_index_nospec(index, dev->vq_num);
 		if (!vduse_vq_signal_irqfd(dev->vqs[index])) {
+			cpus_read_lock();
 			vduse_vq_update_effective_cpu(dev->vqs[index]);
 			ret = vduse_dev_queue_irq_work(dev,
 						&dev->vqs[index]->inject,
 						dev->vqs[index]->irq_effective_cpu);
+			cpus_read_unlock();
 		}
 		break;
 	}
-- 
2.34.1
