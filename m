From: Deep Shah <sdeep@vmware.com>
Subject: [PATCH] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
Date: Thu, 16 Apr 2020 16:45:20 -0700
Message-ID: <20200416234520.GA1700@prme-mon-cfl-mlw-07>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, pv-drivers@vmware.com, jgross@suse.com, thellstrom@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

Thomas Hellstrom will be handing over VMware's maintainership of these
interfaces to Deep Shah.

Signed-off-by: Deep Shah <sdeep@vmware.com>
Acked-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..c9bdbb65e96b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12730,7 +12730,7 @@ F:	include/uapi/linux/ppdev.h
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Thomas Hellstrom <thellstrom@vmware.com>
+M:	Deep Shah <sdeep@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
@@ -18025,7 +18025,7 @@ S:	Maintained
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Thomas Hellstrom <thellstrom@vmware.com>
+M:	Deep Shah <sdeep@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
-- 
2.7.4
