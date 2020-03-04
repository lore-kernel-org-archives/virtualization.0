From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Wed, 4 Mar 2020 22:50:02 +0100
Message-ID: <20200304215001.GD3315@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
 <20200304142838-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200304142838-mutt-send-email-mst@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 04, 2020 at 02:34:33PM -0500, Michael S. Tsirkin wrote:
> All these extra levels of indirection is one of the reasons
> hypervisors such as kata try to avoid ACPI.

Platforms that don't use ACPI need another hardware detection mechanism,
which can also be supported. But the first step here is to enable the
general case, and for x86 platforms this means ACPI.

Regards,

	Joerg
