From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: Re: [E1000-eedc] [PATCH 16/17] lldpad support for libvirt netlink
	message
Date: Tue, 3 Aug 2010 13:59:54 +0200
Message-ID: <201008031359.54190.jens@linux.vnet.ibm.com>
References: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
	<1279881273-10261-17-git-send-email-jens@linux.vnet.ibm.com>
	<4C57CACE.2070202@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C57CACE.2070202@intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: John Fastabend <john.r.fastabend@intel.com>
Cc: "chrisw@redhat.com" <chrisw@redhat.com>, arnd@arndb.de, Stefan Berger <stefanb@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, "e1000-eedc@lists.sourceforge.net" <e1000-eedc@lists.sourceforge.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 August 2010, John Fastabend wrote:
> Jens Osterkamp wrote:
> > This code receives a IEEE 802.1Qbg virtual station instance from libvir=
t in
> > a SETLINK message. The parsed VSI is then handed over to VDP for proces=
sing.
> > The VDP state machine processes the VSI while libvirt polls the result =
using
> > GETLINK.
> > =

> > Requires at least Linux kernel 2.6.35-rc1.
> > =

> > Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
> > Signed-off-by: Gerhard Stenzel <gstenzel@linux.vnet.ibm.com>
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > ---
> >  event_iface.c |  617 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  lldp_vdp.c    |    2 +-
> >  lldpad.c      |   10 +
> >  3 files changed, 622 insertions(+), 7 deletions(-)
> > =

> =

> Jens,
> =

> Can you explain why this interface is needed?  There is already a kernel =


We needed a way in libvirt to associate the virtual network interface(s) of=
 a
guest with an adjacent switch. The protocol to do this could be implemented
both in userspace (e.g. in lldpad) or in the adapter firmware. You could ha=
ve
different drivers for both ways in libvirt but to keep it simple we decided
to use netlink for both.

The original mailthread on netdev started here

http://marc.info/?l=3Dlinux-netdev&m=3D127242976205746&w=3D2

> interface for this how come libvirt and lldpad can not use the kernel int=
erface?

In fact we are using the kernel interface for this, e.g. the definitions of=
 the
netlink attributes are in the kernel header files.
The only difference is that in the userspace case, the netlink messages
are addressed to the pid of lldpad whereas in the firmware case, the netlink
messages go to pid 0 (kernel).

Best regards, =


Jens Osterkamp
---------------------------------------------------------------------------=
-----
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=E4ftsf=FChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=F6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
