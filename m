From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 2/2] Arch-specific includes
Date: Mon, 2 Apr 2007 18:28:20 -0300
Message-ID: <20070402212820.GD7711@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DiL7RhKs8rK9YGuF"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry if this gets resent. My fault ;-)

All that is left for the architectures, is the room for some specific
definitions.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>

-- 
Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"

--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lgarchdefs.patch"

--- /dev/null	2007-04-02 15:35:49.510433377 -0300
+++ i386/lguest_defs.h	2007-04-02 16:19:27.000000000 -0300
@@ -0,0 +1,7 @@
+#ifndef _LGUEST_DEFS_H_
+#define _LGUEST_DEFS_H_
+
+/* LGUEST_TOP_ADDRESS comes from the Makefile */
+#define RESERVE_TOP_ADDRESS LGUEST_GUEST_TOP - 1024*1024
+
+#endif
--- /dev/null	2007-04-02 15:35:49.510433377 -0300
+++ x86_64/lguest_defs.h	2007-04-02 16:19:27.000000000 -0300
@@ -0,0 +1,11 @@
+#ifndef _LGUEST_DEFS_H_
+#define _LGUEST_DEFS_H_
+
+#include <asm/vsyscall.h>
+
+/* LGUEST_TOP_ADDRESS comes from the Makefile */
+#define RESERVE_TOP_ADDRESS LGUEST_GUEST_TOP
+
+#define BOOT_PGTABLE "boot_level4_pgt"
+
+#endif

--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization

--DiL7RhKs8rK9YGuF--
