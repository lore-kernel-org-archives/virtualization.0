From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/2] lguest: handle dodgy/non-existent TSC. Guest code.
Date: Thu, 05 Jul 2007 10:56:23 -0700
Message-ID: <468D30C7.7050103@goop.org>
References: <1183529972.6005.1.camel@localhost.localdomain>	<1183530033.6005.3.camel@localhost.localdomain>	<20070704064402.GB10345@bakeyournoodle.com>
	<1183536605.6005.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>, Matt Mackall <mpm@selenic.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
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

How about having lguest_tsc and lguest_jiffies clocksources, with the 
approprate ratings to get them selected when needed?  And lguest_jiffies 
could probably just be a new structure which points to the normal 
jiffies clocksource function(s).

    J
