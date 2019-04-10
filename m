From: Yuval Shaia <yuval.shaia@oracle.com>
Subject: Re: [PATCH v5 2/5] virtio-pmem: Add virtio pmem driver
Date: Wed, 10 Apr 2019 17:41:47 +0300
Message-ID: <20190410144147.GA7947__10445.2841844008$1555718043$gmane$org@lap1>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-3-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190410040826.24371-3-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com, linux-nvdimm@lists.01.org, vishal.l.verma@intel.com, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, stefanha@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong.eric@gmail.com, darrick.wong@oracle.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> +
> +static int virtio_pmem_probe(struct virtio_device *vdev)
> +{
> +	int err = 0;
> +	struct resource res;
> +	struct virtio_pmem *vpmem;
> +	struct nvdimm_bus *nvdimm_bus;
> +	struct nd_region_desc ndr_desc = {};
> +	int nid = dev_to_node(&vdev->dev);
> +	struct nd_region *nd_region;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	vdev->priv = vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem),
> +					GFP_KERNEL);
> +	if (!vpmem) {
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	vpmem->vdev = vdev;
> +	err = init_vq(vpmem);
> +	if (err)
> +		goto out_err;
> +
> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +			start, &vpmem->start);
> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +			size, &vpmem->size);
> +
> +	res.start = vpmem->start;
> +	res.end   = vpmem->start + vpmem->size-1;
> +	vpmem->nd_desc.provider_name = "virtio-pmem";
> +	vpmem->nd_desc.module = THIS_MODULE;
> +
> +	vpmem->nvdimm_bus = nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> +						&vpmem->nd_desc);
> +	if (!nvdimm_bus)
> +		goto out_vq;
> +
> +	dev_set_drvdata(&vdev->dev, nvdimm_bus);
> +
> +	ndr_desc.res = &res;
> +	ndr_desc.numa_node = nid;
> +	ndr_desc.flush = virtio_pmem_flush;
> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> +	nd_region = nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc);
> +	nd_region->provider_data =  dev_to_virtio

Pleas delete the extra space.

> +					(nd_region->dev.parent->parent);
> +
> +	if (!nd_region)
> +		goto out_nd;
> +
> +	return 0;
> +out_nd:
> +	err = -ENXIO;
> +	nvdimm_bus_unregister(nvdimm_bus);
> +out_vq:
> +	vdev->config->del_vqs(vdev);
> +out_err:
> +	dev_err(&vdev->dev, "failed to register virtio pmem memory\n");
> +	return err;
> +}
