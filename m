Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A96364029
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972306; cv=none; b=RWUwVP6nYeAY/r18UlJUfEwzcvtxqtRLsK7hEQtfPSKZTxCUig8cWPhixhFB1+KhvxMRDpXodRhy54CKK/PiG+J3OQoj7w9CzGqNCFwIoZqorm75dRSsHl5Zakg0Gg/blA1aGSEg02K0VqRNcncojn8Hkn4Y5IoTjbctLEiWqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972306; c=relaxed/simple;
	bh=1EKl1kWQvJGheFlwoQkDRjIS8f/4xZr2quxsulUAAP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDobYrxYuYnhG2hacxUkyQ50q4G5EWIfPqrs8hpWXN2Jn6KBEFYugBdi21FZVcPTcQUT5TDMRxHW8wSl7E2z9tPxs4O8vLU+jONkKewUt7cN8FYSDnbzoDiRcYdPe7EA1GWEiZpPsLMsJpUfzvvOyAf5j5FDGiqSYGUKQ3HqNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmBzdS8c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmBzdS8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767972304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGXCF0AqybI7Z1N0Bkbk2QG29YtO/8cd89BEW93BgII=;
	b=DmBzdS8crfkekznoYaIauo1i236Uy8a9VncTwoaTDmrjWR0mDxmoyOd6QmNwrJeA/ad2NE
	wSCtz5UIE7axIZTBkXn7tqN3agFQ9bLXIu1tYcG1pXb8BtNbU9siBjwWtM0q56KrVwKrvm
	GsIWWah2OHhRFqkxXYGAEn9MXF0WmH8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-h0B6aeYxOh6KUpIfHfq7sg-1; Fri,
 09 Jan 2026 10:25:01 -0500
X-MC-Unique: h0B6aeYxOh6KUpIfHfq7sg-1
X-Mimecast-MFC-AGG-ID: h0B6aeYxOh6KUpIfHfq7sg_1767972300
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4E411955DC7;
	Fri,  9 Jan 2026 15:24:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A5BA1954196;
	Fri,  9 Jan 2026 15:24:55 +0000 (UTC)
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
Subject: [PATCH v11 05/12] vdpa: document set_group_asid thread safety
Date: Fri,  9 Jan 2026 16:24:23 +0100
Message-ID: <20260109152430.512923-6-eperezma@redhat.com>
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

Document that the function races with the check of DRIVER_OK.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
Requested at
https://lore.kernel.org/lkml/CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com/
---
 include/linux/vdpa.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 4cf21d6e9cfd..cd1b1f1321b9 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -312,7 +312,9 @@ struct vdpa_map_file {
  *				@idx: virtqueue index
  *				Returns the affinity mask
  * @set_group_asid:		Set address space identifier for a
- *				virtqueue group (optional)
+ *				virtqueue group (optional).  It's not thread
+ *				safe to call this function concurrently with
+ *				set_status.
  *				@vdev: vdpa device
  *				@group: virtqueue group
  *				@asid: address space id for this group
-- 
2.52.0

