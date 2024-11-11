Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C233199939
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333097; cv=none; b=jdLoIpTLt/I0RKze8M6dOjdmAfc8nAqgmooEp49F8X6P/GlENG1naAzsUpO1J3GVhtI5SGH8+cO+gxzOYjpyH3CCn8ykhU9kqjZEzjgwvvQohiyEOLRcONOjKMv4YhSzy19a8Y5+ckXKDP8KyQeDz4emDwx7BZY5svvZ8Qpv7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333097; c=relaxed/simple;
	bh=Czawgg0eHQCiBa/n9H4yWNVg6iyINBKzS2rt+c5jO0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j4IXozmJeScIBarvAn2VaWaQ/HoTx64m3u+bCTTX5cGklfkieXdHSWUIB98hJxCqCck5zHBOgdYIpdLLcO0xc29NWlSxFk4/j/MgSBtz00LcCuJWRXYqjOVHqKyxNDjM3jdSrCnQKkAN7ge9HstoV8uNHptTte3PQ3h+zky27DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHKzzv/p; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHKzzv/p"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 168294024D
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 13:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwyMlknOm6hQ for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Nov 2024 13:51:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 45AAA400D6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45AAA400D6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHKzzv/p
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45AAA400D6
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731333091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SDgcf2zjsNemccSJG3/V1OaS/z5L3BgNHfGxAIvuYes=;
	b=bHKzzv/p9EgPBx1pBGbH7C31N4WXJVm+iubb4X2y3d+p4CDoUQZfrf45UuQNZ5e2/f4gmd
	KTg6pTHzupA1MQWGKnhNagpo21k8SpdCCQ9q7d+P+6Az4dZtzN1Rdp8mEPRTCl07JjoieJ
	R2dkraxbvHEWSaf/nY+lfr/TBqpYr04=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-H8LtLpcgOZagN5Q16TIqSA-1; Mon, 11 Nov 2024 08:51:24 -0500
X-MC-Unique: H8LtLpcgOZagN5Q16TIqSA-1
X-Mimecast-MFC-AGG-ID: H8LtLpcgOZagN5Q16TIqSA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315af466d9so32175495e9.3
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 05:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333084; x=1731937884;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDgcf2zjsNemccSJG3/V1OaS/z5L3BgNHfGxAIvuYes=;
        b=sx54XdHPidFSBSspKqZt54DjV8YzEov8FGhicQwSVtfOk9BXwZh0cWUZyHlpS91Q1V
         tQXRXHo6/W0hGLgtZt98jTT3uTNGxz4Kt2tcrfU/mOHGub04t750zSyK1VBsNOZVqJc/
         mtPehDBAuhgV9GGHGUl1f6ehXTeynt/Qv0iuG48XY1rLCYU3jE/aIrHaM6+aWnQE353V
         mIqxkKLsJFZQFhWXQVq0SiRZvnfNva+NruuWGnLXtRAKGCMEeqsB7sacuNMkck7Mfp6N
         q2nVVWz/Kdy6NMZGTlXJeLPZUjH2r+fMqQFX0CJFWeWYPrtJXphdFA/dzOHR2tmFw5wX
         XxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6KQfbBGnlJJxDnXzD1VcGWsFUdYOD3TZcNf8FH639M5bTqUi6x0XTdtnVodW9f8IOpawee1bLxXee0WPjBw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxdSmLjnMD3j4PS3h/pneYsgd2fDn7dXRj9cb1XKkU4OdhpHGJs
	IV9p/tjhV0eyByLpxPW6qYEUluSlJWwaxKrgi4Q8hzRjmskD1EAjh8KkI2EJYNHlDVHOZvUdsgP
	1J2rzzWeH2UrCrc/wWVWnvPmUdPm1RimhT3OkVEjweIU6Xl8LGhebBUp4k+zYce1YWc0A8YfmDq
	5a+iw=
X-Received: by 2002:a05:600c:524d:b0:431:5465:807b with SMTP id 5b1f17b1804b1-432b751dcc3mr97623555e9.32.1731333083662;
        Mon, 11 Nov 2024 05:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdl1MVOk6cXvoplWf4kpAyP0Q0PfmfJirwFRy6M9tNvfOSuKn0TM0JJ3TMSOe/6ZyakDUOBA==
X-Received: by 2002:a05:600c:524d:b0:431:5465:807b with SMTP id 5b1f17b1804b1-432b751dcc3mr97611965e9.32.1731333055694;
        Mon, 11 Nov 2024 05:50:55 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:7c39:766b:279:9fac:c5c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bc468d94sm68340235e9.0.2024.11.11.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 05:50:54 -0800 (PST)
Date: Mon, 11 Nov 2024 08:50:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com, christophe.jaillet@wanadoo.fr,
	cvam0000@gmail.com, dtatulea@nvidia.com, eperezma@redhat.com,
	feliu@nvidia.com, gregkh@linuxfoundation.org, jasowang@redhat.com,
	jiri@nvidia.com, lege.wang@jaguarmicro.com, lingshan.zhu@kernel.org,
	mst@redhat.com, pstanner@redhat.com, qwerty@theori.io,
	v4bel@theori.io, yuancan@huawei.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20241111085050-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ArAgCAfKXNOWfVR7QiRZ4m0SNWvqff4dhVi6yYVLpE4_1731333084
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 83e445e64f48bdae3f25013e788fcf592f142576:

  vdpa/mlx5: Fix error path during device add (2024-11-07 16:51:16 -0500)

----------------------------------------------------------------
virtio: bugfixes

Several small bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dragos Tatulea (1):
      vdpa/mlx5: Fix error path during device add

Feng Liu (1):
      virtio_pci: Fix admin vq cleanup by using correct info pointer

Hyunwoo Kim (1):
      vsock/virtio: Initialization of the dangling pointer occurring in vsk->trans

Philipp Stanner (1):
      vdpa: solidrun: Fix UB bug with devres

Shivam Chaudhary (1):
      Fix typo in vringh_test.c

Xiaoguang Wang (1):
      vp_vdpa: fix id_table array not null terminated error

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling

 drivers/vdpa/ifcvf/ifcvf_base.c         |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c       | 21 +++++----------------
 drivers/vdpa/solidrun/snet_main.c       | 14 ++++++++++----
 drivers/vdpa/virtio_pci/vp_vdpa.c       | 10 +++++++---
 drivers/virtio/virtio_pci_common.c      | 24 ++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h      |  1 +
 drivers/virtio/virtio_pci_modern.c      | 12 +-----------
 net/vmw_vsock/virtio_transport_common.c |  1 +
 tools/virtio/vringh_test.c              |  2 +-
 9 files changed, 45 insertions(+), 42 deletions(-)

