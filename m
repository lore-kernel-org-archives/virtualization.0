From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/5] lguest guest feedback tidyups
Date: Mon, 14 May 2007 17:11:49 +1000
Message-ID: <1179126709.23513.194.camel__42402.3135369227$1179126783$gmane$org@localhost.localdomain>
References: <1178846246.23513.21.camel@localhost.localdomain>
	<1178846354.23513.23.camel@localhost.localdomain>
	<1178846490.23513.27.camel@localhost.localdomain>
	<20070513184339.GZ4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070513184339.GZ4095@ftp.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-05-13 at 19:43 +0100, Al Viro wrote:
> On Fri, May 11, 2007 at 11:21:30AM +1000, Rusty Russell wrote:
> >  	/* Devices are in page above top of "normal" mem. */
> > -	lguest_devices = ioremap(max_pfn << PAGE_SHIFT, PAGE_SIZE);
> > +	lguest_devices = (__force void*)ioremap(max_pfn<<PAGE_SHIFT,PAGE_SIZE);
> 
> Er...  What's being done here?  What are we mapping and what's going to
> be accessed when we dereference that sucker?

This, too, is now wrapped in lguest_map() in the updated patch.  

Guest virtual device memory can be directly accessed, but Jeff Garzik
and Christoph Hellwig made good points about not encouraging such
abnormal use of ioremap in drivers.

BTW, I've done a new rollup patch of lguest against 2.6.21, if you would
like to review the whole thing.  This version includes the big code
documentation patch not yet in -mm.

	http://lguest.ozlabs.org/lguest-2.6.21-290.patch.gz

Thanks,
Rusty.
