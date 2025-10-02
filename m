Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250030ACEE
	for <virtualization@lists.linux.dev>; Thu,  2 Oct 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401366; cv=none; b=d4NKv0cKSOHmwoqu38tIGrW8A691kWHBKuXQn+TtTTKq+dp6yV9lfUdopbUXvXUS3JyhDE1c0PK9DO5waSGd+tFlu9RlfrUQvOpUB8vPd/cZ7bmzJXZKsJa4YKW/77oe4OMutUX8lyxBBBzkxIQASe3vaVhLpOMZBDV3F0/Ylt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401366; c=relaxed/simple;
	bh=goKcmOzmH9ogjIeR/aDjNdtZqVeWTMkhnZhMQaR/02w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elggOfRCR+p0iYFloLYWjNpKgtfGLGeUZFMRNB9yyOS3/s7uahRr9jwlOFagO/UJ/K2BTOtT49XZgvJcyetkAOXHKCe+HORpBYUMfKGlXrD8JHPH2xRmh3l4rTxpm0vI+Q5f6zn3LFVSibcWGHD0s26jVjyPFY6rk+e3fy90rO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwBerCSw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwBerCSw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759401364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM0cA7tzuiWV6s6TW2GZ8k3Gv110oDPxpMncChVaQDg=;
	b=DwBerCSw4YzC+of08MhnoEDk42DXuAyvEKIm8D/FjeM1+4FDVM03ugqHz7tiPiwN8u5ZS4
	8MlZEtuxcfI61ZW1snmqUqwTGRqyQZ3/He+PfuDvLdA6swGmZUbLCXGiso8X1oYlbaaZNX
	855Jvck5KaEhVqygcXXt4enFTaRbkFc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-BOo6szoQOACQRpbdzOvqrQ-1; Thu,
 02 Oct 2025 06:36:00 -0400
X-MC-Unique: BOo6szoQOACQRpbdzOvqrQ-1
X-Mimecast-MFC-AGG-ID: BOo6szoQOACQRpbdzOvqrQ_1759401358
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B4F01800578;
	Thu,  2 Oct 2025 10:35:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.208])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1299A300018D;
	Thu,  2 Oct 2025 10:35:52 +0000 (UTC)
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
Subject: [RFC 2/2] vduse: allow to specify device-specific features if it's multiclass
Date: Thu,  2 Oct 2025 12:35:37 +0200
Message-ID: <20251002103537.308717-3-eperezma@redhat.com>
In-Reply-To: <20251002103537.308717-1-eperezma@redhat.com>
References: <20251002103537.308717-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Even if the device supports more than one class, there are ways to solve
the ambiguity of which device are we creating.  In the VDUSE case it is
the name, for example.

RFC: I fon't understand 100% the motivation of this limitation, as the
backend should be the one filtering out the invalid features if any.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 34874beb0152..0fc32f3bd66f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -688,15 +688,6 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = -EINVAL;
 		goto err;
 	}
-	if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
-	    config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
-	    classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
-	    config.device_features & VIRTIO_DEVICE_F_MASK) {
-		NL_SET_ERR_MSG_MOD(info->extack,
-				   "Management device supports multi-class while device features specified are ambiguous");
-		err = -EINVAL;
-		goto err;
-	}

 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
--
2.51.0

