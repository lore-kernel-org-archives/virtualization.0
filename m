From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 11/11] virtio: balloon: Add freeze, restore handlers
	to support S4
Date: Thu, 17 Nov 2011 14:25:08 +0200
Message-ID: <20111117122508.GB19682@redhat.com>
References: <cover.1321530505.git.amit.shah@redhat.com>
	<1147d4f726e51f2e03a84f3732d60ccd0d8e480c.1321530505.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1147d4f726e51f2e03a84f3732d60ccd0d8e480c.1321530505.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: linux-kernel@vger.kernel.org, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 17, 2011 at 05:27:42PM +0530, Amit Shah wrote:
> Delete the vqs on the freeze callback to prepare for hibernation.
> Re-create the vqs in the restore callback to resume normal function.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1ff3cf4..90149d1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -363,6 +363,22 @@ static void __devexit virtballoon_remove(struct virtio_device *vdev)
>  	kfree(vb);
>  }
>  
> +#ifdef CONFIG_PM
> +static int virtballoon_freeze(struct virtio_device *vdev)
> +{
> +	/* Now we reset the device so we can clean up the queues. */
> +	vdev->config->reset(vdev);
> +

This is a weird thing to do. We normally delete vqs then reset.
For example, I don't know whether we guarantee what happens
to MSI-X vectors assigned meanwhile if you reset.
IIRC qemu doesn't use MSI-X for the balloon, but nothing
prevents it.

> +	vdev->config->del_vqs(vdev);

What prevents requests being submitted at this point?
I see all kind of handling of freezing in the balloon thread ...
maybe that gives us some guarantees, but if yes
it makes sense to add a comment to point this out.


> +	return 0;
> +}
> +
> +static int virtballoon_restore(struct virtio_device *vdev)
> +{
> +	return init_vqs(vdev->priv);
> +}
> +#endif
> +
>  static unsigned int features[] = {
>  	VIRTIO_BALLOON_F_MUST_TELL_HOST,
>  	VIRTIO_BALLOON_F_STATS_VQ,
> @@ -377,6 +393,10 @@ static struct virtio_driver virtio_balloon_driver = {
>  	.probe =	virtballoon_probe,
>  	.remove =	__devexit_p(virtballoon_remove),
>  	.config_changed = virtballoon_changed,
> +#ifdef CONFIG_PM
> +	.freeze	=	virtballoon_freeze,
> +	.restore =	virtballoon_restore,
> +#endif
>  };
>  
>  static int __init init(void)
> -- 
> 1.7.7.1
