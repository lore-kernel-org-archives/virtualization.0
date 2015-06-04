From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_pci: Clear stale cpumask when setting irq affinity
Date: Thu, 4 Jun 2015 14:55:28 +0200
Message-ID: <20150604145513-mutt-send-email-mst@redhat.com>
References: <1433407304-22981-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1433407304-22981-1-git-send-email-jiang.liu@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 04, 2015 at 04:41:44PM +0800, Jiang Liu wrote:
> The cpumask vp_dev->msix_affinity_masks[info->msix_vector] may contain
> staled information when vp_set_vq_affinity() gets called, so clear it
> before setting the new cpu bit mask.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

I have queued this up.
Thanks!

> ---
>  drivers/virtio/virtio_pci_common.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index e894eb278d83..eba1b7ac7294 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -423,6 +423,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
>  		if (cpu == -1)
>  			irq_set_affinity_hint(irq, NULL);
>  		else {
> +			cpumask_clear(mask);
>  			cpumask_set_cpu(cpu, mask);
>  			irq_set_affinity_hint(irq, mask);
>  		}
> -- 
> 1.7.10.4
