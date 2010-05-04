From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 4 May 2010 20:56:14 +0200
Message-ID: <20100504185614.GB24998@lst.de>
References: <20100218222220.GA14847@redhat.com>
	<20100420014635.GE21899@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100420014635.GE21899@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 20, 2010 at 02:46:35AM +0100, Jamie Lokier wrote:
> Does this mean that virtio-blk supports all three combinations?
> 
>    1. FLUSH that isn't a barrier
>    2. FLUSH that is also a barrier
>    3. Barrier that is not a flush
> 
> 1 is good for fsync-like operations;
> 2 is good for journalling-like ordered operations.
> 3 sounds like it doesn't mean a lot as the host cache provides no
> guarantees and has no ordering facility that can be used.

No.  The Linux virtio_blk guest driver either supports data integrity
by using FLUSH or can send down BARRIER requests which aren't much
help at all.  Qemu only implements FLUSH anyway.
