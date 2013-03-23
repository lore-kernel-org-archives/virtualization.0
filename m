From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: xen: how does XEN_PRIVILEGED_GUEST work?
Date: Sat, 23 Mar 2013 14:59:35 +0100
Message-ID: <1364047175.1390.249.camel@x61.thuisdomein>
References: <1363991855.1390.213.camel@x61.thuisdomein>
	<20130323132211.GA8676@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130323132211.GA8676@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Randy Dunlap <rdunlap@xenotime.net>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2013-03-23 at 09:22 -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 22, 2013 at 11:37:35PM +0100, Paul Bolle wrote:
> > 1) Its Kconfig entry is preceded with this comment:
> >     # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
> >     # name in tools.
> > 
> > What does that mean?
> 
> [root@phenom minutes]# cat /etc/grub.d/20_linux_xen |grep PRIV
>         if (grep -qx "CONFIG_XEN_DOM0=y" "${config}" 2> /dev/null || grep -qx "CONFIG_XEN_PRIVILEGED_GUEST=y" "${config}" 2> /dev/null); then echo -n "$i " ; fi

Thanks.

Can userspace require the build system to keep using some Kconfig symbol
by doing tests like these? Anyhow, if that's the only tool then
XEN_PRIVILEGED_GUEST can be dropped. XEN_PRIVILIGED_GUEST should always
be equal to XEN_DOM0 so this if () test will evaluate identically with
the sub-test for CONFIG_XEN_PRIVILIGED_GUEST removed.


Paul Bolle
