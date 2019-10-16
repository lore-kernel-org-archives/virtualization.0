From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC v3 8/9] mm/memory_hotplug: Introduce
	offline_and_remove_memory()
Date: Wed, 16 Oct 2019 13:47:08 +0200
Message-ID: <20191016114708.GY317@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-9-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190919142228.5483-9-david@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu 19-09-19 16:22:27, David Hildenbrand wrote:
> virtio-mem wants to offline and remove a memory block once it unplugged
> all subblocks (e.g., using alloc_contig_range()). Let's provide
> an interface to do that from a driver. virtio-mem already supports to
> offline partially unplugged memory blocks. Offlining a fully unplugged
> memory block will not require to migrate any pages. All unplugged
> subblocks are PageOffline() and have a reference count of 0 - so
> offlining code will simply skip them.
> 
> All we need an interface to trigger the "offlining" and the removing in a
> single operation - to make sure the memory block cannot get onlined by
> user space again before it gets removed.
> 
> To keep things simple, allow to only work on a single memory block.

Without a user it is not really clear why do we need this interface.
I am also not really sure why do you want/need to control beyond the
offlining stage. Care to explain some more?
-- 
Michal Hocko
SUSE Labs
