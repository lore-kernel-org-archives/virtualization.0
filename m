From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Fri, 15 Dec 2017 21:05:36 -0800
Message-ID: <20171216050536.GA18920__47447.9895471179$1513400817$gmane$org@bombadil.infradead.org>
References: <5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215202238-mutt-send-email-mst@kernel.org>
	<201712161331.ABI26579.OtOMFSOLHVFFQJ@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201712161331.ABI26579.OtOMFSOLHVFFQJ@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Dec 16, 2017 at 01:31:24PM +0900, Tetsuo Handa wrote:
> Michael S. Tsirkin wrote:
> > On Sat, Dec 16, 2017 at 01:21:52AM +0900, Tetsuo Handa wrote:
> > > My understanding is that virtio-balloon wants to handle sparsely spreaded
> > > unsigned long values (which is PATCH 4/7) and wants to find all chunks of
> > > consecutive "1" bits efficiently. Therefore, I guess that holding the values
> > > in ascending order at store time is faster than sorting the values at read
> > > time.

What makes you think that the radix tree (also xbitmap, also idr) doesn't
sort the values at store time?

> I'm asking whether we really need to invent a new library module (i.e.
> PATCH 1/7 + PATCH 2/7 + PATCH 3/7) for virtio-balloon compared to mine.
> 
> What virtio-balloon needs is ability to
> 
>   (1) record any integer value in [0, ULONG_MAX] range
> 
>   (2) fetch all recorded values, with consecutive values combined in
>       min,max (or start,count) form for efficiently
> 
> and I wonder whether we need to invent complete API set which
> Matthew Wilcox and Wei Wang are planning for generic purpose.

The xbitmap absolutely has that ability.  And making it generic code
means more people see it, use it, debug it, optimise it.  I originally
wrote the implementation for bcache, when Kent was complaining we didn't
have such a thing.  His needs weren't as complex as Wei's, which is why
I hadn't implemented everything that Wei needed.
