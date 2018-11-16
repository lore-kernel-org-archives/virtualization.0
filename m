From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/7] of: Allow the iommu-map property to omit
	untranslated devices
Date: Fri, 16 Nov 2018 17:26:48 -0600
Message-ID: <20181116232648.GA12293__41160.7295311571$1542410700$gmane$org@bogus>
References: <20181115165234.43990-1-jean-philippe.brucker@arm.com>
	<20181115165234.43990-4-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181115165234.43990-4-jean-philippe.brucker@arm.com>
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
Cc: mark.rutland@arm.com, virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, joro@8bytes.org, mst@redhat.com, will.deacon@arm.com, robin.murphy@arm.com, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, kvmarm@lists.cs.columbia.edu, bhelgaas@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Nov 2018 16:52:30 +0000, Jean-Philippe Brucker wrote:
> In PCI root complex nodes, the iommu-map property describes the IOMMU that
> translates each endpoint. On some platforms, the IOMMU itself is presented
> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). This isn't supported
> by the current OF driver, which expects all endpoints to have an IOMMU.
> Allow the iommu-map property to have gaps.
> 
> Relaxing of_map_rid() also allows the msi-map property to have gaps, which
> is invalid since MSIs always reach an MSI controller. In that case
> pci_msi_setup_msi_irqs() will return an error when attempting to find the
> device's MSI domain.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/of/base.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
