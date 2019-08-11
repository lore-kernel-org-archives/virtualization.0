From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Sun, 11 Aug 2019 04:55:27 -0400
Message-ID: <20190811044431-mutt-send-email-mst__40593.1957227708$1565513744$gmane$org@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190811055607.GA12488@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> So we need a flag on the virtio device, exposed by the
> hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> don't take a shortcut.

The point here is that it's actually still not real. So we would still
use a physical address. However Linux decides that it wants extra
security by moving all data through the bounce buffer.  The distinction
made is that one can actually give device a physical address of the
bounce buffer.

-- 
MST
