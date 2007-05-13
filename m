From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 2/5] lguest guest feedback tidyups
Date: Sun, 13 May 2007 19:43:39 +0100
Message-ID: <20070513184339.GZ4095__41339.5492280417$1179081870$gmane$org@ftp.linux.org.uk>
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
>  	/* Devices are in page above top of "normal" mem. */
> -	lguest_devices = ioremap(max_pfn << PAGE_SHIFT, PAGE_SIZE);
> +	lguest_devices = (__force void*)ioremap(max_pfn<<PAGE_SHIFT,PAGE_SIZE);

Er...  What's being done here?  What are we mapping and what's going to
be accessed when we dereference that sucker?
