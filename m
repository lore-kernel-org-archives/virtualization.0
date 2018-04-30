From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Mon, 30 Apr 2018 09:12:08 +0200
Message-ID: <20180430071208.GG23854__30225.3748327077$1525072232$gmane$org@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
	<20180428082433.GK5632@nanopsycho.orion>
	<62f3b81b-70f6-6991-8e23-2bf650ecea2d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <62f3b81b-70f6-6991-8e23-2bf650ecea2d@intel.com>
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

Mon, Apr 30, 2018 at 05:00:33AM CEST, sridhar.samudrala@intel.com wrote:
>
>On 4/28/2018 1:24 AM, Jiri Pirko wrote:
>> Fri, Apr 27, 2018 at 07:06:59PM CEST, sridhar.samudrala@intel.com wrote:
>> > This patch enables virtio_net to switch over to a VF datapath when a VF
>> > netdev is present with the same MAC address. It allows live migration
>> > of a VM with a direct attached VF without the need to setup a bond/team
>> > between a VF and virtio net device in the guest.
>> > =

>> > The hypervisor needs to enable only one datapath at any time so that
>> > packets don't get looped back to the VM over the other datapath. When =
a VF
>> Why? Both datapaths could be enabled at a time. Why the loop on
>> hypervisor side would be a problem. This in not an issue for
>> bonding/team as well.
>
>Somehow the hypervisor needs to make sure that the broadcasts/multicasts f=
rom the VM
>sent over the VF datapath don't get looped back to the VM via the virtio-n=
et datapth.

Why? Please see below.


>This can happen if both datapaths are enabled at the same time.
>
>I would think this is an issue even with bonding/team as well when virtio-=
net and
>VF are backed by the same PF.
>
>

I believe that the scenario is the same as on an ordinary nic/swich
network:

...................

  host
 =

       bond0
      /     \
    eth0   eth1
     |       |
...................
     |       |
     p1      p2

  switch

...................

It is perfectly valid to p1 and p2 be up and "bridged" together. Bond
has to cope with loop-backed frames. "Failover driver" should too,
it's the same scenario.


>> =

>> =

>> > is plugged, the virtio datapath link state can be marked as down. The
>> > hypervisor needs to unplug the VF device from the guest on the source =
host
>> > and reset the MAC filter of the VF to initiate failover of datapath to
>> "reset the MAC filter of the VF" - you mean "set the VF mac"?
>
>Yes.=A0 the PF should take away the MAC address assigned to the VF so that=
 the PF
>starts receiving those packets.

Okay, got it. Please put this in the description.


>
>> =

>> =

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
>> [...]
>> =

>
