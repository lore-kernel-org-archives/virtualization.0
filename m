From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/12] block: bio_release_pages: use flags arg instead
	of bool
Date: Tue, 30 Jul 2019 12:25:57 +0200
Message-ID: <20190730102557.GA1700__10950.7001050346$1564482734$gmane$org@lst.de>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
	<20190724042518.14363-4-jhubbard@nvidia.com>
	<20190724053053.GA18330@infradead.org>
	<20190729205721.GB3760@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190729205721.GB3760@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Minwoo Im <minwoo.im.dev@gmail.com>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>linux-
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 29, 2019 at 04:57:21PM -0400, Jerome Glisse wrote:
> > All pages releases by bio_release_pages should come from
> > get_get_user_pages, so I don't really see the point here.
> 
> No they do not all comes from GUP for see various callers
> of bio_check_pages_dirty() for instance iomap_dio_zero()
> 
> I have carefully tracked down all this and i did not do
> anyconvertion just for the fun of it :)

Well, the point is _should_ not necessarily do.  iomap_dio_zero adds the
ZERO_PAGE, which we by definition don't need to refcount.  So we can
mark this bio BIO_NO_PAGE_REF safely after removing the get_page there.

Note that the equivalent in the old direct I/O code, dio_refill_pages,
will be a little more complicated as it can match user pages and the
ZERO_PAGE in a single bio, so a per-bio flag won't handle it easily.
Maybe we just need to use a separate bio there as well.

In general with series like this we should not encode the status quo an
pile new hacks upon the old one, but thing where we should be and fix
up the old warts while having to wade through all that code.
