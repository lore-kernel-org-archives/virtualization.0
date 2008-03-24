From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC/PATCH 01/15 v2] preparation: provide hook to enable pgstes
	in user pagetable
Date: Mon, 24 Mar 2008 14:50:02 -0700
Message-ID: <20080324145002.d59f9372.akpm__28142.2659442343$1206395590$gmane$org@linux-foundation.org>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206203560.7177.45.camel@cotte.boeblingen.de.ibm.com>
	<1206205357.7177.83.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206205357.7177.83.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: npiggin@suse.de, aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, borntraeger@de.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, schwidefsky@de.ibm.com, hugh@veritas.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, xiantao.zhang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 22 Mar 2008 18:02:37 +0100
Carsten Otte <cotte@de.ibm.com> wrote:

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> The SIE instruction on s390 uses the 2nd half of the page table page to
> virtualize the storage keys of a guest. This patch offers the s390_enable_sie
> function, which reorganizes the page tables of a single-threaded process to
> reserve space in the page table:
> s390_enable_sie makes sure that the process is single threaded and then uses
> dup_mm to create a new mm with reorganized page tables. The old mm is freed 
> and the process has now a page status extended field after every page table.
> 
> Code that wants to exploit pgstes should SELECT CONFIG_PGSTE.
> 
> This patch has a small common code hit, namely making dup_mm non-static.
> 
> Edit (Carsten): I've modified Martin's patch, following Jeremy Fitzhardinge's
> review feedback. Now we do have the prototype for dup_mm in
> include/linux/sched.h.
> 
> ...
>
> --- linux-host.orig/kernel/fork.c
> +++ linux-host/kernel/fork.c
> @@ -498,7 +498,7 @@ void mm_release(struct task_struct *tsk,
>   * Allocate a new mm structure and copy contents from the
>   * mm structure of the passed in task structure.
>   */
> -static struct mm_struct *dup_mm(struct task_struct *tsk)
> +struct mm_struct *dup_mm(struct task_struct *tsk)
>  {
>  	struct mm_struct *mm, *oldmm = current->mm;
>  	int err;

ack

> --- linux-host.orig/include/linux/sched.h
> +++ linux-host/include/linux/sched.h
> @@ -1758,6 +1758,8 @@ extern void mmput(struct mm_struct *);
>  extern struct mm_struct *get_task_mm(struct task_struct *task);
>  /* Remove the current tasks stale references to the old mm_struct */
>  extern void mm_release(struct task_struct *, struct mm_struct *);
> +/* Allocate a new mm structure and copy contents from tsk->mm */
> +extern struct mm_struct *dup_mm(struct task_struct *tsk);
>  
>  extern int  copy_thread(int, unsigned long, unsigned long, unsigned long, struct task_struct *, struct pt_regs *);
>  extern void flush_thread(void);
> 

hm, why did we put these in sched.h?

oh well - acked-by-me.
