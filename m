Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94738E8C6
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348407; cv=none; b=t1OW4i8+brpw8EdVDzYcXYhSvKkd3bf75ZzzBx5+irP6A5tyjSIfPAIKYdw3h4K/kTfXsJtQ6qGmgaw15CsarMGOQz9upNeDkBXR6f/PBlXySDylGmB0Dw9dWnEMTQ87N3ngG0Bco0soMsupF1Y8GoTVcCSLRq8xbzW+uCP77dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348407; c=relaxed/simple;
	bh=vHUUkPXFwLf4KGnZSOqColwII/6gvw5qWQ+yFfH1aOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzjQqHIq8wAQv+FplWvg+S+0NmKrohEec1gXkb3R5srQxAzF2Ni6xK/tz7KSEFHi0jgDa+8dIdjdzdvpOhT5iSWKxTwIsKowLDY5SEkak7pAlqMdYFaCIC/xPieHbnXsyGE4ngMMJFZt8Qev8sh/ZyK2GCStHJekHJUKr0tc5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5pNvnfZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5pNvnfZ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c197eaaab00so244880366b.0
        for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348404; x=1787953204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITnR6ks3UA4W9A1ERgkESDSmUijciQ0O4sxmZ41mlKo=;
        b=V5pNvnfZxq7/dFoTJjCCLYJ80FqZPVG4/GgpUoceaylSUrA8vT7JH+UUHs2jk1PD+X
         AvUdf2jbi0gGoX4Dr66yR1ENSKLX4FYBYZ+e/utbvUCg9CeUlEb/CMMDZmCfSYU3naEr
         ebgE0ZX7lD3cYy24nRTHYAt1hFPQF8TwILUBBZzFrd7YJ5GtNsV3h3RAPdblj/4wnZfB
         UVRx6EqNBwtYRxutvrcb279YYqdmmJ1KSZm5MK69Gm/KUloUjiAmG2nDvB8gfvMayZPb
         9CvEa/X74HCLPvUE0oLjntJTPFXYao69n5fIZGseIQbhK/lwriPPoVLBGMa0w+WM3xc9
         qw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348404; x=1787953204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITnR6ks3UA4W9A1ERgkESDSmUijciQ0O4sxmZ41mlKo=;
        b=M6/IK79FRqPOVLYRMF2HuXIl4gJH9K2BYPxwfvZBYJWssBODcqczVA0Uz/7sNwhvcH
         QTcrN1H0K1D87UFV1UdFCV74WHCzuqki5/nNKFVXTIPlgL3JPNs3dOQcgPNasgMxc9KN
         Nfu9cuKjzlTYP05fGzCKOWu5vYUVw1U9jWqk8Zu6gvpTDTulCBKW8+3r5a7I9VckPu+v
         1pYu6BGdhbT9LvOgaklF2RJmzCfWUX7926fpyQ24ttZ1qxU/x8ygE0XKALr8JWZJHF6q
         i3o80oBOSJH3LhKb/VaTrVPGhmMEC5MiywYAYBnQVefewvi6x+eng2DWA+icryfBUbah
         LlpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZzcyiZDdSeVaKtomDBF/fnEW/Ie1DJchG4gTtrsxeycxhAe45VgWZ05FOW7A6zFmbyhDXG5M2A+IV7lbvaw==@lists.linux.dev
X-Gm-Message-State: AFuF++krFP+r06abiIjLKVeLB/sUeuGb2Ah1Q50Jb6F69KQSaIwBB32S
	P6vchjNPgZ+0OlIexVkYN7xgzkkCHpYyEyEB268sHek/sOvdxcUTiQ0J
X-Gm-Gg: AR+sD10nnHTErAMt5f/yg2tyBhM+QLEyruLAXO9Ab8MurDJKq220z3rymFAq19llmKD
	uB75Pqhfto6OPk8e6EkoLd3qxGd5OrKJ2uH+jbMK0Y8Sinq6gQG9uR0UDgiqrZOUtFqRWn0Nmwo
	6QWeU8oO6oYE+a7rKWEn7uTuKDIn4uO/SzSBgCDzhTRIMxUR2toCDZudVRWaV8eAkeJtH/1GYnD
	Ad0r2hCNjm6YWj96G/bjgG0aoQQebB3SnN8JrqR7h8sQ5nfErfWG13Z3kgxndy2nQvXZlCxR7rI
	3jbXf4I+8iRtOxY7gLASjmF+jj9bu1R7BHC9E4RVOTTS7IHQfLV70/hNthyL0oOrOSsWM4V6MeU
	7SOp/EZ/eQKI8KfDL6k3lbNR+Gwk3NPPT+omPbuGOVhb6EgGRvsiL6fBl6Ejx7hlvHHVhL7hZzf
	Z1sAOHrgnoW1NSlUN2HUS1O+d89/6YAI2xM24G10EbL9hcvL9xEKeWQYWivbZN2si+yBQxKfw8N
	LyHI9jYhpeRMkkWdc/ubCwPQIuQ/97rPCJ6iOvw6dLiM+/l8yx2BDE3PGju9dZvTmX2Dn/8ioQv
	Ujw/N9+Z6mZ8azZTW3O5R/j2t3CYRtJ2L/GWm8TymzzfBUZq584wpWSBsVUvob/iwuegCG75nph
	JfJE=
X-Received: by 2002:a17:907:c50a:b0:c21:1b58:fa96 with SMTP id a640c23a62f3a-c246a39f3a8mr1027520066b.3.1787348404303;
        Fri, 21 Aug 2026 14:40:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a103-bf01-4ca5-89c5-9aa3-9754.310.pool.telefonica.de. [2a02:3100:a103:bf01:4ca5:89c5:9aa3:9754])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm5834966b.46.2026.08.21.14.40.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 14:40:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Eugenio Perez" <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: fix use-after-free in unregister_virtio_device()
Date: Fri, 21 Aug 2026 23:39:53 +0200
Message-Id: <20260821213953.76906-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_unregister() is device_del() plus put_device(). When the caller
holds no extra reference, that drops the last one and runs the release
callback, which for several transports frees the memory the embedded
struct virtio_device sits in. unregister_virtio_device() then calls
virtio_debug_device_exit(), which reads dev->debugfs_dir out of the freed
object.

Affected transports are the ones whose release callback frees and whose
remove path takes no reference: virtio_mmio, virtio_vdpa, virtio_uml,
mlxbf-tmfifo and virtio_ccw. virtio_pci is unaffected because
virtio_pci_remove() brackets the call with get_device() and put_device().

Remove the debugfs entries before the device can go away. They are only
accessed through the protected debugfs interface, so
debugfs_remove_recursive() waits for in-progress file operations before
returning. Tearing them down while the device is still alive is therefore
safe.

Reproduced on User-Mode Linux with CONFIG_KASAN and CONFIG_VIRTIO_DEBUG
by unbinding a virtio-uml device:

  BUG: KASAN: slab-use-after-free in virtio_debug_device_exit+0x36/0x4d
  Read of size 8 at addr 00000000616e0b10 by task init/1
   __asan_report_load8_noabort
   virtio_debug_device_exit+0x36/0x4d
   unregister_virtio_device+0x48/0x75
   virtio_uml_remove
   platform_remove
   device_release_driver_internal
   unbind_store

  Freed by task 1:
   kfree
   virtio_uml_release_dev
   device_release
   kobject_put
   put_device
   device_unregister
   unregister_virtio_device+0x48/0x75
   virtio_uml_remove

With this applied, the report is gone and unbind is clean.

Fixes: 96a8326d69ff ("virtio: add debugfs infrastructure to allow to debug virtio features")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 75bb4ffe3b877..b6c9e927bef57 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -604,8 +604,8 @@ void unregister_virtio_device(struct virtio_device *dev)
 {
 	int index = dev->index; /* save for after device release */
 
-	device_unregister(&dev->dev);
 	virtio_debug_device_exit(dev);
+	device_unregister(&dev->dev);
 	ida_free(&virtio_index_ida, index);
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);

base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
-- 
2.53.0

