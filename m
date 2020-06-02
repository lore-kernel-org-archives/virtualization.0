From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 00/15] virtio-mem: paravirtualized memory
Date: Tue, 2 Jun 2020 09:09:28 +0200
Message-ID: <8e130bb2-e4bc-bbfc-a635-b44957f069ed@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <virtio-dev-return-7437-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
Content-Language: en-US
To: linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pankaj Gupta <pankaj.gupta.l>
List-Id: virtualization@lists.linuxfoundation.org

On 07.05.20 16:01, David Hildenbrand wrote:
> This series is based on v5.7-rc4. The patches are located at:
>     https://github.com/davidhildenbrand/linux.git virtio-mem-v4
> 
> This is basically a resend of v3 [1], now based on v5.7-rc4 and restested.
> One patch was reshuffled and two ACKs I missed to add were added. The
> rebase did not require any modifications to patches.
> 
> Details about virtio-mem can be found in the cover letter of v2 [2]. A
> basic QEMU implementation was posted yesterday [3].
> 
> [1] https://lkml.kernel.org/r/20200507103119.11219-1-david@redhat.com
> [2] https://lkml.kernel.org/r/20200311171422.10484-1-david@redhat.com
> [3] https://lkml.kernel.org/r/20200506094948.76388-1-david@redhat.com
> 
> v3 -> v4:
> - Move "MAINTAINERS: Add myself as virtio-mem maintainer" to #2
> - Add two ACKs from Andrew (in reply to v2)
> -- "mm: Allow to offline unmovable PageOffline() pages via ..."
> -- "mm/memory_hotplug: Introduce offline_and_remove_memory()"
> 
> v2 -> v3:
> - "virtio-mem: Paravirtualized memory hotplug"
> -- Include "linux/slab.h" to fix build issues
> -- Remember the "region_size", helpful for patch #11
> -- Minor simplifaction in virtio_mem_overlaps_range()
> -- Use notifier_from_errno() instead of notifier_to_errno() in notifier
> -- More reliable check for added memory when unloading the driver
> - "virtio-mem: Allow to specify an ACPI PXM as nid"
> -- Also print the nid
> - Added patch #11-#15

@MST ping, v5.7 has been released

-- 
Thanks,

David / dhildenb
