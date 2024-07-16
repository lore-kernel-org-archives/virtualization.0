Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF615491
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129761; cv=none; b=dOK7FEFPvP53pDd+EXKzZxeI+MiPsBaNabOHCXoOXwOL2Q8RUWag3Wkorw9yrrFZQT37Kb1I30v/uIKh28nLEhOCidakk4rOgcfC8e/kS7ppkodaZEbaqju9WFpkQXcNz0sEG35zzL5RvIJsLKDVu5ALvkx9j9D9Xln4vgceK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129761; c=relaxed/simple;
	bh=4yklOWkKrVpApwzZZw7FmQXgRKNFYuWvonlubqC+/w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQEx2ptIBFfQ8uqGEitfADDRUdJTka/DUAnw2WVsLxTlfZJ4wkxD9TwXG1RabcdeAmSdIih0dAJcbu85xppNFQuYJBbAFBT0AIN6eHYp33QST/ot20PYvu6dfuYccF/klbhYTsT2oHRx43FAfBnjIJh5nSZSOynT1P3l+s/8Ops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ejfJjW+s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ejfJjW+s"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso36948935e9.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129756; x=1721734556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq+V8e6E3TORmmEIhljg9inuMoGXfl58B4jGhHe1ocE=;
        b=ejfJjW+sZszPQmbICYHK4LfLLgv4zUkqvymy+A8g7lOBf2bs1zM5zu1djOAszRpNd1
         gHxte/V9WeC9IMHugYN3MO7+zHuxLFWUeMJccXfh1fKkDlhgVnZ4UTAcm0+e/rCj9kmo
         BYMhSHWdDcCN9Eb9Dq2jAzO0WI+Lelh8ihpwmQsprcKmil2wzJaG5btOb8c48b8STZLH
         twBS3+wCZlLQB9cW2X7+fyMlrXgl1gELbOZpxb8XIERi1JfBUImvT+lpXD0QYVVtAa0T
         QU9hQ/5/9991eJDM+7TQOqCFhS2EDkz8VwtjVB02jNkSmCPO1/mzT6Wz7BBVxwJezHqr
         Sv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129756; x=1721734556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq+V8e6E3TORmmEIhljg9inuMoGXfl58B4jGhHe1ocE=;
        b=ngRf9hYjpZN5BtIH/4m3bdxFvmu0pqTmG2C8OoB9kbQ3bJmjioK0+2YjEk2w7NYLJt
         CRkfPeW7yvyUTuofYbKbz0JH9Jcxw94r8vLV2pXSicHZxNztORzU7S2dT15YUPqZuKMS
         C9hYqA5q2owGTKieWFdctOXaa8eQbTqjA1JTeoTGYXk8zCh+Hr7+g+wN6rBICEdGmlpj
         X0CZwSzrBg/LZFlraGu1unJL59TDWZhRmvCzuuTECepWyUnVHS9JM3/+spmD5xRq7OwL
         nx/7FtrWG6YT6aJ96yYOOZuAOFAiFcRwhcAe5LLvmmEGUGraTr5wZ4F013X96foq+pjf
         iu1Q==
X-Gm-Message-State: AOJu0YwUUhAObR8txsXxmh1QyMyEWNA+EnADevamfIpSmoQ5jltUf+uT
	y2ZwqK3tJaOcuuxdPN/0EJhojV31f0DA/ZdTeTFJIkKV5zn+t4UB3IhtjgaTacsWN45jVemOGE2
	eTyM=
X-Google-Smtp-Source: AGHT+IFsgcYRN2iwv6UKGOv2bmROZbKqJLHyubJjrddFOkiTsiVdn/U00vZxDWWFwbebzOBeu9idHA==
X-Received: by 2002:a05:6000:243:b0:367:8fe2:7d8b with SMTP id ffacd0b85a97d-368275928cdmr1106569f8f.31.1721129756408;
        Tue, 16 Jul 2024 04:35:56 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25942csm155643095e9.15.2024.07.16.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:35:55 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 00/13] virtio_pci_modern: allow parallel admin queue commands execution
Date: Tue, 16 Jul 2024 13:35:39 +0200
Message-ID: <20240716113552.80599-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the admin queue command execution is serialized by a lock.
This patchsets lifts this limitation allowing to execute admin queue
commands in parallel. To do that, admin queue processing needs to be
converted from polling to interrupt based completion. Note that admin
queue is treated as a slow path virtqueue. That means that under
circumstance there are not enough vectors available, the admin queue
will share config vector.

Patches #1-#11 are preparations, making things a bit smoother as well.
  Worth mentioning is Patch #5, which introduces another vector
  allocation fallback for slow path virtqueues.
Patch #12 implements interrupt based completion for admin queue.
Patch #13 finally removes the admin queue serialization lock.

Please note that this patchset prepares ground for control queue vector
implementation as well, treating it as a slow path virtqueue as well.

---
v2->v3:
- removed forgotten struct member docs in patch #9
v1->v2:
- rebased
- added slow path vector allocation fallback
- fixed couple of bugs and issues
- see individual patches for detailed changelog

Jiri Pirko (13):
  virtio_pci: push out single vq find code to vp_find_one_vq_msix()
  virtio_pci: simplify vp_request_msix_vectors() call a bit
  virtio_pci: pass vector policy enum to vp_find_vqs_msix()
  virtio_pci: pass vector policy enum to vp_find_one_vq_msix()
  virtio_pci: introduce vector allocation fallback for slow path
    virtqueues
  virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
  virtio: push out code to vp_avq_index()
  virtio_pci: pass vq info as an argument to vp_setup_vq()
  virtio: create admin queues alongside other virtqueues
  virtio_pci_modern: create admin queue of queried size
  virtio_pci_modern: pass cmd as an identification token
  virtio_pci_modern: use completion instead of busy loop to wait on
    admin cmd result
  virtio_pci_modern: remove admin queue serialization lock

 drivers/virtio/virtio.c            |  28 +----
 drivers/virtio/virtio_pci_common.c | 190 +++++++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  16 ++-
 drivers/virtio/virtio_pci_modern.c | 159 +++++++++++-------------
 include/linux/virtio.h             |   3 +
 include/linux/virtio_config.h      |   4 -
 6 files changed, 239 insertions(+), 161 deletions(-)

-- 
2.45.2

