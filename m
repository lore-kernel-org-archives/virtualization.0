Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9455366DDC
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833219; cv=none; b=q97N0iIXKjNohXZyQd/F1Ky7m/yIyqGc9wLJFYecfSTZO6w++LQtnatALde2VWnZpnjlqkwtyTIX+j9Xry0iUWqSERnSf2iakWAPpMUyHb5zdD5SHqsG9Gos9U/XKiX/ssosbqawclvTIrmYyMzL9fJSu8tLVbnye2930mdIcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833219; c=relaxed/simple;
	bh=WvaWFkgvzchUZXLO23A+T5t6Ue7xXVAlqjtGBYlixZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=La63HDLHmmmjj3XpgXwS/1szO2RJjCBKqevrEuiSxMlSWgQ2pGxBtIUI9mB+agD6w8v/kobmpjGYesM+oxPX8/I6csa631GE96eRD5h4ey045cR7Gi3OcTp/zz/mU6dMzmv7oE3ur4t6Tiow8/m+ypaxqgIYDtpESTjfOLRm3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9HW2ca4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9HW2ca4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768833216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaNLbM0Xd0ri4i+Zhc5YrPBWzg2GZI57dccxp+Nyuaw=;
	b=S9HW2ca4EAWfYD0lZ2OAkxGwn4ZBnmhNMank4rOjVcKwj8bpIsG9lKWYdZSy6y7Y/nW/rb
	iZiP/c6ZO8nqNPoXxh9YJOXGqpE3968bpqFwOdiPTxf6QxaOXaUB5K+/aYxU0q0MxuVFNN
	j8cnoBckOgSUfJ3aOm70J08yQ5e1Wzc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-qarqllUfOAWkmLEpgVPtag-1; Mon,
 19 Jan 2026 09:33:33 -0500
X-MC-Unique: qarqllUfOAWkmLEpgVPtag-1
X-Mimecast-MFC-AGG-ID: qarqllUfOAWkmLEpgVPtag_1768833212
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70C501956070;
	Mon, 19 Jan 2026 14:33:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 029B418001D5;
	Mon, 19 Jan 2026 14:33:28 +0000 (UTC)
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
Subject: [PATCH v15 05/13] vdpa: document set_group_asid thread safety
Date: Mon, 19 Jan 2026 15:32:58 +0100
Message-ID: <20260119143306.1818855-6-eperezma@redhat.com>
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

Document that the function races with the check of DRIVER_OK.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
Requested at
https://lore.kernel.org/lkml/CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com/

v12: Reword comment (MST).
---
 include/linux/vdpa.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 4cf21d6e9cfd..2bfe3baa63f4 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -312,7 +312,9 @@ struct vdpa_map_file {
  *				@idx: virtqueue index
  *				Returns the affinity mask
  * @set_group_asid:		Set address space identifier for a
- *				virtqueue group (optional)
+ *				virtqueue group (optional).  Caller must
+ *				prevent this from being executed concurrently
+ *				with set_status.
  *				@vdev: vdpa device
  *				@group: virtqueue group
  *				@asid: address space id for this group
-- 
2.52.0

