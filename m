From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] VIRTIO: Remove reference to now non-existent __KERNEL__ check.
Date: Fri, 26 Oct 2012 07:34:09 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210260732150.4995@oneiric>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


Since the header file is now under uapi/, there is no __KERNEL__check,
so fix the comment.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index b7cda39..72a09e1 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -1,7 +1,7 @@
 #ifndef _UAPI_LINUX_VIRTIO_CONFIG_H
 #define _UAPI_LINUX_VIRTIO_CONFIG_H
-/* This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
- * anyone can use the definitions to implement compatible drivers/servers.
+/* This header is BSD licensed so anyone can use the definitions to
+ * implement compatible drivers/servers.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
