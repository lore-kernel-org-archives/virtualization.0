From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Date: Wed, 11 Jul 2018 16:38:05 +0200
Message-ID: <20180711143805.GP20050__39249.1800281734$1531319767$gmane$org@dhcp22.suse.cz>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
	<1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
	<CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
	<5B455D50.90902@intel.com>
	<CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
	<20180711092152.GE20050@dhcp22.suse.cz>
	<5B45E17D.2090205@intel.com>
	<20180711110949.GJ20050@dhcp22.suse.cz>
	<286AC319A985734F985F78AFA26841F7396EEFD8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7396EEFD8@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Rik van Riel <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "nilal@redhat.com" <nilal@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed 11-07-18 13:55:15, Wang, Wei W wrote:
> On Wednesday, July 11, 2018 7:10 PM, Michal Hocko wrote:
> > On Wed 11-07-18 18:52:45, Wei Wang wrote:
> > > On 07/11/2018 05:21 PM, Michal Hocko wrote:
> > > > On Tue 10-07-18 18:44:34, Linus Torvalds wrote:
> > > > [...]
> > > > > That was what I tried to encourage with actually removing the
> > > > > pages form the page list. That would be an _incremental_
> > > > > interface. You can remove MAX_ORDER-1 pages one by one (or a
> > > > > hundred at a time), and mark them free for ballooning that way.
> > > > > And if you still feel you have tons of free memory, just continue
> > removing more pages from the free list.
> > > > We already have an interface for that. alloc_pages(GFP_NOWAIT,
> > MAX_ORDER -1).
> > > > So why do we need any array based interface?
> > >
> > > Yes, I'm trying to get free pages directly via alloc_pages, so there
> > > will be no new mm APIs.
> > 
> > OK. The above was just a rough example. In fact you would need a more
> > complex gfp mask. I assume you only want to balloon only memory directly
> > usable by the kernel so it will be
> > 	(GFP_KERNEL | __GFP_NOWARN) & ~__GFP_RECLAIM
> 
> Sounds good to me, thanks.
> 
> > 
> > > I plan to let free page allocation stop when the remaining system free
> > > memory becomes close to min_free_kbytes (prevent swapping).
> > 
> > ~__GFP_RECLAIM will make sure you are allocate as long as there is any
> > memory without reclaim. It will not even poke the kswapd to do the
> > background work. So I do not think you would need much more than that.
> 
> "close to min_free_kbytes" - I meant when doing the allocations, we
> intentionally reserve some small amount of memory, e.g. 2 free page
> blocks of "MAX_ORDER - 1". So when other applications happen to do
> some allocation, they may easily get some from the reserved memory
> left on the free list. Without that reserved memory, other allocation
> may cause the system free memory below the WMARK[MIN], and kswapd
> would start to do swapping. This is actually just a small optimization
> to reduce the probability of causing swapping (nice to have, but not
> mandatary because we will allocate free page blocks one by one).

I really have hard time to follow you here. Nothing outside of the core
MM proper should play with watermarks.
 
>  > But let me note that I am not really convinced how this (or previous)
> > approach will really work in most workloads. We tend to cache heavily so
> > there is rarely any memory free.
> 
> With less free memory, the improvement becomes less, but should be
> nicer than no optimization. For example, the Linux build workload
> would cause 4~5 GB (out of 8GB) memory to be used as page cache at the
> final stage, there is still ~44% live migration time reduction.

But most systems will stay somewhere around the high watermark if there
is any page cache activity. Especially after a longer uptime.
-- 
Michal Hocko
SUSE Labs
