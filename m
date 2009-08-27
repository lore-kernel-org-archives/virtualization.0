From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Extending virtio_console to support multiple ports
Date: Thu, 27 Aug 2009 14:07:03 +1000
Message-ID: <1251346023.20467.21.camel__44065.0292359807$1251346115$gmane$org@pasglop>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090826154552.GA31910@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, alan@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2009-08-26 at 21:15 +0530, Amit Shah wrote:

> 
> > - Convert hvc's usage of spinlocks to mutexes. I've no idea how this
> >   will play out; I'm no expert here. But I did try doing this and so far
> >   it all looks OK. No lockups, lockdep warnings, nothing. I have full
> >   debugging enabled. But this doesn't mean it's right.
> 
> So just to test this further I added the capability to have more than
> one hvc console spawn from virtio_console, created two consoles and did
> a 'cat' of a file in each of the virtio-consoles. It's been running for
> half an hour now without any badness. No spew in debug logs too.
> 
> I also checked the code in hvc_console.c that takes the spin_locks.
> Nothing there that runs from (or needs to run from) interrupt context.
> So the change to mutexes does seem reasonable. Also, the spinlock code
> was added really long back -- git blame shows Linus' first git commit
> introduced them in the git history, so it's pure legacy baggage.

Two things here:

 - First you seem to have completely missed the fact that hvc_poll() can
be called from interrupt time :-) Look at hvc_irq.c which is used by
some backends. Maybe that can be "fixed" by deferring to a work queue,
though it's nice to have the keyboard input have somewhat of a higher
priority than anything else here.

So unless that's fixed, or I missed something, that's a big NACK for
now.

 - Then, are we certain that there's no case where the tty layer will
call us with some lock held or in an atomic context ? To be honest, I've
totally lost track of the locking rules in tty land lately so it might
well be ok, but something to verify.

Cheers,
Ben.
