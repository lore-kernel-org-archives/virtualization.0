From: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Date: Mon, 20 Jul 2020 08:19:40 +0300
Message-ID: <20200720051940.GA116013@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-11-eli@mellanox.com>
 <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
 <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
 <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
 <20200718194902.GA52765@mtl-vdi-166.wap.labs.mlnx>
 <ed10cb66-174f-ec5c-8043-4e18de65fb99@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ed10cb66-174f-ec5c-8043-4e18de65fb99@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, shahafs@mellanox.com, saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>, Eugenio Perez Martin <eperezma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 20, 2020 at 12:12:30PM +0800, Jason Wang wrote:
> 
> On 2020/7/19 上午3:49, Eli Cohen wrote:
> >On Fri, Jul 17, 2020 at 04:57:29PM +0800, Jason Wang wrote:
> >>>Looks like checking intialized is enough. Will fix this.
> >>>>>+
> >>>>>+static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
> >>>>>+{
> >>>>>+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >>>>>+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >>>>>+	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> >>>>>+	int err;
> >>>>>+
> >>>>>+	if (!mvq->ready && ready && mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY) {
> >>>>>+		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> >>>>>+		if (err) {
> >>>>>+			mlx5_vdpa_warn(mvdev, "failed to modify virtqueue(%d)\n", err);
> >>>>>+			return;
> >>>>>+		}
> >>>>>+	}
> >>>>I wonder what's the reason of changing vq state on the hardware
> >>>>here. I think we can defer it to set_status().
> >>>>
> >>>I can defer this to set status.
> >>>
> >>>I just wonder if it is possible that the core vdpa driver may call this
> >>>function with ready equals false and after some time call it with ready
> >>>equals true.
> >>
> >>Good point, so I think we can keep the logic. But looks like the
> >>code can not work if ready equals false since it only tries to
> >>modify vq state to RDY.
> >>
> >The point is that you cannot modify the virtqueue to "not ready".
> 
> 
> Is this a hardware limitation of software one?

Sorry, but I was not accruate in my statement above. You can suspend the
hardware VQ but you cannot mover out of suspend back to ready.
> 
> I'm asking since we need support live migration. But a questions is
> how to stop the device but not reset, since we need get e.g
> last_avail_idx from the device.
> 
> It could be either:
> 
> 1) set_status(0)
> 2) get_vq_state()
> 
> or
> 
> 1) set_queue_ready(0)
> 2) get_vq_state()
> 

This can work.

> Set_status(0) means reset the virtio device but last_avail_idx is
> something out of virtio spec. I guess using set_queue_ready() is
> better.
> 
> What's you opinion?

So if the intention to set ready(0) as a preliminary state for live
migration then we're ok. We just need to keep in mind that there's no
way of suspend but destroy the hardware vq.

> 
> Thanks
> 
> 
> >  The
> >only option is to destroy it and create a new one. This means that if I
> >get ready equals false after the virtqueue has been created I need to
> >teardown the driver and set it up again.
> >
> >Given that, I think your original suggestion to defer this logic is
> >reasonable.
> >
> 
