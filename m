From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [RFC PATCH 1/5] lguest: mmap backing file
Date: Fri, 21 Mar 2008 09:12:24 +1100
Message-ID: <200803210912.25648.rusty__12233.9555681267$1206051436$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
	<47E26EE1.5030706@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E26EE1.5030706@codemonkey.ws>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 March 2008 01:04:17 Anthony Liguori wrote:
> Rusty Russell wrote:
> > From: Paul TBBle Hampson <Paul.Hampson@Pobox.com>
> >
> > This creates a file in $HOME/.lguest/ to directly back the RAM and DMA
> > memory mappings created by map_zeroed_pages.
>
> I created a test program recently that measured the latency of a
> reads/writes to an mmap() file in /dev/shm and in a normal filesystem.
> Even after unlinking the underlying file, the write latency was much
> better with a mmap()'d file in /dev/shm.

How odd!  Do you have any idea why?

> /dev/shm is not really for general use.  I think we'll want to have our
> own tmpfs mount that we use to create VM images.

If we're going to mod the kernel, how about a "mmap this part of their address 
space" and having the kernel keep the mappings in sync.  But I think that if 
we want to get speed, we should probably be doing the copy between address 
spaces in-kernel so we can do lightweight exits.

> I also prefer to use a 
> unix socket for communication, unlink the file immediately after open,
> and then pass the fd via SCM_RIGHTS to the other process.

Yeah, I shied away from that because cred passing kills whole litters of 
puppies.  It makes for better encapsulation tho, so I'd do it that way in a 
serious implementation.

Cheers,
Rusty.
