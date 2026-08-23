Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BD339375
	for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510108; cv=none; b=qT0PIBkIoc0pb+nN2chUPtWFVIUF0oyIci1DGiIpuW14O1DBtCuAszZtAgJlCdtRYhpTaPhI2jJ2NzSXak7po2HT5y+KS0XWoHQqoCDZyrz1U9kS+ZhDKxVHWKB+X+O7ZPjyzBZa37endJsrRbWiyFip0e9rfDnxkIhS2ndSdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510108; c=relaxed/simple;
	bh=yjdXslBGbzwFdci6QHpbbFDvYKSeF4IauobuIUcSXCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5o5nfi114QvzmjXx7onIBpk+14RHhqnrLp80Bf0m6Om/oIN163B0IJQbShML5HerUU+KakarBWr3gLuDqoE8Rpul4uAVW8wxOpdYUFE06X46mDxFRxeGwSRQb4VU7PGafoC7O8xGVPVpAvk0CX53+sy33UAou4FnzhIrY/G7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCN6+wPI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCN6+wPI"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1712a04ddaso458226166b.2
        for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787510104; x=1788114904; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhR6A6pOlxFnDseZWXN693d/vUJe+c8P3tz2lrasiRw=;
        b=fCN6+wPImDC/+db2eaQPMXXc37H6pZ9/oNWiDdXUovcyBh4ZmbxFv/Iz0cLMQckSyO
         A7om+yik4HUzWCkFr56dWNHyQQzoB0nK6ZxW57jzYlPKRAT19ZjIkJzoXdb9yUOQDivw
         HAKYtD3zpezjKGtD7TAi2rUlwL8xVzPWJqYEv4YMCDqVq9Zeoml0+S1tbQMy9GRSMEib
         M46V1pMC9Eft/5gDQFVVuZo2jQM7ko1RH3+klK8DqcFFeNyhjy0alxeNvxbkE/18TckD
         9v4E2ettetNQEJlW0fP0FkEcAKcxTGVHTxzBiULLHrpgmORf7/b2Uc6ERRl3m0V2OlZK
         L3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510104; x=1788114904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rhR6A6pOlxFnDseZWXN693d/vUJe+c8P3tz2lrasiRw=;
        b=RSyiD7n4oIgAGu+cjtS0t39l+MaTIKyNCsd38rK5XNZ/vD0javcC6LvMHHNR742W5n
         zjQw8HJvBfpMV3A1AN1I3G3NSMOjU0K5MNkVC8QMTlswzaS/ymyOVYGNoqr+6dgegDY9
         KisZiy8K2cGO64+w3xFPhoEMiaPm5qEt6XElC0ePejHVwvsI1QuPfAf8iy1s6z6sJog9
         TblUMEiK+Xg410UkB7NbyqrTh1fs5WWTG/IdKD/2c29IDkWt4nVOp4t7lcRT6ij17lLb
         C01TP0sT3LyOTxi0dHlQgqS2MZ97ZG98oTHZtMf8Kest3YoCOAd2whHnR6OQxr2+7Ehi
         8MGQ==
X-Gm-Message-State: AFuF++msL0/cfi3fEa/xMuJs0ToSrkmKpDYN5N0UEyKZPwdGYxb0zsBU
	EEZgKzsR6eyZJr8YxAk9UtpNLX87Mw7LlMH86JsrnQi3k2bn/7C3nAlw
X-Gm-Gg: AR+sD11XfOzqAxpDZfcmJ7OPpEyRdJhKZtNz9oHAYl/rsA5Grll9YWoSHd52REZcPJD
	G2u/tS/77BeTvXVeAqK2bJiWCpD/H6UjgNWjoAAnW0rWZVH3aqa2Yn9aR5zsPUq/bVkOZVlWEOp
	V6m9WwVcM7SSFnNv/+yjLidzvYaAqR/VZkZnu2mfONM5udSNxGc5EbFBSiy9auKdgOp0Gl3R3mG
	OApAKh05wybhWF+lGhX/94Jqfg+Oynd1awfIapl1kt1rAxZ73+13YGCV/ocFIEb1xxhfwREeIRq
	3Vr1ZhM4Ml2MPENqfbDiRan5VoyexMK3nWZ9nh0jXf6AUd5jf7NcC+MlQD8CR/c5bPJF9wNGp5n
	GfMt9WBvs0CZpydZMGj8SIEdVgmYyJaV9rIYp7ApBICqXPoJkI9Z6JOCdPhcSHVMCEOseG5s6EJ
	FL6ZUr1N01DQ+IcCHcpEqDMYHoEq7nN1F+nGIyAjHxBSeJA4i6v5bRkmlNG+AnZ2s/dhTqUjTFw
	cqye3ABftPr/aLhyXDV97+eS14CoNAAPkze7dbQbIhJ7qIc2RI74yE=
X-Received: by 2002:a17:907:72c4:b0:c24:4128:c19f with SMTP id a640c23a62f3a-c2491e838dcmr1642086166b.11.1787510104071;
        Sun, 23 Aug 2026 11:35:04 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box (dynamic-002-214-002-133.2.214.pool.telefonica.de. [2.214.2.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm805385066b.27.2026.08.23.11.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:35:03 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: lukas@wunner.de,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	stefanha@redhat.com,
	parav@nvidia.com,
	axboe@kernel.dk,
	kees@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 0/3] pci_hp: fix surprise removal hang during safe removal
Date: Sun, 23 Aug 2026 18:34:52 +0000
Message-ID: <20260823183458.982699-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is based on top of MST's RFC v5
(cover.1752094439.git.mst@redhat.com) and tries to address the architectural
gap identified by Lukas Wunner in that thread.

Context:

MST's RFC v5 adds disconnect_work infrastructure so drivers can be
notified of surprise removal. Lukas identified a race that the
series cannot address: if safe removal is already in progress when the
device is yanked, pciehp_ist() is blocked and cannot deliver the
disconnect event.

Potential fix:

I reproduced this with a simple edu device driver (patch 1) that blocks
in remove() waiting for an interrupt. Same as blk_mq_freeze_queue_wait().

deadlock in pciehp_ist() is avoided by adding a workaround in pciehp_isr() (patch 3)
where a disconnect_work is scheduled and as this is a different thread it runs and
dispatches the disconnect event to the driver. The driver can then unblock and complete
the remove() and thus breaking the deadlock and also overcoming the problem of
not waiting in pciehp_isr().This is only schduled if the PDS is set to 0
indicating that there is no card attached at this slot in pciehp_isr().

Tested using qemu:
- Hacked the edu device to raise a delayed interrupt.
- Hacked qemu to actually act like suprise removal by adding a simple monitor cmd
  `pcie_surprise_del` to remove the device and genrate PDC=1, DLLSC = 1 and PDS=0.
1. Launched qemu with the edu device:
    `-device pcie-root-port,id=rp1,chassis=1,slot=1   -device edu,bus=rp1,id=edu0`
2. Ran `echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove` to start safe removal
3. Ran `pcie_surprise_del edu0` to surprise remove the device while safe removal
    is in progress.
4. Verified that `edu_remove()` and `edu_disconnect()` are called.

Without the fix: remove() hangs permanently.
With the fix: pciehp_isr() fires, pciehp_disconnect_work() schedules
pci_dev_set_disconnected(), edu_disconnect() completes the wait, remove()
proceeds.

Would this be a viable approach?

Assisted-by: Claude:claude-sonnet-4-6

Abhin Parekadan Jose (3):
  misc: add edu_srpoc surprise removal POC driver
  pciehp: add disconnect_work work_struct
  pciehp_hpc: workaround to not wait in pciehp_isr on surprise removal

 drivers/misc/Makefile            |   1 +
 drivers/misc/edu_srpoc.c         | 180 +++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp.h     |   1 +
 drivers/pci/hotplug/pciehp_hpc.c |  47 ++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 drivers/misc/edu_srpoc.c

--
2.51.1
