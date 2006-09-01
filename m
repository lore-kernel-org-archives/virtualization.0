From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 18:04:00 +0200
Message-ID: <1157126640.21733.43.camel@localhost>
References: <20060901110948.GD15684@skybase>
	<1157122667.28577.69.camel@localhost.localdomain>
	<1157124674.21733.13.camel@localhost> <44F8563B.3050505@shadowen.org>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44F8563B.3050505@shadowen.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 16:48 +0100, Andy Whitcroft wrote:
> >> I know that there are 32-bit s390 kernels, but would this be a
> >> reasonable feature to restrict to only 64-bit kernels?  That might be a
> >> decent compromise.
> > =

> > Yes, it is definitly an option to make this a 64-bit only features. In
> > particular because the ESSA instruction that is used on s390 is only
> > available in zarch mode (=3D64 bit).
> =

> Wow.  Well there are only 7 extra bits available in 64 bit mode (the
> FIELDS area is larger on 64bit machines).  Do we really, really need
> three new bits.  What are they being used for here.

I have though about alternatives for the page bits hard and long and I
could not find a way how to do it without the bits. Their use is:
1) The page-is-discarded (PG_discarded) bit is set for pages that have
been recognized as removed by the host. The page needs to be removed
from the page cache while there are still page references floating
around. To prevent multiple removals from the page cache the discarded
bit is needed.
2) The page-state-change (PG_state_change) bit is required to prevent
that an make_stable "overtakes" a make_volatile. In order to make a page
volatile a number of conditions are check. After this is done the state
change will be done. The critical section is the code that performs the
checks up to the instruction that does the state change. No make_stable
may be done in between. The granularity is per page, to use a global
lock like a spinlock would severly limit the scalability for large smp
systems.
3) The page-has-a-writable-mapping (PG_writable) bit is set when the
first writable pte for a page is established. The page needs to have a
different state if a writable pte exists compared to a read-only page.
The alternative without the page bit would be to do the state change
every time a writable pte is established or to search all ptes of a
given page. Both have performance implications. =


Overall I fear that the code really needs three additional bits.

-- =

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
