From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 3/4 v2] xen kconfig: add dom0 support help text
Date: Wed, 11 Jan 2012 17:36:40 +0100
Message-ID: <1326299801-7966-3-git-send-email-drjones@redhat.com>
References: <20120111161911.GB18203@andromeda.dapyr.net>
	<1326299801-7966-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1326299801-7966-1-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: konrad@darnok.org
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, stefano.stabellini@eu.citrix.com
List-Id: virtualization@lists.linuxfoundation.org

Describe dom0 support in the config menu and supply help text for it.

v2 adds 'if EXPERT' to keep it out of the "standard" menu.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arch/x86/xen/Kconfig |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 26c731a..31ec975 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -14,9 +14,14 @@ config XEN
 	  Xen hypervisor.
 
 config XEN_DOM0
-	def_bool y
+	bool "Xen Initial Domain (Dom0) support" if EXPERT
+	default y
 	depends on XEN && PCI_XEN && SWIOTLB_XEN
 	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
+	help
+	  This allows the kernel to be used for the initial Xen domain,
+	  Domain0. This is a privileged guest that supplies backends
+	  and is used to manage the other Xen domains.
 
 # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
 # name in tools.
-- 
1.7.7.5
