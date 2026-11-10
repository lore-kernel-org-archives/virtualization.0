Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794330680;
	b=Ylij6QCLnPhGxe5UTm/jox+ICBfaj1A2xAjXYI1dyWCnUecwBJA1OafnUvfM8S9yuiBv
	 GIRwdrKhTWJiLLvE7OzNAb86HDrjI1TJSN1p5vWOA3VlIEDM5DTut4ecIqBzcVLx+OmR8
	 B77MpZaF/pd1XGmO17zzgHOXpvVEVoTPwl3b9Q4mp/0CmErCOzHcNAr6e299mxnw4R5HT
	 m8VCjagI8ZAe8VWIgHkX24vk2kwsmc35QB9Te5QRJtgc6IhBUntIsBDDBRP3Ay6klh9Tg
	 uWIYKknZ8bmUm2ZrLV6Ft9981q3xA2QsUBTTq00tbTUm9pL+FU2pSY0kYyBd+hsTLyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330680;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JD64Ud7a3qHc7EvaTpRIa2pxyb3pp+K7JU5At4Osxfo=;
	b=eqeW6oPTHeFUZhDSGgQP6FIGcVUf2tYWSmS2HE2NDmgi17J80xIvtKyLgsuQ6Bgv4d1G
	 L1zlqbog5NiuuAW6yesc84B2jUWexLMw0q3UFL4DRmsGfWLdW2iGMy2p0+UZEqpBmdELn
	 4pEJsa1civgNIOElZf9a0tO0jxjRg2o+puHxq/kfyIhNh43+4SfdXQXonSxhHDfvpbfPL
	 b8fufG7dg4jJRfV0a1aQqvSiEBXDHmbjwOW5qiGIUEliB9CJOQKLFlyhUKeUSn5Iek+L4
	 AAUdJQB9OVNqCIn7N3IsbbMOkKReJhTR21qpMjyBeWvO5J+QKZZs6VfdTdTBLj1wnKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxrKUzU8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36C606A31C;
	Tue, 10 Nov 2026 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxrKUzU8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794330679;
	b=tJiS2txvWvl9sTQjmHlzlcavYhgvA+FQVwxmmGWBUelkEhb0wLfWePRYIZ7RnB0zPM9r
	 YyRzK9mx5e1KqJHIgOY1uR+RJTrKWryzAyaOl4E86q2E+SW42lpLbllQz4Hm4Egs5IGb4
	 w9hbLSsLVSmzKmoM52Nj5EH5FEu57WDL+DF09IIJfpIoB0wAzRxQsKBgbYSCi0bH73RdP
	 3KjBgY71J/zmgMxgP/3ZdJ9NzhMaIEHbDTEfBU7GZ+fBC4fvmY0whP+T/xJa9XeUc0keD
	 eYEBDiZV7TjDXo1+IgBskXbGTPNosqH6VHxZVLKzo4MLdT5a5Tj6alq1+67G39oGz+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794330679;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JD64Ud7a3qHc7EvaTpRIa2pxyb3pp+K7JU5At4Osxfo=;
	b=jn0Xk2sKpv8tn2aFXR0vZihllQkx3bt3G2DIRqhWUp9VBrjy3sCzIYZZh7ZnW+HRQPBH
	 BnaYJSJyYN52Ec9505OSVkk1Ga4Z4+oZws1Jt4dJC4AMjozNnDc1eA1GncsjX5WZnI3hk
	 oKB/NRFeFivP4zRxInytW9n2CocMU8gEL/TG0WouuZ8RLGYUgyQX/hYqBXhXPWSwi2hqZ
	 VzlzmAOqNlDeI1ykyy0kLYABahrnAmT7c7OcSAEzQDNpyufTyLUNopF06IFOhgmKqreuG
	 ICM4gMB7T9tAeHek34iCNUs0DhYgmwddmGJglH+sGJsLl40HId0kVcd4yHUeRQBXFPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ECDEA1F0089F;
	Tue, 10 Nov 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330679;
	bh=JD64Ud7a3qHc7EvaTpRIa2pxyb3pp+K7JU5At4Osxfo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FxrKUzU8vVuhy7ylN5Kl1tZZcNS/y0NEl11bn60auuRfyMYft+r60Gx2Esl93UdEa
	 u7wGTtCdTBAHZM1BVkNN7tlyqFwSVstTd6CfXkPA177QZ5NZsq4fudV2QMrBpPMQ8J
	 1lSDLFrAluayNWEqGZSOYLyaJArChPXz/5OvioGz3pmaT9glnunwXq54kmd0gVFF0e
	 m/baqQEpClM0jsZ/a6+RYRswm2LhbalMRVv+5j8piSmGScczMkLWs58IgNLO9SebB1
	 nPZ7KxyUNs9BL0XI0rJwRXoVVx+QeiXhtdcs6ATBUEFN369dE1728JwsE/6/3AjVjt
	 A+hm+ixoRrsxQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7D6DE48C22;
	Tue, 10 Nov 2026 17:11:18 +0000 (UTC)
From: Seonghyeon Lim via B4 Relay <devnull+forfortuna.naver.com@kernel.org>
Date: Wed, 11 Nov 2026 02:11:13 +0900
Subject: [PATCH] can: virtio: fix virtqueue use before DRIVER_OK
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
Message-Id: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>
X-B4-Tracking: v=1; b=H4sIADBQ82oC/yXMQQ5AMBCF4avIrE1SgjSuIhZVU8aiZIoQcXfF2
 32L918QSJgC1MkFQjsHnn1EliZgR+MHQu6jIVd5lcXhzrLyjNZ4FDL9ibq05JxTldEFxNsi5Pj
 4kk37O2zdRHZ9O3DfD8XMF5F0AAAA
X-Change-ID: 20261111-virtio-can-ready-85cefff06a84
To: Harald Mommer <harald.mommer@oss.qualcomm.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
 Seonghyeon Lim <forfortuna@naver.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794330677; l=1943;
 i=forfortuna@naver.com; s=20261110; h=from:subject:message-id;
 bh=MJAobe4rPXYioFnUfp9+XUMNTxBij8wL6gfGu1JqKaQ=;
 b=E1tjMRm3+lNVL2OwfvqZKG7Q0qtbt8SWyZ1IIFGIkPNrZN1rDFwRWWcxA8zCPaJbUwq2c0pta
 au/rzScbiSpAZ3U57rYO8ZM0v+Qsd863Ysb4r0+HahDb4KjqAiFl424
X-Developer-Key: i=forfortuna@naver.com; a=ed25519;
 pk=NSzj4ReyzmE01C4q/f+7jqXzWqsN5NwQK5UsSI6ufiE=
X-Endpoint-Received: by B4 Relay for forfortuna@naver.com/20261110 with
 auth_id=1481
X-Original-From: Seonghyeon Lim <forfortuna@naver.com>
Reply-To: forfortuna@naver.com
Content-Transfer-Encoding: 7bit

From: Seonghyeon Lim <forfortuna@naver.com>

virtio_can_probe() and virtio_can_restore() fill the RX virtqueue and
kick it before the device is set DRIVER_OK. The virtio specification
does not allow the driver to notify the device before DRIVER_OK.

In restore, if the interface was up, virtio_can_open() then sends a
START control message and waits for the reply. DRIVER_OK is only set
by the virtio core after restore returns, so the device may never
handle the request and the wait never completes, which hangs system
resume. In probe, an ndo_open() right after register_candev() can
likewise send the START message before DRIVER_OK.

Call virtio_device_ready() before the first virtqueue use in both
probe and restore, as virtio-net does.

Fixes: 083082a4e6d8 ("can: virtio: Add virtio CAN driver")
Signed-off-by: Seonghyeon Lim <forfortuna@naver.com>
---
Tested with QEMU 8.2 + vhost-device-can: with the CAN interface up,
suspend/resume (pm_test=devices) hangs without this patch and
completes with it. No new lockdep warnings.
---
 drivers/net/can/virtio_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
index f67d0bf09681..ae35a00b784b 100644
--- a/drivers/net/can/virtio_can.c
+++ b/drivers/net/can/virtio_can.c
@@ -912,6 +912,9 @@ static int virtio_can_probe(struct virtio_device *vdev)
 		err = -ENOMEM;
 		goto on_failure;
 	}
+
+	virtio_device_ready(vdev);
+
 	virtio_can_populate_rx_vq(vdev);
 
 	err = register_virtio_can_dev(dev);
@@ -966,6 +969,9 @@ static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
 		virtio_can_del_vq(vdev);
 		return -ENOMEM;
 	}
+
+	virtio_device_ready(vdev);
+
 	virtio_can_populate_rx_vq(vdev);
 
 	if (netif_running(ndev)) {

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261111-virtio-can-ready-85cefff06a84

Best regards,
--  
Seonghyeon Lim <forfortuna@naver.com>


