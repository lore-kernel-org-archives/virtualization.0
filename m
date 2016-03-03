From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC qemu 0/4] A PV solution for live migration optimization
Date: Thu, 3 Mar 2016 17:46:15 +0000
Message-ID: <20160303174615.GF2115__13372.4572755911$1457030086$gmane$org@work-vm>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

* Liang Li (liang.z.li@intel.com) wrote:
> The current QEMU live migration implementation mark the all the
> guest's RAM pages as dirtied in the ram bulk stage, all these pages
> will be processed and that takes quit a lot of CPU cycles.
> 
> From guest's point of view, it doesn't care about the content in free
> pages. We can make use of this fact and skip processing the free
> pages in the ram bulk stage, it can save a lot CPU cycles and reduce
> the network traffic significantly while speed up the live migration
> process obviously.
> 
> This patch set is the QEMU side implementation.
> 
> The virtio-balloon is extended so that QEMU can get the free pages
> information from the guest through virtio.
> 
> After getting the free pages information (a bitmap), QEMU can use it
> to filter out the guest's free pages in the ram bulk stage. This make
> the live migration process much more efficient.

Hi,
  An interesting solution; I know a few different people have been looking
at how to speed up ballooned VM migration.

  I wonder if it would be possible to avoid the kernel changes by
parsing /proc/self/pagemap - if that can be used to detect unmapped/zero
mapped pages in the guest ram, would it achieve the same result?

> This RFC version doesn't take the post-copy and RDMA into
> consideration, maybe both of them can benefit from this PV solution
> by with some extra modifications.

For postcopy to be safe, you would still need to send a message to the
destination telling it that there were zero pages, otherwise the destination
can't tell if it's supposed to request the page from the source or
treat the page as zero.

Dave

> 
> Performance data
> ================
> 
> Test environment:
> 
> CPU: Intel (R) Xeon(R) CPU ES-2699 v3 @ 2.30GHz
> Host RAM: 64GB
> Host Linux Kernel:  4.2.0           Host OS: CentOS 7.1
> Guest Linux Kernel:  4.5.rc6        Guest OS: CentOS 6.6
> Network:  X540-AT2 with 10 Gigabit connection
> Guest RAM: 8GB
> 
> Case 1: Idle guest just boots:
> ============================================
>                     | original  |    pv    
> -------------------------------------------
> total time(ms)      |    1894   |   421
> --------------------------------------------
> transferred ram(KB) |   398017  |  353242
> ============================================
> 
> 
> Case 2: The guest has ever run some memory consuming workload, the
> workload is terminated just before live migration.
> ============================================
>                     | original  |    pv    
> -------------------------------------------
> total time(ms)      |   7436    |   552
> --------------------------------------------
> transferred ram(KB) |  8146291  |  361375
> ============================================
> 
> Liang Li (4):
>   pc: Add code to get the lowmem form PCMachineState
>   virtio-balloon: Add a new feature to balloon device
>   migration: not set migration bitmap in setup stage
>   migration: filter out guest's free pages in ram bulk stage
> 
>  balloon.c                                       | 30 ++++++++-
>  hw/i386/pc.c                                    |  5 ++
>  hw/i386/pc_piix.c                               |  1 +
>  hw/i386/pc_q35.c                                |  1 +
>  hw/virtio/virtio-balloon.c                      | 81 ++++++++++++++++++++++++-
>  include/hw/i386/pc.h                            |  3 +-
>  include/hw/virtio/virtio-balloon.h              | 17 +++++-
>  include/standard-headers/linux/virtio_balloon.h |  1 +
>  include/sysemu/balloon.h                        | 10 ++-
>  migration/ram.c                                 | 64 +++++++++++++++----
>  10 files changed, 195 insertions(+), 18 deletions(-)
> 
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
