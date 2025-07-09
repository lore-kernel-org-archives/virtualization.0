Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046523185D
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094532; cv=none; b=m8QdLoPc9qq75hCw9BPiAlvaHrFJwhTVNgK+wuficseqlnCqRnRX/IBtL1k3rW1vW0SvjTTAZz7yBItY1XllKJ+1ZgON6zOmD3HUaMt+YVkSmU9TKdDvHoLCWw2RXyStTLOBgDnBEK5rHiJ1zr+nkMbKAWS51JG7C5H6mNr/4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094532; c=relaxed/simple;
	bh=JTJVkmOLnRfILK5ufjbxQjP514STuLltf2LGrFdAEPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oT2SZo7NkS1/vYUZXC0nqfc6tVVlLNnIppk4j8pGXcLt13xc73K63lBhHdsouHG0WlA3s+ctbSMnB9eYGDeZwS9GE6/oV/FM76y99AvVZ462gl4inh8AXz7I7T4Pf5cJr7h1mqE+D4tj+YRlFoqclqEd/EUbUXl0FTgH1LySJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=el53lsXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="el53lsXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1eeG0+aNHKSbFK7ky8dnoR90LoNUZNKrOGjsnQWQ9MY=;
	b=el53lsXCiHq/Fp6+66xdDJWwmexqekfw9UKaflj581MhE+eEWKlMNFfoh1B/pMLM/E7j2G
	UfFHwJ1erjaWMgNHeJvz4MBmaBU1cEp8gd1n0VHqlqDeCNhFQ7X1hoeeDxsiuC9JrulQLN
	bSq9z1aluh8nfwrwNNNGHD6i9E1SxG8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-s_R8DsB4MwW-LvphDLwF9g-1; Wed, 09 Jul 2025 16:55:28 -0400
X-MC-Unique: s_R8DsB4MwW-LvphDLwF9g-1
X-Mimecast-MFC-AGG-ID: s_R8DsB4MwW-LvphDLwF9g_1752094527
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso170445f8f.1
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094527; x=1752699327;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eeG0+aNHKSbFK7ky8dnoR90LoNUZNKrOGjsnQWQ9MY=;
        b=Kekvr+D9olWMGRRBe2cJymW0Gnm/nD7YgyXBKRSrA4Vii4t5oVDyfD4//8buwurmiu
         9yIXJmbwVZTApltY8qMwVwPW1E2+7lVZY72NYIDbtb+bYnj8+94T2JJMQdrgz934KB5e
         AAWYiyb5Z6HzxG343Ptw9KyZuL0tX/7Sf3EzxNMnjbh8Lff8HsaQ7kP4KV5zLLDW5Yuz
         RS7k8GwxFMIaP5E9yJJoaKsbJv7pXdKmvueaOredXEPwOVikmiVMnvagNqUSY2Q8MKaM
         93Pb/nZxWf8qFXM6pGxoeAWmlsstBy+67UdqOAe6rRm5HHq3R07o5j3D1xcfjo9dVZIK
         3oBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlgwnOYzsAsmJJMsHZfDlToQzBocRK60cLxHLbRhfdvuI6WllvY3+r5u8qj+Synp2lG9bLawVkfzCqOSPxew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+UL7DlNAcHIBb5dLDbKTwJUBoBvnFwJTd0dVUFl8VLUC41p1+
	DVNtx+BiElyozIKFbu9Sa53AWFblqS3+aEJyv58B81hQ7jtf4/hUWTwGb7JIEramIbKxmoi5PkU
	1YAvkyZrMopJEm9FWkG3YxrcJJOVp8tgJ9dvApsQWUx7UhAIssSBLAEAgMdjs08lT+Jid
X-Gm-Gg: ASbGnct/kT20OGRo2TTm1b4BlZwxLGdM4uXfql6R1Mk6dtPp1dg+VSTGwFZQBtWhf5F
	9ywkOUVMWLD8hjWWQy+SI+uBEaBaqueiX5c7aHz1vHua8itAUK7Mcm8zxmkG8hDWUDt3R82ZFsx
	fQ7tZw6JVGWM+lZV6c4iELibkNFxHxYZ1mCts6KKf2WLGjC6onkn/G8PSmLPG6RQN4zO+m3GF0C
	6JZ1TbYkbsmJ6FwowlHgnz8PPsIhsF1/gOxxnyuAovalzzmjo1VAVXGn5SbeOH02AhWZJ94TmBk
	p4ZSI2Sx6HEEvRk=
X-Received: by 2002:a05:6000:2913:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3b5e788d2c4mr1319062f8f.10.1752094526795;
        Wed, 09 Jul 2025 13:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENLpfIvJB+dmyEoPgLHpsVWD6fbGIZAwezKmU2P9msQM/dbc5vXYMGNyI9NmDpA09Z2FQx2w==
X-Received: by 2002:a05:6000:2913:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3b5e788d2c4mr1319054f8f.10.1752094526364;
        Wed, 09 Jul 2025 13:55:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50516f1sm35729015e9.16.2025.07.09.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:25 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: [PATCH RFC v5 0/5] pci,virtio: report surprise removal event
Message-ID: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wetQVAcndtMgO1xt2d7bER67lFHI4X4jFsxwLYivbQs_1752094527
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Lukas, Keith, Bjorn, others, would very much appreciate your comments
on whether the pci core changes are acceptable.


Parav, I expect this to be integrated into your work on fixing surprise
removal. As such, I am not queueing these patches yet - please include with your
other patches fixing these issues.

==========

This is an attempt to fix the following race in virtio:

when device removal is initiated by a user
action, such as driver unbind, it in turn initiates driver cleanup and
is then waiting for an interrupt from the device. If the device is now
surprise-removed, that interrupt never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

        1. the graceful removal is ongoing in the remove() callback, where disk
           deletion del_gendisk() is ongoing, which waits for the requests +to
           complete,

        2. Now few requests are yet to complete, and surprise removal started.

        At this point, virtio block driver will not get notified by the driver
        core layer, because it is likely serializing remove() happening by
        +user/driver unload and PCI hotplug driver-initiated device removal.  So
        vblk driver doesn't know that device is removed, block layer is waiting
        for requests completions to arrive which it never gets.  So
        del_gendisk() gets stuck.

We could add timeouts to handle that, but given virtio blk devices are
implemented in userspace, this makes the device flaky.

Instead, this adds pci core infrastructure, and virtio core
infrastructure, for drivers to be notified of device disconnect.

Actual cleanup in virtio-blk is still TBD.
Compile-tested only.

==========

Notes on the design:

Care was taken to avoid re-introducing the bug fixed by

commit 74ff8864cc84 ("PCI: hotplug: Allow marking devices as disconnected during bind/unbind")

To avoid taking locks on removal path, and to avoid invoking callback
with unpredictable latency, the event is reported through a WQ.

Adding APIs to enable/disable the reporting on probe/remove, helps make
sure the driver won't go away in the middle of the handling, all
without taking any locks.

The benefit is that the resulting API is harder than a callback to
misuse, adding unpredictable latencies to unplug. The WQ can simply do
the cleanup directly, taking any locks it needs for that.  The cost is
several extra bytes per device, which seems modest.


Previous discussion:
https://lore.kernel.org/all/11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com

Changes from v4:
	fix !CONFIG_PCI, reported by Stephen
Changes from v3:
	added documentation to address comments by Parav
	support in virtio core
Changes from v2:
        v2 was corrupted, fat fingers :(
Changes from v1:
         switched to a WQ, with APIs to enable/disable
         added motivation

==========


Michael S. Tsirkin (5):
  pci: report surprise removal event
  virtio: fix comments, readability
  virtio: pack config changed flags
  virtio: allow transports to suppress config change
  virtio: support device disconnect

 drivers/pci/pci.h                  |  6 ++++
 drivers/virtio/virtio.c            | 23 +++++++++++++--
 drivers/virtio/virtio_pci_common.c | 45 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |  3 ++
 drivers/virtio/virtio_pci_legacy.c |  2 ++
 drivers/virtio/virtio_pci_modern.c |  2 ++
 include/linux/pci.h                | 45 ++++++++++++++++++++++++++++++
 include/linux/virtio.h             | 11 ++++++--
 include/linux/virtio_config.h      | 32 +++++++++++++++++++++
 9 files changed, 163 insertions(+), 6 deletions(-)

-- 
MST

