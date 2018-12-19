From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Date: Wed, 19 Dec 2018 18:09:59 -0500
Message-ID: <20181219180417-mutt-send-email-mst__45270.1283073567$1545260903$gmane$org@kernel.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
	<20181212103545.GV16835@8bytes.org>
	<9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "bhelgaas@google.com" <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
> >> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
> >>=A0=A0=A0=A0 git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> > =

> > Unfortunatly gitweb seems to be broken on linux-arm.org. What is missing
> > in this patch-set to make this work on x86?
> =

> You should be able to access it here:
> http://www.linux-arm.org/git?p=3Dlinux-jpb.git;a=3Dshortlog;h=3Drefs/head=
s/virtio-iommu/devel
> =

> That branch contains missing bits for x86 support:
> =

> * ACPI support. We have the code but it's waiting for an IORT spec
> update, to reserve the IORT node ID. I expect it to take a while, given
> that I'm alone requesting a change for something that's not upstream or
> in hardware.

Frankly I think you should take a hard look at just getting the data
needed from the PCI device itself.  You don't need to depend on virtio,
it can be a small driver that gets you that data from the device config
space and then just goes away.

If you want help with writing such a small driver let me know.

If there's an advantage to virtio-iommu then that would be its
portability, and it all goes out of the window because
of dependencies on ACPI and DT and OF and the rest of the zoo.


> * DMA ops for x86 (see "HACK" commit). I'd like to use dma-iommu but I'm
> not sure how to implement the glue that sets dma_ops properly.
> =

> Thanks,
> Jean

OK so IIUC you are looking into Christoph's suggestions to fix that up?

There's still a bit of time left before the merge window,
maybe you can make above changes.

-- =

MST
