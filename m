From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] uapi: add SPDX identifier to vm_sockets_diag.h
Date: Fri, 24 Nov 2017 12:08:40 -0800
Message-ID: <20171124200840.5551-1-sthemmin__49432.1000566289$1511554158$gmane$org@microsoft.com>
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
To: stefanha@redhat.com
Cc: netdev@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

New file seems to have missed the SPDX license scan and update.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 include/uapi/linux/vm_sockets_diag.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/vm_sockets_diag.h b/include/uapi/linux/vm_sockets_diag.h
index 14cd7dc5a187..0b4dd54f3d1e 100644
--- a/include/uapi/linux/vm_sockets_diag.h
+++ b/include/uapi/linux/vm_sockets_diag.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /* AF_VSOCK sock_diag(7) interface for querying open sockets */
 
 #ifndef _UAPI__VM_SOCKETS_DIAG_H__
-- 
2.11.0
