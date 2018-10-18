From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: virtio: Add virtio-pci-iommu node
Date: Wed, 17 Oct 2018 19:35:02 -0500
Message-ID: <20181018003502.GA28260__7975.86151534251$1539822789$gmane$org@bogus>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
	<20181012145917.6840-3-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181012145917.6840-3-jean-philippe.brucker@arm.com>
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, joro@8bytes.org, mst@redhat.com, will.deacon@arm.com, virtualization@lists.linux-foundation.org, eric.auger@redhat.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, marc.zyngier@arm.com, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 12 Oct 2018 15:59:12 +0100, Jean-Philippe Brucker wrote:
> Some systems implement virtio-iommu as a PCI endpoint. The operating
> systems needs to discover the relationship between IOMMU and masters long
> before the PCI endpoint gets probed. Add a PCI child node to describe the
> virtio-iommu device.
> 
> The virtio-pci-iommu is conceptually split between a PCI programming
> interface and a translation component on the parent bus. The latter
> doesn't have a node in the device tree. The virtio-pci-iommu node
> describes both, by linking the PCI endpoint to "iommus" property of DMA
> master nodes and to "iommu-map" properties of bus nodes.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  .../devicetree/bindings/virtio/iommu.txt      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
