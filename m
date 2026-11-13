Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559801;
	b=lnvGQh07BJS8Gx/gdHvyuFxb/HSsSYa5U1XhYnDYr783O3WPJQdDyEk/NBY7gwSBlUJE
	 2rcugfIJT/ijihqW+aY6HPDFIvbDzwd1Ss19S2dHr7Yl0bN7ZpO98EVgF+6MoQyu84a3R
	 TIofpq/pDNoDFqxrCezMX+2aiezrRLfTdKUr+iGtXopWZXyWrbVpkywiZSa1qSF9xfCHH
	 VDXK3BCdz4R1TpCS5Sc11nd5TsLj2fs15khZLHZAUqhH3JBzhFxZApcLppIEv2zN7k32V
	 +vq2wzbcTixzIR8GBwa5bwcbRWE/g18QM7jW6c+/rl7k7J5aMygwU2AhwvW6uAW1Xjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g3miSUCaoPJIQa6siBt7PZKkvjuOEV2JhJvHnsT+V6w=;
	b=uTSGy/CT42hRVB9H6CDYPppSBm+9CrS/k75Z/G00+G5rKFWDFK0f+qCmLSB+vRfWWpEi
	 kn5SFEHty4MNSogNuowUv9nryi8AJxAsocSjs7caRz/vZAazUPC67iYaQhlfi+p795eRc
	 GWcGkvzqc4+b+705fwndOWCnWnYKmpJ158vqip5YW1c3LokkX6PG8J/O4TG8JbvJc9AUo
	 4Dqt9g/rvcTjVzel3aot3zpwSeYnaKFIonb4o91N0uU34sXAWzspHWwbUTWTcED+yew0p
	 FdkE82IK8aKZqJR/2bkU3O8ovZQGznhBRMAtobjj/6BMb9NXypBUiXkNJR74i8u3fXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRuKHW1J;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0F606B360
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 08:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A0F606B360
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oRuKHW1J
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37986eb6fa2so1671342eec.0
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559800; x=1795164600; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3miSUCaoPJIQa6siBt7PZKkvjuOEV2JhJvHnsT+V6w=;
        b=oRuKHW1Jkvv6rNryDDPr1/KaHykgDRI0UTQDwJvIDSPZXDU47K8vhR1ISzTxAKnxgm
         DjHz7zr1CaXA/64xowmZDVjLrNckXetJG9ORpL4BRNnPjz2PXxm8RIn+lGSu9bbkEuZH
         5f8v0NSL+G6Smg9JupSjP7Txi8e/HzPP8mEs4nOuQ6oF/fbKU/zrPUyezvBvIvqGRLzL
         Fo+BTeiwr9N3G6MzuA8w4SfQp4mKhOWe3hhEnQhAnxhwIrkcSWt0PjIAKEaijzhvc80U
         LdfiOWNif9C/3FRSwvR0XF2cgPmIeObE0Cs0it7D9AE44HEp9G/7fsjHiu5ohaS3920B
         QH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559800; x=1795164600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3miSUCaoPJIQa6siBt7PZKkvjuOEV2JhJvHnsT+V6w=;
        b=oT9vQik/MvzD6B6dQAa7o/aZxfNF7ToNhIUVRKmapXKGjpT7ACnHvx/SvxkaW8YBNh
         kh/KTISDSaQjbRh/Zx+2pAdXGcsPkySbJtGPamzRmGelrmictwiO+M5dDgf4i/6Ptqwn
         UCXwRF7T3qLAMbNt3NvxwrfwgNLgzjjff6S/d9/VarqpjH86sfInw4nlgYsYZ0Y/GgDQ
         saqO1vJsYffRVuMPIMQ2jV8DpxHk3Dh4H2STcZzdf2qRMDIcYx3XjxAKYKxDuaMXKR03
         jSpDqj3PqHKuDQg3oEELZgtXKZ9AwgdXn6p3wXpu+gtgpBRPcGfLAHKm7cwNo8nYCknm
         35Ew==
X-Forwarded-Encrypted: i=1; AL+hErEgxOGUYXwzeWa7JNhQQTRWgy11sneisyKhA7qH/HiATDu/WwUztpe7v0kYP/U30k2eioz92xrg7VqZGYDJEA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+/R+WeCqaSoZPw8JuIl1Z/T1eQfWDsMLkK9poI3ZYKZ00FxKmu
	q27W5QR4oG0XjWVGdEToVF/JyAMrL1uFK9W6wNe4Ro4SoWnalYnC5IjO
X-Gm-Gg: AYBFou0j3jlx6abZv7p8r3M0wjOmmH2JJjEABPqKFZmbz/A0jllFwW9T3Hf+gNJurB1
	Ky9GDTse9VHlwxQ/5E4AkM5Em45SIzshv/NoDl3/tNZufXz2jAFtXi8X7z1c8IRcpEEgXIpm9C6
	CjeAf5MzDvqwa+yhb+KF1mR3MO/8bR2bRzEq2LjInBdgKohfEYSnvyurNTEs94DtWa/VziPnT4k
	lXs33dLoP5ITbUgcyjTeiFRbm3WhPU+1gtCe3nYbvF+1FJWpmLpm/8fY7sOHxGc4Pz1dhQlWxcQ
	djaoadaMH4wtJ7XV+JuNcxclYIXfK0x7Bh4Jk0WagDyLfKkLelF4b2RiNchFL8Vk76FNT4qMLvg
	gLNYxqC79GsY3lTuxH+1MRUk5hovWmLvcHz8RduNITj2Q3ezDLZXiRYnckjugkmRumYd1Xzzxxg
	ocY/caRjSycfh10yZCFMpCBts3Q+e3YG26zYbFPdSsPBFZkWWqi6l7jgF1uWY7o7KW2xs3s2R1u
	nPDOo+tPg8q0nTASH6myajf4+BgFAENeW10t5E4DYKFXmAsLN16FTmt3XueGwghoiaZXeeNPb4k
	zFY1+fIrSvHZYmYkqr/Dd4IdXD28BV0X74GYbmypKkNYZPOZ8BYVG2E6Pgb/XurexMOcQdHGMOb
	rwINgpyb33aLR6b2z7jYj2o71qJIlWTiA478TM9Sf3mc=
X-Received: by 2002:a05:693c:3f02:b0:36e:1fbe:3571 with SMTP id 5a478bee46e88-3796365ee8dmr1632220eec.3.1794559799163;
        Fri, 13 Nov 2026 00:49:59 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:1866])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm5251032eec.10.2026.11.13.00.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:58 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: rusty@rustcorp.com.au,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] virtio_console: fix buffer ownership and unplug races in the read path
Date: Fri, 13 Nov 2026 16:49:52 +0800
Message-Id: <20261113084952.211929-1-shunsheng1218@gmail.com>
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

Two readers can use the same port at once. The read path checks for
input under inbuf_lock, but fill_readbuf() copies to userspace after the
lock is released. A second reader can take the same buffer, and the
input callback can prefetch the next buffer while the first one is still
in use. This can duplicate data or change its order.

The read path can also touch the input virtqueue after unplug_port() has
started tearing it down.

Let one reader claim port->inbuf while it copies. The claim is published
under inbuf_lock; other readers wait, and the input callback does not
prefetch until the claim is released. If the reader does not consume the
whole buffer, the remainder goes back to port->inbuf before another
reader can use the next one.

Publish an unplugging state before teardown. Read and poll snapshot the
input state under inbuf_lock, while host_connected is read with
READ_ONCE(). A read that observes unplug returns -ENODEV, poll reports
EPOLLHUP, and a buffer returned after unplug is freed instead of being
requeued. This also distinguishes unplug from a normal host disconnect.

The HVC callback lifetime is a separate, adjacent issue handled by the
hvc_kick change. This patch only covers the read-buffer ownership and
unplug races.

Tested with a QEMU virtio-serial device under KASAN. The unpatched
driver duplicated records with two readers and hit a virtqueue
use-after-free when a read raced with unplug. With this change, 20,000
records were delivered once and in order, reads observing unplug
returned -ENODEV, and removing one port left the other port usable.
CONFIG_CONSOLE_POLL and real remoteproc DMA were not runtime-tested.

Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off data from host to readers")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Changes in v5:
- Restore the Fixes tag for the original reader hand-off implementation.
- Author rewrote the commit message in a shorter, direct form.  No code
  changes from v4.
- Clarify that the read-buffer ownership fix is independent.  The HVC
  callback lifetime after inbuf_lock is dropped is a separate, adjacent
  fix in #10 v2:
  https://lore.kernel.org/r/20261105114450.971521-1-shunsheng1218@gmail.com/
- Add single-port PORT_REMOVE coverage: the target reader returns
  -ENODEV while another port on the same device remains usable.
- CONFIG_CONSOLE_POLL and real remoteproc DMA remain untested.

AI tools assisted with source review and test harness development.
The author wrote the final commit message and reviewed the resulting
code and test results.

v4: https://lore.kernel.org/r/20261106091739.1334178-1-shunsheng1218@gmail.com/
v3: https://lore.kernel.org/r/20261106053438.1206065-1-shunsheng1218@gmail.com/
v2: https://lore.kernel.org/r/20261105114535.972013-1-shunsheng1218@gmail.com/
v1: https://lore.kernel.org/r/179378543196.71890.7555371342727156729@gmail.com/

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

