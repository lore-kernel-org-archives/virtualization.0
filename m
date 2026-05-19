Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0546EEC3
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154521; cv=none; b=LeUXS0+aetUyeuDwvWC9GR2D9v+IYK6f+/iHKRHKBaa8K/tMlDwjbYklEhDUhgQH7FUwiZu6rYIxJWrCbFShFIpkHzetzrmLer579KlgVX4wP9tbspZiXDCJnY28pyFrdPp9TnvGVYsfgCy+OhM+xf+ps394kzcCYNydHCi+roE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154521; c=relaxed/simple;
	bh=KjMvZFjC6y4OcwTWkFYR1YeAONR7NN9MwUQVQd+2+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXtoVcvzKRYmKRlzlbVYu55wi3T7BWFgKaHnOB2E0QB6cVvuB51ub1Tl86owFcEqMsTv4Ub8dSXCcZ1ccl3WxbeZj8pIAdZx3v9bCujZ03C7cGEvLml0oBwWuQujxW2eHKs2tiC1lBnkObVZIzH0MPzl/2DZ+l6M0/dfesZjcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+zgC65t; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+zgC65t"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-573a81abef0so2288741e0c.2
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779154519; x=1779759319; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1Fp7K7PG/nlHH3CiiWwzeRxFndoQ3kUzPeEfziqQvg=;
        b=M+zgC65tewMja7LO+zo93sl76Zid57LzJNKrufRH9D61KfYUiVgxNFAcUSGWfWP8SB
         JZacI7NQCihcvRo/bc8KD9mrkOJU1tQo/IEZ48cfT9Iq1C+sRb015Cd47X2zEHji4WmJ
         kQmFfoqmPTAizbs69uOW9CWiAaT8PAxtq8gGhMWa8wNE3Cgyz285kAKoYBAefZzZEO0i
         R0mXVNtTfq0t1niMWCPPCjGA0HmUAE8RNIEBht9ArUao73Uqlv25nTQ5g59G2rnKjmFC
         cYRW3qGq+rb4h4osA7p4cWS6MAefqXbJTVH9BbnR9iicn/6Dh4Ev7mH1gdvK6NisO25I
         63dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154519; x=1779759319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1Fp7K7PG/nlHH3CiiWwzeRxFndoQ3kUzPeEfziqQvg=;
        b=slbPVMOZFQf7eSTJRWO3X1d/UiFkBil/GO7jKvV993ow1vvdYrDQgfJ25LsiNGorQ/
         /YUqFy1e8NyPSy4fn/pacFPT2U7HuUiJYC6H2707oEdxUr5H91BRqJp5hxD2bUd2OTbR
         YLshLA6Iq8oNppW40GcYOQF6PHPj94Cx6slQeeKkpDYSgT1eHalZPlunp4G5Jgh8YHTU
         OD7rEBJZ4hNCwCQKyjNUikhjl6A1A3zvoPbnHaorXUyAvf/RSWBNONgjevIVM1pxm8yO
         YhiVP+VDQ86LQ/SMpN1u0rl9CloSiCBnnXcNCBuNAnw1rweKeOv3OBQF5abw+lss/gUH
         xjLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4De07PYXhHG7XNR9psVpPGcYVqa2nvQ5B6jZ/Oo5YuHQZufc5tBePHQi335Mzy/i2SZ9m7EFagQleIEMplA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo/HX8p/18XcnRI4QQAbO+ggfGC8E/bKIqH3Cb6Ua10z5B52bb
	tlLdzGzbl9NX8rZv4nq5D/+rLfeqcq2yOQxjrse74i4e77NhYaYAz5kW
X-Gm-Gg: Acq92OEyzEaX5xpuNNA/yaBe6DdmGHF03DQko1CuW6LnF+OwZ5Bg/Fi08ttRDWqFRAU
	fTpG4igVAGJZE2R+RK8qu7YmoRaE7Gvd1PT7K2JC0Kxq3QByW0tCabgMO9yw04BjlTrC+Zo2S9Y
	FSyrQ2luKD30SdSx7N+qwYzHAcn+AcdqoeIT1l42bb0Oi8QWnIH4zLs39lCpUwq6jTE59p5lmOY
	6k6FGehb1CSxnxiGD4IRnU73n9PqzNIEe+1cvjbp77WX4IDNrjd34F7dwmyTklpujXzjYbF1Ahc
	ZIpG4gcoyqYjbNFOmi2xFq7cyPEOhPFRuqmFndaCqXInv1+JZcMeC23mw4AYyibCpZCwJ3oINlE
	6Rw1BE2n2puXjiwuO++Gu2FblQpHTAe/J0fTu7UBe2fQACB192GIB0mmJN+6e1zg9n/81Msv3lv
	93ogWpzQ2M9AU+M719LiH6b+7rvEjykMWMeOQ=
X-Received: by 2002:a05:6122:2407:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-5760be39b7bmr9653912e0c.1.1779154518848;
        Mon, 18 May 2026 18:35:18 -0700 (PDT)
Received: from fedora ([107.145.254.161])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760fadc1dasm7151886e0c.16.2026.05.18.18.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:35:17 -0700 (PDT)
From: Christian Fontanez <christfontanez@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: skhan@linuxfoundation.org,
	luis.hernandez093@gmail.com,
	rbm@suse.com,
	Christian Fontanez <christfontanez@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: add missing kernel-doc for map and vmap members
Date: Mon, 18 May 2026 21:33:20 -0400
Message-ID: <20260519013321.32511-1-christfontanez@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bee8c7c24b73 ("virtio: introduce map ops in virtio core") and
commit b16060c5c7d5 ("virtio: introduce virtio_map container union")
added 'map' and 'vmap' members to struct virtio_device but did not
update the kernel-doc comment block. This caused 'make htmldocs' to
emit warnings:

  ./include/linux/virtio.h:188 struct member 'map' not described in 'virtio_device'
  ./include/linux/virtio.h:188 struct member 'vmap' not described in 'virtio_device'

Add the missing entries in struct-declaration order to match the
existing convention in the file. After this patch, 'make htmldocs'
no longer emits these warnings.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Fixes: b16060c5c7d5 ("virtio: introduce virtio_map container union")
Reported-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

Signed-off-by: Christian Fontanez <christfontanez@gmail.com>
---
Notes for reviewers:
- Tested with 'make htmldocs' on linux-next (next-20260518); the two
  warnings on include/linux/virtio.h:188 are gone, with no new warnings
  introduced.
- Based on linux-next/master at commit 80dd246accce ("Add linux-next
  specific files for 20260518").

 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3bbc4cb6a672..bf089e51970e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,11 +157,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: the map operations for mapping virtio device memory.
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: the map container with transport- or device-specific metadata.
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
--
2.54.0

