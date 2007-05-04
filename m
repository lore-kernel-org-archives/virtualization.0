From: Matt Mackall <mpm@selenic.com>
Subject: Re: [RELEASE] Lguest for 2.6.21
Date: Thu, 3 May 2007 22:20:44 -0500
Message-ID: <20070504032043.GT11115@waste.org>
References: <1178117028.19815.14.camel@localhost.localdomain>
	<20070503160201.GR11166@waste.org>
	<1178237603.23670.26.camel@localhost.localdomain>
	<1178239389.23670.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178239389.23670.33.camel@localhost.localdomain>
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
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 04, 2007 at 10:43:09AM +1000, Rusty Russell wrote:
> On Fri, 2007-05-04 at 10:13 +1000, Rusty Russell wrote:
> > On Thu, 2007-05-03 at 11:02 -0500, Matt Mackall wrote:
> > > On Thu, May 03, 2007 at 12:43:48AM +1000, Rusty Russell wrote:
> > > > 	http://lguest.ozlabs.org/lguest-2.6.21-254.patch.gz
> > > > 
> > > > See Documentation/lguest/lguest.txt for how to run,
> > > > drivers/lguest/README for the draft code documentation journey.
> > > 
> > > Your lguest readme is quite lacking in the area of how to configure a
> > > guest kernel as opposed to the host kernel. More hand-holding, please.
> > 
> > Hi Matt!
> > 
> > 	Ah, that's because they are the same kernel.  Turning on CONFIG_LGUEST
> > builds-in the parts needed to be a guest as well.

Ok, I thought that might be a possibility.
 
> -- You will need to configure your kernel with the following options:
> +- Lguest runs the same kernel as guest and host.  You can configure
> +  them differently, but usually it's easiest not to.

I take it both sides of the virtual device drivers are turned on by
the lguest option?

For the purposes of kernel hacking, I'd want to boot into one build
and repeatedly launch another build as a guest, thereby getting
faster hack/build/test cycles than either qemu or full reboot.
How tightly coupled are things here?

-- 
Mathematics is the supreme nostalgia of our time.
