From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: State of Xen in upstream Linux
Date: Wed, 30 Jul 2008 17:51:37 -0700
Message-ID: <48910C99.10606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Well, the mainline kernel just hit 2.6.27-rc1, so it's time for an
update about what's new with Xen.  I'm trying to aim this at both the
user and developer audiences, so bear with me if I seem to be waffling
about something irrelevant.


2.6.26 was mostly a bugfix update compared with 2.6.25, with a few small
issues fixed up.  Feature-wise, it supports 32-bit domU with the core
devices needed to make it work (netfront, blockfront, console).  It also
has xen-pvfb support, which means you can run the standard X server
without needing to set up Xvnc.

I don't know of any bugs in 2.6.26, so I'd recommend you try it out for
all your 32-bit domU needs.  It has had fairly wide exposure in Fedora
kernels, so I'd rank its stability as fairly high.  If you're migrating
from 2.6.18-xen, then there'll be a few things you need to pay attention
to.  http://wiki.xensource.com/xenwiki/XenParavirtOps should help, but
if it doesn't, please either fix it and/or ask!


2.6.27 will be a much more interesting release.  It has two major
feature additions: save/restore/migrate (including checkpoint and live
migration), and x86-64 support.  In keeping with the overall unification
of i386 and x86-64 code in the kernel, the 32- and 64-bit Xen code is
largely shared, so they have feature parity.

The Xen support seems fairly stable in linux-2.6.git, but the kernel is
still at -rc1, so lots of other things will tend to break.  I encourage
you to try it out if you're comfortable with what's still a fairly high
rate of change.

My current patch stack is pretty much empty - everything has been merged
into linux-2.6.git - so it makes a good base for any changes you may have


Now that Xen can directly boot a bzImage format kernel, distros have a
lot of flexibilty in how they package Xen.  A single grub.conf entry can
be used to boot either a native kernel (via normal grub), or a
paravirtualized Xen kernel (via pygrub), without modification.

Fedora 9's kernel-xen package has been based on the mainline kernel from
the outset, but it is still packaged as a separate kernel.  kernel-xen
has been dropped from rawhide (what will become Fedora 10), and all Xen
support - both 32 and 64 bit - has been rolled into the main kernel
package.


So, what's next?

The obvious big piece of missing functionality is dom0 support.  That
will be my focus in this next kernel development window, and I hope
we'll have it merged into 2.6.28.  Some roadblock may appear which
prevents this (kernel development is always a bit uncertain), but that's
the current plan.

We're planning on setting up a xen.git on xen.org somewhere.  We still
need to work out the precise details, but my expectation is that will
become the place where dom0 work continues, and I also hope that other
Xen developers will start using it as the base for their own Xen work. 
Expect to see some more concrete details over the next week or so.


What can I do?

I'm glad you asked.  Here's my current TODO list.  These are mostly
fairly small-scale projects which just need some attention.  I'd love
people to adopt things from this list.

x86-64: SMP broken with CONFIG_PREEMPT

    It crashes early after bringing up a second CPU when preempt is
    enabled.  I think it's failing to set up the CPU topology properly,
    and leaving something uninitialized.  The desired topology is the
    simplest possible - one core per package, no SMT/HT, no multicore,
    no shared caches.  It should be simple to set up.

irq balancing causes lockups

    Using irq balancing causes the kernel to lock up after a while.  It
    looks like it's losing interrupts.  It's probably dropping
    interrupts if you migrate an irq beween vcpus while an event is
    pending.  Shouldn't be too hard to fix.  (In the meantime, the
    workaround is to make sure that you don't enable in-kernel irq
    balancing, and you don't run irqbalanced.)

block device hotplug

    Hotplugging devices should work already, but I haven't really tested
    it.  Need to make sure that both the in-kernel driver stuff works
    properly, and that udev events are raised properly, scripts run,
    device nodes added - and conversely for unplug.  Also, a modular
    xen-blockfront.ko should be unloadable.

net device hotplug

    Similar to block devices, but with a slight extra complication.  If
    the driver has outstanding granted pages, then the module can't be
    immediately unloaded, because you can't free the pages if dom0 has a
    reference to them.  My thought is to add a simple kernel thread
    which takes ownership of unwanted granted pages: it would
    periodically try to ungrant them, and if successful, free the page. 
    That means that netfront could hand ownership of those pages over to
    that thread, and unload immediately.

Performance measurement and tuning

    By design, the paravirt-ops-based Xen implementation should have
    high performance.  It uses batching where-ever possible, late
    pin/early unpin, and all the other performance tricks available to a
    Xen kernel.  However, my emphasis has been on correctness and
    features, so I have not extensively benchmarked or performance tuned
    the code.  There's plenty of scope for measuring both synthetic and
    real-world benchmarks (ideally, applications you really care about),
    and try to work out how things can be tuned.

    One thing that has already come to light is a general regression in
    context switch time compared to 2.6.18.8-xen.  It's unclear where
    it's coming from; a close look at the actual context switch code
    itself shows that it should perform the same as 2.6.18-xen (same
    number of hypercalls performed, for example).

    This would be an excellent opportunity to become familiar with Xen's
    tracing and performance measurement tools...

Balloon driver

    The current in-kernel balloon driver only supports shrinking and
    regrowing a domain up to its original size.  There's no support for
    growing a domain beyond that.

    My plan is to use hotplug memory to add new memory to the system.  I
    have some prototype code to do this, which works OK, but the hotplug
    memory subsystem needs some modifications to really deal with the
    kinds of incremental memory increases that we need for ballooning
    (it assumes that you're actually plugging in physical DIMMs).

    The other area which needs attention is some sanity checking when
    deflating a domain, to prevent killing the domain by stealing too
    much memory.  2.6.18-xen uses a simple static minimum memory
    heuristic based on the original size of the domain.  This helps, but
    doesn't really prevent over-shrinking a domain which is already
    under memory pressure.  A better approach might be to register a
    shrinker callback, which means that the balloon driver can see how
    much memory pressure the system is under by looking getting feedback
    from it.

    A more advanced project is to modify the kernel VM subsystem to
    measure refault distance, which is how long a page is evicted before
    being faulted back in again.  That measurement can tell you how much
    more memory you need to add to a domain in order to get the fault
    rate below a given rate.

gdb gives bad info in a 64-bit domain

    For some reason, gdb doesn't work properly.  If you set a
    breakpoint, the program will stop as expected, but the register
    state will be wrong.  Other users of the ptrace syscall, such as
    strace, seem to get good results, so I'm not sure what's going on
    here.  It might be a simple fix, or symptomatic of a more serious
    problem.  But it needs investigation first.

My Pet Project

    What's missing?  What do you depend on?  What's needed before you
    can use mainline Xen as your sole Xen kernel?

Thanks,
    J
