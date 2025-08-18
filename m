Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66024308F27
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507449; cv=none; b=ijIZ6jcCBGQ65hV+gEb4sLunzZTKgzk/Q3/PHE92EL4snrU2rMS9UxeeHoB2W+tIapeTI/iJii4wPq8XcygkCgjKniQENtktD6BQCOnh/tkhMJxKJx66XIuyLdk0xqDqsvzUzZCT6PkNR4zDGqZ8A6ugveSvKWrW8vJn//QmazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507449; c=relaxed/simple;
	bh=Mq/AfDbkzeahYi6sN3Rcg3Dlb4puLIjsK36j9gN6tVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky2mxfI+6XtkFO9vts8x+vY8bRV3tNvHxbQeRVeyAXV4z7MGrLw2pesvmJhxqeB6im/I5IEkXxPJdiHOaFRvOF0y5b0r0SoW2fagniGMpdywxQB7Wsy2HSfTLrXFgJGA8H4RP4kSd76e2d5YZPJBYw6gNXCv6mtd39BMgEfjkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBx8Ho2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBx8Ho2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755507447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahzdshQiL3Xzni/Jqm6kcPlFcj6smcBvlHHrtbsnZWI=;
	b=gBx8Ho2YKMFIfS8KudwO2Ju42MsqxgrxG15xL6AQTFkrh/Voco5OCWhmcbjcRiR4+/kj2D
	yq9LOEcKXOue6SswBMuks6jeQfyyizcc57G2+KOv5j3mzBXyAAK+DO9yaDZcYBUPtySn8m
	V55v3Rm4HTKaaVvWTvBXeAv0bwnMlck=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-GMg2T3ajOSG-vO-Bz9LOFg-1; Mon,
 18 Aug 2025 04:57:23 -0400
X-MC-Unique: GMg2T3ajOSG-vO-Bz9LOFg-1
X-Mimecast-MFC-AGG-ID: GMg2T3ajOSG-vO-Bz9LOFg_1755507442
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD7D1800286;
	Mon, 18 Aug 2025 08:57:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59F9B1800446;
	Mon, 18 Aug 2025 08:57:18 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC v3 1/7] vduse: add v1 API definition
Date: Mon, 18 Aug 2025 10:57:05 +0200
Message-ID: <20250818085711.3461758-2-eperezma@redhat.com>
In-Reply-To: <20250818085711.3461758-1-eperezma@redhat.com>
References: <20250818085711.3461758-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 68a627d04afa..9a56d0416bfe 100644
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
2.50.1

