Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA122D7A9
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310132; cv=none; b=YHWr7KEyxc17hAJTaRpdtneC2kPN2WCTAzwvlkybH2TZ1RivFLQIRMVnFV+meUGHH1gCgd0gqi3GXN0N1QcA+3Q0dSLlwUBrVii8XFNiszgGzhyjIavr28rLZ7p+YJ5k6mrRfG3qRCYLa+wLeXEs8dC6xp0gbia8Rczd4zWdCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310132; c=relaxed/simple;
	bh=ls5x7/h6PkyMwjIK7m+WptLGXeW9x7K+JqAeCp80rAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSh8nKhzzdys17mHlowNcFYlnD6zvp4TCPOR+PcTeUU88PrAr3P0XwmsCXcM8SVXI2VhU3c4tPp3z2Y+YdHwoBVAmzPTRyADotQTvwHYQnUwZD1sRMqKPOy0nbMuQJxIrkYeciCJlmjsKsLA8/nxTLAzKzpT1Pj1C4Pnh0sJuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=rVVDlz63; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="rVVDlz63"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49263703c6eso399665e9.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1782310129; x=1782914929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHAT42RXInTAMI9ksXMYSe7Z9GutkddjZOFYn2zaAnw=;
        b=rVVDlz63KgiTnmzEMaNjX4VKYBUUVPX+K+B3QK5bmvb4aaLFkzd+1k973m5K/F8gYt
         fOM0M5TG9mAfx8isRYoQ9d95c1lzfkrgDcalxNyQ1p/JtFJB4i9ze2pvnX7yVXnetyoo
         O4odh+5XlB7oXJ6h3Xqq0Y7mIYQgDutw/5VdTsAkllUDKgiHRLczeXlf9tJpnyvtiOjI
         4UC9rf9rVFzWsKswgDxRx7+ZkaHQN2BQL/WxDN9STGLcX2zmx5b40zHE0g43+r6yYXQh
         1ei7A2y2pMGPepzL1jGYbnfgQ22APh2oHGx88oL3uBS/3U825OtyFH302PXKW54tlZQK
         pgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310129; x=1782914929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHAT42RXInTAMI9ksXMYSe7Z9GutkddjZOFYn2zaAnw=;
        b=BdIG+sHD7tU29KSGnjJ9SFJyZefsSq+0MK7P/qYzg8zWlNhb3O2YHTPUsuphRseG5/
         YETxn7CPmf28PdoqvbcZBYIhWiU/s1R6uW/Cj93uZSwV6Gxio0w1rqySrS7L1NdO31Gs
         rA+RNRx5odewZ9mlvIf0I8CwfRtGLWFAH/AURVAoQqVxLFz4VxDSCNxteuD+IsumSQN6
         u1Ld7HhHDUmFqmT3SGXHb6PICYxKgQewajYgOnIsCTromtPHd6KWA7+p3CWZBBNFS3iR
         I4jJ8FQnJzMd+ySfrFNNN/kwA0hqr2s8YCn6uCcVaDs4+f/qKSkY9YlzgrHCKu4zxgzr
         ObFQ==
X-Gm-Message-State: AOJu0YyOtNleDGLWbi0bzT8WaESLGqrZ+gZVkIuiuKk6G1IoA6DRBe2u
	xNwuw+4EfhplY74oD9niR4FtF5+AjMT7e9lcboNwiwCUWNj8amX+ImBFBW8zuXCzv8g=
X-Gm-Gg: AfdE7cm6HL1rzXwJ71t+O0yM8P3PypRaTxFDYt5WuoaWkpbTHtiShdGpsfXGO60p/WO
	u2NnGC/c6BgFr30pRm8l6bQj30VdCG5DQ+rwBIXEuFmz/62SCiec8dly1rM5O1BnV6tFxIKQOSS
	ParrnpYRIwUsFruwfInYvbiHQ+UPZSi3AqO9RuPDkLK3CncqPnIcKOZFDv4dYWqCooUPBqEOfso
	8dyo7HKBHlTyRB3f+r9RGWosQ9Imn1SIbr4wwOPlaxgiteowFB0ZiP7Q6Yn+6zupHG9mAkF7OIt
	v7gttseFyW9FojnsPTlqxv3sOpuajN1xbmzzyb/vKrAG5JpbsvOuyKJdg4+2PQxRbrWCGx+83No
	BB9aI5AI+EHzZJ/O9ucPTBMMDinaHylKMu2k2nnknz/zYNqqR6k7Zzo1oBZJu6cZaCfQCLOwCG+
	h+wwUR
X-Received: by 2002:a05:600c:c8c:b0:492:3291:9011 with SMTP id 5b1f17b1804b1-4925b389fdemr121858035e9.30.1782310129541;
        Wed, 24 Jun 2026 07:08:49 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:306c:c2d:85d5:28d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm519680275e9.5.2026.06.24.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:08:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 0/4] virtio_balloon: quiesce balloon work on device shutdown
Date: Wed, 24 Jun 2026 16:08:42 +0200
Message-ID: <20260624140846.2616797-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()") the virtio bus breaks and resets every virtio device
during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
.shutdown of its own, so that generic path runs while the balloon's
asynchronous work is still armed: the free page reporting worker, the
inflate/deflate and stats workers, the OOM notifier and the free page
shrinker.

Once the device has been broken, virtqueue_add_inbuf() in
virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
On a kernel booted with panic_on_warn that turns an ordinary reboot into a
fatal panic in the middle of device_shutdown(), so the machine never
reaches the new kernel. The inflate/deflate and OOM paths do not warn but
are no better off: they call wait_event(vb->acked, ...) and would block
forever on a queue that can no longer complete.

This was hit in the field as an intermittent failure of a virtualization
cluster upgrade: guest storage nodes were rebooted via kexec into the new
kernel, and the ones whose free page reporting happened to run during
device_shutdown() panicked (the guests run with panic_on_warn) and never
came back, stalling the rolling upgrade. The crash dump showed the WARN at
virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
virtqueues already broken.

Validated by churning balloon inflate/deflate from the host while
kexec-rebooting the guest in a loop under panic_on_warn: the unpatched
kernel reproduces the WARN within a couple of cycles, while the patched
kernel survives many consecutive kexec cycles cleanly (12/12 in the final
run, 0 WARNs). checkpatch is clean across the series.

Changes in v2:
- Add a virtio_device_shutdown() core helper and call it from the balloon
  .shutdown handler instead of open-coding break + synchronize_cbs + reset
  (David Hildenbrand).
- New patch: make tell_host() warn and bail instead of hanging if a buffer
  add ever fails (David Hildenbrand); kept as a separate patch
  (Michael S. Tsirkin).

v1: https://lore.kernel.org/all/20260622133715.3707707-1-den@openvz.org

Denis V. Lunev (4):
  virtio: add virtio_device_shutdown() helper
  virtio_balloon: factor out virtballoon_quiesce()
  virtio_balloon: quiesce balloon work before device shutdown
  virtio_balloon: warn on failed buffer add in tell_host()

 drivers/virtio/virtio.c         | 41 ++++++++++++++++++++++-----------
 drivers/virtio/virtio_balloon.c | 40 ++++++++++++++++++++++++--------
 include/linux/virtio.h          |  1 +
 3 files changed, 59 insertions(+), 23 deletions(-)

-- 
2.53.0

