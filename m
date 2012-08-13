From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Tue, 14 Aug 2012 09:29:49 +0930
Message-ID: <87lihis5qi.fsf__21803.5557111309$1344903797$gmane$org@rustcorp.com.au>
References: <cover.1344619987.git.aquini@redhat.com>
	<f19b63dfa026fe2f8f11ec017771161775744781.1344619987.git.aquini@redhat.com>
	<20120813084123.GF14081@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120813084123.GF14081@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Aug 2012 11:41:23 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Aug 10, 2012 at 02:55:15PM -0300, Rafael Aquini wrote:
> > +/*
> > + * Populate balloon_mapping->a_ops->freepage method to help compaction on
> > + * re-inserting an isolated page into the balloon page list.
> > + */
> > +void virtballoon_putbackpage(struct page *page)
> > +{
> > +	spin_lock(&pages_lock);
> > +	list_add(&page->lru, &vb_ptr->pages);
> > +	spin_unlock(&pages_lock);
> 
> Could the following race trigger:
> migration happens while module unloading is in progress,
> module goes away between here and when the function
> returns, then code for this function gets overwritten?
> If yes we need locking external to module to prevent this.
> Maybe add a spinlock to struct address_space?

The balloon module cannot be unloaded until it has leaked all its pages,
so I think this is safe:

        static void remove_common(struct virtio_balloon *vb)
        {
        	/* There might be pages left in the balloon: free them. */
        	while (vb->num_pages)
        		leak_balloon(vb, vb->num_pages);

Cheers,
Rusty.
