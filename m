From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Tue, 20 Feb 2018 21:14:10 +0100
Message-ID: <20180220201410.GF2031@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180220104224.GA2031@nanopsycho>
	<CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
	<20180220162933.GD2031@nanopsycho>
	<509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Tue, Feb 20, 2018 at 06:14:32PM CET, sridhar.samudrala@intel.com wrote:
>On 2/20/2018 8:29 AM, Jiri Pirko wrote:
>> Tue, Feb 20, 2018 at 05:04:29PM CET, alexander.duyck@gmail.com wrote:
>> > On Tue, Feb 20, 2018 at 2:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > Fri, Feb 16, 2018 at 07:11:19PM CET, sridhar.samudrala@intel.com wro=
te:
>> > > > Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can =
be
>> > > > used by hypervisor to indicate that virtio_net interface should ac=
t as
>> > > > a backup for another device with the same MAC address.
>> > > > =

>> > > > Ppatch 2 is in response to the community request for a 3 netdev
>> > > > solution.  However, it creates some issues we'll get into in a mom=
ent.
>> > > > It extends virtio_net to use alternate datapath when available and
>> > > > registered. When BACKUP feature is enabled, virtio_net driver crea=
tes
>> > > > an additional 'bypass' netdev that acts as a master device and con=
trols
>> > > > 2 slave devices.  The original virtio_net netdev is registered as
>> > > > 'backup' netdev and a passthru/vf device with the same MAC gets
>> > > > registered as 'active' netdev. Both 'bypass' and 'backup' netdevs =
are
>> > > > associated with the same 'pci' device.  The user accesses the netw=
ork
>> > > > interface via 'bypass' netdev. The 'bypass' netdev chooses 'active=
' netdev
>> > > > as default for transmits when it is available with link up and run=
ning.
>> > > Sorry, but this is ridiculous. You are apparently re-implemeting part
>> > > of bonding driver as a part of NIC driver. Bond and team drivers
>> > > are mature solutions, well tested, broadly used, with lots of issues
>> > > resolved in the past. What you try to introduce is a weird shortcut
>> > > that already has couple of issues as you mentioned and will certanly
>> > > have many more. Also, I'm pretty sure that in future, someone comes =
up
>> > > with ideas like multiple VFs, LACP and similar bonding things.
>> > The problem with the bond and team drivers is they are too large and
>> > have too many interfaces available for configuration so as a result
>> > they can really screw this interface up.
>> What? Too large is which sense? Why "too many interfaces" is a problem?
>> Also, team has only one interface to userspace team-generic-netlink.
>> =

>> =

>> > Essentially this is meant to be a bond that is more-or-less managed by
>> > the host, not the guest. We want the host to be able to configure it
>> How is it managed by the host? In your usecase the guest has 2 netdevs:
>> virtio_net, pci vf.
>> I don't see how host can do any managing of that, other than the
>> obvious. But still, the active/backup decision is done in guest. This is
>> a simple bond/team usecase. As I said, there is something needed to be
>> implemented in userspace in order to handle re-appear of vf netdev.
>> But that should be fairly easy to do in teamd.
>
>The host manages the active/backup decision by
>- assigning the same MAC address to both VF and virtio interfaces
>- setting a BACKUP feature bit on virtio that enables virtio to transparen=
tly
>take
>=A0 over the VFs datapath.
>- only enable one datapath at anytime so that packets don't get looped back
>- during live migration enable virtio datapth, unplug vf on the source and
>replug
>=A0 vf on the destination.
>
>The VM is not expected and doesn't have any control of setting the MAC
>address
>or bringing up/down the links.
>
>This is the model that is currently supported with netvsc driver on Azure.

Yeah, I can see it now :( I guess that the ship has sailed and we are
stuck with this ugly thing forever...

Could you at least make some common code that is shared in between
netvsc and virtio_net so this is handled in exacly the same way in both?

The fact that the netvsc/virtio_net kidnaps a netdev only because it
has the same mac is going to give me some serious nighmares...
I think we need to introduce some more strict checks.
