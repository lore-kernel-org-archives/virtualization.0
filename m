Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B1379987
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563792; cv=none; b=uAE3MZXOn0/IdkG1nn3mCDgozGA7hm9R9KmHg42GLWPIJezlkAapCYXs8FE6vSB8/RtjBSQaLcLf3Qzp7khnUqRGDdVznKmXOM8T0aDqsV6jqnn2gv6B2QE7C/0ARPz2GRaxre+h7jtO3xvcaaNFa17OccSThaeWIHBmL/Es0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563792; c=relaxed/simple;
	bh=kPIwutlaHYRIMwkFfJxglxNcT7ptoTo+B+svMdU9qk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Alr7Q3sCwR3azkuOlE68gUjE7PJYeBC7qEJv+2pz87d+Yw0I1lgP3c38cSjyE7BLRR8B5S5cR3paoKLfrdPHcQGjN98FsU9OX2Qy7HYxLZqN0Kzjl+Fq6uptVH44LGtKacGe+jtnJzS0SzfJfIfN0r+dqF/W40EIfSZw13+O6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2LJOQEB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2LJOQEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768563790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41EkAV6iOHfW6IoRMF7mDhbBMoIqwfBDSPK0zgIerfs=;
	b=A2LJOQEBy5bmWpV8S3N/1io1KizTrRmIyzf26eeCdsgXpCvtmejCP+9fKGXMJLVK/Oxxay
	WcnNl16ZQaoZavbbOh6aFY4zwK3McSwy+p0q6XKyMAEHKI32yoERCpgFt+BvbdpAsOxx7q
	sQKYwM9D1j/0w1sHpHQcRe05lp96C5I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-ZQ_9e5J3Ne-wqJ6zE3xjBw-1; Fri,
 16 Jan 2026 06:43:07 -0500
X-MC-Unique: ZQ_9e5J3Ne-wqJ6zE3xjBw-1
X-Mimecast-MFC-AGG-ID: ZQ_9e5J3Ne-wqJ6zE3xjBw_1768563786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E84CE19560A1;
	Fri, 16 Jan 2026 11:43:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31DB11801ACF;
	Fri, 16 Jan 2026 11:43:01 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	jasowang@redhat.com
Subject: [PATCH v13 06/13] vhost: forbid change vq groups ASID if DRIVER_OK is set
Date: Fri, 16 Jan 2026 12:42:24 +0100
Message-ID: <20260116114231.1474306-7-eperezma@redhat.com>
In-Reply-To: <20260116114231.1474306-1-eperezma@redhat.com>
References: <20260116114231.1474306-1-eperezma@redhat.com>
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

