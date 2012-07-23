From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v4 1/3] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Mon, 23 Jul 2012 11:35:10 +0900
Message-ID: <20120723023510.GB6832__41672.5864205093$1343076684$gmane$org@bbox>
References: <cover.1342485774.git.aquini@redhat.com>
	<49f828a9331c9b729fcf77226006921ec5bc52fa.1342485774.git.aquini@redhat.com>
	<20120718054824.GA32341@bbox>
	<20120720194858.GA16249@t510.redhat.com>
	<20120723023332.GA6832@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120723023332.GA6832@bbox>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Rafael Aquini <aquini@linux.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 23, 2012 at 11:33:32AM +0900, Minchan Kim wrote:
> Hi Rafael,
> 
> On Fri, Jul 20, 2012 at 04:48:59PM -0300, Rafael Aquini wrote:
> > Howdy Minchan,
> > 
> > Once again, thanks for raising such valuable feedback over here.
> > 
> > On Wed, Jul 18, 2012 at 02:48:24PM +0900, Minchan Kim wrote:
> > > > +/* __isolate_lru_page() counterpart for a ballooned page */
> > > > +static bool isolate_balloon_page(struct page *page)
> > > > +{
> > > > +	if (WARN_ON(!is_balloon_page(page)))
> > > > +		return false;
> > > 
> > > I am not sure we need this because you alreay check it before calling
> > > isolate_balloon_page. If you really need it, it would be better to
> > > add likely in isolate_balloon_page, too.
> > > 
> > 
> > This check point was set in place because isolate_balloon_page() was a publicly
> > visible function and while our current usage looks correct it would not hurt to
> > have something like that done -- think of it as an insurance policy, in case
> > someone else, in the future, attempts to use it on any other place outside this
> > specifc context. 
> > Despite not seeing it as a dealbreaker for the patch as is, I do agree, however,
> > this snippet can _potentially_ be removed from isolate_balloon_page(), since
> > this function has become static to compaction.c.
> 
> Yes. It's not static.

Typo. It's static.

-- 
Kind regards,
Minchan Kim
