From: Paul Bolle <pebolle@tiscali.nl>
Subject: xen: how does XEN_PRIVILEGED_GUEST work?
Date: Fri, 22 Mar 2013 23:37:35 +0100
Message-ID: <1363991855.1390.213.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Randy Dunlap <rdunlap@xenotime.net>, xen-devel@lists.xensource.com, Ingo Molnar <mingo@elte.hu>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

0) The Kconfig symbol XEN_PRIVILEGED_GUEST got added to the mainline
Linux repository in v2.6.37. It has never been used. It has always been
a nop.

1) Its Kconfig entry is preceded with this comment:
    # Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
    # name in tools.

What does that mean?

2) On a related note: can anyone please explain commit
7c1bfd685bcdc822ab1d7411ea05c82bd2a7b260 ("xen/pci: Fix compiler error
when CONFIG_XEN_PRIVILEGED_GUEST is not set.") and commit
c00c8aa2d976e9ed1d12a57b42d6e9b27efb7abe ("xen/trace: Fix compile error
when CONFIG_XEN_PRIVILEGED_GUEST is not set"). Do they perhaps fix
problems in code not mainlined?


Paul Bolle
