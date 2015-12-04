From: Venkatesh Srinivas via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] tools/virtio: fix byteswap logic
Date: Fri, 4 Dec 2015 11:37:53 -0800
Message-ID: <20151204193753.GA19430@google.com>
References: <1448872410-11553-1-git-send-email-mst@redhat.com>
Reply-To: Venkatesh Srinivas <venkateshs@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1448872410-11553-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: vsrinivas@ops101.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 30, 2015 at 10:33:34AM +0200, Michael S. Tsirkin wrote:
> commit cf561f0d2eb74574ad9985a2feab134267a9d298 ("virtio: introduce
> virtio_is_little_endian() helper") changed byteswap logic to
> skip feature bit checks for LE platforms, but didn't
> update tools/virtio, so vring_bench started failing.
> 
> Update the copy under tools/virtio/ (TODO: find a way to avoid this code
> duplication).
> 
> Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tools/virtio/linux/virtio_config.h | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
> index 806d683..57a6964 100644
> --- a/tools/virtio/linux/virtio_config.h
> +++ b/tools/virtio/linux/virtio_config.h
> @@ -40,33 +40,39 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
>  #define virtio_has_feature(dev, feature) \
>  	(__virtio_test_bit((dev), feature))
>  
> +static inline bool virtio_is_little_endian(struct virtio_device *vdev)
> +{
> +	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
> +		virtio_legacy_is_little_endian();
> +}
> +
> +/* Memory accessors */
>  static inline u16 virtio16_to_cpu(struct virtio_device *vdev, __virtio16 val)
>  {
> -	return __virtio16_to_cpu(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val);
> +	return __virtio16_to_cpu(virtio_is_little_endian(vdev), val);
>  }
>  
>  static inline __virtio16 cpu_to_virtio16(struct virtio_device *vdev, u16 val)
>  {
> -	return __cpu_to_virtio16(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val);
> +	return __cpu_to_virtio16(virtio_is_little_endian(vdev), val);
>  }
>  
>  static inline u32 virtio32_to_cpu(struct virtio_device *vdev, __virtio32 val)
>  {
> -	return __virtio32_to_cpu(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val);
> +	return __virtio32_to_cpu(virtio_is_little_endian(vdev), val);
>  }
>  
>  static inline __virtio32 cpu_to_virtio32(struct virtio_device *vdev, u32 val)
>  {
> -	return __cpu_to_virtio32(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val);
> +	return __cpu_to_virtio32(virtio_is_little_endian(vdev), val);
>  }
>  
>  static inline u64 virtio64_to_cpu(struct virtio_device *vdev, __virtio64 val)
>  {
> -	return __virtio64_to_cpu(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val);
> +	return __virtio64_to_cpu(virtio_is_little_endian(vdev), val);
>  }
>  
>  static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
>  {
> -	return __cpu_to_virtio64(virtio_has_feature(vdev, VIRTIO_F_VERSION_1), val);
> +	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
>  }

Tested patch with vring-bench. (I did something similar when reviving it).

Tested-by: Venkatesh Srinivas <venkateshs@google.com>

-- vs;
