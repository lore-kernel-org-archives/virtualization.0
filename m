From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] virtio: console: Update Copyright
Date: Mon, 31 Jan 2011 13:06:37 +0530
Message-ID: <2b171369d71b435407d421be3786ad9dfb32a7a9.1296459389.git.amit.shah@redhat.com>
References: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
In-Reply-To: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
References: <eb504880dbb2b70d51c62a63012b69408b80d070.1296459389.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/tty/hvc/virtio_console.c |    3 ++-
 include/linux/virtio_console.h   |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/virtio_console.c b/drivers/tty/hvc/virtio_console.c
index 1068095..f03338f 100644
--- a/drivers/tty/hvc/virtio_console.c
+++ b/drivers/tty/hvc/virtio_console.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2006, 2007, 2009 Rusty Russell, IBM Corporation
- * Copyright (C) 2009, 2010 Red Hat, Inc.
+ * Copyright (C) 2009, 2010, 2011 Red Hat, Inc.
+ * Copyright (C) 2009, 2010, 2011 Amit Shah <amit.shah@redhat.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index a85064d..e4d3335 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -7,7 +7,8 @@
  * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
  * anyone can use the definitions to implement compatible drivers/servers.
  *
- * Copyright (C) Red Hat, Inc., 2009, 2010
+ * Copyright (C) Red Hat, Inc., 2009, 2010, 2011
+ * Copyright (C) Amit Shah <amit.shah@redhat.com>, 2009, 2010, 2011
  */
 
 /* Feature bits */
-- 
1.7.3.5
