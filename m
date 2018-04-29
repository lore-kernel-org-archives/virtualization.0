From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Sun, 29 Apr 2018 15:45:02 +0200
Message-ID: <20180429134502.GA23854__46032.0932012566$1525009407$gmane$org@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
	<20180428094205.GM5632@nanopsycho.orion>
	<CADGSJ23A4w=MmnP7CneBwk=eouS07HfK4=1UWTk3Dz3gBX0yjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CADGSJ23A4w=MmnP7CneBwk=eouS07HfK4=1UWTk3Dz3gBX0yjg@mail.gmail.com>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, aaron.f.brown@intel.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Sun, Apr 29, 2018 at 10:56:30AM CEST, loseweigh@gmail.com wrote:
>On Sat, Apr 28, 2018 at 2:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>> Fri, Apr 27, 2018 at 07:06:59PM CEST, sridhar.samudrala@intel.com wrote:
>>>This patch enables virtio_net to switch over to a VF datapath when a VF
>>>netdev is present with the same MAC address. It allows live migration
>>>of a VM with a direct attached VF without the need to setup a bond/team
>>>between a VF and virtio net device in the guest.
>>>
>>>The hypervisor needs to enable only one datapath at any time so that
>>>packets don't get looped back to the VM over the other datapath. When a VF
>>>is plugged, the virtio datapath link state can be marked as down. The
>>>hypervisor needs to unplug the VF device from the guest on the source host
>>>and reset the MAC filter of the VF to initiate failover of datapath to
>>>virtio before starting the migration. After the migration is completed,
>>>the destination hypervisor sets the MAC filter on the VF and plugs it back
>>>to the guest to switch over to VF datapath.
>>>
>>>It uses the generic failover framework that provides 2 functions to create
>>>and destroy a master failover netdev. When STANDBY feature is enabled, an
>>>additional netdev(failover netdev) is created that acts as a master device
>>>and tracks the state of the 2 lower netdevs. The original virtio_net netdev
>>>is marked as 'standby' netdev and a passthru device with the same MAC is
>>>registered as 'primary' netdev.
>>>
>>>This patch is based on the discussion initiated by Jesse on this thread.
>>>https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>>
>>
>> When I enabled the standby feature (hardcoded), I have 2 netdevices now:
>> 4: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>     link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>>     inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>>        valid_lft forever preferred_lft forever
>> 5: ens3n_sby: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>     link/ether 52:54:00:b2:a7:f1 brd ff:ff:ff:ff:ff:ff
>>     inet6 fe80::5054:ff:feb2:a7f1/64 scope link
>>        valid_lft forever preferred_lft forever
>>
>> However, it seems to confuse my initscripts on Fedora:
>> [root@test1 ~]# ifup ens3
>> ./network-functions: line 78: [: /etc/dhcp/dhclient-ens3: binary operator expected
>> ./network-functions: line 80: [: /etc/dhclient-ens3: binary operator expected
>> ./network-functions: line 69: [: /var/lib/dhclient/dhclient-ens3: binary operator expected
>>
>You should teach Fedora and all cloud vendors to upgrade their
>initscripts and other userspace tools, no?

I just wanted to point out that the conversion from "nostandby" to
"standby" isn't always that smooth as claimed. The claim was "no change
for the current user" iirc.
