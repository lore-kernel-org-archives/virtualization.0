From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V4 4/5] virtio: introduce a vDPA based transport
Date: Thu, 20 Feb 2020 15:19:18 +0000
Message-ID: <20200220151914.GW23930@mellanox.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200220061141.29390-5-jasowang@redhat.com>
Content-Language: en-US
Content-ID: <580C49A7720E4D419B954616884CC2C0@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Wang <jasowang@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "mhabets@solarflare.com" <mhabets@solarflare.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "lulu@redhat.com" <lulu@redhat.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "hch@infradead.org" <hch@infradead.org>, "eperezma@redhat.com" <eperezma@redhat.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, Shahaf Shuler <shahafs@mellanox.com>, Parav Pandit <parav@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 20, 2020 at 02:11:40PM +0800, Jason Wang wrote:
> +static int virtio_vdpa_probe(struct vdpa_device *vdpa)
> +{
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	struct virtio_vdpa_device *vd_dev;
> +	int ret = -EINVAL;
> +
> +	vd_dev = kzalloc(sizeof(*vd_dev), GFP_KERNEL);
> +	if (!vd_dev)
> +		return -ENOMEM;
> +
> +	vd_dev->vdev.dev.parent = vdpa_get_dma_dev(vdpa);
> +	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
> +	vd_dev->vdev.config = &virtio_vdpa_config_ops;
> +	vd_dev->vdpa = vdpa;
> +	INIT_LIST_HEAD(&vd_dev->virtqueues);
> +	spin_lock_init(&vd_dev->lock);
> +
> +	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
> +	if (vd_dev->vdev.id.device == 0)
> +		goto err;
> +
> +	vd_dev->vdev.id.vendor = ops->get_vendor_id(vdpa);
> +	ret = register_virtio_device(&vd_dev->vdev);
> +	if (ret)
> +		goto err;

This error unwind is wrong. register_virtio_device() does
device_initialize() as it's first action. After that point error
unwind must be done with put_device() - particularly calling
kfree(vd_dev) after doing dev_set_name() leaks memory.

Looks like about half of the register_virtio_device() users did this
right, the others not. Perhaps you should fix them too...

Jason
