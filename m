From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/10] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Date: Tue, 14 Apr 2020 17:30:46 -0700
Message-ID: <20200414173046.dc097faf7062f76a8c68f580@linux-foundation.org>
References: <20200311171422.10484-1-david@redhat.com>
        <20200311171422.10484-8-david@redhat.com>
        <156601a9-e919-b88f-2278-97ecee554d21@redhat.com>
        <20200414123438-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200414123438-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Apr 2020 12:35:02 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 11, 2020 at 06:19:04PM +0100, David Hildenbrand wrote:
> > On 11.03.20 18:14, David Hildenbrand wrote:
> > > virtio-mem wants to offline and remove a memory block once it unplugged
> > > all subblocks (e.g., using alloc_contig_range()). Let's provide
> > > an interface to do that from a driver. virtio-mem already supports to
> > > offline partially unplugged memory blocks. Offlining a fully unplugged
> > > memory block will not require to migrate any pages. All unplugged
> > > subblocks are PageOffline() and have a reference count of 0 - so
> > > offlining code will simply skip them.
> > > 
> > > All we need is an interface to offline and remove the memory from kernel
> > > module context, where we don't have access to the memory block devices
> > > (esp. find_memory_block() and device_offline()) and the device hotplug
> > > lock.
> > > 
> > > To keep things simple, allow to only work on a single memory block.
> > > 
> > 
> > Lost the ACK from Michael
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com> [1]
> > 
> > [1] https://lkml.kernel.org/r/20200302142737.GP4380@dhcp22.suse.cz
> 
> 
> Andrew, could you pls ack merging this through the vhost tree,
> with the rest of the patchset?

I wish the device_offline() return value was documented :(

Yes, please go ahead and merge.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
