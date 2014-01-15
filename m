From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4 RFC 0/3] virtio: add 'device_lost' to virtio_device
Date: Wed, 15 Jan 2014 12:48:42 +1030
Message-ID: <874n56xa0t.fsf@rustcorp.com.au>
References: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<87r49cm9cf.fsf@rustcorp.com.au>
	<52B05951.6050500@linux.vnet.ibm.com>
	<878uvhn13r.fsf@rustcorp.com.au>
	<52B7F6B1.9070300@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <52B7F6B1.9070300@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> On 19/12/13 01:19, Rusty Russell wrote:
>> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>>> On 17/12/13 04:42, Rusty Russell wrote:
>>>> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>>>>> Hi, here is my v4 patch-set update to the v3 RFC submitted on Nov 27th.
>>>>>
>>>>> When an active virtio block device is hot-unplugged from a KVM guest,
>>>>> affected guest user applications are not aware of any errors that occur
>>>>> due to the lost device. This patch-set adds code to avoid further request
>>>>> queueing when a lost block device is detected, resulting in appropriate
>>>>> error info. Additionally a potential hang situation can be avoided by not
>>>>> waiting for requests (e.g. in-flight requests) in blk_cleanup_queue() that
>>>>> will never complete.
>>>>>
>>>>> On System z there exists no handshake mechanism between host and guest
>>>>> when a device is hot-unplugged. The device is removed and no further I/O
>>>>> is possible.
>>>>
>>>>
>>>> Hi Heinz,
>>>>
>>>>           If you simply mark every virtqueue as broken when this
>>>> unexpected unplug happens, does that not Just Work?
>>>>
>>>> I think I've asked this before...
>>>> Rusty.
>>>
>>> Hi Rusty,
>>>
>>> setting the (one) virtqueue, vblk is currently using, as broken doesn't
>>> solve the problems.
>>>
>>> In that case virtblk_request()s still succeed  - like this one...
>>
>> No, you set *all* virtqueues broken.  Which is accurate, right?
>>
>> Cheers,
>> Rusty.
>>
>
> I'm sorry, but I don't get this.
> The vblk involved has only 1 virtqueue.
> What do you mean by all "*all* virtqueues ?

Sorry, that was my mistake.  I was referring to the general problem,
and didn't read your previous response.

OK, firstly virtqueue_add *should* fail if vq is broken.  Then it would
work, right?  ie.  Our drivers should already handle the case where a
virtqueue is marked broken, right?  Otherwise they're not robust.

Patch queue coming...

Thanks,
Rusty.
