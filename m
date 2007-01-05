From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 2/3] Vmi initialize fs for smp
Date: Thu, 4 Jan 2007 20:35:30 -0800
Message-ID: <200701050435.l054ZUO7005541@zach-dev.vmware.com>
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
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that Jeremy's change to move the kernel PDA to %fs has arrived,
convert the AP processor setup for SMP to use FS instead of GS.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 2ac108843573 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Jan 04 20:01:52 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Thu Jan 04 20:02:42 2007 -0800
@@ -533,8 +533,8 @@ vmi_startup_ipi_hook(int phys_apicid, un
 =

 	ap.ds =3D __USER_DS;
 	ap.es =3D __USER_DS;
-	ap.fs =3D 0;
-	ap.gs =3D __KERNEL_PDA;
+	ap.fs =3D __KERNEL_PDA;
+	ap.gs =3D 0;
 =

 	ap.eflags =3D 0;
 =
