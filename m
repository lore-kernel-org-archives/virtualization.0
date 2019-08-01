From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/12] block: bio_release_pages: use flags arg instead
	of bool
Date: Thu, 1 Aug 2019 10:20:04 +0200
Message-ID: <20190801082004.GA17348__18654.657276214$1564648531$gmane$org@lst.de>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
	<20190724042518.14363-4-jhubbard@nvidia.com>
	<20190724053053.GA18330@infradead.org>
	<20190729205721.GB3760@redhat.com> <20190730102557.GA1700@lst.de>
	<20190730155702.GB10366@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190730155702.GB10366@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Minwoo Im <minwoo.im.dev@gmail.com>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, Anna Schumaker <anna.schumaker@netapp.com>linu
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 30, 2019 at 11:57:02AM -0400, Jerome Glisse wrote:
> Other user can also add page that are not coming from GUP but need to
> have a reference see __blkdev_direct_IO()

Except for the zero page case I mentioned in my last mail explicitly,
and the KVEC/PIPE type iov vecs from the original mail what other
pages do you see to get added?
