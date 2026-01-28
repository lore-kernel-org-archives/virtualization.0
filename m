Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACEC32BF43
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604350; cv=none; b=RKwrZCvsrqfRRME/y+8hzEEH3dNe57zMv5WzgUNrro2V26iqp1o31RjeBJxXCYWd2hGxL2dKXfHoa2k4y1ML3hK+uiZXKk3wO0HlUvmGUf9CiyHiY8d09fap1ny7HpE+fxn89LstoFx0QyFnDD/rqlrBn+jeW+EWCzriYbjMkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604350; c=relaxed/simple;
	bh=xJ0hpPC1Mj/MA/To2N3dZPAJOkgDLAVTKEvIX/nQUtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP2QTsXKZ5PkXj2e+A70SCc09foySwVLjkBAGoHPNxmP+XN/ry8kTA3v3wbctLGnrXV7Hgcs1RLnmTE3JVJTLcrL4uRBVrFRaExzB6XN/Dx9+QVvCEKRwiwQySousUyXcFh+tTbJTXYM8bYEZBtNBdiIdypIrgDTcW81FZEfRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5nGjLFU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5nGjLFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769604348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR0t8gQb2jQmayWHiX0aSSeiUmtsNw1fKY557776eB0=;
	b=E5nGjLFUFOUaOewzCSjwh8fc9OUwqIeJKn3Gp3bATo9ttG9HQZRJcc0j2CCFy4fZjtpxLF
	rsTqbYWai6A+KgHOt39X4sK03DKs4okkqLyHZ8GV4PDLz6jksyl2zEDsREUx5osDGYyLjE
	yhAvVNX+sopklkNgwe52P8sYjiLnGn8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-iD9D9ld0OyytF6kyLMpXSA-1; Wed,
 28 Jan 2026 07:45:45 -0500
X-MC-Unique: iD9D9ld0OyytF6kyLMpXSA-1
X-Mimecast-MFC-AGG-ID: iD9D9ld0OyytF6kyLMpXSA_1769604344
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67A691955D93;
	Wed, 28 Jan 2026 12:45:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26FFA30002D8;
	Wed, 28 Jan 2026 12:45:39 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 3/6] vduse: Add API v2 definition
Date: Wed, 28 Jan 2026 13:45:21 +0100
Message-ID: <20260128124524.875271-4-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-1-eperezma@redhat.com>
References: <20260128124524.875271-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Introduce the definition for VDUSE API V2.  This version serves as a
gateway for feature negotiation.

The kernel uses this version to determine if the userspace device
supports feature flags. Devices that do not explicitly negotiate API V2
will be blocked from querying available VDUSE features, ensuring
backward compatibility.

The next patches implement the new feature incrementally, only enabling
the VDUSE device to set the V2 API version by the end of the series.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/uapi/linux/vduse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 68b4287f9fac..dea89ed281a7 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -14,6 +14,10 @@
 
 #define VDUSE_API_VERSION_1	1
 
+/* Features support */
+
+#define VDUSE_API_VERSION_2	2
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
-- 
2.52.0

