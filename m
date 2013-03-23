From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: xen: how does XEN_PRIVILEGED_GUEST work?
Date: Sat, 23 Mar 2013 09:22:11 -0400
Message-ID: <20130323132211.GA8676@phenom.dumpdata.com>
References: <1363991855.1390.213.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363991855.1390.213.camel@x61.thuisdomein>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Randy Dunlap <rdunlap@xenotime.net>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 22, 2013 at 11:37:35PM +0100, Paul Bolle wrote:
> 0) The Kconfig symbol XEN_PRIVILEGED_GUEST got added to the mainline
> Linux repository in v2.6.37. It has never been used. It has always been
> a nop.
> 
> 1) Its Kconfig entry is preceded with this comment:
>     # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
>     # name in tools.
> 
> What does that mean?

[root@phenom minutes]# cat /etc/grub.d/20_linux_xen |grep PRIV
        if (grep -qx "CONFIG_XEN_DOM0=y" "${config}" 2> /dev/null || grep -qx "CONFIG_XEN_PRIVILEGED_GUEST=y" "${config}" 2> /dev/null); then echo -n "$i " ; fi

> 
> 2) On a related note: can anyone please explain commit
> 7c1bfd685bcdc822ab1d7411ea05c82bd2a7b260 ("xen/pci: Fix compiler error
> when CONFIG_XEN_PRIVILEGED_GUEST is not set.") and commit

Hm, the change actually was for CONFIG_XEN_DOM0. Title is incorrect

> c00c8aa2d976e9ed1d12a57b42d6e9b27efb7abe ("xen/trace: Fix compile error
> when CONFIG_XEN_PRIVILEGED_GUEST is not set"). Do they perhaps fix
> problems in code not mainlined?

No. That one was triggered by some juicy random config that Randy's
randconfig found.

> 
> 
> Paul Bolle
> 
