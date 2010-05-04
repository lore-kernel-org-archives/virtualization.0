From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 4 May 2010 22:01:24 +0300
Message-ID: <20100504190124.GA29764__46150.9899622344$1272999952$gmane$org@redhat.com>
References: <20100218222220.GA14847@redhat.com>
	<20100420014635.GE21899@shareable.org>
	<20100504185614.GB24998@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100504185614.GB24998@lst.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 04, 2010 at 08:56:14PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 20, 2010 at 02:46:35AM +0100, Jamie Lokier wrote:
> > Does this mean that virtio-blk supports all three combinations?
> > 
> >    1. FLUSH that isn't a barrier
> >    2. FLUSH that is also a barrier
> >    3. Barrier that is not a flush
> > 
> > 1 is good for fsync-like operations;
> > 2 is good for journalling-like ordered operations.
> > 3 sounds like it doesn't mean a lot as the host cache provides no
> > guarantees and has no ordering facility that can be used.
> 
> No.  The Linux virtio_blk guest driver either supports data integrity
> by using FLUSH or can send down BARRIER requests which aren't much
> help at all.

It seems we use BARRIER when we get REQ_HARDBARRIER, right?
What does the REQ_HARDBARRIER flag in request mean and when is it set?

>  Qemu only implements FLUSH anyway.
