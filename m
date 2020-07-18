From: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Date: Sat, 18 Jul 2020 22:49:02 +0300
Message-ID: <20200718194902.GA52765@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-11-eli@mellanox.com>
 <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
 <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
 <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, shahafs@mellanox.com, saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 17, 2020 at 04:57:29PM +0800, Jason Wang wrote:
> >Looks like checking intialized is enough. Will fix this.
> >>>+
> >>>+static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
> >>>+{
> >>>+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >>>+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >>>+	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> >>>+	int err;
> >>>+
> >>>+	if (!mvq->ready && ready && mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY) {
> >>>+		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> >>>+		if (err) {
> >>>+			mlx5_vdpa_warn(mvdev, "failed to modify virtqueue(%d)\n", err);
> >>>+			return;
> >>>+		}
> >>>+	}
> >>
> >>I wonder what's the reason of changing vq state on the hardware
> >>here. I think we can defer it to set_status().
> >>
> >I can defer this to set status.
> >
> >I just wonder if it is possible that the core vdpa driver may call this
> >function with ready equals false and after some time call it with ready
> >equals true.
> 
> 
> Good point, so I think we can keep the logic. But looks like the
> code can not work if ready equals false since it only tries to
> modify vq state to RDY.
>

The point is that you cannot modify the virtqueue to "not ready". The
only option is to destroy it and create a new one. This means that if I
get ready equals false after the virtqueue has been created I need to
teardown the driver and set it up again.

Given that, I think your original suggestion to defer this logic is
reasonable.
