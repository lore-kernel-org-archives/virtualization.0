From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 0/3] Sharing MSIX irq for tx/rx queue pairs
Date: Mon, 05 Jan 2015 13:10:14 +0800
Message-ID: <54AA1CB6.9020109@redhat.com>
References: <1419562425-20614-1-git-send-email-jasowang@redhat.com>
	<87ppauovjb.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ppauovjb.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 01/05/2015 09:39 AM, Rusty Russell wrote:
> Jason Wang <jasowang@redhat.com> writes:
>> Hi all:
>>
>> This series try to share MSIX irq for each tx/rx queue pair. This is
>> done through:
>>
>> - introducing virtio pci channel which are group of virtqueues that
>>   sharing a single MSIX irq (Patch 1)
>> - expose channel setting to virtio core api (Patch 2)
>> - try to use channel setting in virtio-net (Patch 3)
> Hi Jason,
>
>         Is "channel" a term you created yourself, or something I was
> just unaware of?  

By myself and probably not accurate.
> irq_group would seem more obvious, if the former.
>

Yes, will use this in next version. Thanks.
>> For the transport that does not support channel, channel paramters
>> were simply ignored. For devices that does not use channel, it can
>> simply pass NULL or zero to virito core.
>>
>> With the patch, 1 MSIX irq were saved for each TX/RX queue pair.
> It seems fairly straightforward.
>
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>
>
> Thanks,
> Rusty.
> --
