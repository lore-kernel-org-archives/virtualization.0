From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 8/9] Guest page hinting: discarded page list.
Date: Fri, 01 Sep 2006 17:40:19 +0200
Message-ID: <1157125219.21733.24.camel@localhost>
References: <20060901111117.GI15684@skybase>
	<1157123836.28577.77.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1157123836.28577.77.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, virtualization@lists.osdl.org, frankeh@watson.ibm.com, rhim@cc.gateh.edu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 08:17 -0700, Dave Hansen wrote:
> > +#if defined(CONFIG_PAGE_DISCARD_LIST)
> > +       if (page_host_discards() && unlikely(PageDiscarded(page))) {
> > +               local_irq_disable();
> > +               list_add_tail(&page->lru,
> > +                             &__get_cpu_var(page_discard_list));
> > +               local_irq_enable();
> > +               return;
> > +       }
> > +#endif =

> =

> If PageDiscarded() was #ifdef'd in the header, you wouldn't need this in
> the .c file.

No, unfortunately not. There is a new variable page_discard_list that is
only defined if CONFG_PAGE_DISCARD_LIST is set. The compiler will
complain about the absence of the variable, even if the code is never
reached because PageDiscarded always returns 0.

-- =

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
