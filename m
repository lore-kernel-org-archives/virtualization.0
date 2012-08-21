From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Tue, 21 Aug 2012 14:42:52 -0300
Message-ID: <20120821174251.GB12294__29160.8703708791$1345573358$gmane$org@t510.redhat.com>
References: <cover.1345519422.git.aquini@redhat.com>
	<e24f3073ef539985dea52943dcb84762213a0857.1345519422.git.aquini@redhat.com>
	<20120821135223.GA7117@redhat.com>
	<1345562166.23018.109.camel@twins>
	<20120821154142.GA8268@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120821154142.GA8268@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2012 at 06:41:42PM +0300, Michael S. Tsirkin wrote:
> On Tue, Aug 21, 2012 at 05:16:06PM +0200, Peter Zijlstra wrote:
> > On Tue, 2012-08-21 at 16:52 +0300, Michael S. Tsirkin wrote:
> > > > +             rcu_read_lock();
> > > > +             mapping = rcu_dereference(page->mapping);
> > > > +             if (mapping_balloon(mapping))
> > > > +                     ret = true;
> > > > +             rcu_read_unlock();
> > > 
> > > This looks suspicious: you drop rcu_read_unlock
> > > so can't page switch from balloon to non balloon? 
> > 
> > RCU read lock is a non-exclusive lock, it cannot avoid anything like
> > that.
> 
> You are right, of course. So even keeping rcu_read_lock across both test
> and operation won't be enough - you need to make this function return
> the mapping and pass it to isolate_page/putback_page so that it is only
> dereferenced once.
>
No, I need to dereference page->mapping to check ->mapping flags here, before
returning. Remember this function is used at MM's compaction/migration inner
circles to identify ballooned pages and decide what's the next step. This
function is doing the right thing, IMHO.

Also, looking at how compaction/migration work, we verify the only critical path
for this function is the page isolation step. The other steps (migration and
putback) perform their work on private lists previouly isolated from a given
source.

So, we just need to make sure that the isolation part does not screw things up
by isolating pages that balloon driver is about to release. That's why there are
so many checkpoints down the page isolation path assuring we really are
isolating a balloon page. 
