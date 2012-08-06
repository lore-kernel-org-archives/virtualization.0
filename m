From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v5 1/3] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Mon, 6 Aug 2012 16:24:18 -0300
Message-ID: <20120806192418.GB3968__13054.5811182403$1344281108$gmane$org@t510.redhat.com>
References: <cover.1344259054.git.aquini@redhat.com>
	<212b5297df32cb4e3f60d5b76a8cb0629d328a4e.1344259054.git.aquini@redhat.com>
	<50200F1F.7060605@redhat.com>
	<20120806190053.GA3968@t510.redhat.com> <502015C9.2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <502015C9.2@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 06, 2012 at 03:06:49PM -0400, Rik van Riel wrote:
> 
> Just a plain rename would work.
>
Ok, I will rename it.
 
> >+static inline bool is_balloon_page(struct page *page)
> >+{
> >+	return (page->mapping && page->mapping == balloon_mapping);
> >+}
> 
> As an aside, since you are only comparing page->mapping and
> not dereferencing it, it can be simplified to just:
> 
> 	return (page->mapping == balloon_mapping);
> 
We really need both comparisons to avoid potential NULL pointer dereferences at
__isolate_balloon_page() & __putback_balloon_page() while running at bare metal
with no balloon driver loaded, since balloon_mapping itself is a pointer which
each balloon driver can set to its own structure. 

Thanks, Rik, for taking the time to look at this patch and provide (always)
valuable feedback.

I'll shortly respin a v6 with your suggestions.

-- Rafael
