From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Tue, 18 Sep 2007 23:52:24 +0200
Message-ID: <200709182352.25118.ak__19710.3429506116$1190152633$gmane$org@suse.de>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de>
	<1190151272.7262.175.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190151272.7262.175.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 18 September 2007 23:34, Rusty Russell wrote:
> On Tue, 2007-09-18 at 12:57 +0200, Andi Kleen wrote:
> > On Friday 14 September 2007 07:21, Rusty Russell wrote:
> > > It's pretty widely used,
> >
> > Is it? By whom?
>
> Hi Andi,
>
> 	Please stop asking for facts!  It's was easy claim to make, and hard to
> disprove 8)
>
> > > and the distributions will turn it on.
> >
> > That's no reason to make it default y. Please undo that. default y
> > is near always a bad idea.
>
> How about a "select" based on Xen, lguest or VMI?  There's no other
> reason to enable it, after all.

I did an patch to do that recently because  the current setup
is indeed unobvious.

But I had to drop it again because 
it ended up with Kconfig warnings. about undefined symbols
on x86-64. The problem is that lguest
is visible in Kconfig for all architectures and it warns
if you select something that doesn't exist on all architectures.

The only workaround would have been to define PARAVIRT
for all architectures, which I considered too ugly.

I think Sam stated recently he wanted to remove that warning
but it needed some infrastructure work.

> > Also I would still consider it experimental.
>
> After 9 months in mainline and three kernel versions, 

Well it changed a lot each release.

> I'd hope not. 
> It's been pretty damn stable (ok, you broke it once, but maybe that's
> because you consider it experimental).

Is there a significant user base? 

At least the Xen port seems to have specific requirements
and essentially only work on xen-unstable (?) [or at least
some very new Xen version] which probably very few
people use.

-Andi
