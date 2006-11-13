From: James Morris <jmorris@redhat.com>
Subject: [PATCH] lhype: compilation fix for PKMAP_BASE reference
Date: Mon, 13 Nov 2006 17:28:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0611131726100.24957-100000@redline.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

I get a compilation error with an undefined reference to PKMAP_BASE (on a
fairly standard x86 box).  This patch include asm/highmem.h, where the
macro is defined.  Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

---

diff -r 2f39210c8792 drivers/lhype/init.c
--- a/drivers/lhype/init.c	Mon Nov 13 17:16:49 2006 -0500
+++ b/drivers/lhype/init.c	Mon Nov 13 17:23:38 2006 -0500
@@ -8,6 +8,7 @@
 #include <linux/vmalloc.h>
 #include <linux/proc_fs.h>
 #include <linux/file.h>
+#include <asm/highmem.h>
 #include <asm/lhype.h>
 #include <asm/paravirt.h>
 #include <asm/desc.h>
