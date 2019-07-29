From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 03/12] block: bio_release_pages: use flags arg instead of
	bool
Date: Mon, 29 Jul 2019 16:57:21 -0400
Message-ID: <20190729205721.GB3760__3498.58284914575$1564434146$gmane$org@redhat.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
	<20190724042518.14363-4-jhubbard@nvidia.com>
	<20190724053053.GA18330@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190724053053.GA18330@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Minwoo Im <minwoo.im.dev@gmail.com>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Andrew
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 23, 2019 at 10:30:53PM -0700, Christoph Hellwig wrote:
> On Tue, Jul 23, 2019 at 09:25:09PM -0700, john.hubbard@gmail.com wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> > =

> > In commit d241a95f3514 ("block: optionally mark pages dirty in
> > bio_release_pages"), new "bool mark_dirty" argument was added to
> > bio_release_pages.
> > =

> > In upcoming work, another bool argument (to indicate that the pages came
> > from get_user_pages) is going to be added. That's one bool too many,
> > because it's not desirable have calls of the form:
> =

> All pages releases by bio_release_pages should come from
> get_get_user_pages, so I don't really see the point here.

No they do not all comes from GUP for see various callers
of bio_check_pages_dirty() for instance iomap_dio_zero()

I have carefully tracked down all this and i did not do
anyconvertion just for the fun of it :)

Cheers,
J=E9r=F4me
