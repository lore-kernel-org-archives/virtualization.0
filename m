Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C31DA60C
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316332; cv=none; b=Z9WnADLyh6jCQAkPwe9K9Cdu5Bx/FbqtyRh51GCYXWw2F3a3MNj1PK5ce4fdOZc4Bg1kHp6d1ieglConJ545Wf8g3fh/PG7873HgzGud3jfAsX8GU2lnnGLwy9fJPXwygiYQP9NXbjjE0VpwNuJrsIF/0bGjCzuKngk06nlHNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316332; c=relaxed/simple;
	bh=/EZ8uL9G3hFtdF20Zk/ubx5oExJilk/BwdV79vc3cnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GDGHVuqH3zfDPMwFPze1J5ziOJ6G4hTRNjBHq1JuBJvh4dgCH9BzZ22kX3PkhfWCWYVtdrMEBpfR64CrLrM7QHICzJ16u73K2IO/3R5VPhQj24iViM0eCTlKwCQ74AMDfcWMfLxHHTKBdeqE6WklBM3u8u3BVGU6NsmKKxSqTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iK2jr46c; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iK2jr46c"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 396D980E47
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 15:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xD8xHvlNI9Og for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Oct 2024 15:52:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4865580E44
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4865580E44
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iK2jr46c
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4865580E44
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728316328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=G9TXcvGmMkyb4Jec0+mQTLksqLLOXrKvoY/7ZxCB8eE=;
	b=iK2jr46c66IlEquwdeV+lQ4MlxoRUshrU3wNzfYsH1PotQImCJ9+7+L02gsWcYzXuWP0QS
	NoN2VqlJwpNr3vPQqUYzFidfrtSF8yQRy9Jrre7R+vwGE+ORCr6rfHD4RCvFzR7VIw8H2o
	vdSdP6U5g5NZuX2bCrp7Kkm26fUvrn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-KHIjKmD6NS6AipvyIlUJXA-1; Mon, 07 Oct 2024 11:52:05 -0400
X-MC-Unique: KHIjKmD6NS6AipvyIlUJXA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb808e9fcso29454415e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 08:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316324; x=1728921124;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9TXcvGmMkyb4Jec0+mQTLksqLLOXrKvoY/7ZxCB8eE=;
        b=N8pBGR80hv+Ixtxm2NW916SAaCz60eSz6MXXFG70U3tb9cD2qJSOGTQovSua4C8hwv
         B2cn/gQce4kMSRTkQ/O5GkZKwnUzPtGJH4v3s75+2jX8UAkqNCwUdeCRUA8pZo3EVyL/
         y3u0KImK7TubEjuGuIFbkVFhRaiWLzRlPApu65Y3X5c09rtexpYEcBow5Gl2FLRZQw48
         u/dlr/Z7NAwQuD+6wH61Ni+9X1Yby+RovPx+qHB/A3CfgSSdAGhH+LyLNWkj6M9NDAgC
         9lg4D18dHWlvI9REUCgsg1bkI+Ju9hR0tuBvuaKFW04VAE8wzXoF3nUntm2IzBqkF6gT
         0iag==
X-Forwarded-Encrypted: i=1; AJvYcCUe7TOkia8GLbyRcZzTrEs+F7NNQge2ZrOhmwnKFDxHMWoKYiUrzIwkmC5uBhcAoo+c7Mr8iPsYUqmrggL4sg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzNWlJn3sAo2n04rfWazMRviqxYPNVHSGi+029zHQg7W0qfy0c8
	+KbnMeTksp15DtSPyRy+B3WDFBP86+YmlsQInd0RkUxzs2R3WNydfInCMHydJJCNFGL6qNt6YKI
	IQf4efkyXQ3ayfhsSQx4jN7l7GYCfEmP3fDG80IBEq8UVlGttnOQim1HW003N27jRzt6f0R6+IT
	9Gqpo=
X-Received: by 2002:a05:600c:350c:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-42f85aa1a76mr80142135e9.2.1728316323911;
        Mon, 07 Oct 2024 08:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6www5QFkt0BJe4rLwpAGtQvp+gL9TCRDjcvZWpHi7aBIelswHzZJHbt+bvyCApLkp6Y2R5Q==
X-Received: by 2002:a05:600c:350c:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-42f85aa1a76mr80141915e9.2.1728316323509;
        Mon, 07 Oct 2024 08:52:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:8906:45ec:feb4:98e4:6184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d7aasm95666195e9.27.2024.10.07.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:52:03 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:51:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, dan.carpenter@linaro.org, elver@google.com,
	jasowang@redhat.com, lkp@intel.com, luigi.leonardi@outlook.com,
	michael.christie@oracle.com, mst@redhat.com, schalla@marvell.com,
	sgarzare@redhat.com,
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com,
	wh1sper@zju.edu.cn
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20241007115158-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit efcd71af38be403fa52223092f79ada446e121ba:

  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-25 07:07:44 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 221af82f606d928ccef19a16d35633c63026f1be:

  vhost/scsi: null-ptr-dereference in vhost_scsi_get_req() (2024-10-07 11:47:56 -0400)

----------------------------------------------------------------
virtio: bugfixes

Several small bugfixes all over the place.
Most notably, fixes the vsock allocation with GFP_KERNEL in atomic
context, which has been triggering warnings for lots of testers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Haoran Zhang (1):
      vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Michael S. Tsirkin (3):
      virtio_ring: tag event_triggered as racy for KCSAN
      virtio_console: fix misc probe bugs
      vsock/virtio: use GFP_ATOMIC under RCU read lock

Srujana Challa (1):
      vdpa/octeon_ep: Fix format specifier for pointers in debug messages

 drivers/char/virtio_console.c          | 18 ++++++++++--------
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 12 ++++++------
 drivers/vhost/scsi.c                   | 25 ++++++++++++++-----------
 drivers/virtio/virtio_ring.c           |  2 +-
 net/vmw_vsock/virtio_transport.c       |  8 ++++----
 5 files changed, 35 insertions(+), 30 deletions(-)

