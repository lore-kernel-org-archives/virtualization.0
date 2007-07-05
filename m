From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/2] lguest: handle dodgy/non-existent TSC.  Host code.
Date: Thu, 5 Jul 2007 01:41:15 -0500
Message-ID: <20070705064115.GE11115@waste.org>
References: <1183529972.6005.1.camel@localhost.localdomain>
	<20070704132025.GZ11115@waste.org>
	<1183599525.6005.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1183599525.6005.55.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 05, 2007 at 11:38:45AM +1000, Rusty Russell wrote:
> On Wed, 2007-07-04 at 08:20 -0500, Matt Mackall wrote:
> > On Wed, Jul 04, 2007 at 04:19:32PM +1000, Rusty Russell wrote:
> > > Lguest currently requires a TSC, which breaks older machines and Matt
> > > Mackall who boots the host with "notsc".
> > 
> > I do? I temporarily had a "notsc" arg in my lguest launcher script,
> > but removing it made no difference. I do* boot the host with NO_HZ though.
> 
> NO_HZ should be OK, but last we spoke, "notsc" in the host caused
> lguest_data.tsc_khz to be zero => divide by zero errors (the previous
> fixes should sort out the other TSC issues).

I did indeed have a zero tsc_khz, and my system does mark TSC unstable
(falling back to acpi-pm). But I've never once booted the host kernel
on this laptop with "notsc". I've experimented with booting a guest
with notsc to see if it would help.

As a further datapoint, rc6-mm1 host and guest works. 

> Anyway, if the host decides not to use the TSC, the guest shouldn't use
> it, which is the basis of this patch...

Sure.

-- 
Mathematics is the supreme nostalgia of our time.
