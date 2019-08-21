From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] mm/balloon_compaction: Informative allocation warnings
Date: Wed, 21 Aug 2019 18:59:32 +0000
Message-ID: <4E10A342-9A51-4C1F-8E5A-8005AACEF4CE__29656.3418860146$1566414005$gmane$org@vmware.com>
References: <20190821094159.40795-1-namit@vmware.com>
	<75ff92c2-7ae2-c4a6-cd1f-44741e29d20e@redhat.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <75ff92c2-7ae2-c4a6-cd1f-44741e29d20e@redhat.com>
Content-Language: en-US
Content-ID: <3A38FA3954F90E49AB4A1D4968549FAF@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Linux-MM <linux-mm@kvack.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On Aug 21, 2019, at 11:57 AM, David Hildenbrand <david@redhat.com> wrote:
> 
> On 21.08.19 11:41, Nadav Amit wrote:
>> There is no reason to print generic warnings when balloon memory
>> allocation fails, as failures are expected and can be handled
>> gracefully. Since VMware balloon now uses balloon-compaction
>> infrastructure, and suppressed these warnings before, it is also
>> beneficial to suppress these warnings to keep the same behavior that the
>> balloon had before.
>> 
>> Since such warnings can still be useful to indicate that the balloon is
>> over-inflated, print more informative and less frightening warning if
>> allocation fails instead.
>> 
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> 
>> ---
>> 
>> v1->v2:
>>  * Print informative warnings instead suppressing [David]
>> ---
>> mm/balloon_compaction.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>> index 798275a51887..0c1d1f7689f0 100644
>> --- a/mm/balloon_compaction.c
>> +++ b/mm/balloon_compaction.c
>> @@ -124,7 +124,12 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>> struct page *balloon_page_alloc(void)
>> {
>> 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY);
>> +				       __GFP_NOMEMALLOC | __GFP_NORETRY |
>> +				       __GFP_NOWARN);
>> +
>> +	if (!page)
>> +		pr_warn_ratelimited("memory balloon: memory allocation failed");
>> +
>> 	return page;
>> }
>> EXPORT_SYMBOL_GPL(balloon_page_alloc);
> 
> Not sure if "memory balloon" is the right wording. hmmm.
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Do you have a better suggestion?
