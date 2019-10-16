From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v3 8/9] mm/memory_hotplug: Introduce
	offline_and_remove_memory()
Date: Wed, 16 Oct 2019 14:57:03 +0200
Message-ID: <0568676b-4a22-cd95-1de8-a43022aa6a9f@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-9-david@redhat.com>
	<20191016114708.GY317@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191016114708.GY317@dhcp22.suse.cz>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 16.10.19 13:47, Michal Hocko wrote:
> On Thu 19-09-19 16:22:27, David Hildenbrand wrote:
>> virtio-mem wants to offline and remove a memory block once it unplugged
>> all subblocks (e.g., using alloc_contig_range()). Let's provide
>> an interface to do that from a driver. virtio-mem already supports to
>> offline partially unplugged memory blocks. Offlining a fully unplugged
>> memory block will not require to migrate any pages. All unplugged
>> subblocks are PageOffline() and have a reference count of 0 - so
>> offlining code will simply skip them.
>>
>> All we need an interface to trigger the "offlining" and the removing in a
>> single operation - to make sure the memory block cannot get onlined by
>> user space again before it gets removed.
>>
>> To keep things simple, allow to only work on a single memory block.
> 
> Without a user it is not really clear why do we need this interface.
> I am also not really sure why do you want/need to control beyond the
> offlining stage. Care to explain some more?
> 

The user is the next (small) patch in this series:

https://lkml.org/lkml/2019/9/19/475

Let's assume virtio-mem added a memory block and that block was onlined 
(e.g. by user space). E.g. 128MB.

On request, virtio-mem used alloc_contig_range() to logically unplug all 
chunks (e.g., 4MB) of that memory block. virtio-mem marked all pages 
PG_offline and dropped the reference count to 0 (to allow the memory 
block to get offlined). Basically no memory of the memory block is still 
in use by the system. So it is very desirable to remove that memory 
block along with the vmemmap and the page tables. This frees up memory.

In order to remove the memory block, it first has to be officially 
offlined (e.g., make the memory block as offline). Then, the memory 
block can get cleanly removed. Otherwise, try_remove_memory() will fail.

To do this, virtio-mem needs an interface to perform both steps (offline 
+ remove).

There is no interface for a driver to offline a memory block. What I 
propose here performs both steps (offline+remove) in a single step, as 
that is really what the driver wants.

-- 

Thanks,

David / dhildenb
