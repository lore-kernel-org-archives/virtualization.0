From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 10 Sep 2018 10:53:16 +0200
Message-ID: <20180910085316.yzjbvoohqhdng2vb__40293.9055501067$1536569484$gmane$org@sirius.home.kraxel.org>
References: <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
	<20180808063158.GA2474@infradead.org>
	<4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
	<20180808123036.GA2525@infradead.org>
	<b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
	<20180808232210-mutt-send-email-mst@kernel.org>
	<98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
	<20180809054013.GA20507@infradead.org>
	<f1eeb994-ea13-d0f1-dc55-7c5049e70670@amd.com>
	<20180910061947.GA30666@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180910061947.GA30666@infradead.org>
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
Cc: brijesh.singh@amd.com, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, paulus@samba.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>, robh@kernel.org, Jiandi An <jiandi@amd.com>, jean-philippe.brucker@arm.com, mpe@ellerman.id.au, thomas.lendacky@amd.com, marc.zyngier@arm.com, linuxram@us.ibm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, joe@perches.com, jiandi.an@amd.com, robin.murphy@arm.com, haren@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

> > this to set the VIRTIO_F_IOMMU_PLATFORM flag. But for example
> > QEMU has the use of iommu_platform attribute disabled for virtio-gpu
> > device.  So would also like to move towards not having to specify
> > the VIRTIO_F_IOMMU_PLATFORM flag.
> 
> Specifying VIRTIO_F_IOMMU_PLATFORM is the right thing for your 
> platform given that you can't directly use physical addresses.
> Please fix qemu so that virtio-gpu works with VIRTIO_F_IOMMU_PLATFORM.

This needs both host and guest side changes btw.

Guest side patch is in drm-misc (a3b815f09bb8) and should land in the
next merge window.

Host side patches are here:
  https://git.kraxel.org/cgit/qemu/log/?h=sirius/virtio-gpu-iommu

Should also land in the next qemu version.

cheers,
  Gerd
