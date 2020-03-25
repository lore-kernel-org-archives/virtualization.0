From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V8 5/9] vDPA: introduce vDPA bus
Date: Wed, 25 Mar 2020 09:29:49 -0300
Message-ID: <20200325122949.GW13183@mellanox.com>
References: <20200325082711.1107-1-jasowang@redhat.com>
 <20200325082711.1107-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200325082711.1107-6-jasowang@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 25, 2020 at 04:27:07PM +0800, Jason Wang wrote:
> +struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> +					const struct vdpa_config_ops *config,
> +					size_t size);
> +
> +#define vdpa_alloc_device(dev_struct, member, parent, config)   \
> +			  container_of(__vdpa_alloc_device( \
> +				       parent, config, \
> +				       sizeof(struct dev_struct) + \
> +				       BUILD_BUG_ON_ZERO(offsetof( \
> +				       struct dev_struct, member))), \
> +				       struct dev_struct, member)

This all looks robust now, one minor remark is to not do 'struct
dev_struct' here so the caller has to do

   vdpa_alloc_device(struct foo, vpda, ...)

Which suggests to the reader something unusual is happening

Jason
