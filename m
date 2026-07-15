Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575236F8E8
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125438; cv=none; b=m6Kq7lwsAxP+6omPMcJ0W0oV+XRbprvpmFzj0NMebElc08FSswa8+nfRLDuKEvHWXB0dTjwtPjZWFpd/5bxUgPOb9Gphqv5EKI+G09lc0Za4y0lOqcyq8/AmKMWOiifbPie/G+92U4FsFxER6N/cRFXc7qyx00TrKuKLOOU0a7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125438; c=relaxed/simple;
	bh=tWfme+tzQ9G7mAqvSYSvjdoyZ1LogMZJCZU9ph6QRJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkQ35oxxouXIGoFNWls9GeK3t2Lu5SnQuvtURUL+FJJM4Xr/l9mwTPpwTKoSpDJAi4pvE8nbZ2sf+cXExxCtwtJCmtRZIAJotcwxL6cAPjcrBQDUhDz0txd/jt+gsMI88HlcV9G2jRKLK5xrqieEKxbZzQCTFcpR4SSugEB/G0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELVf0zf/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELVf0zf/"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15ba5b151dso285432066b.3
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 07:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125432; x=1784730232; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gSGPZtrn7btUtmz6wHgzIANbziCZWoxzvDyAbH1+WOo=;
        b=ELVf0zf/fg6soe4YuD9REbQ5PgHThvVieyy1pUDGCtIQBoP1c3ENmN1zLf8qcPe6a0
         xT06PItCJRUtclDMSK9WwtShMdR0r2sn/j4whGmvBcejaH0+hf6nfHjAsScfdumCyrNs
         scAnmBTLJjpMqX7fJ91MYWqHXs9C7zwrk7WzKG0n5GyjVyqWqsZMU+Pu0+CjwwgTHrOE
         QtN4/yk3AqYJxIZ+cruwMNh3WwM/1mtN5Emcqw5/3RlV7Yd1AhfYmHkcPQxnsdykfKVh
         mZqlmkX0EXIl2o1HLwidpA063g1pqItX5jV9dHr5tPRYUZa5Ra7I+nE9ChHudD2Po+Hk
         Thdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125432; x=1784730232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSGPZtrn7btUtmz6wHgzIANbziCZWoxzvDyAbH1+WOo=;
        b=my0YuqQJXQ5Xh1i0a6Rx0ZtIRttc9g6Y2th3YubHdLQy79TWFjDKjcK+ks++JGy5YU
         P+WbPSxwDTyssmdyV0W1fnwCO+ZUlnlW3jtZf2jsCTjGDbTd0o1G6HYMcfpdowRwBILV
         za/vMy8pQ5o07acJZtRoAHW/gHuxNtNe5TEcRLDXoc6spSzVw0CxPEhM/AOsHe11/kYi
         UJZz64MIUavs2XbkBqlmj1RKGA02Ba9yabfQ6pXH0dZgwZ+MiDAeZimfA8pfFsR4MEMr
         fHFed5WdjgtKk6VWF9do0kWRAeL0OG6cFslFlyz8476xtTKhv/1FW7uldp7X5C8faeCr
         GZ2g==
X-Forwarded-Encrypted: i=1; AHgh+RpxsQAXguv+ftNm3pZ201rmbZk9gIg0TS5HxTosQ8AFyLK2/HWx0omQxe8wqWEKcxydLPutoGm1G9jJTaBM4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwsHb98abQFGco91gUmVmIuq+K8S1XsVDHEKB8uI1KOOVp5w67
	sAzVUb3GpKIu96rEArtaRO7vXlHMIwV6jcWYNMDtikDVIqA0qTjwS2aS
X-Gm-Gg: AfdE7cml1s3kg5pME8o23/X7rZaGwMPxp5g1kkhT7GYcA2diAWHYRpyUeBqZx4kHQLZ
	OaRM0YS1LPwKG8Mn+hBZ7UI1gLmuA8mDsi5PHI5NRA1WbeM4T82v9BYD9R5mVn+RYJOUN7ScHDy
	+XNVcru8xMOrkcIUZuZS8odLyn3xNrlZMdDqWEBIxxdLApY5Vv5ChEy0wFklOHCobk2IHQk/NW+
	q83dgwuvzKoAWK9HKgYb2PsETI/ZQ2fP/EdTPLRmkzRdf7Fqs8IWzmL9zOHCDbfDuXhM6PmxIcN
	hkKEv1g2eQX0OIcRLaXsObVGQyp6pClHfMPgRgY9NHXVd+CbMpGTN26lG0Xr2SzuSzRzOMeMZlZ
	A8MUIglTMGAXsuW/j2M/G2N6h5Fsgn5qoMNGPGBBOTCBBoMb4Qm3MhM3amBxQCbNNtCkZDQlnnQ
	mzZi5gpS555eFxqTGvY5EQLR7v6Znh2P90ipbkysDfy5L1G3PjYEox1rDSUYC3DAN1knScBSn/U
	Sqp
X-Received: by 2002:a17:907:3f96:b0:c15:f26a:3438 with SMTP id a640c23a62f3a-c161ea32e98mr929035366b.24.1784125432269;
        Wed, 15 Jul 2026 07:23:52 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:51 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 4/4] virtio_console: take a kref in find_port_by_vq() to fix port UAF
Date: Wed, 15 Jul 2026 16:22:43 +0200
Message-ID: <20260715142337.22811-5-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-1-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_port_by_vq() returns a raw struct port pointer without taking a
reference on it, unlike find_port_by_devt_in_portdev() which does.
find_port_by_vq()'s only two callers, in_intr() and out_intr(), run
as virtqueue interrupt callbacks, entirely independent of and
possibly concurrently with unplug_port(), which itself runs from a
workqueue when the host sends a VIRTIO_CONSOLE_PORT_REMOVE control
message.

unplug_port() removes the port from portdev->ports under ports_lock,
then later drops its last reference with kref_put(), freeing it via
remove_port(). find_port_by_vq() also walks portdev->ports under
ports_lock, so if it finds the port still on the list, the list
removal, and therefore the eventual kref_put(), has not happened yet,
and taking a reference at that point is always safe. Without doing
so, in_intr()/out_intr() can be left holding a pointer to a port that
unplug_port() frees on another core before they are done using it.

Both triggers are host-controlled as the host decides when to send the
PORT_REMOVE control message and when to kick the port's data vq. So a
malicious backend could race the two on purpose, without any guest side
cooperation. The freed object is a generic kmalloc allocation containing
a wait_queue_head_t, which in_intr()/out_intr() pass to
wake_up_interruptible() after touching the stale pointer.
wake_up_interruptible() invokes a function pointer read out of the
wait queue's entries. If the freed slab slot is reclaimed with
attacker influenced content before that call, then this is an arbitrary
function call primitive rather than just undefined behaviour.

Take a reference in find_port_by_vq() while still holding ports_lock,
matching find_port_by_devt_in_portdev(), and release it in in_intr()
and out_intr() once they are done with the port.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/char/virtio_console.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index faef362dae85..1b7593684ed9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -304,6 +304,11 @@ static struct port *find_port_by_id(struct ports_device *portdev, u32 id)
 	return port;
 }
 
+/*
+ * The port object's reference is incremented now and
+ * it is the caller's responsibility to decrement it
+ */
+
 static struct port *find_port_by_vq(struct ports_device *portdev,
 				    struct virtqueue *vq)
 {
@@ -312,8 +317,10 @@ static struct port *find_port_by_vq(struct ports_device *portdev,
 
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
@@ -1706,6 +1713,7 @@ static void out_intr(struct virtqueue *vq)
 	}
 
 	wake_up_interruptible(&port->waitqueue);
+	kref_put(&port->kref, remove_port);
 }
 
 static void in_intr(struct virtqueue *vq)
@@ -1723,6 +1731,7 @@ static void in_intr(struct virtqueue *vq)
 	if (!port->portdev) {
 		/* Port is being unplugged, ignore further data. */
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		kref_put(&port->kref, remove_port);
 		return;
 	}
 	port->inbuf = get_inbuf(port);
@@ -1756,6 +1765,8 @@ static void in_intr(struct virtqueue *vq)
 
 	if (is_console_port(port) && hvc_poll(port->cons.hvc))
 		hvc_kick();
+
+	kref_put(&port->kref, remove_port);
 }
 
 static void control_intr(struct virtqueue *vq)
-- 
2.43.0

