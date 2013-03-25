From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: xen: how does XEN_PRIVILEGED_GUEST work?
Date: Mon, 25 Mar 2013 09:45:11 -0400
Message-ID: <20130325134511.GB11546@phenom.dumpdata.com>
References: <1363991855.1390.213.camel@x61.thuisdomein>
	<20130323132211.GA8676@phenom.dumpdata.com>
	<1364047175.1390.249.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364047175.1390.249.camel@x61.thuisdomein>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>, Ingo Molnar <mingo@elte.hu>, Randy Dunlap <rdunlap@xenotime.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 23, 2013 at 02:59:35PM +0100, Paul Bolle wrote:
> On Sat, 2013-03-23 at 09:22 -0400, Konrad Rzeszutek Wilk wrote:
> > On Fri, Mar 22, 2013 at 11:37:35PM +0100, Paul Bolle wrote:
> > > 1) Its Kconfig entry is preceded with this comment:
> > >     # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
> > >     # name in tools.
> > > 
> > > What does that mean?
> > 
> > [root@phenom minutes]# cat /etc/grub.d/20_linux_xen |grep PRIV
> >         if (grep -qx "CONFIG_XEN_DOM0=y" "${config}" 2> /dev/null || grep -qx "CONFIG_XEN_PRIVILEGED_GUEST=y" "${config}" 2> /dev/null); then echo -n "$i " ; fi
> 
> Thanks.
> 
> Can userspace require the build system to keep using some Kconfig symbol
> by doing tests like these? Anyhow, if that's the only tool then

I don't know if there are rules written down for this sort of thing - but
I presume there are some utilities that check the /proc/config.gz to
see if certain options are enabled? This is not that much different from that.

> XEN_PRIVILEGED_GUEST can be dropped. XEN_PRIVILIGED_GUEST should always
> be equal to XEN_DOM0 so this if () test will evaluate identically with
> the sub-test for CONFIG_XEN_PRIVILIGED_GUEST removed.

That is the only tool that I am aware of.

But if we wanted to drop one of those CONFIG_ options I would be more happy
with dropping of the XEN_DOM0. As the initial domain is not that different
from any PV domain - except that it can do ACPI, VGA, and some EFI stuff.
In essence it is a priviliged guest type.

It might make more sense to have the XEN_PRIVILIGED_GUEST be the option
that that would define whether there should be a dependency on the ACPI, VGA, etc
stuff.

Unfortunatly the XEN_DOM0 seems to be so interleaved in the header/source code
that this would take some surgery to get right.

> 
> 
> Paul Bolle
> 
