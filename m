From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 2/5] [PATCH] make vsmp_init void, instead of static int
Date: Mon, 11 Feb 2008 17:16:02 -0200
Message-ID: <1202757365-18634-2-git-send-email-gcosta__1086.18407180092$1202770914$gmane$org@redhat.com>
References: <1202757365-18634-1-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1202757365-18634-1-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, shai@scalemp.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Glauber Costa <gcosta@redhat.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalemp.com>
Acked-by: Shai Fultheim <shai@scalemp.com>
---
 arch/x86/kernel/vsmp_64.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index d971210..9766917 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -16,20 +16,20 @@ #include <linux/pci_regs.h>
 #include <asm/pci-direct.h>
 #include <asm/io.h>
 
-static int __init vsmp_init(void)
+static void __init vsmp_init(void)
 {
 	void *address;
 	unsigned int cap, ctl;
 
 	if (!early_pci_allowed())
-		return 0;
+		return;
 
 	/* Check if we are running on a ScaleMP vSMP box */
 	if ((read_pci_config_16(0, 0x1f, 0, PCI_VENDOR_ID) !=
 	     PCI_VENDOR_ID_SCALEMP) ||
 	    (read_pci_config_16(0, 0x1f, 0, PCI_DEVICE_ID) !=
 	     PCI_DEVICE_ID_SCALEMP_VSMP_CTL))
-		return 0;
+		return;
 
 	/* set vSMP magic bits to indicate vSMP capable kernel */
 	address = ioremap(read_pci_config(0, 0x1f, 0, PCI_BASE_ADDRESS_0), 8);
@@ -46,7 +46,7 @@ static int __init vsmp_init(void)
 	}
 
 	iounmap(address);
-	return 0;
+	return;
 }
 
 core_initcall(vsmp_init);
-- 
1.4.2
