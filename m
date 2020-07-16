From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost next 06/10] vdpa: Add means to communicate vq status
 on get_vq_state
Date: Thu, 16 Jul 2020 16:11:00 +0800
Message-ID: <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-7-eli@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716072327.5359-7-eli@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eli Cohen <eli@mellanox.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/16 下午3:23, Eli Cohen wrote:
> Currently, get_vq_state() is used only to pass the available index value
> of a vq. Extend the struct to return status on the VQ to the caller.
> For now, define VQ_STATE_NOT_READY. In the future it will be extended to
> include other infomration.
>
> Modify current vdpa driver to update this field.
>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Eli Cohen <eli@mellanox.com>


What's the difference between this and get_vq_ready()?

Thanks


> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c  | 1 +
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
>   include/linux/vdpa.h             | 9 +++++++++
>   3 files changed, 11 insertions(+)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 69032ee97824..77e3b3d91167 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -240,6 +240,7 @@ static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
>   {
>   	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>   
> +	state->state = vf->vring[qid].ready ? 0 : BIT(VQ_STATE_NOT_READY);
>   	state->avail_index = ifcvf_get_vq_state(vf, qid);
>   }
>   
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 599519039f8d..06d974b4bd7b 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -434,6 +434,7 @@ static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>   	struct vringh *vrh = &vq->vring;
>   
> +	state->state = vq->ready ? 0 : BIT(VQ_STATE_NOT_READY);
>   	state->avail_index = vrh->last_avail_idx;
>   }
>   
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7b088bebffe8..bcefa30a3b2f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -27,12 +27,21 @@ struct vdpa_notification_area {
>   	resource_size_t size;
>   };
>   
> +/**
> + * Bitmask describing the status of the vq
> + */
> +enum {
> +	VQ_STATE_NOT_READY = 0,
> +};
> +
>   /**
>    * vDPA vq_state definition
>    * @avail_index: available index
> + * @state: returned status from get_vq_state
>    */
>   struct vdpa_vq_state {
>   	u16	avail_index;
> +	u32	state;
>   };
>   
>   /**
