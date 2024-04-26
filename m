Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21A1482F5
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144133; cv=none; b=M5KjJaUF3uTOeV9vU3nkxmjl8XGue/dkP1V4ztaxkRdFGmw8VNn4MVEkdjQUbGi7u1a7AiaC9cSPuljcCJjXPkzvmMf2BFHY08JkWOAr620+DRMfbN/70n3+ShciEOHSQxzx6NpHUnroQb2Dnton5Wc9/vHO+/g9GEHgDR6ECsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144133; c=relaxed/simple;
	bh=ds2lT/PGNEw95k2LLV4Fz32hL3nhmLENtpvxxMkvbtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POCdEps4jJ9evLK4+r9KVjHz6Gqb5V9hLc1UyXeXXhlGdc9km1SeCbz7VwSf3V3a3f39AOhGhvWrG1DHd8rB3HBz9fzv1DuUheZWpx3owPOYanzpS2EhfvtsuIQ8vLkDoyHkmH8nCWtCKLKdmJ43yvUfRRJVjGGPiovFWbHl6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ebJHG/h5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ebJHG/h5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so17770425e9.1
        for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714144128; x=1714748928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tCCJLZp3I1TSGfvKd4jndrvV9LX9C6tnE0dEa2yccE=;
        b=ebJHG/h55l80INuItl69NYhmWs1S2vhaWTNrXJmf/5K4WIoyVfuGWqDfdfvLXH0wBd
         UHWdwgCpJgr3zc0QQ3DUMz1J8NU0I2zzcBAvzoGHas1A9d1LzNUKT+ezs2YzQD3nnNjT
         HsILxw9X0fqht5ZRr78IerdZhBCxa23cJD78A5jaRe4oHfhddHe94t6az263ZvVGIhrp
         GGQxekDkVNxcMcozwtDErhCo0AOWiv2lmZbT6NWOShbluxwWXv2CKe/p2kF6Vv5n5oKI
         ojIxsGoExrppLOJKyL9CXEV0Ax6qFEkbqdGSyxEyJRFD0Wc+awuog27iO4fZy3abcyLn
         uZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144128; x=1714748928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tCCJLZp3I1TSGfvKd4jndrvV9LX9C6tnE0dEa2yccE=;
        b=gN5ICiRN+x5adgNR+eNZheH3R46dVYHRedRUFt71nbg/RF1cPWLzzJl3E4ERJvcvYc
         E5ZHeiQRSJ3tMEiDjXSTOejDyN5SA6p4/bGQw3n9Vf1gkYsJWi4yIKST/vzZ7gcFUGwI
         +5idfQNF2nuj/jM2oe8NOiW5rK5EnOu5cdQCbAifC4Or1vpBS5DEIMat9dt37T5HqG+h
         MOpDaSVfAt8nzZUxX8zGXer5l37qiyJM/AAenmRrwvkjVdjrLEDwG6Rx6m3/2/DZhw3Z
         A9WZJejhlId0K+voJB9aaBIxao9/6ma9MJeLeu4/cfPyDWlyoV8hXoiv5eXj7QnS8WZw
         HrXg==
X-Gm-Message-State: AOJu0Yy8j38WuVWrXjyrS73SbTFipthI12oMFP4hFIwDOPmnT7HRhOlz
	Mq6WzqCZ9sNnf5dJN3uGBzSRDVUHzEIBFApt7rp++ueKTh4T2fhAFfv7uvCWMZxDnj90xCFFDe2
	i
X-Google-Smtp-Source: AGHT+IEqn5tBbLbmva6ofwML/0b0ztg6WpdjyMLiSd1myY5jIPVwixGmAhbmfygyRt1qo/BWCOwlOg==
X-Received: by 2002:a05:600c:444d:b0:41b:935:249c with SMTP id v13-20020a05600c444d00b0041b0935249cmr1811296wmn.28.1714144127662;
        Fri, 26 Apr 2024 08:08:47 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm35133358wmb.41.2024.04.26.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:08:47 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: [patch virtio] virtio: delete vq in vp_find_vqs_msix() when request_irq() fails
Date: Fri, 26 Apr 2024 17:08:45 +0200
Message-ID: <20240426150845.3999481-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

When request_irq() fails, error path calls vp_del_vqs(). There, as vq is
present in the list, free_irq() is called for the same vector. That
causes following splat:

[    0.414355] Trying to free already-free IRQ 27
[    0.414403] WARNING: CPU: 1 PID: 1 at kernel/irq/manage.c:1899 free_irq+0x1a1/0x2d0
[    0.414510] Modules linked in:
[    0.414540] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4+ #27
[    0.414540] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
[    0.414540] RIP: 0010:free_irq+0x1a1/0x2d0
[    0.414540] Code: 1e 00 48 83 c4 08 48 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 8b 74 24 04 48 c7 c7 98 80 6c b1 e8 00 c9 f7 ff 90 <0f> 0b 90 90 48 89 ee 4c 89 ef e8 e0 20 b8 00 49 8b 47 40 48 8b 40
[    0.414540] RSP: 0000:ffffb71480013ae0 EFLAGS: 00010086
[    0.414540] RAX: 0000000000000000 RBX: ffffa099c2722000 RCX: 0000000000000000
[    0.414540] RDX: 0000000000000000 RSI: ffffb71480013998 RDI: 0000000000000001
[    0.414540] RBP: 0000000000000246 R08: 00000000ffffdfff R09: 0000000000000001
[    0.414540] R10: 00000000ffffdfff R11: ffffffffb18729c0 R12: ffffa099c1c91760
[    0.414540] R13: ffffa099c1c916a4 R14: ffffa099c1d2f200 R15: ffffa099c1c91600
[    0.414540] FS:  0000000000000000(0000) GS:ffffa099fec40000(0000) knlGS:0000000000000000
[    0.414540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.414540] CR2: 0000000000000000 CR3: 0000000008e3e001 CR4: 0000000000370ef0
[    0.414540] Call Trace:
[    0.414540]  <TASK>
[    0.414540]  ? __warn+0x80/0x120
[    0.414540]  ? free_irq+0x1a1/0x2d0
[    0.414540]  ? report_bug+0x164/0x190
[    0.414540]  ? handle_bug+0x3b/0x70
[    0.414540]  ? exc_invalid_op+0x17/0x70
[    0.414540]  ? asm_exc_invalid_op+0x1a/0x20
[    0.414540]  ? free_irq+0x1a1/0x2d0
[    0.414540]  vp_del_vqs+0xc1/0x220
[    0.414540]  vp_find_vqs_msix+0x305/0x470
[    0.414540]  vp_find_vqs+0x3e/0x1a0
[    0.414540]  vp_modern_find_vqs+0x1b/0x70
[    0.414540]  init_vqs+0x387/0x600
[    0.414540]  virtnet_probe+0x50a/0xc80
[    0.414540]  virtio_dev_probe+0x1e0/0x2b0
[    0.414540]  really_probe+0xc0/0x2c0
[    0.414540]  ? __pfx___driver_attach+0x10/0x10
[    0.414540]  __driver_probe_device+0x73/0x120
[    0.414540]  driver_probe_device+0x1f/0xe0
[    0.414540]  __driver_attach+0x88/0x180
[    0.414540]  bus_for_each_dev+0x85/0xd0
[    0.414540]  bus_add_driver+0xec/0x1f0
[    0.414540]  driver_register+0x59/0x100
[    0.414540]  ? __pfx_virtio_net_driver_init+0x10/0x10
[    0.414540]  virtio_net_driver_init+0x90/0xb0
[    0.414540]  do_one_initcall+0x58/0x230
[    0.414540]  kernel_init_freeable+0x1a3/0x2d0
[    0.414540]  ? __pfx_kernel_init+0x10/0x10
[    0.414540]  kernel_init+0x1a/0x1c0
[    0.414540]  ret_from_fork+0x31/0x50
[    0.414540]  ? __pfx_kernel_init+0x10/0x10
[    0.414540]  ret_from_fork_asm+0x1a/0x30
[    0.414540]  </TASK>

Fix this by calling deleting the current vq when request_irq() fails.

Fixes: 0b0f9dc52ed0 ("Revert "virtio_pci: use shared interrupts for virtqueues"")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..584af7816532 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -348,8 +348,10 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 				  vring_interrupt, 0,
 				  vp_dev->msix_names[msix_vec],
 				  vqs[i]);
-		if (err)
+		if (err) {
+			vp_del_vq(vqs[i]);
 			goto error_find;
+		}
 	}
 	return 0;
 
-- 
2.44.0

