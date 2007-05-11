From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/5] lguest guest feedback tidyups
Date: Fri, 11 May 2007 07:56:13 +0100
Message-ID: <20070511065613.GB25182__3596.32718978009$1178866629$gmane$org@infradead.org>
References: <1178846246.23513.21.camel@localhost.localdomain>
	<1178846354.23513.23.camel@localhost.localdomain>
	<1178846490.23513.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178846490.23513.27.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 11, 2007 at 11:21:30AM +1000, Rusty Russell wrote:
> 1) send-dma and bind-dma hypercall wrappers for drivers to use,
> 2) formalization of the convention that devices can use the irq
>    corresponding to their index on the lguest_bus.
> 3) ___force to shut up sparse: guests *can* use ioremap as virtual mem.

No, they can't.  Even if in your case the underlying address spaces
happen to be the same anything returned by ioremap must use the proper
accessors.  That's the whole point of having this separation, otherwise
you wouldn't need to use ioremap at all.  So instead of sprinkling cast
around add lguest_read*/lguest_write* accessors that do the __force cast
once and make sure the ioremap return value is always accessed using those.
