From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 3/5] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Tue, 21 Aug 2012 17:37:13 +0200
Message-ID: <1345563433.26596.2.camel__30698.0442641818$1345566122$gmane$org@twins>
References: <cover.1345519422.git.aquini@redhat.com>
	<c5f02c618c99b0da11240c1b504672de6f70a074.1345519422.git.aquini@redhat.com>
	<20120821144013.GA7784@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120821144013.GA7784@redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, paulmck <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2012-08-21 at 17:40 +0300, Michael S. Tsirkin wrote:
> > +             spin_lock(&vb->pages_lock);
> > +             page = list_first_or_null_rcu(&vb->pages, struct page, lru);
> 
> Why is list_first_or_null_rcu called outside
> RCU critical section here?

It looks like vb->pages_lock is the exclusive (or modification)
counterpart to the rcu-read-lock in this particular case, so it should
be fine.

Although for that same reason, it seems superfluous to use the RCU list
method since we're exclusive with list manipulations anyway.

> > +             if (!page) {
> > +                     spin_unlock(&vb->pages_lock);
> > +                     break;
> > +             }
> > +             /*
> > +              * It is safe now to drop page->mapping and delete this page
> > +              * from balloon page list, since we are grabbing 'pages_lock'
> > +              * which prevents 'virtballoon_isolatepage()' from acting.
> > +              */
> > +             clear_balloon_mapping(page);
> > +             list_del_rcu(&page->lru);
> > +             spin_unlock(&vb->pages_lock); 
