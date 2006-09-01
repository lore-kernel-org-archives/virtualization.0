From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 11:23:44 -0700
Message-ID: <1157135024.18728.19.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
	<1157122667.28577.69.camel@localhost.localdomain>
	<1157124674.21733.13.camel@localhost> <44F8563B.3050505@shadowen.org>
	<1157126640.21733.43.camel@localhost>
	<1157127483.28577.117.camel@localhost.localdomain>
	<1157127943.21733.52.camel@localhost>
	<1157128634.28577.139.camel@localhost.localdomain>
	<1157129762.21733.63.camel@localhost>
	<1157130970.28577.150.camel@localhost.localdomain>
	<1157132520.21733.78.camel@localhost>
	<1157133780.18728.6.camel@localhost.localdomain>
	<1157133841.21733.79.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1157133841.21733.79.camel@localhost>
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

On Fri, 2006-09-01 at 20:04 +0200, Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 11:03 -0700, Dave Hansen wrote:
> > OK.  It comes down to a race between =

> > =

> >         __remove_from_page_cache()/__delete_from_swap_cache()
> > =

> > and
> > =

> >         __page_discard()
> > =

> > running on the same page at the same time.  Right?
> =

> Yes.

OK, and there's no other workable solution to exclude each other from
running at the same time than a bit in page->flags?

It seems like that hashed lock (or lock in mem_map[]) we were talking
about earlier might be applicable here, too.

Do we ever discard pages other than ones that have just recently failed
to be made stable?  There seems to be a lot of

	if (!page_make_stable(page) {
		...
		page_discard(page);
	}

Some of these call sites even have mapping->page_lock held when the
page_make_stable() occurs, so they would have _already_ excluded
__remove_from_page_cache().  At which call sites is it not feasible to
acquire mapping->page_lock?

-- Dave
