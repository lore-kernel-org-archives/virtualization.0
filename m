From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH] VMCI/VSOCK: Add maintainers for VMCI,
	AF_VSOCK and VMCI transport
Date: Thu, 21 Mar 2019 07:41:28 -0700
Message-ID: <1553179288-40893-1-git-send-email-jhansen@vmware.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Update the maintainers file to include maintainers for the VMware
vmci driver, af_vsock, and the vsock vmci transport.

Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 MAINTAINERS | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..b9714fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16630,6 +16630,14 @@ S:	Maintained
 F:	drivers/scsi/vmw_pvscsi.c
 F:	drivers/scsi/vmw_pvscsi.h
 
+VMWARE VMCI DRIVER
+M:	Jorgen Hansen <jhansen@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/vmw_vmci/
+
 VMWARE VMMOUSE SUBDRIVER
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
@@ -16638,6 +16646,18 @@ S:	Maintained
 F:	drivers/input/mouse/vmmouse.c
 F:	drivers/input/mouse/vmmouse.h
 
+VMWARE VSOCK DRIVER (AF_VSOCK) AND VMCI TRANSPORT
+M:	Jorgen Hansen <jhansen@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	net/vmw_vsock/af_vsock.c
+F:	net/vmw_vsock/vmci_transport*
+F:	net/vmw_vsock/vsock_addr.c
+F:	include/linux/vm_sockets.h
+F:	include/uapi/linux/vm_sockets.h
+
 VMWARE VMXNET3 ETHERNET DRIVER
 M:	Ronak Doshi <doshir@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
-- 
2.6.2
