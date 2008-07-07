From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC 3/4] xen: use lock-byte spinlock implementation
Date: Mon, 07 Jul 2008 12:07:52 -0700
Message-ID: <20080707190838.607667440__46568.4517207139$1215458438$gmane$org@goop.org>
References: <20080707190749.299430659@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=xen-use-byte-locks.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Switch to using the lock-byte spinlock implementation, to avoid the
worst of the performance hit from ticket locks.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Cc: Thomas Friebel <thomas.friebel@amd.com>
---
 arch/x86/xen/smp.c |    1 +
 1 file changed, 1 insertion(+)

===================================================================
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -430,4 +430,5 @@
 {
 	smp_ops = xen_smp_ops;
 	xen_fill_possible_map();
+	paravirt_use_bytelocks();
 }

-- 
