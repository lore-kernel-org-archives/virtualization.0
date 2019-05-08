From: =?UTF-8?Q?Jakub_Staro=c5=84?= via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] virtio-pmem: Add virtio pmem driver
Date: Wed, 8 May 2019 12:05:39 -0700
Message-ID: <3d643ac5-ea1b-efba-9f42-31b2ed3ab5b0__30344.2853315332$1558282873$gmane$org@google.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-3-pagupta@redhat.com>
	<3d6479ae-6c39-d614-f1d9-aa1978e2e438@google.com>
	<1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
Reply-To: =?UTF-8?Q?Jakub_Staro=c5=84?= <jstaron@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
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
To: Pankaj Gupta <pagupta@redhat.com>
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.o
List-Id: virtualization@lists.linuxfoundation.org

On 5/8/19 4:12 AM, Pankaj Gupta wrote:
> 
>>
>> On 4/25/19 10:00 PM, Pankaj Gupta wrote:
>>
>>> +void host_ack(struct virtqueue *vq)
>>> +{
>>> +	unsigned int len;
>>> +	unsigned long flags;
>>> +	struct virtio_pmem_request *req, *req_buf;
>>> +	struct virtio_pmem *vpmem = vq->vdev->priv;
>>> +
>>> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
>>> +	while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
>>> +		req->done = true;
>>> +		wake_up(&req->host_acked);
>>> +
>>> +		if (!list_empty(&vpmem->req_list)) {
>>> +			req_buf = list_first_entry(&vpmem->req_list,
>>> +					struct virtio_pmem_request, list);
>>> +			list_del(&vpmem->req_list);
>>
>> Shouldn't it be rather `list_del(vpmem->req_list.next)`? We are trying to
>> unlink
>> first element of the list and `vpmem->req_list` is just the list head.
> 
> This looks correct. We are not deleting head but first entry in 'req_list'
> which is device corresponding list of pending requests.
> 
> Please see below:
> 
> /**
>  * Retrieve the first list entry for the given list pointer.
>  *
>  * Example:
>  * struct foo *first;
>  * first = list_first_entry(&bar->list_of_foos, struct foo, list_of_foos);
>  *
>  * @param ptr The list head
>  * @param type Data type of the list element to retrieve
>  * @param member Member name of the struct list_head field in the list element.
>  * @return A pointer to the first list element.
>  */
> #define list_first_entry(ptr, type, member) \
>     list_entry((ptr)->next, type, member)

Please look at this StackOverflow question:
https://stackoverflow.com/questions/19675419/deleting-first-element-of-a-list-h-list

Author asks about deleting first element of the queue. In our case
(and also in the question's author case), `vpmem->req_list` is not element
of any request struct and not an element of the list. It's just a list head storing 
`next` and `prev` pointers which are then pointing to respectively first and
last element of the list. We want to unlink the first element of the list,
so we need to pass pointer to the first element of the list to
the `list_del` function - that is, the `vpmem->req_list.next`.

Thank you,
Jakub Staron
