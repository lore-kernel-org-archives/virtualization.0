Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA833B6E6
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416564; cv=none; b=AABGWiZoH1NWd7vEpVxOWD0N0kAMf3YZMRwEauHcTLjxkzCNelz9Cnq1RCYNSJEl5nXCKIhcaKRO8MGAv213nuDFtfH3Wyb9b3SR9fX/7cw9vNXutAjMj+/4D/7hjRRgKixAR/FinnWnwSc83Wxwwi0mJCadiyrtzkZhnDZCSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416564; c=relaxed/simple;
	bh=kPIwutlaHYRIMwkFfJxglxNcT7ptoTo+B+svMdU9qk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiNMl8JNCeSbTrr0Du17fS6zkxfZcH77nqaCSuoiOMv3kbtxivO50iJ88QfOki2FB0FWsquzZMLA79YyQEkN8vqd1B1kjtg309dUvyUO2nN2nTdhrcbVkJeTY6KJxJGtHJj6zWPmyrGPTK+vPaP6TMXlVi96ePSSBSRlIy+hVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nkl4mhiS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nkl4mhiS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768416558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41EkAV6iOHfW6IoRMF7mDhbBMoIqwfBDSPK0zgIerfs=;
	b=Nkl4mhiSClsFHh+Cjqo71YitGm21ma9vjtTmSrlgdXjBYnjjqnQtyxku8x3TSoKpvOHXFB
	wkDT6i7+lGOVAJxZvlquIjL4h8eWo+qA1tlr6C3RKkQCHACQQvPDTB3sLKTcXSCrQFLloN
	SXQc/A0H9DjPMqX7QHgsdWXgjuVOOjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-qUsWU6d0NiqPX08vkDs3Kg-1; Wed,
 14 Jan 2026 13:49:13 -0500
X-MC-Unique: qUsWU6d0NiqPX08vkDs3Kg-1
X-Mimecast-MFC-AGG-ID: qUsWU6d0NiqPX08vkDs3Kg_1768416552
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59E8818005B8;
	Wed, 14 Jan 2026 18:49:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58A7B19560B4;
	Wed, 14 Jan 2026 18:49:08 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v12 06/13] vhost: forbid change vq groups ASID if DRIVER_OK is set
Date: Wed, 14 Jan 2026 19:48:32 +0100
Message-ID: <20260114184839.926884-7-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-1-eperezma@redhat.com>
References: <20260114184839.926884-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

