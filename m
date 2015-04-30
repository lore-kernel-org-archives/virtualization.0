From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/6] x86: use macro instead of "0" for setting
	TICKET_SLOWPATH_FLAG
Date: Thu, 30 Apr 2015 12:53:58 +0200
Message-ID: <1430391243-7112-2-git-send-email-jgross__48555.8683089495$1430453259$gmane$org@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1430391243-7112-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

For paravirtualized spinlocks setting the "slowpath" flag in
__ticket_enter_slowpath() is done via setting bit "0" in
lock->tickets.head instead of using a macro.

Change this by defining an appropriate macro.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/spinlock.h       | 3 ++-
 arch/x86/include/asm/spinlock_types.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index cf87de3..8ceec8d 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -46,7 +46,8 @@ static __always_inline bool static_key_false(struct static_key *key);
 
 static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
 {
-	set_bit(0, (volatile unsigned long *)&lock->tickets.head);
+	set_bit(TICKET_SLOWPATH_BIT,
+		(volatile unsigned long *)&lock->tickets.head);
 }
 
 #else  /* !CONFIG_PARAVIRT_SPINLOCKS */
diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index 5f9d757..579409a 100644
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -4,8 +4,9 @@
 #include <linux/types.h>
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define TICKET_SLOWPATH_BIT	0
 #define __TICKET_LOCK_INC	2
-#define TICKET_SLOWPATH_FLAG	((__ticket_t)1)
+#define TICKET_SLOWPATH_FLAG	((__ticket_t)(1 << TICKET_SLOWPATH_BIT))
 #else
 #define __TICKET_LOCK_INC	1
 #define TICKET_SLOWPATH_FLAG	((__ticket_t)0)
-- 
2.1.4
