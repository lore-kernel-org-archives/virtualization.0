From: Zhu Yanhai <zhu.yanhai@gmail.com>
Subject: Xen PV ABI on FPU doesn't match with pvops kernel FPU code, reducing
	to a serious memory data damage
Date: Thu, 7 Nov 2013 12:15:01 +0800
Message-ID: <CAC8teKX4kSFBdDzGSqTT=6K3d7g=TVOL0RcmxdcLx0bMP-jZow__42825.0676639893$1383806603$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Ian Campbell <Ian.Campbell@citrix.com>, George Dunlap <George.Dunlap@eu.citrix.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi guys,
The PV ABI of xen will clear CR0.TS before trapping into the PV guest
kernel's exception handler, so the exception handler in guest kernel
runs with CR0.TS clear at the very beginning (which is different with
on baremetal). In Xenolinux and mainline Linux kernel before 2.6.26
everything is fine since they don't sleep nor enable interrupts during
the handler, however the current mainline pvops kernel has a schedule
window opened within it.

[Pls see the code below,

void math_state_restore(void)
{
    struct task_struct *tsk = current;

    if (!tsk_used_math(tsk)) {
        local_irq_enable();                       <<<< Here it might
open a schedule window
        /*
         * does a slab alloc which can sleep
         */
        if (init_fpu(tsk)) {
            /*
             * ran out of memory!
             */
            do_group_exit(SIGKILL);
            return;
        }
        local_irq_disable();                      <<<< Here it closes
    }

    __thread_fpu_begin(tsk);

    /*
     * Paranoid restore. send a SIGSEGV if we fail to restore the state.
     */
    if (unlikely(restore_fpu_checking(tsk))) {
        drop_init_fpu(tsk);
        force_sig(SIGSEGV, tsk);
        return;
    }

    tsk->fpu_counter++;
}
]

This can cause serious data damage against xen pv guests (including
dom0 kernel), we have encountered this issue both in stress test and
production systems. Please take a look at
http://comments.gmane.org/gmane.comp.emulators.xen.devel/176970 for
more discussions and test cases.

Ian and George, we have confirmed this is the very root cause of
http://comments.gmane.org/gmane.comp.emulators.xen.devel/175491

The xen ABI is part of history which can't be changed, as well as
simply adding a couple of stts()-clts() around the enabling/disabling
interrupts is a really ugly hack.
Maintainers, any thoughts?

--
Thanks,
Zhu Yanhai
