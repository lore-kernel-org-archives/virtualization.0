From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Mon, 22 Jan 2018 17:37:20 -0800
Message-ID: <f44e28d8-d96e-e8b5-594a-2a66957a902d__44032.7466851615$1516671427$gmane$org@intel.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
	<CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
	<20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
	<20180117213527-mutt-send-email-mst@kernel.org>
	<CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
	<20180122231713-mutt-send-email-mst@kernel.org>
	<7edf772b-627c-6121-3332-479caed524da@intel.com>
	<20180122160204.130451f2@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180122160204.130451f2@xeon-e3>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


On 1/22/2018 4:02 PM, Stephen Hemminger wrote:
>
>>>   
>>>> In the case of SwitchDev it
>>>> should be possible for the port representors and the switch to provide
>>>> data on which interfaces are bonded on the host side and which aren't.
>>>> With that data it would be pretty easy to just put together a list of
>>>> addresses that would prefer to go the para-virtual route instead of
>>>> being transmitted through physical hardware.
>>>>
>>>> In addition a bridge implies much more overhead since normally a
>>>> bridge can receive a packet in on one interface and transmit it on
>>>> another. We don't really need that. This is more of a VEPA type setup
>>>> and doesn't need to be anything all that complex. You could probably
>>>> even handle the Tx queue selection via a simple eBPF program and map
>>>> since the input for whatever is used to select Tx should be pretty
>>>> simple, destination MAC, source NUMA node, etc, and the data-set
>>>> shouldn't be too large.
>>> That sounds interesting. A separate device might make this kind of setup
>>> a bit easier.  Sridhar, did you look into creating a separate device for
>>> the virtual bond device at all?  It does not have to be in a separate
>>> module, that kind of refactoring can come later, but once we commit to
>>> using the same single device as virtio, we can't change that.
>> No. I haven't looked into creating a separate device. If we are going to
>> create a new
>> device, i guess it has to be of a new device type with its own driver.
>>
>> As we are using virtio_net to control and manage the VF data path, it is
>> not clear to me
>> what is the advantage of creating a new device rather than extending
>> virtio_net to manage
>> the VF datapath via transparent bond mechanism.
>>
>> Thanks
>> Sridhar
>>
>>
> The requirement with Azure accelerated network was that a stock distribution image from the
> store must be able to run unmodified and get accelerated networking.
> Not sure if other environments need to work the same, but it would be nice.
>
> That meant no additional setup scripts (aka no bonding) and also it must
> work transparently with hot-plug. Also there are diverse set of environments:
> openstack, cloudinit, network manager and systemd. The solution had to not depend
> on any one of them, but also not break any of them.
Yes. Cloud Service Providers using KVM as hypervisor have a similar 
requirement to provide accelerated
networking with VM images that support virtio_net.

Thanks
Sridhar
