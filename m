From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 1/2] Makefile for common loader
Date: Mon, 2 Apr 2007 16:46:10 -0300
Message-ID: <20070402194610.GB7711@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s/l3CgOIzMHHjg/5"
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
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch moves lguest's loader Makefile one level bellow, and adds
arch-specific code to arch directories

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>

-- 
Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lgmake.patch"

--- i386/Makefile	2007-04-02 16:11:56.000000000 -0300
+++ Makefile	2007-04-02 16:11:56.000000000 -0300
@@ -1,12 +1,13 @@
 # This creates the demonstration utility "lguest" which runs a Linux guest.
 
-# We rely on CONFIG_PAGE_OFFSET to know where to put lguest binary.
-# Some shells (dash - ubunu) can't handle numbers that big so we cheat.
-include ../../../.config
-LGUEST_GUEST_TOP := ($(CONFIG_PAGE_OFFSET) - 0x08000000)
 
-CFLAGS:=-Wall -Wmissing-declarations -Wmissing-prototypes -O3 \
-	-static -DLGUEST_GUEST_TOP="$(LGUEST_GUEST_TOP)" -Wl,-T,lguest.lds
+#we could uname -i, but it seems to return unknown on a bunch locations
+ARCH:=$(shell uname -m | sed s/i[3456]86/i386/)
+
+include $(ARCH)/defines
+
+CFLAGS:=-g -Wall -Wmissing-declarations -Wmissing-prototypes -O3 \
+	-static -DLGUEST_GUEST_TOP="$(LGUEST_GUEST_TOP)" -Wl,-T,lguest.lds -I$(ARCH)
 LDLIBS:=-lz
 
 all: lguest.lds lguest
--- /dev/null	2007-04-02 15:35:49.510433377 -0300
+++ i386/defines	2007-04-02 16:13:43.000000000 -0300
@@ -0,0 +1,4 @@
+# We rely on CONFIG_PAGE_OFFSET to know where to put lguest binary.
+# Some shells (dash - ubunu) can't handle numbers that big so we cheat.
+include ../../.config
+LGUEST_GUEST_TOP := ($(CONFIG_PAGE_OFFSET) - 0x08000000)
--- /dev/null	2007-04-02 15:35:49.510433377 -0300
+++ x86_64/defines	2007-04-02 16:11:56.000000000 -0300
@@ -0,0 +1,4 @@
+# For now on x86_64 we'll hard code the location of the lguest binary loader.
+# But when we can get a relocatable kernel, we'll have to work to make this
+# dynamic.
+LGUEST_GUEST_TOP := 0x7f000000

--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization

--s/l3CgOIzMHHjg/5--
