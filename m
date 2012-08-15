From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Wed, 15 Aug 2012 10:48:39 +0100
Message-ID: <20120815094839.GJ4052__37744.1266821281$1345024145$gmane$org@csn.ul.ie>
References: <cover.1344619987.git.aquini@redhat.com>
	<f19b63dfa026fe2f8f11ec017771161775744781.1344619987.git.aquini@redhat.com>
	<20120813084123.GF14081@redhat.com>
	<20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814201113.GE22133@t510.redhat.com>
	<20120815090528.GH4052@csn.ul.ie>
	<20120815092528.GA29214@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120815092528.GA29214@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 15, 2012 at 12:25:28PM +0300, Michael S. Tsirkin wrote:
> On Wed, Aug 15, 2012 at 10:05:28AM +0100, Mel Gorman wrote:
> > On Tue, Aug 14, 2012 at 05:11:13PM -0300, Rafael Aquini wrote:
> > > On Tue, Aug 14, 2012 at 10:51:39PM +0300, Michael S. Tsirkin wrote:
> > > > What I think you should do is use rcu for access.
> > > > And here sync rcu before freeing.
> > > > Maybe an overkill but at least a documented synchronization
> > > > primitive, and it is very light weight.
> > > > 
> > > 
> > > I liked your suggestion on barriers, as well.
> > > 
> > 
> > I have not thought about this as deeply as I shouold but is simply rechecking
> > the mapping under the pages_lock to make sure the page is still a balloon
> > page an option? i.e. use pages_lock to stabilise page->mapping.
> 
> To clarify, are you concerned about cost of rcu_read_lock
> for non balloon pages?
> 

Not as such, but given the choice between introducing RCU locking and
rechecking page->mapping under a spinlock I would choose the latter as it
is more straight-forward.

-- 
Mel Gorman
SUSE Labs
