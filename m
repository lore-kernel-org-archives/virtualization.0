From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Tue, 28 Aug 2012 18:23:12 +0300
Message-ID: <20120828152312.GB2903__32743.254202842$1346171189$gmane$org@redhat.com>
References: <cover.1345869378.git.aquini@redhat.com>
	<aa4af6e819584cb05fc0dba44594ae23ab761d03.1345869378.git.aquini@redhat.com>
	<20120826075557.GD19551@redhat.com>
	<20120827202834.GC6517@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120827202834.GC6517@t510.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 27, 2012 at 05:28:35PM -0300, Rafael Aquini wrote:
> On Sun, Aug 26, 2012 at 10:55:58AM +0300, Michael S. Tsirkin wrote:
> > On Sat, Aug 25, 2012 at 02:24:56AM -0300, Rafael Aquini wrote:
> > > Memory fragmentation introduced by ballooning might reduce significantly
> > > the number of 2MB contiguous memory blocks that can be used within a guest,
> > > thus imposing performance penalties associated with the reduced number of
> > > transparent huge pages that could be used by the guest workload.
> > > 
> > > This patch introduces a common interface to help a balloon driver on
> > > making its page set movable to compaction, and thus allowing the system
> > > to better leverage the compation efforts on memory defragmentation.
> > > 
> > > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > 
> > Tons of rcu uses but not sync in sight. This looks suspicious.
> 
> There's no critical section marked with rcu_read_lock/rcu_read_unlock. that's
> why there's no call for sync anywhere. As we are behaving mostly as updaters,
> the hole rcu usage is awkward and it's placed basically to enforce the proper
> order. To avoid hurting the RCU API usage with this awk approach I'll drop it
> for the next series submission (it will use barriers instead).

If everything is under page lock, barriers are likely not required.
If not, they might not be sufficient.

-- 
MST
