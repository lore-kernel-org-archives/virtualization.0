From: David Hildenbrand <david@redhat.com>
Subject: Re: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 11:42:04 +0100
Message-ID: <193b0215-fda3-6867-e7dc-39c2d43f1007@redhat.com>
References: <286AC319A985734F985F78AFA26841F73E41F306@shsmsx102.ccr.corp.intel.com>
 <2b388a78-79cd-f99a-6f87-6446dcb4b819@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F367@shsmsx102.ccr.corp.intel.com>
 <605bef3e-373f-f39a-4849-930326564b5b@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F3DE@shsmsx102.ccr.corp.intel.com>
 <bcb69e37-fd84-6397-0ff5-befd99a361dd@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F490@shsmsx102.ccr.corp.intel.com>
 <5b184893-014c-35a1-928b-37b8f4647116@redhat.com>
 <286AC319A985734F985F78AFA26841F73E41F562@shsmsx102.ccr.corp.intel.com>
 <ef1dfd46-49c8-8aa9-2a5e-d2ebb2e093f5@redhat.com>
 <20200205051404-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200205051404-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tyler Sanderson <tysand@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 05.02.20 11:25, Michael S. Tsirkin wrote:
> On Wed, Feb 05, 2020 at 10:58:14AM +0100, David Hildenbrand wrote:
>> On 05.02.20 10:49, Wang, Wei W wrote:
>>> On Wednesday, February 5, 2020 5:37 PM, David Hildenbrand wrote:
>>>>>
>>>>> Not sure how TCG tracks the dirty bits. But In whatever
>>>>> implementation, the hypervisor should have
>>>>
>>>> There is only a single bitmap for that purpose. (well, the one where KVM
>>>> syncs to)
>>>>
>>>>> already dealt with the race between he current round and the previous
>>>> round dirty recording.
>>>>> (the race isn't brought by this feature essentially)
>>>>
>>>> It is guaranteed to work reliably without this feature as you only clear what
>>>> *has been migrated*, 
>>>
>>> Not "clear what has been migrated" (that skips nothing..)
>>> Anyway, it's a hint used for optimization.
>>
>> Yes, an optimization that might easily lead to data corruption when the
>> two bitmaps are either not in place or don't play along in that specific
>> way (and I suspect this is the case under TCG).
> 
> So I checked and TCG has two copies too.
> Each block has bmap used for migration and also dirty_memory
> where pages are marked dirty. See cpu_physical_memory_sync_dirty_bitmap.
qemu_guest_free_page_hint() works on block->bmap.
cpu_physical_memory_set_dirty_range() works on ram_list.dirty_memory[i].

So you are right - sorry for the false alarm and thanks for verifying :)

[...]

> 
> Again a flag that tells guest it should wait until used
> could be a reasonable expension. If we stick to the shrinker
> it's actually implementable easily. With an OOM notifier - I'm not so
> sure ...

See my other mail. I think we should keep handling just as is and not
overcomplicate things (especially in our implementation as you noted)
Instead, maybe abstract the reporting feature.

> 
> And a big part of the problem is that after all this time the page
> hinting interfaces are still undocumented. Quite sad really :(

Yes, that was the source of my confusion ... the double-bitmap thingy is
non-obvious. And anybody who wants to implement that interface in a
hypervisor has to be aware that the race I explained has to be avoided
using e.g., two bitmaps and the sync.

-- 
Thanks,

David / dhildenb
