Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244760;
	b=nrcZ04f6pop6Y0NCLz9yCcbviMmOE0tIwRYKGrlqeZFM7KtIVzNvskOpNi5TepELbf6Z
	 PcBdBRw+fyAhypEqsayZzmx8DdpX57HCstCjIImI5n0iX4XH8Xv3AseQlLhAmkehI7My3
	 0E9IrNMU/pSGT3c3eylIZPl86rZHU5Cwp7VI3KEpAwpQPgM3Em/DeK8zkHfiblXYcMVet
	 3XmSBr9SX/+cHkYXlFZXgKb4mzYEJfG56B6hMN9gqT3jEaf8+IyKH/MMgwT0isVdktn1R
	 wnHFMdnHcPJgKtAvr0GPtgRzbI+mxO/l8vdjsNWdq8VQPHn2bFJFRvoQXGuZ8DHG7fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244760;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=Lz/3gg9sMfuwVp5WFfXRkG4Oe9U7sz3MgZkoMCHGtU8=;
	b=gN09qj/I+A6bfIA71EW5wYXpMgcye8Ef4eRTM1bHD0mA3Wy/RwdOxiQGUHMZrZS7erBv
	 r1HDrVJWatmXuW4I1P3UKly41S5p8NZMQvPsKg7b4zpl8LH7mec/SRCl73aJlqs4jKkcA
	 yl0Y1k2WXUTsXRFxttZnUi0jYcqBswaXePjvJkubAa26l6tlHyvM4TeND5lbjxNNabYhK
	 K1dcejx5YVyAcO0rkbOXP4cNnu9c8dhtNZRVhJ6VhmFmYoJbC9bsICqGoJIGgcre8ruUS
	 S4AXYlEGUSmt9YK7feUqjHQ6vKSJi36Mzn1HEneQocxkC3YQBZqYp9K7ccDS7NK3zAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cNCpukSs;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B81606A31C;
	Mon,  9 Nov 2026 17:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cNCpukSs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=Lz/3gg9sMfuwVp5WFfXRkG4Oe9U7sz3MgZkoMCHGtU8=; b=cNCpukSsdaBElywJ/qDmeHtEL8
	mGgRWVhVgsM6jxj3gRfpV2amwhCdYwtMoOzTUHhqSzL6oaruqQTsl6/XPVcTX29GiQuVDrju8oVKs
	wVQTmhbf6JnxqlRmwggmw/0zbykCx2ke7mydjEtY46pGCiL1opd1ctYZ3CYgpXAQj/X3buWv/VCBC
	qobRtTubUF6s3wQExm2PXFZq7uL3W/fn3aUGfWLatpQ3okqSAzdhRZVr9B5Wm/juvFsHPr/YlhyoA
	YK7zVyr/3DmffGXsvhB43v0yYONaRsVCXW2FJWEfIwOVtY7bCkchC7BYlB5ZJJm4LqClOYCvYqt96
	THKAzaYA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQT1V-00BmUW-2A;
	Mon, 09 Nov 2026 17:19:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Nov 2026 09:18:23 -0800
Subject: [PATCH net] virtio_net: skip Rx refill when polled by netpoll
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-virtio-net-netpoll-pp-v1-1-3f004b406d71@debian.org>
X-B4-Tracking: v=1; b=H4sIAF4A8moC/x2MQQqAMAwEv1JyNpAWUfQr4kFs1IC0JRURxL9bP
 cxhYHZvyKzCGXpzg/IpWWIoYisD8zaFlVF8cXDkGmupw1P0kIiBj48U9x1TQtvSQn6ufcMEZZu
 UF7n+3wFKB+PzvKHEYPRsAAAA
X-Change-ID: 20261109-virtio-net-netpoll-pp-170f0dc4d6e0
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2381; i=leitao@debian.org;
 h=from:subject:message-id; bh=7mfYh+ms93celyal6ko3GrStt9luljGSKquriidqZHE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8gCOQhcZ5Z3qE8uz9/ZeNGPxl/R12/SH4bao5
 BKEwsCYpkmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavIAjgAKCRA1o5Of/Hh3
 bd1wD/90n8dQjKW23s+toDTMTWIaZufcEdIVxJuluH+Pbq404MHnR336ofYw3uujtrn6wSMabH7
 lUAOuelx48knMH5qDvXuWfNrddEYIYf/aFbl2wwep22ODIK/KKoPCyqj9iZ9GqrjZDX7lL1vJqS
 M+mUIA1UR02on4mqZdsLdiL4jp32JKgbsqGd+hYv1eKSfT3+7Pf1l3IAtleTAgJuUS4HdNwMjxO
 eHzM/9XeyJrhCeEJw7Y4RSVcqJG7zUo0b5LmyGrxiCzMDKgMnDE8bXIVX4tNJOLs1bGQaxMfVVr
 MFHpWfVweG6JKDEOp+XQ4dws59dCeCuvIsVMNgKkdXpW8IHbXcPJz78oTalUDDsuLuttVLeI6Ic
 5t10gnaYurZpDEP+YPGkx1wJ/bbMSo3H18QXdQFmk8yZ2XhOGLd0NOXEclYqzRNhIbYeeX4R+eQ
 1xY5z6t07JlQobHNzvSpk9tr5p1NMRiTsqCvwxxn5BqQkX5bAGLfAKA9jeRSliekvrZxBGdzCGU
 YUi5WNDZD1wMyMyFjRL+/Z9zjxsGkT8pO0xDDx/RvyoAMWxqSMLHTWLjjMA66zKWXXz+fAK/Bme
 qjAX12Ui+/rz5XlsVrvyUilmeqlQvBf/RkpuuPLZrX+00F8iQ8FQxeKXeYUA61pY4LqNG/eId/i
 rDoCkiSEHb150Ng==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

We are seeing pp_ref_count underflow warnings on virtio_net hosts with
heavy netconsole traffic, followed by general protection faults in
napi_consume_skb() on frag addresses made of packet data, when
skb_defer_free_flush() frees the corrupted skbs:

  WARNING: ./include/net/page_pool/helpers.h:297 at page_pool_alloc_frag_netmem+0x1d9/0x230, CPU#540: swapper/540/0
  Call Trace:
   <IRQ>
   try_fill_recv+0x399/0x940
   virtnet_poll+0x538/0xc10
   net_rx_action+0x21d/0x610
   irq_exit_rcu+0xf9/0x3a0
   common_interrupt+0x85/0x90
   </IRQ>

The theory is that virtnet_poll() refills the Rx ring when netpoll
calls it. netpoll polls NAPI with a zero budget to reclaim Tx buffers,
on whatever CPU is transmitting, but virtnet_receive() still refills
it.

Since commit 24fbd3967f3f ("virtio_net: add page_pool support for buffer
allocation") that refill allocates from the page pool, which must not be
used with a zero budget (see Documentation/networking/napi.rst).

A reproducer on the net tree supports the theory: an 8-CPU arm64 VM with
QEMU user networking, a netconsole target on the virtio_net device and
three TCP receivers on other CPUs checking a known byte pattern. A
printk flood through netconsole corrupted all three streams within about
three minutes, after which recvmsg() failed with -EFAULT and the same
warning fired. A test kthread calling netpoll_poll_dev() in a loop, as
__netpoll_send_skb() does while the Tx queue is busy, corrupts the
streams within seconds.

Only reclaim Tx when the budget is zero

Fixes: 24fbd3967f3f ("virtio_net: add page_pool support for buffer allocation")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe72..9db5ec875c141f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3037,6 +3037,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 	virtnet_poll_cleantx(rq, budget);
 
+	if (unlikely(!budget))
+		return 0;
+
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 	rq->packets_in_napi += received;
 

---
base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
change-id: 20261109-virtio-net-netpoll-pp-170f0dc4d6e0

Best regards,
--  
Breno Leitao <leitao@debian.org>

