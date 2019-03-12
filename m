From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Date: Tue, 12 Mar 2019 18:33:51 +0100
Message-ID: <20190312183351.74764f4f.cohuck@redhat.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
Dongli Zhang <dongli.zhang@oracle.com> wrote:

> I observed that there is one msix vector for config and one shared vector
> for all queues in below qemu cmdline, when the num-queues for virtio-blk
> is more than the number of possible cpus:
> 
> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3
> ... ...
>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
> ... ...
> 
> 
> However, when num-queues is the same as number of possible cpus:
> 
> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
> 
> # cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3
> ... ... 
>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
> ... ...
> 
> In above case, there is one msix vector per queue.

Please note that this is pci-specific...

> 
> 
> This is because the max number of queues is not limited by the number of
> possible cpus.
> 
> By default, nvme (regardless about write_queues and poll_queues) and
> xen-blkfront limit the number of queues with num_possible_cpus().

...and these are probably pci-specific as well.

> 
> 
> Is this by design on purpose, or can we fix with below?
> 
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4bc083b..df95ce3 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>  	if (err)
>  		num_vqs = 1;
>  
> +	num_vqs = min(num_possible_cpus(), num_vqs);
> +
>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>  	if (!vblk->vqs)
>  		return -ENOMEM;

virtio-blk, however, is not pci-specific.

If we are using the ccw transport on s390, a completely different
interrupt mechanism is in use ('floating' interrupts, which are not
per-cpu). A check like that should therefore not go into the generic
driver.
