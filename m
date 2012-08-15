From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Wed, 15 Aug 2012 10:05:28 +0100
Message-ID: <20120815090528.GH4052@csn.ul.ie>
References: <cover.1344619987.git.aquini@redhat.com>
	<f19b63dfa026fe2f8f11ec017771161775744781.1344619987.git.aquini@redhat.com>
	<20120813084123.GF14081@redhat.com>
	<20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814201113.GE22133@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120814201113.GE22133@t510.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2012 at 05:11:13PM -0300, Rafael Aquini wrote:
> On Tue, Aug 14, 2012 at 10:51:39PM +0300, Michael S. Tsirkin wrote:
> > What I think you should do is use rcu for access.
> > And here sync rcu before freeing.
> > Maybe an overkill but at least a documented synchronization
> > primitive, and it is very light weight.
> > 
> 
> I liked your suggestion on barriers, as well.
> 

I have not thought about this as deeply as I shouold but is simply rechecking
the mapping under the pages_lock to make sure the page is still a balloon
page an option? i.e. use pages_lock to stabilise page->mapping.

-- 
Mel Gorman
SUSE Labs
