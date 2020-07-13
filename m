From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/7] virtio_vdpa: init IRQ offloading function pointers to
 NULL.
Date: Mon, 13 Jul 2020 16:28:57 +0800
Message-ID: <276bf939-8e12-e28a-64f7-1767851e0db5@redhat.com>
References: <1594565366-3195-1-git-send-email-lingshan.zhu@intel.com>
 <1594565366-3195-5-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1594565366-3195-5-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/12 下午10:49, Zhu Lingshan wrote:
> This commit initialize IRQ offloading function pointers in
> virtio_vdpa_driver to NULL. Becasue irq offloading only focus
> on VMs for vhost_vdpa.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>   drivers/virtio/virtio_vdpa.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index c30eb55..1e8acb9 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -386,6 +386,8 @@ static void virtio_vdpa_remove(struct vdpa_device *vdpa)
>   	},
>   	.probe	= virtio_vdpa_probe,
>   	.remove = virtio_vdpa_remove,
> +	.setup_vq_irq = NULL,
> +	.unsetup_vq_irq = NULL,
>   };


Is this really needed consider the it's static?

Thanks


>   
>   module_vdpa_driver(virtio_vdpa_driver);
