From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
	a reference count of 0
Date: Wed, 16 Oct 2019 16:16:09 +0200
Message-ID: <f2ca2396-8aae-842c-91f5-84c3e0fae70e__21366.3932796166$1571235422$gmane$org@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-7-david@redhat.com>
	<20191016114321.GX317@dhcp22.suse.cz>
	<bd38d88d-19a7-275a-386d-f37cb76a3390@redhat.com>
	<20191016134519.GC317@dhcp22.suse.cz>
	<2aef8477-7d12-63a8-e273-9eae8712d5c2@redhat.com>
	<20191016140958.GE317@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191016140958.GE317@dhcp22.suse.cz>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: Pingfan Liu <kernelfans@gmail.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Anthony Yznaga <anthony.yznaga@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>, Yang Shi <yang.shi@linux.alibaba.c>
List-Id: virtualization@lists.linuxfoundation.org

On 16.10.19 16:09, Michal Hocko wrote:
> On Wed 16-10-19 15:55:00, David Hildenbrand wrote:
>> On 16.10.19 15:45, Michal Hocko wrote:
> [...]
>>> There is state stored in the struct page. In other words this shouldn't
>>> be really different from HWPoison pages. I cannot find the code that is
>>> doing that and maybe we don't handle that. But we cannot simply online
>>> hwpoisoned page. Offlining the range will not make a broken memory OK
>>> all of the sudden. And your usecase sounds similar to me.
>>
>> Sorry to say, but whenever we online memory the memmap is overwritten,
>> because there is no way you could tell it contains garbage or not. You have
>> to assume it is garbage. (my recent patch even poisons the memmap when
>> offlining, which helped to find a lot of these "garbage memmap" BUGs)
>>
>> online_pages()
>> 	...
>> 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL);
>> 	...
>> 		memmap_init_zone()
>> 			-> memmap initialized
>>
>> So yes, offlining memory with HWPoison and re-onlining it effectively drops
>> HWPoison markers. On the next access, you will trigger a new HWPoison.
> 
> Right you are! I need to sit on this much more and think about it with a
> clean head.
> 

Sure, take your time and let me know if you need any details on how 
virtio-mem works, how it uses these interfaces, and how the mm internals 
it uses play along.

Thanks Michal!

-- 

Thanks,

David / dhildenb
