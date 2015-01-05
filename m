From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 0/3] Sharing MSIX irq for tx/rx queue pairs
Date: Mon, 05 Jan 2015 11:09:42 +0800
Message-ID: <54AA0076.9030406@redhat.com>
References: <1419562425-20614-1-git-send-email-jasowang@redhat.com>
	<20141228075226.GA25704@redhat.com> <54A8FBF9.7000105@redhat.com>
	<20150104113613.GC4336@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150104113613.GC4336@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 01/04/2015 07:36 PM, Michael S. Tsirkin wrote:
> On Sun, Jan 04, 2015 at 04:38:17PM +0800, Jason Wang wrote:
>> On 12/28/2014 03:52 PM, Michael S. Tsirkin wrote:
>>> On Fri, Dec 26, 2014 at 10:53:42AM +0800, Jason Wang wrote:
>>>> Hi all:
>>>>
>>>> This series try to share MSIX irq for each tx/rx queue pair. This is
>>>> done through:
>>>>
>>>> - introducing virtio pci channel which are group of virtqueues that
>>>>   sharing a single MSIX irq (Patch 1)
>>>> - expose channel setting to virtio core api (Patch 2)
>>>> - try to use channel setting in virtio-net (Patch 3)
>>>>
>>>> For the transport that does not support channel, channel paramters
>>>> were simply ignored. For devices that does not use channel, it can
>>>> simply pass NULL or zero to virito core.
>>>>
>>>> With the patch, 1 MSIX irq were saved for each TX/RX queue pair.
>>>>
>>>> Please review.
>>> How does this sharing affect performance?
>>>
>> Patch 3 only checks more_used() for tx ring which in fact reduces the
>> effect of event index and may introduce more tx interrupts. After fixing
>> this issue, tested with 1 vcpu and 1 queue. No obvious changes in
>> performance were noticed.
>>
>> Thanks
> Is this with or without MQ?

Without MQ. 1 vcpu and 1 queue were used.
> With MQ, it seems easy to believe as interrupts are
> distributed between CPUs.
>
> Without MQ, it should be possible to create UDP workloads where
> processing incoming and outgoing interrupts
> on separate CPUs is a win.

Not sure. Processing on separate CPUs may only win when the system is
not busy. But if we processing a single flow in two cpus, it may lead
extra lock contention and bad cache utilization.
And if we really want to distribute the load, RPS/RFS could be used.
