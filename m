Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798128;
	b=sGIXcfca6XTJiKEgGXS2l/jf+1oFxYgF5iO96T9jUTh5T5a81c4vkbhfPDs0lM5VEe0/
	 vSzs6bj8kIRB41vKdYkWdsVav81C2WSp3tpv7X/6CBlFxrwWfj1UV5g5gal1Y+9ZP9SlI
	 2lH8Oj/EdutCTWY8SzhE70tINKY7Gr7iqFQCx5Dfz9b73djOgjVJcJdvBgrbk7wtWwOPc
	 L4boM26C3EW7TvpIfx0OIlCiaWhML5gOXrUaxctsvgtvHVEJ2e4H8NhnGQlBh+fSfTiLh
	 cONX8lVKtOZpoQsu4nyazYKrNbn05qySXjoI5+uZAw70XstTicje4KxmpqK9pPOsEiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VMrRqMHzjHqGYxf2SI/6lKJFf2peQ7pwuCUbgZFOrI8=;
	b=yNjhVPAlzj7ak6gd9i+t7GUrDIXVi0gb7+wlrGcIHCy3vllGhZ7HcGicm5nOpCThB5bz
	 7gADDcUwvuCJwSh5dZout9nA/zmuFF4/kQfjIN0cH28FJIUIdNlloC6dO7gWibcyzzZAn
	 I3acUjrK2Zm9+vtbASZjuskWGZvqo0YiqoVDglW6pQB9cddkWy1H6BPjSlGPcSuu84yz3
	 IkmH58bKWnQS+t/vXK9c938BVbQhWbi10/Aqdivt7lB6ttWlh6QwKKUTIwzYxbhIl4/Kp
	 nnhqQhTAStJiDSiJHuqdbBJNGvyZr97xmcFC2Ueh8lSOBhK6sp2AY9zHOyUTwi5pGiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEsGxmLc;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA412606A88A
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 03:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA412606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEsGxmLc
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93a40a9a01aso611575785a.0
        for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 19:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794798119; x=1795402919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VMrRqMHzjHqGYxf2SI/6lKJFf2peQ7pwuCUbgZFOrI8=;
        b=qEsGxmLc0bEO29Op58ZHiknLgM0CNGJFlxptl0OtnUbNDzZDso4m/jQdHdaG+c9WKd
         RBAJ7ylRHYsmNdrKosCzWJYt3a8D23kt2bEMseZQpf1BO9eSR1oOQuulQpYQlC5+GxEl
         G80suZpMqN/hSKvSMN0e/BTZyfP2e4OmoepKSdzJytLU9zNoM0KagjUfRAEdBpwnKfZa
         YAQKCN5ORvC12g1rI8HvEcahKlRkt+zfsyFXCpjaj6sOLbBzb6ptfIVndjuytg9yLH7I
         EBVreDG/Ny+AoIa/CpyAlsItMxZl6LFJMuSiNu0c4FtJicvB3VJjCx3T5WIfw+hgFPIJ
         kvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794798119; x=1795402919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VMrRqMHzjHqGYxf2SI/6lKJFf2peQ7pwuCUbgZFOrI8=;
        b=O13W41qi2qdQuTsHgD54nkhFSwq1jHxMrwmMmY2QU4Fs9qDnflWBCi+xNstBHQY6by
         RoX6OCQzTGXrdn4hL4Sw4hr968uebz8gHVSRuDdG8TBrvnE27CFOjNS5fJZb8aOHPZNU
         HfAADutxr/loRbgfMqlIh+4duvZRRA3JTRyQHGTsYsaiS6rPGHJMjLeVjeim5uhP0KGk
         /crhkY8s7VjHh6X/uskjN3lWJazwyGK+e4MJViTwfw6UFp+wday/60uW7x+4rby4Hub2
         iREhWUTuvggtTeMEKB7I6cbG1Yw4VHTk44jnkO8SiegJcVZ8gzUv/x4rNCbMkI0LFeVc
         TiPg==
X-Forwarded-Encrypted: i=1; AL+hErEk+eod0xfnT/sdL93PfzmBjAilultxLrUCjKTYa8Fu1XfgszeSgnjt4rfqc8/YtbW6w4o68vpFBxqUFLkETw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/fr9L8OasIwaRryBUccPnvFdtH7OYzlThl7e8WERyvrWVdsGSf
	kI45H+pkCWPBFwNPjH/Ta6NLvHwCQxjz7MMvgMugI4rhGCPNaZBDgXJK
X-Gm-Gg: AYBFou2t6xaNt6ASrZZceezR3VnT79k5nrEJQiBXWRMLzEXQLK8FUMJuESx1g1FBIXV
	ao3jKmJC1gwAsjz/mKjaghF1cOh96+LC/I7ADk0Ue17dJtjFR571QxYDwmmTRGR2y3jU7UVRxg7
	vO4zVkfhZjcTsb6H1V0i5onx2VREhYzfUrfJqd8aNtscMgz0UFAgYJeuGb1K0lVExmdTd8uWt6u
	y0ZIWlT3XK8A9PTDrFEGKHU5KpYj1WI6Xp6ziqlVXzbaa+C7Lu0m+8KQF7wnE/S7eXPwtpYznk9
	r5vwR8rEnr89wlpYVte+tj8yRgvJtgcscudZ9g9w/2KUmSvrxjfb4+RWaf4f5Rgb52B1orfhRas
	YDic4YBQQfHCUq7FboVhK2puj4DZsuxm+qLD5yGCD5i/rvU7uFihK7HqfWZgx3/3zuBX/8iRC0a
	bbYnsRO/ByZNxou9AAXv8ne11vMc7eSidj2LRKYwb8G2eAkqTlCEarou8Jo0/IBAXceWCiJIZ5N
	L60iHH/O4gmjDcUavMa+8rmbI4xOlCFqJf/etaf9qpKYtjoH+7n06HqoWnSpb6zLQ4kPqcEOc25
	4uofx/jXtBlT+L/daEzlAIfUV6LYG19e2oI9HbXlpz8UjQGsU74H
X-Received: by 2002:a05:620a:6019:b0:93e:95ce:5394 with SMTP id af79cd13be357-9494b9b63acmr1378102485a.2.1794798118524;
        Sun, 15 Nov 2026 19:01:58 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c831b7dsm746297085a.20.2026.11.15.19.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:01:58 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] vdpa/vp_vdpa: Wait for device reset to complete
Date: Sun, 15 Nov 2026 22:01:44 -0500
Message-ID: <20261116030152.1704527-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vp_vdpa_reset() writes 0 to device_status and returns success right
away. The virtio specification requires the driver to wait until a read
of device_status returns 0 before reinitializing the device, and
virtio_pci_modern's vp_reset() does exactly that: the read-back flushes
the posted status write and any in-flight device writes, including
MSI-X messages.

Without it, vhost-vdpa (or virtio-vdpa) can go on to tear down the
IOTLB/IOMMU mappings or reprogram the queues while the device has not
yet finished its reset, and may still be DMAing to the old virtqueue
addresses. The MSI-X vectors are also freed while an interrupt from
the old configuration may still be in flight.

Poll device_status after writing 0, in the same way as vp_reset(),
before freeing the IRQs and returning.

Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Drop Cc: stable, as this has not been reproduced.
- Rebased on current mainline. No code change.

v1: https://lore.kernel.org/r/20260926211507.1330179-1-oss.patchbox@gmail.com

Like vp_reset(), the new loop has no bound, so a surprise-removed
device that reads back all ones would keep it spinning (the Sashiko
review of v1 pointed this out). I kept it the same as vp_reset()
rather than handling that case only here.

Compile-tested only (x86_64 defconfig + VP_VDPA, W=1).

 drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 646efd9384fb..eba82ff253ea 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -8,6 +8,7 @@
  * Based on virtio_pci_modern.c.
  */
 
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -236,6 +237,9 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
 	u8 s = vp_vdpa_get_status(vdpa);
 
 	vp_modern_set_status(mdev, 0);
+	/* Wait for the reset to complete */
+	while (vp_modern_get_status(mdev))
+		fsleep(1000);
 
 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
 		vp_vdpa_free_irq(vp_vdpa);

base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.43.0

