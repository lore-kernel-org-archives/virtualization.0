From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v3 6/9] mm: Allow to offline PageOffline() pages with
	a reference count of 0
Date: Thu, 24 Oct 2019 10:51:28 +0200
Message-ID: <ba7164c9-b98e-0ce1-358e-8b0d45fe3f48@redhat.com>
References: <20191016140350.GD317@dhcp22.suse.cz>
	<7c7bef01-f904-904a-b0a7-f7b514b8bda8@redhat.com>
	<20191018081524.GD5017@dhcp22.suse.cz>
	<83d0a961-952d-21e4-74df-267912b7b6fa@redhat.com>
	<20191018111843.GH5017@dhcp22.suse.cz>
	<709d39aa-a7ba-97aa-e66b-e2fec2fdf3c4@redhat.com>
	<20191022122326.GL9379@dhcp22.suse.cz>
	<b4be42a4-cbfc-8706-cc94-26211ddcbe4a@redhat.com>
	<20191023094345.GL754@dhcp22.suse.cz>
	<ad2aef12-61ac-f019-90d1-59637255f9e3@redhat.com>
	<20191024084241.GV17610@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191024084241.GV17610@dhcp22.suse.cz>
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

On 24.10.19 10:42, Michal Hocko wrote:
> On Wed 23-10-19 12:03:51, David Hildenbrand wrote:
>>> Do you see any downsides?
>>
>> The only downside I see is that we get more false negatives on
>> has_unmovable_pages(), eventually resulting in the offlining stage after
>> isolation to loop forever (as some PageOffline() pages are not movable
>> (especially, XEN balloon, HyperV balloon), there won't be progress).
>>
>> I somewhat don't like forcing everybody that uses PageOffline() (especially
>> all users of balloon compaction) to implement memory notifiers just to avoid
>> that. Maybe, we even want to use PageOffline() in the future in the core
>> (e.g., for memory holes instead of PG_reserved or similar).
> 
> There is only a handful of those and we need to deal with them anyway.
> If you do not want to enforce them to create their own notifiers then we
> can accomodate the hotplug code. __test_page_isolated_in_pageblock resp.

Yeah, I would prefer offlining code to be able to deal with that without 
notifier changes for all users.

> the call chain up can distinguish temporary and permanent failures
> (EAGAIN vs. EBUSY). The current state when we always return EBUSY and
> keep retrying for ever is not optimal at all, right? A referenced PageOffline

Very right!

> could be an example of EBUSY all other failures where we are effectively
> waiting for pages to get freed finaly would be EAGAIN.

We have to watch out for PageOffline() pages that are actually movable 
(balloon compaction). But that doesn't sound too hard.
> 
> It is a bit late in the process because a large portion of the work has
> been done already but this doesn't sound like something to lose sleep
> over.
> 

Right. I'll look into that to find out if this would work. And see if I 
can reproduce what I described at all (theoretical thoughts) :)

Again, thanks for looking into this Michal!

-- 

Thanks,

David / dhildenb
