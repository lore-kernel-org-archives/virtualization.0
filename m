From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [patch 02/21] Xen-paravirt: Handle a zero-sized VT
	console
Date: Wed, 14 Feb 2007 10:24:47 +0100
Message-ID: <45D2D55F.4060605@suse.de>
References: <20070213221729.772002682@goop.org>
	<20070213221829.513618819@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040403020007080106070803"
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070213221829.513618819@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------040403020007080106070803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeremy Fitzhardinge wrote:
> If we're running under Xen, then there's no VT console.  This results
> in vc->vc_screenbuf_size == 0, which causes alloc_bootmem to panic.
> Don't bother allocating a vc_screenbuf if its going to be 0 sized.

NAK.

The *real* problem is that the real-mode boot code never ever runs, thus
SCREEN_INFO is not initialized (all zeros), and vgacon doesn't catch
that case.  Instead it thinks it runs on a EGA card with 0 lines and 0
columns.

So better fix vgacon to catch this and switch to the 80x25 dummy console
instead, patch attached.

cheers,

  Gerd


--------------040403020007080106070803
Content-Type: text/plain;
 name="vgacon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vgacon"

---
 drivers/video/console/vgacon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: paravirt-2.6.20-hg749/drivers/video/console/vgacon.c
===================================================================
--- paravirt-2.6.20-hg749.orig/drivers/video/console/vgacon.c
+++ paravirt-2.6.20-hg749/drivers/video/console/vgacon.c
@@ -372,7 +372,8 @@ static const char *vgacon_startup(void)
 	}
 
 	/* VGA16 modes are not handled by VGACON */
-	if ((ORIG_VIDEO_MODE == 0x0D) ||	/* 320x200/4 */
+	if ((ORIG_VIDEO_MODE == 0x00) ||	/* SCREEN_INFO not initialized */
+	    (ORIG_VIDEO_MODE == 0x0D) ||	/* 320x200/4 */
 	    (ORIG_VIDEO_MODE == 0x0E) ||	/* 640x200/4 */
 	    (ORIG_VIDEO_MODE == 0x10) ||	/* 640x350/4 */
 	    (ORIG_VIDEO_MODE == 0x12) ||	/* 640x480/4 */

--------------040403020007080106070803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--------------040403020007080106070803--
