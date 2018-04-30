From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Mon, 30 Apr 2018 09:20:34 +0200
Message-ID: <20180430072034.GH23854__48340.6920721338$1525072739$gmane$org@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
	<20180428094205.GM5632@nanopsycho.orion>
	<638e52c7-64db-9d8d-7530-f6b000d3e292@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <638e52c7-64db-9d8d-7530-f6b000d3e292@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Mon, Apr 30, 2018 at 06:16:58AM CEST, sridhar.samudrala@intel.com wrote:
>On 4/28/2018 2:42 AM, Jiri Pirko wrote:
>> Fri, Apr 27, 2018 at 07:06:59PM CEST,sridhar.samudrala@intel.com  wrote:
>> > This patch enables virtio_net to switch over to a VF datapath when a VF
>> > netdev is present with the same MAC address. It allows live migration
>> > of a VM with a direct attached VF without the need to setup a bond/team
>> > between a VF and virtio net device in the guest.
>> > =

>> > The hypervisor needs to enable only one datapath at any time so that
>> > packets don't get looped back to the VM over the other datapath. When =
a VF
>> > is plugged, the virtio datapath link state can be marked as down. The
>> > hypervisor needs to unplug the VF device from the guest on the source =
host
>> > and reset the MAC filter of the VF to initiate failover of datapath to
>> > virtio before starting the migration. After the migration is completed,
>> > the destination hypervisor sets the MAC filter on the VF and plugs it =
back
>> > to the guest to switch over to VF datapath.
>> > =

>> > It uses the generic failover framework that provides 2 functions to cr=
eate
>> > and destroy a master failover netdev. When STANDBY feature is enabled,=
 an
>> > additional netdev(failover netdev) is created that acts as a master de=
vice
>> > and tracks the state of the 2 lower netdevs. The original virtio_net n=
etdev
>> > is marked as 'standby' netdev and a passthru device with the same MAC =
is
>> > registered as 'primary' netdev.
>> > =

>> > This patch is based on the discussion initiated by Jesse on this threa=
d.
>> > https://marc.info/?l=3Dlinux-virtualization&m=3D151189725224231&w=3D2
>> > =

>> When I enabled the standby feature (hardcoded), I have 2 netdevices now:
>> 4: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UP group default qlen 1000
>>      link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>>      inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>>         valid_lft forever preferred_lft forever
>> 5: ens3n_sby: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel =
state UP group default qlen 1000
>>      link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>>      inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>>         valid_lft forever preferred_lft forever
>> =

>> However, it seems to confuse my initscripts on Fedora:
>> [root@test1 ~]# ifup ens3
>> ./network-functions: line 78: [: /etc/dhcp/dhclient-ens3: binary operato=
r expected
>> ./network-functions: line 80: [: /etc/dhclient-ens3: binary operator exp=
ected
>> ./network-functions: line 69: [: /var/lib/dhclient/dhclient-ens3: binary=
 operator expected
>> =

>> Determining IP information for ens3
>> ens3n_sby...Cannot find device "ens3n_sby.pid"
>> Cannot find device "ens3n_sby.lease"
>>   failed.
>> =

>> I tried to change the standby device mac:
>> ip link set ens3n_sby addr 52:54:00:b2:a7:f2
>> [root@test1 ~]# ifup ens3
>> =

>> Determining IP information for ens3... done.
>> [root@test1 ~]#
>> =

>> But now the network does not work. I think that the mac change on
>> standby device should be probably refused, no?
>
>Yes. we should block changing standby device mac.
>
>> When I change the mac back, all works fine.
>
>This is strange. So you had to change the standby device mac twice to
>get dhcp working.

Yes. First to some other mac to not to confuse initscripts, second back
to the "failover mac" in order to make frames go through (I'm guessing
that virtio_net also has mac filter for incoming frames).


>
>I do see NetworkManager trying to get dhcp address on standby device, but

Not using NM. Just good old Fedora initscripts.


>i don't see any issue with connectivity.=A0 To be totally transparent, we
>need to only expose one netdev.

Yep.


>
>> =

>> Now I try to change mac of the failover master:
>> [root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
>> RTNETLINK answers: Operation not supported
>> =

>> That I did expect to work. I would expect this would change the mac of
>> the master and both standby and primary slaves.
>
>If a VF is untrusted, a VM will not able to change its MAC and moreover

Note that at this point, I have no VF. So I'm not sure why you mention
that.


>in this mode we are assuming that the hypervisor has assigned the MAC and
>guest is not expected to change the MAC.

Wait, for ordinary old-fashioned virtio_net, as a VM user, I can change
mac and all works fine. How is this different? Change mac on "failover
instance" should work and should propagate the mac down to its slaves.


>
>For the initial implementation, i would propose not allowing the guest to
>change the MAC of failover or standby dev.

I see no reason for such restriction.


>
>
>> =

>> Now I tried to add a primary pci device. I don't have any fancy VF on my
>> test setup, but I expected the good old 8139cp to work:
>> [root@test1 ~]# ethtool -i ens9
>> driver: 8139cp
>> ....
>> [root@test1 ~]# ip link set ens9 addr 52:54:00:b2:a7:f1
>> =

>> I see no message in dmesg, so I guess the failover module did not
>> enslave this netdev. The mac change is not monitored. I would expect
>> that it is and whenever a device changes mac to the failover one, it
>> should be enslaved and whenever it changes mac back to something else,
>> it should be released - the primary one ofcourse.
>
>Sure. that may be the best way to handle the guest changing the primary
>netdev's mac.

Yep.


>
>> =

>> =

>> =

>> [...]
>> =

>> > +static int virtnet_get_phys_port_name(struct net_device *dev, char *b=
uf,
>> > +				      size_t len)
>> > +{
>> > +	struct virtnet_info *vi =3D netdev_priv(dev);
>> > +	int ret;
>> > +
>> > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_STANDBY))
>> > +		return -EOPNOTSUPP;
>> > +
>> > +	ret =3D snprintf(buf, len, "_sby");
>> please avoid the "_".
>> =

>> [...]
>
