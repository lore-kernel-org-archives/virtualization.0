Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F2296BB7
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416559; cv=none; b=FgUkptyp5uWbNjmogikt2f/5rIg7YRr0y4clf1CVne4wiK5FiDNCa93c+07sZUwkWuW0/G0QigToZzVNyQdh8FoHXR08RKqSCNDTHxvubMgXfXxU/76A4qaJKfWFffdilTA9DwXkhTqxwVvhwz61rJ4HcuiVNOKWQB131R2dXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416559; c=relaxed/simple;
	bh=vZTTTmD5KMY+/Sed8hFVGe7MBW9KTDuwGyoIkE3pQXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJIronHjJS/GsucaJegPy2N3K0Lc7owdLWg8JI8MMzRlBlsZs41q4xlBqchpamI00yqG0fBypvVXeoAbK6DSvN2fNw/RxrVVOvZLzLYPp90XhsUP8TEyw1tsEjP2dHU5rLDEFNhCc1MmHovpnKOwTlZBZr7D4scWoFlH5k22/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8BuZW7H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8BuZW7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768416553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6E8xV12rMKKWf9PFGPN0HuX7CMm2T1uMofq9AgsU374=;
	b=A8BuZW7Hl1AU37v+okN1S+WtwMRsiNN6iQp30rfIvkwQC5IK8dgFd8xc/rAW6t01z1Nanj
	my6veivWaW1wDH+yjGfa/Wu+FRJ3gYO4y8OqQnQDe2WglidvNr4ipwgCGnzSOjNa1c83iP
	N9tL8/ZR+T8dZI3oQZYZm+0u0KncQww=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-Atu6lZkBPomdpT0ocGx3ew-1; Wed,
 14 Jan 2026 13:49:09 -0500
X-MC-Unique: Atu6lZkBPomdpT0ocGx3ew-1
X-Mimecast-MFC-AGG-ID: Atu6lZkBPomdpT0ocGx3ew_1768416548
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFAD818005BF;
	Wed, 14 Jan 2026 18:49:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E6CD19560BA;
	Wed, 14 Jan 2026 18:49:03 +0000 (UTC)
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
Subject: [PATCH v12 05/13] vdpa: document set_group_asid thread safety
Date: Wed, 14 Jan 2026 19:48:31 +0100
Message-ID: <20260114184839.926884-6-eperezma@redhat.com>
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

