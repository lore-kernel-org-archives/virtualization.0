From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 1/3] xen: Move manage.c to drivers/xen for ia64/xen support.
Date: Tue, 22 Apr 2008 16:00:04 +0900
Message-ID: <12088476061989-git-send-email-yamahata__2899.69952214069$1208848108$gmane$org@valinux.co.jp>
References: <12088476062604-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12088476062604-git-send-email-yamahata@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

move arch/x86/xen/manage.c under drivers/xen/to share codes
with x86 and ia64.
ia64/xen also uses manage.c

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/x86/xen/Makefile              |    2 +-
 drivers/xen/Makefile               |    2 +-
 {arch/x86 => drivers}/xen/manage.c |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {arch/x86 => drivers}/xen/manage.c (100%)

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 3d8df98..40b119b 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,4 +1,4 @@
 obj-y		:= enlighten.o setup.o multicalls.o mmu.o \
-			time.o manage.o xen-asm.o grant-table.o
+			time.o xen-asm.o grant-table.o
 
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 37af04f..363286c 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,4 +1,4 @@
-obj-y	+= grant-table.o features.o events.o
+obj-y	+= grant-table.o features.o events.o manage.o
 obj-y	+= xenbus/
 obj-$(CONFIG_XEN_XENCOMM)	+= xencomm.o
 obj-$(CONFIG_XEN_BALLOON)	+= balloon.o
diff --git a/arch/x86/xen/manage.c b/drivers/xen/manage.c
similarity index 100%
rename from arch/x86/xen/manage.c
rename to drivers/xen/manage.c
-- 
1.5.3
