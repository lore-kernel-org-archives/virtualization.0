Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3A481AB5
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Sep 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946980; cv=fail; b=eSKlQC7hkzTikJAj+G8/Qmp62m5QmbX2v3cMKe+ni7mgwvD9vqNyy2DqGdmNf2ImlUI0W27qDOxN7pDihmMGnPLsgq6aDnOaHlcFr4Ri0io+1sCvCkznjIWZQTSf66kqTHbGfQvK7MQQFtAxixo78gmIF+QzUkC1qB5ikRVT5xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946980; c=relaxed/simple;
	bh=nAQBbg9Zs0y2Qf9x9IGuBTOq7gf12GSRPT0y06wSXn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NEeGqweK0dH2rF6dQpk/1Qzc64r1tNztYb9UwS2kgFb6Q6yHrxBRLgtZpQQSQHcGc5Tqh5RWMlfl8akR2anK46+0dNeQ+cXl68FB+pPbNIK4zK/Oweyw62TuNigy7aLolADVLxmYmKNR38zwUAW9ipt31hTtBFAeJ/XQ/wslPcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fk6xCJ+i; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk6xCJ+i"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82024606CE
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Sep 2026 09:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.353
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rjt7Iv_dL3TB for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2026 09:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C50F860639
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788946975;
	b=Q+o3qvcLi52ouFc3Qa+9e2IQ3yeGPXZ6dTeyF90tU6aoqRwEmQHy1Ak2wvro9ES7BbC3
	 bI6fMHHcLQWR025FauWhq+VgMwDkkSCQFHusMevdyKLMp63u2748Mc3C4fZCVuSW/1iUc
	 UpgPjO0G1eA54QI7T/cBmO3v3kSuZkdCmE4iQJe4HFbksqaKfy99ptL05gBAAZyoqQYC6
	 PYrHMpR0su4K5Rzb+nH5pUhnnb+sPxK7SOQYolZ7S+F8HmhKtYaWZgCnZq2ewgQ1BUMqa
	 V3ViAVkRpVmoEF/XNqBdGDlQOnupxYOlnXFhG6LETPxboFfpPixdIDY1a9dNkAjtOQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788946975;
	h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=k5ADtFhBnmPz3rZHAoQiP2HyIk15/rYOjED5HrGOPIQ=;
	b=Z8Y167yr3zAGaPJmQCkaxVPvTjen3mTpvbHlREtN1bssNIgJtURlbTGtG8TeBKApPZvM
	 PD9KJ5LNWJ3R7gNtPmhrXODU7+wFxxT2nPiQ2i9L4b6sqyGl4boquJfvVmT3N/SQGvTir
	 YKmsC0YK5dNC5glcU2rakV/QU/M4l4R+sPjlN4TG0D41HX7VBRr4DgkPI1tSOwdmWRl87
	 ClS3MZwrI/VAEw/2zzkQmRUT5q5gGfFaVm4pH3pHbDbSPcrPPqZczEHf3w4ipXjerONys
	 9xYZOY+B14sdpRuauHdFw4kfI3wVmzPBQqpgOip1nTcxY4CtgGIZNjddCkqwPkNG7EQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fk6xCJ+i;
	arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fk6xCJ+i
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTP id C50F860639
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Sep 2026 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788946972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5ADtFhBnmPz3rZHAoQiP2HyIk15/rYOjED5HrGOPIQ=;
	b=fk6xCJ+i9yRfsv/76BYrMqmvaSScOXxM9EtKdV8JP4pgqJfwm5RWOuA8cbgev8ptQL30Hu
	oQ4cVswy9jKRH9Rapzea2z9lRSN24EvWJvrUTjtDrzAGtF596VKYAfLN2J2781plK3fb/1
	C9ndrKA+4GzM6ibcfVq31IUZ/+JrOCc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-B7T0HTUQO1aiYOenzoA0dQ-1; Wed, 09 Sep 2026 05:42:50 -0400
X-MC-Unique: B7T0HTUQO1aiYOenzoA0dQ-1
X-Mimecast-MFC-AGG-ID: B7T0HTUQO1aiYOenzoA0dQ_1788946969
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a1e3cfc8d3so4508508a12.3
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Sep 2026 02:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946969; x=1789551769;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5ADtFhBnmPz3rZHAoQiP2HyIk15/rYOjED5HrGOPIQ=;
        b=dzSxOBQFL2vfy5HtF5G+JRVLILgjVJM2x5PlBQHNXkMJ+G0X3zSqapNGN2v/1a/HSp
         oMYuLYIa7U+TcyHoUXBxYbLGkORoeo4zh8XyVGNyvTrbPDfFcaTu7N7/UCSRPYd9LvOi
         d7awZfd7Q+Mpzswm6ftivpuJJRK1caLzyjd6OnkSm4glkk5/rrvIeNVLjGiH/kzOyZTD
         JfO9fTFHLLahJPzhuWp5QAdPwkTjIXU9Ttjh48VMEQcDa7FEIibpI/EhilxG/9sUizHg
         FGjD1d6cB5m+v+nHR/+dT5B9x31+Z2xkH2gJLaUkVetZlShRdSclJzEopcdGR4/F1YUK
         YyWQ==
X-Forwarded-Encrypted: i=1; AKwUvBziYoKZoD5xf0qfERKP1zt5g+7H1unYUlUU9eG/dqNvVfCiIUBZ6peEB1rcJJJ0KeNxhHTSiQWz83rlwyGBNA==@lists.linux-foundation.org
X-Gm-Message-State: AFuF++m2V4ztK27wZ1d0CRWTo/lfx0JXb2Hn8NQOnxGH7Q/MQCgsod2E
	/4uJoS1BmpMJmB7e1QI1JpgY8YG4vj3t9u0EEDEcDIK4rt6D7TtHtyVqALzG6rgDx2Qpm7hTBfV
	8ptxyhdNe7tEz+zJCSvb+oRo1HAzeKE3ALNxnS+B3VzrW4kzGoQLTqk3LQTNgINzF/O/pjYpgD7
	VUBkiRTgY=
X-Gm-Gg: AYBFou358BPUA+Lh6wCA59YNMamod9C2+36wARhYb1SyFxhXXpNbGK2TWjp+PfUhGYC
	jMJ3FAWXGfnEPZFWRFHOBSadhBhLSljjjxcbh3Ie3CAeChKbVK472pFeCSwlbGXuLFDkSjmavk9
	ajh2Tpu9n/2d4VMkunx6/scHI58oP2qhlVAci45OH9Id1sQDF5pG3cX581vr75WlMaKiI9HyQY9
	bIw+McI7tYYJcGQO7PXWyJzG3bOdPFlPfdr84+LL8uJu5bTTSm7Ja6NI0mm3YjYRGzAKSJGkqnx
	idPfGznI4nwHKfwjJnvOT3RvssB9Ln4Bc/gBjSW8I6EEjKtTWZQDICFdqPGMp9smbg3P2rfLAyb
	ENHV67LWTdxBkBY/Z+xhDc68=
X-Received: by 2002:a05:6402:2552:b0:6a7:ea54:390 with SMTP id 4fb4d7f45d1cf-6a7ea542471mr11986155a12.33.1788946968952;
        Wed, 09 Sep 2026 02:42:48 -0700 (PDT)
X-Received: by 2002:a05:6402:2552:b0:6a7:ea54:390 with SMTP id 4fb4d7f45d1cf-6a7ea542471mr11986120a12.33.1788946968355;
        Wed, 09 Sep 2026 02:42:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9857ce120sm1226086a12.4.2026.09.09.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:42:47 -0700 (PDT)
Date: Wed, 9 Sep 2026 05:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	astellman@stellman-greene.com, dongli.zhang@oracle.com,
	eperezma@redhat.com, graf@amazon.com, kmehltretter@gmail.com,
	linfeng.sun.dev@gmail.com, lvivier@redhat.com, mst@redhat.com,
	nikhilljatt@gmail.com, physicalmtea@gmail.com,
	xiongweimin@kylinos.cn, yuz08559@gmail.com
Subject: [GIT PULL] vhost,vdpa,virtio: fixes
Message-ID: <20260909054245-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D4WqSG2wGwDBr9pWrvbwNtMajmAwgt05sFKYteXRwps_1788946969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 48a4ee65e677559776349128e6a81a6041986c99:

  vduse: return compat ioctl results directly (2026-09-08 03:58:27 -0400)

----------------------------------------------------------------
vhost,vdpa,virtio: fixes

Just a ton of small fixes all over the place.

Also includes virtio and virtio-rng MAINTAINERS updates.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Graf (1):
      virtio_ring: fix stale descriptor flags after a failed packed add

Andrew Stellman (1):
      virtio-pci: return IRQ_HANDLED after non-zero ISR

Dongli Zhang (2):
      vhost-scsi: use kvzalloc for vq array allocation
      vhost-scsi: clamp max_io_vqs module parameter

Eugenio Pérez (1):
      virtio: add Eugenio Pérez as Maintainer

Jia Jia (4):
      virtio_console: do not free control-out buffers on remove
      vhost/vdpa: reject VRING_NUM larger than device max
      vduse: validate virtqueue alignment
      vhost: invalidate vring access on IOTLB transitions

Karl Mehltretter (2):
      virtio: fix use-after-free in unregister_virtio_device()
      virtio_input: stop callbacks before unregistering input device

Laurent Vivier (1):
      MAINTAINERS: Add a section for virtio-rng

Linfeng Sun (4):
      vdpa_sim_blk: reject out-of-range sector starts
      vdpa_sim_net: check TX pull result before RX copy
      vhost: limit outstanding IOTLB misses per virtqueue
      vduse: return compat ioctl results directly

Nikhil (1):
      vduse: do not take dev->rwsem in the virtqueue kick path

Xiong Weimin (8):
      virtio_mmio: disable IRQ wake before free_irq
      vdpa/pds: check virtqueue notify mapping
      vdpa: alibaba: Keep DRIVER_OK clear if IRQ setup fails
      vdpa: solidrun: Free IRQs after request failure
      vdpa: ifcvf: Put device on unsupported feature error
      vdpa: octeon_ep: Check dev_set_name() in dev add
      virtio-vdpa: Use queue id when setting vq affinity
      virtio_input: reset device if input_register_device() fails

Yu Zhang (2):
      vhost-vdpa: don't install the eventfd_ctx_fdget() error in config_ctx
      vhost-vdpa: protect config_ctx from being freed under the config callback

 MAINTAINERS                              | 13 ++++-
 drivers/char/virtio_console.c            | 21 ++++++-
 drivers/vdpa/alibaba/eni_vdpa.c          |  5 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  3 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  2 +
 drivers/vdpa/pds/vdpa_dev.c              |  6 ++
 drivers/vdpa/solidrun/snet_main.c        |  6 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c     |  3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c     |  7 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c       | 36 +++++++++---
 drivers/vhost/net.c                      |  2 +
 drivers/vhost/scsi.c                     | 49 +++++++++++-----
 drivers/vhost/vdpa.c                     | 88 +++++++++++++++++++++--------
 drivers/vhost/vhost.c                    | 95 ++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h                    |  4 ++
 drivers/vhost/vsock.c                    |  2 +
 drivers/virtio/virtio.c                  |  2 +-
 drivers/virtio/virtio_input.c            |  9 ++-
 drivers/virtio/virtio_mmio.c             | 16 +++++-
 drivers/virtio/virtio_pci_common.c       |  4 +-
 drivers/virtio/virtio_ring.c             | 38 +++++++++++--
 drivers/virtio/virtio_vdpa.c             |  5 +-
 22 files changed, 342 insertions(+), 74 deletions(-)

