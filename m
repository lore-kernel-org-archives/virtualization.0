Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D271379984
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563790; cv=none; b=LZPG6zGpYPOuczWEZ7CZgIxIR6Xk6YOV+N2RHxFan93Tq2fo8gs1Thf9xCBNCQh6kmBsbnfHHJmDN1mhiLNtbei5yU0RXQBCsF27JlRu52h1cA2Z3rBlG1+ZDecUy5Y37Kg/yh+jvlEdX9iMNBprW69KeVGy6DUrtYMBU6+7N1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563790; c=relaxed/simple;
	bh=vZTTTmD5KMY+/Sed8hFVGe7MBW9KTDuwGyoIkE3pQXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZRpsG436daM3iXhiUJDjRpHWbVsr43H/rUy3BmYc6gezk/yeCZaRWPYobvq3EMg5g8a8QZpDLYKqvKCtXR04Y5vbxytUWRK19ZpPUtWKimTz2BhTJabKHr3cnWqNXgY1qdPlrkTWGwO25c1Atad+L6fS0ZaQbkC2/Bh087iF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSL60Fzy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSL60Fzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768563786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6E8xV12rMKKWf9PFGPN0HuX7CMm2T1uMofq9AgsU374=;
	b=KSL60FzyTIWD7XnJuVNT8qiqDReXmA86batAgNKr4d9wGxtSaWa+4o/mNTMix7Ua6OdXkN
	Djk6ZjdhCradiObfcrMxho6htdHO2wjbKZyGqlf7vRmVb3dB8pxdEqZJK965DXGP9vwHfT
	WRudEVC3WORJa/uTrnkAo2Ly1Bt7I50=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-y7oCZjDNM52mhG5AmBt3JQ-1; Fri,
 16 Jan 2026 06:43:03 -0500
X-MC-Unique: y7oCZjDNM52mhG5AmBt3JQ-1
X-Mimecast-MFC-AGG-ID: y7oCZjDNM52mhG5AmBt3JQ_1768563782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE82D19560A3;
	Fri, 16 Jan 2026 11:43:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C30171801ACF;
	Fri, 16 Jan 2026 11:42:57 +0000 (UTC)
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
Subject: [PATCH v13 05/13] vdpa: document set_group_asid thread safety
Date: Fri, 16 Jan 2026 12:42:23 +0100
Message-ID: <20260116114231.1474306-6-eperezma@redhat.com>
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

