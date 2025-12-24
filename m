Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663E3148D0
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766573707; cv=none; b=ewXiJS6wlDu2s9L0LbU/q59n42/JBZclCRM/2YjPfQGYapKm2B2oBMfudYq5iNZfRvEELD8r3IUpfuSygDcakHdeT/DoDplqzeuuZb5z5U1ghNZw29lLPFJ2PAedXJCC08lxEMQjXqsGsZpLWvHvYjFWs9sl2CkepehWDk/6qUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766573707; c=relaxed/simple;
	bh=YJxxyVUIH0LKd1472HrqzJ1zqvb7vGfc8Y7LGrUbm8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eNgGAoYD8SIPi7szITPARDOaDJuJrXF0TN8Wp+bgOKXIrJ/cGnBIIbZx3Rc/Y4IT8hU9zIuzldCZI1QHdqGVqXKaBjJ/+KzkrdJ3szuPv2yIDG6B7RPdSpWR5SoSXtNMY07h+1uhu6M6dW/JFDZhfRnimmV6VZ+Mq9dRA+v+yxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=IG5KpWDc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="IG5KpWDc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso31784555e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1766573702; x=1767178502; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6YVPObAxph0NNzQqXtKmHrXXfkoVXAgC9K27LINgZDk=;
        b=IG5KpWDc+b42bQrXlurCSo5ZiH2dKK6PbJ5RL1+iagGZd/1/jn9Te1MJVkA9xT0ICr
         HUFr310jq3Knk1E2OySC/1wvmDdwZR076RdCHMzWnIc7vDqJncUsr/1XSBSY9IzkXPmU
         Fue72XU2sSVLg1spAp6juofdm1Tfzewz+mS3qzMzx9DEcBEg941vrsJVzuai/D7k2xf/
         I9VAfBpGfcct775lDdlIi4KERUsMAITWoaTvjYrl2CzS+BBWqneyv1JOz5NzdahJlnry
         h6h6MOHJD3mTd4jcj336x5l366whJczB35kXKoaetQYsYOq/XqB/TJAefyixzyJqbar/
         w5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766573702; x=1767178502;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YVPObAxph0NNzQqXtKmHrXXfkoVXAgC9K27LINgZDk=;
        b=uU24dvhF6Eqtcft7n4jUf7gSY6/fQ2cv+BjLx0y1+1AhLpitQzRYFLgl0q32R70Rq+
         Hk2cTFMh5pppBfnXpfzX5DQMNDPe6KP5Tbi01w+QWawKsXP2gLyw/e3Lipjx/CfKS8QL
         PS0gUviUdRAzPZw/R60s7fz0btY4A3EuCSSqT70ngv3gR68f/AD4xyznmOOrUQUx0+LT
         xXODconJLorG0OZlkb8MG296LxzMmvLBacyAcPWA1JS8uWGibFdO8jxR4kxqwjpOwbAE
         R86EDLwoAj/sU8zZAZIsPaX6PoSXS+oUlDkcQYC2bOJh/l3Ox5S9Z4JJyi9Q+VIMv7Qx
         DBzw==
X-Gm-Message-State: AOJu0YxL0wkZtLP03vmFRa847ALfr0RklLtzoVUjy1xA5BSktHc5MVY1
	NeWomMloEz8ALlLhrbwmf5o9CP2I1TyZGrKyzv2jByeIWaDcSTGCihsAepUtG+DM1FU=
X-Gm-Gg: AY/fxX56c7kEeBEtKi8oRWUhtuNqyZxH0Zq+xBWtrJWbAxHif/eEh5qizUaCLVXBQhK
	Vb7DYSA4pbr1iOvo50bIj2A4rsFm3GH5x7BZB6atSpAzU5lxfc5uT1wbdwbndOrd8dL6p2o6W5v
	vJ0natE1VUGZwzILpBMMRFFcNUTLKtSrSkNIo+2j8WHnNJQNO/AeNGgpCDN9w8urCA9AnnY9/6O
	GPzVe0umbPTv+Yz31Uy0K7+6y5PA7j4hTUL54uO7EXEttEbGB0uMc9yVQ2Vahk96y0cdK89vNi+
	x6aZaOC3V5FAuBMwvcFTJnLPiNXYHL7RvA1PHsvGI/WC+G2nI88AUObH/tfMJA46A2g41SE5o5O
	ys9q7Rlyad62ZoQS449b96hnuYgX9e/WYzrldDpNidDEIOJHH5JUyAAVLUtL+1NXLn/KhFgzRJH
	ZEVtjKEk0DIs0ADa/c
X-Google-Smtp-Source: AGHT+IG2oGo0/KRl8OLMUZV/2O7F94LGNUSLFxYl9Aa7ZK9BDlk3PbNHbqqE6+JW5GXsU4J5C4/cfQ==
X-Received: by 2002:a05:600c:35c4:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-47d195869e7mr203405325e9.28.1766573701534;
        Wed, 24 Dec 2025 02:55:01 -0800 (PST)
Received: from fedora.fritz.box ([2001:a61:11d9:dc01:f21:4d89:1b7a:e08d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27c2260sm331937075e9.15.2025.12.24.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:55:01 -0800 (PST)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 24 Dec 2025 11:54:46 +0100
Subject: [PATCH v3] virtio: console: fix lost wakeup when device is written
 and polled
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251224-virtio-console-lost-wakeup-v3-1-b8ee6812fa68@isovalent.com>
X-B4-Tracking: v=1; b=H4sIAHXGS2kC/43NsQ6CMBSF4Vchna2hbS6Ik+9hHGq5lRuRkrZWD
 eHdLUzGwTj+Z/jOxAJ6wsD2xcQ8JgrkhhxqUzDT6eGCnNrcTJYShBTAE/lIjhs3BNcj712I/KG
 veB95aaGqDJhWgWUZGD1aeq748ZS7oxCdf61fSSzrX2wSXPC60WCg3gnA+kDBJd3jELfG3dhCJ
 /nBSfmTk5mDFhtlzsoKI765eZ7fsY5KyBcBAAA=
X-Change-ID: 20251215-virtio-console-lost-wakeup-0f566c5cd35f
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

A process issuing blocking writes to a virtio console may get stuck
indefinitely if another thread polls the device. Here is how to trigger
the bug:

- Thread A writes to the port until the virtqueue is full.
- Thread A calls wait_port_writable() and goes to sleep, waiting on
  port->waitqueue.
- The host processes some of the write, marks buffers as used and raises
  an interrupt.
- Before the interrupt is serviced, thread B executes port_fops_poll().
  This calls reclaim_consumed_buffers() via will_write_block() and
  consumes all used buffers.
- The interrupt is serviced. vring_interrupt() finds no used buffers
  via more_used() and returns without waking port->waitqueue.
- Thread A is still in wait_event(port->waitqueue), waiting for a
  wakeup that never arrives.

The crux is that invoking reclaim_consumed_buffers() may cause
vring_interrupt() to omit wakeups.

Fix this by calling reclaim_consumed_buffers() in out_int() before
waking. This is similar to the call to discard_port_data() in
in_intr() which also frees buffer from a non-sleepable context.
This in turn guarantees that port->outvq_full is up to date when
handling polling. Since in_intr() already populates port->inbuf we
use that to avoid changing reader state.

Cc: stable@vger.kernel.org
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
As far as I can tell all currently maintained stable series kernels need
this commit. Applies and builds cleanly on 5.10.247, verified to fix
the issue.
---
Changes in v3:
- Use spin_lock_irq in port_fops_poll (Arnd)
- Use spin_lock in out_intr (Arnd)
- Link to v2: https://lore.kernel.org/r/20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com

Changes in v2:
- Call reclaim_consumed_buffers() in out_intr instead of
  issuing another wake.
- Link to v1: https://lore.kernel.org/r/20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com
---
 drivers/char/virtio_console.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54debd6029ea2c2a5542d7a28500e67b8..e6048e04c3b23d008caa2a1d31d4ac6b2841045f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -971,10 +971,17 @@ static __poll_t port_fops_poll(struct file *filp, poll_table *wait)
 		return EPOLLHUP;
 	}
 	ret = 0;
-	if (!will_read_block(port))
+
+	spin_lock_irq(&port->inbuf_lock);
+	if (port->inbuf)
 		ret |= EPOLLIN | EPOLLRDNORM;
-	if (!will_write_block(port))
+	spin_unlock_irq(&port->inbuf_lock);
+
+	spin_lock_irq(&port->outvq_lock);
+	if (!port->outvq_full)
 		ret |= EPOLLOUT;
+	spin_unlock_irq(&port->outvq_lock);
+
 	if (!port->host_connected)
 		ret |= EPOLLHUP;
 
@@ -1705,6 +1712,10 @@ static void out_intr(struct virtqueue *vq)
 		return;
 	}
 
+	spin_lock(&port->outvq_lock);
+	reclaim_consumed_buffers(port);
+	spin_unlock(&port->outvq_lock);
+
 	wake_up_interruptible(&port->waitqueue);
 }
 

---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20251215-virtio-console-lost-wakeup-0f566c5cd35f

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>

