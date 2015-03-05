From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_balloon: set DRIVER_OK before using device
Date: Thu, 05 Mar 2015 13:24:47 +1030
Message-ID: <877fuwjgqw.fsf@rustcorp.com.au>
References: <1425474779-29412-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1425474779-29412-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> virtio spec requires that all drivers set DRIVER_OK
> before using devices. While balloon isn't yet
> included in the virtio 1 spec, previous spec versions
> also required this.
>
> virtio balloon might violate this rule: probe calls
> kthread_run before setting DRIVER_OK, which might run
> immediately and cause balloon to inflate/deflate.
>
> To fix, call virtio_device_ready before running the kthread.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Replied, CC'd stable.

Thanks,
Rusty.


> ---
>  drivers/virtio/virtio_balloon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5a6ad6d..6a356e3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -508,6 +508,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	if (err < 0)
>  		goto out_oom_notify;
>  
> +	virtio_device_ready(vdev);
> +
>  	vb->thread = kthread_run(balloon, vb, "vballoon");
>  	if (IS_ERR(vb->thread)) {
>  		err = PTR_ERR(vb->thread);
> -- 
> MST
