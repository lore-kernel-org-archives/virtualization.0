From: James Morris <jmorris@redhat.com>
Subject: [PATCH] lhype: Add LFS support to lhype_add for disk images
Date: Wed, 15 Nov 2006 12:29:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0611151227410.26032-100000@redline.boston.redhat.com>
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

This patch allows lhype_add to open disk image files larger than 2GB.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

---

diff -r 82d084b15417 drivers/lhype/lhype_add.c
--- a/drivers/lhype/lhype_add.c	Wed Nov 15 00:58:18 2006 -0500
+++ b/drivers/lhype/lhype_add.c	Wed Nov 15 01:01:35 2006 -0500
@@ -329,7 +329,7 @@ static int set_up_block_device(const cha
 	struct stat st;
 	int fd;
 =

-	fd =3D open(name, O_RDWR, 0);
+	fd =3D open(name, O_RDWR|O_LARGEFILE, 0);
 	if (fd < 0)
 		err(1, "Opening %s", name);
 =
