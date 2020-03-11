From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Wed, 11 Mar 2020 17:48:22 -0400
Message-ID: <20200311174348-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
 <20200311174822.GA96893@myrica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200311174822.GA96893@myrica>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Boeuf, Sebastien" <sebastien.boeuf@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2020 at 06:48:22PM +0100, Jean-Philippe Brucker wrote:
> Yes "not elegant" in part because of the PCI fixup. Fixups are used to
> work around bugs

Not really - they are for anything unusual that common PCI code can not
handle on its own.

-- 
MST
