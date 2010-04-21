From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-spec: document block CMD and FLUSH
Date: Wed, 21 Apr 2010 13:39:59 +0300
Message-ID: <20100421103959.GA31461__12070.7916249104$1271846886$gmane$org@redhat.com>
References: <20100218222220.GA14847@redhat.com>
	<20100420014635.GE21899@shareable.org>
	<201004201422.58456.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201004201422.58456.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: kvm@vger.kernel.org, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 20, 2010 at 02:22:58PM +0100, Paul Brook wrote:
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
> (3) allows the guest to queue overlapping transfers with well defined results.
> I have no idea how useful this is in practice, but it's certainly plausible.
> 
> Paul

In theory, yes.
At the moment, qemu only implements FLUSH and lguest only
implements barrier without FLUSH.

If you think it's useful, maybe start by using FLUSH+barrier
in linux guest driver, that'd demonstrate how it's used.


-- 
MST
