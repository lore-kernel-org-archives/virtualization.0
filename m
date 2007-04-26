From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Fix lguest oops when guest dies while receiving I/O
Date: Thu, 26 Apr 2007 20:45:10 +1000
Message-ID: <1177584310.30071.60.camel__23927.6818851524$1177584392$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

lguest needs to hold a reference to its task in case it exits while
another Guest is sending it I/O.  Otherwise we can oops in
access_process_vm->get_task_mm->task_lock().

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest_user.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

===================================================================
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -107,7 +107,8 @@ static int initialize(struct file *file,
 	setup_regs(lg->regs, args[2]);
 	setup_guest_gdt(lg);
 	lg->tsk = current;
-	lg->mm = get_task_mm(current);
+	get_task_struct(lg->tsk);
+	lg->mm = get_task_mm(lg->tsk);
 	lg->last_pages = NULL;
 	mutex_unlock(&lguest_lock);
 
@@ -160,6 +161,7 @@ static int close(struct inode *inode, st
 	mutex_lock(&lguest_lock);
 	release_all_dma(lg);
 	free_guest_pagetable(lg);
+	put_task_struct(lg->tsk);
 	mmput(lg->mm);
 	if (!IS_ERR(lg->dead))
 		kfree(lg->dead);
