From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Wed, 4 Mar 2020 22:54:49 +0100
Message-ID: <20200304215449.GE3315@8bytes.org>
References: <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
 <20200304153821.GE646000@myrica>
 <20200304174045.GC3315@8bytes.org>
 <20200304133744.00000fdb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200304133744.00000fdb@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, robin.murphy@arm.com, "Kaneda, Erik" <erik.kaneda@intel.com>, "Rothman, Michael A" <michael.a.rothman@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 04, 2020 at 01:37:44PM -0800, Jacob Pan (Jun) wrote:
> + Mike and Erik who work closely on UEFI and ACPICA.
> 
> Copy paste Erik's initial response below on how to get a new table,
> seems to confirm with the process you stated above.
> 
> "Fairly easy. You reserve a 4-letter symbol by sending a message
> requesting to reserve the signature to Mike or the ASWG mailing list or
> info@acpi.info

Great! I think this is going to be the path forward here.

Regards,

	Joerg

> 
> There is also another option. You can have ASWG own this new table so
> that not one entity or company owns the new table."
