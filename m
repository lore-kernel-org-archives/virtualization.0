Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CA27B32C
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300791; cv=none; b=pR8Az8BybubHF8Whw3xSzNlmw/gs37JJGBRqqOxPhOJ0JNsADUTvsp8N6/VeynhpixMG/q9xEZj3SiJpV7ywnD7yBD3RfuPcirY/Y+NkMsm7QgDe/eFyLais8Gmi/6Xq8fIJrJdh1IvohfJrWlEqPSZQfZk0SbwcSuALrNuCqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300791; c=relaxed/simple;
	bh=t8k7v3qPLzWUekqdj32SHdLbPhJMgxMvTA4A8BZ+joo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqQXeygHENsUqzp76kCcaIeMVN/J4AG+n5wF2Rm9SlWwRAhOlYnBYiB7fk0BwgDdJBbtJvFkd13LxHtF1PwhLv2h2P3JBHGeBwMcyR5PH7hsUNFv6mW4xUIFMTxmDdJPDb1AX68NRlfD5FLldQwc3vvkIuf8JGegI5vm2wAY/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvnIdbtp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvnIdbtp"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1614804757so843624966b.1
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300786; x=1784905586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i1nXx/Bw8UKp/4mvBIV9E4y7f+3yDloK/9473BWu9mc=;
        b=DvnIdbtpcsEbghhepyD+518DT1z8fuvuFLkYPTVA4R6GMx0M3sIejIs1PIYKz4B4Z+
         Kq6Su2VVqn5hnJVdY7mxoWPZnc3KcoWOq8vGbl3vu/M/Z7XMOgScX42YuOFNbFYVOiOn
         wm13mYhzUm1e+51Jrd5Yw2OL5GV46hW6lFJ93BebwIJO8Y7HY5i7AqaMZpBfWcctrJ++
         xIfwdpJyO+KLud8o9B/qDkNwW5gN8FX5oLP0p5rSFEFZQEuCwmKml1tgE4OSNUrslSFk
         GSiNm4PbflKTtLq7TNsj/dVLbVSyVBr0TIUbAMW3MI4FfSi1bxtVat7JAWAl4K/dvlNn
         48KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300786; x=1784905586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i1nXx/Bw8UKp/4mvBIV9E4y7f+3yDloK/9473BWu9mc=;
        b=Um57vlpaYDPxV25zTyMTExl9pUDUarZgamxnbcXjiadPi3QGQKwiZlHYugOVBjd8gN
         QlTilDM0fB5Mh/PGq39oVE8wrD4fbHzXZK6zeUj3hwamheqnMRzl7O1EdwFXC03yGFqv
         DzUeiG9QFaLaMyPipToSt4foMEpYvKY4/cHmGSWWZ/jyRRrUBhdYDIhEamvci8oH4PWw
         Nt7Udq7SF/TW929f+Xzj3efnjFVP7Y9dvMtLY3m7NQ0dRJ8pBYIuz1rpvk6i0Ism3NXz
         NPBMAZqBUDWwBs7BuAiONThEUGgiIORqEKz87aFfsdkyOx/aXdqwIo1/FfM9nXzpQuhC
         5Gmw==
X-Forwarded-Encrypted: i=1; AHgh+RpTRl6A3pKjgm5iI7wjsjPF2xr0omQap4vudyFCtla24BMAXc4gE+YhIMOnYByzub9hXJ8+Otyqmrqykj+Cnw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy2XIRimePrkTQKzwv9dsAXwUso3P4rwXSLjZznwkFoDT1OfcC
	cLZjQvuctzutcg6zSZnnPxD+F+ybdmeEZmFzIUuJwv6a4RKWySRSGloo
X-Gm-Gg: AfdE7cne98edMdmnst2qS+6KL+TOoGKAq42tGIEsbN/uvxNaBiOw2GAHFYZ0xtMddmp
	QAfoLxSZMcc2B+IOy0dVzxE0ID+zQCxCtlCUyETeNlFqBgzEeMADHEfmAo/29spc720lTVYNVst
	rSjljFGbzhKI/9ODZ4Go2SeoRlTlJ9WnNTzdqFkGayljUYBhvr5X9An9AEXmTAzwC5OMsQi36X4
	2m+vPmKHR2Jcj/PKrpnnWSrZGcvwhFI1W3wqloA+NEyzKGYXIjcHLUC5FdE1Sv4XYNG5RS2KYQS
	Q0r1N3+Rjl6HU4LgGCwhr3YTPOduYQwwPbttIPzF4jzjg3Xa0ReySE1fkdsaAB5tg0YaQMGz3iI
	cuUeHTKulBEiCP3GRP8o1RXZ3CS7FYyxXqkfZIHx+urihYqYx21Y6OU5bvvidvTt+fnyQLa34tm
	EOkGDH6uF3hxpmOjIh51d7WwE2hJTWx4PjhZ2Q0DB8IiHsYKxs7bGYNCliQ95RPDGxXQ==
X-Received: by 2002:a17:907:25c4:b0:c12:68f2:af4 with SMTP id a640c23a62f3a-c16b4866b46mr133720766b.54.1784300786177;
        Fri, 17 Jul 2026 08:06:26 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-5347-776a-5ef9-a909.fixed6.kpn.net. [2a02:a463:a071:0:5347:776a:5ef9:a909])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5fa2fsm89116066b.31.2026.07.17.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:06:25 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] virtio_console: take a kref in find_port_by_vq() to fix port UAF
Date: Fri, 17 Jul 2026 17:06:22 +0200
Message-ID: <20260717150622.23636-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_port_by_vq() returns a raw struct port pointer without taking a
reference on it, unlike find_port_by_devt_in_portdev() which does.
find_port_by_vq()'s only two callers, in_intr() and out_intr(), run as
virtqueue interrupt callbacks, entirely independent of and possibly
concurrently with unplug_port(), which itself runs from a workqueue when
the host sends a VIRTIO_CONSOLE_PORT_REMOVE control message.

unplug_port() removes the port from portdev->ports under ports_lock,
then later drops its last reference with kref_put(), freeing it via
remove_port(). find_port_by_vq() also walks portdev->ports under
ports_lock, so if it finds the port still on the list, the list removal,
and therefore the eventual kref_put(), has not happened yet, and taking
a reference at that point is always safe. Without doing so,
in_intr()/out_intr() can be left holding a pointer to a port that
unplug_port() frees on another core before they are done using it.

Both triggers are host-controlled as the host decides when to send the
PORT_REMOVE control message and when to kick the port's data vq. So a
malicious backend could race the two on purpose, without any guest side
cooperation. The freed object is a generic kmalloc allocation containing
a wait_queue_head_t, which in_intr()/out_intr() pass to
wake_up_interruptible() after touching the stale pointer.
wake_up_interruptible() invokes a function pointer read out of the wait
queue's entries. If the freed slab slot is reclaimed with attacker
influenced content before that call, then this is an arbitrary function
call primitive rather than just undefined behaviour.

Take a reference in find_port_by_vq() while still holding ports_lock,
matching find_port_by_devt_in_portdev(), and release it in in_intr() and
out_intr() once they are done with the port.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/char/virtio_console.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index faef362dae85..1b63afe24e29 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -304,6 +304,12 @@ static struct port *find_port_by_id(struct ports_device *portdev, u32 id)
 	return port;
 }
 
+/*
+ * Finds a port by the virtqueue and returns a pointer to struct port
+ * with the reference count incremented.
+ *
+ * Callers MUST decrement it when finished.
+ */
 static struct port *find_port_by_vq(struct ports_device *portdev,
 				    struct virtqueue *vq)
 {
@@ -312,8 +318,10 @@ static struct port *find_port_by_vq(struct ports_device *portdev,
 
 	spin_lock_irqsave(&portdev->ports_lock, flags);
 	list_for_each_entry(port, &portdev->ports, list)
-		if (port->in_vq == vq || port->out_vq == vq)
+		if (port->in_vq == vq || port->out_vq == vq) {
+			kref_get(&port->kref);
 			goto out;
+		}
 	port = NULL;
 out:
 	spin_unlock_irqrestore(&portdev->ports_lock, flags);
@@ -1706,6 +1714,7 @@ static void out_intr(struct virtqueue *vq)
 	}
 
 	wake_up_interruptible(&port->waitqueue);
+	kref_put(&port->kref, remove_port);
 }
 
 static void in_intr(struct virtqueue *vq)
@@ -1723,6 +1732,7 @@ static void in_intr(struct virtqueue *vq)
 	if (!port->portdev) {
 		/* Port is being unplugged, ignore further data. */
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		kref_put(&port->kref, remove_port);
 		return;
 	}
 	port->inbuf = get_inbuf(port);
@@ -1756,6 +1766,8 @@ static void in_intr(struct virtqueue *vq)
 
 	if (is_console_port(port) && hvc_poll(port->cons.hvc))
 		hvc_kick();
+
+	kref_put(&port->kref, remove_port);
 }
 
 static void control_intr(struct virtqueue *vq)
-- 
2.43.0

