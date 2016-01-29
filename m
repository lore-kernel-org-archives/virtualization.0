From: "tip-bot for Michael S. Tsirkin" <tipbot@zytor.com>
Subject: [tip:locking/core] locking/x86: Use mb() around clflush()
Date: Fri, 29 Jan 2016 03:33:14 -0800
Message-ID: <tip-ca59809ff6d572ae58fc6bedf7500f5a60fdbd64@git.kernel.org>
References: <1453921746-16178-5-git-send-email-mst@redhat.com>
Reply-To: luto@amacapital.net, dvlasenk@redhat.com, bitbucket@online.de,
	oleg@redhat.com, len.brown@intel.com,
	torvalds@linux-foundation.org, peterz@infradead.org,
	tglx@linutronix.de, luto@kernel.org, akpm@linux-foundation.org,
	dbueso@suse.de, brgerst@gmail.com, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net, bp@alien8.de,
	paulmck@linux.vnet.ibm.com, hpa@zytor.com, mingo@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453921746-16178-5-git-send-email-mst@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-tip-commits@vger.kernel.org
Cc: len.brown@intel.com, dave@stgolabs.net, dvlasenk@redhat.com, akpm@linux-foundation.org, mst@redhat.com, bitbucket@online.de, brgerst@gmail.com, dbueso@suse.de, oleg@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, peterz@infradead.org, luto@amacapital.net, bp@alien8.de, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  ca59809ff6d572ae58fc6bedf7500f5a60fdbd64
Gitweb:     http://git.kernel.org/tip/ca59809ff6d572ae58fc6bedf7500f5a60fdbd64
Author:     Michael S. Tsirkin <mst@redhat.com>
AuthorDate: Thu, 28 Jan 2016 19:02:51 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 29 Jan 2016 09:40:10 +0100

locking/x86: Use mb() around clflush()

The following commit:

  f8e617f4582995f ("sched/idle/x86: Optimize unnecessary mwait_idle() resched IPIs")

adds memory barriers around clflush(), but this seems wrong for UP since
barrier() has no effect on clflush().  We really want MFENCE, so switch
to mb() instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <bitbucket@online.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization <virtualization@lists.linux-foundation.org>
Link: http://lkml.kernel.org/r/1453921746-16178-5-git-send-email-mst@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9f7c21c..9decee2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -418,9 +418,9 @@ static void mwait_idle(void)
 	if (!current_set_polling_and_test()) {
 		trace_cpu_idle_rcuidle(1, smp_processor_id());
 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
-			smp_mb(); /* quirk */
+			mb(); /* quirk */
 			clflush((void *)&current_thread_info()->flags);
-			smp_mb(); /* quirk */
+			mb(); /* quirk */
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
