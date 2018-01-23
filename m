From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Wed, 24 Jan 2018 01:01:03 +0200
Message-ID: <20180124010051-mutt-send-email-mst__14787.2047652074$1516748364$gmane$org@kernel.org>
References: <20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
	<20180117213527-mutt-send-email-mst@kernel.org>
	<CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
	<20180122231713-mutt-send-email-mst@kernel.org>
	<7edf772b-627c-6121-3332-479caed524da@intel.com>
	<20180123020332-mutt-send-email-mst@kernel.org>
	<be3864b4-f108-6a7d-8628-204d4d4ae278@intel.com>
	<20180123035619-mutt-send-email-mst@kernel.org>
	<CAKgT0UfaKG7=E5ciarE3fSUp-Ke-oDNodGe_baEAGbZqWV4Qug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKgT0UfaKG7=E5ciarE3fSUp-Ke-oDNodGe_baEAGbZqWV4Qug@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 22, 2018 at 07:36:32PM -0800, Alexander Duyck wrote:
> On Mon, Jan 22, 2018 at 6:04 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Jan 22, 2018 at 05:34:37PM -0800, Samudrala, Sridhar wrote:
> >> On 1/22/2018 4:05 PM, Michael S. Tsirkin wrote:
> >> > On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
> >> > > > > You could probably
> >> > > > > even handle the Tx queue selection via a simple eBPF program and map
> >> > > > > since the input for whatever is used to select Tx should be pretty
> >> > > > > simple, destination MAC, source NUMA node, etc, and the data-set
> >> > > > > shouldn't be too large.
> >> > > > That sounds interesting. A separate device might make this kind of setup
> >> > > > a bit easier.  Sridhar, did you look into creating a separate device for
> >> > > > the virtual bond device at all?  It does not have to be in a separate
> >> > > > module, that kind of refactoring can come later, but once we commit to
> >> > > > using the same single device as virtio, we can't change that.
> >> > > No. I haven't looked into creating a separate device. If we are going to
> >> > > create a new
> >> > > device, i guess it has to be of a new device type with its own driver.
> >> > Well not necessarily - just a separate netdev ops.
> >> > Kind of like e.g. vlans share a driver with the main driver.
> >>
> >> Not sure what you meant by vlans sharing a driver with the main driver.
> >> IIUC, vlans are supported via 802.1q driver and  creates a netdev of type
> >> 'vlan'
> >> with vlan_netdev_ops
> >
> > But nothing prevents a single module from registering
> > multiple ops.
> 
> Just to clarify, it seems like what you are suggesting is just adding
> the "master" as a separate set of netdev ops or netdevice and to have
> virtio spawn two network devices, one slave and one master, if the
> BACKUP bit is set. Do I have that right?

Yes, that was my idea.

> I am good with the code still living in the virtio driver and
> consolidation with other similar implementations and further
> improvement could probably happen later as part of some refactor.
> 
> Thanks.
> 
> - Alex
