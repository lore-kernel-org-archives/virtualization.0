Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943295;
	b=mVZZ8wLhVNbWpX/zEAK5aTt4ne16zHXBJZWKplOrujh45VI1FkbjrJmvWHO/w61+aCKk
	 K3piQopzl5kGUy7BDLsObehjHg4TCcOdhGPfmj0QeVni9QFHcCByTSl2pEnoBn8IddR69
	 A664RMXhIZsaUveZ8BuA4uo2TCfKSA3gxP1c9/vFO50kLdM4WceIzOybnc1EF4PxTyhQ1
	 FTX3dytDPIZGDh+0b84kDDVVwCB073biIZVSqTTUhCNaX9syjG+qpHDC0l5xkWBDyFOKc
	 wskAGvKIt4vB6ziVHPhMTMlceLTEeB2ym8XaCMTXUhESW1/DqBdM8iE51dpYYGFvnSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FPr++xAK0MuAQlXbkT1ssOj1KR4BUSwaP/TXm3dUT7s=;
	b=i6x31arzscSUbnCxTcsRpGGWtwwSjbF3SrWsDgjLrShnbhsF3krjDoKYx9lwi4z0GyKK
	 fviBP0flm+g9bKXGVE3RVnTyjbOijnfnWz/yprebpj2XSuEU3M3T7OJHUTgT54lJTTKEg
	 7+I7o5KzTZ/qbcJt0WBGAOI3uGResVoMo6Kxx7+IUWfnv5OO88gUeZG4G2Mnr1UbZaiim
	 NgoL5jQM7djfdY3paK3yteFWi79GxSinqif0abawEvUHuoXi++cQbbjpszxgF+Ia4g/Km
	 r1RzsrNAofi0i2GgqtE+517eCb35VTvYUhGHiX94ZxBLgbhmwelEoZ8Pnhj7mA5ixoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXjHuYGb;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BD606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 05:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 774BD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXjHuYGb
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so581172c88.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 21:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793943293; x=1794548093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPr++xAK0MuAQlXbkT1ssOj1KR4BUSwaP/TXm3dUT7s=;
        b=OXjHuYGbj+8N+uSCd4wcTIniPFaCXy+YpNtamkdWIltDS84aUp0A1lAlmfahSqV/CW
         2rxgUyxhBASFl0H4F11gUGjBH8ZWyn+KN4/xQzWhTrLUYEnjtRbqo45dSbrIcGy6lTMp
         hKKX4UqFegtI7K9pViotSJrfWxwPRhs5+rccDwBpgvcTxjPg1YXGKTZBuX3l51KfSOeA
         JbLo99fZkT5QMYSfP1ba8D2TR6vSK4cD9977wjGLdiN19Fz6h8ru46eyskCTY3J1B32V
         yeX794OKbWrQJX7fncy5PE3+2AcMo9B2cT9JtXt9wi1B4vKmLNea/v32/2qXaarPfJFq
         Yv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793943293; x=1794548093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPr++xAK0MuAQlXbkT1ssOj1KR4BUSwaP/TXm3dUT7s=;
        b=KDfbHDuhDrIdxNEdMz/GX4E+f0lIkD4aBI8rOjYaNuUre5FpSmKGnfY4FN1PW+6lEW
         xpdq6GOGj9YgHmj3OcKeeFj+w+GpVaM6RFGSH+xomiWThiLJgm917rhJM+HBdRTZ+t2X
         NEafiS05+kvDd50yQTP59SyniPaTSwCvPFm40MQEhiQe5EQwFZjX9Krls15YnT3fL+MI
         8K/CxeTxbOTIareT1Nmst/HRdwfgWL+f486hrL2FL43cZ2/WKtIpSLKEqiiXvlPDL4Tp
         DFOuepEThrx2DkA05HiQAdTxPwKurUU3I5BIxnvA7GWX6WnozGJDx42k0lwRzorcF4PV
         /vIw==
X-Forwarded-Encrypted: i=1; AKwUvBziBYdiJ+0tjqQqJaxUfDqSUBJVky4WG8sfXUWWEhIybNsmxd9aoTBiYP7Q8iY1eV+sP4NKw5IAPRXceOlI5g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+AuVzSxbmjKeY+r1H1Bzt6LiLxe0X6ZPC3HpOnm64BXUKDGZme
	yWOLfuD6oWzXx/tUOcr8phM1/EhckO6/PrEgKofyOyS8KBT25hyfLmOnM6CZAibm81ZZ7g==
X-Gm-Gg: AYBFou2mijlbpwFKqzLl6syCwZHZqFdlGzhOY6jCcBTrV57WHdufH7r4uAiL7mc46yy
	h3Emeths6V61HO9mCXO94tSsicj/pWGMM2RxKfDbZZPARanIxn4I1r14rQi4s0n+vMgo1yrZtEe
	Rkf1Vu0ifAslMlG2Yt1Kw1POE2PuYHmAP4WqB8NgX+rTTFy10D9lgG4DTqqq5VjDIFErbGUndMv
	YYhjBVAcVMfXy8NrFNcLv7chrcxf+1QWii8qoWnRDyeXhJQ83w6I+jusGwoHSuzPZgM/XItG82I
	YOzYFfZ7SjVBru2vsGtBeGGe0nXcq9j5Ub8A+Nznk09FeSrQP7w068NGs4uZRz3DNzDzNAwF++Y
	OKL+xy2fOdke0VZtcWyVrOKqn05U0AnL38vYkYaFCts/lTiTuOPosWWtwgLWsLdCXz0oUqfrqzM
	l15Tw2hV15l/0KJiAqTxhljkThie+6jBnENGbhDViQ6Kd6ER1Gzm+QhRWe8SkhjBRWc/W87P27B
	b6/rQEO63lSatmAUF4YJrIRxsKc7jvstdVz4QGlbp3dIyFMPgXQp5I66GQLlFExhlUaDWL04TBG
	AM2L/gaafsfvBQHoOq6najQByJSFDdRgtnHqnxH3lnSQ120K70WRHvAz1e6IYzAy/5rJuurdDAT
	kzNdBj5mIcQ8YDA5n/su7RKIuoLKN5QhAJnndgh+d3/EQSGs=
X-Received: by 2002:a05:701b:21db:b0:184:d593:2897 with SMTP id a92af1059eb24-1b25d32fbf3mr1601958c88.29.1793943293007;
        Thu, 05 Nov 2026 21:34:53 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:1602:ecff:fe49:38a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e407bb5sm2574511c88.1.2026.11.05.21.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:34:52 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: rusty@rustcorp.com.au,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtio_console: fix buffer ownership and unplug races in the read path
Date: Fri,  6 Nov 2026 13:34:38 +0800
Message-Id: <20261106053438.1206065-1-shunsheng1218@gmail.com>
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
requeue a buffer nobody will free anymore.  The input virtqueue
callback itself can run past find_port_by_vq() into port->portdev
and the virtqueue after unplug_port() has cleared them.

Track buffer ownership explicitly:

- fill_readbuf() claims port->inbuf under inbuf_lock and owns it
  exclusively across the unlocked copy.  port_has_data() and the
  input virtqueue callback no longer prefetch the next buffer while
  a claim is held (nor once the port is being unplugged), so a
  partially consumed buffer is always finished before the next one
  and the byte order is preserved.

- The input state is snapshotted under inbuf_lock as empty,
  readable (a buffer can be acquired), claimed, or unplugged.  Only
  a readable buffer lets poll() report EPOLLIN or a read() proceed;
  a claimed buffer is data pending for the EOF and host-disconnect
  logic, so a peer reader sharing the file descriptor does not
  observe EOF while another reader still owns unread bytes and
  instead waits for the claim to be released.  A nonblocking reader
  gets -EAGAIN (or 0 when the host has disconnected and no data is
  left).  The atomic HVC poll simply retries.

- unplug_port() publishes an "unplugging" state under inbuf_lock
  before any teardown.  After observing the unplugging state under
  inbuf_lock, in_intr() drops its port reference and returns without
  accessing portdev or the input virtqueue.  The separate HVC adapter
  lifetime race after inbuf_lock is dropped is addressed by the
  independently submitted hvc_kick change.  Readers stop touching the
  input virtqueue from that point; a reader returning a claimed buffer
  frees it instead of requeueing it.  A userspace read() that has not
  copied any byte returns -ENODEV for an unplugged port, while the HVC
  get_chars() path keeps returning 0.  free_buf() always runs
  outside the lock: the teardown, copy-fault and failed-requeue
  paths defer the free until inbuf_lock is dropped, so free_buf()
  may sleep for DMA buffers when called from a userspace read.
  Nothing reads the buffer after it is freed, and the claim is
  always released with a wakeup, so readers waiting for the claim
  are not stalled until the next packet.

This issue was investigated and the fix was developed with AI
assistance (ZCode/GLM-4).

Testing with QEMU and KASAN injection (lockdep and
CONFIG_DEBUG_ATOMIC_SLEEP enabled in the test kernel):

- A shared-fd, two-reader test without unplug delivered all 20000
  records exactly once, with no corruption or reordering.  The
  unmodified kernel delivered 19979 of them more than once and only
  48 could be attributed to any consistent stream order.
- Stalling the input callback right after find_port_by_vq() while a
  QMP device_del unplugs the port made the previous version
  dereference the cleared portdev (KASAN null-ptr-deref in
  in_intr()); this version returns through the unplug check and
  reports nothing.
- Stalling a userspace read() just before fill_readbuf() and
  unplugging the port while it is parked: the previous version
  returns 0 (treated as a normal host disconnect), this version
  returns -ENODEV.
- With one reader parked while holding a claim, poll() no longer
  reports EPOLLIN and a nonblocking read from the second reader
  returns -EAGAIN instead of a readable/EAGAIN mismatch.  With the
  host disconnecting at the same point, the second reader gets
  -EAGAIN rather than a premature EOF, and the following blocking
  read receives the remainder the first reader puts back.
- During concurrent unplug, readers received a valid contiguous
  prefix before disconnect, with no duplicates or KASAN reports;
  the same stall sequences produce six slab use-after-free reports
  per run on the unmodified kernel.
- A separate fault-injection run exercised 20 failed buffer
  requeues, all going through the deferred free path, without a
  reported use-after-free, lockdep splat or invalid-context sleep.
- Combined with the hvc_kick change for the HVC adapter lifetime,
  the 20000-record integrity test, the callback/unplug injection
  and a normal PORT_REMOVE run all complete without new KASAN,
  lockdep, duplicate or reordered data.

The test environment provides virtual virtio-console devices only.
Real remoteproc DMA buffers were not available, so the rproc-serial
DMA buffer path is covered by code inspection of the claim, deferred
free and reclaim ordering, not by a runtime test.

Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off data from host to readers")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Changes since v2:
- in_intr() now returns immediately when it observes unplugging or a
  cleared portdev, dropping the reference taken by find_port_by_vq().
  The previous version skipped get_inbuf() but still evaluated
  is_rproc_serial(port->portdev->vdev) and could reach
  discard_port_data() or the HVC adapter after unplug_port() tore the
  port down.  Reproduced by stalling in_intr() after
  find_port_by_vq() while a QMP device_del unplugs the port: the
  previous version reports a KASAN null-ptr-deref in in_intr() (RIP
  in_intr+0x2c5), this version reports nothing.
- Introduced an explicit input-state snapshot and stopped treating
  "a buffer is claimed" as "readable".  poll() no longer reports
  EPOLLIN and a nonblocking read returns -EAGAIN while another
  reader owns the buffer, instead of the previous poll/read
  mismatch.  Reproduced by parking one reader on a claim and
  polling/reading from the second reader: previous version fails
  both checks, this version passes.
- fill_readbuf() returns -ENODEV instead of 0 when a userspace
  reader finds the port unplugged before copying anything;
  port_fops_read() takes the same snapshot and applies it before
  the EOF/EAGAIN early returns.  The HVC path keeps returning 0.
  Reproduced by stalling a read() just before fill_readbuf() and
  unbinding the port: previous version returns 0, this version
  returns -ENODEV.
- Do not run discard_port_data() from in_intr() while a claim is
  held; the claimed buffer is returned to port->inbuf by its owner
  and the deferred cleanup completes on release or port teardown.
- Use READ_ONCE() for the unlocked connection-state reads in the
  fill_readbuf() retry path, matching port_fops_read() and
  will_read_block().
- Revalidated the claimed+poll, claimed+O_NONBLOCK,
  claim+host-disconnect, claim-period unplug, 20000-record
  integrity and combined hvc_kick cases under KASAN, lockdep and
  CONFIG_DEBUG_ATOMIC_SLEEP.
v2: https://lore.kernel.org/r/20261105114535.972013-1-shunsheng1218@gmail.com/
v1: https://lore.kernel.org/r/179378543196.71890.7555371342727156729@gmail.com/
---
 drivers/char/virtio_console.c | 296 ++++++++++++++++++++++++++++++----
 1 file changed, 265 insertions(+), 31 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5c..d1757017d9bd0 100644
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
@@ -534,19 +551,48 @@ static void discard_port_data(struct port *port)
 			 err);
 }
 
-static bool port_has_data(struct port *port)
+/*
+ * Input state of a port, snapshotted under inbuf_lock.  The distinction
+ * between a buffer that can be acquired now (AVAILABLE) and one that is
+ * owned by another reader (CLAIMED) matters for poll() and for blocking
+ * reads: only AVAILABLE must be reported as readable, while both mean
+ * that unread data may still be pending for the EOF logic.
+ */
+enum port_input_state {
+	PORT_INPUT_EMPTY,
+	PORT_INPUT_AVAILABLE,
+	PORT_INPUT_CLAIMED,
+	PORT_INPUT_UNPLUGGED,
+};
+
+/* Callers must not hold inbuf_lock. */
+static enum port_input_state port_input_state(struct port *port)
 {
 	unsigned long flags;
-	bool ret;
+	enum port_input_state state;
 
-	ret = false;
 	spin_lock_irqsave(&port->inbuf_lock, flags);
-	port->inbuf = get_inbuf(port);
-	if (port->inbuf)
-		ret = true;
+
+	if (port->unplugging || !port->portdev) {
+		state = PORT_INPUT_UNPLUGGED;
+	} else if (port->inbuf_claimed) {
+		state = PORT_INPUT_CLAIMED;
+	} else {
+		port->inbuf = get_inbuf(port);
+		state = port->inbuf ? PORT_INPUT_AVAILABLE
+				    : PORT_INPUT_EMPTY;
+	}
 
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
-	return ret;
+	return state;
+}
+
+static bool port_has_data(struct port *port)
+{
+	enum port_input_state state = port_input_state(port);
+
+	return state == PORT_INPUT_AVAILABLE ||
+	       state == PORT_INPUT_CLAIMED;
 }
 
 static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
@@ -692,24 +738,112 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
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
 
-	if (!out_count || !port_has_data(port))
+	if (!out_count)
 		return 0;
 
+retry:
+	spin_lock_irqsave(&port->inbuf_lock, flags);
+
+	/* The port is going away; its vqs are being torn down. */
+	if (port->unplugging || !port->portdev) {
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		/* Userspace sees a removed port; HVC just has no data. */
+		return to_user ? -ENODEV : 0;
+	}
+
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
+			return READ_ONCE(port->host_connected) ? -EAGAIN : 0;
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
+		if (!READ_ONCE(port->guest_connected))
+			return -ENODEV;
+		if (!READ_ONCE(port->host_connected) && !port_has_data(port))
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
@@ -717,19 +851,57 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 
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
@@ -737,11 +909,21 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 /* The condition that must be true for polling to end */
 static bool will_read_block(struct port *port)
 {
-	if (!port->guest_connected) {
+	enum port_input_state state;
+
+	if (!READ_ONCE(port->guest_connected)) {
 		/* Port got hot-unplugged. Let's exit. */
 		return false;
 	}
-	return !port_has_data(port) && port->host_connected;
+
+	state = port_input_state(port);
+	if (state == PORT_INPUT_UNPLUGGED || state == PORT_INPUT_AVAILABLE)
+		return false;
+	/* Another reader owns the claimed buffer: wait for it. */
+	if (state == PORT_INPUT_CLAIMED)
+		return true;
+
+	return READ_ONCE(port->host_connected);
 }
 
 static bool will_write_block(struct port *port)
@@ -771,21 +953,28 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 			      size_t count, loff_t *offp)
 {
 	struct port *port;
+	enum port_input_state state;
 	ssize_t ret;
 
 	port = filp->private_data;
 
 	/* Port is hot-unplugged. */
-	if (!port->guest_connected)
+	if (!READ_ONCE(port->guest_connected))
+		return -ENODEV;
+
+	state = port_input_state(port);
+	if (state == PORT_INPUT_UNPLUGGED)
 		return -ENODEV;
 
-	if (!port_has_data(port)) {
+	if (state != PORT_INPUT_AVAILABLE) {
 		/*
-		 * If nothing's connected on the host just return 0 in
-		 * case of list_empty; this tells the userspace app
-		 * that there's no connection
+		 * No buffer can be acquired right now: the input is empty
+		 * or another reader owns the claimed buffer.  A host
+		 * disconnect is only EOF when no reader still holds
+		 * unread bytes; with a claim outstanding, wait for it.
 		 */
-		if (!port->host_connected)
+		if (state == PORT_INPUT_EMPTY &&
+		    !READ_ONCE(port->host_connected))
 			return 0;
 		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
@@ -796,7 +985,7 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 			return ret;
 	}
 	/* Port got hot-unplugged while we were waiting above. */
-	if (!port->guest_connected)
+	if (!READ_ONCE(port->guest_connected))
 		return -ENODEV;
 	/*
 	 * We could've received a disconnection message while we were
@@ -808,10 +997,14 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 	 * really want to give off whatever data we have and only then
 	 * check for host_connected.
 	 */
-	if (!port_has_data(port) && !port->host_connected)
+	state = port_input_state(port);
+	if (state == PORT_INPUT_UNPLUGGED)
+		return -ENODEV;
+	if (state == PORT_INPUT_EMPTY && !READ_ONCE(port->host_connected))
 		return 0;
 
-	return fill_readbuf(port, ubuf, count, true);
+	return fill_readbuf(port, ubuf, count, true,
+			     filp->f_flags & O_NONBLOCK);
 }
 
 static int wait_port_writable(struct port *port, bool nonblock)
@@ -1206,7 +1399,7 @@ static ssize_t get_chars(u32 vtermno, u8 *buf, size_t count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	return fill_readbuf(port, (__force u8 __user *)buf, count, false);
+	return fill_readbuf(port, (__force u8 __user *)buf, count, false, false);
 }
 
 static void resize_console(struct port *port)
@@ -1400,6 +1593,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 	port->name = NULL;
 	port->inbuf = NULL;
+	port->inbuf_claimed = false;
+	port->unplugging = false;
 	port->cons.hvc = NULL;
 	port->async_queue = NULL;
 
@@ -1533,6 +1728,17 @@ static void remove_port_data(struct port *port)
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
@@ -1579,6 +1785,12 @@ static void unplug_port(struct port *port)
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
@@ -1791,7 +2003,28 @@ static void in_intr(struct virtqueue *vq)
 	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
-	port->inbuf = get_inbuf(port);
+
+	/*
+	 * The port is being unplugged: unplug_port() tears down portdev,
+	 * the guest_connected state and the HVC adapter.  Do not touch
+	 * the input virtqueue or any of that state; just drop the port
+	 * reference taken by find_port_by_vq().
+	 */
+	if (port->unplugging || !port->portdev) {
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		wake_up_interruptible(&port->waitqueue);
+		kref_put(&port->kref, remove_port);
+		return;
+	}
+
+	/*
+	 * A reader may own an exclusively claimed buffer, possibly
+	 * sleeping in copy_to_user().  Do not prefetch the next buffer
+	 * now: the claimer's unconsumed remainder must go back to
+	 * port->inbuf first, or the prefetched buffer would be lost.
+	 */
+	if (!port->inbuf_claimed)
+		port->inbuf = get_inbuf(port);
 
 	/*
 	 * Normally the port should not accept data when the port is
@@ -1810,7 +2043,8 @@ static void in_intr(struct virtqueue *vq)
 	 * guest_connected to true.
 	 */
 
-	if (!port->guest_connected && !is_rproc_serial(port->portdev->vdev))
+	if (!port->inbuf_claimed && !port->guest_connected &&
+	    !is_rproc_serial(port->portdev->vdev))
 		discard_port_data(port);
 
 	/* Send a SIGIO indicating new data in case the process asked for it */
-- 
2.34.1

