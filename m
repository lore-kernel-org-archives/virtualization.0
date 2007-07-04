From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] lguest: handle dodgy/non-existent TSC. Guest code.
Date: Wed, 04 Jul 2007 18:10:05 +1000
Message-ID: <1183536605.6005.19.camel@localhost.localdomain>
References: <1183529972.6005.1.camel@localhost.localdomain>
	<1183530033.6005.3.camel@localhost.localdomain>
	<20070704064402.GB10345@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704064402.GB10345@bakeyournoodle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-04 at 16:44 +1000, Tony Breeds wrote:
> Why bother installing an lguest_clock which is the same as jiffies?
> Wouldn't it be better to just use the system provided jiffies
> clocksource in the case where you haven't been provided with
> lguest_data.tsc_khz ?

Hi Tony!

	Yes, but jiffies is the lowest-rated clock (so PIT will get chosen).  I
initially mugged clocksource_jiffies.rating, but that felt wrong: it's
currently not registered when this code runs so it's a simple
assignment, but if code order was to change it would have to be a call
to clocksource_change_rating().

There's an internal clocksource_override which I could use, but I'd have
to make it non-static.

Maybe John has thoughts?

Thanks,
Rusty.
