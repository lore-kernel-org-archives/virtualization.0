Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88527A103
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419528; cv=none; b=MdMB2VvxnvdEV5viNo/XMmDeyIlqLiA+eHwXcLuHgsIIXcQ4uXqtMiO9UldGC+eVNZOWvZSqBTarxWWjQgyMWHdCmavoSEiNKXxKCEl2yY/TaPTMdynT18BABMWu5NNSvzVqKvTKEtnU+MGlnIsxCk8jAvNvyiOaipru4g66PNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419528; c=relaxed/simple;
	bh=LMbD+mGVr4R54oqbuSPJjT7hgxHNDpTTEhrQ8kp91Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NzLTwHHiRj6plMh+I1juxN/EXKknMrpc3TEbm2+hMTtUPwcTrt2FJGOEPx12U7lfLZmM7ijFS9NtcG/X2mUb8fHpByJia8tzZoJ+JQsRyPeL/0i++l/p8b2aXgFy9Ld73C359FS8kVNJ2saxu/AgXcXEUZ2KCSVldZ4Mze4N12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=MxklyrKT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MxklyrKT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so26035735e9.3
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1766419525; x=1767024325; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HctcY/WyAFhr2CuJcQ/EAsavvvLqYgvVfTp40T2+6/U=;
        b=MxklyrKTOVJer6kC/aYwRMgZ3I6/9JBNnbYuVg/F1Gwb0ytg5IuLoe/HdV6YG/MvJP
         2dUcsSTy8GSZ4FMAfs0GA5rA8y7DROyg3cC29bCOs22MYUEHiVi3M0K1+sgutcFbFv7u
         xNfjrR3L/lLM2uqcNyl/l7uyLXaSJQedoqPSEL7ezB3J3I35lqu4I+1kMSN4rvVrrC/Y
         yjeAy3ftUM2JJnQIsYonX7XlFhZfnvnWI9v9RBnE7jjMxWXilhYbjY89UR0p1UDU+uJE
         PBPD9mPqTWUCHeUDtsaev0fa8XltZ7gJxg6TCovuE0s+Ox48oBIYhqmZw6DRQP7rdQ97
         pD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766419525; x=1767024325;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HctcY/WyAFhr2CuJcQ/EAsavvvLqYgvVfTp40T2+6/U=;
        b=fd7EgnDHQCHZpHa38U8o/T/OJAw7Z0n/tbsxTHIlVB2UrgWxlNCj2QSGe7ZDsMa8kX
         p/u6dlEKo7/HBLZqwW01OEMWi+oESGn3/cdnEn4TafS72XtapXPmOvdT3HAWB6FRt0rT
         sfILR1fm72YrpSiXTikCj3VXgS7DBMuAhYn5SfqJ6aa0gIw0vcf1IptkhoGZE1LOH3EM
         rcA55lDWvyHjrIatDUsWqzoS3uNth4NyP4W/WGNVOeZKyyUehzRGNfswX+ww0w5vconQ
         hsQlskyQ8DDTW9AAD/nOf5IhALmSax5iQTZ6EVEsaetoXimaT12UEGMltaZKsp35Rq0c
         LVmQ==
X-Gm-Message-State: AOJu0YxU72GbcIYTwoOyE+hXk8OoitlSQfskBWYPoVb0pOmsmYFMBS0m
	Q/Y4UtOvuDR0bka+oOGq1HVgmRXDcczmi321XYfCluYhtCNFNJhON/DpQA5mi4dms2IRr6B7vj8
	LZnOM
X-Gm-Gg: AY/fxX4UC6NC9Aqr1iVAfobTvr4ozfldFLalmqdvYN9sP5TP3F4q/g8MeSN/0W764q9
	J+2jp6FrdXpcsN8getjwzZcxPWu2+ugxGtCIniacrsIw4FEveicamS9BlWH9rfesHP10bRVwjbP
	Z4nom4DoluZnUIjPu85h37ibmtoZxXQ3Fflbx5SdSymayBsGOt/kt+u+mh6HKex3iK+yJ4ITaQ3
	Fuxnk+Rj6kRcPUb2/rjxlmMUSykSJXwLRlHDkP+IAaCmfhhbqaCM/0wDhgKoUvr2ew6nAHCB+3J
	YUUq2owic6tpz+0hAxQNMHXk8caHst5tnUQeDTMb4ay+Qrmuv7guFGh+YbEv1fEgA4oavOgKHsF
	XffMQcyyeE/mOPpeKHkaWInuDbIJkfobyO2Z8Uy9+KzSsagHNdjQGllJ0VVYu1phoTY6nwgVT0f
	dH186LhOiQNbGUHnk=
X-Google-Smtp-Source: AGHT+IGSknRdbsa5PQMVNQHcORhsGBo5WTH0vm6MkjJM8fZl6NeQc1jKFM6m/ElAUYfOJ5bhBHDSTQ==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr12613044f8f.46.1766419524478;
        Mon, 22 Dec 2025 08:05:24 -0800 (PST)
Received: from fedora.fritz.box ([2001:a61:11b4:1201:32:bc57:e0b3:1183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm22954962f8f.37.2025.12.22.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:05:23 -0800 (PST)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 22 Dec 2025 17:04:53 +0100
Subject: [PATCH v2] virtio: console: fix lost wakeup when device is written
 and polled
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com>
X-B4-Tracking: v=1; b=H4sIACRsSWkC/43NQQ6CMBCF4auQrh1DawbUlfcwLJoyyETskLZWD
 eHuVk7g8nuL/y0qUmCK6lwtKlDmyOILzK5SbrT+RsB9sTK1QW00QuaQWMCJjzIRTBITvOydnjP
 UAzaNQ9cfcFAlMAca+L3Fr13xyDFJ+GxfWf/Wv7JZg4b2ZNFhe9RI7YWjZDuRT3snD9Wt6/oFT
 8iq9cgAAAA=
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
Changes in v2:
- Call reclaim_consumed_buffers() in out_intr instead of
  issuing another wake.
- Link to v1: https://lore.kernel.org/r/20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com
---
 drivers/char/virtio_console.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54debd6029ea2c2a5542d7a28500e67b8..351e445da35e25910671615a8ecc79165dfc66b7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -971,10 +971,17 @@ static __poll_t port_fops_poll(struct file *filp, poll_table *wait)
 		return EPOLLHUP;
 	}
 	ret = 0;
-	if (!will_read_block(port))
+
+	spin_lock(&port->inbuf_lock);
+	if (port->inbuf)
 		ret |= EPOLLIN | EPOLLRDNORM;
-	if (!will_write_block(port))
+	spin_unlock(&port->inbuf_lock);
+
+	spin_lock(&port->outvq_lock);
+	if (!port->outvq_full)
 		ret |= EPOLLOUT;
+	spin_unlock(&port->outvq_lock);
+
 	if (!port->host_connected)
 		ret |= EPOLLHUP;
 
@@ -1698,6 +1705,7 @@ static void flush_bufs(struct virtqueue *vq, bool can_sleep)
 static void out_intr(struct virtqueue *vq)
 {
 	struct port *port;
+	unsigned long flags;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
 	if (!port) {
@@ -1705,6 +1713,10 @@ static void out_intr(struct virtqueue *vq)
 		return;
 	}
 
+	spin_lock_irqsave(&port->outvq_lock, flags);
+	reclaim_consumed_buffers(port);
+	spin_unlock_irqrestore(&port->outvq_lock, flags);
+
 	wake_up_interruptible(&port->waitqueue);
 }
 

---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20251215-virtio-console-lost-wakeup-0f566c5cd35f

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>

