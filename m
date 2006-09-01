From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 09:18:03 -0700
Message-ID: <1157127483.28577.117.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	<1157122667.28577.69.camel@localhost.localdomain>
	<1157124674.21733.13.camel@localhost> <44F8563B.3050505@shadowen.org>
	<1157126640.21733.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1157126640.21733.43.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: schwidefsky@de.ibm.com
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, nickpiggin@yahoo.com.au, Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 18:04 +0200, Martin Schwidefsky wrote:
> 1) The page-is-discarded (PG_discarded) bit is set for pages that have
> been recognized as removed by the host. The page needs to be removed
> from the page cache while there are still page references floating
> around. To prevent multiple removals from the page cache the discarded
> bit is needed.

OK, so the page has data in it, and is in the page cache.  The
hypervisor kills the page, gives the notification to the kernel that the
page has gone away, and the kernel marks PG_discarded.  There still
might be active references to the page.

So, is the problem trying to communicate with the reference holders that
the page is no longer valid?  How is this fundamentally different from
page truncating?

> 2) The page-state-change (PG_state_change) bit is required to prevent
> that an make_stable "overtakes" a make_volatile. In order to make a page
> volatile a number of conditions are check. After this is done the state
> change will be done. The critical section is the code that performs the
> checks up to the instruction that does the state change. No make_stable
> may be done in between. The granularity is per page, to use a global
> lock like a spinlock would severly limit the scalability for large smp
> systems.

How about doing it in the NUMA node?  Or the mem_section?  Or, even a
bit in the mem_map[] for the area guarding the 'struct page' itself?
Even a hashed table of locks based on the page address.  You just need
something that allows _some_ level of concurrency.  You certainly never
have a number of CPUs which is anywhere close to the number of 'struct
page's in the system.

Let me think more about (3).

-- Dave
