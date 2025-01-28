Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969683A14
	for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043588; cv=none; b=bujrPJ8KVqwuEXf1J8nEBP/Ip+uLWY+uyN4gcM9yHJVBeOi4zdJwjkXdiEfk0ZVJuJecPqDC3rULBuQcKMw8dYjbMz1qD1yl+Dm+PzXcQUefDf4vdjCQEzSGaXmmpPTj7+HajDpp+GpYiE+ImdvJQUsu8ePbPbnDxdcw6f9iH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043588; c=relaxed/simple;
	bh=GpINQ6ZzddIbwxLm7ZXVzGSeC1OGdZ0QaoPbmgUO12U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgrQ7/8+C4H81+yc06Vw4VEPmB92DxPIeAs8uHR6vieErA86AGptnB8AEMOWUQIQFZGcyLr3JU+VEhghbtECJp2G8ZC+CmWw3TNfTAbrXD8B89aPqJiN8jweaSaDsU0kzpFvMA4QdT2aKWLIlxsa5Pga+wHPk5Chk3hCeDt+FOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N6gpdjc9; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N6gpdjc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hGv6v
	ULkxz5mbNHtJETmL6ilm0UrsXxB4x4eWmqlYG8=; b=N6gpdjc917QzSewqSH0oE
	etMxATe2iw6gTNA2clKnHrvh2vUmEjcF1aNmVLUoXTCdz1QN6Jr5HAt2Stc/Li9G
	t0G2gQo+fcAdUp6tAmEowXeRSqiqMsDokcmfowjoebw9kmi2IK/5I0B6jWGCBu7w
	m1Rq2DsdK1x7YZSD5T+f9o=
Received: from DESKTOP-DMSSUQ5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnz0yqcJhngcb0Iw--.31752S2;
	Tue, 28 Jan 2025 13:52:43 +0800 (CST)
From: oushixiong1025@163.com
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] virtio_console: Convert to use devm funcs
Date: Tue, 28 Jan 2025 13:52:41 +0800
Message-ID: <20250128055241.30760-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz0yqcJhngcb0Iw--.31752S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWDuFWxKw48uryxAw13Jwb_yoWrGr1xpa
	4kuF1rGFW8Jr47WrykXay8X3W5uanrAr1xKr9Fv3s7Kr15try8ZrySyFyq9FWrAr97CFW8
	AF1ktFWfJF1UuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joApnUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXA3iD2eYa7YjIQAAsc

From: Shixiong Ou <oushixiong@kylinos.cn>

Convert to devm_* funcs so that no need to manual free in error path.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/char/virtio_console.c | 43 ++++++++++++++---------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c62b208b42f1..657cf15dad55 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1811,15 +1811,17 @@ static int init_vqs(struct ports_device *portdev)
 	nr_ports = portdev->max_nr_ports;
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
-	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
-	vqs_info = kcalloc(nr_queues, sizeof(*vqs_info), GFP_KERNEL);
-	portdev->in_vqs = kmalloc_array(nr_ports, sizeof(struct virtqueue *),
-					GFP_KERNEL);
-	portdev->out_vqs = kmalloc_array(nr_ports, sizeof(struct virtqueue *),
-					 GFP_KERNEL);
+	vqs = devm_kmalloc_array(&portdev->vdev->dev, nr_queues,
+				 sizeof(struct virtqueue *), GFP_KERNEL);
+	vqs_info = devm_kcalloc(&portdev->vdev->dev, nr_queues,
+				sizeof(*vqs_info), GFP_KERNEL);
+	portdev->in_vqs = devm_kmalloc_array(&portdev->vdev->dev,
+					     nr_ports, sizeof(struct virtqueue *), GFP_KERNEL);
+	portdev->out_vqs = devm_kmalloc_array(&portdev->vdev->dev,
+					      nr_ports, sizeof(struct virtqueue *), GFP_KERNEL);
 	if (!vqs || !vqs_info || !portdev->in_vqs || !portdev->out_vqs) {
 		err = -ENOMEM;
-		goto free;
+		return err;
 	}
 
 	/*
@@ -1850,7 +1852,7 @@ static int init_vqs(struct ports_device *portdev)
 	/* Find the queues. */
 	err = virtio_find_vqs(portdev->vdev, nr_queues, vqs, vqs_info, NULL);
 	if (err)
-		goto free;
+		return err;
 
 	j = 0;
 	portdev->in_vqs[0] = vqs[0];
@@ -1866,18 +1868,10 @@ static int init_vqs(struct ports_device *portdev)
 			portdev->out_vqs[i] = vqs[j + 1];
 		}
 	}
-	kfree(vqs_info);
-	kfree(vqs);
+	devm_kfree(&portdev->vdev->dev, vqs_info);
+	devm_kfree(&portdev->vdev->dev, vqs);
 
 	return 0;
-
-free:
-	kfree(portdev->out_vqs);
-	kfree(portdev->in_vqs);
-	kfree(vqs_info);
-	kfree(vqs);
-
-	return err;
 }
 
 static const struct file_operations portdev_fops = {
@@ -1897,8 +1891,8 @@ static void remove_vqs(struct ports_device *portdev)
 		cond_resched();
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
-	kfree(portdev->in_vqs);
-	kfree(portdev->out_vqs);
+	devm_kfree(&portdev->vdev->dev, portdev->in_vqs);
+	devm_kfree(&portdev->vdev->dev, portdev->out_vqs);
 }
 
 static void virtcons_remove(struct virtio_device *vdev)
@@ -1941,7 +1935,6 @@ static void virtcons_remove(struct virtio_device *vdev)
 	 * away.
 	 */
 	remove_vqs(portdev);
-	kfree(portdev);
 }
 
 /*
@@ -1967,7 +1960,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	portdev = kmalloc(sizeof(*portdev), GFP_KERNEL);
+	portdev = devm_kmalloc(&vdev->dev, sizeof(*portdev), GFP_KERNEL);
 	if (!portdev) {
 		err = -ENOMEM;
 		goto fail;
@@ -1984,7 +1977,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 			"Error %d registering chrdev for device %u\n",
 			portdev->chr_major, vdev->index);
 		err = portdev->chr_major;
-		goto free;
+		goto fail;
 	}
 
 	multiport = false;
@@ -2001,7 +1994,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 				"Invalidate max_nr_ports %d",
 				portdev->max_nr_ports);
 			err = -EINVAL;
-			goto free;
+			goto fail;
 		}
 		multiport = true;
 	}
@@ -2060,8 +2053,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
-free:
-	kfree(portdev);
 fail:
 	return err;
 }
-- 
2.43.0

