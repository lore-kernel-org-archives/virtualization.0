From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] virtio-balloon: initialize all vq callbacks
Date: Wed, 18 Dec 2019 10:28:23 +0100
Message-ID: <20191218102823.790d88fa.cohuck@redhat.com>
References: <20191217190610.248061-1-dverkamp@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217190610.248061-1-dverkamp@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 17 Dec 2019 11:06:09 -0800
Daniel Verkamp <dverkamp@chromium.org> wrote:

> Ensure that elements of the array that correspond to unavailable

s/array/callbacks array/ ?

> features are set to NULL; previously, they would be left uninitialized.
> 
> Since the corresponding names array elements were explicitly set to
> NULL, the uninitialized callback pointers would not actually be
> dereferenced; however, the uninitialized callbacks elements would still
> be read in vp_find_vqs_msix() and used to calculate the number of MSI-X
> vectors required.
> 
> Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> ---
>  drivers/virtio/virtio_balloon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 93f995f6cf36..8e400ece9273 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -475,7 +475,9 @@ static int init_vqs(struct virtio_balloon *vb)
>  	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
>  	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
>  	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
> +	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
>  	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> +	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>  	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {

Alternatively, it might make sense to zero the whole array and drop the
explicit NULL assignments, which would also be a bit more future
proof... but this one fixes things as well, of course.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
