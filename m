Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E332147F0
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563533; cv=none; b=P3TDVMSnnN4iUgCPEhDQEXPPr/makm5Xf6ZLnQDONL0uoNDfnopMli8XiB/aOtCm0tnr4wlthLht35lJ7hgWAxotapoZ8apRCBAMJchyNhw7We7tjISgpb4Gt2w21ri9hcYtJYioZv6tpWN1yEihEQXJZx+LMH4HlXy99l/T3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563533; c=relaxed/simple;
	bh=dZEmvojR4+WMrLvLN9+xoAXznz3LrllKaatNb90DI74=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGYa+Mec/ZuGwL+KCNyvIZatMB1Pkp448vG+Ao0YlomVyHGU6jCx3rM/PDkZxpQ9Ae/xbocGk36SsIV4P93d2yj3v3VKuwm0mrhNZMdCBHe2IaB7HZ6IWQ9xiHek8As3nSTyxki0e6AAVscy2qRU8ZRcoVkGIaJvyq5hwaHXYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr4VFu/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr4VFu/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737563530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCSE7ZiubHavoM0WvF5Ce7eiEIiG9FzK+grdd2K915c=;
	b=Lr4VFu/E9aSP4+vTvO4E0bg4ZYnjkb3Zy0GcDYTqDyXO+TgSe2aOOQwcD/GqKQOBpOrJyH
	uCowJ1TQNIVJo6969LoFfR1puAtv9RpJ0xEuEtnOwuscr4HeWQL5obS6uLEd3VN8Tp5IjB
	J3Cb5rvQaJlSXPvg2Cc+3iFnmJMakk8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-BLvKj68MPyG5UUF3c9sPdA-1; Wed,
 22 Jan 2025 11:32:06 -0500
X-MC-Unique: BLvKj68MPyG5UUF3c9sPdA-1
X-Mimecast-MFC-AGG-ID: BLvKj68MPyG5UUF3c9sPdA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCB131955BDE;
	Wed, 22 Jan 2025 16:32:04 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10C9019560B7;
	Wed, 22 Jan 2025 16:32:00 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	Hanna Reitz <hreitz@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev
Subject: [RFC 1/5] vduse: add virtio_fs to allowed dev id
Date: Wed, 22 Jan 2025 17:31:50 +0100
Message-ID: <20250122163154.1225353-2-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-1-eperezma@redhat.com>
References: <20250122163154.1225353-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

A VDUSE device that implements virtiofs device works fine just by
adding the device id to the whitelist.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7ae99691efdf..6a9a37351310 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -144,6 +144,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
 	VIRTIO_ID_NET,
+	VIRTIO_ID_FS,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
-- 
2.48.1

