From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Wed, 13 Jun 2018 00:41:41 -0700
Message-ID: <20180613074141.GA12033@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<20180524072104.GD6139@ram.oc3035372033.ibm.com>
	<0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
	<20180531204320-mutt-send-email-mst@kernel.org>
	<20180607052306.GA1532@infradead.org>
	<20180607185234-mutt-send-email-mst@kernel.org>
	<20180611023909.GA5726@ram.oc3035372033.ibm.com>
	<07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: robh@kernel.org, cohuck@redhat.com, pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, joe@perches.com, "Rustad,
	Mark D" <mark.d.rustad@intel.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 11, 2018 at 01:29:18PM +1000, Benjamin Herrenschmidt wrote:
> At the risk of repeating myself, let's just do the first pass which is
> to switch virtio over to always using the DMA API in the actual data
> flow code, with a hook at initialization time that replaces the DMA ops
> with some home cooked "direct" ops in the case where the IOMMU flag
> isn't set.
> 
> This will be equivalent to what we have today but avoids having 2
> separate code path all over the driver.
> 
> Then a second stage, I think, is to replace this "hook" so that the
> architecture gets a say in the matter.

I don't think we can actually use dma_direct_ops.  It still allows
architectures to override parts of the dma setup, which virtio seems
to blindly assume phys == dma and not cache flushing.

I think the right way forward is to either add a new
VIRTIO_F_IS_PCI_DEVICE (or redefine the existing iommu flag if deemed
possible).  And then make sure recent qemu always sets it.
