From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 4/4] paravirt,xen: correct xen_nopvspin case
Date: Tue,  5 Sep 2017 15:24:44 +0200
Message-ID: <20170905132444.7163-5-jgross__45427.6714394384$1504617980$gmane$org@suse.com>
References: <20170905132444.7163-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170905132444.7163-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, peterz@infradead.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, longman@redhat.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

With the boot parameter "xen_nopvspin" specified a Xen guest should not
make use of paravirt spinlocks, but behave as if running on bare
metal. This is not true, however, as the qspinlock code will fall back
to a test-and-set scheme when it is detecting a hypervisor.

In order to avoid this set the virt_spin_lock pvops function to
_paravirt_false() in case xen_nopvspin has been specified.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/spinlock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 25a7c4302ce7..c01cedfa745d 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -129,6 +129,8 @@ void __init xen_init_spinlocks(void)
 
 	if (!xen_pvspin) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
+		pv_lock_ops.virt_spin_lock =
+			__PV_IS_CALLEE_SAVE(_paravirt_false);
 		return;
 	}
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
-- 
2.12.3
