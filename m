From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon
	pages mobility
Date: Thu, 23 Aug 2012 14:28:45 -0300
Message-ID: <20120823172844.GC10777__12238.6673502207$1345742963$gmane$org@t510.redhat.com>
References: <20120822000741.GI9027@redhat.com>
	<20120822011930.GA23753@t510.redhat.com>
	<20120822093317.GC10680@redhat.com>
	<20120823021903.GA23660@x61.redhat.com>
	<20120823100107.GA17409@redhat.com>
	<20120823121338.GA3062@t510.redhat.com>
	<20120823123432.GA25659@redhat.com>
	<20120823130606.GB3746@t510.redhat.com>
	<20120823135328.GB25709@redhat.com>
	<20120823162504.GA1522@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120823162504.GA1522@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 23, 2012 at 07:25:05PM +0300, Michael S. Tsirkin wrote:
> On Thu, Aug 23, 2012 at 04:53:28PM +0300, Michael S. Tsirkin wrote:
> > Basically it was very simple: we assumed page->lru was never
> > touched for an allocated page, so it's safe to use it for
> > internal book-keeping by the driver.
> > 
> > Now, this is not the case anymore, you add some logic in mm/ that might
> > or might not touch page->lru depending on things like reference count.
> 
> Another thought: would the issue go away if balloon used
> page->private to link pages instead of LRU?
> mm core could keep a reference on page to avoid it
> being used while mm handles it (maybe it does already?).
>
I don't think so. That would be a lot more trikier and complex, IMHO.
 
> If we do this, will not the only change to balloon be to tell mm that it
> can use compaction for these pages when it allocates the page: using
> some GPF flag or a new API?
> 

What about keep a conter at virtio_balloon structure on how much pages are
isolated from balloon's list and check it at leak time?
if the counter gets > 0 than we can safely put leak_balloon() to wait until
balloon page list gets completely refilled. I guess that is simple to get
accomplished and potentially addresses all your concerns on this issue.

Cheers!
