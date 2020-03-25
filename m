From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V8 9/9] virtio: Intel IFC VF driver for VDPA
Date: Wed, 25 Mar 2020 09:34:10 -0300
Message-ID: <20200325123410.GX13183@mellanox.com>
References: <20200325082711.1107-1-jasowang@redhat.com>
 <20200325082711.1107-10-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200325082711.1107-10-jasowang@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, Bie Tiwei <tiwei.bie@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 25, 2020 at 04:27:11PM +0800, Jason Wang wrote:
> +static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ifcvf_adapter *adapter;
> +	struct ifcvf_hw *vf;
> +	int ret, i;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		IFCVF_ERR(&pdev->dev, "Failed to enable device\n");
> +		goto err_enable;
> +	}
> +
> +	ret = pci_request_regions(pdev, IFCVF_DRIVER_NAME);
> +	if (ret) {
> +		IFCVF_ERR(&pdev->dev, "Failed to request MMIO region\n");
> +		goto err_regions;
> +	}
> +
> +	ret = pci_alloc_irq_vectors(pdev, IFCVF_MAX_INTR,
> +				    IFCVF_MAX_INTR, PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		IFCVF_ERR(&pdev->dev, "Failed to alloc irq vectors\n");
> +		goto err_vectors;
> +	}
> +
> +	adapter = vdpa_alloc_device(ifcvf_adapter, vdpa, dev, &ifc_vdpa_ops);
> +	if (adapter == NULL) {
> +		IFCVF_ERR(&pdev->dev, "Failed to allocate vDPA structure");
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	adapter->dev = dev;
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, adapter);
> +
> +	ret = ifcvf_request_irq(adapter);
> +	if (ret) {
> +		IFCVF_ERR(&pdev->dev, "Failed to request MSI-X irq\n");
> +		goto err_msix;
> +	}
> +
> +	vf = &adapter->vf;
> +	for (i = 0; i < IFCVF_PCI_MAX_RESOURCE; i++) {
> +		vf->mem_resource[i].phys_addr = pci_resource_start(pdev, i);
> +		vf->mem_resource[i].len = pci_resource_len(pdev, i);
> +		if (!vf->mem_resource[i].len)
> +			continue;
> +
> +		vf->mem_resource[i].addr = pci_iomap_range(pdev, i, 0,
> +				vf->mem_resource[i].len);
> +		if (!vf->mem_resource[i].addr) {
> +			IFCVF_ERR(&pdev->dev,
> +				  "Failed to map IO resource %d\n", i);
> +			ret = -EINVAL;
> +			goto err_msix;
> +		}
> +	}
> +
> +	if (ifcvf_init_hw(vf, pdev) < 0) {
> +		ret = -EINVAL;
> +		goto err_msix;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +
> +	if (ret) {
> +		IFCVF_ERR(adapter->dev, "No usable DMA confiugration\n");
> +		ret = -EINVAL;
> +		goto err_msix;
> +	}
> +
> +	adapter->vdpa.dma_dev = dev;
> +	ret = vdpa_register_device(&adapter->vdpa);
> +	if (ret) {
> +		IFCVF_ERR(adapter->dev, "Failed to register ifcvf to vdpa bus");
> +		goto err_msix;
> +	}
> +
> +	return 0;
> +
> +err_msix:
> +	put_device(&adapter->vdpa.dev);
> +	return ret;
> +err_alloc:
> +	pci_free_irq_vectors(pdev);
> +err_vectors:
> +	pci_release_regions(pdev);
> +err_regions:
> +	pci_disable_device(pdev);
> +err_enable:
> +	return ret;
> +}

I personally don't like seeing goto unwinds with multiple returns, and
here I think it is actually a tiny bug.

All touches to the PCI device must stop before the driver core
remove() returns - so these pci function cannot be in the kref put
release function anyhow.

Suggest to use the devm versions of the above instead, and then you
can reorder things so the allocation is done first.

Jason
