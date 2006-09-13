From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
Date: Wed, 13 Sep 2006 14:45:35 +0200
Message-ID: <1158151535.2560.20.camel@localhost>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
	<45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>
	<1158137786.2560.3.camel@localhost> <4507F453.1040809@watson.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4507F453.1040809@watson.ibm.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-09-13 at 08:06 -0400, Hubertus Franke wrote:
> Martin Schwidefsky wrote:
> > On Tue, 2006-09-12 at 21:29 -0400, Rik van Riel wrote:
> > =

> >>Note that the transition _to_ volatile can also be batched
> >>and done somewhat lazily.  For frequently mmaped pages that
> >>could end up saving us the transition the other way, too...
> > =

> > =

> > That would be helpful, only how to do it? We need some sort of list or
> > array where to store the pages that should be made volatile. The main
> > problem that I see is that you have to remove a page that is freed from
> > the list/array again, otherwise you would end up with a non page-cache
> > page being made volatile. That makes using per-cpu arrays hard since a
> > page can be freed on another cpu.
> > =

> =

> =

> Martin. the point was that pages
> which are in the hold/cold lists are technically free.
> However we keep them stable.
> When the hot/cold list is spilled back to the buddy allocator
> we make them volatile in buld (i.e. through the array).

You mean unused.

> So we only build the array for the duration of the bulk-release
> to the buddy allocator (and potentially the other way as well).
> Hence there is no "state" to maintain or track for the array.
> Pages in the hot/cold lists remain stable.
> This would not any of the problems you described as long as we hold
> the lock for the hot/cold list during buld-volatile.

I was not talking about free pages, and I don't think Rik was either.
The idea is to be lazy about the make-volatile calls. Put the pages for
which a make-volatile call should be done to some array/list and do a
bulk make-volatile. These pages are still in the page/swap cache. The
trouble is we have to be sure these pages have not been freed in the
meantime.

The bulk set-unused/set-stable to the buddy allocator should not be to
problematic. We just have to find new places where to do the calls.

-- =

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
