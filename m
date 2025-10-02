Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3492FF66A
	for <virtualization@lists.linux.dev>; Thu,  2 Oct 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401354; cv=none; b=nw5zkuRwT6gD7e04kdI29ygfAw3Iudk1L9MgYt2NFEwEO2+79tr/L1IzFUSfLHPCBo3SZRB6umf7n4FZheYEhpo2GfCzsiukIiAwwtIJqM0r00tYEPs8co7Rd5zIcEJAY4EX//HKQamxnRtMaLx5G5fnVwolVfJuHN2Hjz0Ko2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401354; c=relaxed/simple;
	bh=R3kcVoNm8AxvW6p+I+oQs0JRBi7GG8nm9/kcEGO0Dik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eSKmjhK88K3zUkXAgFFTYiEPDyGcs2Gq1/0zEKMMReM8ixKm52IhBhcDlNbpmzfUK5H4Xs3eizAXyAnHKyiEOhKiPQKpZq8Q7uBdNpLpDTppmpNEcEbEzr+L+xId58DUf5XoqugSrdCSRYRUgmDXZRb22J2UatOH7ql07SRvBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fyib+f7f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fyib+f7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759401351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UKUts6XcuzPI8ux1sN1ppRT2CxL0Ox4R/rL5JBmAnyI=;
	b=Fyib+f7fb+75yhW0zIkG690c5Ci7UZbKLfn/vsSKf6poA+xVY78FJ1ZOl/cjOFNH0TSkzl
	82fbKtErtALYdRvwUkoLWs76ysUt6OmfbE2yovnfnAlPiRTzor+C0e+esh8DBejbmF343k
	c7385QkJOB1gpx7S5IGfk4S1BcP2N3I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-o4AnDlCfPiye51Arzr9FGg-1; Thu,
 02 Oct 2025 06:35:48 -0400
X-MC-Unique: o4AnDlCfPiye51Arzr9FGg-1
X-Mimecast-MFC-AGG-ID: o4AnDlCfPiye51Arzr9FGg_1759401347
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8245F195605B;
	Thu,  2 Oct 2025 10:35:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.208])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 664CC300018D;
	Thu,  2 Oct 2025 10:35:40 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>,
	Cindy Lu <lulu@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Jonah Palmer <jonah.palmer@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Be=C3=B1at=20Gartzia=20Arruabarrena?= <bgartzia@redhat.com>
Subject: [RFC 0/2] support vduse feature provisioning in vdpa netlink command
Date: Thu,  2 Oct 2025 12:35:35 +0200
Message-ID: <20251002103537.308717-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series implements features provisioning for vduse devices.  This allows
the device provisioner to clear the features exposed by the userland device, so
the driver never see them.  The intended use case is to provision more than one
different device with the same feature set, allowing live migration between
them.

The device addition validates the provisioned features to be a subset of the
parent features, as the rest of the backends.

Eugenio Pérez (2):
  vduse: support feature provisioning
  vduse: allow to specify device-specific features if it's multiclass

 drivers/vdpa/vdpa.c                |  9 ---------
 drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++++++++++---
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.51.0

