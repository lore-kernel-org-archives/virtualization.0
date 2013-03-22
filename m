From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 03/22] virtio_config: make transports implement accessors.
Date: Fri, 22 Mar 2013 10:13:38 +0100
Message-ID: <20130322101338.18abab01@gondolin>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-4-git-send-email-rusty@rustcorp.com.au>
	<20130321100905.7d4ab9fb@gondolin> <87boacff6v.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87boacff6v.fsf@rustcorp.com.au>
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

On Fri, 22 Mar 2013 11:01:20 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:


> Nice understatement.  I guess you know where I cut & pasted from...
> 
> Here is the updated version.

Looks sane to me.

> 
> Thanks,
> Rusty.
> 
> diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
> index 6711e65..9b8c527 100644
> --- a/drivers/s390/kvm/kvm_virtio.c
> +++ b/drivers/s390/kvm/kvm_virtio.c
> @@ -112,24 +112,79 @@ static void kvm_finalize_features(struct virtio_device *vdev)
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
>  	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
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
>  	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> 
> -	BUG_ON(offset + len > desc->config_len);
> -	memcpy(kvm_vq_configspace(desc) + offset, buf, len);
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u8 *)(kvm_vq_configspace(desc) + offset) = val;
> +}
> +
> +static u16 kvm_get16(struct virtio_device *vdev, unsigned int offset)
> +{
> +	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(u16) > desc->config_len);
> +	return *(u16 *)(kvm_vq_configspace(desc) + offset);
> +}
> +
> +static void kvm_set16(struct virtio_device *vdev, unsigned int offset, u16 val)
> +{
> +	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u16 *)(kvm_vq_configspace(desc) + offset) = val;
> +}
> +
> +static u32 kvm_get32(struct virtio_device *vdev, unsigned int offset)
> +{
> +	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(u32) > desc->config_len);
> +	return *(u32 *)(kvm_vq_configspace(desc) + offset);
> +}
> +
> +static void kvm_set32(struct virtio_device *vdev, unsigned int offset, u32 val)
> +{
> +	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u32 *)(kvm_vq_configspace(desc) + offset) = val;
> +}
> +
> +static u64 kvm_get64(struct virtio_device *vdev, unsigned int offset)
> +{
> +	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(u64) > desc->config_len);
> +	return *(u64 *)(kvm_vq_configspace(desc) + offset);
> +}
> +
> +static void kvm_set64(struct virtio_device *vdev, unsigned int offset, u64 val)
> +{
> +	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
> +
> +	/* Check they didn't ask for more than the length of the config! */
> +	BUG_ON(offset + sizeof(val) > desc->config_len);
> +	*(u64 *)(kvm_vq_configspace(desc) + offset) = val;
>  }
> 
>  /*
> @@ -278,8 +333,14 @@ static const char *kvm_bus_name(struct virtio_device *vdev)
>  static const struct virtio_config_ops kvm_vq_configspace_ops = {
>  	.get_features = kvm_get_features,
>  	.finalize_features = kvm_finalize_features,
> -	.get = kvm_get,
> -	.set = kvm_set,
> +	.get8 = kvm_get8,
> +	.set8 = kvm_set8,
> +	.get16 = kvm_get16,
> +	.set16 = kvm_set16,
> +	.get32 = kvm_get32,
> +	.set32 = kvm_set32,
> +	.get64 = kvm_get64,
> +	.set64 = kvm_set64,
>  	.get_status = kvm_get_status,
>  	.set_status = kvm_set_status,
>  	.reset = kvm_reset,
> 
