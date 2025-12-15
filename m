Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB73164D8
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795246; cv=none; b=N6YYkqmPgBbgYCBwLXOhfDpmRpmpnU6GmcjUEEe3WwqvI8N1gfOLwBEjs7Bxx0eVS33HdeeliiadOMMAXFl3PmbNe0qEYiT8+XKmTZzT0HMVasBDZPI+qqH4y/8zY6QNgWZZgj+fZSL16pT5oH+QEPj7nJZu5QEb3uFuMVGjd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795246; c=relaxed/simple;
	bh=/SxEaFMNo7pFquIiCNEE+7QNb48DDtpf3LMr/IucKtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e4wq+6+9rgzpk+7NnPTyYiPKq+L0gdfAozcVwLXs0mZyA1qpjtscTGTLsp48/h3cWEIztd4Q1IB0+satOR6LEFOPhBuI2DxmRPU2LlgtTjqJnbJYS9aczoolYdGH4dHzsz21KF+Hxvjh18hQ1HBfTHW3DoMBkXQ7fARkbL7usUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=EKEVAMzE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="EKEVAMzE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so2795525e9.3
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 02:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1765795241; x=1766400041; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XypjIFMPPz3oCrw1uobW8ajykibBtZzwnq44lW9wyhM=;
        b=EKEVAMzEsIrPUTFWfOxByYV31Ckm6mBRmh2NhoUt9F3erkbBUHSZCOuOt6AVgufy/R
         NKtN1U2ofqkbZif5F2KtV/rnkOTGFZQ0bfuwmDTy8eiOAmAjihp5z1bwf8GF/VBmndXE
         omi5lzqGathpmkI5W+NS5B+MTKmg9GVFsm11kDDdZMss0Gbj229TCFrW6ym+g4Yi051k
         aH9FBKT9JdYtYCHoX/K9TxqrsAcEUkvd2ThQbTJqE0+8fEvcB5wQ5+gEF+gjhc4b8CZS
         RkNPdM6z2XNivqnFQtuBcJlRzTXdpM1BpxAKdzDE4EDLNHUWJcixhZLRu6/4H3cYBd0Y
         3v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765795241; x=1766400041;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XypjIFMPPz3oCrw1uobW8ajykibBtZzwnq44lW9wyhM=;
        b=Hq9odlUYtBNec4acU5iTN+hRKnpqx5Smtry+8fu3KFzbZx6sM66H7cwDWMEzG0EuRh
         F42gWnELTw05pVFnCKTFfmFyxyxfyYikbXBFpn9cmtpPSgyaoc6Ag5INbW2g1K6nW59P
         0dGtRYYVHfcQLHC+LG5i9EwUXDSlaeAqXZRWiryHYuMDd1EbeGtl9lrUN1eIUGrU97uv
         BgZaOs1iOrJFs/3lUjin7x5kysJxzH0bFVdl0dqhvehs9LcGb2cE+fPzaza0WuBc7SGQ
         F+0S9LDXaWla4BGIW9Uu/PUCtEjC2+bsCXmhj9n1f1HLlNfEgp73Yn6zIvUEeKUek2tz
         15Kg==
X-Gm-Message-State: AOJu0YxT2jAwi5EqCTxsU9DfignlSeYkozO/agW/4RZGeJrfAmOlWFPK
	LfnhxPt/saA8mLNVu3jFTvmtidb+8CxVxmimITK/eX3rG6muLdC+Ou7NDrW5AfiPn7S8aX05+Fw
	sj9FT
X-Gm-Gg: AY/fxX5xUTJQfGKCslsoZxFAyHYBIcMZgHub02hoA3D3z8eVd+qgJCKDvsQdbTr7B3Y
	IKl7s+3pY++2OOIsI1gBPWbfnRoLMynz7A8OGOKuAWaCGSAUMarxRVk5C3DnERWbsVvWUTOUz8e
	1xjhafvboRoA/ZP/k5GlJT+Syh2dxFMfEuyAGzJvlxmdEFUx3W9vbz5Wf7w59phVgqV6pDnARuR
	PjdxpVxRT3jIAVxGHyTIHUbKIfD90Uz9L0akjNy9lDWYyxSXVciHzgdcEUu+bUil7i/V6JOcwR+
	B5kQBtC+G/3TN84x6OXJIEFIrkfkWq93hn8zm3GoPSWJSTRvcL/XjjgSlLX382D2dciwSYv8tqG
	fbrJZT9WQbRyvXV2srksXJWzEc5tMK34uYwxYsEwpoWmnK5OMGVwTccP+6HfeIya5sSWyY6YHZd
	sIt2/JoEFPeYk/W+nnCSwm6yok+2+0VT/MRSzdjSmV4EIxsClv3LAI7YjekRpcrH2/6AcMv5v2w
	sUbYVQwfOA=
X-Google-Smtp-Source: AGHT+IFKg33PwsCdfmLQrXSGuuWbN6asFRauDAwGkuKbmzIP0FQVXEdLitzX17zXx3ezt3wX8qRQXw==
X-Received: by 2002:a05:600c:3151:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-47a8f8c0a52mr118993485e9.10.1765795241347;
        Mon, 15 Dec 2025 02:40:41 -0800 (PST)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f49da20sm178569895e9.5.2025.12.15.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:40:41 -0800 (PST)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 15 Dec 2025 10:40:13 +0000
Subject: [PATCH] virtio: console: fix lost wakeup when device is written
 and polled
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com>
X-B4-Tracking: v=1; b=H4sIAIzlP2kC/x3MwQqDMAwA0F+RnBdoO+LBXxk7SE23YGmkcToQ/
 93i8V3eAcZV2GDoDqi8iYmWBv/oIH7H8mGUqRmCC+SDJ9ykrqIYtZhmxqy24j7O/FvQJer7SHF
 6UoIWLJWT/O/89T7PC4hn8hBsAAAA
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

Fix this by making reclaim_consumed_buffers() issue an additional wake
up if it consumed any buffers.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
As far as I can tell all currently maintained stable series kernels need
this commit. I've tested that it applies cleanly to 5.10.247, however
wasn't able to build the kernel due to an unrelated link error. Instead
I applied it to 5.15.197, which compiled and verified to be fixed.
---
 drivers/char/virtio_console.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54debd6029ea2c2a5542d7a28500e67b8..7cd3ad9da9b53a7a570410f12501acc7fd7e3b9b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -581,6 +581,7 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 static void reclaim_consumed_buffers(struct port *port)
 {
 	struct port_buffer *buf;
+	bool freed = false;
 	unsigned int len;
 
 	if (!port->portdev) {
@@ -589,7 +590,15 @@ static void reclaim_consumed_buffers(struct port *port)
 	}
 	while ((buf = virtqueue_get_buf(port->out_vq, &len))) {
 		free_buf(buf, false);
+		freed = true;
+	}
+	if (freed) {
+		/* We freed all used buffers. Issue a wake up so that other pending
+		 * tasks do not get stuck. This is necessary because vring_interrupt()
+		 * will drop wakeups from the host if there are no used buffers.
+		 */
 		port->outvq_full = false;
+		wake_up_interruptible(&port->waitqueue);
 	}
 }
 

---
base-commit: d358e5254674b70f34c847715ca509e46eb81e6f
change-id: 20251215-virtio-console-lost-wakeup-0f566c5cd35f

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>

