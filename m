From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/7] More lguest massage.
Date: Thu, 17 Jan 2008 22:35:46 -0200
Message-ID: <12006165651341-git-send-email-gcosta__28271.1358428516$1200616664$gmane$org@redhat.com>
References: <1200616550283-git-send-email-gcosta@redhat.com>
	<12006165571406-git-send-email-gcosta@redhat.com>
	<1200616561270-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200616561270-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

inour new model, pages are assigned to a virtual cpu, not to a guest.
Wemove it to the lg_cpu structure.

Signed-off-by:Glauber de Oliveira Costa <gcosta@redhat.com>
---
drivers/lguest/lg.h          |    3 ++-
drivers/lguest/lguest_user.c |    8 ++++----
drivers/lguest/x86/core.c    |    4 ++--
3 files changed, 8 insertions(+), 7 deletions(-)

diff--git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index11a3ae2..eb473a5 100644
---a/drivers/lguest/lg.h
+++b/drivers/lguest/lg.h
@@-57,6 +57,8 @@ struct lg_cpu {
	unsigned long regs_page;
	struct lguest_regs *regs;

+	structlguest_pages *last_pages;
+
	int cpu_pgd; /* which pgd this cpu is currently using */

	/* If a hypercall was asked for, this points to the arguments. */
@@-92,7 +94,6 @@ struct lguest

	/* Bitmap of what has changed: see CHANGED_* above. */
	int changed;
-	structlguest_pages *last_pages;

	struct pgdir pgdirs[4];

diff--git a/drivers/lguest/lguest_user.c b/drivers/lguest/lguest_user.c
indexf4f6df8..a87fca6 100644
---a/drivers/lguest/lguest_user.c
+++b/drivers/lguest/lguest_user.c
@@-131,6 +131,10 @@ static int lg_cpu_start(struct lg_cpu *cpu, unsigned id, unsigned long start_ip)
	 * reference, it is destroyed before close() is called. */
	cpu->mm = get_task_mm(cpu->tsk);

+	/*We remember which CPU's pages this Guest used last, for optimization
+	* when the same Guest runs on the same CPU twice. */
+	cpu->last_pages= NULL;
+
	return 0;
}

@@-192,10 +196,6 @@ static int initialize(struct file *file, const unsigned long __user *input)
	if (err)
		goto free_regs;

-	/*We remember which CPU's pages this Guest used last, for optimization
-	* when the same Guest runs on the same CPU twice. */
-	lg->last_pages= NULL;
-
	/* We keep our "struct lguest" in the file's private_data. */
	file->private_data = lg;

diff--git a/drivers/lguest/x86/core.c b/drivers/lguest/x86/core.c
index25f48fd..3e457f2 100644
---a/drivers/lguest/x86/core.c
+++b/drivers/lguest/x86/core.c
@@-80,9 +80,9 @@ static void copy_in_guest_info(struct lg_cpu *cpu, struct lguest_pages *pages)
	 * same Guest we ran last time (and that Guest hasn't run anywhere else
	 * meanwhile).  If that's not the case, we pretend everything in the
	 * Guest has changed. */
-	if(__get_cpu_var(last_cpu) != cpu || lg->last_pages != pages) {
+	if(__get_cpu_var(last_cpu) != cpu || cpu->last_pages != pages) {
		__get_cpu_var(last_cpu) = cpu;
-		lg->last_pages= pages;
+		cpu->last_pages= pages;
		lg->changed = CHANGED_ALL;
	}

--
1.5.0.6
