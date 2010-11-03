From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 20/20] x86/ticketlock: rename ticketpair to head_tail
Date: Wed,  3 Nov 2010 11:00:01 -0400
Message-ID: <4c3a64ecac8b57d715238bb1ae55c0079879430d.1288794124.git.jeremy.fitzhardinge__2119.37487260929$1288797734$gmane$org@citrix.com>
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

Make it clearer what fields head_tail is actually overlapping with.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 arch/x86/include/asm/spinlock.h       |    2 +-
 arch/x86/include/asm/spinlock_types.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index a16b6e4..6850884 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -174,7 +174,7 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 	new.slock = tmp.slock + (1 << TICKET_SHIFT);
 
-	ret = cmpxchg(&lock->ticketpair, tmp.slock, new.slock) == tmp.slock;
+	ret = cmpxchg(&lock->head_tail, tmp.slock, new.slock) == tmp.slock;
 	barrier();		/* just make nothing creeps before lock is claimed */
 
 	return ret;
diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index 307ef0b..df031ec 100644
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -24,7 +24,7 @@ typedef struct arch_spinlock {
 		struct {
 			__ticket_t waiting;
 			union {
-				__ticketpair_t ticketpair;
+				__ticketpair_t head_tail;
 				struct __raw_tickets {
 					__ticket_t head, tail;
 				} tickets;
@@ -38,7 +38,7 @@ typedef struct arch_spinlock {
 #else
 typedef struct arch_spinlock {
 	union {
-		__ticketpair_t ticketpair;
+		__ticketpair_t head_tail;
 		struct __raw_tickets {
 			__ticket_t head, tail;
 		} tickets;
-- 
1.7.2.3
