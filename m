Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D63FBEBB
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185101; cv=none; b=FVe2PTd3hKp1sF1O/vhlaC+stsrAL2r5fsxyCU4o+/45wfXA4nWvImayFKPV5qY19GTB0l+fhNdkp3IKUZCZaefd77zfmyRQzGnr9N6Am8sE7z6eEh5bU8Eznbq70V9r6Vv3CVOKI1uifCcHHbxaR/PPqDayO3G0EAaIWIV9SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185101; c=relaxed/simple;
	bh=jR+U9F+ZVzQNuUXFATO2mqm4H3w9W1LvGTuSLBLl6ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xiwziufk7GE/tvQGvQTY6T/yaOXRF/aIFYfO4ShvNmYT95ixuADnbvyP9R0qCx+pyoErTmBy+15qS3BdfiEeWvk8W8s9GF8+VuFaCyeNPBMu97FPcNx0GC+Faq68TOgZ8DqNOtBd7R1XSVBKZOIn5WeSaysZQ3KaS+mh+qCSHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apXMLvc4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apXMLvc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781185099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r6XmyhZJiDhXMzKbioZAprILIuTOaFvPD+o8MSk9uyE=;
	b=apXMLvc42LqNfKk2foh+lGjyNDeo3iWx9fLk8j+BMbEOq9jhsP3V2tRmZX8XcuyKbZ9m4K
	WaD08j6KlFxK5K6U9/VSsHsN3UWuomuFdTbzqRB0whxr3XiY3ullVGYOdAWDK3GpJG6kKB
	wAe7eMhO1jgjZbpAyCBE/EzXeYpiZDU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-13yhVmwnOye_qzhbiKSE1A-1; Thu,
 11 Jun 2026 09:38:15 -0400
X-MC-Unique: 13yhVmwnOye_qzhbiKSE1A-1
X-Mimecast-MFC-AGG-ID: 13yhVmwnOye_qzhbiKSE1A_1781185093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EC56188EB54;
	Thu, 11 Jun 2026 13:38:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.50.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2367180065F;
	Thu, 11 Jun 2026 13:38:07 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: [PATCH 0/2] Fix lock errors in VDUSE suspend feature
Date: Thu, 11 Jun 2026 15:38:04 +0200
Message-ID: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: OHBScVuV7qRA4LEBhA1XslTmpQopofBegBrwDCZmB9Q_1781185093
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fix wrong ordering at taking semaphore after spinlock and convert the spinlock
take and release into guards, so they are not lost after a return.

This series goes on top of https://lore.kernel.org/lkml/20260610083452.477759-1-eperezma@redhat.com/
---
It would be great if these can be squashed.

Eugenio Pérez (2):
  vduse: fix not releasing taken semaphore in vduse_dev_queue_irq_work
  vduse: not take the device semaphore while holding vq spinlock

 drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--
2.54.0

