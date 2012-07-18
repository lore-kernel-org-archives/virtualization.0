From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/3] mm: introduce compaction and migration for
	virtio ballooned pages
Date: Wed, 18 Jul 2012 16:12:39 -0700
Message-ID: <20120718161239.9449e6b5.akpm@linux-foundation.org>
References: <cover.1342485774.git.aquini@redhat.com>
	<49f828a9331c9b729fcf77226006921ec5bc52fa.1342485774.git.aquini@redhat.com>
	<20120718154605.cb0591bc.akpm@linux-foundation.org>
	<20120718230706.GB2313@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120718230706.GB2313@t510.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Rafael Aquini <aquini@linux.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 18 Jul 2012 20:07:07 -0300
Rafael Aquini <aquini@redhat.com> wrote:

> > 
> > > +}
> > > +#else
> > > +static inline bool is_balloon_page(struct page *page)       { return false; }
> > > +static inline bool isolate_balloon_page(struct page *page)  { return false; }
> > > +static inline bool putback_balloon_page(struct page *page)  { return false; }
> > > +#endif /* (VIRTIO_BALLOON || VIRTIO_BALLOON_MODULE) && COMPACTION */
> > 
> > This means that if CONFIG_VIRTIO_BALLOON=y and CONFIG_COMPACTION=n,
> > is_balloon_page() will always return NULL.  IOW, no pages are balloon
> > pages!  This is wrong.
> > 
> I believe it's right, actually, as we can see CONFIG_COMPACTION=n associated with
> CONFIG_MIGRATION=y (and  CONFIG_VIRTIO_BALLOON=y).
> For such config case we cannot perform the is_balloon_page() test branches
> placed on mm/migration.c

No, it isn't right.  Look at the name: "is_balloon_page".  If a caller
runs is_balloon_page() against a balloon page with CONFIG_COMPACTION=n
then they will get "false", which is incorrect.

So the function needs a better name - one which communicates that it is
a balloon page *for the purposes of processing by the compaction code*. 
Making the function private to compaction.c would help with that, if
feasible.
