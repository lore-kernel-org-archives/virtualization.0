Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C33A2572
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126581; cv=none; b=Fz6OBsctmUi8+Yh7yoP2UjVJwbF6Z509YVU7RODAf2EPXjBwRMKrLpr+eII8pyaXtuVZ4vEkaXaKA39c5EmDUzvZHL7mVkrLjPws2OZLe1/paNA9Zs5uS8JRjiUAsPSE1ZslhPduIw4QnmO7kfySnBtJ7gXhph3ykjq+zq1LCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126581; c=relaxed/simple;
	bh=GiLQK2P9mz7B1AOLw3zNKl/JkrN5OSok2azGQMRbFRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHaHqfm48XtYn55JB5v8Ji+ZLQgNRCmCohCNUzv9VQS7tkm/Iq+lfLop23XHLc9wdT5i989OaLV7IvzKlb7XE40Iem7oz/4pww9AUoLGla33SapPxlvMtqRjDBUAPBtiX1SkdtG9dFRsF9DPFMsTvgHdFAfDlwNzzQ3ukMYzVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwbLCt9t; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwbLCt9t"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a50189d25so9847917a12.3
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784126578; x=1784731378; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSbTXzpQvZ2uVegQIg8zTuF9MAlBVbm4zZyffa3w32E=;
        b=dwbLCt9tNkSZeT1//cEzy1jxG+6MFvz9DMl1UIeCjkMiXptezu9SLRDyl/JWzLozK6
         fgd/sTG0WZ+ZlSonJDzKslaIz1U1ATyTSK5AmQXJTnkU27cDKwZColJ585X96cX7rPtA
         euq3dOXRLvYivstmAdsUEdQthRwC7jkAwVVpkPqEUymOHnR6adIxzj65H4Lg4s5t45sW
         YazOxs5Bul0zml2HsR7ZFLX65l/VyM7Q3QACUNdogiN31UCOYN2bNeaQWU0wS6gtK3aY
         gF8BPop+oj8y5G/fA3ig/EDdKESSNpvxDG9/ioYGtWJPFzv7wlFMlgGiZJogVcV0Tiqp
         HPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126578; x=1784731378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSbTXzpQvZ2uVegQIg8zTuF9MAlBVbm4zZyffa3w32E=;
        b=Ohrm2Agk1PA1qCaUWz0YPUDljd2nvHRTJqerg2dNRFF3yVQQYaoeP8Gx8yhXlZ3sS7
         +GJDEEUgSPCeVRNieYSLlE3BUn/LDf2XUifCMXAkTgMMEHTeVqHOFk+OorC4nxkpbm1+
         iybIUkq5HdmfMaCwkLJvrq+9oJ2Lj50F0e2qPZTg6pcusr7uom0dlhdh12i9qkJEpfjd
         i78XHzMFpvb0YRqWuRh79/LePojED8pdpdzud6KhWe0QTX5etQ4pt9WgYpytf01dosZk
         qc0bflZ2fiBBLUw/Yuw1bsaiCidZRyWuN4RCWhX4I3UI0wbQfFs5f6YghzBddI7wuT8C
         OPIw==
X-Gm-Message-State: AOJu0YyBPJ8oFx3gAXlEID6qDMEmsVs81Y48yKt1RCwspvWbrumS7oAx
	shtqEYEK3pVLSJ/oEnfX7zwR47Ta04cf4vR0tYOMvWZzzlQUE0c7nVNJAzX6bz/1FgkyQg==
X-Gm-Gg: AfdE7clJBpqzKwmq49ur5YbbE7owrgxs+8W5z5ZgZ4y6hBGI4R6maT4WH/N6dJoqbAp
	DixDnrynEsOfzRJYKMcEZLcM9+y3JRii0YlliOEOCOB7pusvA+rcefuQubiYBpg3wmjmnaduMLU
	Dq3LMsD3kzKE1dOS9q+aL0YwVbMzCm3RAm8nW5840TwJUCPWoBdqk4tLHYSukQBLJqw9erm1+Fv
	Ofsyj7qh70W5I3OtKb+xpNkTW9ADg7ryDF21/gwii2XLvynDKF80wBl5OfBfn00DAoHib3uhxOx
	r7A7Jvt/qKxZNodyX+QN0e2R2Kd86VwcfV6+3Jl8jXgh+u5vMbENRevaRZctBa598BqvAzZsLnD
	9R/ZZ9+RzKD1kQDz0dpfYEujRpukUOizSR3BCJvbryzod9OXLI2pJkRpS1nSMqjm1M5/Q9JMARy
	yxiAb20elNmBQ9Dh5+MbI25zcSaerTY3fxG0f9oLi2JzAD7WDG6zx9UhhaQ+1BAjfAZjPUFIl2M
	03G
X-Received: by 2002:a17:906:4792:b0:c15:dbc7:a6c1 with SMTP id a640c23a62f3a-c1678fb5229mr227335666b.0.1784126577566;
        Wed, 15 Jul 2026 07:42:57 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1687125db5sm50849066b.12.2026.07.15.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:42:56 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH v2 4/4] virtio_console: take a kref in find_port_by_vq() to fix port UAF
Date: Wed, 15 Jul 2026 16:42:43 +0200
Message-ID: <20260715144254.26156-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-5-harimishal1@gmail.com>
References: <20260715142337.22811-5-harimishal1@gmail.com>
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
v2: reworded the comment above find_port_by_vq() for clarity, no
    functional change since v1.

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

