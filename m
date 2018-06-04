From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Mon, 4 Jun 2018 19:34:19 +0300
Message-ID: <20180604193310-mutt-send-email-mst__29235.345303505$1528129959$gmane$org@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
	<20180604153558-mutt-send-email-mst@kernel.org>
	<20180604125530.GA16378@infradead.org>
	<acdfef1327f73f6ac67645d9f1a8e9204a0f22fb.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <acdfef1327f73f6ac67645d9f1a8e9204a0f22fb.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, joe@perches.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 04, 2018 at 11:14:36PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-04 at 05:55 -0700, Christoph Hellwig wrote:
> > On Mon, Jun 04, 2018 at 03:43:09PM +0300, Michael S. Tsirkin wrote:
> > > Another is that given the basic functionality is in there, optimizations
> > > can possibly wait until per-device quirks in DMA API are supported.
> > 
> > We have had per-device dma_ops for quite a while.
> 
> I've asked Ansuman to start with a patch that converts virtio to use
> DMA ops always, along with an init quirk to hookup "direct" ops when
> the IOMMU flag isn't set.
> 
> This will at least remove that horrid duplication of code path we have
> in there.
> 
> Then we can just involve the arch in that init quirk so we can chose an
> alternate set of ops when running a secure VM.
> 
> This is completely orthogonal to whether an iommu exist qemu side or
> not, and should be entirely solved on the Linux side.
> 
> Cheers,
> Ben.

Sounds good to me.

-- 
MST
