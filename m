From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v3 03/11] xen: Introduce architecture independent data for
	kexec/kdump
Date: Thu, 27 Dec 2012 03:18:52 +0100
Message-ID: <1356574740-6806-4-git-send-email-daniel.kiper__8145.4059495174$1356574906$gmane$org@oracle.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, maxim.uvarov@oracle.com, mingo@redhat.com, tglx@linutronix.de, vgoyal@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Introduce architecture independent constants and structures
required by Xen kexec/kdump implementation.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 include/xen/interface/xen.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 886a5d8..09c16ab 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -57,6 +57,7 @@
 #define __HYPERVISOR_event_channel_op     32
 #define __HYPERVISOR_physdev_op           33
 #define __HYPERVISOR_hvm_op               34
+#define __HYPERVISOR_kexec_op             37
 #define __HYPERVISOR_tmem_op              38
 
 /* Architecture-specific hypercall definitions. */
@@ -231,7 +232,39 @@ DEFINE_GUEST_HANDLE_STRUCT(mmuext_op);
 #define VMASST_TYPE_pae_extended_cr3     3
 #define MAX_VMASST_TYPE 3
 
+/*
+ * Commands to HYPERVISOR_kexec_op().
+ */
+#define KEXEC_CMD_kexec			0
+#define KEXEC_CMD_kexec_load		1
+#define KEXEC_CMD_kexec_unload		2
+#define KEXEC_CMD_kexec_get_range	3
+
+/*
+ * Memory ranges for kdump (utilized by HYPERVISOR_kexec_op()).
+ */
+#define KEXEC_RANGE_MA_CRASH		0
+#define KEXEC_RANGE_MA_XEN		1
+#define KEXEC_RANGE_MA_CPU		2
+#define KEXEC_RANGE_MA_XENHEAP		3
+#define KEXEC_RANGE_MA_BOOT_PARAM	4
+#define KEXEC_RANGE_MA_EFI_MEMMAP	5
+#define KEXEC_RANGE_MA_VMCOREINFO	6
+
 #ifndef __ASSEMBLY__
+struct xen_kexec_exec {
+	int type;
+};
+
+struct xen_kexec_range {
+	int range;
+	int nr;
+	unsigned long size;
+	unsigned long start;
+};
+
+extern unsigned long xen_vmcoreinfo_maddr;
+extern unsigned long xen_vmcoreinfo_max_size;
 
 typedef uint16_t domid_t;
 
-- 
1.5.6.5
