Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956669;
	b=wlApuP5vg7lSE7vWVoyr/eKyimw5oAF6Dg4u/lSCLaE81xhkz4j8WEIYIzTw4mPmOzm1
	 Uulam+lMPZVLwq2wRJ6r51mQiFD0qKTZAnj7bbJ90qv3RRNegF3icp5uwTiFGRwgZuGws
	 Ia20yE4zLKa1XmO7sv2IdL0PZMbGa0G0zm5Zs5yDmEDowLpRvq89JuP4yBu6784Ky8qgK
	 FJbGFAofHdos213wFP1AgqF9lapKrRmTClPgLglOlKXRd6gTYIUr2kHZTBFdRIbv2kf+z
	 OAMXWl1Bn6zsXg2WO7sBsKGW12wefqKEvhs2rl8q7YGG8ddUQ5bzPcV7mUsFXuUzf4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iNPloUTR9LM3h+nhnvEBDecNoAWunEFzhNB+irnO9g8=;
	b=vz6helpGwbdfSuz6t44596I7rMhMhudnveyZOYzkN8RpMPHvdq8tyNy8HVHyXoDwXMhg
	 MLOEoQhujnp3Mnj0qQDbHl7NpbrxTgr0VckOhCq4PSzF/Zje2jIVwwSpJQk28Tee3M0eM
	 HhFmOqH/tFF3h9iRNXo1252cPwRXAhDz1p4Cyv5rW6m822vKRoAcloc6C/AiH293Bw1Lw
	 yPQYR1eNOtX0mmCuDufIA/NIc1OEBbCGkuVH3Kvt34FSVUagrxau9jpbhnf87npshPp1a
	 VDYBcupMydY8EDUR6hJPPHCpbKBax7Jff3ThBU89HmiF6ODIh4zYB2AqLwTSzp6b4Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHhH+GPn;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A9606A33B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 09:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 204A9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RHhH+GPn
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so776698c88.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 01:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956667; x=1794561467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iNPloUTR9LM3h+nhnvEBDecNoAWunEFzhNB+irnO9g8=;
        b=RHhH+GPna4p910q7++ruu06SPIgDfoftnKgtYM1a/+mXH1/rpOdA4bKP7iRMLPkGKy
         g2Vbv9lT+zW7yicOjoMJ6iMAyeEYCdZbVYJNPsrO9PWDlTAxOgGGKXF2ENhV3haxWxPI
         MPc+67tBIsLCXXOujYqrJ5ZDgQKTcghBeoSquOjUW3VlFpEVleeZHrzxxl1wSk7xx47F
         DruJFyMOvK5+O0DtiWvysBArLubRDjn9QPus+HURWH2K1LBmE5E9cpTSUjB6s/txEd/g
         XyUP3OGtDKCfRMIbufzhA7wVSt1xvjrPxd/P3CdUNOXwJ4G1aVWeylkjSJ1aHeogexv3
         Sllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956667; x=1794561467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNPloUTR9LM3h+nhnvEBDecNoAWunEFzhNB+irnO9g8=;
        b=KswXQJ2tTeOdqm4UlnOFVqZMphhz5rYKFiRHAHDaSuAUu1qY078Yv+HrqW0Yna0SK6
         53RqGi2FRoVlXb5grSCZoL40eeuPccJYNk1QVD0bprFlfxbvQorBIwGr+Nz+Hg9l3EE+
         dCISfimaaJwnc8DLIs8idZ6RLba/blJF5sVwN/2bqH7sQIxWiHh0UbvXYnKnxnAZa6NH
         1fTvJCry+KVwL99iW3mMXMIjARhznMBkp2HI9fE+Y8Zo/qsggQ/2uF/0J5HALakDLpg+
         cH0C8B6t9NqJpGueaDc1Mj0ghNFXFgId0Lscu6mbPgMZ2U9x5Yo/8H6yj/hA/gr/V4rj
         uGQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwvfGqI65OxmYtDCpnV9n+C2zlAfj/63/ZP/GuGLQZxwrnAaMP0SQCla3bZDyTYH4EPM0TEY7q7ZX4E/VzDw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+1nPUlsU4KbOcW6mqefN1mKLsAo+uZCgravS7KhLtxEYFdm4RY
	pNfi0CJWpbVnxkDa3F+vus5iHu1vtNMFc+1tRVaFO+DOAzHsawIvF3Zz
X-Gm-Gg: AYBFou1oXLuZr8yjHJ1kCtj7GBnEmaAgrAeRb4eJ8TgYdksj83CnQ/N6/bzcVLTTEoK
	clxZ4xddup481/9pl0LBpjY3hMfv8d58JaGgopDBGHfNcIs1UPFSi8T/dfpBD5Q9HNhcO+Bpsu4
	LtyJktTMrcBB2p/FgktTyI2RU1M/ZDNFz/RLCypHF3GQtslP1eCep481GQR/BZV2sYkHyAlWTm6
	wUChCEFK2wYWWcH0l97zyi2D3xlHJl3NMYdrFDOzdUwcp4bRnJSO0gdIPBAV35iFBMSS1ce1Kh4
	CQUx7Qln5mNgyk3m/PXu0AyjDdrfT1g4Uqqu5wKi9rEBsOY7FecbD7SAkqzzHgGx5spjBIfTc1R
	+Ngwbjp8/ILrkb5/JM/ogya1+ekvVRf6lcs9Jr+1wrTkigWQhMAVLgP/EFTrpsh1mJHPwaJqNaE
	IeHtVzAEAxcMwQRwkG21vJg+89qf8Noy9g2DwsVuM9sKseLqgq6GqbCQ4QNTWxyyWMb+k3kkQ7E
	Siwyx+Dg+5yCk4gVgRjVu7oVE0Vp47RrweMt751I+NZzaYdjr9xvb5Hlk8yG8LP47FypQtwQjmW
	uFW+pZdW227LRou8LwKlDtu1Ul9WPAZ+baM5O9NUyv6xPLzuo58lWhvn6hd3ckZu+UeHrf7LJaK
	pk75GCJxylGxHZuGA0cjVMUzvSQ854t8aKWT0lJE/EaQT
X-Received: by 2002:a05:7022:c43:b0:1ac:d029:70cb with SMTP id a92af1059eb24-1b25d36f29amr2101220c88.30.1793956666638;
        Fri, 06 Nov 2026 01:17:46 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:1866])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm4927535c88.10.2026.11.06.01.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:17:46 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: rusty@rustcorp.com.au,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] virtio_console: fix buffer ownership and unplug races in the read path
Date: Fri,  6 Nov 2026 17:17:39 +0800
Message-Id: <20261106091739.1334178-1-shunsheng1218@gmail.com>
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
  exclusively across the unlocked copy.  port_read_snapshot() and
  the input virtqueue callback do not prefetch another buffer while
  a claim is held (nor once the port is being unplugged), so a
  partially consumed buffer is always finished before the next one
  and the byte order is preserved.

- The input state and the connection state are snapshotted together
  under inbuf_lock as empty, readable (a buffer can be acquired),
  claimed, or unplugged, together with guest_connected and
  host_connected.  poll() reports EPOLLIN when a buffer is available,
  or when the host has disconnected with no pending data so that a
  reader can observe EOF; a claimed buffer is not reported as
  immediately readable.  A claimed buffer is data pending for the EOF
  and host-disconnect logic, so a peer reader sharing the file
  descriptor does not observe EOF while another reader still owns
  unread bytes and instead waits for the claim to be released.  A
  nonblocking reader gets -EAGAIN (or 0 when the host has
  disconnected and no data is left).  Because the unplug state and
  the connection state are taken in the same critical section, a read
  that observes PORT_INPUT_UNPLUGGED in its snapshot returns -ENODEV,
  and poll() reports EPOLLHUP without a fake EPOLLIN.  A concurrent
  read may complete according to an earlier snapshot instead of
  observing the unplug immediately.  This
  ordering guarantee is against unplug_port(); the normal
  host_connected control-message update is not serialized by
  inbuf_lock and is read with READ_ONCE(), as before.  The atomic
  HVC poll simply retries.  will_read_block() uses the same snapshot
  for its wait predicate.

- unplug_port() publishes an "unplugging" state under inbuf_lock
  before any teardown.  After observing the unplugging state under
  inbuf_lock, in_intr() drops its port reference and returns without
  accessing portdev or the input virtqueue.  The separate HVC adapter
  lifetime race after inbuf_lock is dropped is addressed by the
  independently submitted hvc_kick change.  Readers stop touching the
  input virtqueue from that point; a reader returning a claimed buffer
  frees it instead of requeueing it.  A userspace read() that has not
  copied any byte returns -ENODEV for an unplugged port, while the HVC
  get_chars() path keeps returning 0.  In the fill_readbuf() release
  branches of this change, the teardown, copy-fault and
  failed-requeue paths defer free_buf() until inbuf_lock is dropped,
  so a userspace read may sleep in free_buf() for DMA buffers.  Other
  driver paths still free buffers under their own locks.  Nothing
  reads the buffer after it is freed, and the claim is
  always released with a wakeup, so readers waiting for the claim
  are not stalled until the next packet.

  The deferred rproc DMA buffers are reclaimed in unplug_port() after
  hvc_remove().  For the normal HVC polling path, the console entry is
  removed from pdrvdata.consoles before hvc_remove(), so a get_chars()
  that starts later cannot find this port; hvc_remove() also waits
  (via hp->lock) for a get_chars() that already found it.  The
  CONFIG_CONSOLE_POLL path is outside this normal teardown
  synchronization and has not been runtime-tested.

  For device-wide removal, virtio_break_device(), the virtqueue
  callback synchronization during reset, and cancellation of the
  control/config work precede unplug_port(); remove_vqs() subsequently
  frees remaining buffers in sleepable context.  For the virtio-pci
  and virtio-mmio transports, the reset-time callback synchronization
  is synchronize_irq() over the device vectors, and vring_interrupt()
  checks vq->broken before invoking the driver callback, so a late
  interrupt cannot invoke the callback after reset.  This does not
  establish runtime coverage of single-port PORT_REMOVE, where the
  device stays up and the remaining virtqueue callbacks are not
  stopped by reset, nor of all remoteproc transport behavior.

- A zero-length read returns 0 before the unplug checks, preserving
  the normal read(fd, buf, 0) semantics.

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
- A nonblocking read with an empty input raced against unplug: the
  previous version returned 0 (a false EOF) once unplug cleared
  host_connected.  A read that observes the unplug state in its
  input/connection snapshot returns -ENODEV; a concurrent read may
  complete according to an earlier snapshot.  In this test the new
  version returns -EAGAIN and the next read -ENODEV.
- Polling while unplug_port() had published the unplugging state but
  not yet cleared the connection state: the previous version reported
  EPOLLIN | EPOLLRDNORM; this version reports EPOLLHUP only.
- A normal host disconnect still returns 0.
- Combined with the hvc_kick change for the HVC adapter lifetime,
  the 20000-record integrity test, the callback/unplug injection
  and a normal PORT_REMOVE run all complete without new KASAN,
  lockdep, duplicate or reordered data.  The 20000-record, High and
  -ENODEV tests were re-run on this version.

The test environment provides virtual virtio-console devices only.
Real remoteproc DMA buffers were not available, so the rproc-serial
DMA buffer path is covered by code inspection of the claim, deferred
free and reclaim ordering, not by a runtime test.

Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off data from host to readers")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Changes since v3:
- Snapshot the input state and the connection state in one
  inbuf_lock critical section, so an unplug is not mistaken for a
  host disconnect when the read and poll paths check host_connected
  after a state snapshot (reported by Sashiko).
- Make poll() report EPOLLHUP and no EPOLLIN for an unplugging port.
- Return 0 for zero-length reads before the unplug checks.
- Use the same snapshot in will_read_block() and remove the
  now-unused port_input_state().
- Document synchronization of the normal HVC polling path before the
  final DMA reclaim, and explicitly state the CONFIG_CONSOLE_POLL
  testing limitation.
- A/B: the previous version returns 0 / EPOLLIN in the new eofrace
  and pollunplug injections; this version returns -EAGAIN / -ENODEV
  and EPOLLHUP.  Re-ran the 20000-record, claim+poll, nb, eof, High
  and -ENODEV tests.
v3: https://lore.kernel.org/r/20261106053438.1206065-1-shunsheng1218@gmail.com/
v2: https://lore.kernel.org/r/20261105114535.972013-1-shunsheng1218@gmail.com/
v1: https://lore.kernel.org/r/179378543196.71890.7555371342727156729@gmail.com/
---
 drivers/char/virtio_console.c | 347 +++++++++++++++++++++++++++++-----
 1 file changed, 298 insertions(+), 49 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5c..6573db068eee3 100644
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
@@ -534,19 +551,56 @@ static void discard_port_data(struct port *port)
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
+/*
+ * Consistent snapshot of the input state and the connection state.
+ * unplug_port() publishes the unplugging state and clears
+ * guest_connected/host_connected under inbuf_lock, so taking all of
+ * them in the same critical section lets the read and poll paths tell
+ * an unplug from a normal host disconnect.
+ */
+struct port_read_snapshot {
+	enum port_input_state input;
+	bool guest_connected;
+	bool host_connected;
+};
+
+/* Callers must not hold inbuf_lock. */
+static struct port_read_snapshot port_read_snapshot(struct port *port)
 {
+	struct port_read_snapshot snap;
 	unsigned long flags;
-	bool ret;
 
-	ret = false;
 	spin_lock_irqsave(&port->inbuf_lock, flags);
-	port->inbuf = get_inbuf(port);
-	if (port->inbuf)
-		ret = true;
+
+	snap.guest_connected = port->guest_connected;
+	snap.host_connected = READ_ONCE(port->host_connected);
+
+	if (port->unplugging || !port->portdev) {
+		snap.input = PORT_INPUT_UNPLUGGED;
+	} else if (port->inbuf_claimed) {
+		snap.input = PORT_INPUT_CLAIMED;
+	} else {
+		port->inbuf = get_inbuf(port);
+		snap.input = port->inbuf ? PORT_INPUT_AVAILABLE
+					 : PORT_INPUT_EMPTY;
+	}
 
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
-	return ret;
+	return snap;
 }
 
 static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
@@ -692,24 +746,122 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
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
+	struct port_read_snapshot snap;
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
+		bool guest = port->guest_connected;
+		bool host = READ_ONCE(port->host_connected);
+
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		if (!to_user)
+			return 0;
+		if (!guest)
+			return -ENODEV;
+		if (nonblock)
+			return host ? -EAGAIN : 0;
+		if (!host)
+			return 0;
+		/*
+		 * The input is empty but the guest is still connected.
+		 * Wait for data, a disconnect or the unplug fence, then
+		 * re-snapshot instead of reusing the state above.
+		 */
+		err = wait_event_freezable(port->waitqueue,
+					   !will_read_block(port));
+		if (err)
+			return err;
+
+		snap = port_read_snapshot(port);
+		if (snap.input == PORT_INPUT_UNPLUGGED ||
+		    !snap.guest_connected)
+			return -ENODEV;
+		if (snap.input == PORT_INPUT_EMPTY && !snap.host_connected)
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
@@ -717,19 +869,57 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 
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
@@ -737,11 +927,17 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 /* The condition that must be true for polling to end */
 static bool will_read_block(struct port *port)
 {
-	if (!port->guest_connected) {
-		/* Port got hot-unplugged. Let's exit. */
+	struct port_read_snapshot snap = port_read_snapshot(port);
+
+	if (snap.input == PORT_INPUT_UNPLUGGED || !snap.guest_connected)
 		return false;
-	}
-	return !port_has_data(port) && port->host_connected;
+	if (snap.input == PORT_INPUT_AVAILABLE)
+		return false;
+	/* Another reader owns the claimed buffer: wait for it. */
+	if (snap.input == PORT_INPUT_CLAIMED)
+		return true;
+
+	return snap.host_connected;
 }
 
 static bool will_write_block(struct port *port)
@@ -771,21 +967,27 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 			      size_t count, loff_t *offp)
 {
 	struct port *port;
+	struct port_read_snapshot snap;
 	ssize_t ret;
 
 	port = filp->private_data;
 
-	/* Port is hot-unplugged. */
-	if (!port->guest_connected)
+	/* Zero-length reads always return 0. */
+	if (!count)
+		return 0;
+
+	snap = port_read_snapshot(port);
+	if (snap.input == PORT_INPUT_UNPLUGGED || !snap.guest_connected)
 		return -ENODEV;
 
-	if (!port_has_data(port)) {
+	if (snap.input != PORT_INPUT_AVAILABLE) {
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
+		if (snap.input == PORT_INPUT_EMPTY && !snap.host_connected)
 			return 0;
 		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
@@ -795,23 +997,19 @@ static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 		if (ret < 0)
 			return ret;
 	}
-	/* Port got hot-unplugged while we were waiting above. */
-	if (!port->guest_connected)
-		return -ENODEV;
+
 	/*
-	 * We could've received a disconnection message while we were
-	 * waiting for more data.
-	 *
-	 * This check is not clubbed in the if() statement above as we
-	 * might receive some data as well as the host could get
-	 * disconnected after we got woken up from our wait.  So we
-	 * really want to give off whatever data we have and only then
-	 * check for host_connected.
+	 * Re-snapshot after the wait: an unplug or a host disconnect may
+	 * have happened, and the pre-wait state must not be reused.
 	 */
-	if (!port_has_data(port) && !port->host_connected)
+	snap = port_read_snapshot(port);
+	if (snap.input == PORT_INPUT_UNPLUGGED || !snap.guest_connected)
+		return -ENODEV;
+	if (snap.input == PORT_INPUT_EMPTY && !snap.host_connected)
 		return 0;
 
-	return fill_readbuf(port, ubuf, count, true);
+	return fill_readbuf(port, ubuf, count, true,
+			     filp->f_flags & O_NONBLOCK);
 }
 
 static int wait_port_writable(struct port *port, bool nonblock)
@@ -995,21 +1193,25 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
 static __poll_t port_fops_poll(struct file *filp, poll_table *wait)
 {
 	struct port *port;
+	struct port_read_snapshot snap;
 	__poll_t ret;
 
 	port = filp->private_data;
 	poll_wait(filp, &port->waitqueue, wait);
 
-	if (!port->guest_connected) {
-		/* Port got unplugged */
+	snap = port_read_snapshot(port);
+
+	/* Port got unplugged. */
+	if (snap.input == PORT_INPUT_UNPLUGGED || !snap.guest_connected)
 		return EPOLLHUP;
-	}
+
 	ret = 0;
-	if (!will_read_block(port))
+	if (snap.input == PORT_INPUT_AVAILABLE ||
+	    (snap.input == PORT_INPUT_EMPTY && !snap.host_connected))
 		ret |= EPOLLIN | EPOLLRDNORM;
 	if (!will_write_block(port))
 		ret |= EPOLLOUT;
-	if (!port->host_connected)
+	if (!snap.host_connected)
 		ret |= EPOLLHUP;
 
 	return ret;
@@ -1206,7 +1408,7 @@ static ssize_t get_chars(u32 vtermno, u8 *buf, size_t count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	return fill_readbuf(port, (__force u8 __user *)buf, count, false);
+	return fill_readbuf(port, (__force u8 __user *)buf, count, false, false);
 }
 
 static void resize_console(struct port *port)
@@ -1400,6 +1602,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 	port->name = NULL;
 	port->inbuf = NULL;
+	port->inbuf_claimed = false;
+	port->unplugging = false;
 	port->cons.hvc = NULL;
 	port->async_queue = NULL;
 
@@ -1533,6 +1737,17 @@ static void remove_port_data(struct port *port)
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
@@ -1579,6 +1794,18 @@ static void unplug_port(struct port *port)
 	debugfs_remove(port->debugfs_file);
 	kfree(port->name);
 
+	/*
+	 * Reclaim rproc DMA buffers deferred by the atomic cleanup
+	 * paths before the port is fully torn down.  For the normal
+	 * HVC polling path, the console entry was removed from
+	 * pdrvdata.consoles above, so a get_chars() that starts later
+	 * cannot find this port, while hvc_remove() waits (via hp->lock)
+	 * for a get_chars() that had already found it.  The
+	 * CONFIG_CONSOLE_POLL path is outside this normal teardown
+	 * synchronization and has not been runtime-tested.
+	 */
+	reclaim_dma_bufs();
+
 	/*
 	 * Locks around here are not necessary - a port can't be
 	 * opened after we removed the port struct from ports_list
@@ -1791,7 +2018,28 @@ static void in_intr(struct virtqueue *vq)
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
@@ -1810,7 +2058,8 @@ static void in_intr(struct virtqueue *vq)
 	 * guest_connected to true.
 	 */
 
-	if (!port->guest_connected && !is_rproc_serial(port->portdev->vdev))
+	if (!port->inbuf_claimed && !port->guest_connected &&
+	    !is_rproc_serial(port->portdev->vdev))
 		discard_port_data(port);
 
 	/* Send a SIGIO indicating new data in case the process asked for it */
-- 
2.34.1

