From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 5/8] vhost: introduce vhost_is_little_endian() helper
Date: Thu, 23 Apr 2015 21:05:02 +0200
Message-ID: <20150423210502.1d97ca77__423.834837465797$1429896786$gmane$org@thh440s>
References: <20150423152608.11795.4373.stgit@bahia.local>
	<20150423152700.11795.9146.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150423152700.11795.9146.stgit@bahia.local>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 23 Apr 2015 17:27:05 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  drivers/vhost/vhost.h |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 8c1c792..6a49960 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -173,34 +173,39 @@ static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
>  	return vq->acked_features & (1ULL << bit);
>  }
>  
> +static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
> +{
> +	return vhost_has_feature(vq, VIRTIO_F_VERSION_1);
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
