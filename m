Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A992DC32C
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881694; cv=none; b=BI2L1DiDhPOjRhfgji3x5qgjxitrsPn+FFUlCLQYKe3xZ0yHeCScNYBO3CjGIKDsIIq2gLV5fQIZMgtd+TqUuIH2kNduD0rg/F2BwT/tuXfdS8UVQYb7k69kKV+mVdRWF52CDmkdIyi0kZbOiKBsb0AOhZ7CKPwiOASNoeE+qJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881694; c=relaxed/simple;
	bh=pbBzLjrUvy4Jws3IrdIk6Q8D7H91HuRG6YGPY55CtrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ComOo2+sZz22vobd8IbyA/xr/5S3QZ39ZBrYZ4RmCZUCHeqnY2FPawArT1RS/nt4rB6MopIysn7l7FEyuAbdbDcJiFbbkpPAOH76yVG2JM27DDradz78MW6LKhiHTxNuCSNrg+Ee92s53iDi14FmxROhTvEKKGXmfzCzSxBc+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq0XCHnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq0XCHnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758881690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dg27mnkpxY6+wpImWrHzQoz+UEHN7ql4f1eRWWfzQk=;
	b=Cq0XCHnRm/h/1ygNgiDq2Gp0bAX1WyZxC5nxg02EoKG6c64WzMe4idT/n18tvza7agTCfn
	CPAMaieR6ZckPyVweMErYTiSVcd2W7RqnRNxmKJJkTjpDms5HoAiXtX98zZqMS53QUrdoz
	VSjU204SxEV01NS4gceUmNTuw0/kMy8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-A5jmHskfPsmyPShwupsrpw-1; Fri,
 26 Sep 2025 06:14:48 -0400
X-MC-Unique: A5jmHskfPsmyPShwupsrpw-1
X-Mimecast-MFC-AGG-ID: A5jmHskfPsmyPShwupsrpw_1758881687
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A7C21800378;
	Fri, 26 Sep 2025 10:14:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.141])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F82619540EB;
	Fri, 26 Sep 2025 10:14:43 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: [PATCH v5 2/6] vduse: add v1 API definition
Date: Fri, 26 Sep 2025 12:14:28 +0200
Message-ID: <20250926101432.2251301-3-eperezma@redhat.com>
In-Reply-To: <20250926101432.2251301-1-eperezma@redhat.com>
References: <20250926101432.2251301-1-eperezma@redhat.com>
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
2.51.0

