From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver
Date: Wed, 11 Nov 2009 13:13:23 +1030
Message-ID: <200911111313.24226.rusty__45325.3764463172$1257907564$gmane$org@rustcorp.com.au>
References: <1257782838.2835.5.camel@aglitke>
	<200911111032.14956.rusty@rustcorp.com.au>
	<4AFA005C.7020607@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AFA005C.7020607@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, agl@linux.vnet.ibm.com, qemu-devel@nongnu.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 11 Nov 2009 10:37:56 am Anthony Liguori wrote:
> Rusty Russell wrote:
> > You register an outbuf at initialization time.  The host hands it back when
> > it wants you to refill it with stats.
> 
> That's strangely backwards.  Guest send a stat buffer that's filled out, 
> host acks it when it wants another.  That doesn't seem bizarre to you?

Yep!  But that's a limitation of our brains, not the infrastructure ;)

Think of the stats as an infinite stream of data.  Read from it at your
leisure.  This is how, for example, console output works.

> > But the universe is remarkably indifferent to what we want.  Is it actually
> > sufficient or are we going to regret our laziness?
> 
> It's not laziness, it's consistency.  How is actual different than free 
> memory or any other stat?

Because it's a COLLECTION of stats.  For example, swap in should be < swap
out.  Now, the current Linux implementation of all_vm_events() is non-atomic
anyway, so maybe we can just document this as best-effort.  I'm saying that
if it *is* a problem, I think we need a vq.

But it raises the question: what stats are generally useful cross-OS?  Should
we be supplying numbers like "unused" (free) "instantly discardable" (ie.
clean), "discardable to disk" (ie. file-backed), "discardable to swap"
(ie. swap-backed) and "unswappable" instead?

(I just made those up, of course, but it seems like that would give a fair
indication of real memory pressure in any OS).

Thanks,
Rusty.
