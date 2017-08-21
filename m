From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v14 5/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
Date: Mon, 21 Aug 2017 13:21:38 +0800
Message-ID: <599A6DE2.3040309__48300.6831411787$1503292734$gmane$org@intel.com>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-6-git-send-email-wei.w.wang@intel.com>
	<20170818045519-mutt-send-email-mst@kernel.org>
	<5996A845.4010405@intel.com>
	<20170818211119-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170818211119-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mawilcox@microsoft.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mhocko@kernel.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 08/19/2017 02:26 AM, Michael S. Tsirkin wrote:
> On Fri, Aug 18, 2017 at 04:41:41PM +0800, Wei Wang wrote:
>> On 08/18/2017 10:13 AM, Michael S. Tsirkin wrote:
>>> On Thu, Aug 17, 2017 at 11:26:56AM +0800, Wei Wang wrote:
>>>> Add a new vq to report hints of guest free pages to the host.
>>> Please add some text here explaining the report_free_page_signal
>>> thing.
>>>
>>>
>>> I also really think we need some kind of ID in the
>>> buffer to do a handshake. whenever id changes you
>>> add another outbuf.
>> Please let me introduce the current design first:
>> 1) device put the signal buf to the vq and notify the driver (we need
>> a buffer because currently the device can't notify when the vq is empty);
>>
>> 2) the driver starts the report of free page blocks via inbuf;
>>
>> 3) the driver adds an the signal buf via outbuf to tell the device all are
>> reported.
>>
>>
>> Could you please elaborate more on the usage of ID?
> While driver is free to maintain at most one buffer in flight
> the design must work with pipelined requests as that
> is important for performance.

How would the pipeline be designed?

Currently, once the report starts,
- the driver work: add_inbuf(free_pages) & kick;

- the device work:
     record the pages into a free page bitmap;
     virtqueue_push(elem);
     virtio_notify();

For the driver, as long as the vq has available entries, it keeps doing 
its work;
For the device, as long as there are free pages in the vq, it also keeps 
doing its work.


>
> So host might be able to request the reporting twice.
> How does it know what is the report in response to?

The request to start is sent when live migration starts, where would be
the second chance to send the request to start?



>
> If we put an id in request and in response, then that fixes it.
>
>
> So there's a vq used for requesting free page reports.
> driver does add_inbuf( &device->id).
>
> Then when it starts reporting it does
>
>
> add_outbuf(&device->id)
>
> followed by pages.
>
>
> Also if device->id changes it knows it should restart
> reporting from beginning.
>
>
>
>
>
>
>>>> +retry:
>>>> +	ret = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
>>>> +	virtqueue_kick(vq);
>>>> +	if (unlikely(ret == -ENOSPC)) {
>>> what if there's another error?
>> Another error is -EIO, how about disabling the free page report feature?
>> (I also saw it isn't handled in many other virtio devices e.g. virtio-net)
>>
>>>> +		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
>>>> +		goto retry;
>>>> +	}
>>> what is this trickery doing? needs more comments or
>>> a simplification.
>> Just this:
>> if the vq is full, blocking wait till an entry gets released, then retry.
>> This is the
>> final one, which puts the signal buf to the vq to signify the end of the
>> report and
>> the mm lock is not held here, so it is fine to block.
>>
> But why do you kick here on failure? I would understand it if you
> did not kick when adding pages, as it is I don't understand.
>
>
> Also pls rewrite this with a for or while loop for clarity.

OK, I will rewrite this part.


Best,
Wei
