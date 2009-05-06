From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] xen: use header for EXPORT_SYMBOL_GPL
Date: Wed, 06 May 2009 09:50:22 -0700
Message-ID: <4A01BFCE.6020908@oracle.com>
References: <200905060438.n464cWFU025212@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905060438.n464cWFU025212@imap1.linux-foundation.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, akpm@linux-foundation.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

From: Randy Dunlap <randy.dunlap@oracle.com>

mmu.c needs to #include module.h to prevent these warnings:

arch/x86/xen/mmu.c:239: warning: data definition has no type or storage class
arch/x86/xen/mmu.c:239: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/x86/xen/mmu.c:239: warning: parameter names (without types) in function declaration

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/x86/xen/mmu.c |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2009-0505-2119.orig/arch/x86/xen/mmu.c
+++ mmotm-2009-0505-2119/arch/x86/xen/mmu.c
@@ -42,6 +42,7 @@
 #include <linux/highmem.h>
 #include <linux/debugfs.h>
 #include <linux/bug.h>
+#include <linux/module.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
