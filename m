From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 7/7] mm: add vm event counters for balloon pages
	compaction
Date: Tue, 20 Nov 2012 15:29:46 -0800
Message-ID: <20121120152946.823cd2d9.akpm@linux-foundation.org>
References: <cover.1352256081.git.aquini@redhat.com>
	<8dde7996f3e36a5efbe569afe1aadfc84355e79e.1352256088.git.aquini@redhat.com>
	<20121109122033.GR3886@csn.ul.ie>
	<20121109145829.GC4308@optiplex.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121109145829.GC4308@optiplex.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 9 Nov 2012 12:58:29 -0200
Rafael Aquini <aquini@redhat.com> wrote:

> On Fri, Nov 09, 2012 at 12:20:33PM +0000, Mel Gorman wrote:
> > On Wed, Nov 07, 2012 at 01:05:54AM -0200, Rafael Aquini wrote:
> > > This patch introduces a new set of vm event counters to keep track of
> > > ballooned pages compaction activity.
> > > 
> > > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > 
> > Other than confirming the thing actually works can any meaningful
> > conclusions be drawn from this counters?
> > 
> > I know I have been inconsistent on this myself in the past but recently
> > I've been taking the attitude that the counters can be used to fit into
> > some other metric. I'm looking to change the compaction counters to be
> > able to build a basic cost model for example. The same idea could be
> > used for balloons of course but it's a less critical path than
> > compaction for THP for example.
> > 
> > Assuming it builds and all the defines are correct when the feature is
> > not configured (I didn't check) then there is nothing wrong with the
> > patch. However, if it was dropped would it make life very hard or would
> > you notice?
> > 
> 
> Originally, I proposed this patch as droppable (and it's still droppable)
> because its major purpose was solely to show the thing working consistently
> 
> OTOH, it might make the life easier to spot breakages if it remains with the
> merged bits, and per a reviewer request I removed its 'DROP BEFORE MERGE'
> disclaimer.
> 
>    https://lkml.org/lkml/2012/8/8/616

There's a lot to be said for not merging things.

I think I'll maintain this as a mm-only patch.  That way it's
available in linux-next and we can merge it later if a need arises.
