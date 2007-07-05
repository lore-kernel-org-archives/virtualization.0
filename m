From: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2/2] lguest: handle dodgy/non-existent TSC. Guest code.
Date: Thu, 05 Jul 2007 08:37:51 -0700
Message-ID: <1183649871.3570.17.camel@localhost>
References: <1183529972.6005.1.camel@localhost.localdomain>
	<1183530033.6005.3.camel@localhost.localdomain>
	<20070704064402.GB10345@bakeyournoodle.com>
	<1183536605.6005.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183536605.6005.19.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-04 at 18:10 +1000, Rusty Russell wrote:
> On Wed, 2007-07-04 at 16:44 +1000, Tony Breeds wrote:
> > Why bother installing an lguest_clock which is the same as jiffies?
> > Wouldn't it be better to just use the system provided jiffies
> > clocksource in the case where you haven't been provided with
> > lguest_data.tsc_khz ?
> 
> 	Yes, but jiffies is the lowest-rated clock (so PIT will get chosen).  I
> initially mugged clocksource_jiffies.rating, but that felt wrong: it's
> currently not registered when this code runs so it's a simple
> assignment, but if code order was to change it would have to be a call
> to clocksource_change_rating().
> 
> There's an internal clocksource_override which I could use, but I'd have
> to make it non-static.
> 
> Maybe John has thoughts?

I tend to prefer to have many simple clocksources then a few complex
ones that try to handle everything. So adding the lguest clocksource,
even if its the same as jiffies, isn't an issue to me. They're small
anyway, and this allows you to add changes as needed w/o affecting the
normal jiffies clocksource.

Hijacking the rating value would work, but that further complicates the
normal selection paths (which is already complex enough), so I'd avoid
it.

The last apprach of making boot_override_clocksource non-static and
using it to force the clocksource wanted would work. But I think that
opens it up too much for abuse.

thanks
-john
