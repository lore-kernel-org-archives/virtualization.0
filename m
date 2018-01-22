From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [PATCH net-next 0/2] Enable virtio to act as a master for a
	passthru device
Date: Mon, 22 Jan 2018 11:00:03 -0800
Message-ID: <CADGSJ20Z=DPU=x6NrQ0J3ptYyvjZrCQu7teHRz8_XPKW4neDFw__265.821736729954$1516647531$gmane$org@mail.gmail.com>
References: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
	<20180102181603.7fe4fd1e@cakuba.netronome.com>
	<CAKgT0Ue7E3ubPOP-d8femP1Yf=XK0j8MJRC7Wg8L7N59rugL4A@mail.gmail.com>
	<843c77a1-98bb-e667-3b4d-cc8bf7cd1668@intel.com>
	<CAKgT0UdtHVq3WWpjHggNabw_+2piaRQAKguivV690HdzKrg62w@mail.gmail.com>
	<077cfd06-7387-a5aa-2639-fc3cf4ba7efc@intel.com>
	<CADGSJ22TXcyJ1iAAtKho7S=jGfUzUsqvAx-HV2XuwV2sLwfR_Q@mail.gmail.com>
	<b623709f-69ab-b491-3931-7df74745b723@intel.com>
	<CADGSJ223aJjt6X-dA=pKVP3_5+BOQ==Rd017LqBrBsKWqXiNSw@mail.gmail.com>
	<432a4b0a-fadc-3025-b9f6-09fd3e1b384a@intel.com>
	<CADGSJ21rDfqzsnd+m5f6w=LqoTY3Bb0p1Pe+_tppdEm_8HysKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADGSJ21rDfqzsnd+m5f6w=LqoTY3Bb0p1Pe+_tppdEm_8HysKA@mail.gmail.com>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Apologies I didn't notice that the discussion was mistakenly taken
offline. Post it back.

-Siwei

On Sat, Jan 13, 2018 at 7:25 AM, Siwei Liu <loseweigh@gmail.com> wrote:
> On Thu, Jan 11, 2018 at 12:32 PM, Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
>> On 1/8/2018 9:22 AM, Siwei Liu wrote:
>>>
>>> On Sat, Jan 6, 2018 at 2:33 AM, Samudrala, Sridhar
>>> <sridhar.samudrala@intel.com> wrote:
>>>>
>>>> On 1/5/2018 9:07 AM, Siwei Liu wrote:
>>>>>
>>>>> On Thu, Jan 4, 2018 at 8:22 AM, Samudrala, Sridhar
>>>>> <sridhar.samudrala@intel.com> wrote:
>>>>>>
>>>>>> On 1/3/2018 10:28 AM, Alexander Duyck wrote:
>>>>>>>
>>>>>>> On Wed, Jan 3, 2018 at 10:14 AM, Samudrala, Sridhar
>>>>>>> <sridhar.samudrala@intel.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/3/2018 8:59 AM, Alexander Duyck wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Jan 2, 2018 at 6:16 PM, Jakub Kicinski <kubakici@wp.pl>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> On Tue,  2 Jan 2018 16:35:36 -0800, Sridhar Samudrala wrote:
>>>>>>>>>>>
>>>>>>>>>>> This patch series enables virtio to switch over to a VF datapath
>>>>>>>>>>> when
>>>>>>>>>>> a
>>>>>>>>>>> VF
>>>>>>>>>>> netdev is present with the same MAC address. It allows live
>>>>>>>>>>> migration
>>>>>>>>>>> of
>>>>>>>>>>> a VM
>>>>>>>>>>> with a direct attached VF without the need to setup a bond/team
>>>>>>>>>>> between
>>>>>>>>>>> a
>>>>>>>>>>> VF and virtio net device in the guest.
>>>>>>>>>>>
>>>>>>>>>>> The hypervisor needs to unplug the VF device from the guest on the
>>>>>>>>>>> source
>>>>>>>>>>> host and reset the MAC filter of the VF to initiate failover of
>>>>>>>>>>> datapath
>>>>>>>>>>> to
>>>>>>>>>>> virtio before starting the migration. After the migration is
>>>>>>>>>>> completed,
>>>>>>>>>>> the
>>>>>>>>>>> destination hypervisor sets the MAC filter on the VF and plugs it
>>>>>>>>>>> back
>>>>>>>>>>> to
>>>>>>>>>>> the guest to switch over to VF datapath.
>>>>>>>>>>>
>>>>>>>>>>> It is based on netvsc implementation and it may be possible to
>>>>>>>>>>> make
>>>>>>>>>>> this
>>>>>>>>>>> code
>>>>>>>>>>> generic and move it to a common location that can be shared by
>>>>>>>>>>> netvsc
>>>>>>>>>>> and virtio.
>>>>>>>>>>>
>>>>>>>>>>> This patch series is based on the discussion initiated by Jesse on
>>>>>>>>>>> this
>>>>>>>>>>> thread.
>>>>>>>>>>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>>>>>>>>>
>>>>>>>>>> How does the notion of a device which is both a bond and a leg of a
>>>>>>>>>> bond fit with Alex's recent discussions about feature propagation?
>>>>>>>>>> Which propagation rules will apply to VirtIO master?  Meaning of
>>>>>>>>>> the
>>>>>>>>>> flags on a software upper device may be different.  Why muddy the
>>>>>>>>>> architecture like this and not introduce a synthetic bond device?
>>>>>>>>>
>>>>>>>>> It doesn't really fit with the notion I had. I think there may have
>>>>>>>>> been a bit of a disconnect as I have been out for the last week or
>>>>>>>>> so
>>>>>>>>> for the holidays.
>>>>>>>>>
>>>>>>>>> My thought on this was that the feature bit should be spawning a new
>>>>>>>>> para-virtual bond device and that bond should have the virto and the
>>>>>>>>> VF as slaves. Also I thought there was some discussion about trying
>>>>>>>>> to
>>>>>>>>> reuse as much of the netvsc code as possible for this so that we
>>>>>>>>> could
>>>>>>>>> avoid duplication of effort and have the two drivers use the same
>>>>>>>>> approach. It seems like it should be pretty straight forward since
>>>>>>>>> you
>>>>>>>>> would have the feature bit in the case of virto, and netvsc just
>>>>>>>>> does
>>>>>>>>> this sort of thing by default if I am not mistaken.
>>>>>>>>
>>>>>>>> This patch is mostly based on netvsc implementation. The only change
>>>>>>>> is
>>>>>>>> avoiding the
>>>>>>>> explicit dev_open() call of the VF netdev after a delay. I am
>>>>>>>> assuming
>>>>>>>> that
>>>>>>>> the guest userspace
>>>>>>>> will bring up the VF netdev and the hypervisor will update the MAC
>>>>>>>> filters
>>>>>>>> to switch to
>>>>>>>> the right data path.
>>>>>>>> We could commonize the code and make it shared between netvsc and
>>>>>>>> virtio.
>>>>>>>> Do
>>>>>>>> we want
>>>>>>>> to do this right away or later? If so, what would be a good location
>>>>>>>> for
>>>>>>>> these shared functions?
>>>>>>>> Is it net/core/dev.c?
>>>>>>>
>>>>>>> No, I would think about starting a new driver file in "/drivers/net/".
>>>>>>> The idea is this driver would be utilized to create a bond
>>>>>>> automatically and set the appropriate registration hooks. If nothing
>>>>>>> else you could probably just call it something generic like virt-bond
>>>>>>> or vbond or whatever.
>>>>>>
>>>>>>
>>>>>> We are trying to avoid creating another driver or a device.  Can we
>>>>>> look
>>>>>> into
>>>>>> consolidation of the 2 implementations(virtio & netvsc) as a later
>>>>>> patch?
>>>>>>
>>>>>>>> Also, if we want to go with a solution that creates a bond device, do
>>>>>>>> we
>>>>>>>> want virtio_net/netvsc
>>>>>>>> drivers to create a upper device?  Such a solution is already
>>>>>>>> possible
>>>>>>>> via
>>>>>>>> config scripts that can
>>>>>>>> create a bond with virtio and a VF net device as slaves.  netvsc and
>>>>>>>> this
>>>>>>>> patch series is trying to
>>>>>>>> make it as simple as possible for the VM to use directly attached
>>>>>>>> devices
>>>>>>>> and support live migration
>>>>>>>> by switching to virtio datapath as a backup during the migration
>>>>>>>> process
>>>>>>>> when the VF device
>>>>>>>> is unplugged.
>>>>>>>
>>>>>>> We all understand that. But you are making the solution very virtio
>>>>>>> specific. We want to see this be usable for other interfaces such as
>>>>>>> netsc and whatever other virtual interfaces are floating around out
>>>>>>> there.
>>>>>>>
>>>>>>> Also I haven't seen us address what happens as far as how we will
>>>>>>> handle this on the host. My thought was we should have a paired
>>>>>>> interface. Something like veth, but made up of a bond on each end. So
>>>>>>> in the host we should have one bond that has a tap/vhost interface and
>>>>>>> a VF port representor, and on the other we would be looking at the
>>>>>>> virtio interface and the VF. Attaching the tap/vhost to the bond could
>>>>>>> be a way of triggering the feature bit to be set in the virtio. That
>>>>>>> way communication between the guest and the host won't get too
>>>>>>> confusing as you will see all traffic from the bonded MAC address
>>>>>>> always show up on the host side bond instead of potentially showing up
>>>>>>> on two unrelated interfaces. It would also make for a good way to
>>>>>>> resolve the east/west traffic problem on hosts since you could just
>>>>>>> send the broadcast/multicast traffic via the tap/vhost/virtio channel
>>>>>>> instead of having to send it back through the port representor and eat
>>>>>>> up all that PCIe bus traffic.
>>>>>>
>>>>>>   From the host point of view, here is a simple script that needs to be
>>>>>> run to
>>>>>> do the
>>>>>> live migration. We don't need any bond configuration on the host.
>>>>>>
>>>>>> virsh detach-interface $DOMAIN hostdev --mac $MAC
>>>>>> ip link set $PF vf $VF_NUM mac $ZERO_MAC
>>>>>
>>>>> I'm not sure I understand how this script may work with regard to
>>>>> "live" migration.
>>>>>
>>>>> I'm confused, this script seems to require virtio-net to be configured
>>>>> on top of a different PF than where the migrating VF is seated. Or
>>>>> else, how does identical MAC address filter get programmed to one PF
>>>>> with two (or more) child virtual interfaces (e.g. one macvtap for
>>>>> virtio-net plus one VF)? The coincidence of it being able to work on
>>>>> the NIC of one/some vendor(s) does not apply to the others AFAIK.
>>>>>
>>>>> If you're planning to use a different PF, I don't see how gratuitous
>>>>> ARP announcements are generated to make this a "live" migration.
>>>>
>>>>
>>>> I am not using a different PF.  virtio is backed by a tap/bridge with PF
>>>> attached
>>>> to that bridge.  When we reset VF MAC after it is unplugged, all the
>>>> packets
>>>> for
>>>> the guest MAC will go to PF and reach virtio via the bridge.
>>>>
>>> That is the limitation of this scheme: it only works for virtio backed
>>> by tap/bridge, rather than backed by macvtap on top of the
>>> corresponding *PF*. Nowadays more datacenter users prefer macvtap as
>>> opposed to bridge, simply because of better isolation and performance
>>> (e.g. host stack consumption on NIC promiscuity processing are not
>>> scalable for bridges). Additionally, the ongoing virtio receive
>>> zero-copy work will be tightly integrated with macvtap, the
>>> performance optimization of which is apparently difficult (if
>>> technically possible at all) to be done on bridge. Why do we limit the
>>> host backend support to only bridge at this point?
>>
>>
>> No. This should work with virtio backed by macvtap over PF too.
>>
>>>
>>>> If we want to use virtio backed by macvtap on top of another VF as the
>>>> backup
>>>> channel, and we could set the guest MAC to that VF after unplugging the
>>>> directly
>>>> attached VF.
>>>
>>> I meant macvtap on the regarding PF instead of another VF. You know,
>>> users shouldn't have to change guest MAC back and forth. Live
>>> migration shouldn't involve any form of user intervention IMHO.
>>
>> Yes. macvtap on top of PF should work too. Hypervisor doesn't need to change
>> the guest MAC.  The PF driver needs to program the HW MAC filters so that
>> the
>> frames reach PF when VF is unplugged.
>
> So the HW MAC filter is deferred to get programmed for virtio only
> until VF is unplugged, correct? This is not the regular plumbing order
> for macvtap. Unless I miss something obvious, how does this get
> reflected in the script below?
>
>  virsh detach-interface $DOMAIN hostdev --mac $MAC
>  ip link set $PF vf $VF_NUM mac $ZERO_MAC
>
> i.e. commands above won't automatically trigger the programming of MAC
> filters for virtio.
>
> If you program two identical MAC address filters for both VF and
> virito at the same point, I'm sure if won't work at all. It does not
> sound clear to me how you propose to make it work if you don't plan
> to change the plumbing order?
>
>>
>>
>>>
>>>>>> virsh migrate --live $DOMAIN qemu+ssh://$REMOTE_HOST/system
>>>>>>
>>>>>> ssh $REMOTE_HOST ip link set $PF vf $VF_NUM mac $MAC
>>>>>> ssh $REMOTE_HOST virsh attach-interface $DOMAIN hostdev $REMOTE_HOSTDEV
>>>>>> --mac $MAC
>>>>>
>>>>> How do you keep guest side VF configurations e.g. MTU and VLAN filters
>>>>> around across the migration? More broadly, how do you make sure the
>>>>> new VF still as performant as previously done such that all hardware
>>>>> ring tunings and offload settings can be kept as much as it can be?
>>>>> I'm afraid this simple script won't work for those real-world
>>>>> scenarios.
>>>>
>>>>
>>>>> I would agree with Alex that we'll soon need a host-side stub/entity
>>>>> with cached guest configurations that may make VF switching
>>>>> straightforward and transparent.
>>>>
>>>> The script is only adding MAC filter to the VF on the destination. If the
>>>> source host has
>>>> done any additional tunings on the VF they need to be done on the
>>>> destination host too.
>>>
>>> I was mainly saying the VF's run-time configuration in the guest more
>>> than those to be configured from the host side. Let's say guest admin
>>> had changed the VF's MTU value, the default of which is 1500, to 9000
>>> before the migration. How do you save and restore the old running
>>> config for the VF across the migration?
>>
>> Such optimizations should be possible on top of this patch.  We need to sync
>> up
>> any changes/updates to VF configuration/features with virtio.
>
> This is possible but not the ideal way to build it. Virtio perhaps
> would not be the best  place to stack this (VF specifics for live
> migration) up further. We need a new driver and do it right from the
> very beginning.
>
> Thanks,
> -Siwei
>
>>
>>>
>>>> It is also possible that the VF on the destination is based on a totally
>>>> different NIC which
>>>> may be more or less performant. Or the destination may not even support a
>>>> VF
>>>> datapath too.
>>>
>>> This argument is rather weak. In almost all real-world live migration
>>> scenarios, the hardware configurations on both source and destination
>>> are (required to be) identical. Being able to support heterogenous
>>> live migration doesn't mean we can do nothing but throw all running
>>> configs or driver tunings away when it's done. Specifically, I don't
>>> find a reason not to apply the guest network configs including NIC
>>> offload settings if those are commonly supported on both ends, even on
>>> virtio-net. While for some of the configs it might be noticeable for
>>> user to respond to the loss or change, complaints would still arise
>>> when issues are painful to troubleshoot and/or difficult to get them
>>> detected and restored. This is why I say real-world scenarios are more
>>> complex than just switch and go.
>>>
>>
>> Sure. These patches by themselves don't enable live migration automatically.
>> Hypervisor
>> needs to do some additional setup before and after the migration.
