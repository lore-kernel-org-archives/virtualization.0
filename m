From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [RFC] Discuss about an new idea "Vsock over Virtio-net"
Date: Thu, 15 Nov 2018 16:38:47 +0800
Message-ID: <5BED3097.8000708@huawei.com>
References: <5BECEE53.7090408@huawei.com>
	<20181115015547-mutt-send-email-mst@kernel.org>
	<5BED2267.8030306@huawei.com>
	<20181115025622-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115025622-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 2018/11/15 16:10, Michael S. Tsirkin wrote:
> On Thu, Nov 15, 2018 at 03:38:15PM +0800, jiangyiwen wrote:
>> On 2018/11/15 15:04, Michael S. Tsirkin wrote:
>>> On Thu, Nov 15, 2018 at 11:56:03AM +0800, jiangyiwen wrote:
>>>> Hi Stefan, Michael, Jason and everyone,
>>>>
>>>> Several days ago, I discussed with jason about "Vsock over Virtio-net".
>>>> This idea has two advantages:
>>>> First, it can use many great features of virtio-net, like batching,
>>>> mergeable rx buffer and multiqueue, etc.
>>>> Second, it can reduce many duplicate codes and make it easy to be
>>>> maintained.
>>>
>>> I'm not sure I get the motivation. Which features of
>>> virtio net are relevant to vsock? The ones that you mention
>>> all seem to be mostly of use to the networking stack.
>>>
>>>
>>>> Before the implement, I want to discuss with everyone again, and
>>>> want to know everyone's suggestions.
>>>>
>>>> After the discussion, based on this point I will try to implement
>>>> this idea, but I am not familiar with the virtio-net, that is a
>>>> pity. :(
>>>>
>>>> -------------------------Simple idea------------------------------
>>>>
>>>> 1. The packet layout will become as follows:
>>>>
>>>> +---------------------------------+
>>>> |        Virtio-net header        |
>>>> |(struct virtio_net_hdr_mrg_rxbuf)|
>>>
>>> Which fields in virtio_net_hdr_mrg_rxbuf are of interest to vsock?
>>>
>>
>> Hi Michael,
>>
>> Yes, currently vsock has poor performance, first, it only support transport
>> small packet, in order to make the balance between performance and guest memory.
>>
>> In order to solve this problem, there are two features vsock can used,
>> mergeable rx buffer and multiqueue. Based on this, there are some shared
>> codes vsock can use.
>>
>> Thanks,
>> Yiwen.
> 
> Supporting more queues with vsock is probably significantly
> less work than a completely new interface.
> For mergeable, as buffers are split arbitrarily, why can't you combine
> them within guest driver before sending them up the stack?
> Probably better than relying on host to do it.
> 

Actually, I want to said the mergeable *rx* buffer, it cause the
default packet size of vsock is set to 4k. For tx buffer, it is
actually can be scattered in tx vq only need to modify very few codes.

In addition, I has already first version about vsock support mergeable
rx buffer and send patch to the VSOCK community, these codes are
revisited from virtio-net, and some codes are duplicated. Based on
this, we want to use virtio-net as transport of vsock. It can make
the vsock code easy to maintained.

Thanks.

>>>> +---------------------------------+
>>>> |          Vsock header           |
>>>> |    (struct virtio_vsock_hdr)    |
>>>> +---------------------------------+
>>>> |             payload             |
>>>> |      (until end of packet)      |
>>>> +---------------------------------+
>>>
>>> Thanks,
>>>
>>
> 
> .
> 
