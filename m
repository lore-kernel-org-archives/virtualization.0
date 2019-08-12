From: Ram Pai <linuxram@us.ibm.com>
Subject: RE: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 12 Aug 2019 13:29:20 -0700
Message-ID: <20190812202920.GC5964__10009.8003329308$1565641792$gmane$org@ram.ibm.com>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190811064621.GB5964@ram.ibm.com> <20190812121324.GA9405@lst.de>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190812121324.GA9405@lst.de>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 12, 2019 at 02:13:24PM +0200, Christoph Hellwig wrote:
> On Sat, Aug 10, 2019 at 11:46:21PM -0700, Ram Pai wrote:
> > If the hypervisor (hardware for hw virtio devices) does not mandate a
> > DMA API, why is it illegal for the driver to request, special handling
> > of its i/o buffers? Why are we associating this special handling to
> > always mean, some DMA address translation? Can't there be 
> > any other kind of special handling needs, that has nothing to do with
> > DMA address translation?
> 
> I don't think it is illegal per se.  It is however completely broken
> if we do that decision on a system weide scale rather than properly
> requesting it through a per-device flag in the normal virtio framework.

if the decision has to be system-wide; for reasons known locally only to the
kernel/driver, something that is independent of any device-flag,
what would be the mechanism?

RP
