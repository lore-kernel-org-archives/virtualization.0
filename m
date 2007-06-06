From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 12:20:07 +0200
Message-ID: <4666A677.76E4.0078.0@novell.com>
References: <20070522140941.802382212@goop.org>
	<20070522141252.030961467@goop.org> <46668EC6.76E4.0078.0@novell.com>
	<466686E2.4040004@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <466686E2.4040004@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

>>  But I think that a clock source can be expected to be
>> monotonic anyway, which Xen's interpolation mechanism doesn't
>> guarantee across multiple CPUs. (I'm actually beginning to think that
>> this might also be the reason for certain test suites occasionally =
reporting
>> timeouts to fire early.)
>>  =20
>
>Does the kernel expect the tsc clocksource to be completely monotonic
>across cpus?  Any form of cpu-local clocksource is going to have this
>problem; I wonder if clocksources can really only be useful if they're
>always referring to a single system-wide time reference - seems like a
>bit of a limitation.

I suppose so - the clock source's rating gets set to zero if it can be =
predicted
that the TSCs aren't all synchronized, which should pretty much exclude =
the
use of this clock source for any other than fallback if there's really =
nothing
else available.

Jan
