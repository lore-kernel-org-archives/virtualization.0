Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879151;
	b=R0FDwvsq3hq0VFV2Tp7E+2u+N7vUrHtN0VptpWzvwUZ3Du6SujHGTtCUsQJrqYShsuZb
	 g7gg+GpG8qHM6Hia3WiOjbI7H8rAzmtLxSsB6imbtyZPg11MZJrYkUHUEOc8oqXU6SHjX
	 pOQg7SgheztT9QETwcmIJqXiss836n6RlH1Fw2SzJ+mw0JQpehmxjQ4ebo1ZLN3KXCyOG
	 /gu9ntozQ8drAWhqs/wVMJLMatmOImOWBpflU064IkKRbteb+KmP9jPGUY/gWkGUMluRS
	 cMRwYiYizlQ1mC95nKfNYnBBHQ5CrP8UygbxwWoiP/AXzwbm4He8ohLpxuhMIeC0wJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=15pU14wC+qRzWaNivBHeKFWVeFUX6sdrS3OUT9FNZzY=;
	b=sWMSFkxbAtBOaTHLmBDO4TceYwpK3nTPGIhaZ2f5l3IZH3YSNcH2ZqjSykz0JppubYrt
	 mOotkObBofZUibXbop4jbSr8iUBWm+YBRPDHSMKe017LUC3pMQMnXxueBk0PnFvRdZN1n
	 4YjlcGsj0ecQAFee81WFMmCokLB9SLenFltdYa+ZxWpyq94uq5HtBX+9ytWE+mQs/FzBc
	 53lop9FLoY5G5jiBi6FEIHRylzu9jGgz1Isuz2g9oNfQ+m24RxHa8+AfeHIGR2xhJJ54Z
	 BhPftC2Klrees8h0/yIn8088k7JZFhyEO5aHVK4i0GiPmN1kaU56b+3lf4ZLcHHXJVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UWn0O7/t";
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A6D606A915
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 11:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A6D606A915
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UWn0O7/t
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so527741c88.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793879150; x=1794483950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=15pU14wC+qRzWaNivBHeKFWVeFUX6sdrS3OUT9FNZzY=;
        b=UWn0O7/tOWHYyZOHQ/GqectX5r2kcJ5WLcAK/hAq+FPUt3LkH0GOjWe8eWuvND8YyE
         DsNsQ3lIrlDXPIXY4BHGUc+8AmDgnhjHhQuV4gd9i5K82MjXwx1sJqUNvJb2HLjfaJd8
         /nBdF30BqDmmdkR+H1bQuE5JilBWlRVU6NDNBWtWq9F6ORxp4UjMg/5dGCl5714jFPuA
         00D35nOxI3Mg79ygpEWuXFwuXnsB/64Aip+yN9VbpUTdkyAKJSdQnnFtCJ2GTc1ej++i
         nt7EWhMyruwVxSjhfDjQKCXI0EOij4ivKntA2Xy8fsir/fjY9pPS+ukcs8DDj6PtBXV0
         oH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879150; x=1794483950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15pU14wC+qRzWaNivBHeKFWVeFUX6sdrS3OUT9FNZzY=;
        b=OUKkvYIk9W4kP4Otq7SIVV7mP6yUljPD0uGOutKBGYjkVH+vfFFs0WbldM2JMu42fY
         DmvxC5tLS8AaQFh12qRBpJu8d3lnRbQ9jYEh9u0Ez7MWfVNge8pSA8gpNWgyF6UMqv3B
         OHuNK8ha/E2MuuJI5Wk21dBryD2GQdPLPkksp5Yzgpd/cIUUJmLf1vKbz2MBvj1QSRyI
         SknfZ0iCeqgtpCbv5/PuyNP6hGvTU0bawJx2MT/FhF90LMH8mD3CygviojZHsgQU4wdJ
         /tVcsR5o7qO5C9AIaARptU/Vuc4BWYjzJpb9gF9iNy0Lz0z/45+pYikGnN3Oq6likxmF
         /nCw==
X-Forwarded-Encrypted: i=1; AKwUvBzKrk31cQGivgHjY7SHOzgV6nAsieNUYejrJJDGhH0JW8OZZfIHYKjjJgHZtA6x7kImHLS7mMyxCNNDR9+WHQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5JpIipGF5o3GSmV47UIal7+DikBwcHTPFXApJ/+6+icS/q/cZ
	t+NSjTNQYYN78geFP3mbMy2SlLychkhEoDFKZcleUiR1HNPzxcy2vXzf
X-Gm-Gg: AYBFou3JB+JmbZPi88zB/1lRX6pLSKvubgRtaH0MQQ4CFscEzXtJANhcWe79QZ0iP+A
	CTUf+9vUNji8HbZJF85V4ubO6gEHydMMa5JAPi6qLE14ziSdP9fHDE1BYvkIeqr+Pwx+XJRdmyU
	rGqQ3FXWWRymyumYWwXDwbRVaH5JmvdieMj7Zw2sg5SyTegHUnyLg9dqk9BVzlto34lY7jI82Xd
	ej2GLWcpgNTKoU9i2mWo177RiEEoxEuzhz2MOjuu2jxfD1rRcBAEb9CMvcJYg6PmkJd+mmkKZUw
	9RB0uf2NMwVLRur+LADMVPicdYEydRftuYZGXGwtVzCRFo0nBTmwV+48wZoKE5aiRkNi/JIWLO/
	ttrSkOI4j1OEHq3haOZYa6tANaSUeJIiY7Bh9Nc15PDHjnZBWnkNDKVOUL8k5R+KEIPOcZR1/n0
	9+NpWl3MLqazLdf6o2j+EGb7KasQYCptlbfZH/g31uI8RvBC7LUBVCf4u4Kx/NVaiumckO8EWyw
	yNqyG5x9D9E4ZHGr+VlokYBMiGK5pvYb6tMhiWxN3Ko3ut6Y8IrOo5u0QD6TLKWjHwjJT2iVsNL
	XweLj5LCzYuykPRa6yBNAaxQJw2JRgeQwzkGcNM3vp1NdiU5g9g6uvyMYeeoArRWaYCJNFOi1GO
	/TFnrZ3A8CQ==
X-Received: by 2002:a05:7022:5f02:b0:166:862b:9bcc with SMTP id a92af1059eb24-1ac5ac4caecmr26940791c88.18.1793879149565;
        Thu, 05 Nov 2026 03:45:49 -0800 (PST)
Received: from lwq-System-Product-Name.. ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c772fdsm19035554c88.22.2026.11.05.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:49 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: rusty@rustcorp.com.au,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_console: fix buffer ownership and unplug races in the read path
Date: Thu,  5 Nov 2026 19:45:35 +0800
Message-Id: <20261105114535.972013-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read path hands port buffers to readers without any ownership
protocol.  Two threads sharing one file descriptor can both pick up
port->inbuf, copy from it concurrently and requeue it twice, and an
input virtqueue callback prefetching the next buffer can drop the
remainder a reader is about to put back.  During port unplug a
reader can also call add_inbuf() on a virtqueue that is being torn
down (KASAN: slab-use-after-free in virtqueue_get_buf_ctx), or
requeue a buffer nobody will free anymore.

Track buffer ownership explicitly:

- fill_readbuf() claims port->inbuf under inbuf_lock and owns it
  exclusively across the unlocked copy.  port_has_data() and the
  input virtqueue callback no longer prefetch the next buffer while
  a claim is held (nor once the port is being unplugged), so a
  partially consumed buffer is always finished before the next one
  and the byte order is preserved.

- A claimed buffer counts as data pending for the EOF and
  host-disconnect logic, so a peer reader sharing the file descriptor
  does not observe EOF while another reader still owns unread bytes;
  it waits for the claim instead.  A nonblocking reader gets -EAGAIN
  (or 0 when the host has disconnected and no data is left).  The
  atomic HVC poll simply retries.

- unplug_port() publishes an "unplugging" state under inbuf_lock
  before any teardown.  Readers stop touching the input virtqueue
  from that point; a reader returning a claimed buffer frees it
  instead of requeueing it.  free_buf() always runs outside the
  lock: the teardown, copy-fault and failed-requeue paths defer the
  free until inbuf_lock is dropped, so free_buf() may sleep for DMA
  buffers when called from a userspace read.  Nothing reads the
  buffer after it is freed, and the claim is always released with a
  wakeup, so readers waiting for the claim are not stalled until
  the next packet.

This issue was investigated and the fix was developed with AI
assistance (ZCode/GLM-4).

Testing with QEMU and KASAN injection (lockdep and
CONFIG_DEBUG_ATOMIC_SLEEP enabled in the test kernel):

- A shared-fd, two-reader test without unplug delivered all 20000
  records exactly once, with no corruption or reordering.  The
  unmodified kernel delivered 19979 of them more than once and only
  48 could be attributed to any consistent stream order.
- During concurrent unplug, readers received a valid contiguous
  prefix before disconnect, with no duplicates or KASAN reports;
  the same stall sequences produce six slab use-after-free reports
  per run on the unmodified kernel.
- A separate fault-injection run exercised 20 failed buffer
  requeues, all going through the deferred free path, without a
  reported use-after-free, lockdep splat or invalid-context sleep.
- With one reader parked while holding a claim and the host
  disconnecting, a nonblocking read from the second reader returns
  -EAGAIN instead of a premature EOF, and the following blocking
  read receives the remainder the first reader puts back; without
  this change the same sequence returns 0 (premature EOF).

Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off data from host to readers")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---

Changes since v1:
- v1 only fenced the requeue point against virtqueue teardown.  A full
  review of the read path showed the deeper problem: buffers have no
  ownership across the unlocked copy, so concurrent readers (threads
  sharing one file descriptor, or the HVC console poll) can duplicate,
  drop or reorder data.  This version adds the claim protocol and also
  gates the prefetch sites (port_has_data and the input virtqueue
  callback, the latter also once the port is being unplugged).
- A reader that finds the buffer claimed now waits instead of
  returning a spurious short read/EOF, and keeps blocking until new
  data arrives or the port disconnects; a nonblocking reader gets
  -EAGAIN (or 0 when the host has disconnected and no data is left).
- A claimed buffer counts as data pending for the EOF and
  host-disconnect logic: a peer reader on the same file descriptor does
  not receive EOF while another reader still owns unread bytes.  Tested
  with one reader parked on a claim while the host disconnects: the
  second reader's nonblocking read returns -EAGAIN (the same sequence
  returns 0 without this change), and its following blocking read
  receives the remainder the first reader puts back.
- A failed requeue no longer leaks the buffer, and nothing reads the
  buffer after it is freed.  Every free_buf() in the read path now
  runs outside inbuf_lock: the teardown, copy-fault and failed-requeue
  paths defer the free until the lock is dropped, so a userspace
  context may sleep in free_buf() for DMA buffers.  The claim is
  always released with a wakeup, including on the teardown and
  copy-fault exits.
- Claimed-buffer releases in the read path use can_sleep=false only
  through the atomic HVC get_chars() path.  Rproc-serial ports do not
  register an HVC adapter, so their claimed buffers are released
  directly by userspace readers with can_sleep=true.  Other rproc DMA
  buffers may be deferred by atomic cleanup paths and are reclaimed
  during unplug teardown.
- Fixes tag: blame shows the unsynchronized ownership handoff was
  introduced by the fill_readbuf() handoff commit (203baab8ba319).
- Tested with KASAN injection and, additionally, a lockdep and
  CONFIG_DEBUG_ATOMIC_SLEEP enabled kernel: shared-fd two-reader
  integrity, concurrent unplug with a valid contiguous prefix, 20
  forced requeue failures through the deferred free path, and the
  claimed-buffer/host-disconnect EOF case above, all without reports.
- This patch is independent of the other virtio_console read/unplug
  fix ("defer HVC polling out of the virtqueue callback"); both touch
  in_intr() in non-overlapping hunks and stack cleanly on the same
  base.

v1: https://lore.kernel.org/r/179378543196.71890.7555371342727156729@gmail.com/
 drivers/char/virtio_console.c | 214 +++++++++++++++++++++++++++++++---
 1 file changed, 201 insertions(+), 13 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5c..191dceb77df1b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -180,6 +180,23 @@ struct port {
 	/* The current buffer from which data has to be fed to readers */
 	struct port_buffer *inbuf;
 
+	/*
+	 * True while a reader owns an exclusively claimed inbuf outside
+	 * inbuf_lock, possibly sleeping in copy_to_user().  Nobody may
+	 * prefetch the next buffer meanwhile: the claimer's unconsumed
+	 * remainder goes back to inbuf first, or the prefetched buffer
+	 * would be dropped or the stream reordered.
+	 */
+	bool inbuf_claimed;
+
+	/*
+	 * Set at the start of unplug_port(), before any teardown.  The
+	 * read path checks it under inbuf_lock and stops touching the
+	 * input virtqueue; a reader returning a claimed buffer frees it
+	 * instead of requeueing it.
+	 */
+	bool unplugging;
+
 	/*
 	 * To protect the operations on the in_vq associated with this
 	 * port.  Has to be a spinlock because it can be called from
@@ -541,10 +558,28 @@ static bool port_has_data(struct port *port)
 
 	ret = false;
 	spin_lock_irqsave(&port->inbuf_lock, flags);
+
+	/* The port is going away; its vqs are being torn down. */
+	if (port->unplugging || !port->portdev)
+		goto out_unlock;
+
+	/*
+	 * A reader owns the claimed buffer, possibly sleeping in
+	 * copy_to_user().  Report data as pending for the
+	 * EOF/host-disconnect logic, but do not prefetch the next
+	 * buffer: the claimer's unconsumed remainder must go back to
+	 * inbuf first, or the prefetched buffer would be dropped.
+	 */
+	if (port->inbuf_claimed) {
+		ret = true;
+		goto out_unlock;
+	}
+
 	port->inbuf = get_inbuf(port);
 	if (port->inbuf)
 		ret = true;
 
+out_unlock:
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
 	return ret;
 }
@@ -692,24 +727,111 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
  * Give out the data that's requested from the buffer that we have
  * queued up.
  */
+static bool will_read_block(struct port *port);
+
 static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
-			    size_t out_count, bool to_user)
+			    size_t out_count, bool to_user, bool nonblock)
 {
 	struct port_buffer *buf;
 	unsigned long flags;
+	bool free_requeue_buf = false;
+	int err;
+
+	if (!out_count)
+		return 0;
+
+retry:
+	spin_lock_irqsave(&port->inbuf_lock, flags);
 
-	if (!out_count || !port_has_data(port))
+	/* The port is going away; its vqs are being torn down. */
+	if (port->unplugging || !port->portdev) {
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
 		return 0;
+	}
 
+	/*
+	 * Another reader (a userspace read() or the HVC console poll)
+	 * owns the claimed buffer, possibly sleeping in copy_to_user().
+	 * Prefetching the next buffer here would drop or reorder the
+	 * claimed data once the owner returns its unconsumed remainder,
+	 * so report no data instead.  The HVC poll will simply retry;
+	 * a userspace reader waits for the claim to be released.
+	 */
+	if (port->inbuf_claimed) {
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		if (!to_user)
+			return 0;
+		if (nonblock)
+			return -EAGAIN;
+
+		err = wait_event_freezable(port->waitqueue,
+					   !READ_ONCE(port->inbuf_claimed) ||
+					   READ_ONCE(port->unplugging));
+		if (err)
+			return err;
+		goto retry;
+	}
+
+	port->inbuf = get_inbuf(port);
 	buf = port->inbuf;
+	if (!buf) {
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		if (!to_user)
+			return 0;
+		if (nonblock)
+			return !port->host_connected ? 0 : -EAGAIN;
+		/*
+		 * The data we saw was consumed by another reader while we
+		 * waited for its claim.  Keep blocking like the fops-level
+		 * wait instead of reporting a spurious EOF: wait for new
+		 * data, a disconnect or the unplug fence.
+		 */
+		err = wait_event_freezable(port->waitqueue,
+					   !will_read_block(port));
+		if (err)
+			return err;
+		if (!port->guest_connected)
+			return -ENODEV;
+		if (!port->host_connected && !port_has_data(port))
+			return 0;
+		goto retry;
+	}
+
+	/*
+	 * Claim the buffer: we own it exclusively while copying,
+	 * without holding inbuf_lock.
+	 */
+	port->inbuf = NULL;
+	port->inbuf_claimed = true;
+	spin_unlock_irqrestore(&port->inbuf_lock, flags);
+
 	out_count = min(out_count, buf->len - buf->offset);
 
 	if (to_user) {
 		ssize_t ret;
 
 		ret = copy_to_user(out_buf, buf->buf + buf->offset, out_count);
-		if (ret)
+		if (ret) {
+			bool free_it;
+
+			/*
+			 * The copy failed: hand the buffer back with its
+			 * data intact, unless the port is being unplugged,
+			 * in which case nobody would free it anymore.
+			 */
+			spin_lock_irqsave(&port->inbuf_lock, flags);
+			free_it = port->unplugging || !port->portdev;
+			if (!free_it)
+				port->inbuf = buf;
+			port->inbuf_claimed = false;
+			spin_unlock_irqrestore(&port->inbuf_lock, flags);
+
+			if (free_it)
+				free_buf(buf, true);
+			else
+				wake_up_interruptible(&port->waitqueue);
 			return -EFAULT;
+		}
 	} else {
 		memcpy((__force u8 *)out_buf, buf->buf + buf->offset,
 		       out_count);
@@ -717,19 +839,57 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 
 	buf->offset += out_count;
 
-	if (buf->offset == buf->len) {
+	spin_lock_irqsave(&port->inbuf_lock, flags);
+
+	if (port->unplugging || !port->portdev) {
+		/*
+		 * The port was unplugged while we were copying: the vqs
+		 * are going away, so free the buffer instead of requeueing
+		 * it.  Runs outside the lock; sleepability matches the
+		 * caller's context (to_user == false is the atomic HVC
+		 * path, whose DMA frees are deferred by free_buf()).
+		 */
+		port->inbuf_claimed = false;
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		free_buf(buf, to_user);
+		wake_up_interruptible(&port->waitqueue);
+		return out_count;
+	}
+
+	if (buf->offset < buf->len) {
+		/* Data left in this buffer; serve it before the next one. */
+		port->inbuf = buf;
+	} else {
 		/*
 		 * We're done using all the data in this buffer.
 		 * Re-queue so that the Host can send us more data.
 		 */
-		spin_lock_irqsave(&port->inbuf_lock, flags);
-		port->inbuf = NULL;
-
-		if (add_inbuf(port->in_vq, buf) < 0)
+		if (add_inbuf(port->in_vq, buf) < 0) {
 			dev_warn(port->dev, "failed add_buf\n");
-
-		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+			/*
+			 * Defer the free: free_buf() may call
+			 * dma_free_coherent() (rproc buffers) when the
+			 * caller can sleep, which is illegal with
+			 * inbuf_lock held and IRQs off.
+			 */
+			free_requeue_buf = true;
+		}
 	}
+
+	/*
+	 * Release the claim.  Do not touch buf afterwards: it may have
+	 * been freed above (failed requeue).  Wake unconditionally:
+	 * readers waiting for the claim need a wakeup even when the
+	 * buffer was fully consumed.
+	 */
+	port->inbuf_claimed = false;
+	spin_unlock_irqrestore(&port->inbuf_lock, flags);
+
+	if (free_requeue_buf)
+		free_buf(buf, to_user);
+
+	wake_up_interruptible(&port->waitqueue);
+
 	/* Return the number of bytes actually copied */
 	return out_count;
 }
@@ -811,7 +971,8 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 	if (!port_has_data(port) && !port->host_connected)
 		return 0;
 
-	return fill_readbuf(port, ubuf, count, true);
+	return fill_readbuf(port, ubuf, count, true,
+			     filp->f_flags & O_NONBLOCK);
 }
 
 static int wait_port_writable(struct port *port, bool nonblock)
@@ -1206,7 +1367,7 @@ static ssize_t get_chars(u32 vtermno, u8 *buf, size_t count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	return fill_readbuf(port, (__force u8 __user *)buf, count, false);
+	return fill_readbuf(port, (__force u8 __user *)buf, count, false, false);
 }
 
 static void resize_console(struct port *port)
@@ -1400,6 +1561,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 	port->name = NULL;
 	port->inbuf = NULL;
+	port->inbuf_claimed = false;
+	port->unplugging = false;
 	port->cons.hvc = NULL;
 	port->async_queue = NULL;
 
@@ -1533,6 +1696,17 @@ static void remove_port_data(struct port *port)
  */
 static void unplug_port(struct port *port)
 {
+	/*
+	 * Mark the port as being unplugged before any teardown, so the
+	 * read path stops touching the input virtqueue: readers check
+	 * this flag under inbuf_lock and bail out, and a reader that is
+	 * returning a claimed buffer frees it instead of requeueing it
+	 * to a virtqueue that may already be gone.
+	 */
+	spin_lock_irq(&port->inbuf_lock);
+	port->unplugging = true;
+	spin_unlock_irq(&port->inbuf_lock);
+
 	spin_lock_irq(&port->portdev->ports_lock);
 	list_del(&port->list);
 	spin_unlock_irq(&port->portdev->ports_lock);
@@ -1579,6 +1753,12 @@ static void unplug_port(struct port *port)
 	debugfs_remove(port->debugfs_file);
 	kfree(port->name);
 
+	/*
+	 * Reclaim rproc DMA buffers deferred by the atomic cleanup
+	 * paths before the port is fully torn down.
+	 */
+	reclaim_dma_bufs();
+
 	/*
 	 * Locks around here are not necessary - a port can't be
 	 * opened after we removed the port struct from ports_list
@@ -1791,7 +1971,15 @@ static void in_intr(struct virtqueue *vq)
 	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
-	port->inbuf = get_inbuf(port);
+
+	/*
+	 * A reader may own an exclusively claimed buffer, possibly
+	 * sleeping in copy_to_user().  Do not prefetch the next buffer
+	 * now: the claimer's unconsumed remainder must go back to
+	 * port->inbuf first, or the prefetched buffer would be lost.
+	 */
+	if (!port->unplugging && !port->inbuf_claimed)
+		port->inbuf = get_inbuf(port);
 
 	/*
 	 * Normally the port should not accept data when the port is

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

