From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 4/5] x86: use mb() around clflush
Date: Thu, 28 Jan 2016 19:02:51 +0200
Message-ID: <1453921746-16178-5-git-send-email-mst__33477.8066179298$1454000612$gmane$org@redhat.com>
References: <1453921746-16178-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1453921746-16178-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Oleg Nesterov <oleg@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

commit f8e617f4582995f7c25ef25b4167213120ad122b ("sched/idle/x86:
Optimize unnecessary mwait_idle() resched IPIs") adds
memory barriers around clflush, but this seems wrong
for UP since barrier() has no effect on clflush.
We really want mfence so switch to mb() instead.

Cc: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
-- 
MST
