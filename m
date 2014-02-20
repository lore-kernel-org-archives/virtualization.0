From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 RFC 0/3] virtio: add 'device_lost' to virtio_device
Date: Thu, 20 Feb 2014 16:39:25 +0100
Message-ID: <530621AD.7050503@linux.vnet.ibm.com>
References: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<878uu72tcq.fsf@rustcorp.com.au>
	<52E7D6F1.1020900@linux.vnet.ibm.com>
	<87ha8nxpsc.fsf@rustcorp.com.au>
	<53033CC0.3090502@linux.vnet.ibm.com>
	<87zjlm9pne.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87zjlm9pne.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com, Jens Axboe <axboe@kernel.dk>
List-Id: virtualization@lists.linuxfoundation.org

On 20/02/14 09:03, Rusty Russell wrote:
> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>> On 29/01/14 07:31, Rusty Russell wrote:
>>> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>>>> On 23/01/14 05:51, Rusty Russell wrote:
>>>>> Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
>>>>>> Hi, here is my v4 patch-set update to the v3 RFC submitted on Nov 27th.
>>>>>
>>>>> Hi Heinz,
>>>>>
>>>>>            I didn't get a response on my 'break all the virtqueues' patch
>>>>> series.  Could your System Z code work with this?
>>>>>
>>>>> Rusty.
>>>>>
>>>>>
>>>>
>>>> Sorry Rusty, I'm back as of today.
>>>>
>>>> I applied your patch series and did some testing...
>>>>
>>>> Removing a disk while reading from it mostly still ends up
>>>> in hangs as of below:
>>>
>>> OK, we still have the problem of in-flight requests.
>>>
>>> I think the correct answer is to drop all requests if the virtqueue
>>> is broken:
>>>
>>>    -	blk_cleanup_queue(vblk->disk->queue);
>>>    +	if (virtqueue_is_broken(vblk->vq))
>>>    +              /* Don't wait for completion, just drop queue. */
>>>    +              blk_abandon_queue(vblk->disk->queue);
>> Rusty,
>>
>> but blk_abandon_queue() would not solve the incomplete in-flight
>> requests, would it? I suppose it would avoid additional in-flight
>> requests similar to __blk_request_all() and passing -EIO.
>>
>> Ending of asynchronous in-flight requests still cause other problems
>> in the host. Such problems should be handled/avoided there, I suppose.
>
> The device is going away (or gone away!), so it shouldn't be completing
> requests, right?

well, the device is gone and blk_cleanup_queue() should avoid synching 
data to disk. That is the approach of my original patch-set.

I'll try to find an alternative solution exploiting the new
virtio_break_device().

Heinz

>
> If the device is actually broken, well, there's not much we can do.  We
> could try to leak memory I suppose.
>
> Cheers,
> Rusty.
>
