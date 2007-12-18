From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/2] remove __init modifier from header declaration
Date: Tue, 18 Dec 2007 14:52:55 -0200
Message-ID: <11979967763153-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch removes the __init modifier from an extern function
declaration in acpi.h.

Besides not being strictly needed, it requires the inclusion of
linux/init.h, which is usually not even included directly, increasing
header mess by a lot.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/acpi.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86/acpi.h b/include/asm-x86/acpi.h
index c477e57..2feb0c4 100644
--- a/include/asm-x86/acpi.h
+++ b/include/asm-x86/acpi.h
@@ -158,7 +158,7 @@ extern int acpi_scan_nodes(unsigned long start, unsigned long end);
 #ifdef CONFIG_X86_64
 # define NR_NODE_MEMBLKS (MAX_NUMNODES*2)
 #endif
-extern void __init acpi_fake_nodes(const struct bootnode *fake_nodes,
+extern void acpi_fake_nodes(const struct bootnode *fake_nodes,
 				   int num_nodes);
 #else
 static inline void acpi_fake_nodes(const struct bootnode *fake_nodes,
-- 
1.5.0.6
