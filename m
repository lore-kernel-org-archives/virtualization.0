From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 01/15] preparation: provide hook to
	enable pgstes in user pagetable
Date: Sat, 22 Mar 2008 18:57:05 +0100
Message-ID: <20080322175705.GD6367__22144.5917188705$1206208845$gmane$org@osiris.boeblingen.de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030278.6690.52.camel@cotte.boeblingen.de.ibm.com>
	<47E29EC6.5050403@goop.org>
	<1206040405.8232.24.camel@nimitz.home.sr71.net>
	<47E2CAAC.6020903@de.ibm.com>
	<1206124176.30471.27.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1206124176.30471.27.camel@nimitz.home.sr71.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, hollisb@us.ibm.com, arnd@arndb.de, Linux Memory Management List <linux-mm@kvack.org>, carsteno@de.ibm.com, heicars2@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com, jeroney@us.ibm.com, borntrae@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

> What you've done with dup_mm() is probably the brute-force way that I
> would have done it had I just been trying to make a proof of concept or
> something.  I'm worried that there are a bunch of corner cases that
> haven't been considered.
> 
> What if someone else is poking around with ptrace or something similar
> and they bump the mm_users:
> 
> +       if (tsk->mm->context.pgstes)
> +               return 0;
> +       if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
> +           tsk->mm != tsk->active_mm || tsk->mm->ioctx_list)
> +               return -EINVAL;
> -------->HERE
> +       tsk->mm->context.pgstes = 1;    /* dirty little tricks .. */
> +       mm = dup_mm(tsk);
> 
> It'll race, possibly fault in some other pages, and those faults will be
> lost during the dup_mm().  I think you need to be able to lock out all
> of the users of access_process_vm() before you go and do this.  You also
> need to make sure that anyone who has looked at task->mm doesn't go and
> get a reference to it and get confused later when it isn't the task->mm
> any more.
> 
> > Therefore, we need to reallocate the page table after fork() 
> > once we know that task is going to be a hypervisor. That's what this 
> > code does: reallocate a bigger page table to accomondate the extra 
> > information. The task needs to be single-threaded when calling for 
> > extended page tables.
> > 
> > Btw: at fork() time, we cannot tell whether or not the user's going to 
> > be a hypervisor. Therefore we cannot do this in fork.
> 
> Can you convert the page tables at a later time without doing a
> wholesale replacement of the mm?  It should be a bit easier to keep
> people off the pagetables than keep their grubby mitts off the mm
> itself.

Yes, as far as I can see you're right. And whatever we do in arch code,
after all it's just a work around to avoid a new clone flag.
If something like clone() with CLONE_KVM would be useful for more
architectures than just s390 then maybe we should try to get a flag.

Oh... there are just two unused clone flag bits left. Looks like the
namespace changes ate up a lot of them lately.

Well, we could still play dirty tricks like setting a bit in current
via whatever mechanism which indicates child-wants-extended-page-tables
and then just fork and be happy.
