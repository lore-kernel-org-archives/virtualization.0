From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3] crypto: add virtio-crypto driver
Date: Mon, 28 Nov 2016 14:12:44 +0100
Message-ID: <20161128141244.4defcfa1.cornelia.huck__48437.8977249891$1480338791$gmane$org@de.ibm.com>
References: <1480334903-6672-1-git-send-email-arei.gonglei@huawei.com>
	<1480334903-6672-2-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1480334903-6672-2-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gonglei <arei.gonglei@huawei.com>
Cc: virtio-dev@lists.oasis-open.org, weidong.huang@huawei.com, claudio.fontana@huawei.com, mst@redhat.com, qemu-devel@nongnu.org, hanweidong@huawei.com, luonengjun@huawei.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, salvatore.benedetto@intel.com, xuquan8@huawei.com, linux-crypto@vger.kernel.org, stefanha@redhat.com, jianjay.zhou@huawei.com, longpeng2@huawei.com, arei.gonglei@hotmail.com, davem@davemloft.net, wu.wubin@huawei.com, herbert@gondor.apana.org.au
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 28 Nov 2016 20:08:23 +0800
Gonglei <arei.gonglei@huawei.com> wrote:

> +static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
> +{
> +	u32 status;
> +	int err;
> +
> +	virtio_cread(vcrypto->vdev,
> +	    struct virtio_crypto_config, status, &status);
> +
> +	/* Ignore unknown (future) status bits */
> +	status &= VIRTIO_CRYPTO_S_HW_READY;

I'm wondering what the driver really should do if it encounters unknown
status bits.

I'd expect that new status bits are guarded by a feature bit and that
the device should not set status bits if the respective feature bit has
not been negotiated. Therefore, unknown status bits would be a host
error and the driver should consider the device to be broken.

Thoughts?

> +
> +	if (vcrypto->status == status)
> +		return 0;
> +
> +	vcrypto->status = status;
> +
> +	if (vcrypto->status & VIRTIO_CRYPTO_S_HW_READY) {
> +		err = virtcrypto_dev_start(vcrypto);
> +		if (err) {
> +			dev_err(&vcrypto->vdev->dev,
> +				"Failed to start virtio crypto device.\n");
> +			virtcrypto_dev_stop(vcrypto);
> +			return -EPERM;
> +		}
> +		dev_info(&vcrypto->vdev->dev, "Accelerator is ready\n");
> +	} else {
> +		virtcrypto_dev_stop(vcrypto);
> +		dev_info(&vcrypto->vdev->dev, "Accelerator is not ready\n");
> +	}
> +
> +	return 0;
> +}
> +
