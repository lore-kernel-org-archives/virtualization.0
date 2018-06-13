From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Wed, 13 Jun 2018 16:49:39 +0300
Message-ID: <20180613161806-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<20180524072104.GD6139@ram.oc3035372033.ibm.com>
	<0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
	<20180531204320-mutt-send-email-mst@kernel.org>
	<20180607052306.GA1532@infradead.org>
	<20180607185234-mutt-send-email-mst@kernel.org>
	<20180608063655.GA32080@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180608063655.GA32080@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: robh@kernel.org, pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>, cohuck@redhat.com, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, joe@perches.com, "Rustad, Mark D" <mark.d.rustad@intel.com>, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 07, 2018 at 11:36:55PM -0700, Christoph Hellwig wrote:
> > This seems to be what was being asked for in this thread,
> > with comments claiming IOMMU flag adds too much overhead.
> 
> Right now it means implementing a virtual iommu, which I agree is
> way too much overhead.

Well not really. The flag in question will have a desired effect without
a virtual iommu.

> > SEV guys report that they just set the iommu flag and then it all works.
> > I guess if there's translation we can think of this as a kind of iommu.
> > Maybe we should rename PLATFORM_IOMMU to PLARTFORM_TRANSLATION?
> 
> VIRTIO_F_BEHAVES_LIKE_A_REAL_PCI_DEVICE_DONT_TRY_TO_OUTSMART_ME
> 
> as said it's not just translations, it is cache coherence as well.

Well it's only for DMA. So maybe PLATFORM_DMA.

I suspect people will then come and complain that they
do *not* want cache coherence tricks because virtio is
running on a CPU, but we'll see.

> > And apparently some people complain that just setting that flag makes
> > qemu check translation on each access with an unacceptable performance
> > overhead.  Forcing same behaviour for everyone on general principles
> > even without the flag is unlikely to make them happy.
> 
> That sounds like a qemu implementation bug.  If qemu knowns that
> guest physiscall == guest dma space there is no need to check.

Possibly. Or it's possible it's all just theoretical, no one
posted any numbers.

-- 
MST
