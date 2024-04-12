Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C083CB6
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928695; cv=none; b=kMma4xplJeNtxx7evXyfHo9dKph/l+JWK+FVn/bjeNSotgxHmw+3+CPXPkUA8Nm8AXFcH4fMOjHbclqUHYREktzgf6dTOghG1O1SVTKUioQcnxRDbqncH+OPAW67UsR85M5b7TBtIZD19TE9Rshf3gg4IQcsXQjn3R0l6+6de2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928695; c=relaxed/simple;
	bh=6bmbdoifZb2Jpy0PZiNXlrBy305qSk1zWYVTLBSmB0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne0zJm+QVdufQm6h8beWN5Fgj5mI/7iYjKIRXsppEEmqydpfW7NH0bdtRacf6VgQAldDX+n2c42hBB4Zf4ykm7CaIUXa4aCKameRosJrQ3QkMUOhAhBK5CsIdoThZ696JjINPK3gFoAUXOmb9nWfQA7w8MGQmgqWcZOeqLWqcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRGhYdqw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRGhYdqw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3404460744
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8LfcI-cDhaJp for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Apr 2024 13:31:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6C98A60743
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C98A60743
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cRGhYdqw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6C98A60743
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vba8fCSuLQZTKX30MTVAeYL8D2lP6F44uKwflbfLdSs=;
	b=cRGhYdqwMj9zFrpCN4gKidx/HoGqChRzF7LDoUh5OUcfokhW/9PyaT6vc3PwEyrJV+XswZ
	C66QdKFFeKoS09FfbxG7n3pj+uvMnbOuE/8QnqUxHElpWmxq578H3LZib810EyV9jyd2Y5
	9ZTYDrOylPwGyFe5UbC26BmGxB6E0Pk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-W-X8IWsyOMeVoJYzPPGdhQ-1; Fri,
 12 Apr 2024 09:31:29 -0400
X-MC-Unique: W-X8IWsyOMeVoJYzPPGdhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEACA28C97D1;
	Fri, 12 Apr 2024 13:31:28 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9935310E47;
	Fri, 12 Apr 2024 13:31:26 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 5/5] Documentation: Add reconnect process for VDUSE
Date: Fri, 12 Apr 2024 21:28:25 +0800
Message-ID: <20240412133017.483407-6-lulu@redhat.com>
In-Reply-To: <20240412133017.483407-1-lulu@redhat.com>
References: <20240412133017.483407-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add a document explaining the reconnect process, including what the
Userspace App needs to do and how it works with the kernel.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
index bdb880e01132..7faa83462e78 100644
--- a/Documentation/userspace-api/vduse.rst
+++ b/Documentation/userspace-api/vduse.rst
@@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
    after the used ring is filled.
 
 For more details on the uAPI, please see include/uapi/linux/vduse.h.
+
+HOW VDUSE devices reconnection works
+------------------------------------
+1. What is reconnection?
+
+   When the userspace application loads, it should establish a connection
+   to the vduse kernel device. Sometimes,the userspace application exists,
+   and we want to support its restart and connect to the kernel device again
+
+2. How can I support reconnection in a userspace application?
+
+2.1 During initialization, the userspace application should first verify the
+    existence of the device "/dev/vduse/vduse_name".
+    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
+    If it exists, it means this is a reconnection, and we should goto step 2.3
+
+2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
+    /dev/vduse/control.
+    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
+    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.
+
+2.3 Check if the information is suitable for reconnect
+    If this is reconnection :
+    Before attempting to reconnect, The userspace application needs to use the
+    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
+    to get the information from kernel.
+    Please review the information and confirm if it is suitable to reconnect.
+
+2.4 Userspace application needs to mmap the memory to userspace
+    The userspace application requires mapping one page for every vq. These pages
+    should be used to save vq-related information during system running. Additionally,
+    the application must define its own structure to store information for reconnection.
+
+2.5 Completed the initialization and running the application.
+    While the application is running, it is important to store relevant information
+    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
+    get vq information, it's necessary to check whether it's a reconnection. If it is
+    a reconnection, the vq-related information must be get from the mapped pages.
+
+2.6 When the Userspace application exits, it is necessary to unmap all the
+    pages for reconnection
-- 
2.43.0

