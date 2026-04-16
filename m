Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57613242B8
	for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382685; cv=none; b=X245JkarsOIUmqAO0y3mrbI5J54znSQkrDQHj3C+0eVZkLalcJyLgATjnrKkVf3a4m/yQiuOXfbeOuSzT0Y9J1bOe68LCtyto2xa5FvpfxnU3vna+tcQ4uofq47kfR8UUyQD/FyNHK+HvhqQ8+0Q5xfn5VB6y4M0UbpxOZdF4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382685; c=relaxed/simple;
	bh=1hm+B86G5D9G/MCdxoIY2wItu3QHzV/wLiy7jMjCweY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q4Pg5qlBM6AWkP0IdUsKK1SgcZpTUfN99DlglLJHUFEx8SjGPuYCaC+a59vXYbUpD52g2dk0rRCiOCr9xzIYgivrjVpJHcasu0GQkvNlLigNt5FiEAmoJ9tbtdlpUNnW+8F9b52MVyzzi3zzOsqgZViagljk9r5KRznrdbbs6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUfN8HP3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUfN8HP3"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c796163fac5so60475a12.1
        for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382683; x=1776987483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKqud54K8Q9ymiWL5Jl6Wgt+D0YrAG8IY+dffFgFtSk=;
        b=RUfN8HP3uL9AEhNvL85dzxaBTS3An49ZaKsAka7D5YjtUdhosi9UbXweT3q4YXpJC+
         QlutsM6vrIbNr1QogIaw+ehtnuCEVeiAci0qyv58u62aYchw5WPrlA/E1IpOTLVBYMbY
         SDgUmrin9zpc70n3qccL1E1nRRaTQYyhm4B8QNWOlfn9KVjNcJ8ARdo1WjKMv1pROb3M
         5tILCCo/BXVjqSXh/OdRSAuJQjom3VqMPXC+Uaf3SC5qi8zzLPSOyY3m/zErjsi5AGez
         hApSBHVUZnWbZUR1mWZTYj8vvUmYp3Sqt3ehSJHAbN8DzcFwXXlkzHNgCNaawR6FJjih
         Bxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382683; x=1776987483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKqud54K8Q9ymiWL5Jl6Wgt+D0YrAG8IY+dffFgFtSk=;
        b=HQAGB4Io3OKbTV7J4C255GSaUeRULuE5zLzYVJrPNpD1RT10zWQ3Mnotw6sv8dVvHo
         33/rHfT5ngx5CUckJUBElRuYsI/CjrM2Vdnxvl37indX2FzKR5QjqOY/2aWFCC4uOEgw
         SYanosF3vE56lYB6Q5Q7iQ4E1r31GQgWTYMDyb+el6SDwFLLYOBMartxJX6aI+2H8FDN
         XfDGm5gFUp/Syk5uXgBNYmbIARCkc4WIyAU7TLVu+JalsS6RRlzAOgSxjmi2+CtCxywX
         nEWwwCMXo++zGkmS0WVal3C9ADqUybg4I4V9ETWirm69iyfw6wdkTZwKbzElq5tH6Ore
         CVgg==
X-Forwarded-Encrypted: i=1; AFNElJ/0PzG8b4dGeb3YmI/IwE7jUXNuHg9KIQDota6pKgmHCE4iLAKAxAEXVEpDZP/4/TEdWzVDCoynDgRhTGrdxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyZRB+zzU+nCF5NDE/VoU5I4qYwdfQgKGKety1Tbilix6TdpO5
	rgPgU31gQaZwILFYldpz3Ua6jBiMiUJYVNumnbL+DtQgzIL+EDdXouFl
X-Gm-Gg: AeBDies8WUeIJcJQ5yp+Yfh2abz8bgpUTxinAhZl/UKPpfMj+dSQaQ3ODMgdwsEfVEo
	NAEmzli8Uwv19c/PIGfUDbS4LzOk9Hh0FzWiQoGDW7iNy+UMYm80Bk3V1mwZ3AIKlsM0AuJuK+P
	wfTaxKkx29cWI1alfxvHHMyhtiaNHd0hw3qfjLP9ftOHjhrhSh8gNCRCYAA9o4OU3FR+hLpW7C/
	vCJBG2xhEuVAhwhasM6W2z2D5t0uEhcd4jDaC2+pbFjHDPBoDwjraMKc4xDYPGEktrRj6IHE6LN
	iB7NoXX1nMOv1w8wS4XpQXVWadBDaq9e1Myw8VN54cACIK3wdJ2/Em0SAPUEtDJBcz6h2WHCmtt
	fRSkVonvQ0EMdyZHcGwNxVszkggiFDF8vCRQjVgTklaZXT3iYBiLlxTnU/AYBd4boeub+dc9lFd
	Rv8Ikhf0uyrMPH23tHSxbTE8DzLQkuhA1VBVin5Ui0vyivrqQ=
X-Received: by 2002:a05:6a00:3cd1:b0:82f:8a29:e3b4 with SMTP id d2e1a72fcca58-82f8c97f212mr270310b3a.50.1776382682407;
        Thu, 16 Apr 2026 16:38:02 -0700 (PDT)
Received: from localhost ([188.253.126.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8cb6fabbsm135513b3a.33.2026.04.16.16.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:38:01 -0700 (PDT)
From: physicalmtea <physicalmtea@gmail.com>
To: amit@kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	JiaJia <physicalmtea@gmail.com>
Subject: [PATCH] virtio: console: fix use-after-free after failed restore
Date: Fri, 17 Apr 2026 07:37:53 +0800
Message-Id: <20260416233753.134082-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JiaJia <physicalmtea@gmail.com>

virtcons_freeze() tears down the virtqueues through remove_vqs(), but
remove_vqs() only deletes the virtqueues and frees portdev->in_vqs and
portdev->out_vqs. It leaves port->in_vq, port->out_vq, portdev->c_ivq,
and portdev->c_ovq pointing at the old queues.

Those stale pointers survive a failed restore:

  virtcons_freeze()
    -> remove_vqs()
       -> del_vqs()
          -> vring_del_virtqueue()
             -> kfree(vq)

  virtcons_restore()
    -> init_vqs()
       -> virtio_find_vqs()

If init_vqs() fails, virtcons_restore() returns without rebinding the
per-port queue pointers. Later get_chars(), __send_control_msg(),
control_work_handler(), get_inbuf(), reclaim_consumed_buffers(),
__send_to_port(), fill_readbuf(), and splice_write can still reach those
cached pointers and trigger a use-after-free or Oops.

A fault-injection-assisted hibernation run that forces init_vqs() to
fail reproduces this as a KASAN slab-use-after-free in
virtqueue_disable_cb() from virtcons_freeze() on the subsequent PM
path.

Clear the cached virtqueue pointers when queues are deleted, guard the
direct queue users that can still run after a failed restore, and make
queue-less open/write paths fail immediately instead of sleeping or
succeeding against a broken port state.

Signed-off-by: JiaJia <physicalmtea@gmail.com>
---
Runtime evidence from a fault-injection-assisted hibernation run that
forces init_vqs() to fail with -ENOMEM:

  virtio_console virtio1: virtcons_restore: init_vqs failed: -12
  virtio-pci 0000:00:02.0: PM: failed to thaw: error -12

  KASAN report: slab-use-after-free in virtqueue_disable_cb+0x20/0xb0
  Read of size 4 at addr fff000000417c848 by task virtio-console-/1
  The buggy address belongs to the object at fff000000417c800
    which belongs to the cache kmalloc-256 of size 256
  The buggy address is located 72 bytes inside of
    freed 256-byte region [fff000000417c800, fff000000417c900)

  Call trace:
    virtqueue_disable_cb+0x20/0xb0
    virtcons_freeze+0x1f8/0x208
    virtio_device_freeze+0x98/0xd0
    virtio_pci_freeze+0x28/0x60
    pci_pm_freeze+0x94/0x1a8
    dpm_run_callback+0x118/0x4e0
    device_suspend+0x210/0xa40
    dpm_suspend+0x258/0x628
    dpm_suspend_start+0x78/0x88
    hibernation_restore+0x28/0x188
    load_image_and_restore+0xd0/0x118
    hibernate+0x2cc/0x430

 drivers/char/virtio_console.c | 57 ++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c6..05887bdb5 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -464,6 +464,8 @@ static struct port_buffer *get_inbuf(struct port *port)
 
 	if (port->inbuf)
 		return port->inbuf;
+	if (!port->in_vq)
+		return NULL;
 
 	buf = virtqueue_get_buf(port->in_vq, &len);
 	if (buf) {
@@ -547,6 +549,8 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 		return 0;
 
 	vq = portdev->c_ovq;
+	if (!vq)
+		return -ENODEV;
 
 	spin_lock(&portdev->c_ovq_lock);
 
@@ -583,8 +587,8 @@ static void reclaim_consumed_buffers(struct port *port)
 	struct port_buffer *buf;
 	unsigned int len;
 
-	if (!port->portdev) {
-		/* Device has been unplugged.  vqs are already gone. */
+	if (!port->portdev || !port->out_vq) {
+		/* Device has been unplugged or the queues have been torn down. */
 		return;
 	}
 	while ((buf = virtqueue_get_buf(port->out_vq, &len))) {
@@ -603,6 +607,8 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	unsigned int len;
 
 	out_vq = port->out_vq;
+	if (!out_vq)
+		return -ENODEV;
 
 	spin_lock_irqsave(&port->outvq_lock, flags);
 
@@ -684,7 +690,9 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 		spin_lock_irqsave(&port->inbuf_lock, flags);
 		port->inbuf = NULL;
 
-		if (add_inbuf(port->in_vq, buf) < 0)
+		if (!port->in_vq)
+			free_buf(buf, false);
+		else if (add_inbuf(port->in_vq, buf) < 0)
 			dev_warn(port->dev, "failed add_buf\n");
 
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
@@ -777,6 +785,9 @@ static int wait_port_writable(struct port *port, bool nonblock)
 {
 	int ret;
 
+	if (!port->out_vq)
+		return -ENODEV;
+
 	if (will_write_block(port)) {
 		if (nonblock)
 			return -EAGAIN;
@@ -786,8 +797,8 @@ static int wait_port_writable(struct port *port, bool nonblock)
 		if (ret < 0)
 			return ret;
 	}
-	/* Port got hot-unplugged. */
-	if (!port->guest_connected)
+	/* Port got hot-unplugged or lost its queues. */
+	if (!port->guest_connected || !port->out_vq)
 		return -ENODEV;
 
 	return 0;
@@ -919,6 +930,8 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 	 * regular pages to dma pages. And alloc_buf and free_buf must
 	 * support allocating and freeing such a list of dma-buffers.
 	 */
+	if (!port->portdev || !port->out_vq)
+		return -ENODEV;
 	if (is_rproc_serial(port->out_vq->vdev))
 		return -EINVAL;
 
@@ -1039,7 +1052,6 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 		ret = -ENXIO;
 		goto out;
 	}
-
 	/* Allow only one process to open a particular port at a time */
 	spin_lock_irq(&port->inbuf_lock);
 	if (port->guest_connected) {
@@ -1047,6 +1059,11 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 		ret = -EBUSY;
 		goto out;
 	}
+	if (!port->in_vq || !port->out_vq) {
+		spin_unlock_irq(&port->inbuf_lock);
+		ret = -ENODEV;
+		goto out;
+	}
 
 	port->guest_connected = true;
 	spin_unlock_irq(&port->inbuf_lock);
@@ -1141,7 +1158,8 @@ static ssize_t get_chars(u32 vtermno, u8 *buf, size_t count)
 		return -EPIPE;
 
 	/* If we don't have an input queue yet, we can't get input. */
-	BUG_ON(!port->in_vq);
+	if (!port->in_vq)
+		return -EPIPE;
 
 	return fill_readbuf(port, (__force u8 __user *)buf, count, false);
 }
@@ -1666,6 +1684,8 @@ static void control_work_handler(struct work_struct *work)
 
 	portdev = container_of(work, struct ports_device, control_work);
 	vq = portdev->c_ivq;
+	if (!vq)
+		return;
 
 	spin_lock(&portdev->c_ivq_lock);
 	while ((buf = virtqueue_get_buf(vq, &len))) {
@@ -1869,7 +1889,11 @@ static int init_vqs(struct ports_device *portdev)
 
 free:
 	kfree(portdev->out_vqs);
+	portdev->out_vqs = NULL;
 	kfree(portdev->in_vqs);
+	portdev->in_vqs = NULL;
+	portdev->c_ivq = NULL;
+	portdev->c_ovq = NULL;
 	kfree(vqs_info);
 	kfree(vqs);
 
@@ -1882,6 +1906,7 @@ static const struct file_operations portdev_fops = {
 
 static void remove_vqs(struct ports_device *portdev)
 {
+	struct port *port;
 	struct virtqueue *vq;
 
 	virtio_device_for_each_vq(portdev->vdev, vq) {
@@ -1892,9 +1917,17 @@ static void remove_vqs(struct ports_device *portdev)
 			free_buf(buf, true);
 		cond_resched();
 	}
+	list_for_each_entry(port, &portdev->ports, list) {
+		port->in_vq = NULL;
+		port->out_vq = NULL;
+	}
+	portdev->c_ivq = NULL;
+	portdev->c_ovq = NULL;
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
+	portdev->in_vqs = NULL;
 	kfree(portdev->out_vqs);
+	portdev->out_vqs = NULL;
 }
 
 static void virtcons_remove(struct virtio_device *vdev)
@@ -2094,7 +2127,7 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
 	virtio_reset_device(vdev);
 
-	if (use_multiport(portdev))
+	if (use_multiport(portdev) && portdev->c_ivq)
 		virtqueue_disable_cb(portdev->c_ivq);
 	cancel_work_sync(&portdev->control_work);
 	cancel_work_sync(&portdev->config_work);
@@ -2102,12 +2135,14 @@ static int virtcons_freeze(struct virtio_device *vdev)
 	 * Once more: if control_work_handler() was running, it would
 	 * enable the cb as the last step.
 	 */
-	if (use_multiport(portdev))
+	if (use_multiport(portdev) && portdev->c_ivq)
 		virtqueue_disable_cb(portdev->c_ivq);
 
 	list_for_each_entry(port, &portdev->ports, list) {
-		virtqueue_disable_cb(port->in_vq);
-		virtqueue_disable_cb(port->out_vq);
+		if (port->in_vq)
+			virtqueue_disable_cb(port->in_vq);
+		if (port->out_vq)
+			virtqueue_disable_cb(port->out_vq);
 		/*
 		 * We'll ask the host later if the new invocation has
 		 * the port opened or closed.
-- 
2.34.1
