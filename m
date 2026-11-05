Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879104;
	b=roUMvUAci3pARperzDtqdOm1PRgsr/bN4xB5TkDbO/JUbGfEXWE32c/1ZEwKbNPhhMlI
	 smETHfWGlxL0301Zd/xUI5Z9cknwAVXbWxV0EhKuDfCn4XpolbRfdNyV3Hl9peQ3OOnxC
	 1wvbkxRyJh7D87qtsiSTQ2PdXIz7s2MZ1q2b0WrLdhQ8itpb80mamYGJdHdM12ADddTwU
	 FDefxDdVcZwFKHus7Y0GirEGVJN9E1IJiI5rfSpq8iX+Y2B1Ys8NFxnlHVqs2thVbcGmz
	 F0wpPIAVKpELAR92EVVMUwWEy65ZajtfaBNr7HiYC2PGNACkMAJfkeseN9ANCDoYbHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HUzBUAOyVMMNnWBATop3PHNYHsyg1DIgGmHpxUSzv7E=;
	b=3r3bfiKdjtyO5IUp4qOr4z2oguqsYleU3YIcaRscNRgsfzYHEqOorkIZ2DVCCP7CQ/F0
	 KG98A9+dzJH6tE9Q1yxNnpE3pSquhPz5EmrpB5MgB+TtrCcQCxHpE1dX1ZAnkZXZGlzIK
	 +D3ZNKIiSW41r1AmhDNupdcl296nhrzDhvsBiThbit41tQ3j9SsBDnPLGoPKSa8r6bSF4
	 OiuQSx9krk0ZdWve0398lUyjY58o3XBldYAvcMuaCyaGGBqpg5flthSJ+DIpOzXMcJunk
	 YPSwpw0Jg/jlPmo8ucDpW4NgMWZHwovK9NTgidovxAVPfcwiJekd+LDon4BsbCPw+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M6R9Cvid;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D95606A337
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 11:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D95606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M6R9Cvid
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so691147c88.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 03:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793879102; x=1794483902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HUzBUAOyVMMNnWBATop3PHNYHsyg1DIgGmHpxUSzv7E=;
        b=M6R9CvidKifSP6xtTR720d90h2wdy1WKNYDwE0jdIUHvCEyuMVvH5pgfTXs6dsvmn+
         VnWz8N7s5x8qkQ0XgShPf/+7WtkrIG4bh+qrCNJdmQkASn+pAyyPa65fB5vTnnyeBvyM
         2ddpz8VqYQGsY4BjLzhJmQ6PhSB5Lg2rDjP3lkXqG4hTYEEjh//Q5W0OiAfotV0mlD5S
         E1qJPbE3IPpJWyC42ZYH2XVqFwMm6X8a8VwaC+41CnMnadcA7zoPU2Av0xLPwg7eaXeu
         J/0CsK3Rl//o6crdL5I1ukmya9/whP4aluZqdb9jGBHAwcqGJNkdZfikwgGK713YERuQ
         Qqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879102; x=1794483902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HUzBUAOyVMMNnWBATop3PHNYHsyg1DIgGmHpxUSzv7E=;
        b=1uiAiFJCAyFnSnyicGhyuEXG1w5K0Ph96NJ0b36MuUykYwJAhFiIBoFNVuTXSN4Qnd
         fPyOeDQXnJYwGfPx4J0mpMDRZZPFrnOTuD3gPcXfMi4C8oXhbBkzhIAuvSze64zv5Rbt
         9b0aL4IacT3Qi/DlIwW1vXDKbRE//4YIv1l8sQvrSyvUARGE/pcJ5sLRaVTMBAeY6kq5
         451EGum0nckWOxIZAIbGzKanVjT/Gv3HqhSw538WcuI/qYDygOHHIjq97evllz3ixw5h
         rv7xnDR24ZWLXfHhWH2HhEYghrkW3mIj78AUarrIM+ftG6FAXnYLsfJxVikFvYPmHlF9
         3WlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbQ+k33LhZsoeEuOwSH9IRT43NpHq7WpIn1i9aYY9kLv/icxNJOOKpwoT9NHNNd92dhDjIeifNWKtBlu2BvA==@lists.linux.dev
X-Gm-Message-State: APuU4Z80QvIe1AfA6/soea3pWybxFwllHL1Fx/NdLmX/d1dj1wJk9/VD
	Vm70QhwxIc85VDm9XtzzBcYRC5AbF7/kBRxIH7bYuc57hOx8ZnFnpzSm5VMyyTEtjWBiwg==
X-Gm-Gg: AYBFou1X5lLyMJVQTYIAnXq/WEjmasweJAKicQMteWgnkmgzQp0HOH+llwPo6FqiuxA
	y+1jdtS9wp6Fq237B2p0ewjCHCjxHM5FAabTski9xX2imvUUOv4tnq0tdLKVO2QBf6ko19ikVor
	ILpaABAmDiISoy7LNSxs/ok+znLGg7O/Ic9i0SJG8wOuyt0RRq3cRmqgXmohq5kQ2OVXY62vUXj
	uWJOuKvBjIvIbf2u4xFhwFqnyDWzNoNZbunPcp9MTqT7MUnK3LZ6DxJ0ctttnNucrOWocreSdXY
	/1nEZlSuw0qhQEvn/PiLlIpGQ9siXK/cCQU/eTCHGDHLxDydJFD+tTL1c4d746hOYHn30PjroJQ
	OnukmdQek7um/2uH8BV0cdJIyXN+YaZoux9FszMsCPqh28nJvWna/u3MQIYo36WSQRcuV8Owsze
	78zGOyuFAVy9QWTywp0R6i7DH6t61jybtVvUl28DxteQmJJLh0JfJU4fIqylzeWqXzmy4ZLWs87
	1OuYZpue9sddJrTZI4rhNdaIS/OIxoooof0WpVI4ZBL4ugu97UDyIjESjpI3pfS5fHTqOviMdg0
	GdZzzs2oyd3YB6EvaM4id3KQ97vzbtp90ZkvFduxO4CJ9aPhXHFtoQ6oWx1goRfAYfiAoY6Q5Ye
	aq7heqv9rkQ==
X-Received: by 2002:a05:7022:120b:b0:151:5d01:9316 with SMTP id a92af1059eb24-1ac5ac4f406mr25397405c88.23.1793879102040;
        Thu, 05 Nov 2026 03:45:02 -0800 (PST)
Received: from lwq-System-Product-Name.. ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245ac2f44sm16650061c88.0.2026.11.05.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:01 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: rusty@rustcorp.com.au,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_console: defer HVC polling out of the virtqueue callback
Date: Thu,  5 Nov 2026 19:44:50 +0800
Message-Id: <20261105114450.971521-1-shunsheng1218@gmail.com>
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

The input virtqueue callback calls hvc_poll() on port->cons.hvc
without any synchronization against HVC adapter removal.  A port
removed via a VIRTIO_CONSOLE_PORT_REMOVE control message runs
unplug_port() -> hvc_remove(), which drops the adapter's last
tty_port reference and frees it, while the callback may still be
about to dereference the freed adapter:

    BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave
    BUG: KASAN: slab-use-after-free in __hvc_poll

Both sides hold only the port kref; nothing protects
struct hvc_struct between the callback's pointer read and its use.

Do not touch the adapter from hard IRQ context at all.  Only wake
the HVC worker with hvc_kick(): khvcd polls registered adapters
while holding hvc_structs_mutex, which also serializes
hvc_port_destruct() before it removes the adapter from the list
and frees it, so the worker can never poll a removed adapter.  The
callback now only reads the adapter pointer value (never
dereferences it) to decide whether to kick; a stale value can cause
at most a harmless extra kick.  The IS_ERR_OR_NULL() check also
avoids waking the worker for a port whose hvc_alloc() failed.

The price is one extra scheduling latency for console input
delivery.  A 64-byte echo benchmark over a virtio console port
shows no significant difference (RTT p50 0.089 ms vs 0.083 ms,
855 vs 767 msg/s).

The race and the fix were verified with an injection-assisted QEMU
setup: stalling the callback between the waitqueue wakeup and the
adapter access while a QMP device_del removes the port produces six
slab-use-after-free reports per run on the unpatched kernel and
zero reports with this change.

This issue was investigated and the fix was developed with AI
assistance (ZCode/GLM-4).

Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off data from host to readers")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---

Changes since v1:
- v1 protected the in-flight hvc_poll() call with an RCU read-side
  critical section and published a NULL adapter before removal.  This
  version drops the RCU scheme entirely: the virtqueue callback no
  longer touches the HVC adapter at all and only wakes the HVC worker,
  which polls adapters under hvc_structs_mutex - the same mutex that
  serializes adapter destruction - so it can never poll a removed
  adapter, and the unplug side needs no change.
- Verified with an injection-assisted A/B run at the same stall point
  (in_intr+0x18b, between the waitqueue wakeup and the adapter
  access): the unpatched kernel reports six slab-use-after-frees per
  run, this patch reports none.  Round-trip latency and throughput on
  a console port are unchanged (p50 0.089 ms vs 0.083 ms).
- resize_console() and the control-message HVC accesses remain out of
  scope, as in v1.
v1: https://lore.kernel.org/r/179378553951.72222.12851179500568566393@gmail.com/

 drivers/char/virtio_console.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5c..c5b3a6c0ff3d7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1820,7 +1820,14 @@ static void in_intr(struct virtqueue *vq)
 
 	wake_up_interruptible(&port->waitqueue);
 
-	if (is_console_port(port) && hvc_poll(port->cons.hvc))
+	/*
+	 * Leave HVC polling to the khvcd thread: it walks its adapter list
+	 * under hvc_structs_mutex, which also serializes adapter
+	 * destruction, so it cannot poll a removed adapter.  Do not touch
+	 * the adapter here: hvc_remove() can free it concurrently during
+	 * port unplug and this callback holds no reference to it.
+	 */
+	if (!IS_ERR_OR_NULL(READ_ONCE(port->cons.hvc)))
 		hvc_kick();
 
 	kref_put(&port->kref, remove_port);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

