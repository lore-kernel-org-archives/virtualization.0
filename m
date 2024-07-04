Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D41B11EB
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103664; cv=none; b=mWeDs++Mi9+WQB465m4/IngHbSpGgf/YjNaq3aT9NA4k+e6NrMxhWSLMegJsQxjuYkQy7DwWRfCs5rxW++ba8rGMxo34ecoNWG3IgYBocYHZ3c6tTT1FXfsDKpmJgfHEk+qZ2/SCI27lAj+/3NWN3Lr+fOhX5dzBMN9ARqPYFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103664; c=relaxed/simple;
	bh=c3WXl3B3CNV8p5t/WoRkex6Wx1voS6E6J/WZG25IGS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLo97twlbXE4DbntBBe3uD8OA+ebDO+dSHwjlNtXWkrTOGyXPtpdL4f6+623F/2VLC+t8oq8V1OD+CIWa94mswM9Y26zKWqfLiIaz1wydMH78/pSVOH5H0ZiGhncRmQiHNtVTsL/KeRqgy2XjME79bF7JtII7OaAuAhVAWfH72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Nsk0Gleq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Nsk0Gleq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367895d9991so394817f8f.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103661; x=1720708461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZUcAqrULzWGmkg91F9cyeog2be9bbjMRm9ngzyA4To=;
        b=Nsk0GleqhFhjuPl9LU/hhe71hekppp+8pTYT4A2MtMsKMsW2H2zYdTc/uUnfOkPy8M
         p+s0pbOBekdGPtDzPUCe9Dr27ehWb6lk++2T8VbW/rYfg7UTHwLLFq3+E0DRRTzPOHZ6
         WPmcqdk53vfArKqOvCW6U1JEghaG6yfk8XuS1WL8eT3lDMphe8gy/PP+AjyqVgg5Utm5
         pM7VNLlNuj5JgurOB9XsfWHOsuiTvMPKSGDeY02Sc0aJ5ODHXgSYAyIn+1PRXk2dW5B1
         l1QHmuqPEiXLOzplcipkF+doD4lyZaslYgsumAJVdQxB8Ylupy4PnWICzHVU62NMtkFl
         DAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103661; x=1720708461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZUcAqrULzWGmkg91F9cyeog2be9bbjMRm9ngzyA4To=;
        b=JV/NfW4l5gkdrveakjA6IxSBKvTRGpi5yUyRDPqEx15+0iL0L+HJJRHWDPYFelJ8Kg
         7HqBgB2fTausxgtk0qyMC/eflsBe3j4kypvZkVmvm72TvCD710Wak7zu2E6tDytDWJDc
         nGfjT8Da4IDDHpz3Z2l9GOrUNkKl9W0iq+5SCtdRfZ7lvIqTtCp9kNz92Z3OXe2b4kTU
         ex+gPsmruozjqQbvuFVNyfPWodjBcVNNF3dpYkh4be7l9qAe55//mmsfSjMkFZymj2Bi
         xV+93aCtZeuTSd2WCPtQzp+2F7lSXIVXk/vM9lusHwLvr74QC/YqKe3gKYW0rKJnMzxl
         KqSA==
X-Gm-Message-State: AOJu0YzAyMUrsdRHUuwdwNVZkP9IjBU6c7VQ1aWTpa3rL1/x9drJRLW9
	yegpIK2H9BA77AHP2pI3EVU0FJJWF3uSjtXjkIUeG1H267AOr1xt+0gmr+EGbvWYa9VpBIgfA0Z
	S/Cs=
X-Google-Smtp-Source: AGHT+IG/Y+7cRdPeJeJbmtGb6E2YTL4vAQKDIFcDHDBuDxqdnf0cXx+1rvecULh80HuxRKdFUveaNQ==
X-Received: by 2002:adf:e3d0:0:b0:367:8c3e:2316 with SMTP id ffacd0b85a97d-3679dd72610mr1319130f8f.66.1720103661426;
        Thu, 04 Jul 2024 07:34:21 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e12fcsm18592249f8f.48.2024.07.04.07.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 11/19] virtio_console: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:32:59 +0200
Message-ID: <20240704143307.1212454-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704143307.1212454-1-jiri@resnulli.us>
References: <20240704143307.1212454-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/char/virtio_console.c | 44 ++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d9ee2dbc7eab..903d83a1ffe8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1804,8 +1804,7 @@ static void config_work_handler(struct work_struct *work)
 
 static int init_vqs(struct ports_device *portdev)
 {
-	vq_callback_t **io_callbacks;
-	char **io_names;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
 	u32 i, j, nr_ports, nr_queues;
 	int err;
@@ -1814,15 +1813,12 @@ static int init_vqs(struct ports_device *portdev)
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
 	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
-	io_callbacks = kmalloc_array(nr_queues, sizeof(vq_callback_t *),
-				     GFP_KERNEL);
-	io_names = kmalloc_array(nr_queues, sizeof(char *), GFP_KERNEL);
+	vqs_info = kcalloc(nr_queues, sizeof(*vqs_info), GFP_KERNEL);
 	portdev->in_vqs = kmalloc_array(nr_ports, sizeof(struct virtqueue *),
 					GFP_KERNEL);
 	portdev->out_vqs = kmalloc_array(nr_ports, sizeof(struct virtqueue *),
 					 GFP_KERNEL);
-	if (!vqs || !io_callbacks || !io_names || !portdev->in_vqs ||
-	    !portdev->out_vqs) {
+	if (!vqs || !vqs_info || !portdev->in_vqs || !portdev->out_vqs) {
 		err = -ENOMEM;
 		goto free;
 	}
@@ -1833,30 +1829,28 @@ static int init_vqs(struct ports_device *portdev)
 	 * 0 before others.
 	 */
 	j = 0;
-	io_callbacks[j] = in_intr;
-	io_callbacks[j + 1] = out_intr;
-	io_names[j] = "input";
-	io_names[j + 1] = "output";
+	vqs_info[j].callback = in_intr;
+	vqs_info[j + 1].callback = out_intr;
+	vqs_info[j].name = "input";
+	vqs_info[j + 1].name = "output";
 	j += 2;
 
 	if (use_multiport(portdev)) {
-		io_callbacks[j] = control_intr;
-		io_callbacks[j + 1] = NULL;
-		io_names[j] = "control-i";
-		io_names[j + 1] = "control-o";
+		vqs_info[j].callback = control_intr;
+		vqs_info[j].name = "control-i";
+		vqs_info[j + 1].name = "control-o";
 
 		for (i = 1; i < nr_ports; i++) {
 			j += 2;
-			io_callbacks[j] = in_intr;
-			io_callbacks[j + 1] = out_intr;
-			io_names[j] = "input";
-			io_names[j + 1] = "output";
+			vqs_info[j].callback = in_intr;
+			vqs_info[j + 1].callback = out_intr;
+			vqs_info[j].name = "input";
+			vqs_info[j + 1].name = "output";
 		}
 	}
 	/* Find the queues. */
-	err = virtio_find_vqs(portdev->vdev, nr_queues, vqs,
-			      io_callbacks,
-			      (const char **)io_names, NULL);
+	err = virtio_find_vqs_info(portdev->vdev, nr_queues, vqs,
+				   vqs_info, NULL);
 	if (err)
 		goto free;
 
@@ -1874,8 +1868,7 @@ static int init_vqs(struct ports_device *portdev)
 			portdev->out_vqs[i] = vqs[j + 1];
 		}
 	}
-	kfree(io_names);
-	kfree(io_callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 
 	return 0;
@@ -1883,8 +1876,7 @@ static int init_vqs(struct ports_device *portdev)
 free:
 	kfree(portdev->out_vqs);
 	kfree(portdev->in_vqs);
-	kfree(io_names);
-	kfree(io_callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 
 	return err;
-- 
2.45.2

