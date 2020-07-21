From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Date: Tue, 21 Jul 2020 13:51:54 +0800
Message-ID: <73209efd-f513-fec2-e4f7-51e71f08c9fe@redhat.com>
References: <20200720071416.32112-1-eli@mellanox.com>
 <20200720071416.32112-11-eli@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720071416.32112-11-eli@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eli Cohen <eli@mellanox.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/20 下午3:14, Eli Cohen wrote:
> Add a front end VDPA driver that registers in the VDPA bus and provides
> networking to a guest. The VDPA driver creates the necessary resources
> on the VF it is driving such that data path will be offloaded.
>
> Notifications are being communicated through the driver.
>
> Currently, only VFs are supported. In subsequent patches we will have
> devlink support to control which VF is used for VDPA and which function
> is used for regular networking.
>
> Reviewed-by: Parav Pandit<parav@mellanox.com>
> Signed-off-by: Eli Cohen<eli@mellanox.com>
> ---
> Changes from V0:
> 1. Fix include path usage
> 2. Fix use after free in qp_create()
> 3. Consistently use mvq->initialized to check if a vq was initialized.
> 4. Remove unused local variable.
> 5. Defer modifyig vq to ready to driver ok
> 6. suspend hardware vq in set_vq_ready(0)
> 7. Remove reservation for control VQ since it multi queue is not supported in this version
> 8. Avoid call put_device() since this is not a pci device driver.


Looks good to me.

Acked-by: Jason Wang <jasowang@redhat.com>
