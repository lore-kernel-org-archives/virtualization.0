From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Extending virtio_console to support multiple ports
Date: Thu, 27 Aug 2009 19:27:23 +1000
Message-ID: <1251365243.20467.47.camel__6899.91114563799$1251365370$gmane$org@pasglop>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251346023.20467.21.camel@pasglop>
	<20090827100809.5f0aa0a7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827100809.5f0aa0a7@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Cox <alan@linux.intel.com>
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2009-08-27 at 10:08 +0100, Alan Cox wrote:
> >  - Then, are we certain that there's no case where the tty layer will
> > call us with some lock held or in an atomic context ? To be honest,
> > I've totally lost track of the locking rules in tty land lately so it
> > might well be ok, but something to verify.
> 
> Some of the less well behaved line disciplines do this and always have
> done.

That was also my understanding but heh, I though that maybe you may have
fixed all of that already :-)

So at this stage, I think the reasonably thing to do is to stick to the
spinlock, but we can try to make it a bit smarter, and we can definitely
attempt to fix the case Amit pointed out where we call resize without a
lock while it seems to expect it (though we also need to be careful
about re-entrancy I believe).

Cheers,
Ben.
