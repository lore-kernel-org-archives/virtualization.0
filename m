From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC v1 0/3] Add VIRTIO_F_IOMMU_PLATFORM support
Date: Mon, 24 Jul 2017 10:25:01 +0200
Message-ID: <1500884701.15837.1.camel__23209.1308491819$1500884718$gmane$org@redhat.com>
References: <1500502151-13508-1-git-send-email-brijesh.singh@amd.com>
	<62320c1a-0cec-947c-8c63-5eb0416e4e33@redhat.com>
	<25d78a89-59bd-157a-ccf5-70cd25e14a05@amd.com>
	<20170722024318-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170722024318-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, David Airlie <airlied@linux.ie>, Jordan Justen <jordan.l.justen@intel.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Laszlo Ersek <lersek@redhat.com>, edk2-devel@lists.01.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > I see that OVMF has the following virtio drivers, we need to update
> > them
> > all:
> > 
> > VirtioBlkDxe
> > VirtioGpuDxe
> > VirtioNetDxe
> > VirtioRngDxe
> > VirtioScsiDxe
> > 
> > I will wait for Laszlo and Jordan's initial feedback before
> > changing
> > other drivers.
> 
> I'm not sure about the GPU. Cc relevant maintainers -
> can virtio GPU work from behind an IOMMU?

GPU uses main memory as backing storage for framebuffers, and this is
passed as guest physical address (scatterlist of addresses to be exact)
to the host.

So, I think no, this isn't going to work with the current code.

Should be possible to fix though.  We need to define what "guest
physical address" should be with VIRTIO_F_IOMMU_PLATFORM enabled
(probably guest pci bus address) and add support for proper iommu
lookups.

cheers,
  Gerd
