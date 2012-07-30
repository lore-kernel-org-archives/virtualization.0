From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 30 Jul 2012 15:44:24 +0200
Message-ID: <20120730134424.GC6041@lst.de>
References: <971756309.4742543.1343457753475.JavaMail.root@redhat.com>
	<501610E0.8000504@redhat.com> <5016383A.5090008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5016383A.5090008@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 30, 2012 at 09:31:06AM +0200, Paolo Bonzini wrote:
> You only need to add REQ_FLUSH support.  The virtio-blk protocol does
> not support REQ_FUA, because there's no easy way to do it in userspace.

A bio-based driver needs to handle both REQ_FLUSH and REQ_FUA as it does
not get the sequencing of REQ_FUA into REQ_FLUSH that request based drivers
can request.  To what the REQ_FUA request gets translated is a different story.
