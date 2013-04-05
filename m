From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 6/7] virtio: add support for 64 bit features.
Date: Fri, 5 Apr 2013 09:33:45 +0300
Message-ID: <CAK=Wgbb0BX4OhqodUefDnJ78QnHB71zoz4RWD4h+T+-1JqdOqg@mail.gmail.com>
References: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
	<1365133025-5397-7-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365133025-5397-7-git-send-email-rusty@rustcorp.com.au>
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
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 5, 2013 at 6:37 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index fb8faee..aefbaae 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -196,7 +196,7 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
>  }
>
>  /* provide the vdev features as retrieved from the firmware */
> -static u32 rproc_virtio_get_features(struct virtio_device *vdev)
> +static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>  {
>         struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
>
> @@ -210,6 +210,9 @@ static void rproc_virtio_finalize_features(struct virtio_device *vdev)
>         /* Give virtio_ring a chance to accept features */
>         vring_transport_features(vdev);
>
> +       /* Make sure we don't have any features > 32 bits! */
> +       BUG_ON((u32)vdev->features != vdev->features);
> +
>         /*
>          * Remember the finalized features of our vdev, and provide it
>          * to the remote processor once it is powered on.
> @@ -220,6 +223,7 @@ static void rproc_virtio_finalize_features(struct virtio_device *vdev)
>          * extension of the virtio resource entries.
>          */
>         rvdev->gfeatures = vdev->features;
> +
>  }

Seems like an extra newline has sneaked in - we should probably leave it out.

Otherwise

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks!
