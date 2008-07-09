From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] x86: paravirt spinlocks, modular build fix  (was: Re:
	[PATCH RFC 0/4] Paravirtual spinlocks)
Date: Wed, 9 Jul 2008 14:39:05 +0200
Message-ID: <20080709123905.GA16340__42889.9083439775$1215607379$gmane$org@elte.hu>
References: <20080707190749.299430659@goop.org>
	<20080709122852.GA30579@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080709122852.GA30579@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>
List-Id: virtualization@lists.linuxfoundation.org


another small fixlet.

	Ingo

----------------->
commit 0ea0f032767f41fb0a9586ab6acb5c1408ef16c5
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jul 9 14:39:15 2008 +0200

    x86: paravirt spinlocks, modular build fix
    
    fix:
    
      MODPOST 408 modules
    ERROR: "pv_lock_ops" [net/dccp/dccp.ko] undefined!
    ERROR: "pv_lock_ops" [fs/jbd2/jbd2.ko] undefined!
    ERROR: "pv_lock_ops" [drivers/media/common/saa7146_vv.ko] undefined!
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6aa8aed..3edfd7a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -472,6 +472,7 @@ struct pv_lock_ops pv_lock_ops = {
 	.spin_unlock = __ticket_spin_unlock,
 #endif
 };
+EXPORT_SYMBOL_GPL(pv_lock_ops);
 
 EXPORT_SYMBOL_GPL(pv_time_ops);
 EXPORT_SYMBOL    (pv_cpu_ops);
