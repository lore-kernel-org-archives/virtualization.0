From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Thu, 8 Mar 2007 20:54:13 +0100
Message-ID: <20070308195413.GA6570@elte.hu>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> > While that's basically what we did in Xen, it would make more sense =

> > to build it into genapic which would give us one common abstraction =

> > to base from.  We should avoid adding pv_ops when existing =

> > infrastructure exists.
> =

> I was looking at cutting in at a much higher level.  The interface in =

> <linux/smp.h> is a good match for Xen, so I was going to investigate =

> making pv_ops at that level and see how it falls out.

yes, yes, yes. Finally someone with a clue about APIs ;-)

Basically, we want to think about the hypercall API more like a system =

call API, not like a hardware API! There will probably still be lowlevel =

details like ptes for a long time - but even those are not quite =

necessary.

And the reason is really fundamental: those system-call alike APIs are =

going to be the /most stable ones/ over time! 'Send stuff from A to B' =

or 'notify X about event Y' is /ALOT/ more stable across hardware =

variations than 'IDTs, vectors, apics or ptes'. And that is so precisely =

because these are fundamental actions that physical matter can do, and =

those do not get changed when new silicon comes out. In that sense Xen's =

hypervisor API is saner than VMI.

the most highlevel API is what UML uses today (and it clearly overdoes =

abstraction), still i was able to get basic UML performance close to =

native performance, via extending a few Linux system calls to enable the =

management of multiple sets of pagetables (each represented by a =

separate fd) via a single hypervisor-level process, and feeding back raw =

pagefault events to the hypervisor. (that was UML's SKAS concept =

combined with sys_remap_file_pages_prot() and sys_vcpu())

Now the practical problem with UML is that nobody has tried to make an =

UML native+guest 'shared kernel image', and hence it's unusable for =

distros. But there is no conceptual problem with UML's virtualization =

model.

	Ingo
