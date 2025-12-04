Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D533009FF
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873985; cv=none; b=B+ybYAJRVe04wEi3srDWq46W9GMaOh26mXSmJiOEVTsAz9uUswoIoKjI4D4iENeVtpXCQiWs5Dof3XDbfG/fUceXrCkXmrLlUoUflwaRNSjnc8hMFwfkJXYD8z3i9TiHLez5k7Z3FqJMemQ8zA4t1csrxtgFUl9Kj5GgfRuFcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873985; c=relaxed/simple;
	bh=2yVORz43U+z3dI+alRQtkLlSi6piS3f5bUiohx1u6MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uyWpub2v8xXH+NAUhu/si6GXEytIAS6tU5eJScnxegGUzucDts4Jx99kfzqqNrlB5Gsp0xT/maTbaWLbYitItbIDy9rIdfkb2/8CAVA+3U0TZOfF+Lc2qzYfLNTiHJlzb+gAIiwoz3cMh5MBYVuhP52tZ2UW9o0zkV588/y3gYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PyDJzonm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyDJzonm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/2BU6dfvObjfmIg743L6O6ePqwkHkU6MnXaltUr2NQ=;
	b=PyDJzonmXwYAxlU0K8F5icJQp2fEiWK9CjoEdI3TyVv48HqSEAId+jPEqBvPs0x53IBsTD
	RMYmJdOIdmRoMcoST1l4V+oT+72DDpdsYKKHROIr9XLgj6sw2hccJcn0NweAWHx/hBp28w
	ongenR2SjJxSHSf+n/RdANbK1KKa5h4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-xgAkujj2PEeiL97EQejyoA-1; Thu, 04 Dec 2025 13:46:20 -0500
X-MC-Unique: xgAkujj2PEeiL97EQejyoA-1
X-Mimecast-MFC-AGG-ID: xgAkujj2PEeiL97EQejyoA_1764873979
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b478551a6so713004f8f.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873979; x=1765478779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/2BU6dfvObjfmIg743L6O6ePqwkHkU6MnXaltUr2NQ=;
        b=KQUUJ9/e2xEFc8Kho1dUceO4xda60YfgMoZqAUIDhwO2XGFV2BMl2CDyKnmlw6Upss
         rUvtZNVVHbpmJgHjjTX7KGcTS198FrS4MpptsbP+EeYvzXDgeZo1Y22Tk3v9NaW9xyl1
         FlcnsJFe9c0a1u/FZRgsPC4jV+p/k9glu0CPAsm0qtQzGLdivTgGyuxJgJn9Dphx83MD
         xOMkq+uvssw0aX8Y4DxILre62lEWKio+7TbkoHzKEY9GebcjLn+/fvAw4qAUw/5k0YBZ
         7uhtTKBVboU0G7zRe2lvEQj4wUoboupm1RF63UDbAWhhhbgBxr0e7GXtq8yD64IFBF6h
         k9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwjSNuRszr6EUNrsKrNySzJJgVqiwDo1Iz+gaPp4Mjhc4aCIlovuU9xhQoRXJu2ypBy9FkzDQGuQqzJf9noQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmuksLknKfaZ9+WllS1bYin4pjyh2pUv/q7qCpHLRFIlY0hYQG
	ERDzv9GznM6As9fSaOsHc2eS9bIUgb9Fht1bEWuRRgopwWb4viLon8gtt8YunSCQdG9AtXFEDFa
	JV21yl0BB1vC+3x0LI+dY3K8hlf9OGtN5SePr2RwZPF3bl9Agcu87hyjXf0Zu4mhVC2up
X-Gm-Gg: ASbGncu6CZaC4wuE1O0KWcdKPz1+IYU3lgHlSF1eeRoOdlPA/5cbds2183akJ4OIlEc
	kGSf6OZxwtplb/NG9aCZHA71Jxrigbgnil2w4CGY3mXkZlCDXNpq1wQPT4zNOMk21W1uA2gI4ez
	zsSywrGZZsVpUkuakOt7aYg09kexeG60g7XQGnE2O8i8WNruRqcfyxyzriT6D+pLrFql2MKQouI
	175V64I4a8ENHZVq4xhPt4bVeM8eHG/NtohU5VGWODoP2Xz85wQkdb8KiIOQk4D7QMIadiv1Mxh
	OjjLeecnMwlGEnqYeEf1eglP973chiU1kQSDoXcoh/ggpL6jA6kTnrceiJkR261R2lgkzgePHNI
	=
X-Received: by 2002:a05:600c:3513:b0:477:7bd2:693f with SMTP id 5b1f17b1804b1-4792aee39a1mr65278505e9.6.1764873979010;
        Thu, 04 Dec 2025 10:46:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoIAGe8r0i3nv6xruw1ZSNwUvayiol2XMMbxIjD0RXQVPepW/JrO1Ej3A9BM0NVjTdihqtxA==
X-Received: by 2002:a05:600c:3513:b0:477:7bd2:693f with SMTP id 5b1f17b1804b1-4792aee39a1mr65278305e9.6.1764873978486;
        Thu, 04 Dec 2025 10:46:18 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b140cf4sm54468305e9.5.2025.12.04.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:17 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 07/14] tools/virtio: add ucopysize.h stub
Message-ID: <5046df90002bb744609248404b81d33b559fe813.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gqcO-6D1XRoV5V2rYc5wiorn8CC8dtosYfiwT86WTu0_1764873979
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add ucopysize.h with stub implementations of check_object_size,
copy_overflow, and check_copy_size.

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/ucopysize.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/virtio/linux/ucopysize.h

diff --git a/tools/virtio/linux/ucopysize.h b/tools/virtio/linux/ucopysize.h
new file mode 100644
index 000000000000..8beb7755d060
--- /dev/null
+++ b/tools/virtio/linux/ucopysize.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_UCOPYSIZE_H__
+#define __LINUX_UCOPYSIZE_H__
+
+#include <linux/bug.h>
+
+static inline void check_object_size(const void *ptr, unsigned long n,
+				     bool to_user)
+{ }
+
+static inline void copy_overflow(int size, unsigned long count)
+{
+}
+
+static __always_inline __must_check bool
+check_copy_size(const void *addr, size_t bytes, bool is_source)
+{
+	return true;
+}
+
+#endif /* __LINUX_UCOPYSIZE_H__ */
-- 
MST

