From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/1] crypto: add virtio-crypto driver
Date: Wed, 14 Dec 2016 16:38:33 +0100
Message-ID: <bcf62fa0-8fc9-daaf-ea7b-e09eb83b593a__49952.5833446116$1481729936$gmane$org@linux.vnet.ibm.com>
References: <1481716249-185392-1-git-send-email-arei.gonglei@huawei.com>
	<1481716249-185392-2-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481716249-185392-2-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gonglei <arei.gonglei@huawei.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
Cc: xuquan8@huawei.com, weidong.huang@huawei.com, herbert@gondor.apana.org.au, hanweidong@huawei.com, claudio.fontana@huawei.com, mst@redhat.com, luonengjun@huawei.com, wanzongshun@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, longpeng2@huawei.com, davem@davemloft.net, wu.wubin@huawei.com, arei.gonglei@hotmail.com
List-Id: virtualization@lists.linuxfoundation.org



On 12/14/2016 12:50 PM, Gonglei wrote:
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> new file mode 100644
> index 0000000..c0854a1
> --- /dev/null
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -0,0 +1,474 @@
[..]
> +
> +static void virtcrypto_dataq_callback(struct virtqueue *vq)
> +{
> +	struct virtio_crypto *vcrypto = vq->vdev->priv;
> +	struct virtio_crypto_request *vc_req;
> +	unsigned long flags;
> +	unsigned int len;
> +	struct ablkcipher_request *ablk_req;
> +	int error;
> +
> +	spin_lock_irqsave(&vcrypto->lock, flags);

Would it make sense to use a per virtqueue lock
like in virtio_blk for example instead of locking on the whole
device? OK, it seems you use only one dataqueue, so it
may not be that relevant.

> +	do {
> +		virtqueue_disable_cb(vq);
> +		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
> +			if (vc_req->type == VIRTIO_CRYPTO_SYM_OP_CIPHER) {
> +				switch (vc_req->status) {
> +				case VIRTIO_CRYPTO_OK:
> +					error = 0;
> +					break;
> +				case VIRTIO_CRYPTO_INVSESS:
> +				case VIRTIO_CRYPTO_ERR:
> +					error = -EINVAL;
> +					break;
> +				case VIRTIO_CRYPTO_BADMSG:
> +					error = -EBADMSG;
> +					break;
> +				default:
> +					error = -EIO;
> +					break;
> +				}
> +				ablk_req = vc_req->ablkcipher_req;
> +				virtcrypto_clear_request(vc_req);
> +
> +				spin_unlock_irqrestore(&vcrypto->lock, flags);
> +				/* Finish the encrypt or decrypt process */
> +				ablk_req->base.complete(&ablk_req->base, error);
> +				spin_lock_irqsave(&vcrypto->lock, flags);
> +			}
> +		}
> +	} while (!virtqueue_enable_cb(vq));
> +	spin_unlock_irqrestore(&vcrypto->lock, flags);
> +}
