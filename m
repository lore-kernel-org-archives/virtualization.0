Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5826ED41
	for <virtualization@lists.linux.dev>; Sun, 13 Sep 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304445; cv=none; b=labM06Cl1eMCDBP+wG60/ysbVzAcEEfA9r1zMZtAC1MZnG2YBVGSRd/zki0dM3zSX2NM7RMMJf+/g7jiXy5G00E2/bMr9FDQ4BIEnrqRS3F76JaFo4WvrjA3A3HyNbJgt8OT0dUAbdX8sG9LtJuRkK0BnFd5wkgPzsWV9A+ySlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304445; c=relaxed/simple;
	bh=gh86QNcgL4/uql6T9miV+QNqawWq9xpt0gG9GifnxNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f0A5wN3K8yeRqArRDGhuFnCt36Rf1vcAWLmqdwjzM+GN3OANU5WIFsUcI4d+DaHDyzZ6PJn1+ahIDr1tPKVTFPsdU6PijYYWeMT4M+jUr1qR12TtfgFGXiI2lrDBc/DwuAos+WRItUAUVe7y18yVWOQp16u3OnbUDVG83wZ5cSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM4Q8n4p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM4Q8n4p"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3672442a91.2
        for <virtualization@lists.linux.dev>; Sun, 13 Sep 2026 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789304443; x=1789909243; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nUmpKZoARnUkAufXwb6NS9vkOKIDYxCTjaWje8+N2Ps=;
        b=FM4Q8n4p5IoP8E9AJdZ+F9wgUK1WsRtAijICl0HhB8mIxq6hWZASo6SFIFM/+mKpf4
         r/a0mU6aSDTNXp/GoHsbKuUuRvTXktBrdEQdij+u3GWh0QQ1+GY3fyDEzAce3ylP6nm/
         OJZ3SDKUYJU3SSXZB45Yedf1v4FDpiFGoZm7gzUxxs3o8Zg8VZ8+JRbDdNMvwnjqm4HL
         ctm8sLFdFA2s8J2tMvwapArNyn8iHLork7XLSNU/OaC35k451xNZJmOz+wQvacC5/E9h
         Wpj0T2GrxexesAGJG8O4RGOqiZKVAXBUiPKZ8bYEikuSwoCgBqCVal6pw/Or4E40kZ5n
         Ynhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789304443; x=1789909243;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nUmpKZoARnUkAufXwb6NS9vkOKIDYxCTjaWje8+N2Ps=;
        b=Dx24Pzipo6T5meccno5/YTEB3kSZ/yUTHbRfjcxU/oko2PBP7OqcLkl92nCRAecEXD
         VxNvt2QmmXPqq6pD1m5WX62Ky5lsHeCxBQRtNs4vnZExTtmlSAJTs650LSvYvWgxneWF
         vDJdDJGAALP/lcvyzNLpk7yNm9JB1j6YHdypABROEJuGE9JWZTii1B5AWfXazLd3oY7F
         BatX/KaW+AyebWGX1sUcqmZnpOJFj20Xwc7xmsK9H4O3XqRhimxq7pq24NnX8TsnkBSM
         EocFs3hSFJXzY/empyTeNqw9BWwKDLuwPwbYjy7v5V/DKBxLI2VNqg5qpAXXOHwhwumX
         6DGA==
X-Gm-Message-State: AFuF++lKF8b3+i809PD4qLKvEwXX5uQJ6LrUclef/GHM2plvCDudcnOI
	BpuZ0pklVP+tGg4aB4NYJLrLMDB6Y1bmgcgVnWNrqMshPIVTQSSw6loxjrtmbQ==
X-Gm-Gg: AYBFou2aCFwu/vbqoi4C0oJTpHgpLlz5WXhyTlqG5wUWYT+yKKlEpQw6zIRuVxPJf7y
	Q5SrjgQ1neSpIypyF+lSVToZIxs6My3Sb8tuX5PrIrXteJe7S9cWjibd7KtZsgQtn80/godL9KS
	D06P33jhb4Zh3KP+mfavik7jiD18LiyL7b1RAmOIth0nI1vsddzz5rZ/GieNYDAce1OA37jNv0X
	XV7L/5uyXPk7cjCMakN/yfSfF+FbqyfF8H4Cvz8bG+j+TseB3K3M4iH2i1R1YY8QW6GPVZgb02J
	9H1OCy7FMT0BxrAz8eCe6j818aScurEBFUTuqYg8B/HedaBHoRSyU7ZQTt8HDzgzXV+rjm5hZVd
	sUlnFbv2YZhxO/6XzoXQxfddyVx5SaY2eocUt/BSZQ/5vMrUG8mPznm0ZE9chhejgodQr1VELf3
	aF6UMmHf1/uTpZKxjMjEGnjHdI8l72XkqDFXxl12VaPU7TAsVpyRmZ+sBeskLoarU5YCT2cMtVw
	xrXuMKb26KOnana+DzDzfy8Xj5zYsOf5UY=
X-Received: by 2002:a17:90a:1049:b0:39d:e213:9dd3 with SMTP id 98e67ed59e1d1-39de2139e65mr44858a91.1.1789304443314;
        Sun, 13 Sep 2026 06:00:43 -0700 (PDT)
Received: from [192.168.66.6] ([210.32.34.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39da64d4bdfsm3330754a91.0.2026.09.13.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:00:42 -0700 (PDT)
From: Linfeng Sun <linfeng.sun.dev@gmail.com>
Date: Sun, 13 Sep 2026 21:00:27 +0800
Subject: [PATCH] vhost: reject invalid IOTLB update permissions
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-fix-vhost_chr_write_iter-v1-1-76bf1f436cfe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1JmbSAT0dBeRSTYOG2mi1ZmYhVK7
 +6oi7948N/bQEmYFLpmA6GVlZfZAA8N5HKbR3J8N4bgw9m3eHQDv91aFq0pF0kv4UrJJs5HxHB
 C3/YxgukPIfv+0pfrn/XZT5Trtwf7/gFoL9AnfAAAAA==
X-Change-ID: 20260913-fix-vhost_chr_write_iter-071125109b77
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Tiwei Bie <tiwei.bie@intel.com>
Cc: virtualization@lists.linux.dev, Linfeng Sun <linfeng.sun.dev@gmail.com>
X-Mailer: b4 0.16.0

vhost_chr_write_iter() validates the type and size of an IOTLB update, but
does not validate its permission field. An invalid permission can therefore
reach perm_to_iommu_flags() and trigger its warning in vhost_vdpa_map().

Reject IOTLB UPDATE messages whose permission field is empty or contains
bits outside VHOST_ACCESS_RW before dispatching them to a backend.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
---
The Poc sends a VHOST_IOTLB_UPDATE with perm=0:
[   16.334240] ------------[ cut here ]------------
[   16.334439] invalidate vhost IOTLB permission
[   16.334700] WARNING: drivers/vhost/vdpa.c:1035 at vhost_vdpa_map+0x232/0x240, CPU#1: poc/84
[   16.336107] Modules linked in:
[   16.336739] CPU: 1 UID: 0 PID: 84 Comm: poc Not tainted 7.3.0-rc2+ #3 PREEMPT(full) 
[   16.337376] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   16.338035] RIP: 0010:vhost_vdpa_map+0x232/0x240
[   16.338505] Code: c8 41 b9 c0 0c 40 00 4c 89 e6 48 8b b8 b8 00 00 00 e8 d2 22 88 ff 41 89 c7 e9 9c fe ff ff e8 25 85 90 fe 48 8d 3d 3e b2 f5 01 <67> 48 0f b9 3a 41 bf 04 00 00 00 eb b6 90 90 90 90 90 90 90 90 90
[   16.339394] RSP: 0018:ffffc90000e9bc00 EFLAGS: 00000246
[   16.339796] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   16.340241] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff84d69230
[   16.340631] RBP: ffffc90000e9bc58 R08: 0000000000000000 R09: 0000000000000000
[   16.341073] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000100000
[   16.341461] R13: ffff88800913cf70 R14: ffff8880090dd800 R15: 00000000ffffffff
[   16.341906] FS:  000000002789c380(0000) GS:ffff8880f8536000(0000) knlGS:0000000000000000
[   16.342403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.342731] CR2: 0000000000409f70 CR3: 0000000009079000 CR4: 00000000000006f0
[   16.343374] Call Trace:
[   16.344029]  <TASK>
[   16.344363]  vhost_vdpa_process_iotlb_msg+0x896/0xdc0
[   16.344912]  ? __pfx_vhost_vdpa_process_iotlb_msg+0x10/0x10
[   16.345399]  vhost_chr_write_iter+0x168/0x7c0
[   16.345739]  ? apparmor_file_permission+0x29/0x40
[   16.346159]  vhost_vdpa_chr_write_iter+0x27/0x40
[   16.346529]  vfs_write+0x3e7/0x7c0
[   16.346838]  ? __pfx_vhost_vdpa_chr_write_iter+0x10/0x10
[   16.347315]  ksys_write+0xae/0x180
[   16.347640]  __x64_sys_write+0x22/0x40
[   16.347964]  x64_sys_call+0x1285/0x27e0
[   16.348354]  do_syscall_64+0xbf/0x550
[   16.348674]  ? do_syscall_64+0x31/0x550
[   16.349067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   16.349484] RIP: 0033:0x41bd24
[   16.350187] Code: 89 02 48 c7 c0 ff ff ff ff eb bd 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 3d 93 09 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   16.351030] RSP: 002b:00007fff105b3438 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   16.351506] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000041bd24
[   16.351869] RDX: 0000000000000048 RSI: 00007fff105b3440 RDI: 0000000000000003
[   16.352359] RBP: 00007fff105b3530 R08: 00000000004b4820 R09: 0000000000000000
[   16.352733] R10: 0000000000000001 R11: 0000000000000202 R12: 00007fff105b35a8
[   16.353167] R13: 00007fff105b35b8 R14: 00000000004af868 R15: 0000000000000001
[   16.353626]  </TASK>
---
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 44cac11b68d2..0adf0fea97b4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1750,7 +1750,8 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 		goto done;
 	}
 
-	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
+	if (msg.type == VHOST_IOTLB_UPDATE &&
+	    (!msg.size || !msg.perm || (msg.perm & ~VHOST_ACCESS_RW))) {
 		ret = -EINVAL;
 		goto done;
 	}

---
base-commit: ac7360d48607622cd3b1889e2d642a47e458d9e3

Best regards,
-- 
Linfeng Sun <linfeng.sun.dev@gmail.com>

