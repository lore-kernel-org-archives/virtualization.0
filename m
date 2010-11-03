From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 17/20] x86/ticketlock: clarify barrier in arch_spin_lock
Date: Wed,  3 Nov 2010 10:59:58 -0400
Message-ID: <ba397357a160b73c800a608a52256544904c6324.1288794124.git.jeremy.fitzhardinge__16900.8183795542$1288797271$gmane$org@citrix.com>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
In-Reply-To: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Make sure the barrier in arch_spin_lock is definitely in the code path.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 arch/x86/include/asm/spinlock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 158b330..c7455e1 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -151,13 +151,13 @@ static __always_inline void arch_spin_lock(struct arch_spinlock *lock)
 
 		do {
 			if (inc.head == inc.tail)
-				return;
+				goto out;
 			cpu_relax();
 			inc.head = ACCESS_ONCE(lock->tickets.head);
 		} while (--count);
 		__ticket_lock_spinning(lock, inc.tail);
 	}
-	barrier();		/* make sure nothing creeps before the lock is taken */
+out:	barrier();		/* make sure nothing creeps before the lock is taken */
 }
 
 static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
-- 
1.7.2.3
