From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 03/13] vsock: remove include/linux/vm_sockets.h file
Date: Fri, 27 Sep 2019 13:26:53 +0200
Message-ID: <20190927112703.17745-4-sgarzare__23252.5652319723$1569583679$gmane$org@redhat.com>
References: <20190927112703.17745-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This header file now only includes the "uapi/linux/vm_sockets.h".
We can include directly it when needed.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/vm_sockets.h            | 13 -------------
 include/net/af_vsock.h                |  2 +-
 include/net/vsock_addr.h              |  2 +-
 net/vmw_vsock/vmci_transport_notify.h |  1 -
 4 files changed, 2 insertions(+), 16 deletions(-)
 delete mode 100644 include/linux/vm_sockets.h

diff --git a/include/linux/vm_sockets.h b/include/linux/vm_sockets.h
deleted file mode 100644
index 7dd899ccb920..000000000000
--- a/include/linux/vm_sockets.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * VMware vSockets Driver
- *
- * Copyright (C) 2007-2013 VMware, Inc. All rights reserved.
- */
-
-#ifndef _VM_SOCKETS_H
-#define _VM_SOCKETS_H
-
-#include <uapi/linux/vm_sockets.h>
-
-#endif /* _VM_SOCKETS_H */
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 80ea0f93d3f7..c660402b10f2 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,7 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
-#include <linux/vm_sockets.h>
+#include <uapi/linux/vm_sockets.h>
 
 #include "vsock_addr.h"
 
diff --git a/include/net/vsock_addr.h b/include/net/vsock_addr.h
index 57d2db5c4bdf..cf8cc140d68d 100644
--- a/include/net/vsock_addr.h
+++ b/include/net/vsock_addr.h
@@ -8,7 +8,7 @@
 #ifndef _VSOCK_ADDR_H_
 #define _VSOCK_ADDR_H_
 
-#include <linux/vm_sockets.h>
+#include <uapi/linux/vm_sockets.h>
 
 void vsock_addr_init(struct sockaddr_vm *addr, u32 cid, u32 port);
 int vsock_addr_validate(const struct sockaddr_vm *addr);
diff --git a/net/vmw_vsock/vmci_transport_notify.h b/net/vmw_vsock/vmci_transport_notify.h
index 7843f08d4290..a1aa5a998c0e 100644
--- a/net/vmw_vsock/vmci_transport_notify.h
+++ b/net/vmw_vsock/vmci_transport_notify.h
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/vmw_vmci_defs.h>
 #include <linux/vmw_vmci_api.h>
-#include <linux/vm_sockets.h>
 
 #include "vmci_transport.h"
 
-- 
2.21.0
