From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 05/12] xen: move features.c from arch/x86/xen/features.c to
	drivers/xen.
Date: Fri, 28 Mar 2008 20:40:11 +0900
Message-ID: <1206704418807-git-send-email-yamahata__43321.8805389062$1206705295$gmane$org@valinux.co.jp>
References: <12067044183207-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12067044183207-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeremy@goop.org
Cc: eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

ia64/xen also uses it too. Move it into common place so that
ia64/xen can share the code.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/x86/xen/Makefile                |    2 +-
 drivers/xen/Makefile                 |    2 +-
 {arch/x86 => drivers}/xen/features.c |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {arch/x86 => drivers}/xen/features.c (100%)

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 343df24..c5e9aa4 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,4 +1,4 @@
-obj-y		:= enlighten.o setup.o features.o multicalls.o mmu.o \
+obj-y		:= enlighten.o setup.o multicalls.o mmu.o \
 			events.o time.o manage.o xen-asm.o
 
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 56592f0..609fdda 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,2 +1,2 @@
-obj-y	+= grant-table.o
+obj-y	+= grant-table.o features.o
 obj-y	+= xenbus/
diff --git a/arch/x86/xen/features.c b/drivers/xen/features.c
similarity index 100%
rename from arch/x86/xen/features.c
rename to drivers/xen/features.c
-- 
1.5.3
