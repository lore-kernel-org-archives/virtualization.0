From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
	datapath when available
Date: Wed, 24 Jan 2018 00:58:11 +0200
Message-ID: <20180124004556-mutt-send-email-mst__41122.7046665319$1516748206$gmane$org@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
	<CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
	<20180122233205-mutt-send-email-mst@kernel.org>
	<CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Siwei Liu <loseweigh@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 23, 2018 at 12:24:47PM -0800, Siwei Liu wrote:
> On Mon, Jan 22, 2018 at 1:41 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Jan 22, 2018 at 12:27:14PM -0800, Siwei Liu wrote:
> >> First off, as mentioned in another thread, the model of stacking up
> >> virt-bond functionality over virtio seems a wrong direction to me.
> >> Essentially the migration process would need to carry over all guest
> >> side configurations previously done on the VF/PT and get them moved to
> >> the new device being it virtio or VF/PT.
> >
> > I might be wrong but I don't see why we should worry about this usecase.
> > Whoever has a bond configured already has working config for migration.
> > We are trying to help people who don't, not convert existig users.
> 
> That has been placed in the view of cloud providers that the imported
> images from the store must be able to run unmodified thus no
> additional setup script is allowed (just as Stephen mentioned in
> another mail). Cloud users don't care about live migration themselves
> but the providers are required to implement such automation mechanism
> to make this process transparent if at all possible. The user does not
> care about the device underneath being VF or not, but they do care
> about consistency all across and the resulting performance
> acceleration in making VF the prefered datapath. It is not quite
> peculiar user cases but IMHO *any* approach proposed for live
> migration should be able to persist the state including network config
> e.g. as simple as MTU. Actually this requirement has nothing to do
> with virtio but our target users are live migration agnostic, being it
> tracking DMA through dirty pages, using virtio as the helper, or
> whatsoever, the goal of persisting configs across remains same.

So the patching being discussed here will mostly do exactly that if your
original config was simply a single virtio net device.


What kind of configs do your users have right now?


> >
> >> Without the help of a new
> >> upper layer bond driver that enslaves virtio and VF/PT devices
> >> underneath, virtio will be overloaded with too much specifics being a
> >> VF/PT backup in the future.
> >
> > So this paragraph already includes at least two conflicting
> > proposals. On the one hand you want a separate device for
> > the virtual bond, on the other you are saying a separate
> > driver.
> 
> Just to be crystal clear: separate virtual bond device (netdev ops,
> not necessarily bus device) for VM migration specifically with a
> separate driver.

Okay, but note that any config someone had on a virtio device won't
propagate to that bond.

> >
> > Further, the reason to have a separate *driver* was that
> > some people wanted to share code with netvsc - and that
> > one does not create a separate device, which you can't
> > change without breaking existing configs.
> 
> I'm not sure I understand this statement. netvsc is already another
> netdev being created than the enslaved VF netdev, why it bothers?

Because it shipped, so userspace ABI is frozen.  You can't really add a
netdevice and enslave an existing one without a risk of breaking some
userspace configs.


> In
> the Azure case, the stock image to be imported does not bind to a
> specific driver but only MAC address.

I'll let netvsc developers decide this, on the surface I don't think
it's reasonable to assume everyone only binds to a MAC.


> And people just deal with the
> new virt-bond netdev rather than the underlying virtio and VF. And
> both these two underlying netdevs should be made invisible to prevent
> userspace script from getting them misconfigured IMHO.
> 
> A separate driver was for code sharing for sure, only just netvsc but
> could be other para-virtual devices floating around: any PV can serve
> as the side channel and the backup path for VF/PT. Once we get the new
> driver working atop virtio we may define ops and/or protocol needed to
> talk to various other PV frontend that may implement the side channel
> of its own for datapath switching (e.g. virtio is one of them, Xen PV
> frontend can be another). I just don't like to limit the function to
> virtio only and we have to duplicate code then it starts to scatter
> around all over the places.
> 
> I understand right now we start it as simple so it may just be fine
> that the initial development activities center around virtio. However,
> from cloud provider/vendor perspective I don't see the proposed scheme
> limits to virtio only. Any other PV driver which has the plan to
> support the same scheme can benefit. The point is that we shouldn't be
> limiting the scheme to virtio specifics so early which is hard to have
> it promoted to a common driver once we get there.

The whole idea has been floating around for years. It would always
get being drowned in this kind of "lets try to cover all use-cases"
discussions, and never make progress.
So let's see some working code merged. If it works fine for virtio
and turns out to be a good fit for netvsc, we can share code.


> >
> > So some people want a fully userspace-configurable switchdev, and that
> > already exists at some level, and maybe it makes sense to add more
> > features for performance.
> >
> > But the point was that some host configurations are very simple,
> > and it probably makes sense to pass this information to the guest
> > and have guest act on it directly. Let's not conflate the two.
> 
> It may be fine to push some of the configurations from host but that
> perhaps doesn't cover all the cases: how is it possible for the host
> to save all network states and configs done by the guest before
> migration. Some of the configs might come from future guest which is
> unknown to host. Anyhow the bottom line is that the guest must be able
> to act on those configuration request changes automatically without
> involving users intervention.
> 
> Regards,
> -Siwei

All use-cases are *already* covered by existing kernel APIs.  Just use a
bond, or a bridge, or whatever. It's just that they are so generic and
hard to use, that userspace to do it never surfaced.

So I am interested in some code that handles some simple use-cases
in the kernel, with a simple kernel API.

> >
> > --
> > MST
