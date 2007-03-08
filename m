From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 11:47:40 -0800
Message-ID: <20070308194740.GJ10574@sequoia.sous-sol.org>
References: <45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com>
	<1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com>
	<1173313373.24738.937.camel@localhost.localdomain>
	<45EF6077.9090302@vmware.com>
	<20070308182456.GH19575@sequoia.sous-sol.org>
	<45F06720.8080901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F06720.8080901@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris Wright wrote:
> > * Daniel Arai (arai@vmware.com) wrote:
> >   =

> >> There's no good way to override __send_IPI_shortcut.  I suppose we cou=
ld add =

> >> paravirt ops for __send_IPI_shortcut and every other op that touches t=
he APIC. =

> >>     =

> >
> > While that's basically what we did in Xen, it would make more sense to
> > build it into genapic which would give us one common abstraction to base
> > from.  We should avoid adding pv_ops when existing infrastructure exist=
s.
> =

> I was looking at cutting in at a much higher level.  The interface in
> <linux/smp.h> is a good match for Xen, so I was going to investigate
> making pv_ops at that level and see how it falls out.

I agree with that, but I think that's esp. for things like create and launch
new vcpu.  The IPI bit I'm not as clear on, nor running this all on native
as well.

thanks,
-chris
