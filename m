From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/2] S390: Add virtio hotplug add support
Date: Tue, 24 Aug 2010 09:13:24 +0200
Message-ID: <4C737114.60606__43321.9421226115$1282634042$gmane$org@de.ibm.com>
References: <1282599077-29857-1-git-send-email-agraf@suse.de>
	<1282599077-29857-2-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282599077-29857-2-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am 23.08.2010 23:31, schrieb Alexander Graf:
> The one big missing feature in s390-virtio was hotplugging. This is no more.
> This patch implements hotplug add support, so you can on the fly add new devices
> in the guest.

Nice :-)


> Keep in mind that this needs a patch for qemu to actually leverage the
> functionality.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
With the minor nits below fixed:
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

>  #define VIRTIO_PARAM_MASK		0xff
>  #define VIRTIO_PARAM_VRING_INTERRUPT	0x0
>  #define VIRTIO_PARAM_CONFIG_CHANGED	0x1
> +#define VIRTIO_PARAM_DEV_ADD		0x2

See the other patch. This becomes an interface and should go into a header file.
> 
>  /*
>   * The pointer to our (page) of device descriptions.
>   */
>  static void *kvm_devices;
> +struct work_struct hotplug_work;
> 
>  struct kvm_device {
>  	struct virtio_device vdev;
> @@ -331,6 +333,47 @@ static void scan_devices(void)
>  }
> 
>  /*
> + * match for a kvm device with a specific desc pointer
> + */
> +static int match_desc(struct device *dev, void *data)
> +{
> +	if ((ulong)to_kvmdev(dev_to_virtio(dev))->desc == (ulong)data)

ulong doesnt look like kernel coding style.
