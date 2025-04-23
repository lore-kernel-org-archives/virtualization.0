Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C90267396
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390570; cv=none; b=X7T3tVs8Iw8xF7ELzkye+Yx56lalkV+TZGXgEM55AVvWjfGHiNwC59WT7lzpWnntiGARPha3HND/03h3rzWIh4HdMHomUwxN0ljamNtX2OBgI2Gh+pb8uUIeZ4JFNThRkQtN9+jQuB54gAyRH35wQ86u2t8d/Xw2efyydhTOkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390570; c=relaxed/simple;
	bh=1z9o8ll4AHzFt/k/hmidvON8KqNqYeHpKakhn28WR60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gWnkqGErpHOvfAo8Gj3rs0dHcLS/KHvGgT64Hnv54hM4RlOmb7ouzcO+9R9JpEUo5d7GTbQFXJBdjT5/E75qVetiD4Bbs/VwadHeHFeIQevCexT67KURjnZCDIcIau9Kw2F8ZGPe+t1yHjIckMMT0ThSeTD1V50zZf/79hvBxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKUoYKrM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKUoYKrM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BEA840F7D
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 06:42:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ud5bhgyHH5ib for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Apr 2025 06:42:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3785940AA5
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3785940AA5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GKUoYKrM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3785940AA5
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 06:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745390565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=A+IIFd1CyCLzYQbKkS9qdqGwkTTadepQIc+Dm7g0mP0=;
	b=GKUoYKrM+xf0vIhjWHd2I9iDmIixmuYNAntbcJq87GWTQvkUD7sZTcz20aLEAWF5vskZVi
	w5svPeTVxetcijgLvvhjant5Zb8hJW2TzRHKYHq5EQKsL+7Da80mx7kL+rPiPaBYfPgTa3
	9cdmwKqHferq+tuPoQrCzUY2B7dR5Ug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-bC8qXU9LNbm6uhRhPu508A-1; Wed, 23 Apr 2025 02:42:43 -0400
X-MC-Unique: bC8qXU9LNbm6uhRhPu508A-1
X-Mimecast-MFC-AGG-ID: bC8qXU9LNbm6uhRhPu508A_1745390563
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso241282f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 23:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745390563; x=1745995363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+IIFd1CyCLzYQbKkS9qdqGwkTTadepQIc+Dm7g0mP0=;
        b=XcG1OCeaww4AkZmdwVAHcpxReihesO/CQJja8XQdx95k+kNvmPmq8YdxqPK9T65YH4
         QWhU5SSfwbffkToYR7I/+ZW+ujlmW7jGgbyzL+/N6LUU91oznxIYYJUVjDHqt8TX/kUk
         a1fUgFHNNZmxSRXndI5Sas3yFWNx8kCjoRnh4eZ+BMh18Bb8r2B5bhwtyQpOhKbY5ErR
         Xa8nu9fldteH0Gl+vssI8oPAbWuFf/GG95vb7gU/eRQoLUK/CrsJKsJEQFm8Dzy8IJlt
         9QJcN/3P2sw6V3W24VfJD9aVD2BvqLZ+XAU8zEQ+D4WbAwakUKN4mkAZfP6+WKulj69i
         wcMw==
X-Forwarded-Encrypted: i=1; AJvYcCUw+VsZ+hFZi7wy8+clFCKE9fxJ9e9daZMDeDETnTI3tzHyZSvZdq0SLc4bJ6ZSLAGgKC0wmKznK87MqGPsDA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxIcFb+A8AowZADlvoeJfuLjFBwefpyJIYsnsr4pTQzlu3rUtve
	tZ1ve0YfoxXU99hhu/PeYZuVo3/sJJxbcozUrnemN5IQAlJRN0LPJNyAP8STqO3I+pDJbVtC+xA
	ZpSGgBWOG+zhYDEh+/5zmsQhPwIbjLvf4EeK+RJRxWcT2PdQPQPMsFF+UFxkQ4vTDIcowMx9HHL
	Zud2A=
X-Gm-Gg: ASbGncvdqb2bg9xX9d88zrro4vBZ+YMiy1G5TLR+eANCOa27zzf6R4L7W6UN407AwNM
	6daAgZicr0KdBvcElwu7XgIWh0sQTTlTrtubdGG7C75Wa28Ifjl0ALHxsPA7aUMAhtHLDPWDZWK
	CaoJ0AD4v++5AhrDJiUXgLH1QhjEXRS8ifaMOmzqYWC7SBrM438HYo+AYZeIanTaBRWHaQM3OQM
	gZ81dwpO6ur3umRH/7E0Ab9F275+1E7koWN9o7/+em6fHze8G1ZeEdSVVRH76VEZsKWDqGmFJOA
	m5y4qA==
X-Received: by 2002:a5d:64a4:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3a06723c38cmr1327890f8f.8.1745390562738;
        Tue, 22 Apr 2025 23:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfqF3/DnXpz0jT/bVyus2YqORUpTFcY/LdcHG+U6sJT+ZpWhfo0iR0WXLgcAAw16VAtx6A4g==
X-Received: by 2002:a5d:64a4:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3a06723c38cmr1327865f8f.8.1745390562360;
        Tue, 22 Apr 2025 23:42:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4930f1sm17830202f8f.61.2025.04.22.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 23:42:41 -0700 (PDT)
Date: Wed, 23 Apr 2025 02:42:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	danielj@nvidia.com, dongli.zhang@oracle.com, eauger@redhat.com,
	eric.auger@redhat.com, jasowang@redhat.com, jfalempe@redhat.com,
	maxbr@linux.ibm.com, mst@redhat.com, pasic@linux.ibm.com,
	quic_zhonhan@quicinc.com, sgarzare@redhat.com,
	syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
Subject: [GIT PULL] virtio, vhost: fixes
Message-ID: <20250423024239-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4fXo3Pi8mG2VqX0dqDD_icLpSIhP8nXRZLN8nJnWJbw_1745390563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 58465d86071b61415e25fb054201f61e83d21465:

  vhost-scsi: Fix vhost_scsi_send_status() (2025-04-18 10:08:11 -0400)

----------------------------------------------------------------
virtio, vhost: fixes

A small number of fixes.

virtgpu is exempt from reset shutdown fow now -
	 a more complete fix is in the works
spec compliance fixes in:
	virtio-pci cap commands
	vhost_scsi_send_bad_target
	virtio console resize
missing locking fix in vhost-scsi
virtio ring - a KCSAN false positive fix
VHOST_*_OWNER documentation fix

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Daniel Jurgens (1):
      virtio_pci: Use self group type for cap commands

Dongli Zhang (3):
      vhost-scsi: protect vq->log_used with vq->mutex
      vhost-scsi: Fix vhost_scsi_send_bad_target()
      vhost-scsi: Fix vhost_scsi_send_status()

Halil Pasic (1):
      virtio_console: fix missing byte order handling for cols and rows

Maximilian Immanuel Brandtner (1):
      virtio_console: fix order of fields cols and rows

Michael S. Tsirkin (1):
      virtgpu: don't reset on shutdown

Stefano Garzarella (2):
      vhost: fix VHOST_*_OWNER documentation
      vhost_task: fix vhost_task_create() documentation

Zhongqiu Han (1):
      virtio_ring: Fix data race by tagging event_triggered as racy for KCSAN

 drivers/char/virtio_console.c        |  7 ++--
 drivers/gpu/drm/virtio/virtgpu_drv.c |  9 +++++
 drivers/vhost/scsi.c                 | 74 +++++++++++++++++++++++++++---------
 drivers/virtio/virtio.c              |  6 +++
 drivers/virtio/virtio_pci_modern.c   |  4 +-
 drivers/virtio/virtio_ring.c         |  2 +-
 include/linux/virtio.h               |  3 ++
 include/uapi/linux/vhost.h           |  4 +-
 include/uapi/linux/virtio_pci.h      |  1 +
 kernel/vhost_task.c                  |  2 +-
 10 files changed, 85 insertions(+), 27 deletions(-)

