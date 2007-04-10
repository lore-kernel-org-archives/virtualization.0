From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 1/10] I386 sysenter arch pages fix.patch
Date: Mon, 9 Apr 2007 17:06:02 -0700
Message-ID: <200704100006.l3A062AL020596@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

In compat mode, the return value here was uninitialized.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 1fda49a076ed arch/i386/kernel/sysenter.c
--- a/arch/i386/kernel/sysenter.c	Fri Apr 06 14:25:09 2007 -0700
+++ b/arch/i386/kernel/sysenter.c	Fri Apr 06 14:27:31 2007 -0700
@@ -254,7 +254,7 @@ int arch_setup_additional_pages(struct l
 {
 	struct mm_struct *mm =3D current->mm;
 	unsigned long addr;
-	int ret;
+	int ret =3D 0;
 	bool compat;
 =

 	down_write(&mm->mmap_sem);
