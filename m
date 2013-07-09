From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Tue, 9 Jul 2013 10:48:40 -0400
Message-ID: <20130709144840.GF24897@phenom.dumpdata.com>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
	<20130708193457.GA6926@u109add4315675089e695.ant.amazon.com>
	<51DB2134.9040909@zytor.com> <20130708205834.GA481@pd.tnic>
	<1373326534.1438.10.camel@x61.thuisdomein>
	<f5d6bd67-7464-4932-a7ca-6026fe534fc7@email.android.com>
	<51DBDAB802000078000E37C1@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51DBDAB802000078000E37C1@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, Paul Bolle <pebolle@tiscali.nl>, virtualization@lists.linux-foundation.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, Matt Wilson <msw@amazon.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 09, 2013 at 08:41:12AM +0100, Jan Beulich wrote:
> >>> On 09.07.13 at 02:26, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> > Could you explain to me please why the check in the scripts is superfluous?
> 
> This is not really the question - _any_ such check can only be
> wrong. The boot loader has absolutely no business caring about
> kernel internals, and the kernel shouldn't be limited by it in how it
> renames/adds/deletes Kconfig options and anything else.

Then that should be discussed on grub2 to remove said check and modify
the code so that it can properly work without regression.

> 
> > Especially as the grand plan is to get rid of CONFIG_XEN_DOM0 and more or 
> > less have a backend and fronted config option (since that makes more sense 
> > nowadays). And that would make the XEN_DOM0 be obsolete and the XEN_PRIV 
> > would be the one that turns a lot of the options needed to compile a kernel 
> > that can provide backend driver support. (I am hand waving here). 
> 
> That's pretty odd a plan, considering that Dom0 is more than just
> an environment to provide backends. In fact, Dom0 may not be
> providing any backends at all, and instead just serve the
> "controlling hardware" and/or "control domain" purpose that it
> really is meant to be. But of course, if none of _that_ functionality
> depends on this config option, then it indeed could go away.

Right, if I follow that train of logic then there is the 'controlling
domain' and 'hardware backend domain' and then the rest - the guests.

The 'controlling domain' would be just the one that is priviliged to launch
guests, setup the proper XSM labels, etc. Nothing to do with hardware.
But everything to deal with the toolstack.

The 'hardware backend domain' on the other hand has drivers and it also
needs a mechanism to export said devices to the guests. Otherwise it is
a pretty poor 'backend domain' without any way to export the devices
to guests.

Dom0 has been both - but there is nothing wrong with seperating these
two labels. And therein I was thinking that the 'hardware backend domain'
should be the introduced. I am not good with names so the best option
seems CONFIG_XEN_PRIVILIGED, but that sounds to be like 'controlling domain'.

Any good ideas for names? CONFIG_XEN_HARDWARE_DOMAIN ? CONFIG_XEN_PRIVILIGED_DOMAIN?

The items that would depend on CONFIG_XEN_PRIVILIGED_DOMAIN would be
the gntdev.c, xenfs.c and evtchn.c ?

The CONFIG_XEN_HARDWARE_DOMAIN would be mostly everything else - and
also require support for ACPI, PCI, SMP - the low-level thing, and
then the backends.

Lastly the guests. They should be able to be compiled and run without
setting either one of those two options (thought if one wants to set
them that is fine).

And this should also compile on ARM :-)
