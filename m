Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E03B584E
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565549; cv=none; b=kDfiuZUzkIWfl8wSp2FCBOHFxoNrOxbjAA2CoCljq7zfULwhJLEzY2SwgdvKQNm+LmgY1wX51bB3KS/6sYL9U9kiU3rKJ5m6UuV+cPwSnXxDDWob3N8NpFi5mEwa3F90LIMkJYYI7xgXjr1A39i2c+HDigcKIUP49M3PcjxQuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565549; c=relaxed/simple;
	bh=fRzh0K5qr4gUf/VYMCM55FzDDs+02qT33vHQYzGyP1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogX28qZV+MnRMwJ+ZT8k5eP8CA1BzUoC0Z+ujx9HEAugxihsBvIFCBwIMWhecp7/HJg/6lv09u2aBZh8x1OF/O3I/EZXiipihNTYcf0qOmfcqUPceMJZMCDS0Df6BJ5ZAskGL8fTFvZXz7mvTjx5UPnX++CNolKH4q0NwPxYfyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB2NEx1n; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB2NEx1n"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50baafd6c4aso60583781cf.1
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565547; x=1776170347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5iyGpUfhZgo+lStenOb/hPYg/mDianRBZA6L0jxT+kU=;
        b=ZB2NEx1nwgdQozeS4K33pBy91fytN10UfrmflS22xZFnVf1Y9kmakknDOiYl1y8Maz
         3v50vqiuh+h6MgHs4H2urC9gywfS53qgbUcdQj0aNsFe8wYt0OjK9tbh2PLLvwdr28mv
         4a3nMSVR3MscrISPMM96Mm0lJlJHrDizWZEU/0m+TpfvpNxSnuiYXAOBdfoTgFjjfa67
         VVN6qy4iD5BqrL1QiKV1Q9rpg0laJ14Qf3JyceZEhy8aoeM0cDkWNtm8GLaILVkpIAVp
         BYPfNKDrm3M0ndcUlV2UHjX6WZ8Sv7hYAkcvaKjBv9toMetFwc6H8rF/IehlmHXen8Bk
         UmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565547; x=1776170347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iyGpUfhZgo+lStenOb/hPYg/mDianRBZA6L0jxT+kU=;
        b=eUeblHiZkDhNuONILzjQ7a24kuzyhvZdNr4CjhwqDvfIx+5jHI4UCwJ1OX1n+ki1Bb
         zUsvH6uL5gWaEoyioPHYToK0kJIKnKqR18hWqRCRDQfgPgRtlq1jU5diMU+JeUi+wz+I
         elDF7VsTvRqyk3cqJpWL8nS9z/2X2Wj9J9oYTxUaC9AniYfCbrYuyzVaEgk9p6qni8lR
         quqpR2v2aqXWSVRCCcjxmaEt6FWwi7ixEsoNZIE1qzgzwI1argj3LMURZ84K8wpolh24
         4JhVpnHk5sM8syn7HXZGMtlnPVRcZXAfvcf0Aug5zowJ/wUTtpDG3wP53ssL0DinHA92
         K0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFC4DOMVY04IbR0QwvrWakY98BQVjRCtAwbS6sXWrJsHdqla7fiVyNKzioia0DvBYvxL80uAwRwwwYYwVxnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywns2X++1BhCRCkw40i04tkvX4S2QlxBVaYyW4A6lqBXf++Lfz3
	RGZZdv37l+6uHg+Z2yzWVrjO6PdOPB0MlFFyBjJIXC5irSjvNLGoWB3a
X-Gm-Gg: AeBDiet0QQIROWH0uZ4pZF2fJvjJjIfigOj4WFnLbCzqq7EXkA/vt8+Kwo5ZILRiVx1
	KT85zYnbmT+Ynt6Cz0VVA+UTRdf1wvNfn2OCjzhL6SxEvsURh3SalcrT2UOFuu+YPv4nyWDYA4j
	4P4n1u3NFjeATWt4QhcZ4KqOPKF2JgQMbWS502/0v0yivNDvmLCa/acaW8mXYAnSdutQnGMfEdi
	MH5mL/mu+GN5jwryExJ/vfxd7q8FPdEQJVwptZvUl3Ik08oJ8dxjIhnhlsBc2vvxu1Rv8SeTz3s
	5xP03eMzg5OrsUrT7X3W/e9+DD0mNO/qC6VWPaH3903oO7sf/ITEdp5LUH9ccRuVNsTN993cD1Y
	OIsxwrssfidcUQ9VeUbWsOL3I+kdT53k2UeJ98nRpgzotYJ1XqjiZks812hJ8ZdTdmj1kaUv7Tg
	Q36h1OTIwffzdD146labfduM1s/3BJF0ZLgJHnkhSFSPXXcQ0HEEUr/4jUxRVG4g5crnxpdlTbH
	ldzzH2vhEcYBHfYeSmAixfEPc5lSKOCOGAqWeSZaPeSgN31tTHIivF91KIESD7ejmUwvHufNd5G
	JwxbMiA5aoovdF9fze+p
X-Received: by 2002:a05:622a:4a83:b0:50b:404a:746e with SMTP id d75a77b69052e-50d62c71fdemr248911141cf.47.1775565547310;
        Tue, 07 Apr 2026 05:39:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:4041:5c46:7000:d80b:4b87:c7c8:bd46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4d4a034asm133005611cf.6.2026.04.07.05.39.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 05:39:06 -0700 (PDT)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 0/4] virtio: fix four bugs across mmio, pci, and vring
Date: Tue,  7 Apr 2026 08:39:00 -0400
Message-ID: <20260407123904.6390-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four independent fixes across the virtio subsystem:

1. virtio-mmio: vm_reset() returns without polling for the status
   register to read back as 0, violating the spec. Add a poll loop
   matching the existing pattern in virtio-pci's vp_reset().

2. virtio-pci: vp_find_vqs_intx() uses a sequential counter instead
   of avq->vq_index for the admin VQ, unlike the MSI-X path.

3. virtio-pci: vp_interrupt() returns IRQ_NONE for config-change-only
   interrupts because it unconditionally returns vp_vring_interrupt()'s
   result. Track the config-change handling and return IRQ_HANDLED.

4. virtio_ring: vring_transport_features() clears VIRTIO_F_RING_RESET
   during feature negotiation because it is missing from the whitelist.

Andrew Stellman (4):
  virtio-mmio: wait for status readback after reset
  virtio-pci: use avq->vq_index for admin VQ in INTx path
  virtio-pci: return IRQ_HANDLED for config-change interrupts
  virtio_ring: preserve VIRTIO_F_RING_RESET in transport features

 drivers/virtio/virtio_mmio.c       |  3 +++
 drivers/virtio/virtio_pci_common.c | 12 +++++++++---
 drivers/virtio/virtio_ring.c       |  2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.34.1

