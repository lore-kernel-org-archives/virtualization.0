From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v34 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Wed, 27 Jun 2018 11:00:05 +0800
Message-ID: <5B32FDB5.4040506@intel.com>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
	<1529928312-30500-3-git-send-email-wei.w.wang@intel.com>
	<20180626002822-mutt-send-email-mst@kernel.org>
	<5B31B71B.6080709@intel.com>
	<20180626064338-mutt-send-email-mst@kernel.org>
	<5B323140.1000306@intel.com>
	<20180626163139-mutt-send-email-mst@kernel.org>
	<5B32E742.8080902@intel.com>
	<20180627053952-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180627053952-mutt-send-email-mst@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 06/27/2018 10:41 AM, Michael S. Tsirkin wrote:
> On Wed, Jun 27, 2018 at 09:24:18AM +0800, Wei Wang wrote:
>> On 06/26/2018 09:34 PM, Michael S. Tsirkin wrote:
>>> On Tue, Jun 26, 2018 at 08:27:44PM +0800, Wei Wang wrote:
>>>> On 06/26/2018 11:56 AM, Michael S. Tsirkin wrote:
>>>>> On Tue, Jun 26, 2018 at 11:46:35AM +0800, Wei Wang wrote:
>>>>>
>>>>>>>> +	if (!arrays)
>>>>>>>> +		return NULL;
>>>>>>>> +
>>>>>>>> +	for (i = 0; i < max_array_num; i++) {
>>>>>>> So we are getting a ton of memory here just to free it up a bit later.
>>>>>>> Why doesn't get_from_free_page_list get the pages from free list for us?
>>>>>>> We could also avoid the 1st allocation then - just build a list
>>>>>>> of these.
>>>>>> That wouldn't be a good choice for us. If we check how the regular
>>>>>> allocation works, there are many many things we need to consider when pages
>>>>>> are allocated to users.
>>>>>> For example, we need to take care of the nr_free
>>>>>> counter, we need to check the watermark and perform the related actions.
>>>>>> Also the folks working on arch_alloc_page to monitor page allocation
>>>>>> activities would get a surprise..if page allocation is allowed to work in
>>>>>> this way.
>>>>>>
>>>>> mm/ code is well positioned to handle all this correctly.
>>>> I'm afraid that would be a re-implementation of the alloc functions,
>>> A re-factoring - you can share code. The main difference is locking.
>>>
>>>> and
>>>> that would be much more complex than what we have. I think your idea of
>>>> passing a list of pages is better.
>>>>
>>>> Best,
>>>> Wei
>>> How much memory is this allocating anyway?
>>>
>> For every 2TB memory that the guest has, we allocate 4MB.
> Hmm I guess I'm missing something, I don't see it:
>
>
> +       max_entries = max_free_page_blocks(ARRAY_ALLOC_ORDER);
> +       entries_per_page = PAGE_SIZE / sizeof(__le64);
> +       entries_per_array = entries_per_page * (1 << ARRAY_ALLOC_ORDER);
> +       max_array_num = max_entries / entries_per_array +
> +                       !!(max_entries % entries_per_array);
>
> Looks like you always allocate the max number?

Yes. We allocated the max number and then free what's not used.
For example, a 16TB guest, we allocate Four 4MB buffers and pass the 4 
buffers to get_from_free_page_list. If it uses 3, then the remaining 1 
"4MB buffer" will end up being freed.

For today's guests, max_array_num is usually 1.

Best,
Wei
