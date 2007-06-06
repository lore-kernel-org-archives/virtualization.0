From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: [PATCH] xen: disable all non-virtual devices
Date: Tue, 05 Jun 2007 18:23:54 -0700
Message-ID: <46660CAA.9000206@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

A domU Xen environment has no non-virtual drivers, so make sure
they're all disabled at once.  This noticeably speeds up boot time.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>

diff -r c79da0042c7d arch/i386/xen/setup.c
--- a/arch/i386/xen/setup.c	Tue Jun 05 18:17:30 2007 -0700
+++ b/arch/i386/xen/setup.c	Tue Jun 05 18:17:59 2007 -0700
@@ -93,4 +93,6 @@ void __init xen_arch_setup(void)
 	/* fill cpus_possible with all available cpus */
 	xen_fill_possible_map();
 #endif
+
+	paravirt_disable_iospace();
 }
