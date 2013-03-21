From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 03/22] virtio_config: make transports implement accessors.
Date: Thu, 21 Mar 2013 10:09:05 +0100
Message-ID: <20130321100905.7d4ab9fb@gondolin>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-4-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-4-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 21 Mar 2013 18:59:24 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> All transports just pass through at the moment.
> 
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Brian Swetland <swetland@google.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/lguest/lguest_device.c |   79 ++++++++++++++++++++++++++++++++++------
>  drivers/net/caif/caif_virtio.c |    2 +-
>  drivers/s390/kvm/kvm_virtio.c  |   78 +++++++++++++++++++++++++++++++++------
>  drivers/s390/kvm/virtio_ccw.c  |   39 +++++++++++++++++++-
>  drivers/virtio/virtio_mmio.c   |   35 +++++++++++++++++-
>  drivers/virtio/virtio_pci.c    |   39 +++++++++++++++++---
>  include/linux/virtio_config.h  |   70 +++++++++++++++++++++--------------
>  7 files changed, 283 insertions(+), 59 deletions(-)
> 

> diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
> index 6711e65..dcf35b1 100644
> --- a/drivers/s390/kvm/kvm_virtio.c
> +++ b/drivers/s390/kvm/kvm_virtio.c
> @@ -112,26 +112,82 @@ static void kvm_finalize_features(struct virtio_device *vdev)
>  }
> 
>  /*
> - * Reading and writing elements in config space
> + * Reading and writing elements in config space.  Host and guest are always
> + * big-endian, so no conversion necessary.
>   */
> -static void kvm_get(struct virtio_device *vdev, unsigned int offset,
> -		   void *buf, unsigned len)
> +static u8 kvm_get8(struct virtio_device *vdev, unsigned int offset)
>  {
> -	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
               ^^^^^^^^^^^^^^^^^^
 
This looks weird?

> 
> -	BUG_ON(offset + len > desc->config_len);
> -	memcpy(buf, kvm_vq_configspace(desc) + offset, len);
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(u8) > desc->config_len);
> +	return *(u8 *)(kvm_vq_configspace(desc) + offset);
>  }
> 
> -static void kvm_set(struct virtio_device *vdev, unsigned int offset,
> -		   const void *buf, unsigned len)
> +static void kvm_set8(struct virtio_device *vdev, unsigned int offset, u8 val)
>  {
> -	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u8 *)(kvm_vq_configspace(desc) + offset) = val;
> +}
> +
> +static u16 kvm_get16(struct virtio_device *vdev, unsigned int offset)
> +{
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(u16) > desc->config_len);
> +	return *(u16 *)(kvm_vq_configspace(desc) + offset);
> +}
> +
> +static void kvm_set16(struct virtio_device *vdev, unsigned int offset, u16 val)
> +{
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u16 *)(kvm_vq_configspace(desc) + offset) = val;
> +}
> +
> +static u32 kvm_get32(struct virtio_device *vdev, unsigned int offset)
> +{
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
> 
> -	BUG_ON(offset + len > desc->config_len);
> -	memcpy(kvm_vq_configspace(desc) + offset, buf, len);
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(u32) > desc->config_len);
> +	return *(u32 *)(kvm_vq_configspace(desc) + offset);
>  }
> 
> +static void kvm_set32(struct virtio_device *vdev, unsigned int offset, u32 val)
> +{
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u32 *)(kvm_vq_configspace(desc) + offset) = val;
> +}
> +
> +static u64 kvm_get64(struct virtio_device *vdev, unsigned int offset)
> +{
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(u64) > desc->config_len);
> +	return *(u64 *)(kvm_vq_configspace(desc) + offset);
> +}
> +
> +static void kvm_set64(struct virtio_device *vdev, unsigned int offset, u64 val)
> +{
> +	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u64 *)(kvm_vq_configspace(desc) + offset) = val;
> +}
> +
> +

The new functions don't seem to be hooked up anywhere?

>  /*
>   * The operations to get and set the status word just access
>   * the status field of the device descriptor. set_status will also
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index 2029b6c..3652473 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -472,6 +472,7 @@ out_free:
>  	kfree(ccw);
>  }
> 
> +/* We don't need to do endian conversion, as it's always big endian like us */
>  static void virtio_ccw_get_config(struct virtio_device *vdev,
>  				  unsigned int offset, void *buf, unsigned len)
>  {
> @@ -505,6 +506,21 @@ out_free:
>  	kfree(ccw);
>  }
> 
> +
> +#define VIRTIO_CCW_GET_CONFIGx(bits)					\
> +static u##bits virtio_ccw_get_config##bits(struct virtio_device *vdev,	\
> +					   unsigned int offset)		\
> +{									\
> +	u##bits v;							\
> +	virtio_ccw_get_config(vdev, offset, &v, sizeof(v));		\
> +	return v;							\
> +}
> +
> +VIRTIO_CCW_GET_CONFIGx(8)
> +VIRTIO_CCW_GET_CONFIGx(16)
> +VIRTIO_CCW_GET_CONFIGx(32)
> +VIRTIO_CCW_GET_CONFIGx(64)
> +
>  static void virtio_ccw_set_config(struct virtio_device *vdev,
>  				  unsigned int offset, const void *buf,
>  				  unsigned len)
> @@ -535,6 +551,19 @@ out_free:
>  	kfree(ccw);
>  }
> 
> +#define VIRTIO_CCW_SET_CONFIGx(bits)					\
> +static void virtio_ccw_set_config##bits(struct virtio_device *vdev,	\
> +					unsigned int offset,		\
> +					u##bits v)			\
> +{									\
> +	virtio_ccw_set_config(vdev, offset, &v, sizeof(v));		\
> +}
> +
> +VIRTIO_CCW_SET_CONFIGx(8)
> +VIRTIO_CCW_SET_CONFIGx(16)
> +VIRTIO_CCW_SET_CONFIGx(32)
> +VIRTIO_CCW_SET_CONFIGx(64)
> +
>  static u8 virtio_ccw_get_status(struct virtio_device *vdev)
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> @@ -564,8 +593,14 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
>  static struct virtio_config_ops virtio_ccw_config_ops = {
>  	.get_features = virtio_ccw_get_features,
>  	.finalize_features = virtio_ccw_finalize_features,
> -	.get = virtio_ccw_get_config,
> -	.set = virtio_ccw_set_config,
> +	.get8 = virtio_ccw_get_config8,
> +	.set8 = virtio_ccw_set_config8,
> +	.get16 = virtio_ccw_get_config16,
> +	.set16 = virtio_ccw_set_config16,
> +	.get32 = virtio_ccw_get_config32,
> +	.set32 = virtio_ccw_set_config32,
> +	.get64 = virtio_ccw_get_config64,
> +	.set64 = virtio_ccw_set_config64,
>  	.get_status = virtio_ccw_get_status,
>  	.set_status = virtio_ccw_set_status,
>  	.reset = virtio_ccw_reset,

virtio-ccw looks sane at first glance.
