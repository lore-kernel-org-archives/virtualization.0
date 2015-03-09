From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_rpmsg: set DRIVER_OK before using device
Date: Mon, 9 Mar 2015 09:41:01 +0100
Message-ID: <20150309084101.GC22567@redhat.com>
References: <1425754898-32707-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1425754898-32707-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 07, 2015 at 08:06:56PM +0100, Michael S. Tsirkin wrote:
> virtio spec requires that all drivers set DRIVER_OK
> before using devices. While rpmsg isn't yet
> included in the virtio 1 spec, previous spec versions
> also required this.
> 
> virtio rpmsg violates this rule: is calls kick
> before setting DRIVER_OK.
> 
> The fix isn't trivial since simply calling virtio_device_ready earlier
> would mean we might get an interrupt in parallel with adding buffers.
> 
> Instead, split kick out to prepare+notify calls.  prepare before
> virtio_device_ready - when we know we won't get interrupts. notify right
> afterwards.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Ohad, can you review and ack pls?

> Note: compile-tested only.
> 
>  drivers/rpmsg/virtio_rpmsg_bus.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 92f6af6..73354ee 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -951,6 +951,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	void *bufs_va;
>  	int err = 0, i;
>  	size_t total_buf_space;
> +	bool notify;
>  
>  	vrp = kzalloc(sizeof(*vrp), GFP_KERNEL);
>  	if (!vrp)
> @@ -1030,8 +1031,22 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  		}
>  	}
>  
> +	/*
> +	 * Prepare to kick but don't notify yet - we can't do this before
> +	 * device is ready.
> +	 */
> +	notify = virtqueue_kick_prepare(vrp->rvq);
> +
> +	/* From this point on, we can notify and get callbacks. */
> +	virtio_device_ready(vdev);
> +
>  	/* tell the remote processor it can start sending messages */
> -	virtqueue_kick(vrp->rvq);
> +	/*
> +	 * this might be concurrent with callbacks, but we are only
> +	 * doing notify, not a full kick here, so that's ok.
> +	 */
> +	if (notify)
> +		virtqueue_notify(vrp->rvq);
>  
>  	dev_info(&vdev->dev, "rpmsg host is online\n");
>  
> -- 
> MST
