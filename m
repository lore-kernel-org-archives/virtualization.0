Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661112;
	b=VjslEvsrsv85QZKafHOL+TzlxKxAPueZUIrO7LTKAPbsK3JMrPXYhSVEkwgOnTaPpq4S
	 LULb6tJ6yifncTpj2bfpD06709HcJDw0WAjUS+PfgqWl8OsNPYXtE+Ds4fj/D5/u93GHi
	 JcmbC5Xd4iYZJ3CbPU9KFDTDNX16xbtzOAmU5VQKeWRcpQHkPAAUxzXkvP+LUcrnxBiL9
	 1yFdbHa6prxvUBbJwjB6L3LcfsH7Wm6TZJvuwF9XsogClxAmcWY5W1Qpud6IoOAz7M4ji
	 f5/qllPWZvZsWlxq8LRz/31obUcfsK15yMm2Wm336HNu32umR3wXtrwPG6ySp3P6XAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
	b=jXgkwLLnjk1IchBzy7B9Gq6EfPOkxJVcIuoaCgYy8jao/M9T8ZKZ2nGFirRV9seqVy9D
	 MUoYMTk01RCfqM/Nt5XXbTw2tIcwswwwdyr2lVVPbk3AA/+cydVvnxpHL2GqQTOq4NR/y
	 2kGCpJEQnKslwQtCiJPrDpACIVe5SyJIiJuFGTuimHK6f5dJqmSYmdJjwGMjo93Hc2XnO
	 5g78Tlljq4ZQgch3HhCqqtO+0eicS4VGGI4gEwy+879GzpOnicBEPMWyzbz8Um5O48LIT
	 f4ljfylSR73YjuYJAcRxQNG2wAUV+HUSkYIb9EjJUV1cLJJxV6M6DK7Hi57N278dAOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=DHpNGTal;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9D606A329
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 02:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A9D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=DHpNGTal
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-677bc4704cbso7726979d50.0
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 18:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661111; cv=none;
        d=google.com; s=arc-20260327;
        b=Br8dBuwk2ygxY7XUnUZyMEJ187tewxHrAQkhl0Sqtf4VIqwdpAiFNNWMRlNd5iLr+G
         euqEG47WOT5EyYuLTcaxFXuhf4mJJtkdVrJYVePsVkGFH4wyknf8D45ubIgVRUty3THN
         WVyTYnRC1UjdJls2NC73gvfdjwYS8U2j0rEh8dhZnsApaCZJF6uFFV8dVYc38HYXO0XK
         WtzH+jvjemxRuvBZ/JGGJ5QPQKEdMj1fEODfImnFUFvN5liMvqa8iBHlSKXuFv17El7R
         MhzasCCyJq90I2agDI3b/GWYU/7X1DHVfoSvZDl4beOsCHtNLda2v/CWHoQiY5xhPVts
         qLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
        fh=7kCGE8VWeVERe48JKaQE48MmfxLMCExcB55M+6FiZc4=;
        b=BXbzkZeEZpaJozc3BdjQweJBIoTIZRKtQZt3MH3Jk4sSe1KoBtK1FOFkXIX4WVtanZ
         TnwMio9XwvUfdoxYnrNDdtlDhoQUwccZT3Z0+GguUrFhgUl+q6dpk+1wlWjDBGeh7+FU
         bjtv3HEg5lZqJq1hn37MfayNvNeZo/fwlHPHjnMW/qo7dFCsI3uqIJSz4w9bK/SQVeGa
         kTRh9AWCmf5W/LeoQvf1MRVAsfv3uwYWgZKxJO5XXgkVbhd6DbCjTLnswaAyXzfJTDyQ
         4OFRtx4G89hK0rrCjVgzIlGV2Z4R4izPpGHcmsDfDoSKD+zjh2wQHxPvdZOgLMHuNFSw
         0uYw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661111; x=1796265911; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
        b=DHpNGTal2wiRsv8Dw/jhiNOpBR+yEXJxiCkqbZJ7XANgnC6sdG3B4iHE7s9K97DeQp
         AN6PYvZZpwy7D2CRdryYGvFlWsTBzphy28YwwYWUdwWHMWUVo6BnabvFPJVYgeXzdo5P
         2najv7En23Xp2L3HuowMIrwMat2k3V7NdYvpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661111; x=1796265911;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=84DdSevlHdho2iOPdHyadO6XW3qwMBjauZijK5v2WFU=;
        b=HAq4hPzALkasYzSZYx5cUh8xjI4GNxjyB5l126VPuMkym732qt2UxfH1mHdPfDoIXj
         FYW0Zs/7rHv/9EhtB0Sxu5Wh17I3jBlQafevjPPtbu8Nus9GYTOjjqhJn2BHG7mqa93+
         y/VWs6qBYbBGrVdodHZlghYtQH4Kwfeh41T2cCz04v3Dwy/Zn5nnFMOGU0gJtxCBDuZu
         c1mlY/jKo0BVP54KeSF6vZA57oSVZg3UEKT522OvjXPaoULlcK3RKl+UkrhvhsccgkGp
         B9D3Wx4CK5Hk/brtVOfUrMl/XhDLxQfSe7UQQSSkfp0v52lEVqoifYB424ecTjZbbq3D
         3yVQ==
X-Forwarded-Encrypted: i=1; AL+hErHTsHaZqNBJWv37buEB6lx6deZtL6JOYM8JQlniZVXPZ7L1IaQUnyQFxv1ftkeMXByNnfW3r963C1DnaJmSug==@lists.linux.dev
X-Gm-Message-State: APuU4Z9V5kI6Da7FMYQ/JdRKhmX40DIIWgUuxNQG+VtL/cpPev5MZsAL
	yDCQH2rCOt/OOzdbY8oDz8ppS2UYcB9whL8JwXqprKxnQC+tNAHe3kPMu7BGeNx4cMEV5YaIbuG
	H0chrFuFNMTWhLObC3ETzHeuVB9MXI7vIyJiP7GImeQ==
X-Gm-Gg: AZFdTZcXti02B82mj6uEQC8XqZGkQQWDNLW57hWOxpsj7yMLTXHm7fzgeoVV9iE+7hA
	O9ZQ6d770j5OWt2/dnZS0eJJLhqmJZ/rcK8lIfcqYTG6wlNUzbTX1eYJG2602xAmoP3bM6M+xla
	/or3l3PI0s8Ql4wKL2zerdC+lSeTxW2nDLqc82AAPR9spooZfJNFDCMFnr3EPW4xKWSxho4Nusj
	zXIBTXuFi/oJ8tlhEZEV9nOCcrkSZmoob6zbwGPFMXlegHOo6zo+SJz7uDMotLd7u+DEQeYdUD+
	EmuI870WjORYAHNfQhaQPhI1G08/MNNHIKODYMy3jc+zmdPp5UoItEBfJKYkIdwQJDFj+gcB8iQ
	yH4dLj4ABZrqRBwM8RfiyDGbQw0BQ/IFk1HH4OI+9PMAYi1gi5DdVsqS8KL3jsesSVX13tDiJxY
	h1CD3b9R32wUNydkhKsOEdMTVRMkrobF0xKrtq/5al0JgixHo65Ia8wLrGskgQZpvG+ymXgwdk+
	9Ig+r7uDkEU+gc/MEoNWSJlW3HD1cT3+UFB1/XIf4L0HdXPSlxw+nhWOQ==
X-Received: by 2002:a05:690e:b89:b0:67d:c37d:331c with SMTP id
 956f58d0204a3-67df44ddeb8mr8126491d50.159.1795661111365; Wed, 25 Nov 2026
 18:45:11 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:10 -0600
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:10 -0600
X-Gm-Features: Aa3M54oYYln_PYaeGvWJPmyHTFtgp5tbd4RkECzndSrc2_KWyM6QBHXs2A8H9Sw
Message-ID: <CAFaZ9eqZCgDaXJ=2QSBmHVz9WEL4cpthQX02xVesUB5G3NRQWg@mail.gmail.com>
Subject: [PATCH 6.12.y 1/4] virtgpu: don't reset on shutdown
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Michael S. Tsirkin" <mst@redhat.com>

commit 183a08715af1491d381b4e22efd61578fbe05fa5 upstream.

It looks like GPUs are used after shutdown is invoked.
Thus, breaking virtio gpu in the shutdown callback is not a good idea -
guest hangs attempting to finish console drawing, with these warnings:

[   20.504464] WARNING: CPU: 0 PID: 568 at
drivers/gpu/drm/virtio/virtgpu_vq.c:358
virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.505685] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink vfat fat
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common nfit
libnvdimm kvm_intel kvm rapl iTCO_wdt iTCO_vendor_support virtio_gpu
virtio_dma_buf pcspkr drm_shmem_helper i2c_i801 drm_kms_helper lpc_ich
i2c_smbus virtio_balloon joydev drm fuse xfs libcrc32c ahci libahci
crct10dif_pclmul crc32_pclmul crc32c_intel libata virtio_net
ghash_clmulni_intel net_failover virtio_blk failover serio_raw
dm_mirror dm_region_hash dm_log dm_mod
[   20.511847] CPU: 0 PID: 568 Comm: kworker/0:3 Kdump: loaded
Tainted: G        W         -------  ---
5.14.0-578.6675_1757216455.el9.x86_64 #1
[   20.513157] Hardware name: Red Hat KVM/RHEL, BIOS
edk2-20241117-3.el9 11/17/2024
[   20.513918] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
[   20.514626] RIP: 0010:virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.515332] Code: 00 00 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 51
50 00 00 65 ff 0d 42 e3 74 3f 0f 85 69 ff ff ff 0f 1f 44 00 00 e9 5f
ff ff ff <0f> 0b e9 3f ff ff ff 48 83 3c 24 00 74 0e 49 8b 7f 40 48 85
ff 74
[   20.517272] RSP: 0018:ff34f0a8c0787ad8 EFLAGS: 00010282
[   20.517820] RAX: 00000000fffffffb RBX: 0000000000000000 RCX: 0000000000000820
[   20.518565] RDX: 0000000000000000 RSI: ff34f0a8c0787be0 RDI: ff218bef03a26300
[   20.519308] RBP: ff218bef03a26300 R08: 0000000000000001 R09: ff218bef07224360
[   20.520059] R10: 0000000000008dc0 R11: 0000000000000002 R12: ff218bef02630028
[   20.520806] R13: ff218bef0263fb48 R14: ff218bef00cb8000 R15: ff218bef07224360
[   20.521555] FS:  0000000000000000(0000) GS:ff218bef7ba00000(0000)
knlGS:0000000000000000
[   20.522397] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.522996] CR2: 000055ac4f7871c0 CR3: 000000010b9f2002 CR4: 0000000000771ef0
[   20.523740] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.524477] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   20.525223] PKRU: 55555554
[   20.525515] Call Trace:
[   20.525777]  <TASK>
[   20.526003]  ? show_trace_log_lvl+0x1c4/0x2df
[   20.526464]  ? show_trace_log_lvl+0x1c4/0x2df
[   20.526925]  ? virtio_gpu_queue_fenced_ctrl_buffer+0x82/0x2c0 [virtio_gpu]
[   20.527643]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.528282]  ? __warn+0x7e/0xd0
[   20.528621]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.529256]  ? report_bug+0x100/0x140
[   20.529643]  ? handle_bug+0x3c/0x70
[   20.530010]  ? exc_invalid_op+0x14/0x70
[   20.530421]  ? asm_exc_invalid_op+0x16/0x20
[   20.530862]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.531506]  ? virtio_gpu_queue_ctrl_sgs+0x174/0x290 [virtio_gpu]
[   20.532148]  virtio_gpu_queue_fenced_ctrl_buffer+0x82/0x2c0 [virtio_gpu]
[   20.532843]  virtio_gpu_primary_plane_update+0x3e2/0x460 [virtio_gpu]
[   20.533520]  drm_atomic_helper_commit_planes+0x108/0x320 [drm_kms_helper]
[   20.534233]  drm_atomic_helper_commit_tail+0x45/0x80 [drm_kms_helper]
[   20.534914]  commit_tail+0xd2/0x130 [drm_kms_helper]
[   20.535446]  drm_atomic_helper_commit+0x11b/0x140 [drm_kms_helper]
[   20.536097]  drm_atomic_commit+0xa4/0xe0 [drm]
[   20.536588]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
[   20.537162]  drm_atomic_helper_dirtyfb+0x192/0x270 [drm_kms_helper]
[   20.537823]  drm_fbdev_shmem_helper_fb_dirty+0x43/0xa0 [drm_shmem_helper]
[   20.538536]  drm_fb_helper_damage_work+0x87/0x160 [drm_kms_helper]
[   20.539188]  process_one_work+0x194/0x380
[   20.539612]  worker_thread+0x2fe/0x410
[   20.540007]  ? __pfx_worker_thread+0x10/0x10
[   20.540456]  kthread+0xdd/0x100
[   20.540791]  ? __pfx_kthread+0x10/0x10
[   20.541190]  ret_from_fork+0x29/0x50
[   20.541566]  </TASK>
[   20.541802] ---[ end trace 0000000000000000 ]---

It looks like the shutdown is called in the middle of console drawing, so
we should either wait for it to finish, or let drm handle the shutdown.

This patch implements this second option:

Add an option for drivers to bypass the common break+reset handling.
As DRM is careful to flush/synchronize outstanding buffers, it looks like
GPU can just have a NOP there.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()")
Cc: Eric Auger <eauger@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
[ adapted to 6.12: no reset_prepare/reset_done in struct
virtio_driver, add only .shutdown ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c
b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 44d99e89bb9b..92332f9d1796 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -126,6 +126,14 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 	drm_dev_put(dev);
 }

+static void virtio_gpu_shutdown(struct virtio_device *vdev)
+{
+	/*
+	 * drm does its own synchronization on shutdown.
+	 * Do nothing here, opt out of device reset.
+	 */
+}
+
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
@@ -160,6 +168,7 @@ static struct virtio_driver virtio_gpu_driver = {
 	.id_table = id_table,
 	.probe = virtio_gpu_probe,
 	.remove = virtio_gpu_remove,
+	.shutdown = virtio_gpu_shutdown,
 	.config_changed = virtio_gpu_config_changed
 };

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 078e5483b22f..8241024f0890 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -391,6 +391,12 @@ static void virtio_dev_shutdown(struct device *_d)
 	if (!drv)
 		return;

+	/* If the driver has its own shutdown method, use that. */
+	if (drv->shutdown) {
+		drv->shutdown(dev);
+		return;
+	}
+
 	/*
 	 * Some devices get wedged if you kick them after they are
 	 * reset. Mark all vqs as broken to make sure we don't.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3ad94d939d28..2759e2c24d6e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -204,6 +204,8 @@ size_t virtio_max_dma_size(const struct
virtio_device *vdev);
  *    changes; may be called in interrupt context.
  * @freeze: optional function to call during suspend/hibernation.
  * @restore: optional function to call on resume.
+ * @shutdown: synchronize with the device on shutdown. If provided, replaces
+ *    the virtio core implementation.
  */
 struct virtio_driver {
 	struct device_driver driver;
@@ -219,6 +221,7 @@ struct virtio_driver {
 	void (*config_changed)(struct virtio_device *dev);
 	int (*freeze)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
+	void (*shutdown)(struct virtio_device *dev);
 };

 #define drv_to_virtio(__drv)	container_of_const(__drv, struct
virtio_driver, driver)
