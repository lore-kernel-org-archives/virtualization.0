From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
Date: Fri, 29 Jun 2018 09:46:09 +0200
Message-ID: <4840cbb7-dd3f-7540-6a7c-13427de2f0d1@redhat.com>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
	<c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
	<5B35ACD5.4090800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5B35ACD5.4090800@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: yang.zhang.wz@gmail.com, Andrea Arcangeli <aarcange@redhat.com>, riel@redhat.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, Luiz Capitulino <lcapitulino@redhat.com>, pbonzini@redhat.com, nilal@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 29.06.2018 05:51, Wei Wang wrote:
> On 06/27/2018 07:06 PM, David Hildenbrand wrote:
>> On 25.06.2018 14:05, Wei Wang wrote:
>>> This patch series is separated from the previous "Virtio-balloon
>>> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>>> implemented by this series enables the virtio-balloon driver to report
>>> hints of guest free pages to the host. It can be used to accelerate live
>>> migration of VMs. Here is an introduction of this usage:
>>>
>>> Live migration needs to transfer the VM's memory from the source machine
>>> to the destination round by round. For the 1st round, all the VM's memory
>>> is transferred. From the 2nd round, only the pieces of memory that were
>>> written by the guest (after the 1st round) are transferred. One method
>>> that is popularly used by the hypervisor to track which part of memory is
>>> written is to write-protect all the guest memory.
>>>
>>> This feature enables the optimization by skipping the transfer of guest
>>> free pages during VM live migration. It is not concerned that the memory
>>> pages are used after they are given to the hypervisor as a hint of the
>>> free pages, because they will be tracked by the hypervisor and transferred
>>> in the subsequent round if they are used and written.
>>>
>>> * Tests
>>> - Test Environment
>>>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>>>      Guest: 8G RAM, 4 vCPU
>>>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
>>>
>>> - Test Results
>>>      - Idle Guest Live Migration Time (results are averaged over 10 runs):
>>>          - Optimization v.s. Legacy = 284ms vs 1757ms --> ~84% reduction
>>>      - Guest with Linux Compilation Workload (make bzImage -j4):
>>>          - Live Migration Time (average)
>>>            Optimization v.s. Legacy = 1402ms v.s. 2528ms --> ~44% reduction
>>>          - Linux Compilation Time
>>>            Optimization v.s. Legacy = 5min6s v.s. 5min12s
>>>            --> no obvious difference
>>>
>> Being in version 34 already, this whole thing still looks and feels like
>> a big hack to me. It might just be me, but especially if I read about
>> assumptions like "QEMU will not hotplug memory during migration". This
>> does not feel like a clean solution.
>>
>> I am still not sure if we really need this interface, especially as real
>> free page hinting might be on its way.
>>
>> a) we perform free page hinting by setting all free pages
>> (arch_free_page()) to zero. Migration will detect zero pages and
>> minimize #pages to migrate. I don't think this is a good idea but Michel
>> suggested to do a performance evaluation and Nitesh is looking into that
>> right now.
> 
> The hypervisor doesn't get the zero pages for free. It pays lots of CPU 
> utilization and memory bandwidth (there are some guys complaining abut 
> this on the QEMU mailinglist)
> In the above results, the legacy part already has the zero page feature 
> in use.

Indeed, I don't consider this attempt not very practical in general,
especially as it would rely on KSM right now, which is frowned upon by
many people.

> 
>>
>> b) we perform free page hinting using something that Nitesh proposed. We
>> get in QEMU blocks of free pages that we can MADV_FREE. In addition we
>> could e.g. clear the dirty bit of these pages in the dirty bitmap, to
>> hinder them from getting migrated. Right now the hinting mechanism is
>> synchronous (called from arch_free_page()) but we might be able to
>> convert it into something asynchronous.
>>
>> So we might be able to completely get rid of this interface. And looking
>> at all the discussions and problems that already happened during the
>> development of this series, I think we should rather look into how clean
>> free page hinting might solve the same problem.
>>
>> If it can't be solved using free page hinting, fair enough.
>>
> 
> I'm afraid it can't. For example, when we have a guest booted, without 
> too many memory activities. Assume the guest has 8GB free memory. The 
> arch_free_page there won't be able to capture the 8GB free pages since 
> there is no free() called. This results in no free pages reported to host.


So, it takes some time from when the guest boots up until the balloon
device was initialized and therefore page hinting can start. For that
period, you won't get any arch_free_page()/page hinting callbacks, correct.

However in the hypervisor, you can theoretically track which pages the
guest actually touched ("dirty"), so you already know "which pages were
never touched while booting up until virtio-balloon was brought to
life". These, you can directly exclude from migration. No interface
required.

The remaining problem is pages that were touched ("allocated") by the
guest during bootup but freed again, before virtio-balloon came up. One
would have to measure how many pages these usually are, I would say it
would not be that many (because recently freed pages are likely to be
used again next for allocation). However, there are some pages not being
reported.

During the lifetime of the guest, this should not be a problem,
eventually one of these pages would get allocated/freed again, so the
problem "solves itself over time". You are looking into the special case
of migrating the VM just after it has been started. But we have the
exact same problem also for ordinary free page hinting, so we should
rather solve that problem. It is not migration specific.

If we are looking for an alternative to "problem solves itself",
something like "if virtio-balloon comes up, it will report all free
pages step by step using free page hinting, just like we would have from
"arch_free_pages()"". This would be the same interface we are using for
free page hinting - and it could even be made configurable in the guest.

The current approach we are discussing internally for details about
Nitesh's work ("how the magic inside arch_fee_pages() will work
efficiently) would allow this as far as I can see just fine.

There would be a tiny little window between virtio-balloon comes up and
it has reported all free pages step by step, but that can be considered
a very special corner case that I would argue is not worth it to be
optimized.

If I am missing something important here, sorry in advance :)

> 
> Best,
> Wei
> 


-- 

Thanks,

David / dhildenb
