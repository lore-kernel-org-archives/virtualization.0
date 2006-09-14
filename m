From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 5/9] Guest page hinting: mlocked pages.
Date: Thu, 14 Sep 2006 10:59:15 +0200
Message-ID: <1158224355.18478.26.camel@localhost>
References: <20060901111022.GF15684@skybase>  <4508AEB9.4080409@vmware.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4508AEB9.4080409@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2006-09-13 at 18:22 -0700, Zachary Amsden wrote:
> Martin Schwidefsky wrote:
> > diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
> > --- linux-2.6/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
> > +++ linux-2.6-patched/mm/memory.c	2006-09-01 12:50:24.000000000 +0200
> > @@ -2523,6 +2523,31 @@ int make_pages_present(unsigned long add
> >  	BUG_ON(addr >=3D end);
> >  	BUG_ON(end > vma->vm_end);
> >  	len =3D (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
> > +
> > +	if (page_host_discards() && (vma->vm_flags & VM_LOCKED)) {
> > +		int rlen =3D len;
> > +		ret =3D 0;
> > +		while (rlen > 0) {
> > +			struct page *page_refs[32];
> > +			int chunk, cret, i;
> > +
> > +			chunk =3D rlen < 32 ? rlen : 32;
> > +			cret =3D get_user_pages(current, current->mm, addr,
> > +					      chunk, write, 0,
> > +					      page_refs, NULL);
> > +			if (cret > 0) {
> > +				for (i =3D 0; i < cret; i++)
> > +					page_cache_release(page_refs[i]);
> > +				ret +=3D cret;
> > +			}
> > +			if (cret < chunk)
> > +				return ret ? : cret;
> > +			addr +=3D 32*PAGE_SIZE;
> > +			rlen -=3D 32;
> > +		}
> > +		return ret =3D=3D len ? 0 : -1;
> > +	}
> > +
> >  	ret =3D get_user_pages(current, current->mm, addr,
> >  			len, write, 0, NULL, NULL);
> >  	if (ret < 0)
> >   =

> =

> This seems like a bit of unneeded complexity.  Since you've already =

> changed get_user_pages, why not add a follow flag to release the page =

> cache, and simply pass it to get_user_pages, instead of trying to fetch =

> the page list back.  In particular, write and force arguments to =

> get_user_pages look very ripe for combining into a flags field.  Sure, =

> get_user_pages now has a bit more work to do, but it is already a =

> monster, and I think it would keep make_page_present much cleaner.

That makes sense. If we combine write and force the additional flag we
need won't hurt. I'll add this to my to-do list.

-- =

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
