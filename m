From: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH 2/2] lguest: handle dodgy/non-existent TSC. Guest code.
Date: Wed, 4 Jul 2007 16:44:02 +1000
Message-ID: <20070704064402.GB10345@bakeyournoodle.com>
References: <1183529972.6005.1.camel@localhost.localdomain>
	<1183530033.6005.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1183530033.6005.3.camel@localhost.localdomain>
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

On Wed, Jul 04, 2007 at 04:20:33PM +1000, Rusty Russell wrote:
> We create an "lguest_clock" which the guest uses: either TSC or
> jiffies, depending on whether the host tells us the TSC frequency.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/lguest/lguest.c |   51 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> ===================================================================

Hi Rusty,

<snip>

> +static cycle_t lguest_clock_read(void)
> +{
> +	if (lguest_data.tsc_khz)
> +		return native_read_tsc();
> +	else
> +		return jiffies;
> +}
> +
> +/* This is what we tell the kernel is our clocksource.  */

<snip>

> +	/* We use the TSC if the Host tells us we can, otherwise a dumb
> +	 * jiffies-based clock. */
> +	if (lguest_data.tsc_khz) {
> +		lguest_clock.shift = 22;
> +		lguest_clock.mult = clocksource_khz2mult(lguest_data.tsc_khz,
> +							 lguest_clock.shift);
> +		lguest_clock.mask = CLOCKSOURCE_MASK(64);
> +		lguest_clock.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> +	} else {
> +		/* To understand this, start at kernel/time/jiffies.c... */
> +		lguest_clock.shift = 8;
> +		lguest_clock.mult = (((u64)NSEC_PER_SEC<<8)/ACTHZ) << 8;
> +		lguest_clock.mask = CLOCKSOURCE_MASK(32);
> +	}
>  	clocksource_register(&lguest_clock);

Why bother installing an lguest_clock which is the same as jiffies?
Wouldn't it be better to just use the system provided jiffies
clocksource in the case where you haven't been provided with
lguest_data.tsc_khz ?

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
