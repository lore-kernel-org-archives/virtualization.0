Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E42F2606
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Dec 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706054; cv=none; b=FqTAnnMiCDF6re1DS3Nz0EgXDMA7DmMg/KfgjtS4XJq/JbjA4WoAa/hwQ64XBBbIAu8SRNf8QUjjGsOqA3UNbU4aWccQpr8uj7d0RfzXpQ1Gdi9EyM3HvOFhJp7IHlyAsNB3F9nwQZT1dI1O76mM1nq21v3jaoXI1OIEpoUy17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706054; c=relaxed/simple;
	bh=oPYqW5SQfExXpPRUP0ZxO9mJN6N4rIx6CnioC/GrhKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tz2PIj0UCzJH0oHQk4FrDeghHpvyj9rs8A5Sere+72CKMg0kP9x+RNeiqvDdhpfL9OtP0C0xUA95SOqSHqiZNeP9u5wrgEx5RNuFb28375NTiv+fRE6qjDWLpXBlGlgdMkwpywt3fxuS/nPzMbymvoQ2spc+JjjTkswkbCmEM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOINmmaR; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOINmmaR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1441183F8A
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Dec 2025 20:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVJVxb_Kvl8k for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Dec 2025 20:07:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F0BD883E77
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0BD883E77
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KOINmmaR
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F0BD883E77
	for <virtualization@lists.linux-foundation.org>; Tue,  2 Dec 2025 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764706050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4LOaJkYRfgWql4tAMEDx+EG8hV3Vr+6Q+ye5vso+PWc=;
	b=KOINmmaR4b/maDXPwuMm5yMJbVhH5MOv/I+uZ9piEODPkx1HfG7cErme5Az8CPjBryznMa
	Pv9oZlSJhRDEbPCprTJ6fpgqzRaTf55b9c9ld5nVnfYcN8pR13KN09hE0L8bl4XnNWDP8l
	ZAGw2kbhsvgwtE+kqK+bVyc47Br/JYw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-iFJlBmmvMb6IWY4SSBnOnQ-1; Tue, 02 Dec 2025 15:07:26 -0500
X-MC-Unique: iFJlBmmvMb6IWY4SSBnOnQ-1
X-Mimecast-MFC-AGG-ID: iFJlBmmvMb6IWY4SSBnOnQ_1764706045
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so33854575e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 02 Dec 2025 12:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706045; x=1765310845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LOaJkYRfgWql4tAMEDx+EG8hV3Vr+6Q+ye5vso+PWc=;
        b=DzNBrsFdaqwHKqTjaqBK0DzUv/8sci+x2cP1eieJwivaRtaOMYnR44LGZjIyjvk8S/
         OTGJgzevmSHR0w7c+65rgXQHQce8OZ3q/RR8ugyzQOMM0smvBhzw4joF32iZx7BZy1rA
         T0xlIGgr/Gh8uoTx/A9PPmV2arh0Ne0FgcksnIbHmJd86dVMRSqsjy2uodLpRirn/KJA
         I1lwsOGmriJ9deSEPtQNC2Pq8lcsKjSLMJQZOnMuT7bMhZqVijBCJVAesKuy/23pBt2y
         qiql2YkUxlZ4QclBnGOwCOTBkuX1kcyP+BDqmkXmCQ3q++LCh3hUToCO49nJqgeIqT44
         RorQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfNIHwKb63Wh5bo301pxGcYx9L6wteXAJ8lgS8hkqbvP/5ezi+thbjM8YHi5aM0eu62TmxhBKlTITaEnffBw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YztLqeD315JXcbh8ZSEjJOCJIOhGtLdnhpom+Puxl/Vb8qfylLN
	TKT26EMKpkSJzwMJIAabE2oMYjxD4ZlC1WkyZ+Hafw5WsbCCvNgSlloTm8GweDX4y9yFjNlrtcs
	9mMiH5D/mi7sDnlDNrJcMGCKgqCojZkPsADAjgXLCmEk5VGtTujkeECiVgXU8NQ9Y59/duWdL8I
	ei29v/u0g=
X-Gm-Gg: ASbGncsQ4h0deOGjF121A9+jGkBQtLbKw/FsJRaFLbdD7YWWOGjMiEQg6aTOpVVYkFo
	BYOM3YQ09KYF7BhSpbfgL02KpGz3YVuLSBVpn0gMKFDvxEPsrq7ISABH7l4hCzSSDU3F/Eu2PhW
	Jl65pKaymSHfmJNsdulV2QaPIHAx1TbQ/UZzCVHJ8gUV33Qv+2zrAqPKXAsYGMrqBrxF87smekK
	EoDBraOUBOZlbMNZV62j8LzWi4Hxx6lBPLrtada/y/K43CwRezLsQS87T0V7UNKMYU63trs7uvs
	veEYJsizl1f6TRpn3atrmgMIBm+5/YGhmU/b1KmkWE5PhC4Fo738BiHqgpvK12kH1No+fy+8ng7
	PaL5wZh5U8O5Ht2bbgiOfGTKXWc3rfNGM
X-Received: by 2002:a05:600c:5249:b0:477:9d54:58d7 with SMTP id 5b1f17b1804b1-4792a4aac08mr9281235e9.29.1764706045302;
        Tue, 02 Dec 2025 12:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/agkXQ9hhx2CuGFlZ3EgTBLncuqp3bFvjDrGsXOBisReyUeJGrkEIqlYMZDfX1+cLbK1Uhw==
X-Received: by 2002:a05:600c:5249:b0:477:9d54:58d7 with SMTP id 5b1f17b1804b1-4792a4aac08mr9280895e9.29.1764706044801;
        Tue, 02 Dec 2025 12:07:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a8c5fdesm5614095e9.10.2025.12.02.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 12:07:24 -0800 (PST)
Date: Tue, 2 Dec 2025 15:07:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com, alok.a.tiwari@oracle.com,
	jasowang@redhat.com, kriish.sharma2006@gmail.com,
	linmq006@gmail.com, marco.crivellari@suse.com,
	michael.christie@oracle.com, mst@redhat.com, pabeni@redhat.com,
	stable@vger.kernel.org, yishaih@nvidia.com
Subject: [GIT PULL] virtio,vhost: fixes, cleanups
Message-ID: <20251202150721-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xOSMng_06RfODvjCFiaD8PFAbnq2ESkbOypnMBPjxrI_1764706045
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

get_user/put_user change didn't spend time in next and
seems a bit too risky to rush. I'm keeping it in my tree
and we'll get it in the next cycle.


The following changes since commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d:

  Linux 6.18-rc7 (2025-11-23 14:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 205dd7a5d6ad6f4c8e8fcd3c3b95a7c0e7067fee:

  virtio_pci: drop kernel.h (2025-11-30 18:02:43 -0500)

----------------------------------------------------------------
virtio,vhost: fixes, cleanups

Just a bunch of fixes and cleanups, mostly very simple. Several
features are merged through net-next this time around.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (3):
      virtio_vdpa: fix misleading return in void function
      vdpa/mlx5: Fix incorrect error code reporting in query_virtqueues
      vdpa/pds: use %pe for ERR_PTR() in event handler registration

Kriish Sharma (1):
      virtio: fix kernel-doc for mapping/free_coherent functions

Marco Crivellari (2):
      virtio_balloon: add WQ_PERCPU to alloc_workqueue users
      vduse: add WQ_PERCPU to alloc_workqueue users

Miaoqian Lin (1):
      virtio: vdpa: Fix reference count leak in octep_sriov_enable()

Michael S. Tsirkin (11):
      virtio: fix typo in virtio_device_ready() comment
      virtio: fix whitespace in virtio_config_ops
      virtio: fix grammar in virtio_queue_info docs
      virtio: fix grammar in virtio_map_ops docs
      virtio: standardize Returns documentation style
      virtio: fix virtqueue_set_affinity() docs
      virtio: fix map ops comment
      virtio: clean up features qword/dword terms
      vhost/test: add test specific macro for features
      vhost: switch to arrays of feature bits
      virtio_pci: drop kernel.h

Mike Christie (1):
      vhost: Fix kthread worker cgroup failure handling

 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  1 +
 drivers/vdpa/pds/vdpa_dev.c              |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  3 ++-
 drivers/vhost/net.c                      | 29 +++++++++++-----------
 drivers/vhost/scsi.c                     |  9 ++++---
 drivers/vhost/test.c                     | 10 ++++++--
 drivers/vhost/vhost.c                    |  4 ++-
 drivers/vhost/vhost.h                    | 42 ++++++++++++++++++++++++++------
 drivers/vhost/vsock.c                    | 10 +++++---
 drivers/virtio/virtio.c                  | 12 ++++-----
 drivers/virtio/virtio_balloon.c          |  3 ++-
 drivers/virtio/virtio_debug.c            | 10 ++++----
 drivers/virtio/virtio_pci_modern_dev.c   |  6 ++---
 drivers/virtio/virtio_ring.c             |  7 +++---
 drivers/virtio/virtio_vdpa.c             |  2 +-
 include/linux/virtio.h                   |  2 +-
 include/linux/virtio_config.h            | 24 +++++++++---------
 include/linux/virtio_features.h          | 29 +++++++++++-----------
 include/linux/virtio_pci_modern.h        |  8 +++---
 include/uapi/linux/virtio_pci.h          |  2 +-
 21 files changed, 131 insertions(+), 86 deletions(-)

