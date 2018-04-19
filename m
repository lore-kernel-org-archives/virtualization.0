From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCH net-next v6 2/4] net: Introduce generic bypass module
Date: Thu, 19 Apr 2018 08:35:32 +0200
Message-ID: <20180419063532.GA2048__8396.05846344984$1524119617$gmane$org@nanopsycho>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-3-git-send-email-sridhar.samudrala@intel.com>
	<20180411155127.GQ2028@nanopsycho>
	<6a8c1ff5-153a-e40a-91b3-48532b8d3a38@intel.com>
	<20180418092515.GB1989@nanopsycho>
	<dd0d53f0-f5da-cb7d-f8f6-d0c8245eb3cf@intel.com>
	<20180418191315.GA1922@nanopsycho>
	<20180418222309-mutt-send-email-mst@kernel.org>
	<20180418203206.GC1922@nanopsycho>
	<ff0c5ea1-16d4-00a7-9952-9049efa818eb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <ff0c5ea1-16d4-00a7-9952-9049efa818eb@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Thu, Apr 19, 2018 at 12:46:11AM CEST, sridhar.samudrala@intel.com wrote:
>On 4/18/2018 1:32 PM, Jiri Pirko wrote:
>> > > > > > > You still use "active"/"backup" names which is highly mislea=
ding as
>> > > > > > > it has completely different meaning that in bond for example.
>> > > > > > > I noted that in my previous review already. Please change it.
>> > > > > > I guess the issue is with only the 'active'=A0 name. 'backup' =
should be fine as it also
>> > > > > > matches with the BACKUP feature bit we are adding to virtio_ne=
t.
>> > > > > I think that "backup" is also misleading. Both "active" and "bac=
kup"
>> > > > > mean a *state* of slaves. This should be named differently.
>> > > > > =

>> > > > > =

>> > > > > =

>> > > > > > With regards to alternate names for 'active', you suggested 's=
tolen', but i
>> > > > > > am not too happy with it.
>> > > > > > netvsc uses vf_netdev, are you OK with this? Or another option=
 is 'passthru'
>> > > > > No. The netdev could be any netdevice. It does not have to be a =
"VF".
>> > > > > I think "stolen" is quite appropriate since it describes the mod=
us
>> > > > > operandi. The bypass master steals some netdevice according to s=
ome
>> > > > > match.
>> > > > > =

>> > > > > But I don't insist on "stolen". Just sounds right.
>> > > > We are adding VIRTIO_NET_F_BACKUP as a new feature bit to enable t=
his feature, So i think
>> > > > 'backup' name is consistent.
>> > > It perhaps makes sense from the view of virtio device. However, as I
>> > > described couple of times, for master/slave device the name "backup"=
 is
>> > > highly misleading.
>> > virtio is the backup. You are supposed to use another
>> > (typically passthrough) device, if that fails use virtio.
>> > It does seem appropriate to me. If you like, we can
>> > change that to "standby".  Active I don't like either. "main"?
>> Sounds much better, yes.
>
>OK. Will change backup to 'standby'.
>'main' is fine, what about 'primary'?

Primary is also bonding terminology. But in this case, I think it would
fit. The primary slave is used as the active one whenever the link is
up.


>
>
>> =

>> =

>> > In fact would failover be better than bypass?
>> Also, much better.
>
>So do we want to change all 'bypass' references to 'failover' including
>the filenames.(net/core/failover.c and include/net/failover.h)
>
><snip>
>
>
>
>> =

>> =

>> > =

>> > > > The intent is to restrict the 'active' netdev to be a VF. If there=
 is a way to check that
>> > > > a PCI device is a VF in the guest kernel, we could restrict 'activ=
e' netdev to be a VF.
>> > > > =

>> > > > Will look for any suggestions in the next day or two. If i don't g=
et any, i will go
>> > > > with 'stolen'
>> > > > =

>> > > > <snip>
>> > > > =

>> > > > =

>> > > > > +
>> > > > > +static struct net_device *bypass_master_get_bymac(u8 *mac,
>> > > > > +						  struct bypass_ops **ops)
>> > > > > +{
>> > > > > +	struct bypass_master *bypass_master;
>> > > > > +	struct net_device *bypass_netdev;
>> > > > > +
>> > > > > +	spin_lock(&bypass_lock);
>> > > > > +	list_for_each_entry(bypass_master, &bypass_master_list, list) {
>> > > > > > > As I wrote the last time, you don't need this list, spinlock.
>> > > > > > > You can do just something like:
>> > > > > > >            for_each_net(net) {
>> > > > > > >                    for_each_netdev(net, dev) {
>> > > > > > > 			if (netif_is_bypass_master(dev)) {
>> > > > > > This function returns the upper netdev as well as the ops asso=
ciated
>> > > > > > with that netdev.
>> > > > > > bypass_master_list is a list of 'struct bypass_master' that as=
sociates
>> > > > > Well, can't you have it in netdev priv?
>> > > > We cannot do this for 2-netdev model as there is no bypass_netdev =
created.
>> > > Howcome? You have no master? I don't understand..
>
>For 2-netdev model, the master netdev is not a new one created by the bypa=
ss module.
>It is created by netvsc internally and passed via bypass_master_register()

But virtio_net alho has to create the master and pass it down to the
bypass module. Howcome it is different?


>
><snip>
>
>
>
>> > > =

>> > > > > > > > +
>> > > > > > > > +	/* Avoid Bonding master dev with same MAC registering as=
 slave dev */
>> > > > > > > > +	if ((dev->priv_flags & IFF_BONDING) && (dev->flags & IFF=
_MASTER))
>> > > > > > > Yeah, this is certainly incorrect. One thing is, you should =
be using the
>> > > > > > > helpers netif_is_bond_master().
>> > > > > > > But what about the rest? macsec, macvlan, team, bridge, ovs =
and others?
>> > > > > > > =

>> > > > > > > You need to do it not by blacklisting, but with whitelisting=
. You need
>> > > > > > > to whitelist VF devices. My port flavours patchset might hel=
p with this.
>> > > > > > May be i can use netdev_has_lower_dev() helper to make sure th=
at the slave
>> > > > > I don't see such function in the code.
>> > > > It is netdev_has_any_lower_dev(). I need to export it.
>> > > Come on, you cannot use that. That would allow bonding without slave=
s,
>> > > but the slaves could be added later on.
>> > > =

>> > > What exactly you are trying to achieve by this?
>
>I think i can remove this check.=A0 In pre-register,
>for backup device, i check that its parent matches bypass device &
>for vf device, we make sure that it is a pci device.

Okay. That is a start.


>
>
