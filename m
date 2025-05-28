Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78C2459EA
	for <virtualization@lists.linux-foundation.org>; Wed, 28 May 2025 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417256; cv=none; b=OJPWckS3b/iCdlFyXYQL+TrsVbCypS+8zV0yHqpQlhAopkxEafynIbQPGK+DGXODs9F8J2Z59AcyJb28eBpVK7tCCjvqU9/sXtIFuF+4aOWotGem/sC5w0fiWZO5E2DqdZHyuHSLkZxm2h3VsLckErtILU9latXkcKyrHX0hlq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417256; c=relaxed/simple;
	bh=4d2Rvh5/049QiSFiG8HqsMtGYGDNAUWELzNpSKTOFQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MxuanjRL7Z5jGul9idmFWMvo1IN6cosxg0LvhVxQvmInHtIRpBISO/9z6VCBS44MjQeSLxIrD7Fuar0BGPe6BhfQcajoqa476ikz3IfrZXB9/592/1OFmfrdQkJJQUMrobXULUYSXhUg3GZjxSOHZK5kNBDJ4hXU+ZT2DowGu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CONghq0O; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CONghq0O"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B6B740A02
	for <virtualization@lists.linux-foundation.org>; Wed, 28 May 2025 07:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sdlzo4Kb4mbQ for <virtualization@lists.linux-foundation.org>;
 Wed, 28 May 2025 07:27:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 613F2409F1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 613F2409F1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CONghq0O
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 613F2409F1
	for <virtualization@lists.linux-foundation.org>; Wed, 28 May 2025 07:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=u7w+oFgheV8aZ4x33cyzyZZ5cNI/GkUhBQCV4X7SdIs=;
	b=CONghq0O/fpAfrFVKt4mEIWTncKNZmt+9cELYWk2uNbFq1DRwMFYlht3pjhYGbOnFDKeze
	lR4ypMWYEkga4EHPa1mZrSy8i/sfHvfghNIwoM3UlVtlAs5T6WL+TvuktDXT8Lstc6OkfM
	WbqkiJ77zRhgJSNSIZhxD7qKiCznF7o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-sBpbUeHqMGqFOLsnO5n-hg-1; Wed, 28 May 2025 03:27:29 -0400
X-MC-Unique: sBpbUeHqMGqFOLsnO5n-hg-1
X-Mimecast-MFC-AGG-ID: sBpbUeHqMGqFOLsnO5n-hg_1748417248
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450787c8626so1679315e9.1
        for <virtualization@lists.linux-foundation.org>; Wed, 28 May 2025 00:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417248; x=1749022048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7w+oFgheV8aZ4x33cyzyZZ5cNI/GkUhBQCV4X7SdIs=;
        b=GokiLnQ6U5XLFWksH9D9qKdWAcg8JT5tkebddigRzliTwibfZAELNMm6qYYbW43zeW
         YA/3Xc1Mblk6JV44KOt5YoTWNRHPDLJxtLdfVT8Nj7PbMvILLa+nb6MNo9oOWlxdgX1J
         iAAaerpJf4mEHUCg3FbCFX7gAOqYSRCr2B2mbdCABo9af+FeFdaKmUQRVOZSzxR4ck5U
         84+X6/7nhrnP2ZZwW10SD47+8CLAzahEIEtXKN6NC3H512KqMiPD+DPBmgDajR1GLN8J
         aRryQiXIpgjHw2ySoPcMWe8ewKjwEBsD7P6iX+nAvHWoIr0BiX9tYR1x2aW16Pl7RbUg
         CpDA==
X-Forwarded-Encrypted: i=1; AJvYcCVkIXAOPs4xRq5S3t12x6eRzPo7F+ei66zLoGTrT/wxxhDMZVkfAiiagEpJCsUO/XancVXuhgA5+x1JmfiOrA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy08sc1M6YK8e8gFerUU9aRnxgxzY/7gEXYzYJlco/TYhrrfkKy
	kNI2WwOHZgIgE4L3XnSBtmEuxQKM2BQ0Egb+XYzQmAHCrulZV5LkAxoEnOh73jvf+DgBOv6NVxx
	+0j9BMg/BXQ+MQdzW39hPKK5r9QHP3qLrZyqDZrSJp4C/0tEyTHAASENmXX/+j2EBItoW2f+mMK
	np07KDRRI=
X-Gm-Gg: ASbGncv7AWHTiarqvMQeRlUvnUf1PfJe0TRIcwXTiqD163ZKwrVAMN5zxkdkOjBdxfV
	Iy8GtN0HyZuMA0t6jcoe2ztKm70Gw+JrWb6XvlkivfC7GST8n03PIwTNsHlCYsVqGfn7T/1lIvN
	zWfII0shGNdc5v+duRJmXQEnnaeBdgRSUUmVKHBWVU8iug8s/o6jCkTIqqs3YgUZNGrZcG6V145
	imhd4sSfBSTtEr+wVehYrrKzzsOrYv4Xb9yCzB2ppZ2KlBdqO7jkyTUeMY/j09TocpT3WF8slAS
	qkoYhQ==
X-Received: by 2002:a05:600c:4e45:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-44c919e13ddmr185732535e9.10.1748417247879;
        Wed, 28 May 2025 00:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEltm4UmhdICUHUpMHmQNZNYzagk6xfrMPG1SMAdHiF25jVtOn4A91e8E91qUEsAR8QkJYhDQ==
X-Received: by 2002:a05:600c:4e45:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-44c919e13ddmr185732135e9.10.1748417247448;
        Wed, 28 May 2025 00:27:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064ae775sm12042235e9.22.2025.05.28.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:27:26 -0700 (PDT)
Date: Wed, 28 May 2025 03:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandre.belloni@bootlin.com, dongli.zhang@oracle.com, hch@lst.de,
	israelr@nvidia.com, kees@kernel.org, leiyang@redhat.com,
	mst@redhat.com, phasta@kernel.org, quic_philber@quicinc.com,
	sami.md.ko@gmail.com, vattunuru@marvell.com
Subject: [GIT PULL] virtio, vhost: features, fixes
Message-ID: <20250528032724-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9uPrNs9Sm-WWj1Qnyh9X8-9wMw0sgOhAzal7_J8axeY_1748417248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,
There are several bugfixes I'm testing for post rc1 on top of this, but they
are pretty minor.


The following changes since commit a5806cd506af5a7c19bcd596e4708b5c464bfd21:

  Linux 6.15-rc7 (2025-05-18 13:57:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 206cc44588f72b49ad4d7e21a7472ab2a72a83df:

  virtio: reject shm region if length is zero (2025-05-28 03:19:03 -0400)

----------------------------------------------------------------
virtio, vhost: features, fixes

A new virtio RTC driver.

vhost scsi now logs write descriptors so migration works.

Some hardening work in virtio core.

An old spec compliance issue fixed in vhost net.

A couple of cleanups, fixes in vringh, virtio-pci, vdpa.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Christoph Hellwig (1):
      vringh: use bvec_kmap_local

Dongli Zhang (5):
      vhost: modify vhost_log_write() for broader users
      vhost-scsi: adjust vhost_scsi_get_desc() to log vring descriptors
      vhost-scsi: log I/O queue write descriptors
      vhost-scsi: log control queue write descriptors
      vhost-scsi: log event queue write descriptors

Israel Rukshin (1):
      virtio-pci: Fix result size returned for the admin command completion

Kees Cook (1):
      vhost: vringh: Use matching allocation type in resize_iovec()

Peter Hilber (4):
      virtio_rtc: Add module and driver core
      virtio_rtc: Add PTP clocks
      virtio_rtc: Add Arm Generic Timer cross-timestamping
      virtio_rtc: Add RTC class driver

Philipp Stanner (1):
      vdpa/octeon_ep: Control PCI dev enabling manually

Sami Uddin (1):
      virtio: reject shm region if length is zero

 MAINTAINERS                              |    7 +
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |   17 +-
 drivers/vhost/scsi.c                     |  190 +++-
 drivers/vhost/vhost.c                    |   28 +-
 drivers/vhost/vringh.c                   |   19 +-
 drivers/virtio/Kconfig                   |   64 ++
 drivers/virtio/Makefile                  |    5 +
 drivers/virtio/virtio_pci_modern.c       |   13 +-
 drivers/virtio/virtio_rtc_arm.c          |   23 +
 drivers/virtio/virtio_rtc_class.c        |  262 ++++++
 drivers/virtio/virtio_rtc_driver.c       | 1407 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_rtc_internal.h     |  122 +++
 drivers/virtio/virtio_rtc_ptp.c          |  347 ++++++++
 include/linux/virtio_config.h            |    2 +
 include/uapi/linux/virtio_rtc.h          |  237 +++++
 15 files changed, 2707 insertions(+), 36 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c
 create mode 100644 drivers/virtio/virtio_rtc_class.c
 create mode 100644 drivers/virtio/virtio_rtc_driver.c
 create mode 100644 drivers/virtio/virtio_rtc_internal.h
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c
 create mode 100644 include/uapi/linux/virtio_rtc.h

