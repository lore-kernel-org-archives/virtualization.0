From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Wed, 22 Aug 2012 03:37:24 +0300
Message-ID: <20120822003723.GL9027__36705.4467242726$1345595801$gmane$org@redhat.com>
References: <20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814201113.GE22133@t510.redhat.com>
	<20120815090528.GH4052@csn.ul.ie>
	<20120815092528.GA29214@redhat.com>
	<20120815094839.GJ4052@csn.ul.ie>
	<20120815100108.GA1999@redhat.com>
	<20120815111651.GL4052@csn.ul.ie>
	<20120815112851.GA2707@redhat.com> <87mx1o3j5y.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mx1o3j5y.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2012 at 03:01:37PM +0930, Rusty Russell wrote:
> On Wed, 15 Aug 2012 14:28:51 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Aug 15, 2012 at 12:16:51PM +0100, Mel Gorman wrote:
> > > I was thinking of exactly that page->mapping == balloon_mapping check. As I
> > > do not know how many active balloon drivers there might be I cannot guess
> > > in advance how much of a scalability problem it will be.
> > 
> > Not at all sure multiple drivers are worth supporting, but multiple
> > *devices* is I think worth supporting, if for no other reason than that
> > they can work today. For that, we need a device pointer which Rafael
> > wants to put into the mapping, this means multiple balloon mappings.
> 
> Rafael, please make sure that the balloon driver fails on the second and
> subsequent balloon devices.
> 
> Michael, we only allow multiple balloon devices because it fell out of
> the implementation.  If it causes us even the slightest issue, we should
> not support it.  It's not a sensible setup.
> 
> Cheers,
> Rusty.

Looks like latest revision does it using a flag which seems cleaner,
so I think the point is moot.

-- 
MST
