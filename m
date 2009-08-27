From: Amit Shah <amit.shah@redhat.com>
Subject: Re: Extending virtio_console to support multiple ports
Date: Thu, 27 Aug 2009 12:22:51 +0530
Message-ID: <20090827065251.GB3218__7799.68182691864$1251356035$gmane$org@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251349485.6267.6.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1251349485.6267.6.camel@concordia>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Ryan Arnold <rsa@us.ibm.com>, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, alan@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Aug 27 2009 [15:04:45], Michael Ellerman wrote:
> On Wed, 2009-08-26 at 21:15 +0530, Amit Shah wrote:
> > [cc'ing some people who have made some commits in hvc_console.c]
> > 
> > On (Wed) Aug 26 2009 [16:57:18], Amit Shah wrote:
> > > On (Tue) Aug 25 2009 [11:47:20], Amit Shah wrote:
> > > > 
> > > > Hello all,
> > > > 
> > > > Here is a new iteration of the patch series that implements a
> > > > transport for guest and host communications.
> > > > 
> > > > The code has been updated to reuse the virtio-console device instead
> > > > of creating a new virtio-serial device.
> > > 
> > > And the problem now is that hvc calls the put_chars function with
> > > spinlocks held and we now allocate pages in send_buf(), called from
> > > put_chars.
> > > 
> > > A few solutions:
> > 
> > [snip]
> > 
> > > - Convert hvc's usage of spinlocks to mutexes. I've no idea how this
> > >   will play out; I'm no expert here. But I did try doing this and so far
> > >   it all looks OK. No lockups, lockdep warnings, nothing. I have full
> > >   debugging enabled. But this doesn't mean it's right.
> > 
> > So just to test this further I added the capability to have more than
> > one hvc console spawn from virtio_console, created two consoles and did
> > a 'cat' of a file in each of the virtio-consoles. It's been running for
> > half an hour now without any badness. No spew in debug logs too.
> > 
> > I also checked the code in hvc_console.c that takes the spin_locks.
> > Nothing there that runs from (or needs to run from) interrupt context.
> > So the change to mutexes does seem reasonable. Also, the spinlock code
> > was added really long back -- git blame shows Linus' first git commit
> > introduced them in the git history, so it's pure legacy baggage.
> 
> I won't tell Ryan you called his code "pure legacy baggage" if you
> don't ;)
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=d450b4ae023fb4be175389c18f4f87677da03020

Thanks for the link!

(and this general area might be the one that doesn't get major upheavals
in 5-yr spans :-)

		Amit
