From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 04/24] Xen-paravirt_ops: ignore vgacon if hardware not present
Date: Wed, 21 Feb 2007 12:52:58 -0800
Message-ID: <20070221205322.735730912@goop.org>
References: <20070221205254.169835700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=vgacon-ignore-uninitialized.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -372,7 +372,8 @@ static const char *vgacon_startup(void)
 	}
 =

 	/* VGA16 modes are not handled by VGACON */
-	if ((ORIG_VIDEO_MODE =3D=3D 0x0D) ||	/* 320x200/4 */
+	if ((ORIG_VIDEO_MODE =3D=3D 0x00) ||	/* SCREEN_INFO not initialized */
+	    (ORIG_VIDEO_MODE =3D=3D 0x0D) ||	/* 320x200/4 */
 	    (ORIG_VIDEO_MODE =3D=3D 0x0E) ||	/* 640x200/4 */
 	    (ORIG_VIDEO_MODE =3D=3D 0x10) ||	/* 640x350/4 */
 	    (ORIG_VIDEO_MODE =3D=3D 0x12) ||	/* 640x480/4 */

-- =
