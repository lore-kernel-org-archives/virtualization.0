From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm/balloon_compaction: Informative allocation warnings
Date: Wed, 21 Aug 2019 21:12:34 +0200
Message-ID: <3873b6ab-de6d-cac2-90e8-541fe86e2005__332.472384774007$1566414767$gmane$org@redhat.com>
References: <20190821094159.40795-1-namit@vmware.com>
	<75ff92c2-7ae2-c4a6-cd1f-44741e29d20e@redhat.com>
	<4E10A342-9A51-4C1F-8E5A-8005AACEF4CE@vmware.com>
	<497b1189-8e1d-2926-ee5e-9077fcceb04b@redhat.com>
	<36AC2460-9E88-4BAF-B793-A14A00E41617@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <36AC2460-9E88-4BAF-B793-A14A00E41617@vmware.com>
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
To: Nadav Amit <namit@vmware.com>
Cc: Linux-MM <linux-mm@kvack.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 21.08.19 21:10, Nadav Amit wrote:
>> On Aug 21, 2019, at 12:06 PM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.08.19 20:59, Nadav Amit wrote:
>>>> On Aug 21, 2019, at 11:57 AM, David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 21.08.19 11:41, Nadav Amit wrote:
>>>>> There is no reason to print generic warnings when balloon memory
>>>>> allocation fails, as failures are expected and can be handled
>>>>> gracefully. Since VMware balloon now uses balloon-compaction
>>>>> infrastructure, and suppressed these warnings before, it is also
>>>>> beneficial to suppress these warnings to keep the same behavior that the
>>>>> balloon had before.
>>>>>
>>>>> Since such warnings can still be useful to indicate that the balloon is
>>>>> over-inflated, print more informative and less frightening warning if
>>>>> allocation fails instead.
>>>>>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>>>
>>>>> ---
>>>>>
>>>>> v1->v2:
>>>>> * Print informative warnings instead suppressing [David]
>>>>> ---
>>>>> mm/balloon_compaction.c | 7 ++++++-
>>>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>>>>> index 798275a51887..0c1d1f7689f0 100644
>>>>> --- a/mm/balloon_compaction.c
>>>>> +++ b/mm/balloon_compaction.c
>>>>> @@ -124,7 +124,12 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>>>>> struct page *balloon_page_alloc(void)
>>>>> {
>>>>> 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
>>>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY);
>>>>> +				       __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>> +				       __GFP_NOWARN);
>>>>> +
>>>>> +	if (!page)
>>>>> +		pr_warn_ratelimited("memory balloon: memory allocation failed");
>>>>> +
>>>>> 	return page;
>>>>> }
>>>>> EXPORT_SYMBOL_GPL(balloon_page_alloc);
>>>>
>>>> Not sure if "memory balloon" is the right wording. hmmm.
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>
>>> Do you have a better suggestion?
>>
>> Not really - that's why I ack'ed :)
>>
>> However, thinking about it - what about moving the check + print to the
>> caller and then using dev_warn... or sth. like simple "virtio_balloon:
>> ..." ? You can then drop the warning for vmware balloon if you feel like
>> not needing it.
> 
> Actually, there is already a warning that is printed by the virtue_balloon
> in fill_balloon():
> 
>                 struct page *page = balloon_page_alloc();
> 
>                 if (!page) {
>                         dev_info_ratelimited(&vb->vdev->dev,
>                                              "Out of puff! Can't get %u pages\n",
>                                              VIRTIO_BALLOON_PAGES_PER_PAGE);
>                         /* Sleep for at least 1/5 of a second before retry. */
>                         msleep(200);
>                         break;
>                 }
> 
> So are you ok with going back to v1?
> 

Whoops, I missed that - sorry - usually the warnings scream louder at me :D

Yes, v1 is fine with me!

-- 

Thanks,

David / dhildenb
