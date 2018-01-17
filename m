From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Wed, 17 Jan 2018 21:57:37 +0200
Message-ID: <20180117213527-mutt-send-email-mst__18490.5975162566$1516218972$gmane$org@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
	<CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
	<20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 17, 2018 at 11:25:41AM -0800, Samudrala, Sridhar wrote:
> =

> =

> On 1/17/2018 11:02 AM, Michael S. Tsirkin wrote:
> > On Wed, Jan 17, 2018 at 10:15:52AM -0800, Alexander Duyck wrote:
> > > On Thu, Jan 11, 2018 at 9:58 PM, Sridhar Samudrala
> > > <sridhar.samudrala@intel.com> wrote:
> > > > This feature bit can be used by hypervisor to indicate virtio_net d=
evice to
> > > > act as a backup for another device with the same MAC address.
> > > > =

> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > > ---
> > > >   drivers/net/virtio_net.c        | 2 +-
> > > >   include/uapi/linux/virtio_net.h | 3 +++
> > > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > > > =

> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 12dfc5fee58e..f149a160a8c5 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2829,7 +2829,7 @@ static struct virtio_device_id id_table[] =3D=
 {
> > > >          VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
> > > >          VIRTIO_NET_F_CTRL_MAC_ADDR, \
> > > >          VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> > > > -       VIRTIO_NET_F_SPEED_DUPLEX
> > > > +       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_BACKUP
> > > > =

> > > >   static unsigned int features[] =3D {
> > > >          VIRTNET_FEATURES,
> > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/v=
irtio_net.h
> > > > index 5de6ed37695b..c7c35fd1a5ed 100644
> > > > --- a/include/uapi/linux/virtio_net.h
> > > > +++ b/include/uapi/linux/virtio_net.h
> > > > @@ -57,6 +57,9 @@
> > > >                                           * Steering */
> > > >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
> > > > =

> > > > +#define VIRTIO_NET_F_BACKUP      62    /* Act as backup for anothe=
r device
> > > > +                                        * with the same MAC.
> > > > +                                        */
> > > >   #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed an=
d duplex */
> > > > =

> > > >   #ifndef VIRTIO_NET_NO_LEGACY
> > > I'm not a huge fan of the name "backup" since that implies that the
> > > Virtio interface is only used if the VF is not present, and there are
> > > multiple instances such as dealing with east/west or
> > > broadcast/multicast traffic where it may be desirable to use the
> > > para-virtual interface rather then deal with PCI overhead/bottleneck
> > > to send the packet.
> > Right now hypervisors mostly expect that yes, only one at a time is
> > used.  E.g. if you try to do multicast sending packets on both VF and
> > virtio then you will end up with two copies of each packet.
> =

> I think we want to use only 1 interface to=A0 send out any packet. In cas=
e of
> broadcast/multicasts it would be an optimization to send them via virtio =
and
> this patch series adds that optimization.

Right that's what I think we should rather avoid for now.

It's *not* an optimization if there's a single VM on this host,
or if a specific multicast group does not have any VMs on same
host.

I'd rather we just sent everything out on the PT if that's
there. The reason we have virtio in the picture is just so
we can migrate without downtime.


> In the receive path,=A0 the broadcasts should only go the PF and reach th=
e VM
> via vitio so that the VM doesn't see duplicate broadcasts.
> =

> =

> > =

> > To me the east/west scenario looks like you want something
> > more similar to a bridge on top of the virtio/PT pair.
> > =

> > So I suspect that use-case will need a separate configuration bit,
> > and possibly that's when you will want something more powerful
> > such as a full bridge.
> =

> east-west optimization of unicasts would be a harder problem to solve as
> somehow the hypervisor needs to indicate the VM about the local dest. macs

Using a bridge with a dedicated device for east/west would let
bridge use standard learning techniques for that perhaps?


> > =

> > =

> > > What if instead of BACKUP we used the name SIDE_CHANNEL? Basically it
> > > is a bit of double entendre as we are using the physical MAC address
> > > to provide configuration information, and then in addition this
> > > interface acts as a secondary channel for passing frames to and from
> > > the guest rather than just using the VF.
> > > =

> > > Just a thought.
> > > =

> > > Thanks.
> > > =

> > > - Alex
> > I just feel that's a very generic name, not conveying enough information
> > about how they hypervisor expects the pair of devices to be used.
> > =
