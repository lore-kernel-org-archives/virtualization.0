From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 5/7] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Sat, 10 Nov 2012 17:53:19 +0200
Message-ID: <20121110155319.GA13846__23032.4614829899$1352562690$gmane$org@redhat.com>
References: <cover.1352256081.git.aquini@redhat.com>
	<265aaff9a79f503672f0cdcdff204114b5b5ba5b.1352256088.git.aquini@redhat.com>
	<87625h3tl1.fsf@rustcorp.com.au>
	<20121107161146.b99dc4a8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121107161146.b99dc4a8.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 07, 2012 at 04:11:46PM -0800, Andrew Morton wrote:
> On Thu, 08 Nov 2012 09:32:18 +1030
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > Rafael Aquini <aquini@redhat.com> writes:
> > > + * virtballoon_migratepage - perform the balloon page migration on behalf of
> > > + *			     a compation thread.     (called under page lock)
> > 
> > > +	if (!mutex_trylock(&vb->balloon_lock))
> > > +		return -EAGAIN;
> > 
> > Erk, OK...
> 
> Not really.  As is almost always the case with a trylock, it needs a
> comment explaining why we couldn't use the far superior mutex_lock(). 
> Data: this reader doesn't know!
> 
> > > +	/* balloon's page migration 1st step  -- inflate "newpage" */
> > > +	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
> > > +	balloon_page_insert(newpage, mapping, &vb_dev_info->pages);
> > > +	vb_dev_info->isolated_pages--;
> > > +	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
> > > +	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
> > > +	set_page_pfns(vb->pfns, newpage);
> > > +	tell_host(vb, vb->inflate_vq);
> > 
> > tell_host does wait_event(), so you can't call it under the page_lock.
> > Right?
> 
> Sleeping inside lock_page() is OK.  More problematic is that GFP_KERNEL
> allocation.

Do you mean this one:
        if (virtqueue_add_buf(vq, &sg, 1, 0, vb, GFP_KERNEL) < 0)
 ?

In practice it never triggers an allocation, we can pass in
GFP_ATOMIC just as well.

-- 
MST
