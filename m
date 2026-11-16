Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821095;
	b=D71D9YVXipRyqOKa5kw1YDCoRsNI9kaw9o5om33UYpEeBxeGl44unZOPZ30/SI0QntH6
	 BiDSOu8IjITZFiuSNGISIIapMEmLxgE5hbTRgyq1+fcBoiW4K7kSE90JD55fvN/cxSM7H
	 Fr3DNyix/gtzgY8F5SeubOHvQ1xs1n6/7zR1duayuBdGiHDvOTNc523+okLaotHypc/Ac
	 GRD8oZqn/j85U0UDzZiJsvNsdgaWK9U6hnZp+IvOQYLbBoLJv0tefSYxPZbQo+Y6C7jLb
	 iJaC52Aye2zdEDt5q87B0Q0hAAdB4EzAJ7ONTdF79Xa8oadXxiNjWPUw+hH2OMU9PlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PsdqLnUGdpIVrBYmye0zPsfH3hdWVwuux/Bo2cpeGrA=;
	b=4SECYRcvLKLT6VQ+pBclw/2792tu3qaOWjnCmh6WYKV3EkPoN8lx/WvAY3YccJRaHw5G
	 siJ0ep/+5P4IWAu5pxY8yLoAL1KKXj5GfXxSUBm4X6dpzwOUh9fif4FQoAIeVwSg3/MC0
	 KG4BcxCUcT/eucaDZAkRHGPtoquZvEDFFXMBVkKTlhQqenN4dGeNEi1p4U7Q1yWFyeH7i
	 0Or4Ob/uPnpCCQA2c02cC3PJs6oxgK84elVWd596xOYuOQSpVYoajaLGExYCc7rvtqNTy
	 yaZeX3KmAqEJku+Rr5rP4cCeoZ5GiXXm1SBP3OZBJgWMTok9MxqIwSMj593h/gE82tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=0mFrnWb6;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C5606A33F
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 647C5606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=0mFrnWb6
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so9223022eec.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 01:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794821094; x=1795425894; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PsdqLnUGdpIVrBYmye0zPsfH3hdWVwuux/Bo2cpeGrA=;
        b=0mFrnWb6df+QbHEEERm0wC0QMq3HDSoJyD3JsQa8u5o2UMtyEUh/ORbLDODAoFOx+F
         iTeD4WarGKP021UUp4nZmhCaqppzQha5odcpzAA5mUgRn6cdCTJmA2uC6j3qriJWb7KN
         DINQYv6f2mxAvmVv+gbY1SVl8yGiw8R6+Y5JAqKQzNVeGZ3ltSUAoWp81onDmuVLYS9F
         9dNpQ6cT7blxY19aTAEjpUE5GA+Ox/AekuBSZPYepWHYfptv2fqmh6r8MX/SzN5vgZdM
         wPcw1veG305LLxjBOXyB8PyAHGPL7UcVxj5rLTf9aexS+w6blz2wQjzrjcEAFiME4BEE
         PFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821094; x=1795425894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PsdqLnUGdpIVrBYmye0zPsfH3hdWVwuux/Bo2cpeGrA=;
        b=nx+iOgKQzWk3Liqryk7oRNaXeniFnD5m2eqR5PAwrcu9E2UIiUBsLv84+rtmCmnqW0
         hoUmg1BQT1xenXr468zkXXdUJlYaW2nO8RzPzq0+9I4K7X0Adun9APzGwewG8dtyqrmC
         GiT2nTf3Vrhk4sAG44oJHEurCH2/5Ptmv0s9z29EiSlIde8s4hA+wYAmdhzzrBZnNcw7
         69cO05SrNADfajx3NSAjGmjkai1/5QQLLQ1u7FIZefCfJPRYEqjf1/dSVff9xKXWofvu
         tmZyeuqN9F7e4hB0iCgT0vXMIllIqm5gtNQXzyEa7CljV7fw0JMtc1Puz0+5Hg9N1oqO
         FGRg==
X-Forwarded-Encrypted: i=1; AL+hErEG3Lp6EXeQpbcW4PiQCFAZGm7BfWOS9MSDDNB9r2E5rSPF6huTKqCU6O7iNcagWzcmwKMVadkz1eZmZGcuSg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Rm8KOLcf8rOSctmxYzNBdnaslcCWT7qmFKcuZBXTt4PLG7Y/e
	DeZxTybSN/m3B6RiVKH/yTJmk2zvo7Khxz6AizB4z7BU7yCtbEcNnUNrFZOb7b4bEA==
X-Gm-Gg: AZFdTZeOdpuTOM7PjhmapEKFOTIq8vE6Rud0nkHI97eUZLmSI+iTTXUlI6wCmpYjNsF
	jd5AP6FhUwVi8D3WmsPBXuVU8+wyOY8roH8f0b7uC+78tbOlQ+6XsHhuOpUqRwlsQsPZjq95GLy
	Zgo4o3hxk40IwrXPXnD0pQwIRIaAyO14EI2eiBgshcUz9SbDN01LfFL36i8YmLHbra6VeZ1HVce
	EquQNvsVMEpbRyMRZuC/hfiw6R4s7/X20dPgB1QAmMsU515BIxyrkMDEhDfTgRbR0xa3jbOWeoC
	li09fRx0FuA/OQNgYFw0mqrmRZwQhDww6MEFYdntZNp0Jp3ts7QTLsdKLeapCXPEaetOOHL+P4z
	JXqxmdBfUZjZvycHDmk02Oy7wYDTt0EP82qWIdXbTZImggyq4lGWyjFj3I9ugVRo5Dy87n0EOoS
	SW7gUkdWDWXjlmO7L3W+1pNxsZV169jFo8D/Afn0cjGfcnfSzskG5pEDlktC3fcfdXWzi4DxmqW
	AzkTXJWK1y20eYRLfs9CxwiSUGKM9Y60RGKEH3GBiG1+kbekYh7JuD/9TgM02UYO4QHLYWUXenq
	654n5MN3S31EmjcFG4lYiRsZFNVkM4PrfY6+uQ==
X-Received: by 2002:a05:7301:4889:b0:36c:3b8a:8089 with SMTP id 5a478bee46e88-37967ddd89cmr10058508eec.36.1794821094425;
        Mon, 16 Nov 2026 01:24:54 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32056314eec.26.2026.11.16.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:24:54 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/4] virtio_net: zero the stats reply buffer
Date: Mon, 16 Nov 2026 18:24:43 +0900
Message-ID: <20261116092445.3391334-3-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
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

virtnet_get_hw_stats() allocates the reply buffer of the device
statistics command with kmalloc(), and __virtnet_get_hw_stats() parses
the whole buffer. When the device writes less than the buffer holds,
stale heap bytes are reported as counters through ethtool -S and the
per-queue netlink statistics.

Allocate the buffer with kzalloc(), so that the counters the device
didn't write are zeroed. An unwritten record header then has size 0, so
reject it when walking on that header to avoid an infinite loop.

The used length cannot replace the zeroing here, since the device can
also report a larger value than it wrote.

Claude Opus 5.5 was used to audit the driver and draft this patch. To
reproduce, the virtio-net device in QEMU was modified to offer device
statistics and to leave the counters of a receive record unwritten. On
an unmodified kernel, ethtool -S reported kernel pointers as rx0
counters. With this patch, the counters are zeroed, and a reply with
missing records or a record of size 0 is rejected. The
drivers/net/stats.py selftest passes when the device answers with
well-formed records.

Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/all/20260711150754.2918392-1-michael.bommarito@gmail.com/
Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.org/
Fixes: 941168f8b40e ("virtio_net: support device stats")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v3:
- New patch.

 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 57d7a98ecb57..498014773242 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4994,6 +4994,9 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
+		if (!hdr->size)
+			return -EINVAL;
+
 		qid = le16_to_cpu(hdr->vq_index);
 		/* The vqs of the queue pairs beyond curr_queue_pairs lie
 		 * between last_vq and the control vq.
@@ -5068,7 +5071,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (!req)
 		return -ENOMEM;
 
-	reply = kmalloc(res_size, GFP_KERNEL);
+	reply = kzalloc(res_size, GFP_KERNEL);
 	if (!reply) {
 		kfree(req);
 		return -ENOMEM;
-- 
2.56.1

