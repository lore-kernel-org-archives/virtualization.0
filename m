From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio_mmio: add cleanup for virtio_mmio_probe
Date: Mon, 4 Dec 2017 11:24:55 +0100
Message-ID: <20171204112455.33dad9c2.cohuck@redhat.com>
References: <20171201175140.GA19140@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171201175140.GA19140@localhost.didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiping zhang <zwp10758@gmail.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2 Dec 2017 01:51:40 +0800
weiping zhang <zwp10758@gmail.com> wrote:

> cleanup all resource allocated by virtio_mmio_probe.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> ---
>  drivers/virtio/virtio_mmio.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 74dc717..3fd0e66 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -513,8 +513,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  
>  	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
> -	if (!vm_dev)
> -		return  -ENOMEM;
> +	if (!vm_dev) {
> +		rc =  -ENOMEM;

Touching this would be a good time to remove the extra space in front
of the -ENOMEM :)

> +		goto free_mem;
> +	}
>  
>  	vm_dev->vdev.dev.parent = &pdev->dev;
>  	vm_dev->vdev.dev.release = virtio_mmio_release_dev_empty;

(...)

> @@ -573,7 +580,18 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, vm_dev);
>  
> -	return register_virtio_device(&vm_dev->vdev);
> +	rc = register_virtio_device(&vm_dev->vdev);
> +	if (rc)
> +		goto unmap;
> +	return 0;
> +unmap:
> +	iounmap(vm_dev->base);
> +free_mem:
> +	devm_release_mem_region(&pdev->dev, mem->start,
> +			resource_size(mem));
> +free_vmdev:
> +	devm_kfree(&pdev->dev, vm_dev);

I think this is problematic as vm_dev embeds a struct device (via
embedding a struct virtio_device). I think the right way to do this is
- call this only if register_virtio_device() has not been called
- put the devm_kfree() into the ->release callback for the
  virtio_device (IOW, replace virtio_mmio_release_dev_empty() with a
  function that calls this)
- do a put_device() if register_virtio_device() failed

I might be missing some interaction between the usual driver model
handling and devm resources, though.

> +	return rc;
>  }
>  
>  static int virtio_mmio_remove(struct platform_device *pdev)
