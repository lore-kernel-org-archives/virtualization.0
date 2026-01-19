Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB723185D
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833221; cv=none; b=fBCW8QY1s+CDfmIAvUAUio2IAE6VPK8Yt62cUr6y/v6C6tozJmDpMxCBNblWeDFJdrBSxUmoRSeq9H+Y7mItqCTq85R6Q/2p7qS+deWfy6EuDXu39v56fXhtUJrFuP82pK1m6G0nI9olAOpoAVWfYx1EaUFAIqxnwoDs3McxjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833221; c=relaxed/simple;
	bh=RTbGQMeS3TGwfkL0TUsU4PKOT1MwFgKm80XeeFGh0Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHcO+ETsJDmkR8LFkpYmQ4WHgR5C1VtcFrxLCni7+dIXDv+zLihDh1Fay0vuE4X6Z3C/j2vd0q30YgS7UJhFXttX4cy+A488isZMd0lJGSFzIaIdrEYOBnP2ud3mZwr8b1vuUNquEpHIiSLseFFzTIzKTQDXDU9qIRj0Njc6EEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWSfVRjS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWSfVRjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768833218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t45TFxqr8WLK9tsMFvmjqb5HYGHWI8QhdKDpDAmNJlY=;
	b=gWSfVRjS9AU4IDdfghcIZo46oNlnJ2RiI5/LIjMt4mD+RtveKTBtkM6IIuwCly2i9OOmpG
	k+G0GQz/UXRQIGfSvNRgo/Ul8/o/7jVo01KVFXlctcAJ+h5lG+CPq6bPxOFyO3kmBeMYDV
	jBsaQigh19k457vWFglfjKQdHebrH60=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-F4Rw9Rv5O_WG3uemhIEpRQ-1; Mon,
 19 Jan 2026 09:33:37 -0500
X-MC-Unique: F4Rw9Rv5O_WG3uemhIEpRQ-1
X-Mimecast-MFC-AGG-ID: F4Rw9Rv5O_WG3uemhIEpRQ_1768833216
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63BC7180060F;
	Mon, 19 Jan 2026 14:33:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA9B31800577;
	Mon, 19 Jan 2026 14:33:32 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	jasowang@redhat.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 06/13] vhost: forbid change vq groups ASID if DRIVER_OK is set
Date: Mon, 19 Jan 2026 15:32:59 +0100
Message-ID: <20260119143306.1818855-7-eperezma@redhat.com>
In-Reply-To: <20260119143306.1818855-1-eperezma@redhat.com>
References: <20260119143306.1818855-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Only vdpa_sim support it.  Forbid this behaviour as there is no use for
it right now, we can always enable it in the future with a feature flag.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v12: Fix typo in patch message (MST).
---
 drivers/vhost/vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9d25b735b43d..3f0184d42075 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -682,6 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			return -EFAULT;
 		if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
 			return -EINVAL;
+		if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
+			return -EBUSY;
 		if (!ops->set_group_asid)
 			return -EOPNOTSUPP;
 		return ops->set_group_asid(vdpa, idx, s.num);
-- 
2.52.0

