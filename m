Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2343D891D
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427637; cv=none; b=WGOulRZqhVIV6nTSPcnJSnOzQ4Js4A5gCQCKHv1+yd1/MwHcfUxp8qVMZo3VRaCclEIvmofoBkriTn/mxwXVxlnWExPq5Wut40ViVQVIJMASGKKVdJW4NspAB0enuix6j4PLp8T1dPdL4N07BTHXVxScrEPTFDp+1uH16EeF5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427637; c=relaxed/simple;
	bh=frcDkOsxhbHisKGWmmnIOcV+b/dOEogx3aeFK8YONhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tz9lNwNwwzS3SRwAJdnJ1k/GZdrEG/Mzazw2MB4HAR0SsGSs0+2ZTlfaBRCYuAnSKy8sRjk5LowgN6sAgkDwlRSvLjEW3M6HwHSuyCvLtzXr9Ddbnj1Kc2rx9X2vNahLhKSpDnukQ4tWaBmA7XmuXTwYYjzjmfy4gB8pjKYlcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dob2pSvi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dob2pSvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783427634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WNDlYe3DBFErpBps9r0/FtQimGlUQU3DMWQMXJd05T4=;
	b=Dob2pSviKUF6YnFJIU3ztt8LEuaNUmSnmSubvFYwVndFeIhVNc6yc1xyIJmgX4OxmV9DV8
	NybOkWNgp4qwbnZOKP8g0jSQW2fz/igk1D567qJ69gwxGFO8jzanBJrHZivwvGMHF/oXVQ
	6ACrPiH+IXsJQibhsfkadF7dxUg5Des=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-UE-cixJUP8aCTD-hTOwuDg-1; Tue,
 07 Jul 2026 08:33:51 -0400
X-MC-Unique: UE-cixJUP8aCTD-hTOwuDg-1
X-Mimecast-MFC-AGG-ID: UE-cixJUP8aCTD-hTOwuDg_1783427630
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243CA1806C80;
	Tue,  7 Jul 2026 12:33:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8543E3691B;
	Tue,  7 Jul 2026 12:33:46 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	linux-kernel@vger.kernel.org,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH v5 0/2] vduse: Add suspend
Date: Tue,  7 Jul 2026 14:33:42 +0200
Message-ID: <20260707123344.244575-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: EUdStHPwB3x7YOoU-eTpFH5bu1Nf6M3BsCaVYlGwobA_1783427630
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Implement suspend operation for vduse devices, so vhost-vdpa will offer
that backend feature and userspace can effectively suspend the device.

This is a must before get virtqueue indexes (base) for live migration,
since the device could modify them after userland gets them.

This patch does not implement resume, so VMM resets the whole device
to recover from a live migration failure.  Resume optimization can be
implemented on top of these patches, as other vDPA devices have done in
the past.

This series applies on top of
https://lore.kernel.org/lkml/20260707122502.239022-1-eperezma@redhat.com/

v5:
* Rebase on latest enable series

v4:
* Add preparatory patch to not flush the kick and irq works under rwsem
  (MST).
* Fix jump over a semaphore guard (Nathan Chancellor).
* Fix take the device semaphore in the vq spinlock context (MST).
* Add suspend guard at vq_signal_irqfd so the device will not send an
  IRQ after suspend.

v3:
* Expand the patch message with information about resume operation.

v2:
* Take the rwsem only before the actual kick, not in vduse_vdpa_kick_vq.
  This assures that we're not in a critical section.

Eugenio Pérez (2):
  vduse: do not take rwsem at reset work flush
  vduse: Add suspend

 drivers/vdpa/vdpa_user/vduse_dev.c | 162 ++++++++++++++++++++++-------
 include/uapi/linux/vduse.h         |   4 +
 2 files changed, 127 insertions(+), 39 deletions(-)

-- 
2.55.0

