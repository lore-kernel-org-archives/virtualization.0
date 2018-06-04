From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Mon, 4 Jun 2018 15:50:46 +0300
Message-ID: <20180604154355-mutt-send-email-mst__20842.1320924119$1528116527$gmane$org@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
	<20180604085742.GQ4251@umbus>
	<d5df613d6347fe2f9bb6ea65bc6f6be05650ca6f.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d5df613d6347fe2f9bb6ea65bc6f6be05650ca6f.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, joe@perches.com, David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 04, 2018 at 07:48:54PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-04 at 18:57 +1000, David Gibson wrote:
> > 
> > > - First qemu doesn't know that the guest will switch to "secure mode"
> > > in advance. There is no difference between a normal and a secure
> > > partition until the partition does the magic UV call to "enter secure
> > > mode" and qemu doesn't see any of it. So who can set the flag here ?
> > 
> > This seems weird to me.  As a rule HV calls should go through qemu -
> > or be allowed to go directly to KVM *by* qemu.
> 
> It's not an HV call, it's a UV call, qemu won't see it, qemu isn't
> trusted. Now the UV *will* reflect that to the HV via some synthetized
> HV calls, and we *could* have those do a pass by qemu, however, so far,
> our entire design doesn't rely on *any* qemu knowledge whatsoever and
> it would be sad to add it just for that purpose.

It's a temporary work-around. I think that the long-term fix is to
support per-device quirks and have the DMA API DTRT for virtio.

> Additionally, this is rather orthogonal, see my other email, the
> problem we are trying to solve is *not* a qemu problem and it doesn't
> make sense to leak that into qemu.
> 
> >   We generally reserve
> > the latter for hot path things.  Since this isn't a hot path, having
> > the call handled directly by the kernel seems wrong.
> >
> > Unless a "UV call" is something different I don't know about.
> 
> Yes, a UV call goes to the Ultravisor, not the Hypervisor. The
> Hypervisor isn't trusted.
> 
> > > - Second, when using VIRTIO_F_IOMMU_PLATFORM, we also make qemu (or
> > > vhost) go through the emulated MMIO for every access to the guest,
> > > which adds additional overhead.
> > 
> Ben.
