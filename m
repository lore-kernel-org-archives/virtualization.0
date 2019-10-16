From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v3 4/9] mm: Export alloc_contig_range() /
	free_contig_range()
Date: Wed, 16 Oct 2019 14:31:14 +0200
Message-ID: <ef8b47c6-45ad-1b32-c54d-829b44a12131__4476.08198025904$1571229089$gmane$org@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-5-david@redhat.com>
	<20191016112051.GW317@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191016112051.GW317@dhcp22.suse.cz>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Mel Gorman <mgorman@techsingularity.net>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 16.10.19 13:20, Michal Hocko wrote:
> On Thu 19-09-19 16:22:23, David Hildenbrand wrote:
>> A virtio-mem device wants to allocate memory from the memory region it
>> manages in order to unplug it in the hypervisor - similar to
>> a balloon driver. Also, it might want to plug previously unplugged
>> (allocated) memory and give it back to Linux. alloc_contig_range() /
>> free_contig_range() seem to be the perfect interface for this task.
>>
>> In contrast to existing balloon devices, a virtio-mem device operates
>> on bigger chunks (e.g., 4MB) and only on physical memory it manages. It
>> tracks which chunks (subblocks) are still plugged, so it can go ahead
>> and try to alloc_contig_range()+unplug them on unplug request, or
>> plug+free_contig_range() unplugged chunks on plug requests.
>>
>> A virtio-mem device will use alloc_contig_range() / free_contig_range()
>> only on ranges that belong to the same node/zone in at least
>> MAX(MAX_ORDER - 1, pageblock_order) order granularity - e.g., 4MB on
>> x86-64. The virtio-mem device added that memory, so the memory
>> exists and does not contain any holes. virtio-mem will only try to allocate
>> on ZONE_NORMAL, never on ZONE_MOVABLE, just like when allocating
>> gigantic pages (we don't put unmovable data into the movable zone).
> 
> Is there any real reason to export as GPL rather than generic
> EXPORT_SYMBOL? In other words do we need to restrict the usage this
> interface only to GPL modules and why if so. All other allocator APIs
> are EXPORT_SYMBOL so there should better be a good reason for this one
> to differ. I can understand that this one is slightly different by
> requesting a specific range of the memory but it is still under a full
> control of the core MM to say no.

I thought that we might - at least initially - might want to know all 
users. If you prefer, I can drop the GPL.

> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Other than that, I do not think exporting this function is harmful. It
> would be worse to reinvent it and do it wrong.
> 
> I usually prefer to add a caller in the same patch, though, because it
> makes the usage explicit and clear.
> 

It's the next patch in this series (I prefer to split this from the 
actual driver):

https://lkml.org/lkml/2019/9/19/486

> Acked-by: Michal Hocko <mhocko@suse.com> # to export contig range allocator API

Thanks!

-- 

Thanks,

David / dhildenb
