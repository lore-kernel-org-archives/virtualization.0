From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v7 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 14 Aug 2012 17:00:49 -0300
Message-ID: <20120814200043.GB22133__19362.4515938156$1344974472$gmane$org@t510.redhat.com>
References: <cover.1344619987.git.aquini@redhat.com>
	<292b1b52e863a05b299f94bda69a61371011ac19.1344619987.git.aquini@redhat.com>
	<20120813082619.GE14081@redhat.com>
	<20120814174404.GA13338@t510.redhat.com>
	<20120814193525.GB28840@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120814193525.GB28840@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2012 at 10:35:25PM +0300, Michael S. Tsirkin wrote:
> > > > +/* __isolate_lru_page() counterpart for a ballooned page */
> > > > +bool isolate_balloon_page(struct page *page)
> > > > +{
> > > > +	if (WARN_ON(!movable_balloon_page(page)))
> > > 
> > > Looks like this actually can happen if the page is leaked
> > > between previous movable_balloon_page and here.
> > > 
> > > > +		return false;
> > 
> > Yes, it surely can happen, and it does not harm to catch it here, print a warn and
> > return.
> 
> If it is legal, why warn? For that matter why test here at all?
>

As this is a public symbol, and despite the usage we introduce is sane, the warn
was placed as an insurance policy to let us know about any insane attempt to use
the procedure in the future. That was due to a nice review nitpick, actually.

Even though the code already had a test to properly avoid this race you
mention, I thought that sustaining the warn was a good thing. As I told you,
despite real, I've never got (un)lucky enough to stumble across that race window
while testing the patch.

If your concern is about being too much verbose on logging, under certain
conditions, perhaps we can change that test to a WARN_ON_ONCE() ?

Mel, what are your thoughts here?
 
> > While testing it, I wasn't lucky to see this small window opening, though.
