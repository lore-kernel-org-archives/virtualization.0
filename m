From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Mon, 4 Jun 2018 21:52:08 -0700
Message-ID: <20180605045207.GA28447__45537.8330815167$1528174231$gmane$org@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
	<20180604153558-mutt-send-email-mst@kernel.org>
	<e7ceddbec11711a89282e9b70b7fd3c8af10b030.camel@kernel.crashing.org>
	<20180604184035-mutt-send-email-mst@kernel.org>
	<6164442a718645a754879eac5c4c5fad9283c211.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6164442a718645a754879eac5c4c5fad9283c211.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, luto@amacapital.net, joe@perches.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 05, 2018 at 09:26:56AM +1000, Benjamin Herrenschmidt wrote:
> Sorry Michael, that doesn't click. Yes of course virtio is implemented
> in qemu, but the problem we are trying to solve is *not* a qemu problem
> (the fact that the Linux drivers bypass the DMA API is wrong, needs
> fixing, and isnt a qemu problem). The fact that the secure guests need
> bounce buffering is not a qemu problem either.
> 
> Whether qemu chose to use an iommu or not is, and should remain an
> orthogonal problem.

Agreed.  We have a problem with qemu (old qemu only?) punching a hole
into the VM abstraction by deciding that even if firmware tables
claim use of an IOMMU for a PCI bus it expects virtio to use physiscal
addresses.  So far so bad.  The answer to that should have been to
quirk the affected qemu versions and move on.  Instead we now have
virtio not use the DMA API by default and are creating a worse problem.

Let's fix this issue ASAP and quirk the buggy implementations instead
of letting everyone else suffer.  

> The DMA API itself isn't the one that needs to learn "per-device
> quirks", it's just plumbing into arch backends. The "quirk" is at the
> point of establishing the backend for a given device.
> 
> We can go a good way down that path simply by having virtio in Linux
> start with putting *itself* its own direct ops in there when
> VIRTIO_F_IOMMU_PLATFORM is not set, and removing all the special casing
> in the rest of the driver.

Yes.  And we have all the infrastructure for that now.  A few RDMA
drivers quirk to virt_dma_ops, and virtio could quirk to dma_direct_ops
anytime now.  In fact given how much time we are spending arguing here
I'm going to give it a spin today.

> Once that's done, we have a single point of establishing the dma ops,
> we can quirk in there if needed, that's rather nicely contained, or put
> an arch hook, or whatever is necessary.

Yes.
