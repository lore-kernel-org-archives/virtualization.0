From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Date: Tue, 31 Mar 2020 16:09:59 +0200
Message-ID: <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200331100359-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 31.03.20 16:07, Michael S. Tsirkin wrote:
> On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
>> On 31.03.20 15:37, Michael S. Tsirkin wrote:
>>> On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
>>>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
>>>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote=
:
>>>>>>>>
>>>>>>>>
>>>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.c=
om>:
>>>>>>>>>
>>>>>>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hilden=
brand wrote:
>>>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand w=
rote:
>>>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fa=
stest
>>>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be =
able to make
>>>>>>>>>>>> use of THP where it previously was able to. I can imagine th=
is implies a
>>>>>>>>>>>> performance degradation for some workloads. This needs a pro=
per
>>>>>>>>>>>> performance evaluation.
>>>>>>>>>>>
>>>>>>>>>>> I think the problem is more with the alloc_pages API.
>>>>>>>>>>> That gives you exactly the given order, and if there's
>>>>>>>>>>> a larger chunk available, it will split it up.
>>>>>>>>>>>
>>>>>>>>>>> But for balloon - I suspect lots of other users,
>>>>>>>>>>> we do not want to stress the system but if a large
>>>>>>>>>>> chunk is available anyway, then we could handle
>>>>>>>>>>> that more optimally by getting it all in one go.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
>>>>>>>>>>> Along the lines of
>>>>>>>>>>>
>>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_=
order,
>>>>>>>>>>>                    unsigned int max_order, unsigned int *orde=
r)
>>>>>>>>>>>
>>>>>>>>>>> the idea would then be to return at a number of pages in the =
given
>>>>>>>>>>> range.
>>>>>>>>>>>
>>>>>>>>>>> What do you think? Want to try implementing that?
>>>>>>>>>>
>>>>>>>>>> You can just start with the highest order and decrement the or=
der until
>>>>>>>>>> your allocation succeeds using alloc_pages(), which would be e=
nough for
>>>>>>>>>> a first version. At least I don't see the immediate need for a=
 new
>>>>>>>>>> kernel API.
>>>>>>>>>
>>>>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim=
 is
>>>>>>>>> completely disabled, any of these calls can sleep. After it wak=
es up,
>>>>>>>>> we would like to get the larger order that has become available
>>>>>>>>> meanwhile.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yes, but that=E2=80=98s a pure optimization IMHO.
>>>>>>>> So I think we should do a trivial implementation first and then =
see what we gain from a new allocator API. Then we might also be able to =
justify it using real numbers.
>>>>>>>>
>>>>>>>
>>>>>>> Well how do you propose implement the necessary semantics?
>>>>>>> I think we are both agreed that alloc_page_range is more or
>>>>>>> less what's necessary anyway - so how would you approximate it
>>>>>>> on top of existing APIs?
>>>>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/ba=
lloon_compaction.h
>>>
>>> .....
>>>
>>>
>>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>>>>>> index 26de020aae7b..067810b32813 100644
>>>>>> --- a/mm/balloon_compaction.c
>>>>>> +++ b/mm/balloon_compaction.c
>>>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct ball=
oon_dev_info *b_dev_info,
>>>>>>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>>>>>> =20
>>>>>>  /*
>>>>>> - * balloon_page_alloc - allocates a new page for insertion into t=
he balloon
>>>>>> - *			page list.
>>>>>> + * balloon_pages_alloc - allocates a new page (of at most the giv=
en order)
>>>>>> + * 			 for insertion into the balloon page list.
>>>>>>   *
>>>>>>   * Driver must call this function to properly allocate a new ball=
oon page.
>>>>>>   * Driver must call balloon_page_enqueue before definitively remo=
ving the page
>>>>>>   * from the guest system.
>>>>>>   *
>>>>>> + * Will fall back to smaller orders if allocation fails. The orde=
r of the
>>>>>> + * allocated page is stored in page->private.
>>>>>> + *
>>>>>>   * Return: struct page for the allocated page or NULL on allocati=
on failure.
>>>>>>   */
>>>>>> -struct page *balloon_page_alloc(void)
>>>>>> +struct page *balloon_pages_alloc(int order)
>>>>>>  {
>>>>>> -	struct page *page =3D alloc_page(balloon_mapping_gfp_mask() |
>>>>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>> -				       __GFP_NOWARN);
>>>>>> -	return page;
>>>>>> +	struct page *page;
>>>>>> +
>>>>>> +	while (order >=3D 0) {
>>>>>> +		page =3D alloc_pages(balloon_mapping_gfp_mask() |
>>>>>> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>> +				   __GFP_NOWARN, order);
>>>>>> +		if (page) {
>>>>>> +			set_page_private(page, order);
>>>>>> +			return page;
>>>>>> +		}
>>>>>> +		order--;
>>>>>> +	}
>>>>>> +	return NULL;
>>>>>>  }
>>>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
>>>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
>>>>>> =20
>>>>>>  /*
>>>>>>   * balloon_page_enqueue - inserts a new page into the balloon pag=
e list.
>>>>>
>>>>>
>>>>> I think this will try to invoke direct reclaim from the first itera=
tion
>>>>> to free up the max order.
>>>>
>>>> %__GFP_NORETRY: The VM implementation will try only very lightweight
>>>> memory direct reclaim to get some memory under memory pressure (thus=
 it
>>>> can sleep). It will avoid disruptive actions like OOM killer.
>>>>
>>>> Certainly good enough for a first version I would say, no?
>>>
>>> Frankly how well that behaves would depend a lot on the workload.
>>> Can regress just as well.
>>>
>>> For the 1st version I'd prefer something that is the least disruptive=
,
>>> and that IMHO means we only trigger reclaim at all in the same config=
uration
>>> as now - when we can't satisfy the lowest order allocation.
>>
>> Agreed.
>>
>>>
>>> Anything else would be a huge amount of testing with all kind of
>>> workloads.
>>>
>>
>> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
>> GFP_TRANSHUGE_LIGHT)
>=20
> That will improve the situation when reclaim is not needed, but leave
> the problem in place for when it's needed: if reclaim does trigger, we
> can get a huge free page and immediately break it up.
>=20
> So it's ok as a first step but it will make the second step harder as
> we'll need to test with reclaim :).

I expect the whole "steal huge pages from your guest" to be problematic,
as I already mentioned to Alex. This needs a performance evaluation.

This all smells like a lot of workload dependent fine-tuning. :)

--=20
Thanks,

David / dhildenb
