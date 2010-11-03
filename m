From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 14/20] x86/ticketlock: loosen ordering restraints on unlock
Date: Wed,  3 Nov 2010 10:59:55 -0400
Message-ID: <1de42e70d22a5078d65d6d943da06c9ea0f4691b.1288794124.git.jeremy.fitzhardinge__46183.7967312478$1288797728$gmane$org@citrix.com>
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

It's only necessary to prevent the compiler from reordering code out of
the locked region past the unlock.  Putting too many barriers in prevents
the compiler from generating the best code when PV spinlocks are enabled.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 arch/x86/include/asm/spinlock.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index b9a1aae..d6de5e7 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -46,9 +46,7 @@ static __always_inline void __ticket_unlock_release(struct arch_spinlock *lock)
 #else
 static __always_inline void __ticket_unlock_release(struct arch_spinlock *lock)
 {
-	barrier();
 	lock->tickets.head++;
-	barrier();
 }
 #endif
 
@@ -184,7 +182,11 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	__ticket_t next = lock->tickets.head + 1;
+	__ticket_t next;
+
+	barrier();		/* prevent reordering out of locked region */
+
+	next = lock->tickets.head + 1;
 	__ticket_unlock_release(lock);
 	__ticket_unlock_kick(lock, next);
 }
-- 
1.7.2.3
