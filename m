From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 07/15] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Date: Thu, 7 May 2020 07:33:51 -0400
Message-ID: <20200507073302-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-8-david@redhat.com>
 <20200507064558-mutt-send-email-mst@kernel.org>
 <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 07, 2020 at 01:24:38PM +0200, David Hildenbrand wrote:
> On 07.05.20 12:46, Michael S. Tsirkin wrote:
> > On Thu, May 07, 2020 at 12:31:11PM +0200, David Hildenbrand wrote:
> >> virtio-mem wants to offline and remove a memory block once it unplugged
> >> all subblocks (e.g., using alloc_contig_range()). Let's provide
> >> an interface to do that from a driver. virtio-mem already supports to
> >> offline partially unplugged memory blocks. Offlining a fully unplugged
> >> memory block will not require to migrate any pages. All unplugged
> >> subblocks are PageOffline() and have a reference count of 0 - so
> >> offlining code will simply skip them.
> >>
> >> All we need is an interface to offline and remove the memory from kernel
> >> module context, where we don't have access to the memory block devices
> >> (esp. find_memory_block() and device_offline()) and the device hotplug
> >> lock.
> >>
> >> To keep things simple, allow to only work on a single memory block.
> >>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> Tested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Oscar Salvador <osalvador@suse.com>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> >> Cc: Wei Yang <richard.weiyang@gmail.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Qian Cai <cai@lca.pw>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > 
> > didn't you lose Andrew Morton's ack here?
> 
> Yeah, thanks for noticing.
> 
> > 
> >> ---
> >>  include/linux/memory_hotplug.h |  1 +
> >>  mm/memory_hotplug.c            | 37 ++++++++++++++++++++++++++++++++++
> >>  2 files changed, 38 insertions(+)
> > 
> > I get:
> > 
> > error: sha1 information is lacking or useless (mm/memory_hotplug.c).
> > error: could not build fake ancestor
> > 
> > which version is this against? Pls post patches on top of some tag
> > in Linus' tree if possible.
> 
> As the cover states, latest linux-next. To be precise
> 
> commit 6b43f715b6379433e8eb30aa9bcc99bd6a585f77 (tag: next-20200507,
> next/master)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Thu May 7 18:11:31 2020 +1000
> 
>     Add linux-next specific files for 20200507
> 

Don't base on linux-next please. Generally base on the tree you are
targeting, or Linus' tree.


> -- 
> Thanks,
> 
> David / dhildenb
