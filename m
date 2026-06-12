Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E237D13C
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288111; cv=none; b=hhyuk+a0sfsb1eDb2L0nWNhfm0c3JeXgIwnFojE3sp6BlxpaT2HLnbR6VHO29FYzSgIdSrgIFDwLEAReK6onoRLN5NAClhp8TXOXgnFiQEvTEv4anSbu7qPZl4cmIDyyRRebxDf76rwqY2+SghWJB+azmpHktEqFAJCeDAOhErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288111; c=relaxed/simple;
	bh=SRIS52p+xq7tvizVZ//yZjYOuniZpND73rqmik6/LHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iw5P8Sl0weGfCY8qZcM4aCDqfYWr4XpB1mNYxcvIXoc73UyK8aWIAv9aWlacky1p0XyfdeVkHZlAMqaBPt+O28CDFob6Sfrpk6tD5m3odT8ocUKOyfgw3heeDv9AvUS+YlNsqVubcmmfSJEqDSBEAmO/XozZfELs2X0om6LKgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHvMA0Ia; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHvMA0Ia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781288108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lRINJF6yRKjtHzTN939wmwzi4zwzJJVDBd7VQanQWL4=;
	b=cHvMA0IarXHi8uYLXRZlQohIJK1bbCRAgMT0uPYR3n9TV0EnoSPgQWid9qUNKIPsSd189Q
	mHC6WhvBDpsVOsv+t9Ee6sCqrsTbOmtbT4JEIn3RceDyZPAHBorAUtFnZvdNSt2Hv8XwDN
	tc/ya6F4+zYPsYqho18vi0JbeXdI6C4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-3LxhGjISMsKtV2I1UKIo-w-1; Fri,
 12 Jun 2026 14:15:04 -0400
X-MC-Unique: 3LxhGjISMsKtV2I1UKIo-w-1
X-Mimecast-MFC-AGG-ID: 3LxhGjISMsKtV2I1UKIo-w_1781288103
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A03F3195606F;
	Fri, 12 Jun 2026 18:15:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBC5F30001A1;
	Fri, 12 Jun 2026 18:14:58 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yongji Xie <xieyongji@bytedance.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	Cindy Lu <lulu@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 0/2] vduse: Add suspend
Date: Fri, 12 Jun 2026 20:14:55 +0200
Message-ID: <20260612181457.622955-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: M_tgxfu51291ZFqGe6lOBzMfsI-q1smBEHiulqEk76A_1781288103
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

This series applies on top of e372c4ca7931cadb5cbee1cd9124cfad38fa2391,
replacing all the previous patches.

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

 drivers/vdpa/vdpa_user/vduse_dev.c | 164 +++++++++++++++++++++--------
 include/uapi/linux/vduse.h         |   4 +
 2 files changed, 127 insertions(+), 41 deletions(-)

-- 
2.54.0

