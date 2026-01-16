Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C182DD5F6
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572329; cv=none; b=uEgWlSfGDZJ4P1JBJzqdXLKpNVvy59v1alfw+cQCl2qxix7YIjfc2tMsMEa8KYH3jjm8BxlWHvM0/leUy/WvD0xf0TWSyIbyyII36MoISGDojjetehsSHoVbOhYMFQaCXAYfLeKEtD67H4+LSpZWDztg4B/04sbBU302Xn6LIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572329; c=relaxed/simple;
	bh=vZTTTmD5KMY+/Sed8hFVGe7MBW9KTDuwGyoIkE3pQXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vqp/78djeltmNqZ0qWlkmZwuRf7/+0OPe9eZos1f2wZK7bEBpJu1QyCNt+T31JGMq4A79qteeKAWBkvXBwXjyuw17gwU7ybJWhIW06LpAJSpk1YjniujfwEx2i4mKDFL/ixpyMDfIHvsB6KMdLBtN8P4yIceYtd0cgkLLW9Ioio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7CRIPPd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7CRIPPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768572327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6E8xV12rMKKWf9PFGPN0HuX7CMm2T1uMofq9AgsU374=;
	b=U7CRIPPdk/2u/yagRyLXJYH2DyuuAd3dhVB0Y1Et8RL39gqKDcb8EjZ0uVMU375GhxK34R
	l2uRrjWlJ9HrVQi4KxjgWTmsfXXtF/cNTKi79+hD23KMeGl/SNL5twVrBYUcdZLjyGNeVO
	ElhJZFuqbKBRAqrtJRPospnfYfc5qTE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-oaOAW6VgM0eF4o3nLbtkxQ-1; Fri,
 16 Jan 2026 09:05:23 -0500
X-MC-Unique: oaOAW6VgM0eF4o3nLbtkxQ-1
X-Mimecast-MFC-AGG-ID: oaOAW6VgM0eF4o3nLbtkxQ_1768572322
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 729B318002C9;
	Fri, 16 Jan 2026 14:05:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A890D30002D6;
	Fri, 16 Jan 2026 14:05:18 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v14 05/13] vdpa: document set_group_asid thread safety
Date: Fri, 16 Jan 2026 15:04:47 +0100
Message-ID: <20260116140455.1560491-6-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-1-eperezma@redhat.com>
References: <20260116140455.1560491-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Document that the function races with the check of DRIVER_OK.

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

