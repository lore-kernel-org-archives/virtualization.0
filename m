From: Christoph Hellwig <hch@infradead.org>
Subject: Re: virtio scsi host draft specification, v3
Date: Wed, 29 Jun 2011 06:00:18 -0400
Message-ID: <20110629100018.GA22900__24758.1156356775$1309341754$gmane$org@infradead.org>
References: <4DEE2B15.4090809@redhat.com> <4DF21447.6090005@suse.de>
	<20110612075140.GB11941@redhat.com> <4DF77E90.4080409@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4DF77E90.4080409@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 14, 2011 at 05:30:24PM +0200, Hannes Reinecke wrote:
> Which is exactly the problem I was referring to.
> When using more than one channel the request ordering
> _as seen by the initiator_ has to be preserved.
> 
> This is quite hard to do from a device's perspective;
> it might be able to process the requests _in the order_ they've
> arrived, but it won't be able to figure out the latency of each
> request, ie how it'll take the request to be delivered to the
> initiator.
> 
> What we need to do here is to ensure that virtio will deliver
> the requests in-order across all virtqueues. Not sure whether it
> does this already.

This only matters for ordered tags, or implicit or explicit HEAD OF
QUEUE tags.  For everything else there's no ordering requirement.
Given that ordered tags don't matter in practice and we don't have
to support them this just leaves HEAD OF QUEUE.  I suspect the
HEAD OF QUEUE semantics need to be implemented using underlying
draining of all queues, which should be okay given that it's
usually used in slow path commands.
