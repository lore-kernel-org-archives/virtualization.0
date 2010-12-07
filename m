From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH 1/3]: An implementation of HyperV KVP functionality
Date: Tue, 07 Dec 2010 15:09:52 -0700
Message-ID: <4CFE4E40020000300009170B@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartCAE775A0.0__="
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org
Cc: Zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <shemminger@vyatta.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

--=__PartCAE775A0.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch is re-based on the latest linux-next tree.

From: K. Y. Srinivasan <ksrinivasan@novell.com>
Subject: Reserve a connector index for implementing HyperV Key Value Pair
(KVP) functionality.

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>

Index: linux.trees.git/include/linux/connector.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.trees.git.orig/include/linux/connector.h	2010-11-05 =
16:45:32.000000000 -0400
+++ linux.trees.git/include/linux/connector.h	2010-12-07 06:58:34.0000000=
00 -0500
@@ -42,8 +42,9 @@
 #define CN_VAL_DM_USERSPACE_LOG		0x1
 #define CN_IDX_DRBD			0x8
 #define CN_VAL_DRBD			0x1
+#define CN_KVP_IDX			0x9	/* HyperV KVP */
=20
-#define CN_NETLINK_USERS		8
+#define CN_NETLINK_USERS		9
=20
 /*
  * Maximum connector's message size.



--=__PartCAE775A0.0__=
Content-Type: text/plain; name="kvp_connector.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="kvp_connector.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0ASubject: Reserve a =
connector index for implementing HyperV Key Value Pair=0A(KVP) functionalit=
y.=0A=0ASigned-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0AIndex=
: linux.trees.git/include/linux/connector.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0A--- linux.trees.git.orig/include/linux/connector=
.h	2010-11-05 16:45:32.000000000 -0400=0A+++ linux.trees.git/include/l=
inux/connector.h	2010-12-07 06:58:34.000000000 -0500=0A@@ -42,8 =
+42,9 @@=0A #define CN_VAL_DM_USERSPACE_LOG		0x1=0A #define =
CN_IDX_DRBD			0x8=0A #define CN_VAL_DRBD			=
0x1=0A+#define CN_KVP_IDX			0x9	/* HyperV KVP =
*/=0A =0A-#define CN_NETLINK_USERS		8=0A+#define CN_NETLINK_USE=
RS		9=0A =0A /*=0A  * Maximum connector's message size.=0A
--=__PartCAE775A0.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--=__PartCAE775A0.0__=--
