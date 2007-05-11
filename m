From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/5] lguest guest feedback tidyups
Date: Fri, 11 May 2007 17:31:06 +1000
Message-ID: <1178868666.23513.49.camel__9891.13732143796$1178868735$gmane$org@localhost.localdomain>
References: <1178846246.23513.21.camel@localhost.localdomain>
	<1178846354.23513.23.camel@localhost.localdomain>
	<1178846490.23513.27.camel@localhost.localdomain>
	<20070511065613.GB25182@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070511065613.GB25182@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-05-11 at 07:56 +0100, Christoph Hellwig wrote:
> On Fri, May 11, 2007 at 11:21:30AM +1000, Rusty Russell wrote:
> > 1) send-dma and bind-dma hypercall wrappers for drivers to use,
> > 2) formalization of the convention that devices can use the irq
> >    corresponding to their index on the lguest_bus.
> > 3) ___force to shut up sparse: guests *can* use ioremap as virtual mem.
> 
> No, they can't.  Even if in your case the underlying address spaces
> happen to be the same anything returned by ioremap must use the proper
> accessors.  That's the whole point of having this separation, otherwise
> you wouldn't need to use ioremap at all.

Hi Christoph!

	Well, without ioremap, the memory wouldn't normally be mapped.  Is
there something better to use?

> So instead of sprinkling cast
> around add lguest_read*/lguest_write* accessors that do the __force cast
> once and make sure the ioremap return value is always accessed using those.

And that's nothing to do with iremap.  They're required because guest
"physical" == host virtual, and casting a long to a "__user void *"
seems to require a __force.

I enjoy a good Hellwigging as much as anyone, but your aim is off.

Cheers,
Rusty.
