From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Wed, 15 Aug 2012 13:01:08 +0300
Message-ID: <20120815100108.GA1999__8476.63537501848$1345024831$gmane$org@redhat.com>
References: <cover.1344619987.git.aquini@redhat.com>
	<f19b63dfa026fe2f8f11ec017771161775744781.1344619987.git.aquini@redhat.com>
	<20120813084123.GF14081@redhat.com>
	<20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814201113.GE22133@t510.redhat.com>
	<20120815090528.GH4052@csn.ul.ie>
	<20120815092528.GA29214@redhat.com>
	<20120815094839.GJ4052@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120815094839.GJ4052@csn.ul.ie>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mel Gorman <mel@csn.ul.ie>
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 15, 2012 at 10:48:39AM +0100, Mel Gorman wrote:
> On Wed, Aug 15, 2012 at 12:25:28PM +0300, Michael S. Tsirkin wrote:
> > On Wed, Aug 15, 2012 at 10:05:28AM +0100, Mel Gorman wrote:
> > > On Tue, Aug 14, 2012 at 05:11:13PM -0300, Rafael Aquini wrote:
> > > > On Tue, Aug 14, 2012 at 10:51:39PM +0300, Michael S. Tsirkin wrote:
> > > > > What I think you should do is use rcu for access.
> > > > > And here sync rcu before freeing.
> > > > > Maybe an overkill but at least a documented synchronization
> > > > > primitive, and it is very light weight.
> > > > > 
> > > > 
> > > > I liked your suggestion on barriers, as well.
> > > > 
> > > 
> > > I have not thought about this as deeply as I shouold but is simply rechecking
> > > the mapping under the pages_lock to make sure the page is still a balloon
> > > page an option? i.e. use pages_lock to stabilise page->mapping.
> > 
> > To clarify, are you concerned about cost of rcu_read_lock
> > for non balloon pages?
> > 
> 
> Not as such, but given the choice between introducing RCU locking and
> rechecking page->mapping under a spinlock I would choose the latter as it
> is more straight-forward.

OK but checking it how? page->mapping == balloon_mapping does not scale to
multiple balloons, so I hoped we can switch to
page->mapping->flags & BALLOON_MAPPING or some such,
but this means we dereference it outside the lock ...

We will also need to add some API to set/clear mapping so that driver
does not need to poke in mm internals, but that's easy.

> -- 
> Mel Gorman
> SUSE Labs
