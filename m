From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest
	implementation for paravirt_ops interface
Date: 17 Feb 2007 14:51:13 +0100
Message-ID: <20070217135112.GA15102@muc.de>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
	<45D61C74.2000601@vmware.com>
	<Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
	<45D626BB.20007@vmware.com>
	<Pine.LNX.4.64.0702161356380.29218@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Date: Sat, 17 Feb 2007 14:51:12 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702161356380.29218@schroedinger.engr.sgi.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 16, 2007 at 01:59:44PM -0800, Christoph Lameter wrote:
> On Fri, 16 Feb 2007, Zachary Amsden wrote:
> 
> > Yes, but that is just because the Xen hooks happens to be near the last part
> > of the merge.  VMI required some special hooks, as do both Xen and lhype (I
> > think ... Rusty can correct me if lhype's puppy's have precluded the addition
> > of new hooks).  Xen page table handling is very different, mostly it is trap
> > and emulate so writable page tables can work, which means they don't always
> > issue hypercalls for PTE updates, although they do have that option, should
> > the hypervisor MMU model change, or performance concerns prompt a different
> > model (or perhaps, migration?)
> 
> Well looks like there are still some major design issues to be ironed out. 
> What is proposed here is to make paravirt_ops a fake generic 
> API and then tunnel through it to vendor specific kernel mods.

That was always its intention. It's not a direct interface to a hypervisor,
but an somewhat abstracted interface to a "hypervisor driver" 

But you're right that there are currently still quite a lot of hooks
being added. I plan to be much more strict on that in the future.

-Andi
