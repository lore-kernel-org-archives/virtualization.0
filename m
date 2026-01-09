Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312436404A
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972310; cv=none; b=Wa95I/2v+9wxLmom0EmvsG9VTpylXs91plNVfTyplxO/BRny8OCRBYFrdoWpoDS1eRXhVJN9oeOPkVzPk/lcX8nG1Lxmpx48HXppucVsXQwhoPrByHcsecXZ2FtftBmX+U0G2eoKU4EltbJaAj6OL6Z4XXwm1+VkTDZ79AczdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972310; c=relaxed/simple;
	bh=YThuG0JsB01OnDevlOWp+Tu62J3f3NWsb/0cacuOvGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4957OsYKWxjZvg2Mm9fMonRri76WdQucIxFsqurmkU8w7jzTzgFwIY/bss7serOJOFHt+74rQC3WtZVbCJhyXGnUWDQ4IahmydFBpAGvEIEWoyAuYmEwQc2EAFSH6A72FQ0A/rSqgj2a9Mo94R8sfBXVHK+wt9L0iQkTnbWE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtYhSmtH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtYhSmtH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767972308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQwTOq0UWbi2hcfKjCFHsey9lhPdgHZ+VxM4pEXg1vs=;
	b=dtYhSmtHnRFCi+IBR5rUZJLgSacpO3H2TQujRDL1Jj0O5N5KVCHsg6Get4nR1hGI0fQIuP
	TlA4wqz+imKD3vrE4ksJjvPSC+vD/0UiVIR9RKPt6QEEJJBXRjjTF9+GrGFRiGBojy0ror
	HXErgpTYNiCeRbZEwz+aMBQEfMSf7Es=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-cHBlskl_MWqWc8kKnyiaBw-1; Fri,
 09 Jan 2026 10:25:05 -0500
X-MC-Unique: cHBlskl_MWqWc8kKnyiaBw-1
X-Mimecast-MFC-AGG-ID: cHBlskl_MWqWc8kKnyiaBw_1767972303
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C737F18002C8;
	Fri,  9 Jan 2026 15:25:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52DED1954199;
	Fri,  9 Jan 2026 15:24:59 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v11 06/12] vhost: forbid change vq groups ASID if DRIVER_OK is set
Date: Fri,  9 Jan 2026 16:24:24 +0100
Message-ID: <20260109152430.512923-7-eperezma@redhat.com>
In-Reply-To: <20260109152430.512923-1-eperezma@redhat.com>
References: <20260109152430.512923-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Only vdpa_sim support it.  Forbid this behavious as there is no use for
it right now, we can always enable it in the future with a feature flag.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
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

