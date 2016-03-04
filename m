From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RFC qemu 0/4] A PV solution for live migration optimization
Date: Fri, 4 Mar 2016 01:52:53 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E03770E33@SHSMSX101.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<20160303174615.GF2115@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160303174615.GF2115@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [RFC qemu 0/4] A PV solution for live migration optimization
> 
> * Liang Li (liang.z.li@intel.com) wrote:
> > The current QEMU live migration implementation mark the all the
> > guest's RAM pages as dirtied in the ram bulk stage, all these pages
> > will be processed and that takes quit a lot of CPU cycles.
> >
> > From guest's point of view, it doesn't care about the content in free
> > pages. We can make use of this fact and skip processing the free pages
> > in the ram bulk stage, it can save a lot CPU cycles and reduce the
> > network traffic significantly while speed up the live migration
> > process obviously.
> >
> > This patch set is the QEMU side implementation.
> >
> > The virtio-balloon is extended so that QEMU can get the free pages
> > information from the guest through virtio.
> >
> > After getting the free pages information (a bitmap), QEMU can use it
> > to filter out the guest's free pages in the ram bulk stage. This make
> > the live migration process much more efficient.
> 
> Hi,
>   An interesting solution; I know a few different people have been looking at
> how to speed up ballooned VM migration.
> 

Ooh, different solutions for the same purpose, and both based on the balloon.

>   I wonder if it would be possible to avoid the kernel changes by parsing
> /proc/self/pagemap - if that can be used to detect unmapped/zero mapped
> pages in the guest ram, would it achieve the same result?
> 

Only detect the unmapped/zero mapped pages is not enough. Consider the 
situation like case 2, it can't achieve the same result.

> > This RFC version doesn't take the post-copy and RDMA into
> > consideration, maybe both of them can benefit from this PV solution by
> > with some extra modifications.
> 
> For postcopy to be safe, you would still need to send a message to the
> destination telling it that there were zero pages, otherwise the destination
> can't tell if it's supposed to request the page from the source or treat the
> page as zero.
> 
> Dave

I will consider this later, thanks, Dave.

Liang

> 
> >
> > Performance data
> > ================
> >
> > Test environment:
> >
> > CPU: Intel (R) Xeon(R) CPU ES-2699 v3 @ 2.30GHz Host RAM: 64GB
> > Host Linux Kernel:  4.2.0           Host OS: CentOS 7.1
> > Guest Linux Kernel:  4.5.rc6        Guest OS: CentOS 6.6
> > Network:  X540-AT2 with 10 Gigabit connection Guest RAM: 8GB
> >
> > Case 1: Idle guest just boots:
> > ============================================
> >                     | original  |    pv
> > -------------------------------------------
> > total time(ms)      |    1894   |   421
> > --------------------------------------------
> > transferred ram(KB) |   398017  |  353242
> > ============================================
> >
> >
> > Case 2: The guest has ever run some memory consuming workload, the
> > workload is terminated just before live migration.
> > ============================================
> >                     | original  |    pv
> > -------------------------------------------
> > total time(ms)      |   7436    |   552
> > --------------------------------------------
> > transferred ram(KB) |  8146291  |  361375
> > ============================================
> >
