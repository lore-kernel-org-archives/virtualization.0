From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCH net-next v5 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Wed, 11 Apr 2018 10:03:32 +0200
Message-ID: <20180411080332.GL2028__350.894584744488$1523433710$gmane$org@nanopsycho>
References: <20180409080751.GE19345@nanopsycho>
	<16b2e531-7bfa-7f25-2702-f3f8069663ee@intel.com>
	<20180410105504.GA2028@nanopsycho>
	<2ccfad76-589d-9dca-7e4b-9bafee41f844@intel.com>
	<20180410152205.GF2028@nanopsycho>
	<d08ed1e6-678a-7b34-cd2e-52788ceec919@intel.com>
	<20180410154304.GG2028@nanopsycho>
	<82f741a2-2512-39de-84c6-874f126c27ea@intel.com>
	<20180411060327.GH2028@nanopsycho>
	<5d56e572-24f1-745d-49ae-c2dada5db03c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d56e572-24f1-745d-49ae-c2dada5db03c@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Wed, Apr 11, 2018 at 08:24:43AM CEST, sridhar.samudrala@intel.com wrote:
>On 4/10/2018 11:03 PM, Jiri Pirko wrote:
>> Tue, Apr 10, 2018 at 05:59:02PM CEST, sridhar.samudrala@intel.com wrote:
>> > On 4/10/2018 8:43 AM, Jiri Pirko wrote:
>> > > Tue, Apr 10, 2018 at 05:27:48PM CEST, sridhar.samudrala@intel.com wr=
ote:
>> > > > On 4/10/2018 8:22 AM, Jiri Pirko wrote:
>> > > > > Tue, Apr 10, 2018 at 05:13:40PM CEST, sridhar.samudrala@intel.co=
m wrote:
>> > > > > > On 4/10/2018 3:55 AM, Jiri Pirko wrote:
>> > > > > > > Mon, Apr 09, 2018 at 08:47:06PM CEST, sridhar.samudrala@inte=
l.com wrote:
>> > > > > > > > On 4/9/2018 1:07 AM, Jiri Pirko wrote:
>> > > > > > > > > Sat, Apr 07, 2018 at 12:59:14AM CEST, sridhar.samudrala@=
intel.com wrote:
>> > > > > > > > > > On 4/6/2018 5:48 AM, Jiri Pirko wrote:
>> > > > > > > > > > > Thu, Apr 05, 2018 at 11:08:22PM CEST, sridhar.samudr=
ala@intel.com wrote:
>> > > > > > > > > [...]
>> > > > > > > > > =

>> > > > > > > > > > > > +static int virtnet_bypass_join_child(struct net_d=
evice *bypass_netdev,
>> > > > > > > > > > > > +				     struct net_device *child_netdev)
>> > > > > > > > > > > > +{
>> > > > > > > > > > > > +	struct virtnet_bypass_info *vbi;
>> > > > > > > > > > > > +	bool backup;
>> > > > > > > > > > > > +
>> > > > > > > > > > > > +	vbi =3D netdev_priv(bypass_netdev);
>> > > > > > > > > > > > +	backup =3D (child_netdev->dev.parent =3D=3D bypa=
ss_netdev->dev.parent);
>> > > > > > > > > > > > +	if (backup ? rtnl_dereference(vbi->backup_netdev=
) :
>> > > > > > > > > > > > +			rtnl_dereference(vbi->active_netdev)) {
>> > > > > > > > > > > > +		netdev_info(bypass_netdev,
>> > > > > > > > > > > > +			    "%s attempting to join bypass dev when %s =
already present\n",
>> > > > > > > > > > > > +			    child_netdev->name, backup ? "backup" : "a=
ctive");
>> > > > > > > > > > > Bypass module should check if there is already some =
other netdev
>> > > > > > > > > > > enslaved and refuse right there.
>> > > > > > > > > > This will work for virtio-net with 3 netdev model, but=
 this check has to be done by netvsc
>> > > > > > > > > > as its bypass_netdev is same as the backup_netdev.
>> > > > > > > > > > Will add a flag while registering with the bypass modu=
le to indicate if the driver is doing
>> > > > > > > > > > a 2 netdev or 3 netdev model and based on that flag th=
is check can be done in bypass module
>> > > > > > > > > > for 3 netdev scenario.
>> > > > > > > > > Just let me undestand it clearly. What I expect the diff=
erence would be
>> > > > > > > > > between 2netdev and3 netdev model is this:
>> > > > > > > > > 2netdev:
>> > > > > > > > >        bypass_master
>> > > > > > > > >           /
>> > > > > > > > >          /
>> > > > > > > > > VF_slave
>> > > > > > > > > =

>> > > > > > > > > 3netdev:
>> > > > > > > > >        bypass_master
>> > > > > > > > >           /     \
>> > > > > > > > >          /       \
>> > > > > > > > > VF_slave   backup_slave
>> > > > > > > > > =

>> > > > > > > > > Is that correct? If not, how does it look like?
>> > > > > > > > > =

>> > > > > > > > > =

>> > > > > > > > Looks correct.
>> > > > > > > > VF_slave and backup_slave are the original netdevs and are=
 present in both the models.
>> > > > > > > > In the 3 netdev model, bypass_master netdev is created and=
 VF_slave and backup_slave are
>> > > > > > > > marked as the 2 slaves of this new netdev.
>> > > > > > > You say it looks correct and in another sentence you provide=
 completely
>> > > > > > > different description. Could you please look again?
>> > > > > > > =

>> > > > > > To be exact, 2 netdev model with netvsc looks like this.
>> > > > > > =

>> > > > > >       netvsc_netdev
>> > > > > >         /
>> > > > > >        /
>> > > > > > VF_slave
>> > > > > > =

>> > > > > > With virtio_net, 3 netdev model
>> > > > > > =

>> > > > > >     bypass_netdev
>> > > > > >         /     \
>> > > > > >        /       \
>> > > > > > VF_slave   virtio_net netdev
>> > > > > Could you also mark the original netdev which is there now? is it
>> > > > > bypass_netdev or virtio_net_netdev ?
>> > > > bypass_netdev
>> > > >       /     \
>> > > >      /       \
>> > > > VF_slave   virtio_net netdev (original)
>> > > That does not make sense.
>> > > 1) You diverge from the behaviour of the netvsc, where the original
>> > >      netdev is a master of the VF
>> > > 2) If the original netdev is a slave, you cannot have any IP address
>> > >      configured on it (well you could, but the rx_handler would eat =
every
>> > >      incoming packet). So you will break the user bacause he would h=
ave to
>> > >      move the configuration to the new master device.
>> > > This only makes sense that the original netdev becomes the master fo=
r both
>> > > netvsc and virtio_net.
>> > Forgot to mention that bypass_netdev takes over the name of the origin=
al
>> > netdev and
>> > virtio_net netdev will get the backup name.
>> What do you mean by "name"?
>
>bypass_netdev also is associated with the same pci device as the original =
virtio_net
>netdev via SET_NETDEV_DEV().=A0 Also, we added ndo_get_phys_port_name() to=
 virtio_net
>that will return _bkup when BACKUP feature is enabled.

Okay.

>
>So for ex: if virtio_net inteface was getting 'ens12' as the name assigned=
 by udev
>without BACKUP feature,=A0 when BACKUP feature is enabled,=A0 the=A0 bypas=
s_netdev will be
>named 'ens12' and the original virtio_net will get named as ens12n_bkup.

Got it.

I don't like the bypass_master to look differently in netvsc and
virtio_net :/ The best would be to convert netvsc to 3 netdev model and
treat them the same. The more I think about it, the more the 2 netdev
model feels wrong.


>
>
>> =

>> > So the userspace network configuration doesn't need to change.
>> > =

>> > =

>
