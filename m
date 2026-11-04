Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785460;
	b=bcKL5piLZ9QPkXWBRPeQN+U0tjVIWpfIfo130hSbnFTLOwwmqWQvDihicweuGVkatBQ3
	 kfg9CUo3GLx6ZveecKY8tiRlZMN9OSB8Z6WkW0xjev3eNaZwx1MdSSqmBUh5aOZZRZy/I
	 z0NbiSVgWNHo2FOhwphoINbHtr+kZEf5bhHcQP+0IjhusDslE0cnF0HdCuAQmuQVlOr6a
	 PWArTDZUPAUiACPuk/t611ki0bIDCCRtAepLZGf1Sumu8dS7Ld3HmeTfmiuh2zqoP1Phu
	 p98nHGHvMMN5ax+Ezv1LYAm9KlknTvsKAKPQ2IYaWUOEn5pGX+Y9+DqGw4SaVmeV6cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:Message-ID:To:Cc;
	bh=eCaLjyOBd6911x6Yq+VkNvkgea81PfoqbKdxl69yD3U=;
	b=zeANtE8sFuoh4HKIZUCZT3C8EwD+zT5cMhr7ERLgWpftZioNc66/h20oPfpZgSyNtteL
	 6S1WwAnr2rkzvQuD6VbInO1+ywqg/cZd2byRGyCRbKcIIr7KPF0lsmoiRESU1jebFR0ei
	 lPz921E1SR0kP+iBL7L47Pdgo7AmiGJu7dCX0Fi3/QLNKG2qNrGoCLrM1FcFrGvULr6+9
	 JFhGFT4uRZ1Eoy3mGiXv/zW/m+VQl7d32Md9bx7sjGyTYJiZniugwHeUrsWsgH6GvOxU6
	 dGpJo672jIkACzm7Z8S5LXFg4xIOAa1Bko/IhGa9LREfkoqfah/pWwRN0Uf1aN1z2NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLgFjLkp;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AA606A328
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 726AA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLgFjLkp
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36cedf1bd63so462007eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 01:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785459; x=1794390259; darn=lists.linux.dev;
        h=cc:to:message-id:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCaLjyOBd6911x6Yq+VkNvkgea81PfoqbKdxl69yD3U=;
        b=yLgFjLkpUtiPjlgZOrdqisN0lLb4sRldRI0H7Y4b/b/FHVUzKx1DSSMNA9E+Agq11D
         +PfAcsEqjwVLbmdsKs4BoDLrX+xT1wDeYBdUEV4BFOpsAx7r50aU4dQ1qdluQBMyL9Og
         9aXJQ9TPzDIkskB1MRoOHO96rIiXyyFaAQA3Cl5niVBZVmkOtGzpon2RNxsmrFTm09bZ
         JlBDD4XgHBzuzIUDY1fzqXJ8sW3VIAGgbv1sjCxYHgSd/BlYZtsZpk9/jttVauxkhVvw
         RBJ8wnRlc2IZAV7hMdRpdltshndwpbrzhkWINR1D20mPRK7G/kua5VT8DuvlZDPi1Rzf
         CR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785459; x=1794390259;
        h=cc:to:message-id:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCaLjyOBd6911x6Yq+VkNvkgea81PfoqbKdxl69yD3U=;
        b=yi3IevsodF0NoV3GC7+DuA96ocI9PX53fs8Bl80XUyGtQ0xeyeHJh0/XMWKe20op2C
         dvKBeLdbl3UXLy5wZEArD6Lwn0ujgD+W0JcvDzEwNNROIMjSF3r28hR3+HHRGKYRvO/W
         y6Hp+Q5biQzqIQP4uj3mi5+kDGTAXfZ43PlP9vpFi4ZHOakV9x7nSVzEypNKYvukpsk2
         UQVAFuDNxEM/FJCdfopYHMjvOlJe4lYW3rNzfOdSWLAS7d2qTQOQSVz7SApLqNDXXuyE
         9/fCRGS9dhJCE3WZF72v1fmLqvjUoSh7VmeCijfLhSpggk5LrsI2dF+ALMPsQ7S0jg+3
         ZylQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9kj0v/FgtA4C5QQ3+82w2MWjVKTrmRPAmYtaqqlHIoiIGN/9wllCbMzzb2QF6uTQMkIXFR02wKYoFn5oelA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9WXEqkTXTkrvma+K5lAEDREkSHILQz2GxUh0Hcw5WPzsLz3/yD
	dcKk3MOc4H8HizzrtQNoNZyx3YCc4wAOXZu+kdwwisIosrzmLk3WuLhINsta9QFexR4702pq
X-Gm-Gg: AYBFou1kwlRyai1u0MBJON5sDyWlFdcJJJl3wEmUwMmUVA55Yy7fIgMJVLhwzYlhQxi
	UTsf5+jHqWq9Gz+3tgF3pLQO1j9ufgc03UfzjvdWP6bWnD7hdTSLfc1uzK9FqE61n6Otl9vX74T
	JNCjxo4KOWMmwgI/NxU49RkxynLBlX4yNItCrGi/oK2JW1QQfZb0FNI8YgGA0fGZgVN8ap7zBC/
	1uGmkNFBvO+FNR/CxznIaMp9/fMnb4+m0t8CWfwNURfzFpvUZ+MDW2qoMEC/N73AJ3gc4HRqovp
	P/LoEFRW4KElSBZbwyK4EO9/uBojquJ6I7fnBpdzRO9+A3RFN0JDbiPD/DP3vwUTauLJbsZ+rqk
	19P/QdgYe0sh7hs3y1IPNjLENKFrPvVt2fOqCzFuIpHM0EHBdG19i79za0cAfOh7W2zvqS8ZZP/
	43a0qz0dtLdoc/T1GhyM94PaIh8IauA3DAhu/dSYQy9S3IyuoFOMcLjbGqEweA5bb5YyZ4FLPhw
	fGusq/ioCBhtnzYJiUB4KKr7vgN5yMqbsj8k87q4Bw4vdetAPi/8PXIkQzq+m7InX6uqQthaiOh
	oCdQPdxB7aBDBpEXX8BDzc8yJw3VZpBs/3DKoA6Jjef75djDZkVfkN0NIjoVi5a0Za8=
X-Received: by 2002:a05:7300:cf8e:b0:36d:6a77:960a with SMTP id 5a478bee46e88-36d6a86f678mr179367eec.1.1793785459127;
        Wed, 04 Nov 2026 01:44:19 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm5545273eec.15.2026.11.04.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:44:18 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
Date: Wed, 04 Nov 2026 17:43:51 +0800
Subject: [PATCH] virtio_console: guard read-side virtqueue access during
 unplug
Message-ID: <179378543196.71890.7555371342727156729@gmail.com>
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

The virtio-console write path has an unplug fence, but the read path
can still access port->in_vq after device removal has destroyed its
virtqueues. port_has_data() and fill_readbuf() take inbuf_lock without
checking whether the owning port device has gone away.

Clear portdev while holding inbuf_lock during unplug, and check it
under that lock before reading from or re-adding a buffer to the
input virtqueue. Discard an input buffer instead of requeuing it if
the port was unplugged during a userspace copy.

A KASAN-enabled QEMU virtio-serial test reproduced the stale
virtqueue access when read raced with device unbind. The same
injection-assisted sequence did not report a use-after-free with
this change applied.

Fixes: 31610434bc352 ("Virtio console driver")
Assisted-by: ZCode:GLM-4
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
 drivers/char/virtio_console.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 019bcae81af5c..e97e0daa34395 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -541,10 +541,16 @@ static bool port_has_data(struct port *port)
 
 	ret = false;
 	spin_lock_irqsave(&port->inbuf_lock, flags);
+
+	/* Port is going away. The vqs are already gone. */
+	if (!port->portdev)
+		goto out_unlock;
+
 	port->inbuf = get_inbuf(port);
 	if (port->inbuf)
 		ret = true;
 
+out_unlock:
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
 	return ret;
 }
@@ -725,6 +731,16 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 		spin_lock_irqsave(&port->inbuf_lock, flags);
 		port->inbuf = NULL;
 
+		/*
+		 * The port may have been unplugged while we were copying
+		 * data out of the buffer: the vqs are then already gone.
+		 */
+		if (!port->portdev) {
+			spin_unlock_irqrestore(&port->inbuf_lock, flags);
+			free_buf(buf, true);
+			return out_count;
+		}
+
 		if (add_inbuf(port->in_vq, buf) < 0)
 			dev_warn(port->dev, "failed add_buf\n");
 
@@ -1568,6 +1584,18 @@ static void unplug_port(struct port *port)
 	 * a close on an open port later from sending a stale control
 	 * message.
 	 */
+	/*
+	 * Null out portdev under inbuf_lock as well, so the read path
+	 * (port_has_data(), fill_readbuf()) cannot race with the vq
+	 * teardown: it checks port->portdev inside the same lock and
+	 * bails out if NULL, preventing any virtqueue access to an
+	 * already torn-down virtqueue — mirroring the outvq_lock fence
+	 * below for the write path.
+	 */
+	spin_lock_irq(&port->inbuf_lock);
+	port->portdev = NULL;
+	spin_unlock_irq(&port->inbuf_lock);
+
 	spin_lock_irq(&port->outvq_lock);
 	port->portdev = NULL;
 	spin_unlock_irq(&port->outvq_lock);
-- 
2.34.1

