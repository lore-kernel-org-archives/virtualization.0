From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Tue, 23 Jan 2018 04:04:35 +0200
Message-ID: <20180123035619-mutt-send-email-mst__3017.81831444732$1516672989$gmane$org@kernel.org>
References: <1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
	<CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
	<20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
	<20180117213527-mutt-send-email-mst@kernel.org>
	<CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
	<20180122231713-mutt-send-email-mst@kernel.org>
	<7edf772b-627c-6121-3332-479caed524da@intel.com>
	<20180123020332-mutt-send-email-mst@kernel.org>
	<be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 22, 2018 at 05:34:37PM -0800, Samudrala, Sridhar wrote:
> On 1/22/2018 4:05 PM, Michael S. Tsirkin wrote:
> > On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
> > > > > You could probably
> > > > > even handle the Tx queue selection via a simple eBPF program and =
map
> > > > > since the input for whatever is used to select Tx should be pretty
> > > > > simple, destination MAC, source NUMA node, etc, and the data-set
> > > > > shouldn't be too large.
> > > > That sounds interesting. A separate device might make this kind of =
setup
> > > > a bit easier.  Sridhar, did you look into creating a separate devic=
e for
> > > > the virtual bond device at all?  It does not have to be in a separa=
te
> > > > module, that kind of refactoring can come later, but once we commit=
 to
> > > > using the same single device as virtio, we can't change that.
> > > No. I haven't looked into creating a separate device. If we are going=
 to
> > > create a new
> > > device, i guess it has to be of a new device type with its own driver.
> > Well not necessarily - just a separate netdev ops.
> > Kind of like e.g. vlans share a driver with the main driver.
> =

> Not sure what you meant by vlans sharing a driver with the main driver.
> IIUC, vlans are supported via 802.1q driver and=A0 creates a netdev of ty=
pe
> 'vlan'
> with vlan_netdev_ops

But nothing prevents a single module from registering
multiple ops.


> > =

> > > As we are using virtio_net to control and manage the VF data path, it=
 is not
> > > clear to me
> > > what is the advantage of creating a new device rather than extending
> > > virtio_net to manage
> > > the VF datapath via transparent bond mechanism.
> > > =

> > > Thanks
> > > Sridhar
> > So that XDP redirect actions can differentiate between virtio, PT
> > device and the bond. Without it there's no way to redirect
> > to virtio specifically.
> I guess this usecase is for a guest admin to add bpf programs to VF netdev
> and
> redirect frames to virtio.

No - this doesn't make much sense IMHO.  The usecase would be VM
bridging where we process packets incoming on one virtio interface, and
transmit them on another one. It was pointed out using a separate master
netdev and making both virtio and PT its slaves would allow redirect
switch to force virtio, without it it won't be possible to force
redirect to virtio.

How important that use-case is, I am not sure.

>=A0 How does bond enable this feature?
> =

> =

> Thanks
> Sridhar

As it's a userspace configuration, I guess for starters we
can punt this to userspace, too.

-- =

MST
