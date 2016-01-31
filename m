From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: bonding (IEEE 802.3ad) not working with qemu/virtio
Date: Sun, 31 Jan 2016 16:50:32 +0200
Message-ID: <20160131145032.GA5869__40282.7519611039$1454251860$gmane$org@redhat.com>
References: <56ABDA3D.8040100@cumulusnetworks.com> <28285.1454103900@famine>
	<56ABDE2A.7010301@cumulusnetworks.com>
	<20160129.225924.1343743091073159760.davem@davemloft.net>
	<56ACA15C.1080403@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56ACA15C.1080403@cumulusnetworks.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: jiri@resnulli.us, gospo@cumulusnetworks.com, virtualization@lists.linux-foundation.org, bjornar.ness@gmail.com, vfalico@gmail.com, netdev@vger.kernel.org, jay.vosburgh@canonical.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 30, 2016 at 12:41:16PM +0100, Nikolay Aleksandrov wrote:
> On 01/30/2016 07:59 AM, David Miller wrote:
> > From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > Date: Fri, 29 Jan 2016 22:48:26 +0100
> > =

> >> On 01/29/2016 10:45 PM, Jay Vosburgh wrote:
> >>> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> >>>
> >>>> On 01/25/2016 05:24 PM, Bj=F8rnar Ness wrote:
> >>>>> As subject says, 802.3ad bonding is not working with virtio network=
 model.
> >>>>>
> >>>>> The only errors I see is:
> >>>>>
> >>>>> No 802.3ad response from the link partner for any adapters in the b=
ond.
> >>>>>
> >>>>> Dumping the network traffic shows that no LACP packets are sent fro=
m the
> >>>>> host running with virtio driver, changing to for example e1000 solv=
es
> >>>>> this problem
> >>>>> with no configuration changes.
> >>>>>
> >>>>> Is this a known problem?
> >>>>>
> >>>> [Including bonding maintainers for comments]
> >>>>
> >>>> Hi,
> >>>> Here's a workaround patch for virtio_net devices that "cheats" the
> >>>> duplex test (which is the actual problem). I've tested this locally
> >>>> and it works for me.
> >>>> I'd let the others comment on the implementation, there're other sig=
ns
> >>>> that can be used to distinguish a virtio_net device so I'm open to s=
uggestions.
> >>>> Also feedback if this is at all acceptable would be appreciated.
> >>>
> >>> 	Should virtio instead provide an arbitrary speed and full duplex
> >>> to ethtool, as veth does?
> >>>
> >>> 	Creating a magic whitelist of devices deep inside the 802.3ad
> >>> implementation seems less desirable.
> >>>
> >> TBH, I absolutely agree. In fact here's what we've been doing:
> >> add set_settings which allows the user to set any speed/duplex
> >> and get_settings of course to retrieve that. This is also useful
> >> for testing other stuff that requires speed and duplex, not only
> >> for the bonding case.
> > =

> > I also agree.  Having a whitelist is just rediculous.
> > =

> > There should be a default speed/duplex setting for such devices as well.
> > We can pick one that will be use universally for these kinds of devices.
> > =

> Yes, that's the other thing - the default setting, from a brief grepping
> I see that veth uses 10Gbps, tun uses 10Mbps and batman-adv uses 10Mbps.
> =

> If we add a default get_settings that can be used by virtual devices
> in ethtool that returns 10Gbps with the settings set like veth does
> sounds good to me. What do you think ?
> =

> In fact they all set the same settings (apart from speed) so we can
> consolidate them in a single default setting init function and for the
> ones using different speed do something like:
> __ethtool_init_settings(); <- sets everything like veth would with 10Mbps=
 speed
> __ethtool_cmd_speed_set(cmd, SPEED_10000);
> And we're done.
> =


I think leaving speed alone would be preferable if possible.
Faking speed might cause strange effects e.g. bonding prefering
virtio over a real device unexpectedly.
Also, wouldn't it break same link speed requirements?
Same applies to duplex really.

We could easily extend virtio with ability to pass
speed/duplex info from host, but that's not always
known to host and there are existing hypervisors,
so we are still left with the question of what to do
when this info is not available.


Is virtio somehow special that we want LACP for it
if duplex state and speed are unknown, but
don't want it for other devices?
If no, let's allow it for all such devices?

-->
bond_3ad: allow LACP when duplex is unknown

Devices would sometimes set speed and duplex as unknown.

It seem reasonable to allow LACP in this case.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

--

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4cbb8b2..92639ef 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -342,12 +342,12 @@ static u8 __get_duplex(struct port *port)
 	if (slave->link =3D=3D BOND_LINK_UP) {
 		switch (slave->duplex) {
 		case DUPLEX_FULL:
+		default:
 			retval =3D 0x1;
 			netdev_dbg(slave->bond->dev, "Port %d Received status full duplex updat=
e from adapter\n",
 				   port->actor_port_number);
 			break;
 		case DUPLEX_HALF:
-		default:
 			retval =3D 0x0;
 			netdev_dbg(slave->bond->dev, "Port %d Received status NOT full duplex u=
pdate from adapter\n",
 				   port->actor_port_number);

-- =

MST
