From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 26 Jun 2012 21:15:13 +0100
Message-ID: <20120626201513.GJ8103__43387.3241454878$1340741731$gmane$org@csn.ul.ie>
References: <cover.1340665087.git.aquini@redhat.com>
	<7f83427b3894af7969c67acc0f27ab5aa68b4279.1340665087.git.aquini@redhat.com>
	<20120626101729.GF8103@csn.ul.ie>
	<20120626165258.GY11413@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120626165258.GY11413@one.firstfloor.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2012 at 06:52:58PM +0200, Andi Kleen wrote:
> > 
> > What shocked me actually is that VM_BUG_ON code is executed on
> > !CONFIG_DEBUG_VM builds and has been since 2.6.36 due to commit [4e60c86bd:
> > gcc-4.6: mm: fix unused but set warnings]. I thought the whole point of
> > VM_BUG_ON was to avoid expensive and usually unnecessary checks. Andi,
> > was this deliberate?
> 
> The idea was that the compiler optimizes it away anyways.
> 
> I'm not fully sure what putback_balloon_page does, but if it just tests
> a bit (without non variable test_bit) it should be ok.
> 

This was the definition before

#ifdef CONFIG_DEBUG_VM
#define VM_BUG_ON(cond) BUG_ON(cond)
#else
#define VM_BUG_ON(cond) do { } while (0)
#endif

and now it's

#ifdef CONFIG_DEBUG_VM
#define VM_BUG_ON(cond) BUG_ON(cond)
#else
#define VM_BUG_ON(cond) do { (void)(cond); } while (0)
#endif

How is the compiler meant to optimise away "cond" if it's a function
call?

In the old definition VM_BUG_ON did nothing and the intention was that the
"cond" should never had any side-effects. It was to be used for potentially
expensive tests to catch additional issues in DEBUG_VM kernels. My concern
is that after commit 4e60c86bd that the VM doing these additional checks
unnecesarily with a performance hit. In most cases the checks are small
but in others such as free_pages we are calling virt_addr_valid() which
is heavier.

What did I miss? If nothing, then I will revert this particular change
and Rafael will need to be sure his patch is not using VM_BUG_ON to call
a function with side-effects.

-- 
Mel Gorman
SUSE Labs
