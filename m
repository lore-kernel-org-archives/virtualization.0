From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 07/10] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Date: Wed, 11 Mar 2020 18:19:04 +0100
Message-ID: <156601a9-e919-b88f-2278-97ecee554d21@redhat.com>
References: <20200311171422.10484-1-david@redhat.com>
 <20200311171422.10484-8-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200311171422.10484-8-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-Id: virtualization@lists.linuxfoundation.org

On 11.03.20 18:14, David Hildenbrand wrote:
> virtio-mem wants to offline and remove a memory block once it unplugged
> all subblocks (e.g., using alloc_contig_range()). Let's provide
> an interface to do that from a driver. virtio-mem already supports to
> offline partially unplugged memory blocks. Offlining a fully unplugged
> memory block will not require to migrate any pages. All unplugged
> subblocks are PageOffline() and have a reference count of 0 - so
> offlining code will simply skip them.
> 
> All we need is an interface to offline and remove the memory from kernel
> module context, where we don't have access to the memory block devices
> (esp. find_memory_block() and device_offline()) and the device hotplug
> lock.
> 
> To keep things simple, allow to only work on a single memory block.
> 

Lost the ACK from Michael

Acked-by: Michal Hocko <mhocko@suse.com> [1]

[1] https://lkml.kernel.org/r/20200302142737.GP4380@dhcp22.suse.cz

-- 
Thanks,

David / dhildenb
