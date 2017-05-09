From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v9 2/5] virtio-balloon:
	VIRTIO_BALLOON_F_BALLOON_CHUNKS
Date: Tue, 09 May 2017 10:45:59 +0800
Message-ID: <59112D67.9080405__35480.4745446474$1494297855$gmane$org@intel.com>
References: <1492076108-117229-3-git-send-email-wei.w.wang@intel.com>
	<20170413184040-mutt-send-email-mst@kernel.org>
	<58F08A60.2020407@intel.com>
	<20170415000934-mutt-send-email-mst@kernel.org>
	<58F43801.7060004@intel.com>
	<286AC319A985734F985F78AFA26841F7391F6DCD@shsmsx102.ccr.corp.intel.com>
	<20170426192753-mutt-send-email-mst@kernel.org>
	<59019055.3040708@intel.com>
	<20170506012322-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7391FFBB0@shsmsx102.ccr.corp.intel.com>
	<20170508203533-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170508203533-mutt-send-email-mst@kernel.org>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On 05/09/2017 01:40 AM, Michael S. Tsirkin wrote:
> On Sun, May 07, 2017 at 04:19:28AM +0000, Wang, Wei W wrote:
>> On 05/06/2017 06:26 AM, Michael S. Tsirkin wrote:
>>> On Thu, Apr 27, 2017 at 02:31:49PM +0800, Wei Wang wrote:
>>>> On 04/27/2017 07:20 AM, Michael S. Tsirkin wrote:
>>>>> On Wed, Apr 26, 2017 at 11:03:34AM +0000, Wang, Wei W wrote:
>>>>>> Hi Michael, could you please give some feedback?
>>>>> I'm sorry, I'm not sure feedback on what you are requesting.
>>>> Oh, just some trivial things (e.g. use a field in the header,
>>>> hdr->chunks to indicate the number of chunks in the payload) that
>>>> wasn't confirmed.
>>>>
>>>> I will prepare the new version with fixing the agreed issues, and we
>>>> can continue to discuss those parts if you still find them improper.
>>>>
>>>>
>>>>> The interface looks reasonable now, even though there's a way to
>>>>> make it even simpler if we can limit chunk size to 2G (in fact 4G -
>>>>> 1). Do you think we can live with this limitation?
>>>> Yes, I think we can. So, is it good to change to use the previous
>>>> 64-bit chunk format (52-bit base + 12-bit size)?
>>> This isn't what I meant. virtio ring has descriptors with a 64 bit address and 32 bit
>>> size.
>>>
>>> If size < 4g is not a significant limitation, why not just use that to pass
>>> address/size in a standard s/g list, possibly using INDIRECT?
>> OK, I see your point, thanks. Post the two options here for an analysis:
>> Option1 (what we have now):
>> struct virtio_balloon_page_chunk {
>>          __le64 chunk_num;
>>          struct virtio_balloon_page_chunk_entry entry[];
>> };
>> Option2:
>> struct virtio_balloon_page_chunk {
>>          __le64 chunk_num;
>>          struct scatterlist entry[];
>> };
> This isn't what I meant really :) I meant vring_desc.

OK. Repost the code change:

Option2:
struct virtio_balloon_page_chunk {
         __le64 chunk_num;
         struct ving_desc entry[];
};

We pre-allocate a table of desc, and each desc is used to hold a chunk.

In that case, the virtqueue_add() function, which deals with sg, is not
usable for us. We may need to add a new one,
virtqueue_add_indirect_desc(),
to add a pre-allocated indirect descriptor table to vring.


>
>> I don't have an issue to change it to Option2, but I would prefer Option1,
>> because I think there is no be obvious difference between the two options,
>> while Option1 appears to have little advantages here:
>> 1) "struct virtio_balloon_page_chunk_entry" has smaller size than
>> "struct scatterlist", so the same size of allocated page chunk buffer
>> can hold more entry[] using Option1;
>> 2) INDIRECT needs on demand kmalloc();
> Within alloc_indirect?  We can fix that with a separate patch.
>
>
>> 3) no 4G size limit;
> Do you see lots of >=4g chunks in practice?
It wouldn't be much in practice, but we still need the extra code to
handle the case - break larger chunks into less-than 4g ones.

Best,
Wei
