From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Wed, 4 Mar 2020 16:38:21 +0100
Message-ID: <20200304153821.GE646000@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200304133707.GB4177@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 04, 2020 at 02:37:08PM +0100, Joerg Roedel wrote:
> Hi Michael,
> 
> On Tue, Mar 03, 2020 at 11:09:41AM -0500, Michael S. Tsirkin wrote:
> > No. It's coded into the hardware. Which might even be practical
> > for bare-metal (e.g. on-board flash), but is very practical
> > when the device is part of a hypervisor.
> 
> If its that way on PPC, than fine for them. But since this is enablement
> for x86, it should follow the x86 platform best practices, and that
> means describing hardware through ACPI.

I agree with this. The problem is I don't know how to get a new ACPI table
or change an existing one. It needs to go through the UEFI forum in order
to be accepted, and I don't have any weight there. I've been trying to get
the tiny change into IORT for ages. I haven't been given any convincing
reason against it or offered any alternative, it's just stalled. The
topology description introduced here wasn't my first choice either but
unless someone can help finding another way into ACPI, I don't have a
better idea.

Thanks,
Jean
