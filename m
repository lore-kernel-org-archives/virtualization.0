From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] vhost: add support for legacy virtio
Date: Sun, 22 Feb 2015 10:48:29 +0100
Message-ID: <20150222094829.GB17529__7441.69046306542$1424598564$gmane$org@redhat.com>
References: <20150220100724.18608.74654.stgit@bahia.local>
	<20150220100746.18608.15083.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150220100746.18608.15083.stgit@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 20, 2015 at 11:14:47AM +0100, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  drivers/vhost/vhost.h |   20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> Michael,
> 
> The vhost_is_little_endian() helper adds unconditionnal overhead to fixed
> endian architectures: that is all architectures except arm and ppc64. This
> was addressed in QEMU with a TARGET_IS_BIENDIAN macro. Please give an
> advice about how to address this in the vhost code.
> 
> Thanks.

I suggest creating a config option for this, default to off.
When disabled the flag won't be set so userspace
can discover it's availability.


> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index ce2c68e..21e7d6a 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -176,34 +176,42 @@ static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
>  	return vq->acked_features & (1ULL << bit);
>  }
>  
> +static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
> +{
> +	if (vhost_has_feature(vq, VIRTIO_F_VERSION_1))
> +		return true;
> +	else
> +		return !vq->legacy_big_endian;
> +}
> +
>  /* Memory accessors */
>  static inline u16 vhost16_to_cpu(struct vhost_virtqueue *vq, __virtio16 val)
>  {
> -	return __virtio16_to_cpu(vhost_has_feature(vq, VIRTIO_F_VERSION_1), val);
> +	return __virtio16_to_cpu(vhost_is_little_endian(vq), val);
>  }
>  
>  static inline __virtio16 cpu_to_vhost16(struct vhost_virtqueue *vq, u16 val)
>  {
> -	return __cpu_to_virtio16(vhost_has_feature(vq, VIRTIO_F_VERSION_1), val);
> +	return __cpu_to_virtio16(vhost_is_little_endian(vq), val);
>  }
>  
>  static inline u32 vhost32_to_cpu(struct vhost_virtqueue *vq, __virtio32 val)
>  {
> -	return __virtio32_to_cpu(vhost_has_feature(vq, VIRTIO_F_VERSION_1), val);
> +	return __virtio32_to_cpu(vhost_is_little_endian(vq), val);
>  }
>  
>  static inline __virtio32 cpu_to_vhost32(struct vhost_virtqueue *vq, u32 val)
>  {
> -	return __cpu_to_virtio32(vhost_has_feature(vq, VIRTIO_F_VERSION_1), val);
> +	return __cpu_to_virtio32(vhost_is_little_endian(vq), val);
>  }
>  
>  static inline u64 vhost64_to_cpu(struct vhost_virtqueue *vq, __virtio64 val)
>  {
> -	return __virtio64_to_cpu(vhost_has_feature(vq, VIRTIO_F_VERSION_1), val);
> +	return __virtio64_to_cpu(vhost_is_little_endian(vq), val);
>  }
>  
>  static inline __virtio64 cpu_to_vhost64(struct vhost_virtqueue *vq, u64 val)
>  {
> -	return __cpu_to_virtio64(vhost_has_feature(vq, VIRTIO_F_VERSION_1), val);
> +	return __cpu_to_virtio64(vhost_is_little_endian(vq), val);
>  }
>  #endif
