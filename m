From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Sun, 29 Apr 2018 01:56:30 -0700
Message-ID: <CADGSJ23A4w=MmnP7CneBwk=eouS07HfK4=1UWTk3Dz3gBX0yjg__36167.1659666628$1524992091$gmane$org@mail.gmail.com>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
	<20180428094205.GM5632@nanopsycho.orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180428094205.GM5632@nanopsycho.orion>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, aaron.f.brown@intel.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 28, 2018 at 2:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Fri, Apr 27, 2018 at 07:06:59PM CEST, sridhar.samudrala@intel.com wrote:
>>This patch enables virtio_net to switch over to a VF datapath when a VF
>>netdev is present with the same MAC address. It allows live migration
>>of a VM with a direct attached VF without the need to setup a bond/team
>>between a VF and virtio net device in the guest.
>>
>>The hypervisor needs to enable only one datapath at any time so that
>>packets don't get looped back to the VM over the other datapath. When a VF
>>is plugged, the virtio datapath link state can be marked as down. The
>>hypervisor needs to unplug the VF device from the guest on the source host
>>and reset the MAC filter of the VF to initiate failover of datapath to
>>virtio before starting the migration. After the migration is completed,
>>the destination hypervisor sets the MAC filter on the VF and plugs it back
>>to the guest to switch over to VF datapath.
>>
>>It uses the generic failover framework that provides 2 functions to create
>>and destroy a master failover netdev. When STANDBY feature is enabled, an
>>additional netdev(failover netdev) is created that acts as a master device
>>and tracks the state of the 2 lower netdevs. The original virtio_net netdev
>>is marked as 'standby' netdev and a passthru device with the same MAC is
>>registered as 'primary' netdev.
>>
>>This patch is based on the discussion initiated by Jesse on this thread.
>>https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>
>
> When I enabled the standby feature (hardcoded), I have 2 netdevices now:
> 4: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>        valid_lft forever preferred_lft forever
> 5: ens3n_sby: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>     link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>        valid_lft forever preferred_lft forever
>
> However, it seems to confuse my initscripts on Fedora:
> [root@test1 ~]# ifup ens3
> ./network-functions: line 78: [: /etc/dhcp/dhclient-ens3: binary operator expected
> ./network-functions: line 80: [: /etc/dhclient-ens3: binary operator expected
> ./network-functions: line 69: [: /var/lib/dhclient/dhclient-ens3: binary operator expected
>
You should teach Fedora and all cloud vendors to upgrade their
initscripts and other userspace tools, no?

> Determining IP information for ens3
> ens3n_sby...Cannot find device "ens3n_sby.pid"
> Cannot find device "ens3n_sby.lease"
>  failed.
>
> I tried to change the standby device mac:
> ip link set ens3n_sby addr 52:54:00:b2:a7:f2
> [root@test1 ~]# ifup ens3
>
> Determining IP information for ens3... done.
> [root@test1 ~]#
>
> But now the network does not work. I think that the mac change on
> standby device should be probably refused, no?
>
> When I change the mac back, all works fine.
>
>
> Now I try to change mac of the failover master:
> [root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
> RTNETLINK answers: Operation not supported
>
> That I did expect to work. I would expect this would change the mac of
> the master and both standby and primary slaves.
>
>
> Now I tried to add a primary pci device. I don't have any fancy VF on my
> test setup, but I expected the good old 8139cp to work:
> [root@test1 ~]# ethtool -i ens9
> driver: 8139cp
> ....
> [root@test1 ~]# ip link set ens9 addr 52:54:00:b2:a7:f1
>
> I see no message in dmesg, so I guess the failover module did not
> enslave this netdev. The mac change is not monitored. I would expect
> that it is and whenever a device changes mac to the failover one, it
> should be enslaved and whenever it changes mac back to something else,
> it should be released - the primary one ofcourse.
>
>
>
> [...]
>
>>+static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
>>+                                    size_t len)
>>+{
>>+      struct virtnet_info *vi = netdev_priv(dev);
>>+      int ret;
>>+
>>+      if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_STANDBY))
>>+              return -EOPNOTSUPP;
>>+
>>+      ret = snprintf(buf, len, "_sby");
>
> please avoid the "_".
>
> [...]
