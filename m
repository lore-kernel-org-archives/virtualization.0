From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: [PATCH] xen: remove unused Kconfig parameter
Date: Mon,  8 Jul 2013 08:28:24 +0200
Message-ID: <1373264904-27053-1-git-send-email-michael.opdenacker__12954.1817041629$1373386114$gmane$org@free-electrons.com>
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
To: konrad.wilk@oracle.com, jeremy@goop.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: Michael Opdenacker <michael.opdenacker@free-electrons.com>, linux-kernel@vger.kernel.org, x86@kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch proposes to remove the XEN_PRIVILEGED_GUEST kernel
configuration parameter defined in arch/x86/xen/Kconfig, but used
nowhere in the makefiles and source code.

This dummy parameter was added 3 years back, and it may
make sense to remove it now, as the reasons to use it were not
very clear.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/x86/xen/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 1a3c765..b6401dc 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -19,11 +19,6 @@ config XEN_DOM0
 	depends on XEN && PCI_XEN && SWIOTLB_XEN
 	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
 
-# Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
-# name in tools.
-config XEN_PRIVILEGED_GUEST
-	def_bool XEN_DOM0
-
 config XEN_PVHVM
 	def_bool y
 	depends on XEN && PCI && X86_LOCAL_APIC
-- 
1.8.1.2
