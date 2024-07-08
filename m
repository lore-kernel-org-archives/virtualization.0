Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C136B11
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424919; cv=none; b=AmDq3bTSXGync/gzzZo6bl9vS1MrR2lh0m+xVM4df5eKJmSi5mnEsY8LyAOYs36osNRlYl471LT/1GswnAV8OqJcjtlAiFMbjc6yv0teuBF+ew+Tkryxsce2Iy3hS+VWfKTTCS0Bi70ULB+VH7MXe2Mohd0tN3G9g3CKtjed8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424919; c=relaxed/simple;
	bh=c3WXl3B3CNV8p5t/WoRkex6Wx1voS6E6J/WZG25IGS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTI8bcBGsYZ2nj126+/1eR+/vBh2GNlv6xXrY3UaXMSqAxhb0foATZpgOZF0q97wHeAvs+X7eJZe8eejhCKz/DyXJzpIken2cBPh2qetEjAgvKSERGJbmR83t6Fhy1jhdIuJnozJSOy3kPpVtTb+lqjsJV1xeowbqlnjO0DAEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=U/CJiKTv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="U/CJiKTv"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3678f36f154so1926301f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424916; x=1721029716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZUcAqrULzWGmkg91F9cyeog2be9bbjMRm9ngzyA4To=;
        b=U/CJiKTvWMQ2uUek1jneD64g8oZjirOPK6UY7fd54s9pZY02IU2/jK2mvCx2oFsGnx
         9pxB0BTDnoW8UuhHagX7Yn0M11SH5V1FITekl5zjebIq0iFEFdb/xv2QRcNoWzh/6qH4
         So8XIvDWouOsyLWr3vYFfA2FGZjY996WLF8chVh1PoxAW8Sa0jOEfY/bcfd3YVeUanXb
         G1MwdvEymknh0cg0CgMrykHo8XIHIWuWTaN5qzP47YoLPStqUszGHjiTGbEXgIMYu5vd
         mXaqUOYSi5nBStVoP0XRad2cTF6k8KN2A9bOd1p4NuJURLxhC3deTRVZZ18/Bogyy+fx
         PxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424916; x=1721029716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZUcAqrULzWGmkg91F9cyeog2be9bbjMRm9ngzyA4To=;
        b=uVR10XO1arcUAwhmk7ZwhlhLH9UR9xc77Cu9S5JCqXeoVfkr1P8b6V0SMcZJlxBNEH
         YcMC0u1b4cyRi7XaYZNpQB71wEL/foibLWt1lBwi+gdO2DwygN/EvCV3b/nsz+XAPDKh
         EiA7eRfC+QLwC6ZZal4zePr1Fl9AG4YqMY8shNzacJ9fAuPG4bGK4JIWPm0/7Acz9A19
         olXEW6ozAIzVDvMYjb2u/lPEoyiEL6GwixDDs5+b+dZmx2+igQbqOLh5Rhtpsj8zEzSG
         jmmgJbOh2GBSFUKDV9+/LbU+YZSg0glUEIwsc5Fg8u8LilR+/0iDHBb786e3DAIhrPJz
         rjCw==
X-Gm-Message-State: AOJu0YycVIEfXtOwXLlVAnh64Uz7GfnlWP1TKs0Y2TxnAXV9CG1kMnNB
	Ra/Av07MA9HwN8Vx2yN7k+pN5uD2uDzWplMPyRRhEAVJS99K80xDwixj491qk7lvcPh59MJofUm
	hDk0=
X-Google-Smtp-Source: AGHT+IHcFaFo+fDMxql0Qlk+Yn/O6qckGmmfuGCX3UNyZu2BeQ4v/sGFEVsicEp7UtZ3d7tHXzC7Vg==
X-Received: by 2002:a5d:6849:0:b0:367:9614:fb99 with SMTP id ffacd0b85a97d-3679dd31137mr7320076f8f.10.1720424915970;
        Mon, 08 Jul 2024 00:48:35 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a193621esm9353693f8f.86.2024.07.08.00.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 11/19] virtio_console: convert to use virtio_find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:06 +0200
Message-ID: <20240708074814.1739223-12-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
References: <20240708074814.1739223-1-jiri@resnulli.us>
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

