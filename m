From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 02/21] Xen-paravirt: Handle a zero-sized VT console
Date: Tue, 13 Feb 2007 14:17:31 -0800
Message-ID: <20070213221829.513618819@goop.org>
References: <20070213221729.772002682@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline; filename=vgacon-fix-zero-size.patch
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

If we're running under Xen, then there's no VT console.  This results
in vc->vc_screenbuf_size =3D=3D 0, which causes alloc_bootmem to panic.
Don't bother allocating a vc_screenbuf if its going to be 0 sized.

(Cleanup: remove unnecessary cast)

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Gerd Hoffmann <kraxel@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2638,7 +2638,10 @@ static int __init con_init(void)
 	for (currcons =3D 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d =3D vc =3D alloc_bootmem(sizeof(struct vc_data));
 		visual_init(vc, currcons, 1);
-		vc->vc_screenbuf =3D (unsigned short *)alloc_bootmem(vc->vc_screenbuf_si=
ze);
+
+		vc->vc_screenbuf =3D NULL;
+		if (vc->vc_screenbuf_size)
+			vc->vc_screenbuf =3D alloc_bootmem(vc->vc_screenbuf_size);
 		vc->vc_kmalloced =3D 0;
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);

-- =
