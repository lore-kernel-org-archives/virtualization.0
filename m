Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB293612E4
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972290; cv=none; b=mOycVejuKpYiHWK93nA7/IwqciVlSXLO5wA3Xc0am0xWe5v9ifVo7vb8FiXH5IXFY5fmHMtlEzlRfYB8HCnEdKZ30b5whOmg6Grip5atheyyglTwQbgfs1IvxN09k6FlTQ2m/23M+vBDe7iydufVwxaANS/VB+OiGMqg2J2j+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972290; c=relaxed/simple;
	bh=5ECYxaYeBJVIOWeqy/iDdDa/H00cLiMfLM4EhoJhPCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3cnrC9gc/UR9dTpsUHsLKzrp9INkRKeBQ1oRFu+u/D7ANL22Rx8SN6QzSW2/uNx8D1T9jT7IYBfrDyR/oLDpJL5Uh4yVwMo1VsJhD98cGsGS0pyBSvtz6z7r6VDwRlfeemdmHmmZhpfT1Cp17Jd0QvaLxsyvmeq/EdvlUlqQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuPjRcro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuPjRcro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767972286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5hO8Psqd6yn9uKa/WLE0Q8XbzNZAyPQD8caCcDa5fs=;
	b=QuPjRcro+bkYp4Xheqg7jyGJBC4aQ0x91NXjYuAed+RHIZyYQrvtPVQqNe4OOkN3EqW350
	wk9H5w3VLkUdr5Jj2VgUpXUWOJjrVvpeKJ4KcyZoj7IYuv2idJGeVKnud1HF2fYS5cU2iY
	QwJtgOh7Bs6LoA4TII0naIkwhk4bvUw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-QMkHJ4YDPE-7rJUJrPL_Dg-1; Fri,
 09 Jan 2026 10:24:41 -0500
X-MC-Unique: QMkHJ4YDPE-7rJUJrPL_Dg-1
X-Mimecast-MFC-AGG-ID: QMkHJ4YDPE-7rJUJrPL_Dg_1767972280
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FBAB1800447;
	Fri,  9 Jan 2026 15:24:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C99B1954199;
	Fri,  9 Jan 2026 15:24:36 +0000 (UTC)
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
Subject: [PATCH v11 01/12] vduse: add v1 API definition
Date: Fri,  9 Jan 2026 16:24:19 +0100
Message-ID: <20260109152430.512923-2-eperezma@redhat.com>
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

This allows the kernel to detect whether the userspace VDUSE device
supports the VQ group and ASID features.  VDUSE devices that don't set
the V1 API will not receive the new messages, and vdpa device will be
created with only one vq group and asid.

The next patches implement the new feature incrementally, only enabling
the VDUSE device to set the V1 API version by the end of the series.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/uapi/linux/vduse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 10ad71aa00d6..ccb92a1efce0 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -10,6 +10,10 @@
 
 #define VDUSE_API_VERSION	0
 
+/* VQ groups and ASID support */
+
+#define VDUSE_API_VERSION_1	1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
-- 
2.52.0

