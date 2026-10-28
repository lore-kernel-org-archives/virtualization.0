Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179308;
	b=w5Vw4zgpNu4lOmbnYA/Gh/d0J/17dqLOKehdCju09SQk81BDbgpdVNDV23lUrFLEy2j1
	 8O32q59cpfG4280q2J9dXYiBPmLA02HN5MF6MUkKq9kgjb++Egn+7Yo7EvXrA9VjOTja3
	 tEDkxc+Ywehs6tuctIamQzD1azUfRT2MyQN9dPiCT801Jf4FKNHoDrPKi7GjQRkeDhwHm
	 xnGscviXRqCDszgTpli7LCWRBh13MgN5LpfNEJFsPaKXAt9RV0wIqFFIO/6OVvsk9NuGm
	 7SSv0mmXxar8fTcWRCec9i/H5ZU+3FxjTAa2sNjsk5l3N4PTL5n5nhQ5wZw2ROBtRCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0pQyQ0CR8Ho1izzTFJRZdAq2GCxbm4EhPXXwabrY3Jw=;
	b=IkxByNyWDLn8e4VLeP3+vYl29k/51Nf5ays12O8zNyf4RqNAzRMn/AMTMgdoQjF7kSJw
	 FH6JFOmKUUCIFMgOz1zWsaGId3cyiC2tabir50o9TjERWU3stby5Fmgk1veHpwXvgQQNC
	 /O+J+c4EWx1ZWI7j+aGd0xqVOGrRCf9VaQBcNZ+F49084q8jv42HwhBV9a+lzE3hFUfIb
	 YCjhj3snBx5eYB/LB+RgttzGjxA7te7cXWI15Dm3fW/KVCD2eHeReYkMlSMxsspCZMsNw
	 5pNzZ95wWp/n2kK63YZ9XFdFrUWgPgacvXkfshL/amrExZUyHUrUohShOj1wWCj2OUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PKVbY/jA";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F530606A31E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F530606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PKVbY/jA
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso456340a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793179307; x=1793784107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0pQyQ0CR8Ho1izzTFJRZdAq2GCxbm4EhPXXwabrY3Jw=;
        b=PKVbY/jA/C/ALQe7ITWQNBZDiPMF5/YT8qKYG5XWB2/r72my7uEvfWAGL/2YPp81jG
         lwAcvtBMR0PKscAl+fDs8TVoScASUiF7ya1IcmrViG94NTWoAVOUrPpodfkJRXtDHB5T
         LO3b6o+7yRA2KGD3ZknjeGkD76tBAUDvgRXZyNTzNrF9kMGL2MVnNRYHfVpfoJzoHpMS
         NjPsSSr/iRYcangElgLU50+oxSjxmqw7A+7k1itQJNeIVxhBqVXZrHwK9KayEBNJnTPz
         gLQGXgNNd169FHuJvZTiYVgKmYvg2a70pWMMxKM1f3ty1hZybof4tWbiwbtZu0P2DwQA
         EtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179307; x=1793784107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pQyQ0CR8Ho1izzTFJRZdAq2GCxbm4EhPXXwabrY3Jw=;
        b=Fjb8MrFenJbZBlwoxyaZVrIe7eHpJmNFyjXNTQrMkfAyc9bUa859ebumsQQrbnW7Zn
         bn6Asn5c6UsbHwapnXpxcNxhcsdg7+Mop2yEhjZZaxavhJYdqg2yLKbV0HK4XUB88YZP
         Cn56uNc0k3mqK0Hp11tQCIMCpcLFJWCNYH6EGVGoWE+ZPXNZIdT47iph/igwYpWLIT5b
         KFM2BX6p7YcYGZiW4y5jU0MSe7Glm8kGodfooHEaEVOKnBYTE/tcMfEIN1ReLvyGQBOq
         6gS2U/lJrcj2APQgcHuBe51uxgPf+gY/7gyx6ZIbtpERHRiIJF/bGnqRqAN/xptq+Itx
         jung==
X-Forwarded-Encrypted: i=1; AKwUvBxmX6/fThkACCwjl34dygPwQPZ2s2SS1oDRZ5FfhZcYToJyN9WM/Ld5o5IB5r7oH2HdaVqH0xf5kFG9n+b/gA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIoWk9R4h1XhsEBUqCts9zalKXE4/prMeG7SMqUTs/TlVPCdIbO
	95XqHEEvn0Y9Mcc3/7mnzFqJatZPxFCzintQdjre/nkjz5QD1xOMlnrb
X-Gm-Gg: AYBFou031wACyCp6ku7R0PP+CURIGdq5i+q/TKOFnv1dawcW4iktaOdFCpRYNnVXmWe
	DU4c+UAaj9T8wXgjsvgzIxVcJPGZTV1SA9iOaR0e6qTxnjnJ6Sq2eUeUjewc8Jxp8psUv2HuHey
	OI3OVPliIko9VlZEtowTRiwQ1jtqWZNOeDOvBtMy72BWFitjG4uZTJzBxAg0UqA72hTrUEDadxR
	asElM4qhxKkGO6Yod2UW+tg0WjTNZ6EEXsG9oHs/MD4t6+RWKJkpywvTBX316cswp+RXJZNBBOq
	BAYwjOHXdYkFQLTxzN2BEpq4TsvpN94sYIaDASxVkTr4NnwKzQA7eAc0Y4pZpzY0IaAJv5tUhR8
	V/ZOqWrjNOz/AYOQH9y5KMYezzQrMcexsvZzJY+Tb45FjILkVDZ6UNFVphwe6JmyXQ+iQ9kfY1k
	tP06orc0ZWuC1j+sH5rYgat8SY6f54MQf5ohb2pE5iLjfUCnAU+D5jnu8/ZPo20rXFOezvOY7WT
	VeyQ+1+7s8bRN0OQ9oMSvHN+UulHsYMxY0s47Hbbp1X9bZn2xxSvlRE9Vbw640r27f3GEXNmnIT
	qeqDQ3IzXtpKa+o3SHDGLkBRQnnGs9Epwv4+WvrITGl7Lg9RtD83EJHi/98VUsLHp5AWBGaXmY6
	I5HbMsHv2EGI=
X-Received: by 2002:a17:90b:5863:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3ae581836a6mr1316337a91.38.1793179307335;
        Wed, 28 Oct 2026 02:21:47 -0700 (PDT)
Received: from localhost.localdomain ([117.88.121.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a27d594sm2256088a91.1.2026.10.28.02.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:21:46 -0700 (PDT)
From: Jianping Liu <frankljpliu@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	jack@suse.cz,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	alevy@redhat.com,
	frankjpliu@tencent.com
Cc: linux-kernel@vger.kernel.org,
	stable@kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/qxl: Fix oops caused by missing free_irq on device teardown
Date: Wed, 28 Oct 2026 17:21:37 +0800
Message-ID: <20261028092137.1372286-1-frankljpliu@gmail.com>
X-Mailer: git-send-email 2.43.7
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

From: Jianping Liu <frankjpliu@tencent.com>

After qxl.ko is unloaded, reading /proc/interrupts triggers an oops.
qxl_irq_init() requests the PCI IRQ with the DRM device as dev_id, but
qxl_device_fini() never frees it. The IRQ action therefore stays
registered, and its name still points into the unloaded module.

To fix the oops, free the IRQ in qxl_device_fini() with the same
dev_id passed to request_irq().

Cc: stable@kernel.org
Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
---
 drivers/gpu/drm/qxl/qxl_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 461b7ab9ad5c..e6c3d5ebd7c4 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -284,6 +284,8 @@ int qxl_device_init(struct qxl_device *qdev,
 void qxl_device_fini(struct qxl_device *qdev)
 {
 	int cur_idx;
+	struct drm_device *ddev = &qdev->ddev;
+	struct pci_dev *pdev = to_pci_dev(ddev->dev);
 
 	/* check if qxl_device_init() was successful (gc_work is initialized last) */
 	if (!qdev->gc_work.func)
@@ -306,6 +308,7 @@ void qxl_device_fini(struct qxl_device *qdev)
 	wait_event_timeout(qdev->release_event,
 			   atomic_read(&qdev->release_count) == 0,
 			   HZ);
+	free_irq(pdev->irq, ddev);
 	flush_work(&qdev->gc_work);
 	qxl_surf_evict(qdev);
 	qxl_vram_evict(qdev);
-- 
2.43.7

