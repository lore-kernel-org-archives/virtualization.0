Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785564;
	b=UAXYREEFn83tAITpxIEoB2hu8oXI8Tnz1g6+pARut34WvZx9oMIj79uR+dhz0LSKHGQZ
	 oA6e9uhlGMdduOOokaYr5Eqs0WvV6XyWGMpY/EI93Yvrt/pv9Ozm9zoPhU0OHS/46QZEP
	 LoamSN+SD8mRc+48vMGUeht0VBYKi42rXyl39w2XZS7UZmnnl/4z/ANUxPXOstSoawJiu
	 pAjLcrdvV/8PrfrBva5VuRX47uxUlgBJTSZdhu9x4yyqRaVW+CWpaF6YtZcyx0AtXp46V
	 iB+0Hx/rNYmm52Q3kbCbrad3jeeprYUZLIGE5hw6PhCNJOm7gJi2+OumqS6rilglIBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:Message-ID:To:Cc;
	bh=A+QDxq6UCdJRaYtuHqXjnpqOCcz0MOA82xty3nzNvPo=;
	b=Zc1yuhiiYMbu8igKA59azxEyH+FSJxbkRTKkNhbyUxPq7vfibrpZxpuW9xjIix1rBoFG
	 Ttu6tE22k67yM/806fA534qrdacPuVlqcUqxlv66KGf2YT1yoyszolu2wPbOuZ34Afam4
	 uJChroNVairWJqbzwyfmSdkOHZupeSDfrTNlr2glFfTTVxzZp2KD4ZWbQzJyRvjha6zql
	 GukCcbWPaQnkuIB1Ye6AyBpnAus/4oLIDtO+OzgitWT/KPK7lVs7Vgl8RexegAaY8oqUm
	 ic5TQLKCb3rf31zUldJT8bDufm67Ug8lBQt0p0MEC3QyMglMMKSJjfTyfSt1MU7ujfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qCJZvbB1;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CF606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E4CF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qCJZvbB1
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a315ed211so450758eec.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 01:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785563; x=1794390363; darn=lists.linux.dev;
        h=cc:to:message-id:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A+QDxq6UCdJRaYtuHqXjnpqOCcz0MOA82xty3nzNvPo=;
        b=qCJZvbB1zHZbKLoopQrARmS2ZgjSpLEFuZaQiOSSfJnTOwW849IzIv1oR6ZR5SiBFK
         3D5eBa7Qw+sR2Z1ltuQh/3XYXAYiEu6ua5KwBKtgtaelDYoNatXqjkvM2PP9clJK2L6L
         pmyjjgiLPlyGCAaSpguleWDLFyL24wZ5t/0Ain22pjyz5lQqVxsmAlGXX73I9luXdA00
         +dU0CL4n/abX1392qsQqr/QLsDUW/D+PNqEDuP7ui2TmHNgq7fWeKwa2CyVE8P9epiPf
         qaSF6sHKIaQDyS8FFMlbyyDQeKnzlLV9aHvAX8MSfrDREOUy06HCzgiLz+nWRi1hTXoc
         9aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785563; x=1794390363;
        h=cc:to:message-id:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A+QDxq6UCdJRaYtuHqXjnpqOCcz0MOA82xty3nzNvPo=;
        b=zHlhpflNBcMuApuWe28WTVU+okVl2FcAjrpj0mZZZLaS8SYdjjkVn+s4k6TPwEtQS3
         PY1ZUlSkN0kBRsqTA3uo/zqAKlnik8RJD6zZtXN4ONqMHtfeNdEo4Yw5iI6yA/JyKalg
         3S7l7KTtWLPo8rgnH0uFmy9R+p2YV7wK5zl+CxupBM4/DrwNJdOYt5kbnhYU0PIIbg3B
         /bBpU9IjnFxeb4iAFXn7A+OBpq4CN0EoLlLX84xqOmUpC/q+wJiBPLm9/jbxR8Slodys
         QM64RVI8WFqBA5XsTjpEZPnzQhNushmKc8XcbpXz0hKA8/nNCboB827ml0XJB1oxpjaY
         8n0A==
X-Forwarded-Encrypted: i=1; AKwUvBywIfLVPvVozJnIsfDQYYlPHOWQdQ0JIOajyjU2NI9FDh9XzcOd51Su/tvNkfY370w64+fhAVdxfnIUkbujcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/R0vhCSG/7Cc2NGrJcnd7bAV1iJqBJSCX/N4e6bKIrtrv4uACc
	2JD9kpQsFHudj6GLSuj/C1UnpvfwVohnwk+2BIJKdFnZ7v19ag6WARoZ
X-Gm-Gg: AYBFou3HRy390mRhPF7Dw3ys/c6AmDODH+JLXGVcheJQovOCfmjtnyjV33I/4Nd3K96
	/87d3g7kYYsJOLIbqfU8sx+Ml/gLSzsmTRrRphCKkO4SQXe0OKerOTmrAU4SdsYB/dbfiJXpCzp
	Ef/7PMTvoD9SpR208s1tZM3r41isUNS5QYu8ANZ3Jvo2aI3gn/lLh/Afu87ZcxTLufjRAYL8tOX
	WzEofqT3rYAbM2WxS3v7ytWW8+oHE8+HrIagDyJkgatupQK+hQFSm0qIz6nCnvdzeymt/5fb/gU
	M7g7g2uTHEPaK2a/1Ov3z8IuoR1ZUq0CAFMENYwsQIm7/qZBC5LfEaVNMSR/R6Z4rM9l4xO0Bmo
	ZYN4fR2tnpbtMosxHpPTjP8iBRjiJSyCQuNAOZDzec0GLwATvTOi+Vo9PFdRdDyPcbicajit5EF
	kbF4pJzDUcPjF9padwCD9iAYmarSYahchtqIjnXAQUnQx+kVoi3Vlfo5gj4+eZWY9jWq6l0dJtQ
	QlsFzd38ahk7m/VTfWjAZkrCFMnDFszldW8ujAqGInA5ecFDF/yzfDoPiEh8WBIaBM6sTvvIFM2
	QD0QhSPyWfLXiOuv21CoLWmq9mGkxetBB4kzn3JzXwthCCUEqFAUYf1U0MoHBX2blvs=
X-Received: by 2002:a05:7301:9e43:b0:36c:a2cb:6ad0 with SMTP id 5a478bee46e88-36ca2cb6d90mr3896987eec.8.1793785562810;
        Wed, 04 Nov 2026 01:46:02 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3958746sm6179404eec.22.2026.11.04.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:46:02 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
Date: Wed, 04 Nov 2026 17:45:39 +0800
Subject: [PATCH] virtio_console: synchronize HVC polling with port removal
Message-ID: <179378553951.72222.12851179500568566393@gmail.com>
To: amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: rusty@rustcorp.com.au, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

in_intr() may call hvc_poll() after dropping inbuf_lock. At the same
time, a hot-unplug event can remove and free the HVC adapter without
waiting for an in-flight poll. The interrupt callback can then
access freed adapter memory.

Read the HVC pointer inside an RCU read-side critical section and
publish NULL before removing the adapter. Wait for existing RCU
readers before calling hvc_remove(), without holding inbuf_lock
across hvc_poll(), since the HVC operations may take that lock.

The race was reproduced under KASAN with QEMU virtio-serial and
multiple interrupt vectors while host-initiated hot-unplug raced
with a data-queue interrupt. The same injection-assisted sequence
completed without a report after the change.

Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off data from host to readers")
Assisted-by: ZCode:GLM-4
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
 drivers/char/virtio_console.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5c..a3ee4af106d17 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1551,10 +1551,22 @@ static void unplug_port(struct port *port)
 	spin_unlock_irq(&port->inbuf_lock);
 
 	if (is_console_port(port)) {
+		struct hvc_struct *cons_hvc = port->cons.hvc;
+
 		spin_lock_irq(&pdrvdata_lock);
 		list_del(&port->cons.list);
 		spin_unlock_irq(&pdrvdata_lock);
-		hvc_remove(port->cons.hvc);
+
+		/*
+		 * See in_intr(): a data vq callback may be running
+		 * hvc_poll() on the adapter. Publish a NULL adapter so no
+		 * new poll can start, wait for in-flight ones, and only
+		 * then remove the adapter.
+		 */
+		rcu_assign_pointer(port->cons.hvc, NULL);
+		synchronize_rcu();
+
+		hvc_remove(cons_hvc);
 		ida_free(&vtermno_ida, port->cons.vtermno);
 	}
 
@@ -1782,6 +1794,7 @@ static void out_intr(struct virtqueue *vq)
 static void in_intr(struct virtqueue *vq)
 {
 	struct port *port;
+	struct hvc_struct *cons_hvc;
 	unsigned long flags;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
@@ -1820,8 +1833,19 @@ static void in_intr(struct virtqueue *vq)
 
 	wake_up_interruptible(&port->waitqueue);
 
-	if (is_console_port(port) && hvc_poll(port->cons.hvc))
+	/*
+	 * The vq callback calls hvc_poll() on the hvc adapter, which
+	 * hvc_remove() frees on unplug without any lock shared with this
+	 * hard-IRQ path (calling hvc_poll() with port->inbuf_lock held
+	 * would deadlock: the hvc ops take that lock themselves). Take an
+	 * RCU read lock across the poll and have the unplug path NULL out
+	 * the adapter and wait for in-flight callbacks before removing it.
+	 */
+	rcu_read_lock();
+	cons_hvc = rcu_dereference(port->cons.hvc);
+	if (cons_hvc && hvc_poll(cons_hvc))
 		hvc_kick();
+	rcu_read_unlock();
 
 	kref_put(&port->kref, remove_port);
 }
-- 
2.34.1

