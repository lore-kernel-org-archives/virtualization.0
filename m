From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio_mmio: fix devm cleanup
Date: Tue, 12 Dec 2017 14:09:52 +0100
Message-ID: <20171212140952.64d7908a.cohuck__35982.2595296011$1513084222$gmane$org@redhat.com>
References: <20171212125302.6846-1-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171212125302.6846-1-mark.rutland@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: virtualization@lists.linux-foundation.org, weiping zhang <zhangweiping@didichuxing.com>, linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 Dec 2017 12:53:02 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Recent rework of the virtio_mmio probe path balanced a devm_ioremap()
> with an iounmap() rather than its devm variant. This ends up corrupting
> the devm datastructures, and results in the following boot failure on
> arm64 under QEMU 2.9.0:
> 
> [    3.450397] ------------[ cut here ]------------
> [    3.453822] Trying to vfree() nonexistent vm area (00000000c05b4844)
> [    3.460534] WARNING: CPU: 1 PID: 1 at mm/vmalloc.c:1525 __vunmap+0x1b8/0x220
> [    3.475898] Kernel panic - not syncing: panic_on_warn set ...
> [    3.475898]
> [    3.493933] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc3 #1
> [    3.513109] Hardware name: linux,dummy-virt (DT)
> [    3.525382] Call trace:
> [    3.531683]  dump_backtrace+0x0/0x368
> [    3.543921]  show_stack+0x20/0x30
> [    3.547767]  dump_stack+0x108/0x164
> [    3.559584]  panic+0x25c/0x51c
> [    3.569184]  __warn+0x29c/0x31c
> [    3.576023]  report_bug+0x1d4/0x290
> [    3.586069]  bug_handler.part.2+0x40/0x100
> [    3.597820]  bug_handler+0x4c/0x88
> [    3.608400]  brk_handler+0x11c/0x218
> [    3.613430]  do_debug_exception+0xe8/0x318
> [    3.627370]  el1_dbg+0x18/0x78
> [    3.634037]  __vunmap+0x1b8/0x220
> [    3.648747]  vunmap+0x6c/0xc0
> [    3.653864]  __iounmap+0x44/0x58
> [    3.659771]  devm_ioremap_release+0x34/0x68
> [    3.672983]  release_nodes+0x404/0x880
> [    3.683543]  devres_release_all+0x6c/0xe8
> [    3.695692]  driver_probe_device+0x250/0x828
> [    3.706187]  __driver_attach+0x190/0x210
> [    3.717645]  bus_for_each_dev+0x14c/0x1f0
> [    3.728633]  driver_attach+0x48/0x78
> [    3.740249]  bus_add_driver+0x26c/0x5b8
> [    3.752248]  driver_register+0x16c/0x398
> [    3.757211]  __platform_driver_register+0xd8/0x128
> [    3.770860]  virtio_mmio_init+0x1c/0x24
> [    3.782671]  do_one_initcall+0xe0/0x398
> [    3.791890]  kernel_init_freeable+0x594/0x660
> [    3.798514]  kernel_init+0x18/0x190
> [    3.810220]  ret_from_fork+0x10/0x18
> 

Oops.

> To fix this, we can simply rip out the explicit cleanup that the devm
> infrastructure will do for us when our probe function returns an error
> code. We only need to ensure that we call put_device() if a call to
> register_virtio_device() fails.

OK, that was the subtility I obviously missed. Reading through the
code, this seems correct (although I find the infrastructure a bit
unintuitive).

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 7eb781b1bbb7136f ("virtio_mmio: add cleanup for virtio_mmio_probe")
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: weiping zhang <zhangweiping@didichuxing.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/virtio/virtio_mmio.c | 36 +++++++++---------------------------
>  1 file changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index a9192fe4f345..793b1085967f 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -522,10 +522,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  
>  	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
> -	if (!vm_dev) {
> -		rc = -ENOMEM;
> -		goto free_mem;
> -	}
> +	if (!vm_dev)
> +		return -ENOMEM;
>  
>  	vm_dev->vdev.dev.parent = &pdev->dev;
>  	vm_dev->vdev.dev.release = virtio_mmio_release_dev;
> @@ -535,17 +533,14 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	spin_lock_init(&vm_dev->lock);
>  
>  	vm_dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
> -	if (vm_dev->base == NULL) {
> -		rc = -EFAULT;
> -		goto free_vmdev;
> -	}
> +	if (vm_dev->base == NULL)
> +		return -EFAULT;
>  
>  	/* Check magic value */
>  	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
>  	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
>  		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> -		rc = -ENODEV;
> -		goto unmap;
> +		return -ENODEV;
>  	}
>  
>  	/* Check device version */
> @@ -553,8 +548,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	if (vm_dev->version < 1 || vm_dev->version > 2) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
> -		rc = -ENXIO;
> -		goto unmap;
> +		return -ENXIO;
>  	}
>  
>  	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
> @@ -563,8 +557,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
>  		 * with no function. End probing now with no error reported.
>  		 */
> -		rc = -ENODEV;
> -		goto unmap;
> +		return -ENODEV;
>  	}
>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
>  
> @@ -590,20 +583,9 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, vm_dev);
>  
>  	rc = register_virtio_device(&vm_dev->vdev);
> -	if (rc) {
> -		iounmap(vm_dev->base);
> -		devm_release_mem_region(&pdev->dev, mem->start,
> -					resource_size(mem));
> +	if (rc)
>  		put_device(&vm_dev->vdev.dev);
> -	}
> -	return rc;
> -unmap:
> -	iounmap(vm_dev->base);
> -free_mem:
> -	devm_release_mem_region(&pdev->dev, mem->start,
> -			resource_size(mem));
> -free_vmdev:
> -	devm_kfree(&pdev->dev, vm_dev);
> +
>  	return rc;
>  }
>  

Shouldn't the cleanup in _remove() then be removed as well?
